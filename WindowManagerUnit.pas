unit WindowManagerUnit;

interface

uses
  Winapi.Windows,
  System.Classes,
  Winapi.PsAPI,
  System.SysUtils,
  System.Generics.Collections,
  SystemUtils;

type
  TProcessWindowInfo = record
    ProcessId: DWORD;
    WindowHandle: HWND;
    IsForeground: Boolean;
    ProcessName: string;
  end;

  TWindowManager = class
  private
    FWindowList: TDictionary<string, TList<TProcessWindowInfo>>;
    FHiddenProcesses: TDictionary<string, Boolean>;
    procedure CollectProcessWindows(const ProcessNames: TArray<string>);
    function IsTargetProcess(ProcessId: DWORD; const TargetProcesses: TArray<string>; out ProcessName: string): Boolean;
    procedure HideWindows(const ProcessNames: TArray<string>);
    procedure ShowWindows(const ProcessNames: TArray<string>);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Toggle(const ProcessNames: TArray<string>); overload;
    procedure Toggle(const ProcessName: string); overload;
    function IsProcessHidden(const ProcessName: string): Boolean;
    function AreAllProcessesHidden: Boolean;
  end;

implementation

function EnumWindowsCallback(Wnd: HWND; lParam: LParam): BOOL; stdcall;
var
  ProcessId: DWORD;
  Info: TProcessWindowInfo;
  WindowList: TList<TProcessWindowInfo> absolute lParam;
begin
  GetWindowThreadProcessId(Wnd, @ProcessId);
  if (ProcessId <> 0) and IsWindowVisible(Wnd) and IsWindow(Wnd) then
  begin
    Info.ProcessId := ProcessId;
    Info.WindowHandle := Wnd;
    Info.IsForeground := (Wnd = GetForegroundWindow);
    Info.ProcessName := '';
    WindowList.Add(Info);
  end;
  Result := True;
end;

constructor TWindowManager.Create;
begin
  inherited Create;
  FWindowList := TDictionary<string, TList<TProcessWindowInfo>>.Create;
  FHiddenProcesses := TDictionary<string, Boolean>.Create;
end;

destructor TWindowManager.Destroy;
var
  List: TList<TProcessWindowInfo>;
begin
  for List in FWindowList.Values do
    List.Free;
  FWindowList.Free;
  FHiddenProcesses.Free;
  inherited Destroy;
end;

function TWindowManager.IsTargetProcess(ProcessId: DWORD; const TargetProcesses: TArray<string>;
  out ProcessName: string): Boolean;
var
  FileName: array[0..MAX_PATH] of Char;
  ProcessHandle: THandle;
  I: Integer;
  LowerProcessName: string;
begin
  Result := False;
  ProcessName := '';
  ProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ProcessId);
  if ProcessHandle <> 0 then
  try
    if GetModuleFileNameEx(ProcessHandle, 0, FileName, MAX_PATH) > 0 then
    begin
      ProcessName := ExtractFileName(FileName);
      LowerProcessName := ProcessName.ToLower;

      for I := 0 to High(TargetProcesses) do
      begin
        if LowerProcessName = TargetProcesses[I].ToLower then
          Exit(True);
      end;
    end;
  finally
    CloseHandle(ProcessHandle);
  end;
end;

procedure TWindowManager.CollectProcessWindows(const ProcessNames: TArray<string>);
var
  TempList: TList<TProcessWindowInfo>;
  Info: TProcessWindowInfo;
  FoundProcessName: string;
  ProcessName: string;
  LowerProcessNames: TArray<string>;
  I: Integer;
begin
  // Prepare lowercase versions for comparison
  SetLength(LowerProcessNames, Length(ProcessNames));
  for I := 0 to High(ProcessNames) do
    LowerProcessNames[I] := ProcessNames[I].ToLower;

  // Clear only windows for the specified processes
  for ProcessName in ProcessNames do
  begin
    if FWindowList.ContainsKey(ProcessName) then
      FWindowList[ProcessName].Clear
    else
      FWindowList.Add(ProcessName, TList<TProcessWindowInfo>.Create);
  end;

  TempList := TList<TProcessWindowInfo>.Create;
  try
    EnumWindows(@EnumWindowsCallback, LParam(TempList));
    for Info in TempList do
    begin
      if IsTargetProcess(Info.ProcessId, LowerProcessNames, FoundProcessName) then
      begin
        // Find the original process name (case-sensitive) to use as key
        for ProcessName in ProcessNames do
        begin
          if SameText(ProcessName, FoundProcessName) then
          begin
            FWindowList[ProcessName].Add(Info);
            Break;
          end;
        end;
      end;
    end;
  finally
    TempList.Free;
  end;
end;

procedure TWindowManager.HideWindows(const ProcessNames: TArray<string>);

 function IsValidWindow(hWnd: HWND): Boolean;
 begin
  Result := IsWindow(hWnd) and (GetWindowLongPtr(hWnd, GWL_STYLE) <> 0);
 end;

