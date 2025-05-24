unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.IniFiles,
  Vcl.ComCtrls, Vcl.Menus, Vcl.ExtCtrls, Vcl.ImgList, Vcl.Buttons, System.ImageList,
  Vcl.TitleBarCtrls, HotKeyManager, WindowManagerUnit, AudioProcessController, SystemUtils;

const
  TIMER1 = 1;
  TIMER2 = 2;
  MSG_ClearDPS = WM_USER;

  ReleaseDate = '24.05.2025';

type
  TMainForm = class(TForm)
    Main_CHKBOX1: TCheckBox;
    Main_GrpBox3: TGroupBox;
    Main_CHKBOX5: TCheckBox;
    Edit3: TEdit;
    Main_BTN7: TButton;
    Main_GrpBox1: TGroupBox;
    MousePosBox: TComboBox;
    Main_BTN1: TButton;
    Main_GrpBox5: TGroupBox;
    Main_CHKBOX7: TCheckBox;
    Main_GrpBox6: TGroupBox;
    Main_GrpBox4: TGroupBox;
    Main_CHKBOX6: TCheckBox;
    Main_CHKBOX2: TCheckBox;
    Main_CHKBOX8: TCheckBox;
    Main_BTN10: TButton;
    TitleBarPanel1: TTitleBarPanel;
    LogImg: TImage;
    TimerImg: TImage;
    PTab: TTabControl;
    Main_LBL2: TLabel;
    Edit1: TEdit;
    Main_BTN4: TButton;
    Main_GrpBox2: TGroupBox;
    Main_RADGrp1: TRadioGroup;
    GroupBox8: TGroupBox;
    Main_LBL3: TLabel;
    Edit2: TEdit;
    Main_BTN6: TButton;
    Main_LBL1: TLabel;
    Main_CHKBOX3: TCheckBox;
    Main_BTN2: TButton;
    Main_BTN3: TButton;
    FavImg: TImage;
    FavTray: TTrayIcon;
    TimerTrayIcon: TTrayIcon;
    Main_BTN9: TButton;
    Main_BTN8: TButton;
    Main_BTN5: TButton;
    ImageList1: TImageList;
    Edit4: TEdit;
    Main_LBL4: TLabel;
    MainImg: TImage;
    MainMenu: TPopupMenu;
    Main_N1: TMenuItem;
    Main_N2: TMenuItem;
    Main_N3: TMenuItem;
    Main_N4: TMenuItem;
    Main_N5: TMenuItem;
    Main_N6: TMenuItem;
    Main_N7: TMenuItem;
    Main_N8: TMenuItem;
    LangImgList: TImageList;
    Main_LBL5: TLabel;
    Edit5: TEdit;
    Main_LBL6: TLabel;
    Main_BTN11: TButton;
    Main_CHKBOX9: TCheckBox;
    Main_CHKBOX10: TCheckBox;
    Main_CHKBOX4: TCheckBox;
    Main_GrpBox7: TGroupBox;
    BossComboBox: TComboBox;
    Main_CHKBOX11: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Main_CHKBOX1Click(Sender: TObject);
    procedure Main_BTN6Click(Sender: TObject);
    procedure Main_CHKBOX4Click(Sender: TObject);
    procedure Main_BTN4Click(Sender: TObject);
    procedure Main_BTN7Click(Sender: TObject);
    procedure MousePosBoxChange(Sender: TObject);
    procedure Main_BTN1Click(Sender: TObject);
    procedure Main_BTN10Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LogImgClick(Sender: TObject);
    procedure TitleBarPanel1CustomButtons0Click(Sender: TObject);
    procedure Main_CHKBOX5Click(Sender: TObject);
    procedure PTabChange(Sender: TObject);
    procedure Main_BTN2Click(Sender: TObject);
    procedure Main_BTN3Click(Sender: TObject);
    procedure FavTrayClick(Sender: TObject);
    procedure TimerTrayIconClick(Sender: TObject);
    procedure Main_BTN9Click(Sender: TObject);
    procedure Main_BTN8Click(Sender: TObject);
    procedure Main_BTN5Click(Sender: TObject);
    procedure Main_CHKBOX6Click(Sender: TObject);
    procedure TimerTrayIconDblClick(Sender: TObject);
    procedure FavTrayDblClick(Sender: TObject);
    procedure MainImgClick(Sender: TObject);
    procedure Main_N1Click(Sender: TObject);
    procedure Main_N2Click(Sender: TObject);
    procedure Main_N6Click(Sender: TObject);
    procedure MainMenuPopup(Sender: TObject);
    procedure Main_BTN11Click(Sender: TObject);
    procedure Main_LBL5Click(Sender: TObject);
    procedure Main_LBL5MouseEnter(Sender: TObject);
    procedure Main_LBL5MouseLeave(Sender: TObject);
    procedure Main_CHKBOX9Click(Sender: TObject);
    procedure Main_CHKBOX2Click(Sender: TObject);
    procedure Main_CHKBOX3Click(Sender: TObject);
    procedure Main_RADGrp1Click(Sender: TObject);
    procedure Main_CHKBOX7Click(Sender: TObject);
    procedure Main_CHKBOX8Click(Sender: TObject);
    procedure FavTrayMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Main_CHKBOX10Click(Sender: TObject);
    procedure BossComboBoxChange(Sender: TObject);
    procedure Main_CHKBOX11Click(Sender: TObject);
  private
    TskMgrList: TStringList;
    ProcessList: TStringList;
    RunTempList: TStringList;
    procedure SilentException(Sender:TObject; E:Exception);
    function GetFConfig: TMemIniFile;
    procedure HotKeyManagerHotKeyPressed(HotKey: Cardinal; Index: Word);
    procedure WithoutWMHotkey;
    procedure DoUpdateProcesses();
  public
    FConfig: TMemIniFile;
    HotKeyManager: THotKeyManager;
    WinManager: TWindowManager;
    FAudioController: TAudioProcessController;
    //-------------------------------------
    procedure RegIni(Write: Boolean; FirstRun: Boolean);
  protected
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
  private

  end;


var
  MainForm: TMainForm;
  EnableHotKey: Boolean = False;  //bool pentru bosskey
  isDPSServiceRunning: Boolean = False; //daca DPS serviciu in windows este lucreaza sau deconectat, atunci nu se va porni serviciul DPS

implementation

uses ShutdownUnit, lnkForm, HotKeyChanger, Help, Processes,
     Translation, LNK_Properties;

{$R *.dfm}

// GENERAL FUNCTIONS
//------------------------------------------------------------------------------

procedure TMainForm.WMSysCommand(var Message: TWMSysCommand);
begin
  if Message.CmdType = SC_CONTEXTHELP then
   begin
    Main_N1Click(Self);
    Message.Result := 0;
   end else
   begin
    inherited;
   end;
end;

