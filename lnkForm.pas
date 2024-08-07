unit lnkForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, IniFiles,
  ShellAPI, CommCtrl, ActiveX, Vcl.ToolWin;

type
  TLNK_Form = class(TForm)
    Tabs: TTabControl;
    List: TListView;
    Panel: TPanel;
    SpeedButton3: TSpeedButton;
    HideButton: TSpeedButton;
    Button1: TButton;
    PopupMenu: TPopupMenu;
    Open1: TMenuItem;
    N19: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    GeneralMenu: TPopupMenu;
    N23: TMenuItem;
    N24: TMenuItem;
    N12: TMenuItem;
    N28: TMenuItem;
    N18: TMenuItem;
    N15: TMenuItem;
    CustomPopupMenu: TPopupMenu;
    ImageList1: TImageList;
    Bevel1: TBevel;
    Button2: TButton;
    N11: TMenuItem;
    Addtoprocesslist1: TMenuItem;
    ToolBar1: TToolBar;
    Bevel2: TBevel;
    N16: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N17: TMenuItem;
    N20: TMenuItem;
    SpeedButton1: TSpeedButton;
    N21: TMenuItem;
    N25: TMenuItem;
    N27: TMenuItem;
    N29: TMenuItem;
    N22: TMenuItem;
    FindEdit: TEdit;
    ImageList2: TImageList;
    N26: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N71: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure TabsChange(Sender: TObject);
    procedure ListDblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure HideButtonClick(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure GeneralMenuPopup(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1DropDownClick(Sender: TObject);
    procedure Button2DropDownClick(Sender: TObject);
    procedure Addtoprocesslist1Click(Sender: TObject);
    procedure ListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PanelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N16Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure FindEditChange(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
  private
    { Private declarations }
  public
    InsertItem: TListItem;
    FLists: TMemIniFile;
    function GetFLists: TMemIniFile;
    procedure ListPath;
    procedure RegIni(Write: Boolean);
    procedure ChangeIcons(Size: Integer);
    procedure DriveOnClick(Sender: TObject);
    procedure ControlPanelOnClick(Sender: TObject);
    procedure ToolBarOnClick(Sender: TObject);
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

uses LNK_Utils, LNK_Action, LNK_Properties, Unit1, ShutdownUnit, Utils,
     HotKeyChanger, HotKeyManager;

{$R *.dfm}

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
    AddIconsToList(InsertItem.SubItems[2],ImageList2);
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
  MainForm.FConfig.WriteBool('General','LNKForm_OffScreenPos',N22.Checked);
  MainForm.FConfig.WriteBool('General','LNKForm_DragOnDrop',N23.Checked);
  MainForm.FConfig.WriteBool('General','LNKForm_HideWhenRun',N24.Checked);
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
  Tabs.TabIndex := FindString(Tabs.Tabs,Caption);
  N22.Checked := MainForm.FConfig.ReadBool('General','LNKForm_OffScreenPos',True);
  PosLocked := MainForm.FConfig.ReadBool('General','LNKForm_OffScreenPos',True);
  N23.Checked := MainForm.FConfig.ReadBool('General','LNKForm_DragOnDrop',False);
  ON_DragOnDrop := MainForm.FConfig.ReadBool('General','LNKForm_DragOnDrop',False);
  N24.Checked := MainForm.FConfig.ReadBool('General','LNKForm_HideWhenRun',False);
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
LNK_Form.ScaleForPPI(110);
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
  N27Click(Sender);
  N29Click(Sender);
 end;
TabsChange(Sender);
DragAcceptFiles(LNK_Form.Handle,true);
GetPersonalFolders(ToolBar1);
AddIconsToImgList(ImageList1);
end;

procedure TLNK_Form.FormDestroy(Sender: TObject);
begin
RegIni(True);
FLists.Free;
end;

procedure TLNK_Form.FormResize(Sender: TObject);
begin
HideButton.Left := LNK_Form.Width - HideButton.Width - 20;
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
  if (N24.Checked) then Hide;
 end;
end;

procedure TLNK_Form.ListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = ORD(VK_RETURN) then ListDblClick(Sender);
if Key = ORD(VK_DELETE) then N2Click(Sender);
if Shift = [ssCtrl] then
 begin
  case Key of
   Ord('N'): N1Click(Sender);
   Ord('P'): Addtoprocesslist1Click(Sender);
   Ord('F'): N4Click(Sender);
   Ord('C'): N7Click(Sender);
   Ord('X'): N8Click(Sender);
   Ord('L'): N17Click(Sender);
  end;
 end;
if (Shift = [ssShift]) and (Key = ORD(VK_DELETE)) then N1Click(Sender);
if (Shift = [ssAlt]) and (Key = ORD(VK_RETURN)) then N10Click(Sender);
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

procedure TLNK_Form.Button1Click(Sender: TObject);
var
 AFile: String;
begin
AFile := GetSpecialFolderLocation(-1, FOLDERID_Windows)+'\explorer.exe';
RunApplication(AFile, '/root,"shell:::{20D04FE0-3AEA-1069-A2D8-08002B30309D}"',
               PChar(ExtractFilePath(AFile)), SW_MAXIMIZE);
end;

procedure TLNK_Form.Button2Click(Sender: TObject);
var
 AFile: String;
begin
AFile := GetSpecialFolderLocation(-1, FOLDERID_Windows)+'\explorer.exe';
RunApplication(AFile, 'ms-settings:',PChar(ExtractFilePath(AFile)), SW_MAXIMIZE);
end;

procedure TLNK_Form.SpeedButton3Click(Sender: TObject);
var
 AFile: String;
begin
AFile := GetSpecialFolderLocation(-1, FOLDERID_Windows)+'\explorer.exe';
RunApplication(AFile, '/root,"shell:::{645FF040-5081-101B-9F08-00AA002F954E}"',
               PChar(ExtractFilePath(AFile)), SW_MAXIMIZE);
end;

procedure TLNK_Form.HideButtonClick(Sender: TObject);
begin
Hide;
end;

procedure TLNK_Form.SpeedButton1Click(Sender: TObject);
begin
if not ShutdownForm.Showing then
 begin
  //ShutdownForm.ParentWindow := MainForm.Handle;
  ShutdownForm.Position := poDesktopCenter;
  ShutdownForm.Show;
  SetForegroundWindow(ShutdownForm.Handle);
 end else
  begin
   if not ShutdownForm.Timer1.Enabled then
      begin
       MainForm.TimerImage.Hint := 'Timer not active';
       MainForm.TimerTrayIcon.Hint := 'Timer not active';
       LNK_Form.SpeedButton1.Hint := 'Timer not active';
      end;
   ShutdownForm.Close;
  end;
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
                  FindEdit.Text, List, FLists);
  List.SortType := stText;
  ChangeIcons(CurrentIconSize);
  Caption := Tabs.Tabs[Tabs.TabIndex];
  MainForm.FavTray.Hint := Tabs.Tabs[Tabs.TabIndex];
 end;
end;

//Menu items....................................................................

procedure TLNK_Form.N10Click(Sender: TObject);
var
  Index: WORD;
begin
with Properties do
  begin
   ActiveControl := Edit2;
   Edit1.Text := List.Selected.SubItems[0];
   Edit2.Text := List.Selected.Caption;
   Edit3.Text := List.Selected.SubItems[1];
   Edit4.Text := List.Selected.SubItems[2];
   Edit5.Text := List.Selected.SubItems[3];
   Index := 0;
   // if icon location is empty to load icon from exe
   if Edit4.Text = '' then
   Image1.Picture.Icon.Handle := ExtractAssociatedIcon(hInstance,PChar(Edit1.Text),Index)
   else
   Image1.Picture.Icon.Handle := ExtractAssociatedIcon(hInstance,PChar(Edit4.Text),Index);
   if (ShowModal <> mrCancel) and (Edit1.Text <> '') and (Edit2.Text <> '') then
    begin
     FLists.DeleteKey(LNK_Form.Caption,List.Selected.Caption);
     FLists.UpdateFile;
     List.DeleteSelected;
     AddItem(Tabs.Tabs[Tabs.TabIndex],Edit2.Text,Edit1.Text,Edit3.Text,Edit4.Text,Edit5.Text);
    end;
  end;
end;

procedure TLNK_Form.N1Click(Sender: TObject);
var
 s,d: string;
 NewFilePath, WorkingDirPath, IconPath: String;
begin
  s := ''; d := '';
  if SelectExe('Select file or folder',s,d) then
   begin
    if ExtractFileExt(s) = '.lnk' then
     begin
      NewFilePath := WideUpperCase(PathFromLNK(s));
      WorkingDirPath := WideUpperCase(WorkingDirFromLNK(s));
      if WorkingDirPath = ExtractFileDir(NewFilePath) then
      WorkingDirPath := '';
      //if is .lnk then extractfiledir from file
      if FileExists(NewFilePath) then
      AddItem(Tabs.Tabs[Tabs.TabIndex],ChangeFileExt(d,''),NewFilePath,'',
              NewFilePath,WorkingDirPath)
      else
      //else if is dir write curently dir
      AddItem(Tabs.Tabs[Tabs.TabIndex],ChangeFileExt(d,''),NewFilePath,'',
              NewFilePath,WorkingDirPath)
     end else
      //if not File .lnk to read filename from file
      AddItem(Tabs.Tabs[Tabs.TabIndex],ChangeFileExt(d,''),WideUpperCase(s),'',
              WideUpperCase(s),'');
   end;
end;

procedure TLNK_Form.N2Click(Sender: TObject);
begin
if (MessageBox(LNK_Form.Handle,PChar('Do you really want to remove '+List.Selected.Caption+' ?'), PChar(ExtractFileName(ChangeFileExt(ParamStr(0),''))), MB_OKCANCEL) = IDOK) then
 begin
  FLists.DeleteKey(Tabs.Tabs[Tabs.TabIndex],List.Selected.Caption);
  FLists.UpdateFile;
  List.DeleteSelected;
 end;
end;

procedure TLNK_Form.N4Click(Sender: TObject);
begin
with LNK_ActionForm do
  begin
    Caption := 'Create new tab';
    Label1.Caption := 'Name:';
    ActiveControl := ComboBoxEx;
    PathCombo;
    ComboBoxEx.Style := csExDropDown;
    ComboBoxEx.ItemIndex := 0;
    ComboBoxEx.Text := '';
    if (Showmodal <> mrCancel) and (ComboBoxEx.Text <> '') and
       (ComboBoxEx.Text <> LNK_Form.Caption) then
      begin
        FLists.WriteString(ComboBoxEx.Text,'Temp','');
        FLists.DeleteKey(ComboBoxEx.Text,'Temp');
        FLists.UpdateFile;
        Tabs.Tabs.Add(ComboBoxEx.Text);
        if (Tabs.Tabs.Count <> -1 ) then
          begin
            LNK_Form.Caption := ComboBoxEx.Text;
            MainForm.FavTray.Hint := ComboBoxEx.Text;
            Tabs.TabIndex := FindString(Tabs.Tabs,LNK_Form.Caption);
            TabsChange(Sender)
          end;
      end;
  end;
end;

procedure TLNK_Form.N5Click(Sender: TObject);
begin
with LNK_ActionForm do
  begin
    Caption := 'Delete tab';
    Label1.Caption := 'Select tab to delete:';
    ActiveControl := ComboBoxEx;
    PathCombo;
    ComboBoxEx.ItemIndex := FindString(Tabs.Tabs,LNK_Form.Caption);
    ComboBoxEx.Style := csExDropDownList;
    if (Showmodal <> mrCancel) and (ComboBoxEx.Text <> '') then
      begin
        FLists.EraseSection(ComboBoxEx.Text);
        FLists.UpdateFile;
        DeleteAt(Tabs,FindString(Tabs.Tabs,ComboBoxEx.Text));
        if LNK_Form.Caption = ComboBoxEx.Text then
          begin
           if Tabs.Tabs.Count = 0 then
           begin
            N27Click(Sender);
            N29Click(Sender);
           end else
           begin
            Tabs.TabIndex := 0;
            TabsChange(Sender);
           end;
          end;
      end;
  end;
end;

procedure TLNK_Form.N7Click(Sender: TObject);
begin
with LNK_ActionForm do
  begin
    Caption := 'Copy';
    Label1.Caption := 'Select tab:';
    ActiveControl := ComboBoxEx;
    PathCombo;
    ComboBoxEx.Items.Delete(FindString(ComboBoxEx.Items,LNK_Form.Caption));
    ComboBoxEx.ItemIndex := 0;
    ComboBoxEx.Style := csExDropDownList;
    if (Showmodal <> mrCancel) and (ComboBoxEx.Text <> '') and (ComboBoxEx.Text <> LNK_Form.Caption) then
      begin
        FLists.WriteString(ComboBoxEx.Text,List.Selected.Caption,
        List.Selected.SubItems[0]+'|'+List.Selected.SubItems[1]+'|'+
        List.Selected.SubItems[2]+'|'+List.Selected.SubItems[3]+'|');
        FLists.UpdateFile;
      end;
  end;
end;

procedure TLNK_Form.N8Click(Sender: TObject);
begin
with LNK_ActionForm do
  begin
    Caption := 'Move';
    Label1.Caption := 'Select tab:';
    ActiveControl := ComboBoxEx;
    PathCombo;
    ComboBoxEx.Items.Delete(FindString(ComboBoxEx.Items,LNK_Form.Caption));
    ComboBoxEx.ItemIndex := 0;
    ComboBoxEx.Style := csExDropDownList;
    if (Showmodal <> mrCancel) and (ComboBoxEx.Text <> '') and (ComboBoxEx.Text <> LNK_Form.Caption) then
      begin
        FLists.WriteString(ComboBoxEx.Text,List.Selected.Caption,
        List.Selected.SubItems[0]+'|'+List.Selected.SubItems[1]+'|'+
        List.Selected.SubItems[2]+'|'+List.Selected.SubItems[3]+'|');
        FLists.DeleteKey(LNK_Form.Caption,List.Selected.Caption);
        FLists.UpdateFile;
        List.DeleteSelected;
      end;
  end;
end;

procedure TLNK_Form.N22Click(Sender: TObject);
begin
with Sender as TMenuItem do
  begin
    Checked := not Checked;
    PosLocked := Checked;
  end;
end;

procedure TLNK_Form.N23Click(Sender: TObject);
begin
with Sender as TMenuItem do
  begin
    Checked := not Checked;
    ON_DragOnDrop := Checked;
  end;
end;

procedure TLNK_Form.N24Click(Sender: TObject);
begin
with Sender as TMenuItem do Checked := not Checked;
end;

procedure TLNK_Form.N28Click(Sender: TObject);
begin
 case MainForm.FConfig.ReadInteger('General','LNKForm_IconSize',0) of
  0: N30.Checked := True;
  1: N26.Checked := True;
  2: N31.Checked := True;
  4: N71.Checked := True;
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
  0: N33.Checked := True;
  1: N34.Checked := True;
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
 if List.Selected <> nil then N2.Enabled := True else N2.Enabled := False;
 if List.Selected <> nil then N8.Enabled := True else N8.Enabled := False;
 if Caption = '' then N1.Enabled := False else N1.Enabled := True;
 if Caption = '' then N5.Enabled := False else N5.Enabled := True;
 if List.Selected <> nil then Open1.Enabled := True else Open1.Enabled := False;
 if List.Selected <> nil then N17.Enabled := True else N17.Enabled := False;
 if List.Selected <> nil then Addtoprocesslist1.Enabled := True else Addtoprocesslist1.Enabled := False;
 if List.Selected <> nil then N7.Enabled := True else N7.Enabled := False;
 if List.Selected <> nil then N10.Enabled := True else N10.Enabled := False;
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

procedure TLNK_Form.ToolBarOnClick(Sender: TObject);
begin
 RunApplication(TToolButton(Sender).Caption,'',
                ExtractFilePath(TToolButton(Sender).Caption), SW_MAXIMIZE);
 if (N24.Checked) then Hide;
end;

procedure TLNK_Form.Button1DropDownClick(Sender: TObject);
begin
ADDListDrives(CustomPopupMenu);
end;

procedure TLNK_Form.Button2DropDownClick(Sender: TObject);
begin
ADDControlPanelList(CustomPopupMenu);
end;

procedure TLNK_Form.GeneralMenuPopup(Sender: TObject);
begin
if MainForm.FavTray.Visible = True then
N15.Caption := 'Hide icon from tray' else N15.Caption := 'Show icon in tray';
N15.Checked := MainForm.FConfig.ReadBool('General','LNKForm_FavoriteInTray',False);
end;

procedure TLNK_Form.N15Click(Sender: TObject);
begin
with Sender as TMenuItem do
  begin
    Checked := not Checked;
    MainForm.FavTray.Visible := Checked;
    MainForm.FConfig.WriteBool('General','LNKForm_FavoriteInTray',Checked);
    MainForm.FConfig.UpdateFile;
  end;
end;

procedure TLNK_Form.N16Click(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  Caption := 'HotKey changer';
  Button3Click(Sender);
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

procedure TLNK_Form.Addtoprocesslist1Click(Sender: TObject);
var
 PName,PLocation,PWorkinDir,NewFilePath, WorkingDirPath: String;
begin
if not FileExists(List.Selected.SubItems[0]) then
ShowMessage('Not an executable file') else
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
   end;

  PTab.Tabs.Add(IntToStr(PTab.Tabs.Count));
  PTab.TabIndex := PTab.Tabs.Count -1;
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Name',Encode(PName,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Location',Encode(PLocation,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Key','');
  FConfig.WriteBool(IntToStr(PTab.TabIndex), 'NoRunFile', False);
  FConfig.WriteInteger(IntToStr(PTab.TabIndex),'ProcState',0);
  FConfig.WriteString(IntToStr(PTab.TabIndex),'WorkingDir',Encode(PWorkinDir,'N90fL6FF9SXx+S'));
  FConfig.UpdateFile;
  HideButtonClick(Sender);
  Visible := True;
  SetForegroundWindow(Handle);
  PTabChange(Sender);
 end;
end;

procedure TLNK_Form.N14Click(Sender: TObject);
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

procedure TLNK_Form.N17Click(Sender: TObject);
begin
if List.Selected <> nil then
 begin
  OpenFileLocation(List.Selected.SubItems[0]);
  if (N24.Checked) then Hide;
 end;
end;

procedure TLNK_Form.N27Click(Sender: TObject);
var
 i: Integer;
begin
if FLists.SectionExists('System apps') then
ShowMessage('The section with that name already exists, please delete it and then try again!')
else
 begin
  Tabs.Tabs.Add('System apps');
  Tabs.TabIndex := FindString(Tabs.Tabs,'System apps');
  List.Clear;
  AddSystemApps(List, 0);
  ChangeIcons(CurrentIconSize);
  for I := 0 to List.Items.Count-1 do
   begin
    FLists.WriteString('System apps',PChar(List.Items[I].Caption),
    List.Items[I].SubItems[0]+'|'+List.Items[I].SubItems[1]+'|'+
    List.Items[I].SubItems[2]+'|'+List.Items[I].SubItems[3]+'|');
   end;
  FLists.UpdateFile;
 end;
end;

procedure TLNK_Form.N29Click(Sender: TObject);
var
 i: Integer;
begin
if FLists.SectionExists('System folders') then
ShowMessage('The section with that name already exists, please delete it and then try again!')
else
 begin
  Tabs.Tabs.Add('System folders');
  Tabs.TabIndex := FindString(Tabs.Tabs,'System folders');
  List.Clear;
  AddSystemApps(List, 1);
  ChangeIcons(CurrentIconSize);
  for I := 0 to List.Items.Count-1 do
   begin
    FLists.WriteString('System folders',PChar(List.Items[I].Caption),
    List.Items[I].SubItems[0]+'|'+List.Items[I].SubItems[1]+'|'+
    List.Items[I].SubItems[2]+'|'+List.Items[I].SubItems[3]+'|');
   end;
  FLists.UpdateFile;
 end;
end;

end.
