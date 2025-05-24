unit SystemUtils;

interface

uses MMDevApi, Windows, Classes, Registry, SysUtils, ActiveX, TlHelp32, ShlObj,
     MMSystem, WinInet, ShellApi, Messages, Variants, Generics.Collections,
     ComCtrls, WinSvc, IniFiles, Forms, ComObj, StdCtrls, Types, IOUtils,
     Controls, PngImage, Graphics, Menus, CommCtrl, ExtCtrls, AudioProcessController;

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
// GetShellLinkInfo
type
 TShellLinkInfo = record
  PathName: string;
  Arguments: string;
  Description: string;
  WorkingDirectory: string;
  IconLocation: string;
  IconIndex: integer;
  ShowCmd: integer;
  HotKey: word;
 end;

// ---------------------------------------------------------------------------
// Get ID from system
const
  FOLDERID_AddNewPrograms: TGUID                 = '{DE61D971-5EBC-4F02-A3A9-6C82895E5C04}';
  FOLDERID_AdminTools: TGUID                     = '{724EF170-A42D-4FEF-9F26-B60E846FBA4F}';
  FOLDERID_AppUpdates: TGUID                     = '{A305CE99-F527-492B-8B1A-7E76FA98D6E4}';
  FOLDERID_CDBurning: TGUID                      = '{9E52AB10-F80D-49DF-ACB8-4330F5687855}';
  FOLDERID_ChangeRemovePrograms: TGUID           = '{DF7266AC-9274-4867-8D55-3BD661DE872D}';
  FOLDERID_CommonAdminTools: TGUID               = '{D0384E7D-BAC3-4797-8F14-CBA229B392B5}';
  FOLDERID_CommonOEMLinks: TGUID                 = '{C1BAE2D0-10DF-4334-BEDD-7AA20B227A9D}';
  FOLDERID_CommonPrograms: TGUID                 = '{0139D44E-6AFE-49F2-8690-3DAFCAE6FFB8}';
  FOLDERID_CommonStartMenu: TGUID                = '{A4115719-D62E-491D-AA7C-E74B8BE3B067}';
  FOLDERID_CommonStartup: TGUID                  = '{82A5EA35-D9CD-47C5-9629-E15D2F714E6E}';
  FOLDERID_CommonTemplates: TGUID                = '{B94237E7-57AC-4347-9151-B08C6C32D1F7}';
  FOLDERID_ComputerFolder: TGUID                 = '{0AC0837C-BBF8-452A-850D-79D08E667CA7}';
  FOLDERID_ConflictFolder: TGUID                 = '{4BFEFB45-347D-4006-A5BE-AC0CB0567192}';
  FOLDERID_ConnectionsFolder: TGUID              = '{6F0CD92B-2E97-45D1-88FF-B0D186B8DEDD}';
  FOLDERID_Contacts: TGUID                       = '{56784854-C6CB-462B-8169-88E350ACB882}';
  FOLDERID_ControlPanelFolder: TGUID             = '{82A74AEB-AEB4-465C-A014-D097EE346D63}';
  FOLDERID_Cookies: TGUID                        = '{2B0F765D-C0E9-4171-908E-08A611B84FF6}';
  FOLDERID_Desktop: TGUID                        = '{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}';
  FOLDERID_DeviceMetadataStore: TGUID            = '{5CE4A5E9-E4EB-479D-B89F-130C02886155}';
  FOLDERID_Documents: TGUID                      = '{FDD39AD0-238F-46AF-ADB4-6C85480369C7}';
  FOLDERID_DocumentsLibrary: TGUID               = '{7B0DB17D-9CD2-4A93-9733-46CC89022E7C}';
  FOLDERID_Downloads: TGUID                      = '{374DE290-123F-4565-9164-39C4925E467B}';
  FOLDERID_Favorites: TGUID                      = '{1777F761-68AD-4D8A-87BD-30B759FA33DD}';
  FOLDERID_Fonts: TGUID                          = '{FD228CB7-AE11-4AE3-864C-16F3910AB8FE}';
  FOLDERID_Games: TGUID                          = '{CAC52C1A-B53D-4EDC-92D7-6B2E8AC19434}';
  FOLDERID_GameTasks: TGUID                      = '{054FAE61-4DD8-4787-80B6-090220C4B700}';
  FOLDERID_History: TGUID                        = '{D9DC8A3B-B784-432E-A781-5A1130A75963}';
  FOLDERID_HomeGroup: TGUID                      = '{52528A6B-B9E3-4ADD-B60D-588C2DBA842D}';
  FOLDERID_ImplicitAppShortcuts: TGUID           = '{BCB5256F-79F6-4CEE-B725-DC34E402FD46}';
  FOLDERID_InternetCache: TGUID                  = '{352481E8-33BE-4251-BA85-6007CAEDCF9D}';
  FOLDERID_InternetFolder: TGUID                 = '{4D9F7874-4E0C-4904-967B-40B0D20C3E4B}';
  FOLDERID_Libraries: TGUID                      = '{1B3EA5DC-B587-4786-B4EF-BD1DC332AEAE}';
  FOLDERID_Links: TGUID                          = '{BFB9D5E0-C6A9-404C-B2B2-AE6DB6AF4968}';
  FOLDERID_LocalAppData: TGUID                   = '{F1B32785-6FBA-4FCF-9D55-7B8E7F157091}';
  FOLDERID_LocalAppDataLow: TGUID                = '{A520A1A4-1780-4FF6-BD18-167343C5AF16}';
  FOLDERID_LocalizedResourcesDir: TGUID          = '{2A00375E-224C-49DE-B8D1-440DF7EF3DDC}';
  FOLDERID_Music: TGUID                          = '{4BD8D571-6D19-48D3-BE97-422220080E43}';
  FOLDERID_MusicLibrary: TGUID                   = '{2112AB0A-C86A-4FFE-A368-0DE96E47012E}';
  FOLDERID_NetHood: TGUID                        = '{C5ABBF53-E17F-4121-8900-86626FC2C973}';
  FOLDERID_NetworkFolder: TGUID                  = '{D20BEEC4-5CA8-4905-AE3B-BF251EA09B53}';
  FOLDERID_OriginalImages: TGUID                 = '{2C36C0AA-5812-4B87-BFD0-4CD0DFB19B39}';
  FOLDERID_PhotoAlbums: TGUID                    = '{69D2CF90-FC33-4FB7-9A0C-EBB0F0FCB43C}';
  FOLDERID_Pictures: TGUID                       = '{33E28130-4E1E-4676-835A-98395C3BC3BB}';
  FOLDERID_PicturesLibrary: TGUID                = '{A990AE9F-A03B-4E80-94BC-9912D7504104}';
  FOLDERID_Playlists: TGUID                      = '{DE92C1C7-837F-4F69-A3BB-86E631204A23}';
  FOLDERID_PrintersFolder: TGUID                 = '{76FC4E2D-D6AD-4519-A663-37BD56068185}';
  FOLDERID_PrintHood: TGUID                      = '{9274BD8D-CFD1-41C3-B35E-B13F55A758F4}';
  FOLDERID_Profile: TGUID                        = '{5E6C858F-0E22-4760-9AFE-EA3317B67173}';
  FOLDERID_ProgramData: TGUID                    = '{62AB5D82-FDC1-4DC3-A9DD-070D1D495D97}';
  FOLDERID_ProgramFiles: TGUID                   = '{905E63B6-C1BF-494E-B29C-65B732D3D21A}';
  FOLDERID_ProgramFilesCommon: TGUID             = '{F7F1ED05-9F6D-47A2-AAAE-29D317C6F066}';
  FOLDERID_ProgramFilesCommonX64: TGUID          = '{6365D5A7-0F0D-45E5-87F6-0DA56B6A4F7D}';
  FOLDERID_ProgramFilesCommonX86: TGUID          = '{DE974D24-D9C6-4D3E-BF91-F4455120B917}';
  FOLDERID_ProgramFilesX64: TGUID                = '{6D809377-6AF0-444B-8957-A3773F02200E}';
  FOLDERID_ProgramFilesX86: TGUID                = '{7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E}';
  FOLDERID_Programs: TGUID                       = '{A77F5D77-2E2B-44C3-A6A2-ABA601054A51}';
  FOLDERID_Public: TGUID                         = '{DFDF76A2-C82A-4D63-906A-5644AC457385}';
  FOLDERID_PublicDesktop: TGUID                  = '{C4AA340D-F20F-4863-AFEF-F87EF2E6BA25}';
  FOLDERID_PublicDocuments: TGUID                = '{ED4824AF-DCE4-45A8-81E2-FC7965083634}';
  FOLDERID_PublicDownloads: TGUID                = '{3D644C9B-1FB8-4F30-9B45-F670235F79C0}';
  FOLDERID_PublicGameTasks: TGUID                = '{DEBF2536-E1A8-4C59-B6A2-414586476AEA}';
  FOLDERID_PublicLibraries: TGUID                = '{48daf80b-e6cf-4f4e-b800-0e69d84ee384}';
  FOLDERID_PublicMusic: TGUID                    = '{3214FAB5-9757-4298-BB61-92A9DEAA44FF}';
  FOLDERID_PublicPictures: TGUID                 = '{B6EBFB86-6907-413C-9AF7-4FC2ABF07CC5}';
  FOLDERID_PublicRingtones: TGUID                = '{E555AB60-153B-4D17-9F04-A5FE99FC15EC}';
  FOLDERID_PublicVideos: TGUID                   = '{2400183A-6185-49FB-A2D8-4A392A602BA3}';
  FOLDERID_QuickLaunch: TGUID                    = '{52A4F021-7B75-48A9-9F6B-4B87A210BC8F}';
  FOLDERID_Recent: TGUID                         = '{AE50C081-EBD2-438A-8655-8A092E34987A}';
  FOLDERID_RecordedTVLibrary: TGUID              = '{1A6FDBA2-F42D-4358-A798-B74D745926C5}';
  FOLDERID_RecycleBinFolder: TGUID               = '{B7534046-3ECB-4C18-BE4E-64CD4CB7D6AC}';
  FOLDERID_ResourceDir: TGUID                    = '{8AD10C31-2ADB-4296-A8F7-E4701232C972}';
  FOLDERID_Ringtones: TGUID                      = '{C870044B-F49E-4126-A9C3-B52A1FF411E8}';
  FOLDERID_RoamingAppData: TGUID                 = '{3EB685DB-65F9-4CF6-A03A-E3EF65729F3D}';
  FOLDERID_SampleMusic: TGUID                    = '{B250C668-F57D-4EE1-A63C-290EE7D1AA1F}';
  FOLDERID_SamplePictures: TGUID                 = '{C4900540-2379-4C75-844B-64E6FAF8716B}';
  FOLDERID_SamplePlaylists: TGUID                = '{15CA69B3-30EE-49C1-ACE1-6B5EC372AFB5}';
  FOLDERID_SampleVideos: TGUID                   = '{859EAD94-2E85-48AD-A71A-0969CB56A6CD}';
  FOLDERID_SavedGames: TGUID                     = '{4C5C32FF-BB9D-43B0-B5B4-2D72E54EAAA4}';
  FOLDERID_SavedSearches: TGUID                  = '{7D1D3A04-DEBB-4115-95CF-2F29DA2920DA}';
  FOLDERID_SEARCH_CSC: TGUID                     = '{EE32E446-31CA-4ABA-814F-A5EBD2FD6D5E}';
  FOLDERID_SEARCH_MAPI: TGUID                    = '{98EC0E18-2098-4D44-8644-66979315A281}';
  FOLDERID_SendTo: TGUID                         = '{8983036C-27C0-404B-8F08-102D10DCFD74}';
  FOLDERID_SidebarDefaultParts: TGUID            = '{7B396E54-9EC5-4300-BE0A-2482EBAE1A26}';
  FOLDERID_SidebarParts: TGUID                   = '{A75D362E-50FC-4FB7-AC2C-A8BEAA314493}';
  FOLDERID_StartMenu: TGUID                      = '{625B53C3-AB48-4EC1-BA1F-A1EF4146FC19}';
  FOLDERID_Startup: TGUID                        = '{B97D20BB-F46A-4C97-BA10-5E3608430854}';
  FOLDERID_SyncManagerFolder: TGUID              = '{43668BF8-C14E-49B2-97C9-747784D784B7}';
  FOLDERID_SyncResultsFolder: TGUID              = '{289A9A43-BE44-4057-A41B-587A76D7E7F9}';
  FOLDERID_SyncSetupFolder: TGUID                = '{0F214138-B1D3-4A90-BBA9-27CBC0C5389A}';
  FOLDERID_System: TGUID                         = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}';
  FOLDERID_SystemX86: TGUID                      = '{D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27}';
  FOLDERID_Templates: TGUID                      = '{A63293E8-664E-48DB-A079-DF759E0509F7}';
  FOLDERID_UserPinned: TGUID                     = '{9E3995AB-1F9C-4F13-B827-48B24B6C7174}';
  FOLDERID_UserProfiles: TGUID                   = '{0762D272-C50A-4BB0-A382-697DCD729B80}';
  FOLDERID_UserProgramFiles: TGUID               = '{5CD7AEE2-2219-4A67-B85D-6C9CE15660CB}';
  FOLDERID_UserProgramFilesCommon: TGUID         = '{BCBD3057-CA5C-4622-B42D-BC56DB0AE516}';
  FOLDERID_UsersFiles: TGUID                     = '{F3CE0F7C-4901-4ACC-8648-D5D44B04EF8F}';
  FOLDERID_UsersLibraries: TGUID                 = '{A302545D-DEFF-464B-ABE8-61C8648D939B}';
  FOLDERID_Videos: TGUID                         = '{18989B1D-99B5-455B-841C-AB7C74E4DDFC}';
  FOLDERID_VideosLibrary: TGUID                  = '{491E922F-5643-4AF4-A7EB-4E7A138D8174}';
  FOLDERID_Windows: TGUID                        = '{F38BF404-1D43-42F2-9305-67DE0B28FC23}';
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
function GetProcessID_(ProcessExeFilename: String): DWORD;
function TerminateProcessById(ProcessID: DWORD): Boolean;
function MinimizeWindowsForProcess(ProcessExeFilename: String): Integer;
function EnumWindowsProcMatchPID(WHdl: HWND; EData: PEnumData): bool; stdcall;
function GetWinHandleFromProcId(ProcId: DWORD): HWND;
function IsProcessRunning(const AFileName: string): Boolean;
function IsUWPProcess(const ExeName: string): Boolean;
// ---------------------------------------------------------------------------