var
  ProcessName: string;
  Info: TProcessWindowInfo;
  AnyHidden: Boolean;
begin
  CollectProcessWindows(ProcessNames);

  for ProcessName in ProcessNames do
  begin
    if not FWindowList.ContainsKey(ProcessName) or (FWindowList[ProcessName].Count = 0) then
    begin
      FHiddenProcesses.AddOrSetValue(ProcessName, False);
      Continue;
    end;

    AnyHidden := False;
    for Info in FWindowList[ProcessName] do
    begin
      if IsValidWindow(Info.WindowHandle) and IsWindowVisible(Info.WindowHandle) then
      begin
        // Сначала минимизируем, потом скрываем
        ShowWindow(Info.WindowHandle, SW_MINIMIZE);
        ShowWindow(Info.WindowHandle, SW_HIDE);

        if not IsWindowVisible(Info.WindowHandle) then
          AnyHidden := True;
      end;
    end;

    FHiddenProcesses.AddOrSetValue(ProcessName, AnyHidden);
  end;
end;

procedure TWindowManager.ShowWindows(const ProcessNames: TArray<string>);
var
  ProcessName: string;
  Info: TProcessWindowInfo;
  ForegroundSet: Boolean;
  Attempt: Integer;
begin
  for ProcessName in ProcessNames do
  begin
    if not FHiddenProcesses.ContainsKey(ProcessName) or not FHiddenProcesses[ProcessName] then
      Continue;

    if not FWindowList.ContainsKey(ProcessName) then
      Continue;

    // Делаем несколько попыток показать окна
    for Attempt := 1 to 3 do
    begin
      ForegroundSet := False;
      for Info in FWindowList[ProcessName] do
      begin
        if IsWindow(Info.WindowHandle) then
        begin
          // Восстанавливаем окно
          ShowWindow(Info.WindowHandle, SW_RESTORE);
          ShowWindow(Info.WindowHandle, SW_SHOW);

          // Обновляем окно
          UpdateWindow(Info.WindowHandle);

          // Восстанавливаем фокус если это было активное окно
          if Info.IsForeground and not ForegroundSet then
          begin
            SetForegroundWindow(Info.WindowHandle);
            SetActiveWindow(Info.WindowHandle);
            SetFocus(Info.WindowHandle);
            ForegroundSet := True;
          end;

          Sleep(50);
        end;
      end;

      // Проверяем, что хотя бы одно окно стало видимым
      for Info in FWindowList[ProcessName] do
      begin
        if IsWindowVisible(Info.WindowHandle) then
        begin
          FHiddenProcesses.AddOrSetValue(ProcessName, False);
          Break;
        end;
      end;

      if not FHiddenProcesses[ProcessName] then
        Break;

      Sleep(100); // Пауза между попытками
    end;
  end;
end;

procedure TWindowManager.Toggle(const ProcessNames: TArray<string>);
var
  ProcessName: string;
  HasHiddenProcess: Boolean;
  ProcessesToShow, ProcessesToHide: TList<string>;
begin
  ProcessesToShow := TList<string>.Create;
  ProcessesToHide := TList<string>.Create;
  try
    // Проверяем, есть ли хотя бы один скрытый процесс
    HasHiddenProcess := False;
    for ProcessName in ProcessNames do
    begin
      if IsProcessHidden(ProcessName) then
      begin
        HasHiddenProcess := True;
        ProcessesToShow.Add(ProcessName);
      end;
    end;

    if HasHiddenProcess then
    begin
      // Если есть скрытые – показываем только их, остальные не трогаем
      ShowWindows(ProcessesToShow.ToArray);
    end
    else
    begin
      // Если все процессы видны – скрываем всех
      for ProcessName in ProcessNames do
        ProcessesToHide.Add(ProcessName);
      HideWindows(ProcessesToHide.ToArray);
    end;
  finally
    ProcessesToShow.Free;
    ProcessesToHide.Free;
  end;
end;

procedure TWindowManager.Toggle(const ProcessName: string);
begin
  Toggle([ProcessName]);
end;

function TWindowManager.IsProcessHidden(const ProcessName: string): Boolean;
begin
  Result := FHiddenProcesses.ContainsKey(ProcessName) and FHiddenProcesses[ProcessName];
end;


function TWindowManager.AreAllProcessesHidden: Boolean;
var
  ProcessName: string;
  IsRunning, IsHidden: Boolean;
begin
  Result := True;

  // Если нет записей в FHiddenProcesses, значит, ничего не скрыто
  if FHiddenProcesses.Count = 0 then
    Exit(False);

  // Проверяем каждый процесс в FHiddenProcesses
  for ProcessName in FHiddenProcesses.Keys do
  begin
    IsRunning := IsProcessRunning(ProcessName);
    IsHidden := FHiddenProcesses[ProcessName];

    // Если процесс запущен, но не скрыт — значит, не все скрыты
    if IsRunning and not IsHidden then
    begin
      Result := False;
      Exit;
    end;

    // Если процесс не запущен, его не учитываем
  end;
end;

end.
