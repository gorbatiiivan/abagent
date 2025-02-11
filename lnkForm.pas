unit lnkForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, System.IniFiles,
  Winapi.ShellAPI, Winapi.CommCtrl, Winapi.ActiveX, Vcl.ToolWin;

type
  TLNK_Form = class(TForm)
    Tabs: TTabControl;
    List: TListView;
    Panel: TPanel;
    LNK_SPD_BTN3: TSpeedButton;
    LNK_BTN1: TButton;
    PopupMenu: TPopupMenu;
    LNK_LST_MENU_N1: TMenuItem;
    N19: TMenuItem;
    LNK_LST_MENU_N3: TMenuItem;
    LNK_LST_MENU_N4: TMenuItem;
    N3: TMenuItem;
    LNK_LST_MENU_N8: TMenuItem;
    LNK_LST_MENU_N9: TMenuItem;
    N6: TMenuItem;
    LNK_LST_MENU_N5: TMenuItem;
    LNK_LST_MENU_N6: TMenuItem;
    N9: TMenuItem;
    LNK_LST_MENU_N15: TMenuItem;
    GeneralMenu: TPopupMenu;
    LNK_GEN_MENU_N2: TMenuItem;
    LNK_GEN_MENU_N3: TMenuItem;
    N18: TMenuItem;
    LNK_GEN_MENU_N5: TMenuItem;
    ImageList1: TImageList;
    Bevel1: TBevel;
    LNK_BTN2: TButton;
    N11: TMenuItem;
    LNK_LST_MENU_N7: TMenuItem;
    ToolBar1: TToolBar;
    Bevel2: TBevel;
    LNK_GEN_MENU_N6: TMenuItem;
    N13: TMenuItem;
    LNK_GEN_MENU_N1: TMenuItem;
    LNK_LST_MENU_N2: TMenuItem;
    N20: TMenuItem;
    LNK_SPD_BTN1: TSpeedButton;
    LNK_LST_MENU_N10: TMenuItem;
    N25: TMenuItem;
    LNK_LST_MENU_N11: TMenuItem;
    LNK_LST_MENU_N12: TMenuItem;
    LNK_GEN_MENU_N4: TMenuItem;
    FindEdit: TEdit;
    ImageList2: TImageList;
    LNK_LST_MENU_N13: TMenuItem;
    Jumbo1: TMenuItem;
    ExtraLarge1: TMenuItem;
    Normal1: TMenuItem;
    Small1: TMenuItem;
    N26: TMenuItem;
    LNK_LST_MENU_N14: TMenuItem;
    Tile1: TMenuItem;
    Icon1: TMenuItem;
    LNK_BTN3: TButton;
    LNK_LST_MENU_N3_N1: TMenuItem;
    LNK_LST_MENU_N3_N2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TabsChange(Sender: TObject);
    procedure ListDblClick(Sender: TObject);
    procedure LNK_BTN1Click(Sender: TObject);
    procedure LNK_SPD_BTN3Click(Sender: TObject);
    procedure LNK_LST_MENU_N15Click(Sender: TObject);
    procedure LNK_GEN_MENU_N2Click(Sender: TObject);
    procedure LNK_GEN_MENU_N3Click(Sender: TObject);
    procedure LNK_LST_MENU_N4Click(Sender: TObject);
    procedure LNK_LST_MENU_N8Click(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure LNK_GEN_MENU_N5Click(Sender: TObject);
    procedure GeneralMenuPopup(Sender: TObject);
    procedure LNK_BTN2Click(Sender: TObject);
    procedure LNK_BTN1DropDownClick(Sender: TObject);
    procedure LNK_BTN2DropDownClick(Sender: TObject);
    procedure LNK_LST_MENU_N7Click(Sender: TObject);
    procedure ListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LNK_GEN_MENU_N6Click(Sender: TObject);
    procedure LNK_GEN_MENU_N1Click(Sender: TObject);
    procedure LNK_LST_MENU_N2Click(Sender: TObject);
    procedure LNK_SPD_BTN1Click(Sender: TObject);
    procedure LNK_LST_MENU_N11Click(Sender: TObject);
    procedure LNK_LST_MENU_N12Click(Sender: TObject);
    procedure LNK_GEN_MENU_N4Click(Sender: TObject);
    procedure FindEditChange(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure LNK_BTN3DropDownClick(Sender: TObject);
    procedure LNK_BTN3Click(Sender: TObject);
    procedure LNK_LST_MENU_N3_N2Click(Sender: TObject);
    procedure LNK_LST_MENU_N3_N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    InsertItem: TListItem;
    FLists: TMemIniFile;
    FPopup: TPopupMenu;
    function GetFLists: TMemIniFile;
    procedure ListPath;
    procedure RegIni(Write: Boolean);
    procedure ChangeIcons(Size: Integer);
    procedure DriveOnClick(Sender: TObject);
    procedure ControlPanelOnClick(Sender: TObject);
    procedure RecycleOnClick(Sender: TObject);
    procedure ToolBarOnClick(Sender: TObject);
    procedure copyitemclick(Sender: TObject);
    procedure moveitemclick(Sender: TObject);
    procedure deleteitemclick(Sender: TObject);
    procedure Translate(aLanguageID: String);
    procedure OpenFileDir(DialogTitle: String; isFileName: Boolean);
  protected
    procedure WndProc(var Msg: TMessage); message WM_ACTIVATE;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure WMMoving(var Msg: TWMMoving); message WM_MOVING;
    procedure WMDropFiles(var Msg: TWMDropFiles); message wm_DropFiles;
  end;

var
  LNK_Form: TLNK_Form;
  AClose: Boolean = False;
  PosLocked: Boolean = True;
  ON_DragOnDrop: Boolean = False;
  CurrentTab: Integer;//Ctrl+Tab
  CurrentIconSize: Integer = 0;
  CurrentIconStyle: Integer = 0;

implementation

uses LNK_Properties, Unit1, ShutdownUnit, HotKeyChanger, HotKeyManager,
     Translation, SystemUtils;

{$R *.dfm}

// SOME FUNCTIONS
//------------------------------------------------------------------------------
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
     AddIconsToList(IconLocation, ImageList2, CurrentIconStyle);
     InsertItem.ImageIndex := ImageList2.Count-1;
  end;
end;
end;

procedure ADDControlPanelList(PopupMenu: TPopupMenu; Config: TMemIniFile; OnClick: TNotifyEvent);
var
  MenuItem : TMenuItem;
begin
  PopupMenu.Items.Clear;

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG2,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}"';
  MenuItem.OnClick := OnClick;
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG3,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{21EC2020-3AEA-1069-A2DD-08002B30309D}"';
  MenuItem.OnClick := OnClick;
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG4,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{ED7BA470-8E54-465E-825C-99712043E01C}"';
  MenuItem.OnClick := OnClick;
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := '-';
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG5,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{74246bfc-4c96-11d0-abef-0020af6b0b7a}"';
  MenuItem.OnClick := OnClick;
  PopupMenu.Items.Add(MenuItem);

  MenuItem := TMenuItem.Create(PopupMenu);
  MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG6,Config.ReadString('General','Language',EN_US));
  MenuItem.Hint := '/root,"shell:::{BB06C0E4-D293-4f75-8A90-CB05B6477EEE}"';
  MenuItem.OnClick := OnClick;
  PopupMenu.Items.Add(MenuItem);