// SOUND CONTROL FUNCTIONS
// ---------------------------------------------------------------------------
function SetMasterMute(MuteValue: Boolean): Integer;
procedure MuteForProcess(Config: TMemIniFile; Section, ProcessName: String;
                       Mute: Boolean; AudioController: TAudioProcessController);
// ---------------------------------------------------------------------------

// HISTORY CLEANING FUNCTIONS
// ---------------------------------------------------------------------------
function DeleteFolderContents(FolderPath: String): Integer;
function DeleteRecentFiles(): Integer;
function DeleteRecycleBinFiles(): Integer;
function IsRecycleBinEmpty: Boolean;
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

// COMPONENTS GENERAL FUNCTIONS
// ---------------------------------------------------------------------------
procedure AddSubItemsToItemByName(ListView: TListView; const ItemName: string; const SubItems: array of string);
function GetSubItemsFromItemName(ListView: TListView; const ItemName: string): TStringList;
procedure DeleteItemByName(ListView: TListView; const ItemName: string);
function ReadDirectory(List : TStrings; Config: TMemIniFile): Integer;
procedure DeleteAt(cbActive: TTabControl;idx: Integer);
procedure AddMenuItem(Menu: TMenuItem; Tabs: TTabControl; OnClick: TNotifyEvent);
procedure ChangeToNextTab(TabControl: TTabControl);
procedure AddButtonToToolbar(OnClick: TNotifyEvent; var bar: TToolBar; hint: string;
  caption: string; imageindex: Integer; addafteridx: integer = -1);
procedure ADDControlPanelList(ParentMenu: TMenuItem; Config: TMemIniFile; OnClick: TNotifyEvent);
procedure LoadMenuFromINI(Config, ListConfig: TMemIniFile; PopupMenu: TPopupMenu; ImageList: TImageList;
OnClick, OnDrivesClick, OnControlClick, OnNewControlClick, OnRecycleClick: TNotifyEvent);
function ButtonExists(ToolBar: TToolBar; Hint: string): Boolean;
procedure LoadToolButtons(ToolBar: TToolBar; Config: TMemIniFile; ImageList: TImageList;
  OnButtonClick: TNotifyEvent);
procedure AddToolButton(ToolBar: TToolBar; Hint, Caption: string; Config: TMemIniFile;
   ImageList: TImageList; OnButtonClick: TNotifyEvent);
procedure DeleteToolButton(ToolBar: TToolBar; Hint: string; Config: TMemIniFile;
  ImageList: TImageList; OnButtonClick: TNotifyEvent);
procedure AddItemToButtonPopup(ToolBar: TToolBar; Config: TMemIniFile; Form: TForm;
   OnButtonClick: TNotifyEvent);
procedure FlashWindow(FormHandle: HWND);
// ---------------------------------------------------------------------------

// DRIVE FUNCTIONS
// ---------------------------------------------------------------------------
function CurDrvFile(sFileName: String): Char;
function GetQueryDosDevice(sDeviceName: LPCWSTR): String;
function GetDiskVolume(sFileName: String): String;
function RemoveDriveFromFile(sFileName: String): String;
function DiskFloatToString(Number: Double;Units: Boolean): string;
function DiskFreeString(Drive: Char;Units: Boolean): string;
function DiskSizeString(Drive: Char;Units: Boolean): string;
procedure ADDListDrives(PopupMenu: TPopupMenu; OnClick: TNotifyEvent; sFree: String);
// ---------------------------------------------------------------------------

// TSTRINGS FUNCTIONS
// ---------------------------------------------------------------------------
function FindString(List: TStrings; s: string): Integer;
procedure StrToList(const S, Sign: string; SList: TStrings);
function FindStringInStringList(sList: TStringList; const SearchStr: string;
   CaseSensitive: Boolean = False): Integer;
procedure ProcessToList(MyList: TStrings);
procedure RemoveDuplicateItems(ListBox: TListBox);
function StringListToArray(StringList: TStringList): TArray<string>;
// ---------------------------------------------------------------------------

// FILENAME FUNCTIONS
// ---------------------------------------------------------------------------
function RunApplication(const AExecutableFile, AParameters, AWorkingDir : string;
  const AShowOption: Integer = SW_SHOWNORMAL): Integer;
