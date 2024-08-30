unit Utils;

interface

uses Windows, Forms, System.SysUtils, Vcl.StdCtrls, System.Classes, ShellAPI,
     ShlObj, WinSvc, TlHelp32, System.IOUtils, Registry, System.Types, IniFiles,
     ComCtrls;

type //for GetWinHandleFromProcId
  TEnumData = record
    WHdl: HWND;
    WPid: DWORD;
    WTitle: String;
  end;
  PEnumData = ^TEnumData;

function FindString(List: TStrings; s: string): Integer;
procedure StrToList(const S, Sign: string; SList: TStrings);
function IsExistFromList(ExeName: String; List: TListBox): Boolean;
function RunApplication(const AExecutableFile, AParameters, AWorkingDir : string;
  const AShowOption: Integer = SW_SHOWNORMAL): Integer;
procedure OpenFileLocation(FileName: TFileName);
function SelectExe(const Caption: string; var Directory, Name: string): boolean;
function GetLocalComputerName(NameType: TComputerNameFormat = ComputerNameDnsHostname): string;
function CurrentUserName:String;
procedure LogWrite(LogType: String; LogFrom: String; LogMessage: String);
function ABBoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;
procedure ScheduleRunAtStartup(nCreate: Boolean; const ATaskName: string; const AFileName: string;
  const AUserAccount: string);
function Encode(Source, Key: AnsiString): AnsiString;
function Decode(Source, Key: AnsiString): AnsiString;
function EnumWindowsProcMatchPID(WHdl: HWND; EData: PEnumData): bool; stdcall;
function GetWinHandleFromProcId(ProcId: DWORD): HWND;
function IsProcessRunning(const AProcessName: string): Boolean;
procedure ProcessToList(MyList: TListBox);
function ServiceStart(aMachineName,aServiceName: string): boolean;
function ServiceStop(aMachineName, aServiceName: string): boolean;
function ServiceRunning(sMachine, sService: PChar): Boolean;
function GetSpecialPath( CSIDL: Word ): PChar;
procedure ClearDPS;
function CurDrvFile(sFileName: String): Char;
function GetQueryDosDevice(sDeviceName: LPCWSTR): String;
function GetDiskVolume(sFileName: String): String;
function RemoveDriveFromFile(sFileName: String): String;
function RemoveFromRegistryWithMui(MyRoot: HKEY; Key, Name: String): Integer;
function RemoveFromRegistryWithLocation(MyRoot: HKEY; Key,Name: String): Integer;
procedure RemoveAllFromRegistry(AppName,AppLocation: String);
function DeleteFilesFromFolder(sFiles: String; const FolderPath: string): Boolean;
procedure DeleteFilesFromSysMaps(IntLocation: Integer; ProcessNames, FileLocation: String);
function RenameSection(IniFile:TCustomIniFile; FromName,ToName:string):boolean;
procedure ScanProcessListFromIni(Config: TMemIniFile; List: TTabControl);

implementation

uses Unit1, SPGetSid;

function FindString(List: TStrings; s: string): Integer;
var
  i: Integer;
begin
  i := 0;
  while (i < List.Count) and (List[i] <> s) do
    inc(i);
  Result := i;
end;

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

function IsExistFromList(ExeName: String; List: TListBox): Boolean;
begin
  Result := False;
  List.ItemIndex := FindString(List.Items,ExeName);
  if List.ItemIndex <> -1 then
   begin
    Result := True;
   end;
end;

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

procedure OpenFileLocation(FileName: TFileName);
begin
  ShellExecute(Application.Handle, 'OPEN', PChar('explorer.exe'),
           PChar('/select, "' + FileName + '"'), nil, SW_NORMAL);
end;

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

function GetLocalComputerName(NameType: TComputerNameFormat = ComputerNameDnsHostname): string;
var
  len: DWORD;
begin
  len:= 0;
  GetComputerNameEx(NameType, nil, len);
  SetLength(Result, len - 1);
  if not GetComputerNameEx(NameType, PChar(Result), len) then RaiseLastOSError;
end;

function CurrentUserName:String;
var
  UserName: array[0..127] of Char;
  Size:DWord;
begin
  Size:=SizeOf(UserName);
  GetUserName(UserName,Size);
  Result:=UserName;
end;

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

procedure ProcessToList(MyList: TListBox);
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
        MyList.Items.Add(ExtractFileName(ProcessEntry.szExeFile));
      until not Process32Next(SnapshotHandle, ProcessEntry);
    end;
    CloseHandle(SnapshotHandle);
  end;
end;
{
 Clear data
}
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

function ServiceRunning(sMachine, sService: PChar): Boolean;
begin
  Result := SERVICE_RUNNING = ServiceGetStatus(sMachine, sService);
end;

function GetSpecialPath( CSIDL: Word ): PChar;
var
  s: string;
begin
   SetLength( s, MAX_PATH );
   if not SHGetSpecialFolderPath( 0, PChar( s ), CSIDL, false ) then s := '';
   Result := PChar( s );
end;

procedure ClearDPS;
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

//Extract Drive letter from file
function CurDrvFile(sFileName: String): Char;
var
  s1: string;
  s2: Char;
begin
  s1 := ExtractFileDrive(sFileName);
  s2 := s1[1];
  CurDrvFile := s2;
end;

//Extract volume location: C: => \Device\HarddiskVolume1\
function GetQueryDosDevice(sDeviceName: LPCWSTR): String;
var
 arrCh : array [0..MAX_PATH] of char;
begin
if QueryDosDevice(sDeviceName, arrCh, MAX_PATH) <> 0 then
   Result := arrCh;
end;

//Extract device volume: C:\file.exe=>\Device\HarddiskVolume1\
function GetDiskVolume(sFileName: String): String;
var
 tempString: LPCWSTR;
begin
 tempString := PWideChar(WideString(CurDrvFile(sFileName)+':'));
 Result := GetQueryDosDevice(tempString);
end;

//Example C:\file.exe => \file.exe
function RemoveDriveFromFile(sFileName: String): String;
begin
 Result := StringReplace(sFileName, CurDrvFile(sFileName)+':', '', [rfReplaceAll]);
end;

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

procedure RemoveAllFromRegistry(AppName,AppLocation: String);
var
 TempList: TStringList;
 I: Integer;
begin
TempList := TStringList.Create;
try
 TempList.Add(ParamStr(0));
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
  RemoveFromRegistryWithLocation(HKEY_LOCAL_MACHINE,'\SYSTEM\ControlSet001\Services\bam\State\UserSettings\'+GetCurrentUserSid+'\',GetDiskVolume(TempList[I])+RemoveDriveFromFile(TempList[I]));
  RemoveFromRegistryWithLocation(HKEY_LOCAL_MACHINE,'\SYSTEM\CurrentControlSet\Services\bam\State\UserSettings\'+GetCurrentUserSid+'\',GetDiskVolume(TempList[I])+RemoveDriveFromFile(TempList[I]));
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

//------------------------------------------------------------------------------

function RenameSection(IniFile:TCustomIniFile; FromName,ToName:string):boolean; //Success returns True.
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

procedure ScanProcessListFromIni(Config: TMemIniFile; List: TTabControl);
var
 TempStrings: TStringList;
begin
TempStrings := TStringList.Create;
 try
  Config.ReadSections(TempStrings);
  TempStrings.Sort;
  List.Tabs := TempStrings;
  List.Tabs.Delete(FindString(List.Tabs,'General'));
  if List.Tabs.Count <> -1 then List.TabIndex := 0;
 finally
  TempStrings.Free;
 end;
end;

end.