end;

procedure GetPersonalFolders(ToolBar: TToolBar; Config: TMemIniFile; OnClick: TNotifyEvent);
var
 I: Integer;
begin
  //Delete all buttons
  for I := ToolBar.ButtonCount - 1 downto 0 do
  ToolBar.Buttons[I].Free;
  //Create buttons
  AddButtonToToolbar(OnClick, ToolBar,_(LNK_UTILS_GLOBAL_TEXT_MSG7,Config.ReadString('General','Language',EN_US)),GetSpecialFolderLocation(-1, FOLDERID_Desktop),4,0);
  AddButtonToToolbar(OnClick, ToolBar,_(LNK_UTILS_GLOBAL_TEXT_MSG8,Config.ReadString('General','Language',EN_US)),GetSpecialFolderLocation(-1, FOLDERID_Documents),5,1);
  AddButtonToToolbar(OnClick, ToolBar,_(LNK_UTILS_GLOBAL_TEXT_MSG9,Config.ReadString('General','Language',EN_US)),GetSpecialFolderLocation(-1, FOLDERID_Downloads),6,2);
  AddButtonToToolbar(OnClick, ToolBar,_(LNK_UTILS_GLOBAL_TEXT_MSG10,Config.ReadString('General','Language',EN_US)),GetSpecialFolderLocation(-1, FOLDERID_Music),7,3);
  AddButtonToToolbar(OnClick, ToolBar,_(LNK_UTILS_GLOBAL_TEXT_MSG11,Config.ReadString('General','Language',EN_US)),GetSpecialFolderLocation(-1, FOLDERID_Pictures),8,4);
  AddButtonToToolbar(OnClick, ToolBar,_(LNK_UTILS_GLOBAL_TEXT_MSG12,Config.ReadString('General','Language',EN_US)),GetSpecialFolderLocation(-1, FOLDERID_SavedGames),9,5);
  AddButtonToToolbar(OnClick, ToolBar,_(LNK_UTILS_GLOBAL_TEXT_MSG13,Config.ReadString('General','Language',EN_US)),GetSpecialFolderLocation(-1, FOLDERID_Videos),10,6);
end;
//------------------------------------------------------------------------------

procedure TLNK_Form.Translate(aLanguageID: String);
var
 TempInteger: Integer;
begin
  LNK_GEN_MENU_N1.Caption := _(LNK_CPTN_MENUITEM_GEN_N1, aLanguageID);
  LNK_GEN_MENU_N2.Caption := _(LNK_CPTN_MENUITEM_GEN_N2, aLanguageID);
  LNK_GEN_MENU_N3.Caption := _(LNK_CPTN_MENUITEM_GEN_N3, aLanguageID);
  LNK_GEN_MENU_N4.Caption := _(LNK_CPTN_MENUITEM_GEN_N4, aLanguageID);
  LNK_GEN_MENU_N5.Caption := _(LNK_CPTN_MENUITEM_GEN_N5, aLanguageID);
  LNK_GEN_MENU_N6.Caption := _(GLOBAL_CPTN_MENUITEM_Main_N2, aLanguageID);
  LNK_LST_MENU_N1.Caption := _(LNK_CPTN_MENUITEM_LST_N1, aLanguageID);
  LNK_LST_MENU_N2.Caption := _(LNK_CPTN_MENUITEM_LST_N2, aLanguageID);
  LNK_LST_MENU_N3.Caption := _(LNK_CPTN_MENUITEM_LST_N3, aLanguageID);
  LNK_LST_MENU_N3_N1.Caption := _(LNK_CPTN_MENUITEM_LST_N3_N1, aLanguageID);
  LNK_LST_MENU_N3_N2.Caption := _(LNK_CPTN_MENUITEM_LST_N3_N2, aLanguageID);
  LNK_LST_MENU_N4.Caption := _(LNK_CPTN_MENUITEM_LST_N4, aLanguageID);
  LNK_LST_MENU_N5.Caption := _(LNK_CPTN_MENUITEM_LST_N5, aLanguageID);
  LNK_LST_MENU_N6.Caption := _(LNK_CPTN_MENUITEM_LST_N6, aLanguageID);
  LNK_LST_MENU_N7.Caption := _(LNK_CPTN_MENUITEM_LST_N7, aLanguageID);
  LNK_LST_MENU_N8.Caption := _(LNK_CPTN_MENUITEM_LST_N8, aLanguageID);
  LNK_LST_MENU_N9.Caption := _(LNK_CPTN_MENUITEM_LST_N9, aLanguageID);
  LNK_LST_MENU_N10.Caption := _(LNK_CPTN_MENUITEM_LST_N10, aLanguageID);
  LNK_LST_MENU_N11.Caption := _(LNK_CPTN_MENUITEM_LST_N11, aLanguageID);
  LNK_LST_MENU_N12.Caption := _(LNK_CPTN_MENUITEM_LST_N12, aLanguageID);
  LNK_LST_MENU_N13.Caption := _(LNK_CPTN_MENUITEM_LST_N13, aLanguageID);
  Small1.Caption := _(LNK_CPTN_MENUITEM_LST_SMALL, aLanguageID);
  Normal1.Caption := _(LNK_CPTN_MENUITEM_LST_Normal, aLanguageID);
  ExtraLarge1.Caption := _(LNK_CPTN_MENUITEM_LST_ExtraLarge, aLanguageID);
  Jumbo1.Caption := _(LNK_CPTN_MENUITEM_LST_Jumbo, aLanguageID);
  LNK_LST_MENU_N14.Caption := _(LNK_CPTN_MENUITEM_LST_N14, aLanguageID);
  Icon1.Caption := _(LNK_CPTN_MENUITEM_LST_ICON, aLanguageID);
  Tile1.Caption := _(LNK_CPTN_MENUITEM_LST_TILE, aLanguageID);
  LNK_LST_MENU_N15.Caption := _(LNK_CPTN_MENUITEM_LST_N15, aLanguageID);
  LNK_SPD_BTN1.Hint := _(GLOBAL_HINT_IMG_TimerImg, aLanguageID);
  LNK_BTN1.Hint := _(LNK_HINT_BTN_BTN1, aLanguageID);
  LNK_BTN2.Hint := _(LNK_HINT_BTN_BTN2, aLanguageID);
  LNK_BTN3.Hint := _(LNK_HINT_SPDBTN_BTN2, aLanguageID);
  LNK_SPD_BTN3.Hint := _(GLOBAL_HINT_CAPT_BTN1, aLanguageID)+' (Esc)';
  //Create buttons
  GetPersonalFolders(ToolBar1, MainForm.FConfig, ToolBarOnClick);