procedure OpenFileLocation(FileName: TFileName);
function OpenFileDialog(Title,FileName,OKName: LPCWSTR; const isFile: Boolean; var sFileName: string; const sDefaultDir: String = ''): Boolean;
procedure LogWrite(LogType: String; LogFrom: String; LogMessage: String);
function ABBoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;
function RenameSection(IniFile:TCustomIniFile; FromName,ToName:string):boolean;
procedure ScanProcessListFromIni(Config: TMemIniFile; TabList: TTabControl);
procedure GetShellLinkInfo(const LinkFile: WideString; var SLI: TShellLinkInfo);
function PathFromLNK(LinkFileName: String): String;
function WorkingDirFromLNK(LinkFileName: String): String;
procedure FindTextFromTXT(const fileName, searchText: string; ListView: TListView;
  Config: TMemIniFile; sImageList: TImageList; CurrentIconSize: Integer);
function GetSpecialFolderLocation(const Folder: Integer; const FolderNew: TGUID): String;
procedure AddSystemApps(ListView: TListView; AIndex: Integer; sImageList: TImageList;
  CurrentIconSize: Integer);
procedure GetPersonalFolders(ToolBar: TToolBar; Config: TMemIniFile; LangName: String;
  ImageList: TImageList; Form: TForm; OnToolBarClick, OnMenuClick: TNotifyEvent);
function GetNotepad: String;
function CheckPathType(const Path: string): Boolean;
// ---------------------------------------------------------------------------

// ENCRYPTION FUNCTIONS
// ---------------------------------------------------------------------------
function Encode(Source, Key: AnsiString): AnsiString;
function Decode(Source, Key: AnsiString): AnsiString;
// ---------------------------------------------------------------------------

// IMAGES FUNCTIONS
// ---------------------------------------------------------------------------
procedure LangImgFromRes(ImageList: TImageList);
function GetImageListSH(SHIL_FLAG:Cardinal): HIMAGELIST;
procedure AddIconsToList(IconPath: String; ImageList: TImageList; CurrentIconSize: Integer);
procedure GetIconFromFile( aFile: string; var aIcon: TIcon;SHIL_FLAG: Cardinal );
function GetIconIndex(const AFile: string; Attrs: DWORD): integer;
procedure LoadPngFromRes(PngName: String; ImageList: TImageList);
function LoadImageResource(const ResName: string): TPngImage;
procedure AddIconsToImgList(ImageList: TImageList);
procedure DrawIconToPaintBox(PaintBox: TPaintBox; Icon: TIcon; X, Y: Integer);
// ---------------------------------------------------------------------------

implementation

uses Translation;

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
function GetProcessID_(ProcessExeFilename: String): DWORD;
var
  Snapshot: THandle;
  ProcessEntry: TProcessEntry32;
begin
  Result := 0;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot = INVALID_HANDLE_VALUE then
    Exit;
  try
    ProcessEntry.dwSize := SizeOf(TProcessEntry32);
    if Process32First(Snapshot, ProcessEntry) then
    begin
      repeat
        if SameText(ExtractFileName(ProcessEntry.szExeFile), ProcessExeFilename) then
        begin
          Result := ProcessEntry.th32ProcessID;
          Break;
        end;
      until not Process32Next(Snapshot, ProcessEntry);
    end;
  finally
    CloseHandle(Snapshot);
  end;
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
// ---------------------------------------------------------------------------
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
function IsProcessRunning(const AFileName: string): Boolean;
var
  Snapshot: THandle;
  ProcessEntry: TProcessEntry32;
begin
  Result := False;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snapshot = INVALID_HANDLE_VALUE then Exit;

  ProcessEntry.dwSize := SizeOf(TProcessEntry32);
  if Process32First(Snapshot, ProcessEntry) then
  begin
    repeat
      if SameText(ExtractFileName(ProcessEntry.szExeFile), AFileName) then
      begin
        Result := True;
        Break;
      end;
    until not Process32Next(Snapshot, ProcessEntry);
  end;
  CloseHandle(Snapshot);
end;
// ---------------------------------------------------------------------------
{ **
 * Function for check if is UWP apps
 * }
function GetPackageFullName(hProcess: THandle; var packageFullNameLength: ULONG;
  packageFullName: PWideChar): Longint; stdcall; external 'kernel32.dll';

function IsUWPProcess(const ExeName: string): Boolean;
const
  PROCESS_QUERY_LIMITED_INFORMATION = $1000;
var
  hSnapshot: THandle;
  pe: TProcessEntry32;
  hProcess: THandle;
  buffer: array[0..1023] of Char;
  len: ULONG;
begin
  Result := False;
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if hSnapshot = INVALID_HANDLE_VALUE then Exit;

  pe.dwSize := SizeOf(pe);
  if Process32First(hSnapshot, pe) then
  begin
    repeat
      if SameText(pe.szExeFile, ExeName) then
      begin
        hProcess := OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, False, pe.th32ProcessID);
        if hProcess <> 0 then
        begin
          len := Length(buffer);
          if GetPackageFullName(hProcess, len, buffer) = ERROR_SUCCESS then
            Result := True;
          CloseHandle(hProcess);
        end;
        Break;
      end;
    until not Process32Next(hSnapshot, pe);
  end;
  CloseHandle(hSnapshot);
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
procedure MuteForProcess(Config: TMemIniFile; Section, ProcessName: String; Mute: Boolean; AudioController: TAudioProcessController);
begin
 if Config.ReadBool('General','EnableGlobalHotKey',False) = True then
 begin
  if Config.ReadBool('General', 'Mute', False) then
   SetMasterMute(Mute)
 end else
 if Mute = True then
 begin
  if Config.ReadBool('General', 'Mute', False) then SetMasterMute(True) else
   if Config.ReadBool(Section, 'Mute', False) then
   begin
   if FileExists(ExtractFilePath(ParamStr(0))+'svcl.exe') then
     RunApplication(ExtractFilePath(ParamStr(0))+'svcl.exe', '/Mute "'+ProcessName+'"','',SW_HIDE)
   else
     AudioController.MuteProcess(ProcessName, True)
   end;
 end else
 begin
   if Config.ReadBool('General', 'Mute', False) then SetMasterMute(False) else
   if Config.ReadBool(Section, 'Mute', False) then
   begin
    if FileExists(ExtractFilePath(ParamStr(0))+'svcl.exe') then
    RunApplication(ExtractFilePath(ParamStr(0))+'svcl.exe', '/Unmute "'+ProcessName+'"','',SW_HIDE)
   else
     AudioController.MuteProcess(ProcessName, False)
   end;
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
 * Wrapper for the function to get status contains files in Recycle Bin
 * @return Boolean (True) or if full (False)
 * }
function IsRecycleBinEmpty: Boolean;
var
  RecycleBinInfo: TSHQueryRBInfo;
begin
  // Initialize the structure
  RecycleBinInfo.cbSize := SizeOf(TSHQueryRBInfo);

  // Query the Recycle Bin information
  if SHQueryRecycleBin(nil, @RecycleBinInfo) = S_OK then
  begin
    // Check if the number of items is zero
    Result := RecycleBinInfo.i64NumItems = 0;
  end
  else
  begin
    // If the function fails, assume the Recycle Bin is not empty
    Result := False;
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
// ---------------------------------------------------------------------------
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
// ---------------------------------------------------------------------------
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
// ---------------------------------------------------------------------------
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

// COMPONENTS GENERAL FUNCTIONS
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
{ **
 * Function to get section to items to TStrings
 * }
function ReadDirectory(List : TStrings; Config: TMemIniFile): Integer;
begin
List.Clear;
Config.ReadSections(List);
if Config.SectionExists('ToolBar') then
List.Delete(FindString(List,'Toolbar'));
end;
{ **
 * Function to delete tab from TTabControl
 * }
procedure DeleteAt(cbActive: TTabControl;idx: Integer);
begin
  if idx >= 0 then
    CbActive.Tabs.Delete(idx);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to add menu item
 * }
procedure AddMenuItem(Menu: TMenuItem; Tabs: TTabControl; OnClick: TNotifyEvent);
var
 menuItem : TMenuItem;
 i: Integer;
begin
Menu.Clear;
for I := 0 to tabs.Tabs.Count-1 do
 begin
  menuItem := TMenuItem.Create(Menu);
  menuItem.Caption := tabs.Tabs[i];
  menuItem.OnClick := OnClick;
  Menu.Add(menuItem);
 end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to change to next tab
 * }
procedure ChangeToNextTab(TabControl: TTabControl);
begin
  if TabControl.Tabs.Count > 0 then
  begin
    if TabControl.TabIndex < TabControl.Tabs.Count - 1 then
      TabControl.TabIndex := TabControl.TabIndex + 1
    else
      TabControl.TabIndex := 0;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to add custom button to ToolBar
 * }
procedure AddButtonToToolbar(OnClick: TNotifyEvent; var bar: TToolBar; hint: string;
  caption: string; imageindex: Integer; addafteridx: integer = -1);
var
  newbtn: TToolButton;
  prevBtnIdx: integer;
begin
  newbtn := TToolButton.Create(bar);
  newbtn.Caption := caption;
  newbtn.Hint := hint;
  newbtn.ImageIndex := imageindex;
  newbtn.OnClick := OnClick;

  //if they asked us to add it after a specific location, then do so
  //otherwise, just add it to the end (after the last existing button)
  if addafteridx = -1 then begin
    prevBtnIdx := bar.ButtonCount - 1;
  end
  else begin
    if bar.ButtonCount <= addafteridx then begin
      //if the index they want to be *after* does not exist,
      //just add to the end
      prevBtnIdx := bar.ButtonCount - 1;
    end
    else begin
      prevBtnIdx := addafteridx;
    end;
  end;

  if prevBtnIdx > -1 then
    newbtn.Left := bar.Buttons[prevBtnIdx].Left + bar.Buttons[prevBtnIdx].Width
  else
    newbtn.Left := 0;

  newbtn.Parent := bar;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to add ControlPanel list to TMenuItem
 * }
