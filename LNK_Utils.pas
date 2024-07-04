unit LNK_Utils;

interface

uses Windows, Forms, Controls, Menus, ShellAPI, ComCtrls, Messages, Classes, Graphics,
     SysUtils, StdCtrls, SHLObj, ActiveX, ComObj, Dialogs, CommCtrl, Imaging.pngimage,
     IniFiles;
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

type
 EShellOleError = class(Exception);

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

 TSpecialFolderInfo = record
  Name: string;
  ID: Integer;
 end;

type
  TListView = class(ComCtrls.TListView)
  protected
    procedure WndProc(var Message: TMessage); override;
  end;

function GetIconIndex(const AFile: string; Attrs: DWORD): integer;
procedure AddItem(Section, FileName, FilePath, Parameters, IconLocation, WorkingDir: string);
function ReadDirectory(List : TStrings; Config: TMemIniFile): Integer;
procedure GetShellLinkInfo(const LinkFile: WideString;
 var SLI: TShellLinkInfo);
function PathFromLNK(LinkFileName: String): String;
function WorkingDirFromLNK(LinkFileName: String): String;
procedure DeleteAt(cbActive: TTabControl;idx: Integer);
function GetSpecialFolderLocation(const Folder: Integer; const FolderNew: TGUID): String;
function DiskFloatToString(Number: Double;Units: Boolean): string;
function DiskFreeString(Drive: Char;Units: Boolean): string;
function DiskSizeString(Drive: Char;Units: Boolean): string;
procedure ADDListDrives(PopupMenu: TPopupMenu);
procedure ADDControlPanelList(PopupMenu: TPopupMenu);
function GetNotepad: String;
procedure AddSystemApps(AIndex: Integer);
procedure GetPersonalFolders(ToolBar: TToolBar);
procedure LoadPngFromRes(PngName: String; ImageList: TImageList);
function LoadImageResource(const ResName: string): TPngImage;
procedure AddIconsToImgList(ImageList: TImageList);

implementation

uses lnkForm;

function GetIconIndex(const AFile: string; Attrs: DWORD): integer;
var
  SFI: TSHFileInfo;
begin
  SHGetFileInfo(PWideChar(AFile), Attrs, SFI, SizeOf(TSHFileInfo),SHGFI_SYSICONINDEX);
  Result := SFI.iIcon;
end;

procedure TListView.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_ERASEBKGND then
    DefaultHandler(Message)
  else
    inherited;
end;

procedure AddItem(Section, FileName, FilePath, Parameters, IconLocation, WorkingDir: string);
begin
with lnk_Form do
 begin
  if not (FLists.ValueExists(lnk_Form.Caption,FileName)) then
  begin
   FLists.WriteString(Section,FileName,FilePath+'|'+Parameters+'|'+
                      IconLocation+'|'+WorkingDir+'|');
   FLists.UpdateFile;
   InsertItem := List.Items.Add;
   InsertItem.Caption:= FileName;
   InsertItem.SubItems.Add(FilePath);
   InsertItem.SubItems.Add(Parameters);
   InsertItem.SubItems.Add(IconLocation);
   InsertItem.SubItems.Add(WorkingDir);
   InsertItem.ImageIndex := GetIconIndex(PChar(IconLocation), FILE_ATTRIBUTE_NORMAL);
  end;
end;
end;

function ReadDirectory(List : TStrings; Config: TMemIniFile): Integer;
begin
List.Clear;
Config.ReadSections(List);
end;

procedure DeleteAt(cbActive: TTabControl;idx: Integer);
begin
  if idx >= 0 then
    CbActive.Tabs.Delete(idx);
end;

procedure GetShellLinkInfo(const LinkFile: WideString;
 var SLI: TShellLinkInfo);
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

function PathFromLNK(LinkFileName: String): String;
var
 data: TShellLinkInfo;
begin
 GetShellLinkInfo(LinkFileName, data);
 Result := data.PathName;
end;

function WorkingDirFromLNK(LinkFileName: String): String;
var
 data: TShellLinkInfo;
begin
 GetShellLinkInfo(LinkFileName, data);
 Result := data.WorkingDirectory;
end;

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
      end;
    end;
  end;
  Result := FormatFloat('0.00',Number);
  if Units then
    Result := Result + TypeSpace;
end;

function DiskFreeString(Drive: Char;Units: Boolean): string;
var
  Free : Double;
begin
  Free   := DiskFree(Ord(Drive) - 64);
  Result := DiskFloatToString(Free,Units);
end;

function DiskSizeString(Drive: Char;Units: Boolean): string;
var
  Size : Double;
begin
  Size   := DiskSize(Ord(Drive) - 64);
  Result := DiskFloatToString(Size,Units);