end;

//Window procedure.............................................................
procedure TLNK_Form.WndProc(var Msg: TMessage);
begin
  inherited;
  if Msg.WParam = WA_INACTIVE then
  if ON_DragOnDrop = False then
   begin
    Hide;
   end;
end;

procedure TLNK_Form.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    Style := (Style OR WS_POPUP) AND NOT WS_DLGFRAME;
end;

procedure TLNK_Form.WMMoving(var Msg: TWMMoving) ;
var
  workArea: TRect;
begin
if PosLocked = True then
 begin
  workArea := Screen.WorkareaRect;

  with Msg.DragRect^ do
  begin
    if Left < workArea.Left then
      OffsetRect(Msg.DragRect^, workArea.Left - Left, 0) ;

    if Top < workArea.Top then
      OffsetRect(Msg.DragRect^, 0, workArea.Top - Top) ;

    if Right > workArea.Right then
      OffsetRect(Msg.DragRect^, workArea.Right - Right, 0) ;

    if Bottom > workArea.Bottom then
      OffsetRect(Msg.DragRect^, 0, workArea.Bottom - Bottom) ;
  end;
 end;

  inherited;
end;

procedure TLNK_Form.WMDropFiles(var Msg: TWMDropFiles);
var
 HF: THandle;
 i, FileCount: integer;
 p: TPoint;
 s: array [0..1023] of Widechar;
 FileDir, WorkingDirPath: String;
begin
 if (Caption <> '') then
  begin
   HF := Msg.Drop;
   FileCount := DragQueryFile(HF, $FFFFFFFF, nil, 0);
   for i := 0 to FileCount - 1 do
    begin
     DragQueryFile(HF, i, s, sizeof(s));
     //if File is .lnk extract filename from lnk information
     if ExtractFileExt(s) = '.lnk' then
     begin
      FileDir := WideUpperCase(PathFromLNK(s));
      WorkingDirPath := WideUpperCase(WorkingDirFromLNK(s));
      if WorkingDirPath = ExtractFileDir(FileDir) then
      WorkingDirPath := '';
      //if is .lnk then extractfiledir from file
      if FileExists(FileDir) then
      AddItem(Tabs.Tabs[Tabs.TabIndex],ExtractFileName(ChangeFileExt(s,'')),
              FileDir,'',FileDir,WorkingDirPath)
      else
      //else if is dir write curently dir
      AddItem(Tabs.Tabs[Tabs.TabIndex],ExtractFileName(ChangeFileExt(s,'')),
              FileDir,'',FileDir,'');
     end else
      //if not File .lnk to read filename from file
      AddItem(Tabs.Tabs[Tabs.TabIndex],ExtractFileName(ChangeFileExt(s,'')),
              WideUpperCase(s),'',WideUpperCase(s),'');
    end;
    DragFinish(HF);
  end;
end;

//Some functions and procedure.................................................

procedure TLNK_Form.ChangeIcons(Size: Integer);
begin
case Size of
0:
 begin
  ImageList2.Height := 32;
  ImageList2.Width := 32;
  CurrentIconSize := SHIL_LARGE;
 end;
1:
 begin
  ImageList2.Height := 16;
  ImageList2.Width := 16;
  CurrentIconSize := SHIL_SMALL;
 end;
2:
 begin
  ImageList2.Height := 48;
  ImageList2.Width := 48;
  CurrentIconSize := SHIL_EXTRALARGE;
 end;
4:
 begin
  ImageList2.Height := 256;
  ImageList2.Width := 256;
  CurrentIconSize := SHIL_JUMBO;
 end;
end;
SendMessage(List.Handle, LVM_SETIMAGELIST, LVSIL_NORMAL, ImageList2.Handle);
end;

procedure TLNK_Form.ListPath;
var
 i: integer;
 StringList: TStringList;
begin
 StringList := TStringList.Create;
  try
   List.Items.Clear;
   ImageList2.Clear;
   FLists.ReadSection(Tabs.Tabs[Tabs.TabIndex],StringList);
   for I := 0 to StringList.Count - 1 do
   begin
    InsertItem := List.Items.Add;
    InsertItem.Caption:= StringList[I];
    StrToList(FLists.ReadString(Tabs.Tabs[Tabs.TabIndex], StringList[I], ''),'|',InsertItem.SubItems);
    AddIconsToList(InsertItem.SubItems[2], ImageList2, CurrentIconStyle);
    InsertItem.ImageIndex := i;
   end;
  finally
   StringList.Free;
  end;
end;

//Save/Load config from INI....................................................