//timer pentru sa se ascunda procesul de la mouse
procedure TimerCallBack1(uTimerID, uMessage: UINT; dwUser, dw1, dw2: DWORD); stdcall;
begin
with MainForm , Mouse.CursorPos do
case MousePosBox.ItemIndex of
  1: if (X = Screen.DesktopLeft) then WithoutWMHotkey;
  2: if (X = Screen.DesktopWidth -1) then WithoutWMHotkey;
  3: if (Y = Screen.DesktopTop) then WithoutWMHotkey;
  4: if (Y = Screen.DesktopHeight -1) then WithoutWMHotkey;
end;
end;

//timer pentru lista de processe cand sa se inchida de la task managers
procedure TimerCallBack2(uTimerID, uMessage: UINT; dwUser, dw1, dw2: DWORD); stdcall;
begin
with MainForm do DoUpdateProcesses();
end;

procedure Translate(aLanguageID: String);
var
 TempInteger: Integer;
begin
with MainForm do
 begin
  TitleBarPanel1.CustomButtons.Items[0].Hint := _(GLOBAL_HINT_CAPT_BTN1, aLanguageID);
  Main_N1.Caption := _(GLOBAL_CPTN_MENUITEM_Main_N1, aLanguageID);
  Main_N2.Caption := _(GLOBAL_CPTN_MENUITEM_Main_N2, aLanguageID);
  Main_N5.Caption := _(GLOBAL_CPTN_MENUITEM_Main_N5, aLanguageID);
  Main_N6.Caption := EN_US;
  Main_N7.Caption := RU_RU;
  Main_N8.Caption := RO_RO;
  MainImg.Hint := _(GLOBAL_HINT_IMG_MainImg, aLanguageID);
  LogImg.Hint := _(GLOBAL_HINT_IMG_LogImg, aLanguageID);
  TimerImg.Hint := _(GLOBAL_HINT_IMG_TimerImg, aLanguageID);
  FavImg.Hint := _(GLOBAL_HINT_IMG_FavImg, aLanguageID);
  Main_CHKBOX1.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX1, aLanguageID);
  Main_CHKBOX2.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX2, aLanguageID);
  Main_CHKBOX3.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX3, aLanguageID);
  Main_GrpBox1.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox1, aLanguageID);
  //Load items and read itemindex to ComboBox
  TempInteger := MousePosBox.ItemIndex;
  StrToList(_(GLOBAL_CPTN_COMBOBOX_PosBox1, aLanguageID),';',MousePosBox.Items);
  MousePosBox.ItemIndex := TempInteger;
  //----------------------------------------------------------------------------
  Main_BTN1.Hint := _(GLOBAL_CPTN_MENUITEM_Main_N1, aLanguageID);
  Main_LBL1.Caption := _(GLOBAL_CPTN_LBL_LBL1, aLanguageID);
  Main_BTN2.Hint := _(GLOBAL_HINT_BTN_BTN2, aLanguageID);
  Main_BTN3.Hint := _(GLOBAL_HINT_BTN_BTN3, aLanguageID);
  Main_LBL2.Caption := _(GLOBAL_CPTN_LBL_LBL2, aLanguageID);
  Main_BTN4.Hint := _(GLOBAL_HINT_BTN_BTN4, aLanguageID);
  Main_GrpBox2.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox2, aLanguageID);
  Main_BTN5.Hint := _(GLOBAL_HINT_BTN_BTN5, aLanguageID);
  Main_RADGrp1.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox7, aLanguageID);
  //Load items and read itemindex to RadioGroup
  TempInteger := Main_RADGrp1.ItemIndex;
  StrToList(_(GLOBAL_TEXT_RADGRP_RADGrp1, aLanguageID),';',Main_RADGrp1.Items);
  Main_RADGrp1.ItemIndex := TempInteger;
  //----------------------------------------------------------------------------
  Main_CHKBOX4.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX4, aLanguageID);
  Main_LBL3.Caption := _(GLOBAL_CPTN_LBL_LBL3, aLanguageID);
  Main_BTN6.Hint := _(GLOBAL_HINT_BTN_BTN6, aLanguageID);
  Main_LBL4.Caption := _(GLOBAL_CPTN_LBL_LBL4, aLanguageID);
  Main_LBL5.Caption := _(GLOBAL_CPTN_LBL_LBL5, aLanguageID);
  Main_LBL5.Hint := _(GLOBAL_HINT_LBL_LBL5, aLanguageID);
  Main_LBL6.Caption := _(LNK_HINT_BTN_BTN2, aLanguageID)+' :';
  Main_GrpBox3.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox3, aLanguageID);
  Main_CHKBOX5.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX5, aLanguageID);
  Main_CHKBOX11.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX11, aLanguageID);
  Main_CHKBOX11.Hint := _(GLOBAL_HINT_CHKBOX_CHKBOX11, aLanguageID);
  Main_BTN7.Hint := _(GLOBAL_HINT_BTN_BTN4, aLanguageID);
  Main_GrpBox4.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox4, aLanguageID);
  Main_CHKBOX6.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX6, aLanguageID);
  Main_GrpBox7.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox7, aLanguageID);
  //Load items and read itemindex to RadioGroup
  TempInteger := BossComboBox.ItemIndex;
  StrToList(_(GLOBAL_TEXT_GRPBOX_GrpBox7, aLanguageID),';',BossComboBox.Items);
  BossComboBox.ItemIndex := TempInteger;
  //----------------------------------------------------------------------------
  Main_BTN8.Hint := _(GLOBAL_HINT_BTN_BTN5, aLanguageID);
  Main_GrpBox5.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox5, aLanguageID);
  Main_CHKBOX7.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX7, aLanguageID);
  Main_CHKBOX7.Hint := _(GLOBAL_HINT_CHKBOX_CHKBOX7, aLanguageID);
  Main_CHKBOX8.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX8, aLanguageID);
  Main_CHKBOX9.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX9, aLanguageID);
  Main_CHKBOX10.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX10, aLanguageID);
  Main_GrpBox6.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox2, aLanguageID);
  Main_BTN9.Hint := _(GLOBAL_HINT_BTN_BTN5, aLanguageID);
  Main_BTN10.Caption := _(GLOBAL_CPTN_BTN_BTN10, aLanguageID);
  Main_BTN11.Hint := _(GLOBAL_CPTN_MENUITEM_Main_N1, aLanguageID);
 end;
end;

// INI FILE
//------------------------------------------------------------------------------

function TMainForm.GetFConfig: TMemIniFile;
begin
  if FConfig = nil then
  FConfig := TMemIniFile.Create(ExtractFilePath(Application.ExeName) + CurrentUserName + '.ini',TEncoding.UTF8);
  Result := FConfig;
end;

procedure TMainForm.RegIni(Write: Boolean; FirstRun: Boolean);
var
 I: Integer;