procedure ADDControlPanelList(ParentMenu: TMenuItem; Config: TMemIniFile; OnClick: TNotifyEvent);
var
  MenuItem : TMenuItem;
begin
  MenuItem := TMenuItem.Create(ParentMenu.Owner);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG2,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}"';
  MenuItem.OnClick := OnClick;
  ParentMenu.Add(MenuItem);

  MenuItem := TMenuItem.Create(ParentMenu.Owner);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG3,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{21EC2020-3AEA-1069-A2DD-08002B30309D}"';
  MenuItem.OnClick := OnClick;
  ParentMenu.Add(MenuItem);

  MenuItem := TMenuItem.Create(ParentMenu.Owner);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG4,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{ED7BA470-8E54-465E-825C-99712043E01C}"';
  MenuItem.OnClick := OnClick;
  ParentMenu.Add(MenuItem);

  MenuItem := TMenuItem.Create(ParentMenu.Owner);
  MenuItem.Caption := '-';
  ParentMenu.Add(MenuItem);

  MenuItem := TMenuItem.Create(ParentMenu.Owner);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG5,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{74246bfc-4c96-11d0-abef-0020af6b0b7a}"';
  MenuItem.OnClick := OnClick;
  ParentMenu.Add(MenuItem);

  MenuItem := TMenuItem.Create(ParentMenu.Owner);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG6,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{BB06C0E4-D293-4f75-8A90-CB05B6477EEE}"';
  MenuItem.OnClick := OnClick;
  ParentMenu.Add(MenuItem);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to load all items from INI to PopupMenu
 * }
procedure LoadMenuFromINI(Config, ListConfig: TMemIniFile; PopupMenu: TPopupMenu; ImageList: TImageList;
OnClick, OnDrivesClick, OnControlClick, OnNewControlClick, OnRecycleClick: TNotifyEvent);

 function GetSystemIcon(const FileName: string): Integer;
 var
  SHFileInfo: TSHFileInfo;
 begin

  if ImageList.Count = 0 then
    ImageList.Handle := ImageList_Create(16, 16, ILC_COLOR32 or ILC_MASK, 0, 10);

  if SHGetFileInfo(PChar(FileName), 0, SHFileInfo, SizeOf(SHFileInfo),
    SHGFI_ICON or SHGFI_SMALLICON or SHGFI_SHELLICONSIZE or SHGFI_SYSICONINDEX
                              or SHGFI_TYPENAME or SHGFI_DISPLAYNAME) <> 0 then
  begin
    Result := ImageList_AddIcon(ImageList.Handle, SHFileInfo.hIcon);
    DestroyIcon(SHFileInfo.hIcon);
  end
  else
    Result := -1;
 end;

 function CreateMenuItem(AOwner: TComponent; const ACaption, AHint: string;
                      AImageIndex: Integer; AOnClick: TNotifyEvent): TMenuItem;
 begin
  Result := TMenuItem.Create(AOwner);
  Result.Caption := ACaption;
  Result.Hint := AHint;
  Result.ImageIndex := AImageIndex;
  Result.OnClick := AOnClick;
 end;

 procedure AddMenuSeparator(AMenu: TPopupMenu);
 begin
  AMenu.Items.Add(CreateMenuItem(AMenu, '-', '', -1, nil));
 end;

var
  Sections, Items, Parts: TStringList;
  i, j, IconIndex: Integer;
  MenuItem, SubMenuItem: TMenuItem;
  ItemName, ItemCommand, Section, Lang: string;
  hicon: TIcon;
begin
  if not (Assigned(PopupMenu) and Assigned(ImageList) and Assigned(Config)) then Exit;

  Lang := Config.ReadString('General', 'Language', EN_US);
  Sections := TStringList.Create;
  Items := TStringList.Create;
  Parts := TStringList.Create;
  hicon:= TIcon.Create;
  try
    //Add drive list
    ADDListDrives(PopupMenu, OnDrivesClick, _(LNK_UTILS_GLOBAL_TEXT_MSG1,Lang));
    AddMenuSeparator(PopupMenu);

    //Add ControlPanel list
    SubMenuItem := CreateMenuItem(PopupMenu, _(LNK_HINT_BTN_BTN2, Lang), '', -1, nil);
    PopupMenu.Items.Add(SubMenuItem);
    SubMenuItem.Add(CreateMenuItem(PopupMenu, _(LNK_HINT_BTN_BTN2, Lang), '', -1, OnNewControlClick));
    AddMenuSeparator(PopupMenu);
    ADDControlPanelList(SubMenuItem, Config, OnControlClick);
    AddMenuSeparator(PopupMenu);

    //Add RecycleBin
    PopupMenu.Items.Add(CreateMenuItem(PopupMenu, _(LNK_HINT_SPDBTN_BTN2, Lang), '', -1, OnRecycleClick));
    AddMenuSeparator(PopupMenu);

    // Load sections from INI
    ListConfig.ReadSections(Sections);
    for i := 0 to Sections.Count - 1 do
    begin
      Section := Sections[i];
      SubMenuItem := TMenuItem.Create(PopupMenu);
      try
      SubMenuItem.Caption := Section;
      SubMenuItem := CreateMenuItem(PopupMenu, Section, '', -1, nil);
      PopupMenu.Items.Add(SubMenuItem);

      ListConfig.ReadSectionValues(Section, Items);
      Items.Sort;

      for j := 0 to Items.Count - 1 do
      begin
        ItemName := Items.Names[j];
        ItemCommand := Items.ValueFromIndex[j];

        //Need to extract Icon Location
        Parts.Clear;
        StrToList(ItemCommand,'|',Parts);

        //GetSystemIcons
        if (Parts.Count > 2) and SameText(ExtractFileExt(Parts[2]), '.ico') and FileExists(Parts[2]) then
        begin
          hIcon.LoadFromFile(Parts[2]);
          IconIndex := ImageList_AddIcon(ImageList.Handle, hIcon.Handle);
        end
        else
          IconIndex := GetSystemIcon(Parts[2]);

        MenuItem := CreateMenuItem(PopupMenu, ItemName, ItemCommand, IconIndex, OnClick);
        SubMenuItem.Add(MenuItem);
      end;
    except
        SubMenuItem.Free;
        raise;
      end;
    end;
  finally
    Sections.Free;
    Items.Free;
    Parts.Free;
    hicon.Free;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to check if exist button from ToolBar
 * }
function ButtonExists(ToolBar: TToolBar; Hint: string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to ToolBar.ButtonCount - 1 do
  begin
    if SameText(ToolBar.Buttons[i].Hint, Hint) then
    begin
      Result := True;
      Break;
    end;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to load all buttons from INI to ToolBar
 * }
procedure LoadToolButtons(ToolBar: TToolBar; Config: TMemIniFile; ImageList: TImageList;
   OnButtonClick: TNotifyEvent);

 procedure ClearToolbarButtons(Toolbar: TToolBar; ImageList: TImageList);
 var
  i: Integer;
 begin
  for i := Toolbar.ButtonCount - 1 downto 0 do
    Toolbar.Buttons[i].Free;
  ImageList.Clear;
 end;

var
  ButtonList: TStringList;
  NewButton: TToolButton;
  i: Integer;
  TempButtons: TList;
  TempList: TStringList;
begin
  // Clear existing buttons
  ClearToolbarButtons(ToolBar, ImageList);

  ButtonList := TStringList.Create;
  TempButtons := TList.Create;
  TempList := TStringList.Create;
  try
    Config.ReadSectionValues('Toolbar', ButtonList);
    for i := 0 to ButtonList.Count - 1 do
    begin
      if not ButtonExists(ToolBar, ButtonList.Names[i]) then
      begin
        NewButton := TToolButton.Create(ToolBar);
        NewButton.Parent := ToolBar;
        NewButton.Hint := ButtonList.Names[i];
        NewButton.Caption := ButtonList.ValueFromIndex[i];
        NewButton.ShowHint := True;
        NewButton.OnClick := OnButtonClick;
        TempButtons.Add(NewButton);

        //Add icons
        StrToList(ButtonList.ValueFromIndex[i],'|',TempList);
        if TempList.Count <> -1 then
         begin
          AddIconsToList(TempList[2], ImageList, SHIL_LARGE);
          NewButton.ImageIndex := i;
         end;

      end;
    end;
  finally
    for i := 0 to TempButtons.Count - 1 do
    begin
      if not TToolButton(TempButtons[i]).Parent.ContainsControl(TToolButton(TempButtons[i])) then
        TToolButton(TempButtons[i]).Free;
    end;
    TempButtons.Free;
    ButtonList.Free;
    TempList.Free;
  end;

  //If buttons is 0 then ToolBar is not visible
  if ToolBar.ButtonCount <> 0 then
  ToolBar.Visible := True else ToolBar.Visible := False;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to add button to INI and ToolBar
 * }
procedure AddToolButton(ToolBar: TToolBar; Hint, Caption: string; Config: TMemIniFile;
   ImageList: TImageList; OnButtonClick: TNotifyEvent);
begin
 Config.WriteString('Toolbar', Hint, Caption);
 Config.UpdateFile;

 LoadToolButtons(ToolBar, Config, ImageList, OnButtonClick);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to remove button from INI and ToolBar
 * }