function TLNK_Form.GetFLists: TMemIniFile;
begin
  if FLists = nil then
  FLists := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + CurrentUserName + '.ablst',TEncoding.UTF8);
  Result := FLists;
end;

procedure TLNK_Form.RegIni(Write: Boolean);
begin
if Write = true then
 begin
  MainForm.FConfig.WriteInteger('General','LNKForm_Top',Top);
  MainForm.FConfig.WriteInteger('General','LNKForm_Left',Left);
  MainForm.FConfig.WriteInteger('General','LNKForm_Width',Width);
  MainForm.FConfig.WriteInteger('General','LNKForm_Height',Height);
  MainForm.FConfig.WriteString('General','LNKForm_Section',Caption);
  MainForm.FConfig.WriteBool('General','LNKForm_OffScreenPos',LNK_GEN_MENU_N4.Checked);
  MainForm.FConfig.WriteBool('General','LNKForm_DragOnDrop',LNK_GEN_MENU_N2.Checked);
  MainForm.FConfig.WriteBool('General','LNKForm_HideWhenRun',LNK_GEN_MENU_N3.Checked);
  MainForm.FConfig.WriteInteger('General','LNKForm_IconSize',CurrentIconSize);
  MainForm.FConfig.WriteInteger('General','LNKForm_IconStyle',CurrentIconStyle);
  MainForm.FConfig.UpdateFile;
 end else
 begin
  Top := MainForm.FConfig.ReadInteger('General','LNKForm_Top',Top);
  Left := MainForm.FConfig.ReadInteger('General','LNKForm_Left',Left);
  Width := MainForm.FConfig.ReadInteger('General','LNKForm_Width',Width);
  Height := MainForm.FConfig.ReadInteger('General','LNKForm_Height',Height);
  Caption := MainForm.FConfig.ReadString('General','LNKForm_Section','');
  if Caption <> '' then
  Tabs.TabIndex := FindString(Tabs.Tabs,Caption);
  LNK_GEN_MENU_N4.Checked := MainForm.FConfig.ReadBool('General','LNKForm_OffScreenPos',True);
  PosLocked := MainForm.FConfig.ReadBool('General','LNKForm_OffScreenPos',True);
  LNK_GEN_MENU_N2.Checked := MainForm.FConfig.ReadBool('General','LNKForm_DragOnDrop',False);
  ON_DragOnDrop := MainForm.FConfig.ReadBool('General','LNKForm_DragOnDrop',False);
  LNK_GEN_MENU_N3.Checked := MainForm.FConfig.ReadBool('General','LNKForm_HideWhenRun',False);
  ChangeIcons(MainForm.FConfig.ReadInteger('General','LNKForm_IconSize',0));
  CurrentIconSize := MainForm.FConfig.ReadInteger('General','LNKForm_IconSize',0);
  CurrentIconStyle := MainForm.FConfig.ReadInteger('General','LNKForm_IconStyle',0);
    case CurrentIconStyle of
     0: List.ViewStyle := vsIcon;
     1: List.ViewStyle := vsTile;
    end;
 end;
end;

//MainForm......................................................................

procedure TLNK_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if AClose = false then
 begin
  Action := caNone;
 end else Action := caFree;
end;

procedure TLNK_Form.FormCreate(Sender: TObject);
begin
FPopup := TPopupMenu.Create(Self);
LNK_BTN1.DropDownMenu := FPopup;
LNK_BTN2.DropDownMenu := FPopup;
LNK_BTN3.DropDownMenu := FPopup;
FPopup.OwnerDraw := True;
List.ShowColumnHeaders := False;
InsertItem := List.Items.Add;
GetFLists;
//Read sections
ReadDirectory(Tabs.Tabs, FLists);
//Read from config file
RegIni(False);
//if not exists tabs to create systems tabs
if Tabs.Tabs.Count = 0 then
 begin
  LNK_LST_MENU_N11Click(Sender);
  LNK_LST_MENU_N12Click(Sender);
 end;
TabsChange(Sender);
DragAcceptFiles(LNK_Form.Handle,true);
GetPersonalFolders(ToolBar1, MainForm.FConfig, ToolBarOnClick);
AddIconsToImgList(ImageList1);
Translate(MainForm.FConfig.ReadString('General','Language',EN_US));
end;

procedure TLNK_Form.FormDestroy(Sender: TObject);
begin
RegIni(True);
FLists.Free;
FPopup.Free;
end;

procedure TLNK_Form.FormResize(Sender: TObject);
begin
LNK_SPD_BTN3.Left := LNK_Form.Width - LNK_SPD_BTN3.Width - 20;
end;

procedure TLNK_Form.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = ORD(VK_ESCAPE) then Hide;

//Ctrl+Tab to change tabs
if (ssCtrl in Shift) and (Ord(Key) = VK_TAB) then
   begin
      if ssShift in Shift then
         if Tabs.tabIndex > 0 then
            Tabs.TabIndex := Tabs.tabIndex - 1
         else
            Tabs.TabIndex := Tabs.tabs.Count - 1
         //end if
      else
         if Tabs.tabIndex < Tabs.Tabs.Count - 1 then
            Tabs.TabIndex := Tabs.tabIndex + 1
         else
            Tabs.TabIndex := 0;
         //end if
      //end if
      FocusControl(Tabs);
      Tabs.OnChange(self);
   end;
end;

//Components....................................................................

procedure TLNK_Form.ListDblClick(Sender: TObject);
var
 WorkingDir : String;
begin
if List.Selected <> nil then
 begin
  if List.Selected.SubItems[3] <> '' then
  WorkingDir := List.Selected.SubItems[3] else
  WorkingDir := ExtractFilePath(List.Selected.SubItems[0]);
  RunApplication(List.Selected.SubItems[0],List.Selected.SubItems[1],
                 WorkingDir);
  if (LNK_GEN_MENU_N3.Checked) then Hide;
 end;
end;