begin
if FirstRun = True then
 begin
  GetFConfig;
  FConfig.WriteString('General','MainKey','Shift+Ctrl+Alt+F12');
  FConfig.WriteString('General','GlobalHotKey','');
  FConfig.WriteBool('General','EnableGlobalHotKey',False);
  FConfig.WriteString('General','ClearData_Key','');
  FConfig.WriteString('General','BossKey','');
  FConfig.WriteString('General','Task Manager Name',Encode('SystemInformer.exe;ProcessHacker.exe;procexp.exe;procexp64.exe;Taskmgr.exe;perfmon.exe;ProcessActivityView.exe;ProcessThreadsView.exe','N90fL6FF9SXx+S'));
  FConfig.WriteBool('General', 'AutoCloseAPP', False);
  FConfig.WriteBool('General', 'KillSelfFromTask', False);
  FConfig.WriteBool('General', 'Mute', False);
  FConfig.WriteBool('General', 'EnabledLogFile', False);
  FConfig.WriteBool('General', 'Ethernet_Task', False);
  FConfig.WriteBool('General', 'BossClearEthernetData', False);
  FConfig.WriteBool('General', 'BossCheckBox', False);
  FConfig.WriteInteger('General', 'CursorPos', 0);
  FConfig.WriteInteger('General','BossProcState',0);
  FConfig.WriteInteger('General','TabIndex',0);
  FConfig.WriteBool('General','TimerForm_TimerInTray',False);
  FConfig.WriteString('General','TimerForm_Timer_Key','');
  FConfig.WriteInteger('General','LNKForm_Width',803);
  FConfig.WriteInteger('General','LNKForm_Height',505);
  FConfig.WriteString('General','LNKForm_Favorites_Key','');
  FConfig.WriteBool('General','LNKForm_FavoriteInTray',False);
  FConfig.WriteBool('General','LNK_Form_MouseTrayEvent', False);
  FConfig.WriteString('General','Language',EN_US);

  FConfig.WriteString('0','Name',Encode(ExtractFileName(GetNotepad),'N90fL6FF9SXx+S'));
  FConfig.WriteString('0','Location',Encode(GetNotepad,'N90fL6FF9SXx+S'));
  FConfig.WriteString('0','Key','');
  FConfig.WriteInteger('0','ProcState',0);
  FConfig.WriteString('0','WorkingDir',Encode(ExtractFileDir(GetNotepad),'N90fL6FF9SXx+S'));
  FConfig.WriteString('0','Parameters',Encode('','N90fL6FF9SXx+S'));
  FConfig.WriteBool('0', 'NoRunFile', False);
  FConfig.WriteBool('0', 'Mute', False);

  FConfig.UpdateFile;
 end;