end;

procedure ADDListDrives(PopupMenu: TPopupMenu);
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
    MenuItem.Caption := DrvStr+'    '+DiskFreeString(DrvStr2,True)+' free of '+DiskSizeString(DrvStr2, True);
    MenuItem.Hint := DrvStr;
    MenuItem.OnClick := lnk_Form.DriveOnClick;
    PopupMenu.Items.Add(MenuItem);
  until
    ((buf[i-1] = #0) and (buf[i] = #0)) or (i > 499);
end;

procedure ADDControlPanelList(PopupMenu: TPopupMenu);
var
  MenuItem : TMenuItem;
begin
  PopupMenu.Items.Clear;

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Control Panel (category view)';
  MenuItem.Hint := '/root,"shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}"';
  MenuItem.OnClick := lnk_Form.ControlPanelOnClick;
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Control Panel (icons view)';
  MenuItem.Hint := '/root,"shell:::{21EC2020-3AEA-1069-A2DD-08002B30309D}"';
  MenuItem.OnClick := lnk_Form.ControlPanelOnClick;
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Control Panel (all tasks)';
  MenuItem.Hint := '/root,"shell:::{ED7BA470-8E54-465E-825C-99712043E01C}"';
  MenuItem.OnClick := lnk_Form.ControlPanelOnClick;
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := '-';
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'Device Manager';
  MenuItem.Hint := '/root,"shell:::{74246bfc-4c96-11d0-abef-0020af6b0b7a}"';
  MenuItem.OnClick := lnk_Form.ControlPanelOnClick;
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := 'System';
  MenuItem.Hint := '/root,"shell:::{BB06C0E4-D293-4f75-8A90-CB05B6477EEE}"';
  MenuItem.OnClick := lnk_Form.ControlPanelOnClick;
  PopupMenu.Items.Add(MenuItem);
end;

procedure AddButtonToToolbar(var bar: TToolBar; hint: string; caption: string; imageindex: Integer;
  addafteridx: integer = -1);
var
  newbtn: TToolButton;
  prevBtnIdx: integer;
begin
  newbtn := TToolButton.Create(bar);
  newbtn.Caption := caption;
  newbtn.Hint := hint;
  newbtn.ImageIndex := imageindex;
  newbtn.OnClick := LNK_Form.ToolBarOnClick;

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

function GetNotepad: String;
begin
  Result := GetSpecialFolderLocation(-1, FOLDERID_System)+'notepad.exe';
end;

procedure AddSystemApps(AIndex: Integer);

function InsertItem(ACaption, Path, Param: String;
         const WorkingDir: String = ''): Boolean;
var
 InsItem: TListItem;
begin
 InsItem := lnk_Form.List.Items.Add;
 InsItem.Caption:= ACaption;
 InsItem.SubItems.Add(WideUpperCase(Path));
 InsItem.SubItems.Add(Param);
 InsItem.SubItems.Add(WideUpperCase(Path)); //insert icon path
 Insitem.SubItems.Add(WideUpperCase(WorkingDir)); //insert workdir
 InsItem.ImageIndex := GetIconIndex(PChar(InsItem.SubItems.Strings[2]), FILE_ATTRIBUTE_NORMAL);
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

procedure GetPersonalFolders(ToolBar: TToolBar);
begin
  AddButtonToToolbar(LNK_Form.ToolBar1,'Desktop',GetSpecialFolderLocation(-1, FOLDERID_Desktop),3,0);
  AddButtonToToolbar(LNK_Form.ToolBar1,'Documents',GetSpecialFolderLocation(-1, FOLDERID_Documents),4,1);
  AddButtonToToolbar(LNK_Form.ToolBar1,'Downloads',GetSpecialFolderLocation(-1, FOLDERID_Downloads),5,2);
  AddButtonToToolbar(LNK_Form.ToolBar1,'Music',GetSpecialFolderLocation(-1, FOLDERID_Music),6,3);
  AddButtonToToolbar(LNK_Form.ToolBar1,'Pictures',GetSpecialFolderLocation(-1, FOLDERID_Pictures),7,4);
  AddButtonToToolbar(LNK_Form.ToolBar1,'Saved Games',GetSpecialFolderLocation(-1, FOLDERID_SavedGames),8,5);
  AddButtonToToolbar(LNK_Form.ToolBar1,'Videos',GetSpecialFolderLocation(-1, FOLDERID_Videos),9,6);
end;

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
  Icon.Handle := ExtractIcon(hInstance,PChar(GetSpecialFolderLocation(-1, FOLDERID_System)+'imageres.dll'),49);//RecycleBin
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

end.