procedure TLNK_Form.ListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = ORD(VK_RETURN) then ListDblClick(Sender);
if Key = ORD(VK_DELETE) then LNK_LST_MENU_N4Click(Sender);
if Shift = [ssCtrl] then
 begin
  case Key of
   Ord('N'): LNK_LST_MENU_N3_N1Click(Sender);
   Ord('D'): LNK_LST_MENU_N3_N2Click(Sender);
   Ord('P'): LNK_LST_MENU_N7Click(Sender);
   Ord('F'): LNK_LST_MENU_N8Click(Sender);
   Ord('L'): LNK_LST_MENU_N2Click(Sender);
  end;
 end;
if (Shift = [ssAlt]) and (Key = ORD(VK_RETURN)) then LNK_LST_MENU_N15Click(Sender);
end;

procedure TLNK_Form.TabsChange(Sender: TObject);
begin
if Tabs.Tabs.Count <> -1 then
 begin
  ChangeIcons(CurrentIconSize);
  ListPath;
  Caption := Tabs.Tabs[Tabs.TabIndex];
  MainForm.FavTray.Hint := Tabs.Tabs[Tabs.TabIndex];
  FindEdit.Text := '';
 end;
end;

procedure TLNK_Form.LNK_BTN1Click(Sender: TObject);
var
 AFile: String;
begin
AFile := GetSpecialFolderLocation(-1, FOLDERID_Windows)+'\explorer.exe';
RunApplication(AFile, '/root,"shell:::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"',
               PChar(ExtractFilePath(AFile)), SW_MAXIMIZE);
end;

procedure TLNK_Form.LNK_BTN2Click(Sender: TObject);
var
 AFile: String;
begin
AFile := GetSpecialFolderLocation(-1, FOLDERID_Windows)+'\explorer.exe';
RunApplication(AFile, 'ms-settings:',PChar(ExtractFilePath(AFile)), SW_MAXIMIZE);
end;

procedure TLNK_Form.LNK_BTN3Click(Sender: TObject);
var
 AFile: String;
begin
AFile := GetSpecialFolderLocation(-1, FOLDERID_Windows)+'\explorer.exe';
RunApplication(AFile, '/root,"shell:::{645FF040-5081-101B-9F08-00AA002F954E}"',
               PChar(ExtractFilePath(AFile)), SW_MAXIMIZE);
end;

procedure TLNK_Form.LNK_SPD_BTN3Click(Sender: TObject);
begin
Hide;
end;

procedure TLNK_Form.LNK_SPD_BTN1Click(Sender: TObject);
begin
if not ShutdownForm.Showing then
 begin
  //ShutdownForm.ParentWindow := MainForm.Handle;
  ShutdownForm.Position := poDesktopCenter;
  ShutdownForm.Show;
  SetForegroundWindow(ShutdownForm.Handle);
 end else ShutdownForm.Close;
end;

procedure TLNK_Form.PanelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
  sc_DragMove = $F012;
begin
  ReleaseCapture;
  Perform( wm_SysCommand, sc_DragMove, 0 );
end;

procedure TLNK_Form.FindEditChange(Sender: TObject);
begin
if FindEdit.Text = '' then TabsChange(Self) else
 begin
  FindTextFromTXT(ExtractFilePath(Application.ExeName) + CurrentUserName + '.ablst',
                  FindEdit.Text, List, FLists, ImageList2, CurrentIconStyle);
  List.SortType := stText;
  ChangeIcons(CurrentIconSize);
  Caption := Tabs.Tabs[Tabs.TabIndex];
  MainForm.FavTray.Hint := Tabs.Tabs[Tabs.TabIndex];
 end;
end;

//Menu items....................................................................

procedure TLNK_Form.LNK_LST_MENU_N15Click(Sender: TObject);
var
  Index: WORD;
begin
with Properties do
  begin
   ActiveControl := LNKPROP_EDIT1;
   LNKPROP_EDIT2.Text := List.Selected.SubItems[0];
   LNKPROP_EDIT1.Text := List.Selected.Caption;
   LNKPROP_EDIT3.Text := List.Selected.SubItems[1];
   LNKPROP_EDIT5.Text := List.Selected.SubItems[2];
   LNKPROP_EDIT4.Text := List.Selected.SubItems[3];
   Index := 0;
   // if icon location is empty to load icon from exe
   if LNKPROP_EDIT5.Text = '' then
   Image1.Picture.Icon.Handle := ExtractAssociatedIcon(hInstance,PChar(LNKPROP_EDIT2.Text),Index)
   else
   Image1.Picture.Icon.Handle := ExtractAssociatedIcon(hInstance,PChar(LNKPROP_EDIT5.Text),Index);
   if (ShowModal <> mrCancel) {and (LNKPROP_EDIT2.Text <> '') and (LNKPROP_EDIT1.Text <> '')} then
    begin
     FLists.DeleteKey(LNK_Form.Caption,List.Selected.Caption);
     FLists.UpdateFile;
     List.DeleteSelected;
     AddItem(Tabs.Tabs[Tabs.TabIndex],LNKPROP_EDIT1.Text,LNKPROP_EDIT2.Text,LNKPROP_EDIT3.Text,LNKPROP_EDIT5.Text,LNKPROP_EDIT4.Text);
    end;
  end;
end;

procedure TLNK_Form.OpenFileDir(DialogTitle: String; isFileName: Boolean);
var
 sFileName, NewFilePath, WorkingDirPath, IconPath: String;
 Title, FileName, OKName: PChar;
begin
Title := PChar(_(DialogTitle, MainForm.FConfig.ReadString('General','Language',EN_US)));
FileName := PChar(_(LNK_GLOBAL_TEXT_MSG4, MainForm.FConfig.ReadString('General','Language',EN_US)));
OKName := PChar(_(PROC_CPTN_BTN_BTN2, MainForm.FConfig.ReadString('General','Language',EN_US)));
  if OpenFileDialog(Title, FileName, OKName, isFileName, sFileName) then
   begin
    if ExtractFileExt(sFileName) = '.lnk' then
     begin
      NewFilePath := WideUpperCase(PathFromLNK(sFileName));
      WorkingDirPath := WideUpperCase(WorkingDirFromLNK(sFileName));
      if WorkingDirPath = ExtractFileDir(NewFilePath) then
      WorkingDirPath := '';
      //if is .lnk then extractfiledir from file
      if FileExists(NewFilePath) then
      AddItem(Tabs.Tabs[Tabs.TabIndex],ExtractFileName(ChangeFileExt(sFileName,'')),
              NewFilePath, '', NewFilePath, WorkingDirPath)
      else
      //else if is dir write curently dir
      AddItem(Tabs.Tabs[Tabs.TabIndex],ExtractFileName(ChangeFileExt(sFileName,'')),
              NewFilePath, '', NewFilePath, WorkingDirPath)
     end else
      //if not File .lnk to read filename from file
      AddItem(Tabs.Tabs[Tabs.TabIndex],ExtractFileName(ChangeFileExt(sFileName,'')),
              WideUpperCase(sFileName), '', WideUpperCase(sFileName), '');
   end;