GetFConfig;
if Write = true then
 begin
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Name', Encode(Edit1.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Location', Encode(Edit2.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteInteger(IntToStr(PTab.TabIndex),'ProcState',Main_RADGrp1.ItemIndex);
  FConfig.WriteString(IntToStr(PTab.TabIndex),'WorkingDir',Encode(Edit4.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Parameters',Encode(Edit5.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteBool(IntToStr(PTab.TabIndex), 'NoRunFile', Main_CHKBOX4.Checked);
  FConfig.WriteBool(IntToStr(PTab.TabIndex), 'Mute', Main_CHKBOX10.Checked);
  FConfig.WriteBool('General','EnableGlobalHotKey',Main_CHKBOX9.Checked);
  FConfig.WriteBool('General', 'AutoCloseAPP', Main_CHKBOX5.Checked);
  FConfig.WriteBool('General', 'KillSelfFromTask', Main_CHKBOX11.Checked);
  FConfig.WriteBool('General', 'Mute', Main_CHKBOX3.Checked);
  FConfig.WriteBool('General', 'EnabledLogFile', Main_CHKBOX2.Checked);
  FConfig.WriteBool('General', 'Ethernet_Task', Main_CHKBOX7.Checked);
  FConfig.WriteBool('General', 'BossClearEthernetData', Main_CHKBOX8.Checked);
  FConfig.WriteBool('General', 'BossCheckBox', Main_CHKBOX6.Checked);
  FConfig.WriteString('General','Task Manager Name', Encode(Edit3.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteInteger('General', 'CursorPos', MousePosBox.ItemIndex);
  FConfig.WriteInteger('General','BossProcState',BossComboBox.ItemIndex);
  FConfig.WriteBool('General','LNKForm_FavoriteInTray',FavTray.Visible);
  FConfig.WriteBool('General','TimerForm_TimerInTray',TimerTrayIcon.Visible);
  FConfig.WriteInteger('General','TabIndex',PTab.TabIndex);
  FConfig.UpdateFile;
 end else
 begin
  //Read all process to tabs
  ScanProcessListFromIni(FConfig,PTab);
  PTab.TabIndex := FConfig.ReadInteger('General','TabIndex',0);
  Main_CHKBOX9.Checked := FConfig.ReadBool('General','EnableGlobalHotKey',False);
  //Load Main_BTN5 caption from global or no
  if FConfig.ReadBool('General','EnableGlobalHotKey',False) = True then
   begin
    Main_BTN5.Caption := FConfig.ReadString('General','GlobalHotKey', '');
    Main_CHKBOX10.Enabled := False;
   end else
   begin
    Main_BTN5.Caption := FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', '');
    Main_CHKBOX10.Enabled := True;
   end;
  Main_BTN8.Caption := FConfig.ReadString('General','BossKey', '');
  //daca bosscheckbox este true atunci se activeaza bosskey
  if FConfig.ReadBool('General', 'BossCheckBox', False) then
  begin
   if Main_BTN8.Caption <> '' then
   begin
    HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','BossKey', ''),True));
    EnableHotKey := False;
   end else EnableHotKey := True;
   Main_CHKBOX6.Checked := True;
  end else
  begin  //se intoarce la regim normal, adica lucreaza numai hotkey, fara bosskey
   EnableHotKey := True;
   Main_CHKBOX6.Checked := False;
  end;
  //registered process hotkeys
  if FConfig.ReadBool('General','EnableGlobalHotKey',False) = True then
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','GlobalHotKey', ''),True))
  else begin
  for I := 0 to PTab.Tabs.Count-1 do
   begin
    HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString(IntToStr(I),'Key', ''),True));
   end;
  end;

  Main_BTN9.Caption := FConfig.ReadString('General','ClearData_Key', '');
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','ClearData_Key', ''),True));
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','LNKForm_Favorites_Key',''),True));
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','TimerForm_Timer_Key',''),True));
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','MainKey', 'Shift+Ctrl+Alt+F12'),True));

  Main_CHKBOX1.Checked := CheckRunAtStartupByScheduledTask(ExtractFileName(ChangeFileExt(ParamStr(0),'')));

  //Close process when taskmanager running
  if FConfig.ReadBool('General', 'AutoCloseAPP', Main_CHKBOX5.Checked) then
   begin
    SetTimer(Handle,TIMER2,1000,@TimerCallBack2);
    Main_CHKBOX5.Checked := True;
    Main_CHKBOX7.Enabled := HasAdministratorRights();
    Main_CHKBOX11.Enabled := True;
    Edit3.Enabled := True;
    Main_BTN7.Enabled := True;
   end else
   begin
    Main_CHKBOX5.Checked := False;
    Main_CHKBOX7.Enabled := False;
    Main_CHKBOX11.Enabled := False;
    Edit3.Enabled := False;
    Main_BTN7.Enabled := False;
   end;

   Main_CHKBOX11.Checked := FConfig.ReadBool('General', 'KillSelfFromTask', False);

  //Log file
  if FConfig.ReadBool('General', 'EnabledLogFile', Main_CHKBOX2.Checked) then
   begin
    Main_CHKBOX2.Checked := True;
    LogWrite('User: ' + CurrentUserName, 'asAdmin: '+ABBoolToStr(HasAdministratorRights()), 'Open');
   end else Main_CHKBOX2.Checked := False;

  Main_CHKBOX3.Checked := FConfig.ReadBool('General', 'Mute', Main_CHKBOX3.Checked);

  Main_CHKBOX7.Checked := FConfig.ReadBool('General', 'Ethernet_Task', Main_CHKBOX7.Checked);

  Main_CHKBOX8.Checked := FConfig.ReadBool('General', 'BossClearEthernetData', Main_CHKBOX8.Checked);

  Main_CHKBOX1.Enabled := HasAdministratorRights();
  Main_CHKBOX8.Enabled := HasAdministratorRights();
  Main_BTN9.Enabled := HasAdministratorRights();

  Edit1.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Name',''),'N90fL6FF9SXx+S');
  Edit2.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Location',''),'N90fL6FF9SXx+S');
  Edit3.Text := Decode(FConfig.ReadString('General','Task Manager Name', ''),'N90fL6FF9SXx+S');
  Edit4.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'WorkingDir',''),'N90fL6FF9SXx+S');
  Edit5.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Parameters',''),'N90fL6FF9SXx+S');
  Main_CHKBOX4.Checked := FConfig.ReadBool(IntToStr(PTab.TabIndex), 'NoRunFile', False);
  Main_CHKBOX10.Checked := FConfig.ReadBool(IntToStr(PTab.TabIndex), 'Mute', False);
  MousePosBox.ItemIndex := FConfig.ReadInteger('General', 'CursorPos', 0);
  MousePosBoxChange(Self);

  Main_RADGrp1.ItemIndex := FConfig.ReadInteger(IntToStr(PTab.TabIndex),'ProcState',0);
  BossComboBox.ItemIndex := FConfig.ReadInteger('General','BossProcState',0);

  FavTray.Visible := FConfig.ReadBool('General','LNKForm_FavoriteInTray',False);
  TimerTrayIcon.Visible := FConfig.ReadBool('General','TimerForm_TimerInTray',False);

  Translate(FConfig.ReadString('General','Language',EN_US));
 end;
end;

// FORM ACTIONS
//------------------------------------------------------------------------------

procedure TMainForm.SilentException(Sender: TObject; E: Exception);
begin
  // Do nothing to suppress all error messages
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//save settings
ShutdownForm.saveshutdowntoini();
RegIni(True, False);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
//Load png images from Resource
MainImg.Picture.Graphic := LoadImageResource('main24');
LogImg.Picture.Graphic := LoadImageResource('log24');
TimerImg.Picture.Graphic := LoadImageResource('time24');
FavImg.Picture.Graphic := LoadImageResource('star24');

//Application.OnException := SilentException;

//Create HotKeyManager
HotKeyManager := THotKeyManager.Create(Self);
HotKeyManager.OnHotKeyPressed := HotKeyManagerHotKeyPressed;

WinManager := TWindowManager.Create;

FAudioController := TAudioProcessController.Create;

//Read inifile
if not FileExists(ExtractFilePath(Application.ExeName) + CurrentUserName + '.ini') then
 begin
  Application.ShowMainForm := True;
  RegIni(False, True);
 end else
 begin
  //Application.ShowMainForm := False;
  RegIni(False, False);
 end;

TskMgrList := TStringList.Create;
ProcessList := TStringList.Create;
RunTempList := TStringList.Create;

ReportMemoryLeaksOnShutdown := False;

//daca serviciul lucreaza atunci nu va trebui de oprit serviciul DPS
if ServiceRunning(nil, 'DPS') then
isDPSServiceRunning := True else isDPSServiceRunning := False;

//Load languages images from resource
LangImgFromRes(LangImgList);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
//Write logfile
if FConfig.ReadBool('General', 'EnabledLogFile', Main_CHKBOX2.Checked) then
LogWrite('User: ' + CurrentUserName, 'asAdmin: '+ABBoolToStr(HasAdministratorRights()), 'Close');
FConfig.Free;
//Clear all hotkeys
HotKeyManager.ClearHotKeys;
HotKeyManager.Free;
//Free components
WinManager.Free;
FAudioController.Free;
TskMgrList.Free;
ProcessList.Free;
RunTempList.Free;
if HandleAllocated then
 begin
  KillTimer(Handle,TIMER1);
  KillTimer(Handle,TIMER2);
 end;
//daca serviciul din windows nu era in true atunci nu se va da start la DPS
if isDPSServiceRunning = True then
if not ServiceRunning(nil, 'DPS') then ServiceStart('','DPS');
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = ORD(VK_F1) then Main_N1Click(Self);
end;

//Other
//------------------------------------------------------------------------------

//Clear data files
procedure ClearAllData();
var
 AppName, AppLocation: String;
 I: Integer;
begin
with MainForm do
begin
if HasAdministratorRights() then
 begin
  ClearDPS(isDPSServiceRunning);
  for I := 0 to PTab.Tabs.Count-1 do
   begin
    AppName := Decode(FConfig.ReadString(IntToStr(I),'Name',''),'N90fL6FF9SXx+S');
    AppLocation := Decode(FConfig.ReadString(IntToStr(I),'Location',''),'N90fL6FF9SXx+S');
    DeleteFilesFromSysMaps(0,AppName,ExtractFileName(ChangeFileExt(AppLocation,'.lnk')));
    DeleteFilesFromSysMaps(1,AppName,ExtractFileName(ChangeFileExt(AppLocation,'.lnk')));
    RemoveAllFromRegistry(AppName,AppLocation);
    RemoveFromRegistryControlSet(AppLocation);
   end;
 end;
end;
end;

procedure TMainForm.HotKeyManagerHotKeyPressed(HotKey: Cardinal; Index: Word);
var
 AppName, AppLocation, WorkingDir, Parameters: String;
 I,l: Integer;
 MyArray: TArray<string>;
 FirstRun, MuteOn: Boolean;
begin
//Get Mainform HotKey
if TextToHotKey(FConfig.ReadString('General','MainKey','Shift+Ctrl+Alt+F12'),True) = HotKey then
 begin
  Visible := not Visible;
  SetForegroundWindow(Handle);
 end;

//Get TimerForm HotKey
if TextToHotKey(FConfig.ReadString('General','TimerForm_Timer_Key',''),True) = HotKey then
   if (ShutdownForm.Visible = True) and (ShutdownForm.Active = False) then
      TimerTrayIconClick(Self) else TimerTrayIconDblClick(Self);

//Get Lnk_Form HotKey
if TextToHotKey(FConfig.ReadString('General','LNKForm_Favorites_Key',''),True) = HotKey then
   if (LNK_Form.Visible = True) and (LNK_Form.Active = False) then
   FavTrayClick(MainForm) else FavTrayDblClick(Self);

//Get Boss HotKey
if TextToHotKey(FConfig.ReadString('General','BossKey', ''),True) = HotKey then
 begin //automat se ascunde si procesul
  EnableHotKey := not EnableHotKey;
  if FConfig.ReadInteger('General','BossProcState',0) = 0 then
  if not EnableHotKey then WithoutWMHotkey;

  //se inchide procesul daca se apasa pe boss_hotkey
  if FConfig.ReadInteger('General','BossProcState',0) = 1 then
  if not EnableHotKey then
  begin
  //terminate all running processes
  for l := 0 to PTab.Tabs.Count-1 do
   begin
    AppName := Decode(FConfig.ReadString(IntToStr(l),'Name',''),'N90fL6FF9SXx+S');
    TerminateProcessById(GetProcessID_(AppName));
   end;
  end;

  //se inchdide toate procesele si abagent
  if FConfig.ReadInteger('General','BossProcState',0) = 2 then
  if not EnableHotKey then
  begin
  //terminate all running processes
  for l := 0 to PTab.Tabs.Count-1 do
   begin
    AppName := Decode(FConfig.ReadString(IntToStr(l),'Name',''),'N90fL6FF9SXx+S');
    TerminateProcessById(GetProcessID_(AppName));
   end;
   //Delete all trayicons if is visible
   if FavTray.Visible then FavTray.Visible := False;
   if TimerTrayIcon.Visible then TimerTrayIcon.Visible := False;
   //terminate abagent
   TerminateProcess(GetCurrentProcess, 0);
  end;

  // se porneste ClearAllData daca se apasa pe boss_hotkey
  if FConfig.ReadBool('General', 'BossClearEthernetData', Main_CHKBOX8.Checked) then
  if EnableHotKey = False then ClearAllData();
 end;

//Get ClearData HotKey
if TextToHotKey(FConfig.ReadString('General','ClearData_Key', ''),True) = HotKey then
   ClearAllData();

//Run process per global key
for I := 0 to PTab.Tabs.Count-1 do
begin
  //Load information from ini
  AppName := Decode(FConfig.ReadString(IntToStr(I),'Name',''),'N90fL6FF9SXx+S');
  AppLocation := Decode(FConfig.ReadString(IntToStr(I),'Location',''),'N90fL6FF9SXx+S');
  WorkingDir := Decode(FConfig.ReadString(IntToStr(I),'WorkingDir',''),'N90fL6FF9SXx+S');
  Parameters := Decode(FConfig.ReadString(IntToStr(I),'Parameters',''),'N90fL6FF9SXx+S');
  //Run only select process
 if TextToHotKey(FConfig.ReadString(IntToStr(I),'Key', ''),True) = HotKey then
 if EnableHotKey then
 begin
  FirstRun := False;
  if not IsProcessRunning(AppName) and
  not FConfig.ReadBool(IntToStr(I), 'NoRunFile', False) and (AppLocation <> '') then
    begin
     RunApplication(AppLocation, Parameters, WorkingDir, SW_SHOW);
     FirstRun := True;
    end;
    if not FirstRun then
      begin
       //Hide/Show
       WinManager.Toggle([AppName]);

       //Mute/Unmute
       if WinManager.IsProcessHidden(AppName) then
         MuteForProcess(FConfig, IntToStr(I), AppName, True, FAudioController)
       else
         MuteForProcess(FConfig, IntToStr(I), AppName, False, FAudioController);

       //Show window minimized is selected in Main_RADGrp1
       if FConfig.ReadInteger(IntToStr(I),'ProcState',0) = 1 then
       MinimizeWindowsForProcess(AppName);
      end;
 end;
 FirstRun := False;
end;

//Run all processes with one global key
if TextToHotKey(FConfig.ReadString('General','GlobalHotKey', ''),True) = HotKey then
if EnableHotKey then
 begin
 RunTempList.Clear;
 FirstRun := False;
 MuteOn := False;
 //Running apps
 for I := 0 to PTab.Tabs.Count-1 do
  begin
   RunTempList.Add(Decode(FConfig.ReadString(IntToStr(I),'Name',''),'N90fL6FF9SXx+S'));
   AppName := Decode(FConfig.ReadString(IntToStr(I),'Name',''),'N90fL6FF9SXx+S');
   AppLocation := Decode(FConfig.ReadString(IntToStr(I),'Location',''),'N90fL6FF9SXx+S');
   WorkingDir := Decode(FConfig.ReadString(IntToStr(I),'WorkingDir',''),'N90fL6FF9SXx+S');
   Parameters := Decode(FConfig.ReadString(IntToStr(I),'Parameters',''),'N90fL6FF9SXx+S');
   if not IsProcessRunning(AppName) and
   not FConfig.ReadBool(IntToStr(I), 'NoRunFile', False) and (AppLocation <> '') then
    begin
     RunApplication(AppLocation, Parameters, WorkingDir, SW_SHOW);
     FirstRun := True;
    end;
  end;

 //Hide/Show processes
 if not FirstRun then
  begin
   //Hide/Show
   WinManager.Toggle(StringListToArray(RunTempList));

   //Mute/Unmute
   for I := 0 to PTab.Tabs.Count-1 do
    begin
       if WinManager.AreAllProcessesHidden then
       MuteOn := True else MuteOn := False;
       MuteForProcess(FConfig, IntToStr(I), AppName, MuteOn, FAudioController);
    end;

   //Show window minimized is selected in Main_RADGrp1
   for I := 0 to PTab.Tabs.Count-1 do
    begin
     if FConfig.ReadInteger(IntToStr(I),'ProcState',0) = 1 then
     MinimizeWindowsForProcess(RunTempList[I]);
    end;
  end;
 FirstRun := False;
 end;
end;

procedure TMainForm.WithoutWMHotkey; //Hide from mouse
var
  ProcessName: String;
  I: Integer;
begin
for I := 0 to PTab.Tabs.Count-1 do
 begin
  ProcessName := Decode(FConfig.ReadString(IntToStr(I),'Name',''),'N90fL6FF9SXx+S');
  if IsProcessRunning(ProcessName) then
  if isWindowVisible(GetWinHandleFromProcId(GetProcessID_(ProcessName))) then
   begin
    WinManager.Toggle([ProcessName]);
    MuteForProcess(FConfig, IntToStr(I), ProcessName, True, FAudioController);
   end;
 end;
end;

//procedure for create task managers list
procedure TMainForm.DoUpdateProcesses();
var
  i,j: integer;
  Terminated: Boolean;
  AppName: String;
begin
  Terminated := False;
  //Get process list
  ProcessToList(ProcessList);
  //Hide all processes when is running Task managers
  if FConfig.ReadBool('General', 'AutoCloseAPP', False) then
  begin
   if Edit3.Text <> '' then
   begin
   // killing only if running name from Edit3
    StrToList(Edit3.Text,';',TskMgrList);
    for j := 0 to TskMgrList.Count - 1 do
    if FindStringInStringList(ProcessList,TskMgrList[j],True) <> -1 then
     begin
     //kill all running process
      for i := 0 to PTab.Tabs.Count-1 do
        begin
         AppName := Decode(FConfig.ReadString(IntToStr(i),'Name',''),'N90fL6FF9SXx+S');
         if IsProcessRunning(AppName) then
         Terminated := TerminateProcessById(GetProcessID_(AppName));
        end;
      if Terminated then
      begin
       //Get ClearData
       if FConfig.ReadBool('General', 'Ethernet_Task', False) then
       ClearAllData();

       //Terminate abagent
       if FConfig.ReadBool('General', 'KillSelfFromTask', False) then
       TerminateProcess(GetCurrentProcess, 0);
      end;
     end;
   end;
  end;
end;

//Components
//------------------------------------------------------------------------------

procedure TMainForm.MousePosBoxChange(Sender: TObject);
begin
case MousePosBox.ItemIndex of
 0: KillTimer(Handle,TIMER1);
 1..4: SetTimer(Handle,TIMER1,100,@TimerCallBack1);
end;
FConfig.WriteInteger('General', 'CursorPos', MousePosBox.ItemIndex);
FConfig.UpdateFile;
end;

procedure TMainForm.Main_CHKBOX1Click(Sender: TObject);
var
  User: String;
begin
User := CurrentUserName;
with Sender as TCheckBox do
ScheduleRunAtStartup(Checked,ExtractFileName(ChangeFileExt(Application.ExeName,'')),Application.ExeName,User);
end;

procedure TMainForm.Main_CHKBOX2Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  FConfig.WriteBool('General', 'EnabledLogFile', Checked);
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_CHKBOX3Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  FConfig.WriteBool('General', 'Mute', Checked);
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_CHKBOX4Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  Edit2.Enabled := not Checked;
  Edit4.Enabled := not Checked;
  Edit5.Enabled := not Checked;
  Main_BTN6.Enabled := not Checked;
  FConfig.WriteBool(IntToStr(PTab.TabIndex), 'NoRunFile', Checked);
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_CHKBOX11Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  FConfig.WriteBool('General', 'KillSelfFromTask', Checked);
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_CHKBOX5Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  if Checked then
  begin
   SetTimer(Handle,TIMER2,1000,@TimerCallBack2);
   Main_CHKBOX7.Enabled := HasAdministratorRights();
   Main_CHKBOX11.Enabled := True;
   Edit3.Enabled := True;
   Main_BTN7.Enabled := True;
  end else
  begin
   KillTimer(Handle,TIMER2);
   Main_CHKBOX7.Enabled := False;
   Main_CHKBOX11.Enabled := False;
   Edit3.Enabled := False;
   Main_BTN7.Enabled := False;
  end;
  FConfig.WriteBool('General', 'AutoCloseAPP', Checked);
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_CHKBOX6Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  if Checked = True then
  begin
   HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','BossKey', ''),True));
   EnableHotKey := False;
  end else
   begin
    HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString('General','BossKey', ''),True));
    EnableHotKey := True;
   end;
  FConfig.WriteBool('General', 'BossCheckBox', Checked);
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_CHKBOX7Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  FConfig.WriteBool('General', 'Ethernet_Task', Checked);
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_CHKBOX8Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  FConfig.WriteBool('General', 'BossClearEthernetData', Checked);
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_CHKBOX9Click(Sender: TObject);
var
 I: Integer;
 AppName: String;
