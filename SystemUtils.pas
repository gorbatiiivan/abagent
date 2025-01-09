unit SystemUtils;

interface

uses MMDevApi, Windows, Classes, Registry, SysUtils, ActiveX, TlHelp32, ShlObj,
     MMSystem, WinInet, ShellApi, Messages, Variants, Generics.Collections,
     ComCtrls, WinSvc, IniFiles, Forms, ComObj, StdCtrls, Types, IOUtils,
     Controls, PngImage, Graphics;

// ---------------------------------------------------------------------------
// GetWinHandleFromProcId
type
  TEnumData = record
    WHdl: HWND;
    WPid: DWORD;
    WTitle: String;
  end;
  PEnumData = ^TEnumData;
// ---------------------------------------------------------------------------

const
  ACTION_KILL_PROCESS: Integer = 1;
  ACTION_CLOSE_WINDOWS_FOR_PROCESS: Integer = 2;
  ACTION_HIDE_WINDOWS_FOR_PROCESS: Integer = 3;
  ACTION_MINIMIZE_WINDOWS_FOR_PROCESS: Integer = 4;
// ---------------------------------------------------------------------------

// GENERAL FUNCTIONS
// ---------------------------------------------------------------------------
function IsCurrentOSWindowsVista7(): Boolean;
function HasAdministratorRights(): Boolean;
function GetLocalComputerName(NameType: TComputerNameFormat = ComputerNameDnsHostname): string;
function CurrentUserName:String;
function ServiceStart(aMachineName,aServiceName: string): boolean;
function ServiceStop(aMachineName, aServiceName: string): boolean;
function ServiceGetStatus(sMachine, sService: PChar): DWORD;
function ServiceRunning(sMachine, sService: PChar): Boolean;
procedure ScheduleRunAtStartup(nCreate: Boolean; const ATaskName: string;
  const AFileName: string; const AUserAccount: string);
function CheckRunAtStartupByScheduledTask(const TaskName: string): Boolean;
// ---------------------------------------------------------------------------

// WINDOWS TASK SCHEDULING FUNCTIONS
// ---------------------------------------------------------------------------
function GetProcessID_(ProcessExeFilename: String): Integer;
function GetRunningCountForProcess(ProcessExeFilename: String): Integer;
function KillProcess(ProcessExeFilename: String): Integer;
function TerminateProcessById(ProcessID: DWORD): Boolean;
function CloseWindowsForProcess(ProcessExeFilename: String): Integer;
function HideWindowsForProcess(ListView: TListView; ProcessExeFilename: String): Integer;
function MinimizeWindowsForProcess(ProcessExeFilename: String): Integer;
function RestoreWindowsForProcess(ProcessExeFilename: String): Integer;
function KeywordsActionProcess(ListView: TListView; KeywordsList: TStringList; CaseSensitive: Boolean; ActionType: Integer): Integer;
function ShowWindowInTaskbar(hWndOwner: HWnd): Integer;
function ShowAllHiddenWindowsInTaskbar(ListView: TListView; ProcessExeFilename: String): Integer;
function HideWindowFromTaskbar(hWndOwner: HWnd): Integer;
function EnumWindowsProcMatchPID(WHdl: HWND; EData: PEnumData): bool; stdcall;
function GetWinHandleFromProcId(ProcId: DWORD): HWND;
function IsProcessRunning(const AProcessName: string): Boolean;
// ---------------------------------------------------------------------------

// SOUND CONTROL FUNCTIONS
// ---------------------------------------------------------------------------
function SetMasterMute(MuteValue: Boolean): Integer;
procedure MuteForProcess(Config: TMemIniFile; ProcessName: String; Mute: Boolean);
// ---------------------------------------------------------------------------

// HISTORY CLEANING FUNCTIONS
// ---------------------------------------------------------------------------
function DeleteFolderContents(FolderPath: String): Integer;
function DeleteRecentFiles(): Integer;
function DeleteRecycleBinFiles(): Integer;
function GetSpecialPath( CSIDL: Word ): PChar;
procedure ClearDPS(isDPSServiceRunning: Boolean);
function RemoveFromRegistryWithMui(MyRoot: HKEY; Key, Name: String): Integer;
function RemoveFromRegistryWithLocation(MyRoot: HKEY; Key,Name: String): Integer;
procedure RemoveAllFromRegistry(AppName,AppLocation: String);
function DeleteFilesFromFolder(sFiles: String; const FolderPath: string): Boolean;
procedure RemoveFromRegistryControlSet(AppLocation: String);
procedure DeleteFilesFromSysMaps(IntLocation: Integer; ProcessNames, FileLocation: String);
// ---------------------------------------------------------------------------

// Get Current User Sid FUNCTIONS
// ---------------------------------------------------------------------------
function GetCurrentUserSid: string;
// ---------------------------------------------------------------------------

// LISTVIEW FUNCTIONS
// ---------------------------------------------------------------------------
procedure AddSubItemsToItemByName(ListView: TListView; const ItemName: string; const SubItems: array of string);
function GetSubItemsFromItemName(ListView: TListView; const ItemName: string): TStringList;
procedure DeleteItemByName(ListView: TListView; const ItemName: string);
// ---------------------------------------------------------------------------

// DRIVE FUNCTIONS
// ---------------------------------------------------------------------------
function CurDrvFile(sFileName: String): Char;
function GetQueryDosDevice(sDeviceName: LPCWSTR): String;
function GetDiskVolume(sFileName: String): String;
function RemoveDriveFromFile(sFileName: String): String;
// ---------------------------------------------------------------------------

// TSTRINGS FUNCTIONS
// ---------------------------------------------------------------------------
function FindString(List: TStrings; s: string): Integer;
procedure StrToList(const S, Sign: string; SList: TStrings);
function FindStringInStringList(sList: TStringList; const SearchStr: string;
   CaseSensitive: Boolean = False): Integer;
procedure ProcessToList(MyList: TStrings);
procedure RemoveDuplicateItems(ListBox: TListBox);
// ---------------------------------------------------------------------------

// FILENAME FUNCTIONS
// ---------------------------------------------------------------------------
function RunApplication(const AExecutableFile, AParameters, AWorkingDir : string;
  const AShowOption: Integer = SW_SHOWNORMAL): Integer;
procedure OpenFileLocation(FileName: TFileName);
function SelectExe(const Caption: string; var Directory, Name: string): boolean;
procedure LogWrite(LogType: String; LogFrom: String; LogMessage: String);
function ABBoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;
function RenameSection(IniFile:TCustomIniFile; FromName,ToName:string):boolean;
procedure ScanProcessListFromIni(Config: TMemIniFile; TabList: TTabControl);
// ---------------------------------------------------------------------------

// ENCRYPTION FUNCTIONS
// ---------------------------------------------------------------------------
function Encode(Source, Key: AnsiString): AnsiString;
function Decode(Source, Key: AnsiString): AnsiString;
// ---------------------------------------------------------------------------

// IMAGES FUNCTIONS
// ---------------------------------------------------------------------------
procedure LangImgFromRes(ImageList: TImageList);
// ---------------------------------------------------------------------------

implementation

var
  EndpointVolume: IAudioEndpointVolume = nil;
  WindowsHandleList: TList<Cardinal>;
// ---------------------------------------------------------------------------

                             // GENERAL FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function for checking if current operating system is pre-Window XP (because it has different commands and registry keys)
 * @return True if pre-Window XP operating system, false if post-Window XP operating system
 * }
function IsCurrentOSWindowsVista7(): Boolean;
var
  WindowsVista7FilePath: String;
  AuxCharString: array [0 .. 255] of Char;
begin
  GetWindowsDirectory(AuxCharString, SizeOf(AuxCharString));
  WindowsVista7FilePath := String(AuxCharString);
  WindowsVista7FilePath := WindowsVista7FilePath + '\System32\ndfetw.dll';
  if FileExists(WindowsVista7FilePath) then begin
    Result := True;
  end else begin
    Result := False;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for checking if the user has the rights to modify the system registry
 * @return True if the user has the rights, false otherwise
 * }