procedure DeleteToolButton(ToolBar: TToolBar; Hint: string; Config: TMemIniFile;
  ImageList: TImageList; OnButtonClick: TNotifyEvent);
begin
 Config.DeleteKey('Toolbar', Hint);
 Config.UpdateFile;

 LoadToolButtons(ToolBar, Config, ImageList, OnButtonClick);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to add popup menu to all buttons from ToolBar
 * }
procedure AddItemToButtonPopup(ToolBar: TToolBar; Config: TMemIniFile; Form: TForm;
   OnButtonClick: TNotifyEvent);
var
  NewMenuItem: TMenuItem;
  Popup: TPopupMenu;
  i: Integer;
begin
  // Create a single popup menu instance
  Popup := TPopupMenu.Create(Form);

  // Add the new menu item to the popup menu
  NewMenuItem := TMenuItem.Create(Popup);
  NewMenuItem.Caption := _(LNK_CPTN_MENUITEM_LST_N16_2, Config.ReadString('General','Language',EN_US));
  NewMenuItem.OnClick := OnButtonClick; // Assign the event handler
  Popup.Items.Add(NewMenuItem);

  // Assign the same popup menu to all buttons in the toolbar
  for i := 0 to ToolBar.ButtonCount - 1 do
  begin
    ToolBar.Buttons[i].PopupMenu := Popup;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to show flash form
 * }
procedure FlashWindow(FormHandle: HWND);
var
  Info: FLASHWINFO;
begin
  // Flash the window
  Info.cbSize := SizeOf(FLASHWINFO);
  Info.hwnd := FormHandle;
  Info.dwFlags := FLASHW_ALL or FLASHW_TIMERNOFG;
  Info.uCount := 3;
  Info.dwTimeout := 0;
  FlashWindowEx(Info);

  // Delay slightly before forcing bring to front
  Sleep(200); // optional, gives flash time to be seen

  // Bring to front aggressively
  SetWindowPos(FormHandle, HWND_TOPMOST, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
  Sleep(100); // allow Z-order update
  SetWindowPos(FormHandle, HWND_NOTOPMOST, 0, 0, 0, 0,
    SWP_NOMOVE or SWP_NOSIZE or SWP_SHOWWINDOW);
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
{ **
 * Function to convert KB to TB
 * }
function DiskFloatToString(Number: Double;Units: Boolean): string;
var
  TypeSpace : String;
begin
  if Number >= 1024 then
  begin
    //KiloBytes
    Number    := Number / (1024);
    TypeSpace := ' KB';
    if Number >= 1024 then
    begin
      //MegaBytes
      Number    := Number / (1024);
      TypeSpace := ' MB';
      if Number >= 1024 then
      begin
        //GigaBytes
        Number    := Number / (1024);
        TypeSpace := ' GB';
        if Number >= 1024 then
        begin
          //TeraBytes
          Number    := Number / (1024);
          TypeSpace := ' TB';
        end;
      end;
    end;
  end;
  Result := FormatFloat('0.00',Number);
  if Units then
    Result := Result + TypeSpace;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get the free size on the disk
 * }
function DiskFreeString(Drive: Char;Units: Boolean): string;
var
  Free : Double;
begin
  Free   := DiskFree(Ord(Drive) - 64);
  Result := DiskFloatToString(Free,Units);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get the size on the disk
 * }
function DiskSizeString(Drive: Char;Units: Boolean): string;
var
  Size : Double;
begin
  Size   := DiskSize(Ord(Drive) - 64);
  Result := DiskFloatToString(Size,Units);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to add drives list to PopupMenu
 * }
procedure ADDListDrives(PopupMenu: TPopupMenu; OnClick: TNotifyEvent; sFree: String);
var
  i, j, k: integer;
  buf: array [0..499] of char;
  DrvStr: array [0..9] of char;
  DrvStr2: Char;
  LogDrives: set of 0..25;
  MenuItem : TMenuItem;
begin
  PopupMenu.Items.Clear;
  integer(LogDrives) := GetLogicalDrives;
  for i := 0 to 25 do
  GetLogicalDriveStrings(1000, buf);
  i := 0;
  repeat
    FillChar(DrvStr, SizeOf(DrvStr), #0);
    j := 0;
    repeat
      DrvStr[j] := buf[i];
      inc(j);
      inc(i);
    until
      (buf[i] = #0) or (j > 9);
    inc(i);
    DrvStr2 := DrvStr[0];
    MenuItem := TMenuItem.Create(PopupMenu);
    MenuItem.Caption := DrvStr +'    '+ DiskFreeString(DrvStr2,True) + sFree +
         DiskSizeString(DrvStr2, True);
    MenuItem.Hint := DrvStr;
    MenuItem.OnClick := OnClick;
    PopupMenu.Items.Add(MenuItem);
  until
    ((buf[i-1] = #0) and (buf[i] = #0)) or (i > 499);
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
{ **
 * Function to convert string to Array
 * }
function StringListToArray(StringList: TStringList): TArray<string>;
begin
  Result := StringList.ToStringArray;
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
  _SEInfo.Wnd := 0;
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
function OpenFileDialog(Title,FileName,OKName: LPCWSTR; const isFile: Boolean; var sFileName: string; const sDefaultDir: String = ''): Boolean;
var
  FileDialog: IFileDialog;
  Item: IShellItem;
  SelectedPath: PWideChar;
  Options: DWORD;
  DefaultFolder: IShellItem;
begin
  Result := False; // Initialize the result
  CoInitialize(nil); // Initialize COM
  try
    // Create the dialog instance
    if Succeeded(CoCreateInstance(CLSID_FileOpenDialog, nil, CLSCTX_INPROC_SERVER, IFileDialog, FileDialog)) then
    begin
      // Set the default folder
      if sDefaultDir <> '' then
       begin
       if Succeeded(SHCreateItemFromParsingName(PChar(sDefaultDir), nil, IShellItem, DefaultFolder)) then
        FileDialog.SetFolder(DefaultFolder);
       end else
       begin
       if Succeeded(SHCreateItemFromParsingName('::{20D04FE0-3AEA-1069-A2D8-08002B30309D}', nil, IShellItem, DefaultFolder)) then
        FileDialog.SetFolder(DefaultFolder);
       end;

      // Set the dialogs captions
      FileDialog.SetTitle(Title);
      FileDialog.SetFileNameLabel(FileName);
      FileDialog.SetOkButtonLabel(OKName);

      // Set dialog options
      if isFile then
        Options := FOS_FORCEFILESYSTEM or FOS_PATHMUSTEXIST or FOS_FORCESHOWHIDDEN
      else
        Options := FOS_PICKFOLDERS or FOS_FORCEFILESYSTEM or FOS_PATHMUSTEXIST or FOS_FORCESHOWHIDDEN;

      FileDialog.SetOptions(Options);

      // Show the dialog
      if Succeeded(FileDialog.Show(0)) then
      begin
        // Get the selected item
        if Succeeded(FileDialog.GetResult(Item)) then
        begin
          if Succeeded(Item.GetDisplayName(SIGDN_FILESYSPATH, SelectedPath)) then
          begin
            try
              sFileName := SelectedPath; // Set the selected path
              Result := True; // Indicate success
            finally
              CoTaskMemFree(SelectedPath); // Free the allocated memory
            end;
          end;
        end;
      end;
    end;
  finally
    CoUninitialize; // Uninitialize COM
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
{ **
 * Function to get information on an existing shell link
 * }
procedure GetShellLinkInfo(const LinkFile: WideString; var SLI: TShellLinkInfo);
{ Retrieves information on an existing shell link }
var
 SL: IShellLink;
 PF: IPersistFile;
 FindData: TWin32FindData;
 AStr: array[0..MAX_PATH] of char;
begin
 OleCheck(CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER,
  IShellLink, SL));
 { The IShellLink implementer must also support the IPersistFile }
 { interface. Get an interface pointer to it. }
 PF := SL as IPersistFile;
 { Load file into IPersistFile object }
 OleCheck(PF.Load(PWideChar(LinkFile), STGM_READ));
 { Resolve the link by calling the Resolve interface function. }
 OleCheck(SL.Resolve(0, SLR_ANY_MATCH or SLR_NO_UI));
 { Get all the info! }
 with SLI do
 begin
  OleCheck(SL.GetPath(AStr, MAX_PATH, FindData, SLGP_RAWPATH));
  PathName := AStr;
  OleCheck(SL.GetArguments(AStr, MAX_PATH));
  Arguments := AStr;
  OleCheck(SL.GetDescription(AStr, MAX_PATH));
  Description := AStr;
  OleCheck(SL.GetWorkingDirectory(AStr, MAX_PATH));
  WorkingDirectory := AStr;
  OleCheck(SL.GetIconLocation(AStr, MAX_PATH, IconIndex));
  IconLocation := AStr;
  OleCheck(SL.GetShowCmd(ShowCmd));
  OleCheck(SL.GetHotKey(HotKey));
 end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get path from shell link
 * }
function PathFromLNK(LinkFileName: String): String;
var
 data: TShellLinkInfo;
begin
 GetShellLinkInfo(LinkFileName, data);
 Result := data.PathName;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get workdir from shell link
 * }
function WorkingDirFromLNK(LinkFileName: String): String;
var
 data: TShellLinkInfo;
begin
 GetShellLinkInfo(LinkFileName, data);
 Result := data.WorkingDirectory;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to find and delete sections from INI and aasign to TStringsList
 * }
function LoadIniWithoutSections(const FileName: string; const SectionsToDelete: array of string): TStringList;
var
  SourceLines: TStringList;
  ResultLines: TStringList;
  i, j: Integer;
  Line: string;
  CurrentSection: string;
  InDeletedSection: Boolean;