begin
with Sender as TCheckBox do
 begin
  if Checked = True then
   begin
    Main_BTN5.Caption := FConfig.ReadString('General','GlobalHotKey', '');
    Main_CHKBOX10.Enabled := False;
    for I := 0 to PTab.Tabs.Count-1 do
    begin
     //Unregistered Multi HotKey
     HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString(IntToStr(I),'Key', ''),True));
    end;
    //Registered One HotKey for process
    HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','GlobalHotKey', ''),True));
   end else
   begin
    Main_BTN5.Caption := FConfig.ReadString(IntToStr(MainForm.PTab.TabIndex),'Key', '');
    Main_CHKBOX10.Enabled := True;
    //Unregistered Global HotKey
    HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString('General','GlobalHotKey', ''),True));
    //Registered Multi HotKey for processes
    for I := 0 to PTab.Tabs.Count-1 do
    HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString(IntToStr(I),'Key', ''),True));
   end;
   FConfig.WriteBool('General','EnableGlobalHotKey', Checked);
   FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_CHKBOX10Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  FConfig.WriteBool(IntToStr(PTab.TabIndex), 'Mute', Checked);
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_RADGrp1Click(Sender: TObject);
begin
FConfig.WriteInteger(IntToStr(PTab.TabIndex),'ProcState',Main_RADGrp1.ItemIndex);
FConfig.UpdateFile;
end;