function HasAdministratorRights(): Boolean;
var
  Registry: TRegistry;
begin
  try
    Registry := TRegistry.Create();
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Registry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
    Registry.WriteString('AdministratorRightsCheck', '1');
    if (not Registry.ValueExists('AdministratorRightsCheck')) then begin
      Result := False;
    end else begin
      Registry.DeleteValue('AdministratorRightsCheck');
      Registry.CloseKey();
      Registry.Free();
      Result := True;
    end;
  except
    Result := False;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for checking name of the computer name
 * @return String
 * }
function GetLocalComputerName(NameType: TComputerNameFormat = ComputerNameDnsHostname): string;
var
  len: DWORD;
begin
  len:= 0;
  GetComputerNameEx(NameType, nil, len);
  SetLength(Result, len - 1);
  if not GetComputerNameEx(NameType, PChar(Result), len) then RaiseLastOSError;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for checking name of the user name
 * @return String
 * }
function CurrentUserName:String;
var
  UserName: array[0..127] of Char;
  Size:DWord;
begin
  Size:=SizeOf(UserName);
  GetUserName(UserName,Size);
  Result:=UserName;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to run any service from system
 * @return Bool
 * }
function ServiceStart(aMachineName,aServiceName: string): boolean;
var
  schm,
  schs: SC_Handle;
  ss: TServiceStatus;
  psTemp: PChar;
  dwChkP: DWord;
begin
  ss.dwCurrentState := 1;
  schm := OpenSCManager(PChar(aMachineName),nil, SC_MANAGER_CONNECT);
  if (schm > 0) then
  begin
    schs := OpenService(schm,PChar(aServiceName),SERVICE_START or SERVICE_QUERY_STATUS);
    if (schs > 0) then
    begin
      psTemp := nil;
      if (StartService(schs,0, psTemp)) then
      begin
        if (QueryServiceStatus(schs,ss)) then
        begin
          while (SERVICE_RUNNING <> ss.dwCurrentState) do
          begin
            dwChkP := ss.dwCheckPoint;
            Sleep(ss.dwWaitHint);
            if (not QueryServiceStatus(schs,ss)) then
            begin
              break;
            end;
            if (ss.dwCheckPoint <dwChkP) then
            begin
              break;
            end;
          end;
        end;
      end;
      CloseServiceHandle(schs);
    end;
    CloseServiceHandle(schm);
  end;
  Result := SERVICE_RUNNING = ss.dwCurrentState;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to stop any service from system
 * @return Bool
 * }
function ServiceStop(aMachineName, aServiceName: string): boolean;
var
  schm,schs: SC_Handle;
  ss: TServiceStatus;
  dwChkP: DWord;
begin
  schm := OpenSCManager(PChar(aMachineName), nil, SC_MANAGER_CONNECT);
  if (schm > 0) then begin
    schs := OpenService(schm,  PChar(aServiceName), SERVICE_STOP or SERVICE_QUERY_STATUS);
    if (schs > 0) then  begin
      if (ControlService(schs, SERVICE_CONTROL_STOP, ss)) then begin
        if (QueryServiceStatus(schs,ss)) then begin
          while (SERVICE_STOPPED<> ss.dwCurrentState) do begin
            dwChkP := ss.dwCheckPoint;
            Sleep(ss.dwWaitHint);
            if (not QueryServiceStatus(schs,ss)) then break;
            if (ss.dwCheckPoint < dwChkP) then break;
          end;
        end;
      end;
      CloseServiceHandle(schs);
    end;
    CloseServiceHandle(schm);
  end;
  Result := SERVICE_STOPPED = ss.dwCurrentState;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get status running service from system
 * @return Values DWORD
 * }
function ServiceGetStatus(sMachine, sService: PChar): DWORD;
  {******************************************}
  {*** Parameters: ***}
  {*** sService: specifies the name of the service to open
  {*** sMachine: specifies the name of the target computer
  {*** ***}
  {*** Return Values: ***}
  {*** -1 = Error opening service ***}
  {*** 1 = SERVICE_STOPPED ***}
  {*** 2 = SERVICE_START_PENDING ***}
  {*** 3 = SERVICE_STOP_PENDING ***}
  {*** 4 = SERVICE_RUNNING ***}
  {*** 5 = SERVICE_CONTINUE_PENDING ***}
  {*** 6 = SERVICE_PAUSE_PENDING ***}
  {*** 7 = SERVICE_PAUSED ***}
  {******************************************}
var
  SCManHandle, SvcHandle: SC_Handle;
  SS: TServiceStatus;
  dwStat: DWORD;
begin
  dwStat := 0;
  // Open service manager handle.
  SCManHandle := OpenSCManager(sMachine, nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then
  begin
    SvcHandle := OpenService(SCManHandle, sService, SERVICE_QUERY_STATUS);
    // if Service installed
    if (SvcHandle > 0) then
    begin
      // SS structure holds the service status (TServiceStatus);
      if (QueryServiceStatus(SvcHandle, SS)) then
        dwStat := ss.dwCurrentState;
      CloseServiceHandle(SvcHandle);
    end;
    CloseServiceHandle(SCManHandle);
  end;
  Result := dwStat;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get status running service from system
 * @return Bool
 * }
function ServiceRunning(sMachine, sService: PChar): Boolean;
begin
  Result := SERVICE_RUNNING = ServiceGetStatus(sMachine, sService);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to create or delete task in a Task Scheduler
 * }
procedure ScheduleRunAtStartup(nCreate: Boolean; const ATaskName: string; const AFileName: string;
  const AUserAccount: string);
begin
if nCreate = True then
 begin
  ShellExecute(0, nil, 'schtasks', PChar('/delete /f /tn "' + ATaskName + '"'), nil, SW_HIDE);
  ShellExecute(0, nil, 'schtasks', PChar('/RL HIGHEST /create /tn "' + ATaskName + '" ' +
    '/tr "' + AFileName + '" /sc ONLOGON /ru "' + GetLocalComputerName+'\'+AUserAccount + '"'), nil, SW_HIDE);
 end else
if nCreate = False then
 begin
  ShellExecute(0, nil, 'schtasks', PChar('/delete /f /tn "' + ATaskName + '"'), nil, SW_HIDE);
 end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to check if exists task in a Task Scheduler
 * @return Boolean
 * }
function CheckRunAtStartupByScheduledTask(const TaskName: string): Boolean;
const
  TASK_ENUM_HIDDEN = $1;
var
  TaskService: OleVariant;
  TaskFolder: OleVariant;
  TaskCollection: OleVariant;
  Task: OleVariant;
  i: Integer;
begin
  Result := False;
  try
    // Initialize COM library
    CoInitialize(nil);
    try
      // Connect to Task Scheduler service
      TaskService := CreateOleObject('Schedule.Service');
      TaskService.Connect;

      // Get the root task folder
      TaskFolder := TaskService.GetFolder('\');

      // Retrieve all tasks
      TaskCollection := TaskFolder.GetTasks(TASK_ENUM_HIDDEN);

      for i := 1 to TaskCollection.Count do
      begin
        Task := TaskCollection.Item[i];
        if SameText(Task.Name, TaskName) then
        begin
          Result := True;
          Exit;
        end;
      end;
    finally
      CoUninitialize;
    end;
  except
    on E: Exception do
      Writeln('Error: ', E.Message);
  end;
end;
// ---------------------------------------------------------------------------

// TASK AND WINDOWS MANAGER FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function for finding the PID of a certain process
 * @param String Filename of the executable that generated the process
 * @return PID of the process (if value is not 0) or 0 if there has been an error
 * }
function GetProcessID_(ProcessExeFilename: String): Integer;
var
  Handle: tHandle;
  Process: tProcessEntry32;
  GotProcess: Boolean;
begin
  Handle := CreateToolHelp32SnapShot(TH32CS_SNAPALL, 0);
  Process.dwSize := SizeOf(Process);
  GotProcess := Process32First(Handle, Process);
{$B-}
  if (GotProcess and (Process.szExeFile <> ProcessExeFilename) and (Process.szExeFile <> UpperCase(ProcessExeFilename)) and (Process.szExeFile <> LowerCase(ProcessExeFilename))) then begin
    repeat
      GotProcess := Process32Next(Handle, Process);
    until ((not GotProcess) or (Process.szExeFile = ProcessExeFilename) or (Process.szExeFile = UpperCase(ProcessExeFilename)) or (Process.szExeFile = LowerCase(ProcessExeFilename)));
  end;
{$B+}
  if GotProcess then begin
    Result := Process.th32ProcessID;
  end else begin
    Result := 0;
  end;
  CloseHandle(Handle);
end;
// ---------------------------------------------------------------------------
{ **
 * Function for counting the number of running processes by a given filename
 * @param String Filename of the executable that generated the process
 * @return Number of running processes by the given filename
 * }
function GetRunningCountForProcess(ProcessExeFilename: String): Integer;
var
  Handle: tHandle;
  Process: tProcessEntry32;
  GotProcess: Boolean;
begin
  Result := 0;
  Handle := CreateToolHelp32SnapShot(TH32CS_SNAPALL, 0);
  Process.dwSize := SizeOf(Process);
  GotProcess := Process32First(Handle, Process);
{$B-}
  while (GotProcess) do begin
    if ((Process.szExeFile = ProcessExeFilename) or (Process.szExeFile = UpperCase(ProcessExeFilename)) or (Process.szExeFile = LowerCase(ProcessExeFilename))) then begin
      Inc(Result);
    end;
    GotProcess := Process32Next(Handle, Process);
  end;
{$B+}
  CloseHandle(Handle);
end;
// ---------------------------------------------------------------------------
{ **
 * Function for checking if a handle points to a window and, if visible, add it to an array
 * @param WindowsHandle Provided handle
 * @param I Unused integer value
 * @return True if the call was successful, false otherwise
 * }
function GetWindowsHandleList(WindowsHandle: tHandle; I: Integer): Boolean; stdcall;
begin
  try
    if (IsWindow(WindowsHandle) and IsWindowVisible(WindowsHandle)) then begin
      WindowsHandleList.Add(WindowsHandle);
    end;
    Result := True;
  except
    Result := False;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for killing a task
 * @param ProcessExeFilename The filename of the executable which created the process
 * @return 0 if there has been an error, anything else otherwise
 * }
function KillProcess(ProcessExeFilename: String): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: Boolean;
  FSnapshotHandle: tHandle;
  FProcessEntry32: tProcessEntry32;
begin
  Result := 0;
  FSnapshotHandle := CreateToolHelp32SnapShot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  while (Integer(ContinueLoop) <> 0) do begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ProcessExeFilename)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ProcessExeFilename))) then begin
      Result := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;