begin
  ResultLines := TStringList.Create; // Initialize Result immediately
  SourceLines := TStringList.Create;
  try
    if FileExists(FileName) then
      SourceLines.LoadFromFile(FileName)
    else
    begin
      Result := ResultLines; // Return an empty TStringList if file doesn't exist
      SourceLines.Free;
      Exit;
    end;

    CurrentSection := '';
    InDeletedSection := False;

    for i := 0 to SourceLines.Count - 1 do
    begin
      Line := Trim(SourceLines[i]);

      if Line = '' then
      begin
        if not InDeletedSection then
          ResultLines.Add(Line);
        Continue;
      end;

      if (Length(Line) > 2) and (Line[1] = '[') and (Line[Length(Line)] = ']') then
      begin
        CurrentSection := Copy(Line, 2, Length(Line) - 2);
        InDeletedSection := False;
        for j := Low(SectionsToDelete) to High(SectionsToDelete) do
          if SameText(CurrentSection, SectionsToDelete[j]) then
          begin
            InDeletedSection := True;
            Break;
          end;

        if not InDeletedSection then
          ResultLines.Add(Line);
        Continue;
      end;

      if not InDeletedSection then
        ResultLines.Add(Line);
    end;

    Result := ResultLines;
  except
    on E: Exception do
    begin
      ResultLines.Free;
      SourceLines.Free;
      raise;
    end;
  end;
  SourceLines.Free;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to find text in file from drive
 * }
procedure FindTextFromTXT(const fileName, searchText: string; ListView: TListView;
          Config: TMemIniFile; sImageList: TImageList; CurrentIconSize: Integer);
var
  sl,sl2,sl3,sl4: TStringList;
  i,h: Integer;
  ListItem: TListItem;
begin
  ListView.Items.Clear;
  sl := TStringList.Create;
  sl2 := TStringList.Create;// for caption
  sl3 := TStringList.Create;// for subitems
  sl4 := TStringList.Create;// delete sections from sl
  try
   ListView.Items.BeginUpdate;

    // Load INI without 'Toolbar' section (avoid reassigning sl directly)
    sl.Assign(LoadIniWithoutSections(filename,['Toolbar']));

    // Delete section names from sl
    Config.ReadSections(sl4);
    for h := sl4.Count - 1 downto 0 do
    begin
      i := sl.IndexOf('[' + sl4[h] + ']');
      if i <> -1 then
        sl.Delete(i);
    end;

    for i := sl.Count - 1 downto 0 do
    begin
      if Pos(WideUpperCase(SearchText), WideUpperCase(sl[i])) <> 0 then
      begin
        // Assuming StrToList splits a string into a TStringList by a delimiter
        StrToList(sl[i], '=', sl2);
        StrToList(sl[i], '|', sl3);

        ListItem := ListView.Items.Add;
        if sl2.Count > 0 then
          ListItem.Caption := sl2[0]
        else
          ListItem.Caption := ''; // Fallback if no '=' found

        ListItem.SubItems.Assign(sl3);
        if (sl3.Count > 0) and (ListItem.Caption <> '') then
          ListItem.SubItems[0] := StringReplace(ListItem.SubItems[0],
            ListItem.Caption + '=', '', [rfReplaceAll, rfIgnoreCase])
        else if sl3.Count > 0 then
          ListItem.SubItems[0] := sl3[0]; // Use raw value if no caption

        if sl3.Count > 2 then
        begin
          AddIconsToList(PChar(sl3[2]), sImageList, CurrentIconSize);
          ListItem.ImageIndex := sImageList.Count - 1;
        end;
       end;
    end;

  finally
    ListView.Items.EndUpdate;
    sl.Free;
    sl2.Free;
    sl3.Free;
    sl4.Free;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get special folders from system
 * }
function GetSpecialFolderLocation(const Folder: Integer; const FolderNew: TGUID): String;
const
  KF_FLAG_DONT_VERIFY         = $00004000;
var
  FolderPath: PWideChar;
  SHGetFolderPath: function(hwnd: HWND; csidl: Integer; hToken: THandle; dwFlags: DWORD; pszPath: PWideChar): HResult; stdcall;
  SHGetKnownFolderPath: function(const rfid: TIID; dwFlags: DWORD; hToken: THandle; var ppszPath: PWideChar): HRESULT; stdcall;
begin
  Result := '';

  if not CompareMem(@FolderNew, @GUID_NULL, SizeOf(TGUID)) then
  begin
    SHGetKnownFolderPath := GetProcAddress(GetModuleHandle('Shell32.dll'), 'SHGetKnownFolderPath');
    if Assigned(SHGetKnownFolderPath) then
    begin
      FolderPath := nil;
      SetLastError(Cardinal(SHGetKnownFolderPath(FolderNew, KF_FLAG_DONT_VERIFY, 0, FolderPath)));
      if Succeeded(HRESULT(GetLastError)) then
      begin
        Result := FolderPath;
        CoTaskMemFree(FolderPath);
      end;
    end;
  end;

  if (Result = '') and (Folder >= 0) then
  begin
    SHGetFolderPath := GetProcAddress(GetModuleHandle('Shell32.dll'), 'SHGetFolderPathW');
    if Assigned(SHGetFolderPath) then
    begin
      FolderPath := AllocMem((MAX_PATH + 1) * SizeOf(WideChar));
      SetLastError(Cardinal(SHGetFolderPath(0, Folder, 0, 0, FolderPath)));
      if Succeeded(HRESULT(GetLastError)) then
        Result := FolderPath;
      FreeMem(FolderPath);
    end;
  end;

  if Result <> '' then
    Result := IncludeTrailingPathDelimiter(Result);
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get System apps from System to ListView
 * }
procedure AddSystemApps(ListView: TListView; AIndex: Integer; sImageList: TImageList;
                        CurrentIconSize: Integer);

function InsertItem(ACaption, Path, Param: String;
         const WorkingDir: String = ''): Boolean;
var
 InsItem: TListItem;
begin
 InsItem := ListView.Items.Add;
 InsItem.Caption:= ACaption;
 InsItem.SubItems.Add(Path);
 InsItem.SubItems.Add(Param);
 InsItem.SubItems.Add(Path); //insert icon path
 Insitem.SubItems.Add(WorkingDir); //insert workdir
 AddIconsToList(PChar(InsItem.SubItems.Strings[2]), sImageList, CurrentIconSize);
 Insitem.ImageIndex := sImageList.Count-1;
end;

begin
  //http://www.gunsmoker.ru/2011/09/blog-post_11.html
case AIndex of
0:
 begin
  InsertItem('Windows Media Player',GetSpecialFolderLocation(-1, FOLDERID_ProgramFilesX86)+'Windows Media Player\wmplayer.exe','');
  InsertItem('Microsoft Edge',GetSpecialFolderLocation(-1, FOLDERID_ProgramFilesX86)+'Microsoft\Edge\Application\msedge.exe','');
  InsertItem('Regedit',GetSpecialFolderLocation(-1, FOLDERID_Windows)+'regedit.exe','');
  InsertItem('Paint',GetSpecialFolderLocation(-1, FOLDERID_System)+'mspaint.exe','');
  InsertItem('Notepad',GetSpecialFolderLocation(-1, FOLDERID_System)+'notepad.exe','');
  InsertItem('Calculator',GetSpecialFolderLocation(-1, FOLDERID_System)+'calc.exe','');
  InsertItem('Snipping Tool',GetSpecialFolderLocation(-1, FOLDERID_System)+'SnippingTool.exe','');
  InsertItem('Remote Control',GetSpecialFolderLocation(-1, FOLDERID_System)+'mstsc.exe','');
  InsertItem('Faxes and Scanning',GetSpecialFolderLocation(-1, FOLDERID_System)+'WFS.exe','');
  InsertItem('Character Map',GetSpecialFolderLocation(-1, FOLDERID_System)+'charmap.exe','');
  InsertItem('Task Manager',GetSpecialFolderLocation(-1, FOLDERID_System)+'taskmgr.exe','');
  InsertItem('Command Prompt',GetSpecialFolderLocation(-1, FOLDERID_System)+'cmd.exe','');
  InsertItem('On-screen keyboard',GetSpecialFolderLocation(-1, FOLDERID_System)+'osk.exe','');
  InsertItem('Magnifier',GetSpecialFolderLocation(-1, FOLDERID_System)+'magnify.exe','');
  InsertItem('Narrator',GetSpecialFolderLocation(-1, FOLDERID_System)+'narrator.exe','');
  InsertItem('Recovery',GetSpecialFolderLocation(-1, FOLDERID_System)+'RecoveryDrive.exe','');
  InsertItem('iSCSI Initiator',GetSpecialFolderLocation(-1, FOLDERID_System)+'iscsicpl.exe','');
  InsertItem('ODBC Data Sources',GetSpecialFolderLocation(-1, FOLDERID_System)+'odbcad32.exe','');
  InsertItem('ODBC Data Sources (x86)',GetSpecialFolderLocation(-1, FOLDERID_SystemX86)+'odbcad32.exe','');
  InsertItem('System Configuration',GetSpecialFolderLocation(-1, FOLDERID_System)+'msconfig.exe','');
  InsertItem('Local Security Policy',GetSpecialFolderLocation(-1, FOLDERID_System)+'secpol.msc','/s');
  InsertItem('Windows Firewall',GetSpecialFolderLocation(-1, FOLDERID_System)+'WF.msc','');
  InsertItem('Resource Monitor',GetSpecialFolderLocation(-1, FOLDERID_System)+'perfmon.exe','/res');
  InsertItem('Optimize Drives',GetSpecialFolderLocation(-1, FOLDERID_System)+'dfrgui.exe','');
  InsertItem('Disk Cleanup',GetSpecialFolderLocation(-1, FOLDERID_System)+'cleanmgr.exe','');
  InsertItem('Task Scheduler',GetSpecialFolderLocation(-1, FOLDERID_System)+'taskschd.msc','/s');
  InsertItem('Event Viewer',GetSpecialFolderLocation(-1, FOLDERID_System)+'eventvwr.msc','/s');
  InsertItem('System Information',GetSpecialFolderLocation(-1, FOLDERID_System)+'msinfo32.exe','');
  InsertItem('Performance Monitor',GetSpecialFolderLocation(-1, FOLDERID_System)+'perfmon.msc','/s');
  InsertItem('Component Services',GetSpecialFolderLocation(-1, FOLDERID_System)+'comexp.msc','');
  InsertItem('Services',GetSpecialFolderLocation(-1, FOLDERID_System)+'services.msc','');
  InsertItem('Memory Diagnostic',GetSpecialFolderLocation(-1, FOLDERID_System)+'MdSched.exe','');
  InsertItem('Computer Management',GetSpecialFolderLocation(-1, FOLDERID_System)+'compmgmt.msc','/s');
  InsertItem('Print Management',GetSpecialFolderLocation(-1, FOLDERID_System)+'printmanagement.msc','');
  InsertItem('PowerShell ISE',GetSpecialFolderLocation(-1, FOLDERID_System)+'WindowsPowerShell\v1.0\PowerShell_ISE.exe','');
  InsertItem('PowerShell ISE (x86)',GetSpecialFolderLocation(-1, FOLDERID_SystemX86)+'WindowsPowerShell\v1.0\PowerShell_ISE.exe','');
  InsertItem('PowerShell',GetSpecialFolderLocation(-1, FOLDERID_System)+'WindowsPowerShell\v1.0\powershell.exe','');
  InsertItem('PowerShell (x86)',GetSpecialFolderLocation(-1, FOLDERID_SystemX86)+'WindowsPowerShell\v1.0\powershell.exe','');
 end;