end;

procedure TLNK_Form.LNK_LST_MENU_N3_N1Click(Sender: TObject);
begin
OpenFileDir(GLOBAL_TEXT_DIAG1, True);
end;

procedure TLNK_Form.LNK_LST_MENU_N3_N2Click(Sender: TObject);
begin
OpenFileDir(GLOBAL_TEXT_DIAG2, False);
end;

procedure TLNK_Form.LNK_LST_MENU_N4Click(Sender: TObject);
begin
if (MessageBox(LNK_Form.Handle,PChar(_(LNK_GLOBAL_TEXT_MSG2,MainForm.FConfig.ReadString('General','Language',EN_US))+List.Selected.Caption+' ?'), PChar(ExtractFileName(ChangeFileExt(ParamStr(0),''))), MB_OKCANCEL) = IDOK) then
 begin
  FLists.DeleteKey(Tabs.Tabs[Tabs.TabIndex],List.Selected.Caption);
  FLists.UpdateFile;
  List.DeleteSelected;
 end;
end;

procedure TLNK_Form.LNK_LST_MENU_N8Click(Sender: TObject);
var
 NewTabStr,Transl1,Transl2: String;
begin
Transl1 := _(LNK_GLOBAL_TEXT_MSG3,MainForm.FConfig.ReadString('General','Language',EN_US));
Transl2 := _(LNK_GLOBAL_TEXT_MSG4,MainForm.FConfig.ReadString('General','Language',EN_US));
if InputQuery(Transl1, Transl2, NewTabStr) then
if NewTabStr <> '' then
if FLists.SectionExists(NewTabStr) then
ShowMessage(_(LNK_GLOBAL_TEXT_MSG5,MainForm.FConfig.ReadString('General','Language',EN_US))) else
 begin
  FLists.WriteString(NewTabStr,'Temp','');
  FLists.DeleteKey(NewTabStr,'Temp');
  FLists.UpdateFile;
  Tabs.Tabs.Add(NewTabStr);
  if (Tabs.Tabs.Count <> -1 ) then
   begin
    LNK_Form.Caption := NewTabStr;
    MainForm.FavTray.Hint := NewTabStr;
    Tabs.TabIndex := FindString(Tabs.Tabs,LNK_Form.Caption);
    TabsChange(Sender)
   end;
 end;
end;

procedure TLNK_Form.copyitemclick(Sender: TObject);
var
 ACaption: String;
begin
ACaption := StringReplace(TMenuItem(Sender).Caption, '&', '', [rfReplaceAll]);
if LNK_Form.Caption <> ACaption then
begin
 ACaption := StringReplace(TMenuItem(Sender).Caption, '&', '', [rfReplaceAll]);
 FLists.WriteString(ACaption,List.Selected.Caption,
 List.Selected.SubItems[0]+'|'+List.Selected.SubItems[1]+'|'+
 List.Selected.SubItems[2]+'|'+List.Selected.SubItems[3]+'|');
 FLists.UpdateFile;
end;
end;

procedure TLNK_Form.moveitemclick(Sender: TObject);
var
 ACaption: String;
begin
ACaption := StringReplace(TMenuItem(Sender).Caption, '&', '', [rfReplaceAll]);
if LNK_Form.Caption <> ACaption then
begin
 ACaption := StringReplace(TMenuItem(Sender).Caption, '&', '', [rfReplaceAll]);
 FLists.WriteString(ACaption,List.Selected.Caption,
 List.Selected.SubItems[0]+'|'+List.Selected.SubItems[1]+'|'+
 List.Selected.SubItems[2]+'|'+List.Selected.SubItems[3]+'|');
 FLists.DeleteKey(LNK_Form.Caption,List.Selected.Caption);
 FLists.UpdateFile;
 List.DeleteSelected;
end;
end;

procedure TLNK_Form.deleteitemclick(Sender: TObject);
var
 ACaption: String;
begin
ACaption := StringReplace(TMenuItem(Sender).Caption, '&', '', [rfReplaceAll]);
if (MessageBox(LNK_Form.Handle,PChar(_(LNK_GLOBAL_TEXT_MSG6,MainForm.FConfig.ReadString('General','Language',EN_US))+ACaption+' ?'),
    PChar(ExtractFileName(ChangeFileExt(ParamStr(0),''))), MB_OKCANCEL) = IDOK) then
begin
FLists.EraseSection(ACaption);
FLists.UpdateFile;
DeleteAt(Tabs,FindString(Tabs.Tabs,ACaption));
if LNK_Form.Caption = ACaption then
 begin
  if Tabs.Tabs.Count = 0 then
   begin
    LNK_LST_MENU_N11Click(Sender);
    LNK_LST_MENU_N12Click(Sender);
   end else
   begin
    Tabs.TabIndex := 0;
    TabsChange(Sender);
   end;
 end;
end;
end;

procedure TLNK_Form.LNK_GEN_MENU_N4Click(Sender: TObject);
begin
with Sender as TMenuItem do
  begin
    Checked := not Checked;
    PosLocked := Checked;
  end;
end;

procedure TLNK_Form.LNK_GEN_MENU_N2Click(Sender: TObject);
begin
with Sender as TMenuItem do
  begin
    Checked := not Checked;
    ON_DragOnDrop := Checked;
  end;
end;

procedure TLNK_Form.LNK_GEN_MENU_N3Click(Sender: TObject);
begin
with Sender as TMenuItem do Checked := not Checked;
end;

