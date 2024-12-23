// Don't Panic!
// Copyleft 2006-2015 Adrian-Costin Tundrea
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.fsf.org/licensing/licenses/>.
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
unit SystemUtils;

interface

uses MMDevApi, Windows, Classes, Registry, SysUtils, ActiveX, TlHelp32, ShlObj,
     MMSystem, WinInet, ShellApi, Messages, Variants, Generics.Collections,
     Vcl.ComCtrls;

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
function DisableTaskManager(Status: Boolean): Integer;
// function GetTaskbarSizeAndPosition(TaskbarLeft, TaskbarTop, TaskbarWidth, TaskbarHeight: Integer): Integer;
// ---------------------------------------------------------------------------

// WINDOWS TASK SCHEDULING FUNCTIONS
// ---------------------------------------------------------------------------
function GetProcessID(ProcessExeFilename: String): Integer;
function GetRunningCountForProcess(ProcessExeFilename: String): Integer;
function KillProcess(ProcessExeFilename: String): Integer;
function CloseWindowsForProcess(ProcessExeFilename: String): Integer;
function HideWindowsForProcess(ProcessExeFilename: String): Integer;
function MinimizeWindowsForProcess(ProcessExeFilename: String): Integer;
function RestoreWindowsForProcess(ProcessExeFilename: String): Integer;
function KeywordsActionProcess(KeywordsList: TStringList; CaseSensitive: Boolean; ActionType: Integer): Integer;
function ShowWindowInTaskbar(hWndOwner: HWnd): Integer;
function ShowAllHiddenWindowsInTaskbar(ProcessExeFilename: String): Integer;
function HideWindowFromTaskbar(hWndOwner: HWnd): Integer;
// ---------------------------------------------------------------------------

// SOUND CONTROL FUNCTIONS
// ---------------------------------------------------------------------------
function SetMasterMute(MuteValue: Boolean): Integer;
// ---------------------------------------------------------------------------

// HISTORY CLEANING FUNCTIONS
// ---------------------------------------------------------------------------
function DeleteFolderContents(FolderPath: String): Integer;
function DeleteInternetExplorerTemporaryFiles(): Integer;
function DeleteInternetExplorerTypedURLs(): Integer;
function DeleteRecentFiles(): Integer;
function DeleteRecycleBinFiles(): Integer;

// ---------------------------------------------------------------------------
implementation

uses Processes;

var
  EndpointVolume: IAudioEndpointVolume = nil;
  WindowsHandleList, HiddenWindowsHandleList: TList<Cardinal>;
// ---------------------------------------------------------------------------

                             // GENERAL FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function for add running processes to ListView
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
 * Function for blocking access to Windows Task Manager
 * @return Success (0) or error code (1)
 * }
function DisableTaskManager(Status: Boolean): Integer;
var
  Registry: TRegistry;
begin
  try
    Registry := TRegistry.Create();
    Registry.RootKey := HKEY_CURRENT_USER;
    Registry.OpenKey('Software\Microsoft\Windows\CurrentVersion\Policies\System', True);
    if Status then begin
      Registry.WriteString('DisableTaskMgr', '1');
    end else begin
      Registry.DeleteValue('DisableTaskMgr');
    end;
    Registry.CloseKey();
    Registry.Free();
    Result := 0;
  except
    Result := 1;
  end;
end;
// ---------------------------------------------------------------------------
{ TODO : Check the size and position of the taskbar and set the default Panic Button position accordingly! (not at a fixed position) }
// function GetTaskbarSizeAndPosition(TaskbarLeft, TaskbarTop, TaskbarWidth, TaskbarHeight: Integer): Integer; // Function for getting the size and position of the taskbar!
// var
// Data: TAppBarData;
// begin
// Data.HWnd := FindWindow('Shell_TrayWnd', nil);
// Data.cbSize := SizeOf(TAppBarData);
// if (Data.HWnd <> 0) then begin
// if (SHAppBarMessage(ABM_GETTASKBARPOS, Data) = 1) then begin
// TaskbarLeft := Data.rc.Left;
// TaskbarTop := Data.rc.Top;
// TaskbarWidth := Data.rc.Right - Data.rc.Left;
// TaskbarHeight := Data.rc.Bottom - Data.rc.Top;
// Result := 1;
// end else begin
// Result := 0;
// end;
// end else begin
// Result := 0;
// end;
// end;
// ---------------------------------------------------------------------------

// TASK AND WINDOWS MANAGER FUNCTIONS
// ---------------------------------------------------------------------------
{ **
 * Function for finding the PID of a certain process
 * @param String Filename of the executable that generated the process
 * @return PID of the process (if value is not 0) or 0 if there has been an error
 * }