// ---------------------------------------------------------------------------
{ **
 * Function for killing a task
 * @param ProcessID PID of the executable which created the process
 * @return True or False
 * }
function TerminateProcessById(ProcessID: DWORD): Boolean;
var
  ProcessHandle: THandle;
begin
  // Open the process with the necessary privileges
  ProcessHandle := OpenProcess(PROCESS_TERMINATE, False, ProcessID);
  if ProcessHandle = 0 then
  begin
    Result := False;
    Exit;
  end;
  try
    // Attempt to terminate the process
    Result := TerminateProcess(ProcessHandle, 0);
  finally
    CloseHandle(ProcessHandle);
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for closing the windows of a process
 * @param ProcessExeFilename The filename of the executable which created the process
 * @return Success (0) or error code (1)
 * }
function CloseWindowsForProcess(ProcessExeFilename: String): Integer;
var
  I, ProcessID1, ProcessID2: Integer;
begin
  try
    WindowsHandleList := TList<Cardinal>.Create();
    // Finding out the PID of the selected task!
    ProcessID1 := GetProcessID_(ProcessExeFilename);
    // Storing the handles of all active windows in an array!
    EnumWindows(@GetWindowsHandleList, 0);
    for I := 0 to WindowsHandleList.Count - 1 do begin
    // Detecting the PID of the windows using their handles...
      GetWindowThreadProcessID(WindowsHandleList[I], @ProcessID2);
      // ... and then is compared with the PID of all tasks to find out whick task created that window!
      if (ProcessID1 = ProcessID2) then begin
        // Closing the window of the selected task!
        SendMessage(WindowsHandleList[I], WM_SYSCOMMAND, SC_CLOSE, 0);
      end;
    end;
    WindowsHandleList.Free();
    Result := 0;
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for hiding the windows of a process
 * @param ProcessExeFilename The filename of the executable which created the process
 * @return Success (0) or error code (1)
 * }

function HideWindowsForProcess(ListView: TListView; ProcessExeFilename: String): Integer;
var
  I, ProcessID1, ProcessID2: Integer;
  L: integer;
  Item: TListItem;
begin
  try
    WindowsHandleList := TList<Cardinal>.Create();
  // Finding out the PID of the selected task!
    ProcessID1 := GetProcessID_(ProcessExeFilename);
  // Storing the handles of all active windows in an array!
    EnumWindows(@GetWindowsHandleList, 0);
    for I := 0 to WindowsHandleList.Count - 1 do begin
    // Detecting the PID of the windows using their handles...
      GetWindowThreadProcessID(WindowsHandleList[I], @ProcessID2);
    // ... and then is compared with the PID of all tasks to find out whick task created that window!
      if (ProcessID1 = ProcessID2) then begin
      // Hiding the window of the selected task!
        SendMessage(WindowsHandleList[I], WM_SYSCOMMAND, SC_MINIMIZE, 0);
        HideWindowFromTaskbar(WindowsHandleList[I]);
      // Saving the handles of the windows that need to be redisplayed!
        AddSubItemsToItemByName(ListView, ProcessExeFilename,[IntToStr(WindowsHandleList[I])]);
      end;
    end;
    WindowsHandleList.Free();
    Result := 0;
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for minimizing the windows of a process
 * @param ProcessExeFilename The filename of the executable which created the process
 * @return Success (0) or error code (1)
 * }
function MinimizeWindowsForProcess(ProcessExeFilename: String): Integer;
var
  I, ProcessID1, ProcessID2: Integer;
begin
  try
    WindowsHandleList := TList<Cardinal>.Create();
  // Finding out the PID of the selected task!
    ProcessID1 := GetProcessID_(ProcessExeFilename);
  // Storing the handles of all active windows in an array!
    EnumWindows(@GetWindowsHandleList, 0);
    for I := 0 to WindowsHandleList.Count - 1 do begin
    // Detecting the PID of the windows using their handles...
      GetWindowThreadProcessID(WindowsHandleList[I], @ProcessID2);
    // ... and then is compared with the PID of all tasks to find out whick task created that window!
      if (ProcessID1 = ProcessID2) then begin
      // Minimizing to taskbar!
        SendMessage(WindowsHandleList[I], WM_SYSCOMMAND, SC_MINIMIZE, 0);
      end;
    end;
    WindowsHandleList.Free();
    Result := 0;
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for restore the windows of a process
 * @param ProcessExeFilename The filename of the executable which created the process
 * @return Success (0) or error code (1)
 * }
function RestoreWindowsForProcess(ProcessExeFilename: String): Integer;
var
  I, ProcessID1, ProcessID2: Integer;