procedure TLNK_Form.N28Click(Sender: TObject);
begin
 case MainForm.FConfig.ReadInteger('General','LNKForm_IconSize',0) of
  0: Normal1.Checked := True;
  1: Small1.Checked := True;
  2: ExtraLarge1.Checked := True;
  4: Jumbo1.Checked := True;
 end;
end;

procedure TLNK_Form.N26Click(Sender: TObject);
begin
with Sender as TMenuItem do
  begin
    CurrentIconSize := StrToInt(Hint);
    TabsChange(Self);
    MainForm.FConfig.WriteInteger('General','LNKForm_IconSize',CurrentIconSize);
    MainForm.FConfig.UpdateFile;
  end;
end;

procedure TLNK_Form.N32Click(Sender: TObject);
begin
 case MainForm.FConfig.ReadInteger('General','LNKForm_IconStyle',0) of
  0: Icon1.Checked := True;
  1: Tile1.Checked := True;
 end;
end;

procedure TLNK_Form.N33Click(Sender: TObject);
begin
 with Sender as TMenuItem do
  begin
    CurrentIconStyle := StrToInt(Hint);
    case CurrentIconStyle of
     0: List.ViewStyle := vsIcon;
     1: List.ViewStyle := vsTile;
    end;
    ChangeIcons(CurrentIconSize);
    MainForm.FConfig.WriteInteger('General','LNKForm_IconStyle',CurrentIconStyle);
    MainForm.FConfig.UpdateFile;
  end;
end;

procedure TLNK_Form.PopupMenuPopup(Sender: TObject);
begin
 if List.Selected <> nil then LNK_LST_MENU_N4.Enabled := True else LNK_LST_MENU_N4.Enabled := False;
 if List.Selected <> nil then LNK_LST_MENU_N6.Enabled := True else LNK_LST_MENU_N6.Enabled := False;
 if Caption = '' then LNK_LST_MENU_N3.Enabled := False else LNK_LST_MENU_N3.Enabled := True;
 if Caption = '' then LNK_LST_MENU_N9.Enabled := False else LNK_LST_MENU_N9.Enabled := True;
 if List.Selected <> nil then LNK_LST_MENU_N1.Enabled := True else LNK_LST_MENU_N1.Enabled := False;
 if List.Selected <> nil then LNK_LST_MENU_N2.Enabled := True else LNK_LST_MENU_N2.Enabled := False;
 if List.Selected <> nil then LNK_LST_MENU_N7.Enabled := True else LNK_LST_MENU_N7.Enabled := False;
 if List.Selected <> nil then LNK_LST_MENU_N5.Enabled := True else LNK_LST_MENU_N5.Enabled := False;
 if List.Selected <> nil then LNK_LST_MENU_N15.Enabled := True else LNK_LST_MENU_N15.Enabled := False;
 if List.Selected <> nil then AddMenuItem(LNK_LST_MENU_N5, Tabs, copyitemclick);
 if List.Selected <> nil then AddMenuItem(LNK_LST_MENU_N6, Tabs, moveitemclick);
 AddMenuItem(LNK_LST_MENU_N9, Tabs, deleteitemclick);
end;

procedure TLNK_Form.DriveOnClick(Sender: TObject);
var
 AHint: String;
begin
 with Sender as TMenuItem do
  begin
   AHint := StringReplace(Hint, '&', '', [rfReplaceAll]);
   RunApplication(AHint,'', PChar(ExtractFilePath(AHint)));
  end;
end;

procedure TLNK_Form.ControlPanelOnClick(Sender: TObject);
var
 AHint, AFile: String;
begin
 with Sender as TMenuItem do
  begin
   AHint := StringReplace(Hint, '&', '', [rfReplaceAll]);
   AFile := GetSpecialFolderLocation(-1, FOLDERID_Windows)+'\explorer.exe';
   RunApplication(AFile, AHint, PChar(ExtractFilePath(AFile)), SW_MAXIMIZE);
  end;
end;

procedure TLNK_Form.RecycleOnClick(Sender: TObject);
begin
 if DeleteRecycleBinFiles() = 0 then
 LNK_BTN3.ImageIndex := 3;
end;

procedure TLNK_Form.ToolBarOnClick(Sender: TObject);
begin
 RunApplication(TToolButton(Sender).Caption,'',
                ExtractFilePath(TToolButton(Sender).Caption), SW_MAXIMIZE);
 if (LNK_GEN_MENU_N3.Checked) then Hide;
end;

procedure TLNK_Form.LNK_BTN1DropDownClick(Sender: TObject);
begin
ADDListDrives(FPopup, DriveOnClick,
_(LNK_UTILS_GLOBAL_TEXT_MSG1,MainForm.FConfig.ReadString('General','Language',EN_US)));
end;

procedure TLNK_Form.LNK_BTN2DropDownClick(Sender: TObject);
begin
ADDControlPanelList(FPopup, MainForm.FConfig, ControlPanelOnClick);
end;

procedure TLNK_Form.LNK_BTN3DropDownClick(Sender: TObject);
var
 MenuItem : TMenuItem;
begin
FPopup.Items.Clear;
MenuItem := TMenuItem.Create(FPopup);
MenuItem.Caption := _(LNK_UTILS_GLOBAL_TEXT_MSG14,MainForm.FConfig.ReadString('General','Language',EN_US));
MenuItem.OnClick := RecycleOnClick;
MenuItem.Enabled := not IsRecycleBinEmpty;
FPopup.Items.Add(MenuItem);
end;

procedure TLNK_Form.GeneralMenuPopup(Sender: TObject);
begin
if MainForm.FavTray.Visible = True then
LNK_GEN_MENU_N5.Checked := MainForm.FConfig.ReadBool('General','LNKForm_FavoriteInTray',False);
end;

procedure TLNK_Form.LNK_GEN_MENU_N5Click(Sender: TObject);
begin
with Sender as TMenuItem do
  begin
    Checked := not Checked;
    MainForm.FavTray.Visible := Checked;
    MainForm.FConfig.WriteBool('General','LNKForm_FavoriteInTray',Checked);
    MainForm.FConfig.UpdateFile;
  end;
end;