function GetProcessID(ProcessExeFilename: String): Integer;
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
    ProcessID1 := GetProcessID(ProcessExeFilename);
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

function HideWindowsForProcess(ProcessExeFilename: String): Integer;
var
  I, ProcessID1, ProcessID2: Integer;
  L: integer;
  Item: TListItem;
begin
  try
    WindowsHandleList := TList<Cardinal>.Create();
    if (HiddenWindowsHandleList = nil) then begin
      HiddenWindowsHandleList := TList<Cardinal>.Create();
    end;
  // Finding out the PID of the selected task!
    ProcessID1 := GetProcessID(ProcessExeFilename);
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
        HiddenWindowsHandleList.Add(WindowsHandleList[I]);
        AddSubItemsToItemByName(ProcessesForm.ProcessListView,ProcessExeFilename,[IntToStr(WindowsHandleList[I])]);
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
    ProcessID1 := GetProcessID(ProcessExeFilename);
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
    ProcessID1 := GetProcessID(ProcessExeFilename);
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
function KeywordsActionProcess(KeywordsList: TStringList; CaseSensitive: Boolean; ActionType: Integer): Integer;
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
          HideWindowsForProcess(ExtractFileName(FProcessEntry32.szExeFile));
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
function ShowAllHiddenWindowsInTaskbar(ProcessExeFilename: String): Integer;
var
  I: Integer;
  SubItems: TStringList;
begin
  try
    {Show all hidden processes
    for I := 0 to HiddenWindowsHandleList.Count - 1 do begin
      ShowWindowInTaskbar(HiddenWindowsHandleList[I]);
    end;
    HiddenWindowsHandleList.Clear();
    }
    SubItems := GetSubItemsFromItemName(ProcessesForm.ProcessListView, ProcessExeFilename);
     try
      if SubItems.Count > 0 then
       begin
        for i := 0 to SubItems.Count - 1 do
        ShowWindowInTaskbar(StrToInt(SubItems[i]));
       end;
     finally
      SubItems.Free;
     end;
     DeleteItemByName(ProcessesForm.ProcessListView,ProcessExeFilename);
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
 * Function for deleting Internet Explorer temporary files (cache & cookies)
 * @return Success (0) or error code (1)
 * }
function DeleteInternetExplorerTemporaryFiles(): Integer;
var
  lpEntryInfo: PInternetCacheEntryInfo;
  hCacheDir: LongWord;
  dwEntrySize: LongWord;
begin
  try
    dwEntrySize := 0;
    FindFirstUrlCacheEntry(nil, TInternetCacheEntryInfo(nil^), dwEntrySize);
    GetMem(lpEntryInfo, dwEntrySize);
    if (dwEntrySize > 0) then begin
      lpEntryInfo^.dwStructSize := dwEntrySize;
    end;
    hCacheDir := FindFirstUrlCacheEntry(nil, lpEntryInfo^, dwEntrySize);
    if (hCacheDir <> 0) then begin
      repeat
        DeleteUrlCacheEntry(lpEntryInfo^.lpszSourceUrlName);
        FreeMem(lpEntryInfo, dwEntrySize);
        dwEntrySize := 0;
        FindNextUrlCacheEntry(hCacheDir, TInternetCacheEntryInfo(nil^), dwEntrySize);
        GetMem(lpEntryInfo, dwEntrySize);
        if (dwEntrySize > 0) then begin
          lpEntryInfo^.dwStructSize := dwEntrySize;
        end;
      until not FindNextUrlCacheEntry(hCacheDir, lpEntryInfo^, dwEntrySize);
    end;
    FreeMem(lpEntryInfo, dwEntrySize);
    FindCloseUrlCache(hCacheDir);
    Result := 1;
  except
    Result := 0;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function deleting Internet Explorer typed URLs
 * @return Success (0) or error code (1)
 * }
function DeleteInternetExplorerTypedURLs(): Integer;
var
  Registry: TRegistry;
  Key: String;
begin
  Registry := TRegistry.Create();
  Registry.RootKey := HKEY_CURRENT_USER;
  Key := 'Software\Microsoft\Internet Explorer\TypedURLs';
  if Registry.DeleteKey(Key) then begin
    Registry.CreateKey(Key);
  end else begin
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Key := 'Software\Microsoft\Internet Explorer\TypedURLs';
    if Registry.DeleteKey(Key) then begin
      Registry.CreateKey(Key);
    end;
  end;
  Registry.CloseKey();
  Registry.Free();
  Result := 0;
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

end.