begin
  try
    WindowsHandleList := TList<Cardinal>.Create();
  // Finding out the PID of the selected task!
    ProcessID1 := GetProcessID_(ProcessExeFilename);
  // Storing the handles of all active windows in an array!
    EnumWindows(@GetWindowsHandleList, 0);
    for I := 0 to WindowsHandleList.Count - 1 do begin
    // Detecting the PID of the windows using their handles...
      GetWindowThreadProcessID(WindowsHandleList[I], @ProcessID2);
    // ... and then is compared with the PID of all tasks to find out whick task created that window!
      if (ProcessID1 = ProcessID2) then begin
      // Minimizing to taskbar!
        SendMessage(WindowsHandleList[I], WM_SYSCOMMAND, SC_RESTORE, 0);
      end;
    end;
    WindowsHandleList.Free();
    Result := 0;
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for processing a keyword
 * @param KeywordsList The list of keywords to process
 * @param CaseSensitive Keywords are considered case sensitive or not
 * @param ActionType Action to take
 * @return Success (0) or error code (1)
 * }
function KeywordsActionProcess(ListView: TListView; KeywordsList: TStringList; CaseSensitive: Boolean; ActionType: Integer): Integer;
var
  I, J, PID: Integer;
  PIDList: TList<Integer>;
  WindowTitle: String;
  WindowTitleChar: array [0 .. 255] of Char;
  ContinueLoop: Boolean;
  FSnapshotHandle: tHandle;
  FProcessEntry32: tProcessEntry32;
begin
  try
    WindowsHandleList := TList<Cardinal>.Create();
    PIDList := TList<Integer>.Create();
    // Storing the handles of all active windows in an array!
    EnumWindows(@GetWindowsHandleList, 0);
    for I := 0 to WindowsHandleList.Count - 1 do begin
      // Running thru every window and extracting it's title!
      GetWindowText(WindowsHandleList[I], WindowTitleChar, 255);
      // Converting the char array into a String!
      WindowTitle := String(WindowTitleChar);
      for J := 0 to KeywordsList.Count - 1 do begin
        // Searching for the keyword in the title! If found, the PID of the task that generated that window is stored in a list!
        if (((Pos(KeywordsList[J], WindowTitle) <> 0) and CaseSensitive) or ((Pos(UpperCase(KeywordsList[J]), UpperCase(WindowTitle)) <> 0) and (not CaseSensitive))) then begin
          PID := 0;
          GetWindowThreadProcessID(WindowsHandleList[I], @PID);
          if (PID <> 0) then begin
            PIDList.Add(PID);
          end;
        end;
      end;
    end;

    // Running thru all the active tasks!
    FSnapshotHandle := CreateToolHelp32SnapShot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    // Extracting the name of the task if the PID is contained in the saved list and the requested action is performed on that task!
    while (Integer(ContinueLoop) <> 0) do begin
      if (PIDList.Contains(Integer(FProcessEntry32.th32ProcessID))) then begin
        if (ActionType = ACTION_KILL_PROCESS) then
          KillProcess(ExtractFileName(FProcessEntry32.szExeFile));
        if (ActionType = ACTION_CLOSE_WINDOWS_FOR_PROCESS) then
          CloseWindowsForProcess(ExtractFileName(FProcessEntry32.szExeFile));
        if (ActionType = ACTION_HIDE_WINDOWS_FOR_PROCESS) then
          HideWindowsForProcess(ListView, ExtractFileName(FProcessEntry32.szExeFile));
        if (ActionType = ACTION_MINIMIZE_WINDOWS_FOR_PROCESS) then
          MinimizeWindowsForProcess(ExtractFileName(FProcessEntry32.szExeFile));
      end;
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;
    CloseHandle(FSnapshotHandle);
    PIDList.Free();
    Result := 0;
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for showing windows in taskbar
 * @param hWndOwner Handler of the window
 * @return Success (0) or error code (1)
 * }
function ShowWindowInTaskbar(hWndOwner: HWnd): Integer;
var
  hParent: tHandle;
begin
  try
    hParent := GetWindow(hWndOwner, GW_OWNER);
    if (hParent <> 0) then begin
      hWndOwner := hParent;
    end;
    ShowWindow(hWndOwner, SW_SHOW);
    Result := 1;
  except
    Result := 0;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for showing all hidden windows in taskbar
 * @return Success (0) or error code (1)
 * }
function ShowAllHiddenWindowsInTaskbar(ListView: TListView; ProcessExeFilename: String): Integer;
var
  I: Integer;
  SubItems: TStringList;
begin
  try
    SubItems := GetSubItemsFromItemName(ListView, ProcessExeFilename);
     try
      if SubItems.Count > 0 then
       begin
        for i := 0 to SubItems.Count - 1 do
        ShowWindowInTaskbar(StrToInt(SubItems[i]));
       end;
     finally
      SubItems.Free;
     end;
     DeleteItemByName(ListView,ProcessExeFilename);
    Result := 1;
  except
    Result := 0;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for hiding window from taskbar
 * @param hWndOwner Handler of the window
 * @return Success (0) or error code (1)
 * }
function HideWindowFromTaskbar(hWndOwner: HWnd): Integer;
var
  hParent: tHandle;
begin
  try
    hParent := GetWindow(hWndOwner, GW_OWNER);
    if (hParent <> 0) then begin
      hWndOwner := hParent;
    end;
    ShowWindow(hWndOwner, SW_HIDE);
    Result := 0;
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Functions for finding the WinHandle from PID of a certain process
 * @param DWORD of the executable that generated the process
 * }
function EnumWindowsProcMatchPID(WHdl: HWND; EData: PEnumData): bool; stdcall;
var
  Wpid : DWORD;
begin
  Result := True;
  GetWindowThreadProcessID(WHdl, @Wpid);
  if (EData.WPid = Wpid) AND IsWindowVisible(WHdl) then
  begin
    EData.WHdl := WHdl;
    Result := False;
  end;
end;

function GetWinHandleFromProcId(ProcId: DWORD): HWND;
var
  EnumData: TEnumData;
begin
  ZeroMemory(@EnumData, SizeOf(EnumData));
  EnumData.WPid := ProcId;
  EnumWindows(@EnumWindowsProcMatchPID, LPARAM(@EnumData));
  Result := EnumData.WHdl;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for check if is running process
 * @return Success (0) or error code (1)
 * }
function IsProcessRunning(const AProcessName: string): Boolean;
var
  SnapshotHandle: THandle;
  ProcessEntry: TProcessEntry32;
begin
  Result := False;
  SnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if SnapshotHandle <> INVALID_HANDLE_VALUE then
  begin
    ProcessEntry.dwSize := SizeOf(ProcessEntry);
    if Process32First(SnapshotHandle, ProcessEntry) then
    begin
      repeat
        if CompareText(ExtractFileName(ProcessEntry.szExeFile), AProcessName) = 0 then
        begin
          Result := True;
          Break;
        end;
      until not Process32Next(SnapshotHandle, ProcessEntry);
    end;
    CloseHandle(SnapshotHandle);
  end;
end;
// ---------------------------------------------------------------------------

// SOUND CONTROL FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function for muting master volume of the soundcard (compatible with post Windows Vista operating systems)
 * @param MuteValue Activate or deactivate mute
 * @return Success (0) or error code (1)
 * }
function IAEVSetMute(MuteValue: Boolean): Integer;
var
  DeviceEnumerator: IMMDeviceEnumerator;
  DefaultDevice: IMMDevice;
begin
  CoCreateInstance(CLASS_IMMDeviceEnumerator, nil, CLSCTX_INPROC_SERVER, IID_IMMDeviceEnumerator, DeviceEnumerator);
  DeviceEnumerator.GetDefaultAudioEndpoint(eRender, eConsole, DefaultDevice);
  DefaultDevice.Activate(IID_IAudioEndpointVolume, CLSCTX_INPROC_SERVER, nil, EndpointVolume);
  if (EndpointVolume = nil) then begin
    Result := 1;
  end else begin
    EndpointVolume.SetMute(MuteValue, nil);
    Result := 0;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for finding the mute control to the master volume of the soundcard (compatible with Windows XP and pre-XP operating systems)
 * @param Mixer Mixer to mute
 * @param MixerControl Mixer control
 * @return Results of mixerGetLineInfo or MixerGetLineControls
 * }