1:
 begin
  InsertItem('Desktop',GetSpecialFolderLocation(-1, FOLDERID_Desktop),'');
  InsertItem('Documents',GetSpecialFolderLocation(-1, FOLDERID_Documents),'');
  InsertItem('Downloads',GetSpecialFolderLocation(-1, FOLDERID_Downloads),'');
  InsertItem('Music',GetSpecialFolderLocation(-1, FOLDERID_Music),'');
  InsertItem('Pictures',GetSpecialFolderLocation(-1, FOLDERID_Pictures),'');
  InsertItem('Saved Games',GetSpecialFolderLocation(-1, FOLDERID_SavedGames),'');
  InsertItem('Videos',GetSpecialFolderLocation(-1, FOLDERID_Videos),'');
  InsertItem('Admin Tools',GetSpecialFolderLocation(-1, FOLDERID_AdminTools),'');
  InsertItem('CDBurning',GetSpecialFolderLocation(-1, FOLDERID_CDBurning),'');
  InsertItem('Common Admin Tools',GetSpecialFolderLocation(-1, FOLDERID_CommonAdminTools),'');
  InsertItem('Common Programs',GetSpecialFolderLocation(-1, FOLDERID_CommonPrograms),'');
  InsertItem('Common Start Menu',GetSpecialFolderLocation(-1, FOLDERID_CommonStartMenu),'');
  InsertItem('Common Startup',GetSpecialFolderLocation(-1, FOLDERID_CommonStartup),'');
  InsertItem('Common Templates',GetSpecialFolderLocation(-1, FOLDERID_CommonTemplates),'');
  InsertItem('Contacts',GetSpecialFolderLocation(-1, FOLDERID_Contacts),'');
  InsertItem('Cookies',GetSpecialFolderLocation(-1, FOLDERID_Cookies),'');
  InsertItem('DeviceMetadataStore',GetSpecialFolderLocation(-1, FOLDERID_DeviceMetadataStore),'');
  InsertItem('Documents Library',GetSpecialFolderLocation(-1, FOLDERID_DocumentsLibrary),'');
  InsertItem('Favorites',GetSpecialFolderLocation(-1, FOLDERID_Favorites),'');
  InsertItem('Fonts',GetSpecialFolderLocation(-1, FOLDERID_Fonts),'');
  InsertItem('Game Tasks',GetSpecialFolderLocation(-1, FOLDERID_GameTasks),'');
  InsertItem('History',GetSpecialFolderLocation(-1, FOLDERID_History),'');
  InsertItem('Implicit App Shortcuts',GetSpecialFolderLocation(-1, FOLDERID_ImplicitAppShortcuts),'');
  InsertItem('Internet Cache',GetSpecialFolderLocation(-1, FOLDERID_InternetCache),'');
  InsertItem('Libraries',GetSpecialFolderLocation(-1, FOLDERID_Libraries),'');
  InsertItem('Links',GetSpecialFolderLocation(-1, FOLDERID_Links),'');
  InsertItem('LocalAppData',GetSpecialFolderLocation(-1, FOLDERID_LocalAppData),'');
  InsertItem('LocalAppDataLow',GetSpecialFolderLocation(-1, FOLDERID_LocalAppDataLow),'');
  InsertItem('Music Library',GetSpecialFolderLocation(-1, FOLDERID_MusicLibrary),'');
  InsertItem('NetHood',GetSpecialFolderLocation(-1, FOLDERID_NetHood),'');
  InsertItem('Pictures Library',GetSpecialFolderLocation(-1, FOLDERID_PicturesLibrary),'');
  InsertItem('Playlists',GetSpecialFolderLocation(-1, FOLDERID_Playlists),'');
  InsertItem('PrintHood',GetSpecialFolderLocation(-1, FOLDERID_PrintHood),'');
  InsertItem('Profile',GetSpecialFolderLocation(-1, FOLDERID_Profile),'');
  InsertItem('ProgramData',GetSpecialFolderLocation(-1, FOLDERID_ProgramData),'');
  InsertItem('ProgramFilesCommonX64',GetSpecialFolderLocation(-1, FOLDERID_ProgramFilesCommonX64),'');
  InsertItem('ProgramFilesCommonX86',GetSpecialFolderLocation(-1, FOLDERID_ProgramFilesCommonX86),'');
  InsertItem('Program Files X64',GetSpecialFolderLocation(-1, FOLDERID_ProgramFilesX64),'');
  InsertItem('Program Files X86',GetSpecialFolderLocation(-1, FOLDERID_ProgramFilesX86),'');
  InsertItem('Programs',GetSpecialFolderLocation(-1, FOLDERID_Programs),'');
  InsertItem('Public',GetSpecialFolderLocation(-1, FOLDERID_Public),'');
  InsertItem('Public Desktop',GetSpecialFolderLocation(-1, FOLDERID_PublicDesktop),'');
  InsertItem('Public Documents',GetSpecialFolderLocation(-1, FOLDERID_PublicDocuments),'');
  InsertItem('Public Downloads',GetSpecialFolderLocation(-1, FOLDERID_PublicDownloads),'');
  InsertItem('PublicGameTasks',GetSpecialFolderLocation(-1, FOLDERID_PublicGameTasks),'');
  InsertItem('Public Libraries',GetSpecialFolderLocation(-1, FOLDERID_PublicLibraries),'');
  InsertItem('Public Music',GetSpecialFolderLocation(-1, FOLDERID_PublicMusic),'');
  InsertItem('Public Pictures',GetSpecialFolderLocation(-1, FOLDERID_PublicPictures),'');
  InsertItem('Public Ringtones',GetSpecialFolderLocation(-1, FOLDERID_PublicRingtones),'');
  InsertItem('Public Videos',GetSpecialFolderLocation(-1, FOLDERID_PublicVideos),'');
  InsertItem('QuickLaunch',GetSpecialFolderLocation(-1, FOLDERID_QuickLaunch),'');
  InsertItem('Recent',GetSpecialFolderLocation(-1, FOLDERID_Recent),'');
  InsertItem('RecordedTVLibrary',GetSpecialFolderLocation(-1, FOLDERID_RecordedTVLibrary),'');
  InsertItem('ResourceDir',GetSpecialFolderLocation(-1, FOLDERID_ResourceDir),'');
  InsertItem('Ringtones',GetSpecialFolderLocation(-1, FOLDERID_Ringtones),'');
  InsertItem('RoamingAppData',GetSpecialFolderLocation(-1, FOLDERID_RoamingAppData),'');
  InsertItem('SendTo',GetSpecialFolderLocation(-1, FOLDERID_SendTo),'');
  InsertItem('StartMenu',GetSpecialFolderLocation(-1, FOLDERID_StartMenu),'');
  InsertItem('Startup',GetSpecialFolderLocation(-1, FOLDERID_Startup),'');
  InsertItem('System32',GetSpecialFolderLocation(-1, FOLDERID_System),'');
  InsertItem('SysWOW64',GetSpecialFolderLocation(-1, FOLDERID_SystemX86),'');
  InsertItem('Templates',GetSpecialFolderLocation(-1, FOLDERID_Templates),'');
  InsertItem('UserPinned',GetSpecialFolderLocation(-1, FOLDERID_UserPinned),'');
  InsertItem('UserProfiles',GetSpecialFolderLocation(-1, FOLDERID_UserProfiles),'');
  InsertItem('UserProgramFiles',GetSpecialFolderLocation(-1, FOLDERID_UserProgramFiles),'');
  InsertItem('UserProgramFilesCommon',GetSpecialFolderLocation(-1, FOLDERID_UserProgramFilesCommon),'');
  InsertItem('Videos Library',GetSpecialFolderLocation(-1, FOLDERID_VideosLibrary),'');
  InsertItem('Windows',GetSpecialFolderLocation(-1, FOLDERID_Windows),'');
 end;