procedure TMainForm.BossComboBoxChange(Sender: TObject);
begin
FConfig.WriteInteger('General','BossProcState',BossComboBox.ItemIndex);
FConfig.UpdateFile;
end;

procedure TMainForm.Main_BTN5Click(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := Edit1;
  HOTKEYCHANGER_BTN1Click(Sender);
  if FConfig.ReadBool('General','EnableGlobalHotKey',False) = True then  
  Edit1.Text := FConfig.ReadString('General','GlobalHotKey', '') else
  Edit1.Text := FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', '');
  if (Showmodal <> mrCancel) then
   begin
    if FConfig.ReadBool('General','EnableGlobalHotKey',False) = True then
    begin
     HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString('General','GlobalHotKey', ''),True));
     FConfig.WriteString('General','GlobalHotKey',Edit1.Text);
     FConfig.UpdateFile;
    end else
    begin
     HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', ''),True));
     FConfig.WriteString(IntToStr(PTab.TabIndex),'Key',Edit1.Text);
     FConfig.UpdateFile;
    end;
    if Edit1.Text <> '' then
    HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
    Main_BTN5.Caption := Edit1.Text;
   end;
 end;
end;

procedure TMainForm.Main_BTN9Click(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := Edit1;
  HOTKEYCHANGER_BTN1Click(Sender);
  Edit1.Text := FConfig.ReadString('General','ClearData_Key', '');
  if (Showmodal <> mrCancel) then
   begin
    HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString('General','ClearData_Key', ''),True));
    FConfig.WriteString('General','ClearData_Key',Edit1.Text);
    FConfig.UpdateFile;
    if Edit1.Text <> '' then
    HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
    Main_BTN9.Caption := Edit1.Text;
   end;
 end;