function GetMasterMixerControlForMute(Mixer: hMixerObj; var MixerControl: TMixerControl): MMResult;
var
  MixerLine: TMixerLine;
  MixerLineControls: TMixerLineControls;
begin
  ZeroMemory(@MixerLine, SizeOf(MixerLine));
  MixerLine.cbStruct := SizeOf(MixerLine);
  MixerLine.dwComponentType := MIXERLINE_COMPONENTTYPE_DST_SPEAKERS;
  Result := mixerGetLineInfo(Mixer, @MixerLine, MIXER_GETLINEINFOF_COMPONENTTYPE);
  if (Result = MMSYSERR_NOERROR) then begin
    ZeroMemory(@MixerLineControls, SizeOf(MixerLineControls));
    MixerLineControls.cbStruct := SizeOf(MixerLineControls);
    MixerLineControls.dwLineID := MixerLine.dwLineID;
    MixerLineControls.cControls := 1;
    MixerLineControls.dwControlType := MIXERCONTROL_CONTROLTYPE_MUTE;
    MixerLineControls.cbmxctrl := SizeOf(MixerControl);
    MixerLineControls.pamxctrl := @MixerControl;
    Result := MixerGetLineControls(Mixer, @MixerLineControls, MIXER_GETLINECONTROLSF_ONEBYTYPE);
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for muting master volume of the soundcard (compatible with Windows XP and pre-XP operating systems)
 * @param Mixer Mixer to mute
 * @param MuteValue Activate or deactivate mute
 * @return Results of GetMasterMixerControlForMute or MixerSetControlDetails
 * }
function SetMasterMixerMute(Mixer: hMixerObj; MuteValue: Boolean): Integer;
var
  MixerControl: TMixerControl;
  MixerControlDetails: TMixerControlDetails;
  MixerControlDetailsBoolean: TMixerControlDetailsBoolean;
begin
  Result := GetMasterMixerControlForMute(0, MixerControl);
  if (Result = MMSYSERR_NOERROR) then begin
    with MixerControlDetails do begin
      cbStruct := SizeOf(MixerControlDetails);
      dwControlID := MixerControl.dwControlID;
      cChannels := 1;
      cMultipleItems := 0;
      cbDetails := SizeOf(MixerControlDetailsBoolean);
      paDetails := @MixerControlDetailsBoolean;
    end;
    LongBool(MixerControlDetailsBoolean.fValue) := MuteValue;
    Result := MixerSetControlDetails(0, @MixerControlDetails, MIXER_SETCONTROLDETAILSF_VALUE);
  end;
// if (Result<>MMSYSERR_NOERROR) then begin
// raise Exception.CreateFmt('Could not set master volume! '+ 'Multimedia system error #%d', [Result]);
// end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function for muting master volume of the soundcard (depending on host operating system)
 * @param MuteValue Activate or deactivate mute
 * @return Success (0) or error code (1)
 * }
function SetMasterMute(MuteValue: Boolean): Integer;
begin
  try
  // Volume can also be muted by sending a VK_VOLUME_MUTE key event!
  // keybd_event($AD,MapVirtualKey($AD,0),0,0);
    if (IsCurrentOSWindowsVista7()) then begin
      IAEVSetMute(MuteValue);
    end else begin
      SetMasterMixerMute(0, MuteValue);
    end;
    Result := 1;
  except
    Result := 0;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Procedure to mute by process name or mute all system
 * @param MuteValue Activate or deactivate mute
 * }
procedure MuteForProcess(Config: TMemIniFile; ProcessName: String; Mute: Boolean);
begin
if Config.ReadBool('General', 'Mute', False) then
if Mute = True then
begin
 if FileExists(ExtractFilePath(ParamStr(0))+'svcl.exe') then
  RunApplication(ExtractFilePath(ParamStr(0))+'svcl.exe', '/Mute "'+ProcessName+'"','',SW_HIDE)
 else
  SetMasterMute(True);
end else
 begin
  if FileExists(ExtractFilePath(ParamStr(0))+'svcl.exe') then
   RunApplication(ExtractFilePath(ParamStr(0))+'svcl.exe', '/Unmute "'+ProcessName+'"','',SW_HIDE)
  else
   SetMasterMute(False);
 end;
end;
// ---------------------------------------------------------------------------

// HISTORY CLEANING FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function for deleting the contents of the given folder
 * @param FolderPath Path to the folder which content to delete
 * @return Success (0) or error code (1)
 * }
function DeleteFolderContents(FolderPath: String): Integer;
var
  SearchRecord: TSearchRec;
begin
  try
    // Keep in mind that the first records found are always '.' and '..'!
    if (FindFirst(FolderPath + '*.*', faAnyFile, SearchRecord) = 0) then begin
      if (FileExists(FolderPath + SearchRecord.Name)) then begin
        DeleteFile(FolderPath + SearchRecord.Name);
      end;
      while FindNext(SearchRecord) = 0 do begin
        if (FileExists(FolderPath + SearchRecord.Name)) then begin
          DeleteFile(FolderPath + SearchRecord.Name);
        end;
      end;
    end;
    FindClose(SearchRecord);
    Result := 1;
  except
    Result := 0;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Wrapper for the function deleting all recent files
 * @return Success (0) or error code (1)
 * }
function DeleteRecentFiles(): Integer;
begin
  try
    SHAddToRecentDocs(SHARD_PATH, nil);
    Result := 0;
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Wrapper for the function deleting all files from the Recycle Bin
 * @return Success (0) or error code (1)
 * }
function DeleteRecycleBinFiles(): Integer;
begin
  try
    SHEmptyRecycleBin(0, nil, SHERB_NOCONFIRMATION);
    Result := 0;
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get special path of the windows folders
 * @return PChar of the Directory
 * }
function GetSpecialPath( CSIDL: Word ): PChar;
var
  s: string;
begin
   SetLength( s, MAX_PATH );
   if not SHGetSpecialFolderPath( 0, PChar( s ), CSIDL, false ) then s := '';
   Result := PChar( s );
end;
// ---------------------------------------------------------------------------
{ **
 * Wrapper to delete history of the ethernet
 * }
procedure ClearDPS(isDPSServiceRunning: Boolean);
var
  s: PChar;
begin
  s := PChar(GetSpecialPath(CSIDL_WINDOWS) + '\System32\sru\');
  if IsUserAnAdmin then
   begin
    if isDPSServiceRunning = False then DeleteFile(s+'SRUDB.dat') else
     begin
      if ServiceStop('','DPS') then
      if DeleteFile(s+'SRUDB.dat') then ServiceStart('','DPS');
     end;
   end;
end;
// ---------------------------------------------------------------------------
{ **
 * Wrapper for the function deleting files from registry
 * @return Success (0) or error code (1)
 * }
function RemoveFromRegistryWithMui(MyRoot: HKEY; Key,Name: String): Integer;
var
  Registry: TRegistry;
  ExistsKey: String;
begin
  try
    Registry := TRegistry.Create(KEY_ALL_ACCESS + KEY_WOW64_64KEY);
    Registry.RootKey := MyRoot;
    if not Registry.OpenKey(Key, True) then
    begin
      Result := 1;
    end else begin
     if Registry.ValueExists(Name+'.FriendlyAppName') then
     ExistsKey := Name+'.FriendlyAppName' else
     if Registry.ValueExists(Name+'.ApplicationCompany') then
     ExistsKey := Name+'.ApplicationCompany';
      if Registry.DeleteValue(ExistsKey) then
      begin
        Result := 0;
      end else
      begin
        Result := 1;
      end;
    end;
    Registry.CloseKey();
    Registry.Free();
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Wrapper for the function deleting files from registry
 * @return Success (0) or error code (1)
 * }