end;
end;
//------------------------------------------------------------------------------
{ **
 * Function to add Personal folders from System to ToolBar
 * }
procedure GetPersonalFolders(ToolBar: TToolBar; Config: TMemIniFile; LangName: String;
  ImageList: TImageList; Form: TForm; OnToolBarClick, OnMenuClick: TNotifyEvent);
begin
 Config.WriteString('Toolbar',_(LNK_UTILS_GLOBAL_TEXT_MSG13,LangName),
 GetSpecialFolderLocation(-1, FOLDERID_Videos)+'|'+'|'+GetSpecialFolderLocation(-1, FOLDERID_Videos)+'|'+'|');
 Config.WriteString('Toolbar',_(LNK_UTILS_GLOBAL_TEXT_MSG12,LangName),
 GetSpecialFolderLocation(-1, FOLDERID_SavedGames)+'|'+'|'+GetSpecialFolderLocation(-1, FOLDERID_SavedGames)+'|'+'|');
 Config.WriteString('Toolbar',_(LNK_UTILS_GLOBAL_TEXT_MSG11,LangName),
 GetSpecialFolderLocation(-1, FOLDERID_Pictures)+'|'+'|'+GetSpecialFolderLocation(-1, FOLDERID_Pictures)+'|'+'|');
 Config.WriteString('Toolbar',_(LNK_UTILS_GLOBAL_TEXT_MSG10,LangName),
 GetSpecialFolderLocation(-1, FOLDERID_Music)+'|'+'|'+GetSpecialFolderLocation(-1, FOLDERID_Music)+'|'+'|');
 Config.WriteString('Toolbar',_(LNK_UTILS_GLOBAL_TEXT_MSG9,LangName),
 GetSpecialFolderLocation(-1, FOLDERID_Downloads)+'|'+'|'+GetSpecialFolderLocation(-1, FOLDERID_Downloads)+'|'+'|');
 Config.WriteString('Toolbar',_(LNK_UTILS_GLOBAL_TEXT_MSG8,LangName),
 GetSpecialFolderLocation(-1, FOLDERID_Documents)+'|'+'|'+GetSpecialFolderLocation(-1, FOLDERID_Documents)+'|'+'|');
 Config.WriteString('Toolbar',_(LNK_UTILS_GLOBAL_TEXT_MSG7,LangName),
 GetSpecialFolderLocation(-1, FOLDERID_Desktop)+'|'+'|'+GetSpecialFolderLocation(-1, FOLDERID_Desktop)+'|'+'|');
 Config.UpdateFile;

 //Load ToolBar buttons
 LoadToolButtons(ToolBar, Config, ImageList, OnToolBarClick);
//Add popup menu to ToolButton
 AddItemToButtonPopup(ToolBar, Config, Form, OnMenuClick);
end;
//------------------------------------------------------------------------------
{ **
 * Function to get notepad location
 * }
function GetNotepad: String;
begin
  Result := GetSpecialFolderLocation(-1, FOLDERID_System)+'notepad.exe';
end;
// ---------------------------------------------------------------------------
{ **
 * Function to check if is file or folder
 * @return False is folder or True is file
 * }
function CheckPathType(const Path: string): Boolean;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(Path, faAnyFile, SearchRec) = 0 then
  try
    if (SearchRec.Attr and faDirectory) <> 0 then
      Result := False
    else
      Result := True;
  finally
    FindClose(SearchRec);
  end;
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
{ **
 * Function to get icon from file
 * }
function GetImageListSH(SHIL_FLAG:Cardinal): HIMAGELIST;
const
 IID_IImageList: TGUID = '{46EB5926-582E-4017-9FDF-E8998DAA0950}';
type
  _SHGetImageList = function (iImageList: integer; const riid: TGUID; var ppv: Pointer): hResult; stdcall;
var
  Handle: THandle;
  SHGetImageList: _SHGetImageList;
begin
  Result:= 0;
  Handle:= LoadLibrary('Shell32.dll');
  if Handle<>S_OK then
  try
    SHGetImageList:=GetProcAddress(Handle, PChar(727));
    if Assigned(SHGetImageList) and (Win32Platform=VER_PLATFORM_WIN32_NT) then
      SHGetImageList(SHIL_FLAG, IID_IImageList, Pointer(Result));
  finally
    FreeLibrary(Handle);
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get icon from file
 * }
procedure GetIconFromFile( aFile: string; var aIcon: TIcon;SHIL_FLAG: Cardinal );
var
  aImgList: HIMAGELIST;
  SFI: TSHFileInfo;
  aIndex: integer;
begin // Get the index of the imagelist
  SHGetFileInfo( PChar( aFile ), FILE_ATTRIBUTE_NORMAL, SFI, SizeOf( TSHFileInfo ),
    SHGFI_ICON or SHGFI_LARGEICON or SHGFI_SHELLICONSIZE or SHGFI_SYSICONINDEX or SHGFI_TYPENAME or SHGFI_DISPLAYNAME );
  if not Assigned( aIcon ) then
    aIcon := TIcon.Create;
  // get the imagelist
  aImgList := GetImageListSH( SHIL_FLAG );
  // get index
  //aIndex := Pred( ImageList_GetImageCount( aImgList ) );
  aIndex := SFI.iIcon;
  // extract the icon handle
  aIcon.Handle := ImageList_GetIcon( aImgList, aIndex, ILD_NORMAL );
end;
// ---------------------------------------------------------------------------
{ **
 * Function to add icons when find from ListView to ImageList
 * }
procedure AddIconsToList(IconPath: String; ImageList: TImageList; CurrentIconSize: Integer);
var
 hicon: TIcon;
begin
 hicon:= TIcon.Create;
  try
   if ExtractFileExt(IconPath) <> '.ICO' then
    GetIconFromFile(IconPath, hicon, CurrentIconSize)
   else
   if FileExists(IconPath) then
    hicon.LoadFromFile(IconPath);

   //if icon not loading or exist extractfrom imageres.dll
   if hicon.Handle = 0 then
   hicon.Handle := ExtractIcon(hInstance,PChar(
              GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),2);

   ImageList.AddIcon(hicon);
  finally
   hicon.Free;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to get icon index from file
 * }
function GetIconIndex(const AFile: string; Attrs: DWORD): integer;
var
  SFI: TSHFileInfo;
begin
  SHGetFileInfo(PWideChar(AFile), Attrs, SFI, SizeOf(TSHFileInfo),SHGFI_SYSICONINDEX);
  Result := SFI.iIcon;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to load PNG from resource and put to ImageList
 * }
procedure LoadPngFromRes(PngName: String; ImageList: TImageList);
var
 png: TPngImage;
 bmp: TBitmap;
begin
png := TPngImage.Create;
bmp := TBitmap.Create;
 try
  png.LoadFromResourceName(hInstance,PngName);
  bmp.Assign(png);
  bmp.AlphaFormat := afIgnored;
  ImageList.Add(bmp,nil);
 finally
  png.Free;
  bmp.Free;
 end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to load PNG image from resource
 * }
function LoadImageResource(const ResName: string): TPngImage;
var
  Strm: TResourceStream;
begin
  Strm := TResourceStream.Create(hInstance, ResName, RT_RCDATA);
  try
    Result := TPngImage.Create;
    try
      Result.LoadFromStream(Strm);
    except
      Result.Free;
      raise;
    end;
  finally
    Strm.Free;
  end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to load icons from system and imageres.dll and put to ImageList
 * }
procedure AddIconsToImgList(ImageList: TImageList);
var
 Icon: TIcon;
begin
 Icon := TIcon.Create;
 try
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),104);//MyComputer
  ImageList.AddIcon(Icon);
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),22);//ControlPanel
  ImageList.AddIcon(Icon);
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),49);//RecycleBin empty
  ImageList.AddIcon(Icon);
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),50);//RecycleBin full
  ImageList.AddIcon(Icon);

  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),174);
  ImageList.AddIcon(Icon);
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),107);
  ImageList.AddIcon(Icon);
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),175);
  ImageList.AddIcon(Icon);
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),103);
  ImageList.AddIcon(Icon);
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),67);
  ImageList.AddIcon(Icon);
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),177);
  ImageList.AddIcon(Icon);
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),178);
  ImageList.AddIcon(Icon);

  //Extract TimerIcon 32 from resource
  LoadPngFromRes('time32',ImageList);
 finally
  Icon.Free;
end;
end;
// ---------------------------------------------------------------------------
{ **
 * Function to Draw icon to PaintBox
 * }
procedure DrawIconToPaintBox(PaintBox: TPaintBox; Icon: TIcon; X, Y: Integer);
begin
  if Assigned(PaintBox) and Assigned(Icon) and not Icon.Empty then
  begin
    // Ensure PaintBox canvas is ready
    PaintBox.Canvas.Lock;
    try
      // Draw the icon at specified coordinates
      PaintBox.Canvas.Draw(X, Y, Icon);
    finally
      PaintBox.Canvas.Unlock;
    end;
  end;
end;
// ---------------------------------------------------------------------------
end.