end;

procedure TMainForm.Main_BTN8Click(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := Edit1;
  HOTKEYCHANGER_BTN1Click(Sender);
  Edit1.Text := FConfig.ReadString('General','BossKey', '');
  if (Showmodal <> mrCancel) then
   begin
    HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString('General','BossKey', ''),True));
    FConfig.WriteString('General','BossKey',Edit1.Text);
    FConfig.UpdateFile;
    Main_BTN8.Caption := Edit1.Text;
    if Edit1.Text <> '' then
    if Main_CHKBOX6.Checked = True then
    HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
   end;
 end;
end;

procedure TMainForm.Main_BTN10Click(Sender: TObject);
begin
RegIni(True, False);
RegIni(False, False);
end;

procedure TMainForm.Main_BTN6Click(Sender: TObject);
var
  sFileName, NewFilePath, WorkingDirPath: String;
  Title, FileName, OKName: PChar;
begin
Title := PChar(_(GLOBAL_TEXT_DIAG1, FConfig.ReadString('General','Language',EN_US)));
FileName := PChar(_(LNK_GLOBAL_TEXT_MSG4, FConfig.ReadString('General','Language',EN_US)));
OKName := PChar(_(PROC_CPTN_BTN_BTN2, FConfig.ReadString('General','Language',EN_US)));
if OpenFileDialog(Title, FileName, OKName, True, sFileName, ExtractFileDir(Edit2.Text)) then
 begin
  if ExtractFileExt(sFileName) = '.lnk' then
   begin
    //Extract info from .lnk
    NewFilePath := PathFromLNK(sFileName);
    WorkingDirPath := WorkingDirFromLNK(sFileName);
    if FileExists(NewFilePath) then
     begin
      Edit1.Text := ExtractFileName(NewFilePath);
      Edit2.Text := NewFilePath;
      Edit4.Text := WorkingDirPath;
     end;
   end else
   begin
    Edit1.Text := ExtractFileName(sFileName);
    Edit2.Text := sFileName;
    Edit4.Text := ExtractFilePath(sFileName);
   end;
  //Save changes
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Name', Encode(Edit1.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Location', Encode(Edit2.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'WorkingDir',Encode(Edit4.Text,'N90fL6FF9SXx+S'));
  FConfig.UpdateFile;
 end;
end;

procedure TMainForm.Main_LBL5Click(Sender: TObject);
begin
with ProcessesForm do
 begin
  Position := poDesktopCenter;
  PageControl1.ActivePage := TabSheet2;
  ActiveControl := ProcessListView;
  RefreshButtonAction := 1;
  Proc_BTN1Click(Self);
  Proc_BTN2.Caption := _(PROC_CPTN_BTN_BTN2_1, FConfig.ReadString('General','Language',EN_US));
  if (Showmodal <> mrCancel) then
   begin
    if ProcessListView.Selected <> nil then
     begin
      TerminateProcessById(GetProcessID_(ProcessListView.Selected.Caption));
      ProcessListView.Selected.Delete;
     end;
   end;
 end;
end;

procedure TMainForm.Main_LBL5MouseEnter(Sender: TObject);
begin
Main_LBL5.Font.Color := clRed;
end;

procedure TMainForm.Main_LBL5MouseLeave(Sender: TObject);
begin
Main_LBL5.Font.Color := clBlack;
end;

procedure TMainForm.Main_BTN4Click(Sender: TObject);
begin
with ProcessesForm do
 begin
  Position := poDesktopCenter;
  PageControl1.ActivePage := TabSheet1;
  ActiveControl := ListBox1;
  RefreshButtonAction := 0;
  Proc_BTN2.Caption := _(PROC_CPTN_BTN_BTN2, FConfig.ReadString('General','Language',EN_US));
  ProcessToList(ListBox1.Items);
  RemoveDuplicateItems(ListBox1);
  ListBox1.Sorted := True;
  ListBox1.Items.Delete(FindString(ListBox1.Items,ExtractFileName(ParamStr(0))));
  if (Showmodal <> mrCancel) and (ListBox1.ItemIndex <> -1) then
   begin
    Edit1.Text := ListBox1.Items[ListBox1.ItemIndex];
    FConfig.WriteString(IntToStr(PTab.TabIndex),'Name', Encode(Edit1.Text,'N90fL6FF9SXx+S'));
    FConfig.UpdateFile;
   end;
 end;
end;

procedure TMainForm.Main_BTN7Click(Sender: TObject);
begin
with ProcessesForm do
 begin
  Position := poDesktopCenter;
  PageControl1.ActivePage := TabSheet1;
  ActiveControl := ListBox1;
  RefreshButtonAction := 0;
  Proc_BTN2.Caption := _(PROC_CPTN_BTN_BTN2, FConfig.ReadString('General','Language',EN_US));
  ProcessToList(ListBox1.Items);
  RemoveDuplicateItems(ListBox1);
  ListBox1.Sorted := True;
  ListBox1.Items.Delete(FindString(ListBox1.Items,ExtractFileName(ParamStr(0))));
  if (Showmodal <> mrCancel) and (ListBox1.ItemIndex <> -1) then
   begin
    if Edit3.Text = '' then
    begin //if Edit3 is empty
     Edit3.Text := ListBox1.Items[ListBox1.ItemIndex];
    end else
    begin
     //if Exists symbol ';' then not create
     if Edit3.Text[Length(Edit3.Text)] = ';' then
     Edit3.Text := Edit3.Text + ListBox1.Items[ListBox1.ItemIndex] else
     Edit3.Text := Edit3.Text + ';' + ListBox1.Items[ListBox1.ItemIndex];
    end;
   end;
 end;
end;

procedure TMainForm.Main_BTN1Click(Sender: TObject);
begin
ShowMessage(_(GLOBAL_ACTION_BTN_BTN1, FConfig.ReadString('General','Language',EN_US)));
end;

procedure TMainForm.Main_BTN11Click(Sender: TObject);
begin
ShowMessage(_(GLOBAL_HINT_GRPBOX_GrpBox5, FConfig.ReadString('General','Language',EN_US)));
end;

procedure TMainForm.MainImgClick(Sender: TObject);
begin
MainMenu.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TMainForm.LogImgClick(Sender: TObject);
var
 AFile: String;
begin
AFile := ExtractFilePath(Application.ExeName) + CurrentUserName + '.log';
if FileExists(AFile) then
RunApplication(AFile, '', PChar(ExtractFilePath(AFile)))
else
ShowMessage(_(GLOBAL_TEXT_MSG1, FConfig.ReadString('General','Language',EN_US)));
end;