function RemoveFromRegistryWithLocation(MyRoot: HKEY; Key,Name: String): Integer;
var
  Registry: TRegistry;
begin
  try
    Registry := TRegistry.Create(KEY_ALL_ACCESS + KEY_WOW64_64KEY);
    Registry.RootKey := MyRoot;
    if not Registry.OpenKey(Key, True) then
    begin
      Result := 1;
    end else
    begin
     if Registry.ValueExists(Name) then
      if Registry.DeleteValue(Name) then
      begin
        Result := 0;
      end else
      begin
        Result := 1;
      end;
    end;
    Registry.CloseKey();
    Registry.Free();
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Wrapper for the function deleting all running files from process list from registry
 * }
procedure RemoveAllFromRegistry(AppName,AppLocation: String);
var
 TempList: TStringList;
 I: Integer;
begin
TempList := TStringList.Create;
try
 TempList.Clear;
 TempList.Add(ParamStr(0));
 TempList.Add('svcl.exe');
 TempList.Add(ExtractFileDir(ParamStr(0)));
 if AppName <> '' then TempList.Add(AppName);
 if AppLocation <> '' then TempList.Add(AppLocation);
 for I := 0 to TempList.Count-1 do
 begin
  RemoveFromRegistryWithMui(HKEY_CLASSES_ROOT,'\Local Settings\Software\Microsoft\Windows\Shell\MuiCache\',TempList[I]);
  RemoveFromRegistryWithMui(HKEY_CURRENT_USER,'\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache\',TempList[I]);
  RemoveFromRegistryWithLocation(HKEY_CURRENT_USER,'\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched\',TempList[I]);
  RemoveFromRegistryWithLocation(HKEY_CURRENT_USER,'\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\ShowJumpView\',TempList[I]);
  RemoveFromRegistryWithLocation(HKEY_CURRENT_USER,'\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store\',TempList[I]);
  RemoveFromRegistryWithLocation(HKEY_CURRENT_USER,'\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers\',TempList[I]);
  RemoveFromRegistryWithLocation(HKEY_LOCAL_MACHINE,'\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers\',TempList[I]);
  RemoveFromRegistryWithMui(HKEY_USERS,'\'+GetCurrentUserSid+'\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache\',TempList[I]);
  RemoveFromRegistryWithLocation(HKEY_USERS,'\'+GetCurrentUserSid+'\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FeatureUsage\AppSwitched\',TempList[I]);
  RemoveFromRegistryWithLocation(HKEY_USERS,'\'+GetCurrentUserSid+'\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store\',TempList[I]);
  RemoveFromRegistryWithMui(HKEY_USERS,'\'+GetCurrentUserSid+'_Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache\',TempList[I]);
 end;
finally
  TempList.Free;
end;
end;

procedure RemoveFromRegistryControlSet(AppLocation: String);
var
 TempList: TStringList;
 I: Integer;
begin
TempList := TStringList.Create;
try
 TempList.Clear;
 TempList.Add(ParamStr(0));
 TempList.Add(ExtractFilePath(ParamStr(0))+'svcl.exe');
 if AppLocation <> '' then TempList.Add(AppLocation);
 for I := 0 to TempList.Count-1 do
 begin
  RemoveFromRegistryWithLocation(HKEY_LOCAL_MACHINE,'\SYSTEM\ControlSet001\Services\bam\State\UserSettings\'+GetCurrentUserSid+'\',GetDiskVolume(TempList[I])+RemoveDriveFromFile(TempList[I]));
  RemoveFromRegistryWithLocation(HKEY_LOCAL_MACHINE,'\SYSTEM\CurrentControlSet\Services\bam\State\UserSettings\'+GetCurrentUserSid+'\',GetDiskVolume(TempList[I])+RemoveDriveFromFile(TempList[I]));
 end;
finally
  TempList.Free;
end;
end;
// ---------------------------------------------------------------------------
{ **
 * Wrapper for the function deleting all files from the folder
 * @return Success (0) or error code (1)
 * }
function DeleteFilesFromFolder(sFiles: String; const FolderPath: string): Boolean;
var
  sFilesDirs: TStringDynArray;
  sFilesPath: String;
begin
  if IsUserAnAdmin then
   begin
    sFilesDirs := TDirectory.GetFiles(FolderPath, sFiles+'*', TSearchOption.soAllDirectories);
     for sFilesPath in sFilesDirs do
      begin
       if DeleteFile(sFilesPath) then
       Result := True;
      end;
   end;
end;
// ---------------------------------------------------------------------------
{ **
 * Wrapper for the function deleting all files from the prefetch folder
 * @return Success (0) or error code (1)
 * }
procedure DeleteFilesFromSysMaps(IntLocation: Integer; ProcessNames, FileLocation: String);
var
 TskMgrList: TStringList;
 j: integer;
 FolderLocation: String;
begin
case IntLocation of
0: FolderLocation := GetSpecialPath(CSIDL_RECENT);
1: FolderLocation := GetSpecialPath(CSIDL_WINDOWS) + '\Prefetch';
end;
 TskMgrList := TStringList.Create;
  try
   TskMgrList.Add(ExtractFileName(ChangeFileExt(ParamStr(0),'')));
   TskMgrList.Add(ExtractFileName(ChangeFileExt(ProcessNames,'')));
   TskMgrList.Add(ExtractFileName(ChangeFileExt(FileLocation,'')));
   for J := 0 to TskMgrList.Count-1 do
    DeleteFilesFromFolder(TskMgrList[J], FolderLocation);
  finally
   TskMgrList.Free;
  end;
end;
// ---------------------------------------------------------------------------

//GET CURRENT SID
// ---------------------------------------------------------------------------
{ **
 * Function to get information about User Sid
 * @return String CurrentUserSid
 * }
function ConvertSid(Sid: PSID; pszSidText: PChar; var dwBufferLen: DWORD): BOOL;
const
 SID_REVISION     = 1;
var
  psia: PSIDIdentifierAuthority;
  dwSubAuthorities: DWORD;
  dwSidRev: DWORD;
  dwCounter: DWORD;
  dwSidSize: DWORD;
begin
  Result := False;

  dwSidRev := SID_REVISION;

  if not IsValidSid(Sid) then Exit;

  psia := GetSidIdentifierAuthority(Sid);

  dwSubAuthorities := GetSidSubAuthorityCount(Sid)^;

  dwSidSize := (15 + 12 + (12 * dwSubAuthorities) + 1) * SizeOf(Char);

  if (dwBufferLen < dwSidSize) then
  begin
    dwBufferLen := dwSidSize;
    SetLastError(ERROR_INSUFFICIENT_BUFFER);
    Exit;
  end;

  StrFmt(pszSidText, 'S-%u-', [dwSidRev]);

  if (psia.Value[0] <> 0) or (psia.Value[1] <> 0) then
    StrFmt(pszSidText + StrLen(pszSidText),
      '0x%.2x%.2x%.2x%.2x%.2x%.2x',
      [psia.Value[0], psia.Value[1], psia.Value[2],
      psia.Value[3], psia.Value[4], psia.Value[5]])
  else
    StrFmt(pszSidText + StrLen(pszSidText),
      '%u',
      [DWORD(psia.Value[5]) +
      DWORD(psia.Value[4] shl 8) +
      DWORD(psia.Value[3] shl 16) +
      DWORD(psia.Value[2] shl 24)]);

  dwSidSize := StrLen(pszSidText);

  for dwCounter := 0 to dwSubAuthorities - 1 do
  begin
    StrFmt(pszSidText + dwSidSize, '-%u',
      [GetSidSubAuthority(Sid, dwCounter)^]);
    dwSidSize := StrLen(pszSidText);
  end;

  Result := True;
end;

function ObtainTextSid(hToken: THandle; pszSid: PChar;
  var dwBufferLen: DWORD): BOOL;
type
  PTokenUser = ^TTokenUser;
  TTokenUser = packed record
    User: TSidAndAttributes;
  end;

var
  dwReturnLength: DWORD;
  dwTokenUserLength: DWORD;
  tic: TTokenInformationClass;
  ptu: Pointer;
begin
  Result := False;
  dwReturnLength := 0;
  dwTokenUserLength := 0;
  tic := TokenUser;
  ptu := nil;

  if not GetTokenInformation(hToken, tic, ptu, dwTokenUserLength,
    dwReturnLength) then
  begin
    if GetLastError = ERROR_INSUFFICIENT_BUFFER then
    begin
      ptu := HeapAlloc(GetProcessHeap, HEAP_ZERO_MEMORY, dwReturnLength);
      if ptu = nil then Exit;
      dwTokenUserLength := dwReturnLength;
      dwReturnLength    := 0;

      if not GetTokenInformation(hToken, tic, ptu, dwTokenUserLength,
        dwReturnLength) then Exit;
    end
    else
      Exit;
  end;

  if not ConvertSid((PTokenUser(ptu).User).Sid, pszSid, dwBufferLen) then Exit;

  if not HeapFree(GetProcessHeap, 0, ptu) then Exit;

  Result := True;
end;

function GetCurrentUserSid: string;
var
  hAccessToken: THandle;
  bSuccess: BOOL;
  dwBufferLen: DWORD;
  szSid: array[0..260] of Char;
begin
  Result := '';

  bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True,
    hAccessToken);
  if not bSuccess then
  begin
    if GetLastError = ERROR_NO_TOKEN then
      bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY,
        hAccessToken);
  end;
  if bSuccess then
  begin
    ZeroMemory(@szSid, SizeOf(szSid));
    dwBufferLen := SizeOf(szSid);

    if ObtainTextSid(hAccessToken, szSid, dwBufferLen) then
      Result := szSid;
    CloseHandle(hAccessToken);
  end;
end;
// ---------------------------------------------------------------------------

// LISTVIEW FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function to add items to ListView
 * Example: AddSubItemsToItemByName(ListView1, 'Example Item', ['SubItem1', 'SubItem2']);
 * }
procedure AddSubItemsToItemByName(ListView: TListView; const ItemName: string; const SubItems: array of string);
var
  i, j: Integer;
  Item: TListItem;
  Exists: Boolean;
begin
  Exists := False;

  // Iterate through all items to find a match by name
  for i := 0 to ListView.Items.Count - 1 do
  begin
    Item := ListView.Items[i];
    if Item.Caption = ItemName then
    begin
      Exists := True;

      // Add new subitems to the existing item's SubItems
      for j := Low(SubItems) to High(SubItems) do
        Item.SubItems.Add(SubItems[j]);

      Break; // Stop searching after finding the first match
    end;
  end;

  // If no matching item was found, create a new item
  if not Exists then
  begin
    Item := ListView.Items.Add;
    Item.Caption := ItemName; // Set the name of the new item
    for j := Low(SubItems) to High(SubItems) do
      Item.SubItems.Add(SubItems[j]);
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get subitems from ListView
 * Result Add all subitems from seelct item to TStrinList
 * }
function GetSubItemsFromItemName(ListView: TListView; const ItemName: string): TStringList;
var
  i: Integer;
  ListItem: TListItem;
  SubItemList: TStringList;
begin
  SubItemList := TStringList.Create;
  try
    for i := 0 to ListView.Items.Count - 1 do
    begin
      ListItem := ListView.Items[i];
      if ListItem.Caption = ItemName then
      begin
        SubItemList.AddStrings(ListItem.SubItems);
        Break;
      end;
    end;
    Result := SubItemList;
  except
    SubItemList.Free;
    raise;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to delete items to ListView
 * }
procedure DeleteItemByName(ListView: TListView; const ItemName: string);
var
  i: Integer;
begin
  for i := 0 to ListView.Items.Count - 1 do
  begin
    if ListView.Items[i].Caption = ItemName then
    begin
      ListView.Items.Delete(i); // Delete the matching item
      Exit; // Exit after deleting the item to avoid accessing an invalid index
    end;
  end;
end;
// ---------------------------------------------------------------------------

// DRIVE FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function to extract Drive letter from file
 * }
function CurDrvFile(sFileName: String): Char;
var
  s1: string;
  s2: Char;
begin
  s1 := ExtractFileDrive(sFileName);
  s2 := s1[1];
  CurDrvFile := s2;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to extract volume location: C: => \Device\HarddiskVolume1\
 * }
function GetQueryDosDevice(sDeviceName: LPCWSTR): String;
var
 arrCh : array [0..MAX_PATH] of char;
begin
if QueryDosDevice(sDeviceName, arrCh, MAX_PATH) <> 0 then
   Result := arrCh;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to extract device volume: C:\file.exe=>\Device\HarddiskVolume1\
 * }
function GetDiskVolume(sFileName: String): String;
var
 tempString: LPCWSTR;
begin
 tempString := PWideChar(WideString(CurDrvFile(sFileName)+':'));
 Result := GetQueryDosDevice(tempString);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to remove drive form string C:\file.exe => \file.exe
 * }
function RemoveDriveFromFile(sFileName: String): String;
begin
 Result := StringReplace(sFileName, CurDrvFile(sFileName)+':', '', [rfReplaceAll]);
end;
// ---------------------------------------------------------------------------

// TSTRINGS FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function to find String in TStrings
 * @return Success Item Index
 * }
function FindString(List: TStrings; s: string): Integer;
var
  i: Integer;
begin
  i := 0;
  while (i < List.Count) and (List[i] <> s) do
    inc(i);
  Result := i;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to convert String to List
 * @Example: String "aa;bb" = aa
                              bb
 * }
procedure StrToList(const S, Sign: string; SList: TStrings);
var
  CurPos: integer;
  CurStr: string;
begin
  SList.clear;
  SList.BeginUpdate();
  try
    CurStr := S;
    repeat
      CurPos := Pos(Sign, CurStr);
      if (CurPos > 0) then
      begin
        SList.Add(Copy(CurStr, 1, Pred(CurPos)));
        CurStr := Trim(Copy(CurStr, CurPos + Length(Sign),
          Length(CurStr) - CurPos - Length(Sign) + 1));
      end
      else
        SList.Add(CurStr);
    until CurPos = 0;
  finally
    SList.EndUpdate();
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to find String in TStrings with Case sensitive, best with False
 * @return Success Item Index
 * }
function FindStringInStringList(sList: TStringList; const SearchStr: string; CaseSensitive: Boolean = False): Integer;
var
  i: Integer;
  ItemText, TargetText: string;
begin
  Result := -1; // Default: not found

  // Prepare the search string if case-insensitive search is required
  if not CaseSensitive then
    TargetText := LowerCase(SearchStr)
  else
    TargetText := SearchStr;

  // Iterate through the items in the list box
  for i := 0 to sList.Count - 1 do
  begin
    ItemText := sList[i];
    if not CaseSensitive then
      ItemText := LowerCase(ItemText);

    if ItemText = TargetText then
    begin
      Result := i;
      Exit;
    end;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get the running all process from System to TStrings
 * }