procedure TLNK_Form.LNK_GEN_MENU_N6Click(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  HOTKEYCHANGER_BTN1Click(Sender);
  Edit1.Text := MainForm.FConfig.ReadString('General','LNKForm_Favorites_Key','');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString('General','LNKForm_Favorites_Key',''),True));
    MainForm.FConfig.WriteString('General','LNKForm_Favorites_Key',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    if Edit1.Text <> '' then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
   end;
 end;
end;

procedure TLNK_Form.LNK_LST_MENU_N7Click(Sender: TObject);
var
 PName,PLocation,PWorkinDir,PParameter,NewFilePath, WorkingDirPath: String;
begin
if not FileExists(List.Selected.SubItems[0]) then
ShowMessage(_(LNK_GLOBAL_TEXT_MSG7,MainForm.FConfig.ReadString('General','Language',EN_US))) else
with MainForm do
 begin
  if ExtractFileExt(List.Selected.SubItems[0]) = '.lnk' then
   begin
    //Extract info from .lnk
    NewFilePath := PathFromLNK(List.Selected.SubItems[0]);
    WorkingDirPath := WorkingDirFromLNK(List.Selected.SubItems[0]);
    if FileExists(NewFilePath) then
     begin
      PName := ExtractFileName(NewFilePath);
      PLocation := NewFilePath;
      PWorkinDir := WorkingDirPath;
     end;
   end else
   begin
    PName := ExtractFileName(List.Selected.SubItems[0]);
    PLocation := List.Selected.SubItems[0];
    if List.Selected.SubItems[3] = '' then
    PWorkinDir := ExtractFilePath(List.Selected.SubItems[0]) else
    PWorkinDir := List.Selected.SubItems[3];
    PParameter := List.Selected.SubItems[1];
   end;

  PTab.Tabs.Add(IntToStr(PTab.Tabs.Count));
  PTab.TabIndex := PTab.Tabs.Count -1;
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Name',Encode(PName,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Location',Encode(PLocation,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Key','');
  FConfig.WriteBool(IntToStr(PTab.TabIndex), 'NoRunFile', False);
  FConfig.WriteInteger(IntToStr(PTab.TabIndex),'ProcState',0);
  FConfig.WriteString(IntToStr(PTab.TabIndex),'WorkingDir',Encode(PWorkinDir,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Parameters',Encode(PParameter,'N90fL6FF9SXx+S'));
  FConfig.UpdateFile;
  LNK_SPD_BTN3Click(Sender);
  Visible := True;
  SetForegroundWindow(Handle);
  PTabChange(Sender);
 end;
end;

procedure TLNK_Form.LNK_GEN_MENU_N1Click(Sender: TObject);
var
 Input: TInput;
begin
with LNK_Form do
if isWindowVisible(Handle) then
 begin
  if not SetForegroundWindow(Handle) then SetForegroundWindow(Handle)
 end else
if not isWindowVisible(Handle) then
  begin
   TabsChange(LNK_Form);
   Show;
   ZeroMemory(@Input, SizeOf(Input));
   SendInput(1, Input, SizeOf(Input));
   SetForegroundWindow(Handle);
  end;
LNK_Form.ActiveControl := LNK_Form.List;
//Check if RecycleBin is empty or is full
if not IsRecycleBinEmpty then
LNK_BTN3.ImageIndex := 2 else LNK_BTN3.ImageIndex := 3;
end;

procedure OpenFileLocation(sFile: String);
var
   FileName : TFileName;
begin
  FileName := sFile;

  ShellExecute(Application.Handle, 'OPEN',
    pchar('explorer.exe'),
    pchar('/select, "' + FileName + '"'),
    nil,
    SW_NORMAL);
end;

procedure TLNK_Form.LNK_LST_MENU_N2Click(Sender: TObject);
begin
if List.Selected <> nil then
 begin
  OpenFileLocation(List.Selected.SubItems[0]);
  if (LNK_GEN_MENU_N3.Checked) then Hide;
 end;
end;

procedure TLNK_Form.LNK_LST_MENU_N11Click(Sender: TObject);
var
 i: Integer;
 TranslApps: String;
begin
TranslApps := _(LNK_GLOBAL_TEXT_MSG9,MainForm.FConfig.ReadString('General','Language',EN_US));
if FLists.SectionExists(TranslApps) then
ShowMessage(_(LNK_GLOBAL_TEXT_MSG8,MainForm.FConfig.ReadString('General','Language',EN_US)))
else
 begin
  Tabs.Tabs.Add(TranslApps);
  Tabs.TabIndex := FindString(Tabs.Tabs,TranslApps);
  List.Clear;
  AddSystemApps(List, 0, ImageList2, CurrentIconSize);
  ChangeIcons(CurrentIconSize);
  for I := 0 to List.Items.Count-1 do
   begin
    FLists.WriteString(TranslApps,PChar(List.Items[I].Caption),
    List.Items[I].SubItems[0]+'|'+List.Items[I].SubItems[1]+'|'+
    List.Items[I].SubItems[2]+'|'+List.Items[I].SubItems[3]+'|');
   end;
  FLists.UpdateFile;
 end;
end;

procedure TLNK_Form.LNK_LST_MENU_N12Click(Sender: TObject);
var
 i: Integer;
 TranslDirs: String;
begin
TranslDirs := _(LNK_GLOBAL_TEXT_MSG10,MainForm.FConfig.ReadString('General','Language',EN_US));
if FLists.SectionExists(TranslDirs) then
ShowMessage(_(LNK_GLOBAL_TEXT_MSG8,MainForm.FConfig.ReadString('General','Language',EN_US)))
else
 begin
  Tabs.Tabs.Add(TranslDirs);
  Tabs.TabIndex := FindString(Tabs.Tabs,TranslDirs);
  List.Clear;
  AddSystemApps(List, 1, ImageList2, CurrentIconSize);
  ChangeIcons(CurrentIconSize);
  for I := 0 to List.Items.Count-1 do
   begin
    FLists.WriteString(TranslDirs,PChar(List.Items[I].Caption),
    List.Items[I].SubItems[0]+'|'+List.Items[I].SubItems[1]+'|'+
    List.Items[I].SubItems[2]+'|'+List.Items[I].SubItems[3]+'|');
   end;
  FLists.UpdateFile;
 end;
end;

end.