procedure TMainForm.TitleBarPanel1CustomButtons0Click(Sender: TObject);
begin
Visible := False;
end;

procedure TMainForm.PTabChange(Sender: TObject);
begin
Edit1.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Name',''),'N90fL6FF9SXx+S');
Edit2.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Location',''),'N90fL6FF9SXx+S');
Main_CHKBOX4.Checked := FConfig.ReadBool(IntToStr(PTab.TabIndex), 'NoRunFile', Main_CHKBOX4.Checked);
Main_CHKBOX10.Checked := FConfig.ReadBool(IntToStr(PTab.TabIndex), 'Mute', False);
Main_RADGrp1.ItemIndex := FConfig.ReadInteger(IntToStr(PTab.TabIndex),'ProcState',0);
if FConfig.ReadBool('General','EnableGlobalHotKey',False) = True then
  Main_BTN5.Caption := FConfig.ReadString('General','GlobalHotKey', '')
else
  Main_BTN5.Caption := FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', '');
Edit4.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'WorkingDir',''),'N90fL6FF9SXx+S');
Edit5.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Parameters',''),'N90fL6FF9SXx+S');
end;

procedure TMainForm.Main_BTN2Click(Sender: TObject);
begin
PTab.Tabs.Add(IntToStr(PTab.Tabs.Count));
PTab.TabIndex := PTab.Tabs.Count -1;
FConfig.WriteString(IntToStr(PTab.TabIndex),'Name','');
FConfig.WriteString(IntToStr(PTab.TabIndex),'Location','');
FConfig.WriteString(IntToStr(PTab.TabIndex),'Key','');
FConfig.WriteBool(IntToStr(PTab.TabIndex), 'NoRunFile', False);
FConfig.WriteBool(IntToStr(PTab.TabIndex), 'Mute', False);
FConfig.WriteInteger(IntToStr(PTab.TabIndex),'ProcState',0);
FConfig.WriteString(IntToStr(PTab.TabIndex),'WorkingDir','');
FConfig.WriteString(IntToStr(PTab.TabIndex),'Parameters','');
FConfig.UpdateFile;
PTabChange(Sender);
end;

procedure TMainForm.Main_BTN3Click(Sender: TObject);
var
 I: Integer;
 AppName: String;
begin
if PTab.Tabs.Count <> 0 then
if MessageDlg(_(GLOBAL_TEXT_MSG2, FConfig.ReadString('General','Language',EN_US)), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    //Show process if hidden
    AppName := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Name',''),'N90fL6FF9SXx+S');
    if not isWindowVisible(GetWinHandleFromProcId(GetProcessID_(AppName))) then
    WinManager.Toggle(AppName);

    if FConfig.ReadBool('General','EnableGlobalHotKey',False) = False then
    HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', ''),True));
    FConfig.EraseSection(PTab.Tabs[PTab.TabIndex]);
    FConfig.UpdateFile;
    PTab.Tabs.Delete(PTab.TabIndex);
    //if Tabs count -1 to create new
    if PTab.Tabs.Count = 0 then Main_BTN2Click(Sender) else
     begin
      for I := 0 to PTab.Tabs.Count-1 do
       begin
        RenameSection(FConfig,PTab.Tabs[I],IntToStr(I));
       end;
       ScanProcessListFromIni(FConfig,PTab);
       PTabChange(Sender);
     end;
   end;
end;

procedure TMainForm.FavTrayClick(Sender: TObject);
begin
with LNK_Form do
if Active = False then
 begin
  SetForegroundWindow(Handle);
 end;
end;

procedure TMainForm.FavTrayDblClick(Sender: TObject);
begin
with LNK_Form do
if Visible = False then
  begin
   Show;
   SetForegroundWindow(Handle);
  end else Hide;
end;

procedure TMainForm.FavTrayMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if FConfig.ReadBool('General','LNK_Form_MouseTrayEvent', False) then
begin
 with LNK_Form do
 begin
  if Visible = False then
   begin
    Show;
    FlashWindow(LNK_Form.Handle);
   end;
   if Active = False then FlashWindow(Handle);
end;
end;
end;

procedure TMainForm.TimerTrayIconClick(Sender: TObject);
begin
with ShutdownForm do
if Active = False then SetForegroundWindow(Handle);
end;

procedure TMainForm.TimerTrayIconDblClick(Sender: TObject);
begin
with ShutdownForm do
if Visible = False then
 begin
  Position := poDesktopCenter;
  Show;
  SetForegroundWindow(Handle);
 end else Hide;
end;

//PopupMenu1
//------------------------------------------------------------------------------

procedure TMainForm.MainMenuPopup(Sender: TObject);
begin
Main_N5.Find(FConfig.ReadString('General','Language',EN_US)).Default := True;
end;

procedure TMainForm.Main_N1Click(Sender: TObject);
begin
with HelpForm do
 begin
  Position := poDesktopCenter;
  HELPFORM_PAGECTRL1.ActivePageIndex := 0;
  //Read HotKeys from ini to help form
  HELPFORM_LSTVIEW1.Items[0].SubItems.Insert(0,FConfig.ReadString('General','MainKey','Shift+Ctrl+Alt+F12'));
  HELPFORM_LSTVIEW1.Items[1].SubItems.Insert(0,FConfig.ReadString('General','ClearData_Key',''));
  HELPFORM_LSTVIEW1.Items[2].SubItems.Insert(0,FConfig.ReadString('General','BossKey',''));
  HELPFORM_LSTVIEW1.Items[3].SubItems.Insert(0,FConfig.ReadString('General','TimerForm_Timer_Key',''));
  HELPFORM_LSTVIEW1.Items[4].SubItems.Insert(0,FConfig.ReadString('General','LNKForm_Favorites_Key',''));
  Show;
 end;
end;

procedure TMainForm.Main_N2Click(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := Edit1;
  HOTKEYCHANGER_BTN1Click(Sender);
  Edit1.Text := FConfig.ReadString('General','MainKey', 'Shift+Ctrl+Alt+F12');
  if (Showmodal <> mrCancel) then
   begin
    HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString('General','MainKey', 'Shift+Ctrl+Alt+F12'),True));
    FConfig.WriteString('General','MainKey',Edit1.Text);
    FConfig.UpdateFile;
    if Edit1.Text <> '' then
    HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
   end;
 end;
end;

procedure TMainForm.Main_N6Click(Sender: TObject);
var
 ACaption: String;
begin
 ACaption := StringReplace(TMenuItem(Sender).Caption, '&', '', [rfReplaceAll]);
 Translate(ACaption);
 HelpForm.Translate(ACaption);
 HotKeyForm.Translate(ACaption);
 LNK_Form.Translate(ACaption);
 ProcessesForm.Translate(ACaption);
 Properties.Translate(ACaption);
 ShutdownForm.Translate(ACaption);
 TMenuItem(Sender).Default := True;
 FConfig.WriteString('General','Language',ACaption);
 FConfig.UpdateFile;
end;

end.