procedure ProcessToList(MyList: TStrings);
var
  SnapshotHandle: THandle;
  ProcessEntry: TProcessEntry32;
begin
  MyList.Clear;
  SnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if SnapshotHandle <> INVALID_HANDLE_VALUE then
  begin
    ProcessEntry.dwSize := SizeOf(ProcessEntry);
    if Process32First(SnapshotHandle, ProcessEntry) then
    begin
      repeat
       if Pos('.exe', ExtractFileName(ProcessEntry.szExeFile)) <> 0 then
        MyList.Add(ExtractFileName(ProcessEntry.szExeFile));
      until not Process32Next(SnapshotHandle, ProcessEntry);
    end;
    CloseHandle(SnapshotHandle);
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to remove dublicate in ListBox
 * }
procedure RemoveDuplicateItems(ListBox: TListBox);
var
  i, j: Integer;
begin
  if ListBox.Items.Count = 0 then
    Exit;

  for i := ListBox.Items.Count - 1 downto 0 do
  begin
    for j := i - 1 downto 0 do
    begin
      if SameText(ListBox.Items[i], ListBox.Items[j]) then
      begin
        ListBox.Items.Delete(i);
        Break;
      end;
    end;
  end;
end;
// ---------------------------------------------------------------------------

// FILENAME FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function to run any application from system
 * @return ProcessID
 * }
function RunApplication(const AExecutableFile, AParameters, AWorkingDir : string;
  const AShowOption: Integer = SW_SHOWNORMAL): Integer;
var
  _SEInfo: TShellExecuteInfo;
begin
  Result := 0;
  FillChar(_SEInfo, SizeOf(_SEInfo), 0);
  _SEInfo.cbSize := SizeOf(TShellExecuteInfo);
  _SEInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
  // _SEInfo.Wnd := Application.Handle;
  _SEInfo.lpFile := PChar(AExecutableFile);
  _SEInfo.lpDirectory := PChar(AWorkingDir);
  _SEInfo.lpParameters := PChar(AParameters);
  _SEInfo.nShow := AShowOption;
  if ShellExecuteEx(@_SEInfo) then
  begin
    WaitForInputIdle(_SEInfo.hProcess, 3000);
    Result := GetProcessID(_SEInfo.hProcess);
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to  open explorer.exe with location of the filename
 * }
procedure OpenFileLocation(FileName: TFileName);
begin
  ShellExecute(Application.Handle, 'OPEN', PChar('explorer.exe'),
           PChar('/select, "' + FileName + '"'), nil, SW_NORMAL);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to open FileBrowser to select filename or folder from system
 * @return Success
 * }
function SelectExe(const Caption: string; var Directory, Name: string): boolean;
var
  lpItemID : PItemIDList;
  BrowseInfo : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  Result:= false;
  FillChar(BrowseInfo, sizeof(TBrowseInfo), #0);
 with BrowseInfo do begin
  hwndOwner := Application.Handle;
  pszDisplayName := @DisplayName;
  lpszTitle := PChar(Caption);
  ulFlags := BIF_RETURNONLYFSDIRS or BIF_BROWSEINCLUDEFILES or BIF_USENEWUI;
 end;
  lpItemID := SHBrowseForFolder(BrowseInfo);
 if lpItemId <> nil then
  begin
   SHGetPathFromIDList(lpItemID, TempPath);
   Result := lpItemID <> nil;
  if Result then
   begin
    Directory := TempPath;
    Name := DisplayName;
   end;
  GlobalFreePtr(lpItemID);
 end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to create log file
 * }
procedure LogWrite(LogType: String; LogFrom: String; LogMessage: String);
var
  FileName: string;
  LogFile: TextFile;
begin
  Filename:= ExtractFilePath(Application.ExeName) + CurrentUserName + '.log';
  AssignFile (LogFile, Filename);
  if FileExists (FileName) then
   Append (LogFile) // open existing file
  else
   Rewrite (LogFile); // create a new one
    try
     // write to the file and show error
     Writeln (LogFile, DateTimeToStr (Now) + ', ' + LogType + ', ' + LogFrom + ', "' + LogMessage + '"');
    finally
     // close the file
     CloseFile (LogFile);
    end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get bool to string
 * @return String of Bool
 * }
function ABBoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;
procedure VerifyBoolStrArray;
begin
  if Length(TrueBoolStrs) = 0 then
  begin
    SetLength(TrueBoolStrs, 1);
    TrueBoolStrs[0] := DefaultTrueBoolStr;
  end;
  if Length(FalseBoolStrs) = 0 then
  begin
    SetLength(FalseBoolStrs, 1);
    FalseBoolStrs[0] := DefaultFalseBoolStr;
  end;
end;

const
  cSimpleBoolStrs: array [boolean] of String = ('False', 'True');
begin
  if UseBoolStrs then
  begin
    VerifyBoolStrArray;
    if B then
      Result := TrueBoolStrs[0]
    else
      Result := FalseBoolStrs[0];
  end
  else
    Result := cSimpleBoolStrs[Ord(B) <> 0];
end;
// ---------------------------------------------------------------------------
{ **
 * Function to rename section in INI
 * @return of True
 * }
function RenameSection(IniFile:TCustomIniFile; FromName,ToName:string):boolean;
var List:   TStrings;
    n,v:    string;
    i:      integer;
begin
  if IniFile.SectionExists(ToName) then Exit(False);
  if not IniFile.SectionExists(FromName) then Exit(False);

  List:=TStringList.Create;
  try
    IniFile.ReadSectionValues(FromName,List);
    for i:=0 to List.count-1 do begin
      n:=List.Names[i];
      v:=List.ValueFromIndex[i];
      IniFile.WriteString(ToName,n,v);
    end;
  finally
    List.free;
  end;
  IniFile.EraseSection(FromName);
  IniFile.UpdateFile;
  Result:=True;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get all process list from INI to TabControl
 * }
procedure ScanProcessListFromIni(Config: TMemIniFile; TabList: TTabControl);
begin
 Config.ReadSections(TabList.Tabs);
 if Config.SectionExists('General') then
 TabList.Tabs.Delete(FindString(TabList.Tabs,'General'));
 if TabList.Tabs.Count <> -1 then TabList.TabIndex := 0;
end;
// ---------------------------------------------------------------------------

// ENCRYPTION FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function to encrypt String
 * @return AnsiString
 * }
function Encode(Source, Key: AnsiString): AnsiString;
var
  i: Integer;
  s: Byte;
begin
  Result := '';
  for i := 1 to Length(Source) do
  begin
    if Length(Key) > 0 then
      s := Byte(Key[1 + ((i - 1) mod Length(Key))]) xor Byte(Source[i])
    else
      s := Byte(Source[i]);
    Result := Result + AnsiLowerCase(IntToHex(s, 2));
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to decrypt String
 * @return AnsiString
 * }
function Decode(Source, Key: AnsiString): AnsiString;
var
  i: Integer;
  s: AnsiChar;
begin
  Result := '';
  for i := 0 to Length(Source) div 2 - 1 do
  begin
    s := AnsiChar(StrToIntDef('$' + Copy(Source, (i * 2) + 1, 2), Ord(' ')));
    if Length(Key) > 0 then
      s := AnsiChar(Byte(Key[1 + (i mod Length(Key))]) xor Byte(s));
    Result := Result + s;
  end;
end;
// ---------------------------------------------------------------------------

// IMAGES FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function to add language images from resource to ImageList
 * }
procedure LangImgFromRes(ImageList: TImageList);
var
 TempImage: TPNGImage;
 Bitmap: TBitmap;
begin
 TempImage := TPNGImage.Create;
 Bitmap := TBitmap.Create;
  try
   TempImage.LoadFromResourceName(hInstance,'lng_usa');
   Bitmap.Assign(TempImage);
   ImageList.Add(Bitmap, nil);

   TempImage.LoadFromResourceName(hInstance,'lng_russian');
   Bitmap.Assign(TempImage);
   ImageList.Add(Bitmap, nil);

   TempImage.LoadFromResourceName(hInstance,'lng_romania');
   Bitmap.Assign(TempImage);
   ImageList.Add(Bitmap, nil);
  finally
   FreeAndNil(TempImage);
   FreeAndNil(Bitmap);
  end;
end;
// ---------------------------------------------------------------------------
end.
