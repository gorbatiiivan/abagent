unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IniFiles,
  Character, Vcl.ComCtrls, Vcl.Menus, ActiveX, Vcl.ExtCtrls, Vcl.TitleBarCtrls,
  HotKeyManager, System.ImageList, Vcl.ImgList, Vcl.Buttons;

const
  TIMER1 = 1;
  TIMER2 = 1;
  MSG_ClearDPS = WM_USER;

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
    Main_RADGrp2: TRadioGroup;
    TimerImg: TImage;
    PTab: TTabControl;
    Main_LBL2: TLabel;
    Edit1: TEdit;
    Main_BTN4: TButton;
    Main_GrpBox2: TGroupBox;
    Main_RADGrp1: TRadioGroup;
    GroupBox8: TGroupBox;
    Main_LBL3: TLabel;
    Main_CHKBOX4: TCheckBox;
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
    Main_BTN11: TButton;
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
    procedure TimerImgClick(Sender: TObject);
    procedure PTabChange(Sender: TObject);
    procedure Main_BTN2Click(Sender: TObject);
    procedure Main_BTN3Click(Sender: TObject);
    procedure FavImgClick(Sender: TObject);
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
  private
    TskMgrList: TStringList;
    ProcessList: TListBox;

    procedure MyExcept(Sender:TObject; E:Exception);
    function GetFConfig: TMemIniFile;
    procedure HotKeyManagerHotKeyPressed(HotKey: Cardinal; Index: Word);
    procedure WithoutWMHotkey;

    procedure DoUpdateProcesses();
  public
    FConfig: TMemIniFile;
    HotKeyManager: THotKeyManager;
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

uses Utils, SystemUtils, ShutdownUnit, SPGetSid, lnkForm, HotKeyChanger,
     LNK_Utils, Help, Processes, Translation, LNK_Properties;

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
with MainForm do
case MousePosBox.ItemIndex of
  1: if (Mouse.CursorPos.X = Screen.DesktopLeft) then WithoutWMHotkey;
  2: if (Mouse.CursorPos.X = Screen.DesktopWidth -1) then WithoutWMHotkey;
  3: if (Mouse.CursorPos.Y = Screen.DesktopTop) then WithoutWMHotkey;
  4: if (Mouse.CursorPos.Y = Screen.DesktopHeight -1) then WithoutWMHotkey;
end;
end;

//timer pentru lista de processe cand sa se inchida de la task managers
procedure TimerCallBack2(uTimerID, uMessage: UINT; dwUser, dw1, dw2: DWORD); stdcall;
begin
with MainForm do DoUpdateProcesses();
end;

procedure TRun(ProcessName, ExePath, Section, WorkingDir: String);
begin
with MainForm do
if EnableHotKey = True then  //Daca este false in bosshotkey nu se deschide/ascunde/vazut procesul
 begin
  //Daca procesul nu exista, se deschide la dorinta pe hotkey
  if not IsProcessRunning(ProcessName) and (Main_CHKBOX4.Checked = False) then
   begin
    RunApplication(ExePath, '', WorkingDir);
   end else
   //Cand procesul e deschis, se apasa pe hotkey el se ascunde
   if isWindow(GetWinHandleFromProcId(GetProcessID(ProcessName))) then
    begin
     SetMasterMute(FConfig.ReadBool('General', 'Mute', Main_CHKBOX3.Checked));
     HideWindowsForProcess(ProcessName);
     end else
     //Daca procesul este ascuns, el se face vazut
    begin
     if FConfig.ReadBool('General', 'Mute', Main_CHKBOX3.Checked) then SetMasterMute(False);
     ShowAllHiddenWindowsInTaskbar();
     if FConfig.ReadInteger(Section,'ProcState',0) = 0 then
     RestoreWindowsForProcess(ProcessName);
    end;
 end;
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
  Main_RADGrp1.Caption := _(GLOBAL_CPTN_RADGRP_RADGrp1, aLanguageID);
  //Load items and read itemindex to RadioGroup
  TempInteger := Main_RADGrp1.ItemIndex;
  StrToList(_(GLOBAL_TEXT_RADGRP_RADGrp1, aLanguageID),';',Main_RADGrp1.Items);
  Main_RADGrp1.ItemIndex := TempInteger;
  //----------------------------------------------------------------------------
  Main_CHKBOX4.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX4, aLanguageID);
  Main_LBL3.Caption := _(GLOBAL_CPTN_LBL_LBL3, aLanguageID);
  Main_BTN6.Hint := _(GLOBAL_HINT_BTN_BTN6, aLanguageID);
  Main_LBL4.Caption := _(GLOBAL_CPTN_LBL_LBL4, aLanguageID);
  Main_GrpBox3.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox3, aLanguageID);
  Main_CHKBOX5.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX5, aLanguageID);
  Main_BTN7.Hint := _(GLOBAL_HINT_BTN_BTN4, aLanguageID);
  Main_GrpBox4.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox4, aLanguageID);
  Main_CHKBOX6.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX6, aLanguageID);
  Main_RADGrp2.Caption := _(GLOBAL_CPTN_RADGRP_RADGrp1, aLanguageID);
  //Load items and read itemindex to RadioGroup
  TempInteger := Main_RADGrp2.ItemIndex;
  StrToList(_(GLOBAL_TEXT_RADGRP_RADGrp2, aLanguageID),';',Main_RADGrp2.Items);
  Main_RADGrp2.ItemIndex := TempInteger;
  //----------------------------------------------------------------------------
  Main_BTN8.Hint := _(GLOBAL_HINT_BTN_BTN5, aLanguageID);
  Main_GrpBox5.Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox5, aLanguageID);
  Main_CHKBOX7.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX7, aLanguageID);
  Main_CHKBOX7.Hint := _(GLOBAL_HINT_CHKBOX_CHKBOX7, aLanguageID);
  Main_CHKBOX8.Caption := _(GLOBAL_CPTN_CHKBOX_CHKBOX8, aLanguageID);
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
  FConfig.WriteString('General','ClearData_Key','');
  FConfig.WriteString('General','BossKey','');
  FConfig.WriteString('General','Task Manager Name',Encode('SystemInformer.exe;ProcessHacker.exe;procexp.exe;procexp64.exe;Taskmgr.exe;cmd.exe;perfmon.exe;ProcessActivityView.exe;ProcessThreadsView.exe','N90fL6FF9SXx+S'));
  FConfig.WriteBool('General', 'AutoRun', False);
  FConfig.WriteBool('General', 'AutoCloseAPP', False);
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
  FConfig.WriteInteger('General','LNKForm_Width',300);
  FConfig.WriteInteger('General','LNKForm_Height',500);
  FConfig.WriteString('General','LNKForm_Favorites_Key','');
  FConfig.WriteBool('General','LNKForm_FavoriteInTray',False);
  FConfig.WriteString('General','Language',EN_US);

  FConfig.WriteString('0','Name',Encode(ExtractFileName(GetNotepad),'N90fL6FF9SXx+S'));
  FConfig.WriteString('0','Location',Encode(GetNotepad,'N90fL6FF9SXx+S'));
  FConfig.WriteString('0','Key','');
  FConfig.WriteInteger('0','ProcState',0);
  FConfig.WriteString('0','WorkingDir',Encode(ExtractFileDir(GetNotepad),'N90fL6FF9SXx+S'));
  FConfig.WriteBool('0', 'NoRunFile', False);

  FConfig.UpdateFile;
 end;
GetFConfig;
if Write = true then
 begin
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Name', Encode(Edit1.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteString(IntToStr(PTab.TabIndex),'Location', Encode(Edit2.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteInteger(IntToStr(PTab.TabIndex),'ProcState',Main_RADGrp1.ItemIndex);
  FConfig.WriteString(IntToStr(PTab.TabIndex),'WorkingDir',Encode(Edit4.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteBool('General', 'AutoRun', Main_CHKBOX1.Checked);
  FConfig.WriteBool(IntToStr(PTab.TabIndex), 'NoRunFile', Main_CHKBOX4.Checked);
  FConfig.WriteBool('General', 'AutoCloseAPP', Main_CHKBOX5.Checked);
  FConfig.WriteBool('General', 'Mute', Main_CHKBOX3.Checked);
  FConfig.WriteBool('General', 'EnabledLogFile', Main_CHKBOX2.Checked);
  FConfig.WriteBool('General', 'Ethernet_Task', Main_CHKBOX7.Checked);
  FConfig.WriteBool('General', 'BossClearEthernetData', Main_CHKBOX8.Checked);
  FConfig.WriteBool('General', 'BossCheckBox', Main_CHKBOX6.Checked);
  FConfig.WriteString('General','Task Manager Name', Encode(Edit3.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteInteger('General', 'CursorPos', MousePosBox.ItemIndex);
  FConfig.WriteInteger('General','BossProcState',Main_RADGrp2.ItemIndex);
  FConfig.WriteBool('General','LNKForm_FavoriteInTray',FavTray.Visible);
  FConfig.WriteBool('General','TimerForm_TimerInTray',TimerTrayIcon.Visible);
  FConfig.WriteInteger('General','TabIndex',PTab.TabIndex);
  FConfig.UpdateFile;
 end else
 begin
  //Read all process to tabs
  ScanProcessListFromIni(FConfig,PTab);
  PTab.TabIndex := FConfig.ReadInteger('General','TabIndex',0);
  Main_BTN5.Caption := FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', '');
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
  //registered all process hotkey
  for I := 0 to PTab.Tabs.Count-1 do
   begin
    HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString(IntToStr(I),'Key', ''),True));
   end;

  Main_BTN9.Caption := FConfig.ReadString('General','ClearData_Key', '');
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','ClearData_Key', ''),True));
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','LNKForm_Favorites_Key',''),True));
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','TimerForm_Timer_Key',''),True));
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','MainKey', 'Shift+Ctrl+Alt+F12'),True));

  Main_CHKBOX1.Checked := FConfig.ReadBool('General', 'AutoRun', Main_CHKBOX1.Checked);

  Main_CHKBOX4.Checked := FConfig.ReadBool(IntToStr(PTab.TabIndex), 'NoRunFile', Main_CHKBOX4.Checked);
  //Close process when taskmanager running
  if FConfig.ReadBool('General', 'AutoCloseAPP', Main_CHKBOX5.Checked) then
   begin
    SetTimer(Handle,TIMER2,1000,@TimerCallBack2);
    Main_CHKBOX5.Checked := True
   end else
   begin
    Main_CHKBOX5.Checked := False;
   end;

  Main_CHKBOX3.Checked := FConfig.ReadBool('General', 'Mute', Main_CHKBOX3.Checked);
  //Log file
  if FConfig.ReadBool('General', 'EnabledLogFile', Main_CHKBOX2.Checked) then
   begin
    Main_CHKBOX2.Checked := True;
    LogWrite('User: ' + CurrentUserName, 'asAdmin: '+ABBoolToStr(HasAdministratorRights()), 'Open');
   end else Main_CHKBOX2.Checked := False;

  Main_CHKBOX7.Checked := FConfig.ReadBool('General', 'Ethernet_Task', Main_CHKBOX7.Checked);

  Main_CHKBOX8.Checked := FConfig.ReadBool('General', 'BossClearEthernetData', Main_CHKBOX8.Checked);

  Main_CHKBOX1.Enabled := HasAdministratorRights();
  Main_CHKBOX7.Enabled := HasAdministratorRights();
  Main_CHKBOX8.Enabled := HasAdministratorRights();
  Main_BTN9.Enabled := HasAdministratorRights();

  Edit1.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Name',''),'N90fL6FF9SXx+S');
  Edit2.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Location',''),'N90fL6FF9SXx+S');
  Edit3.Text := Decode(FConfig.ReadString('General','Task Manager Name', Edit3.Text),'N90fL6FF9SXx+S');
  Edit4 .Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'WorkingDir',''),'N90fL6FF9SXx+S');
  MousePosBox.ItemIndex := FConfig.ReadInteger('General', 'CursorPos', 0);
  MousePosBoxChange(Self);

  Main_RADGrp1.ItemIndex := FConfig.ReadInteger(IntToStr(PTab.TabIndex),'ProcState',0);
  Main_RADGrp2.ItemIndex := FConfig.ReadInteger('General','BossProcState',0);

  FavTray.Visible := FConfig.ReadBool('General','LNKForm_FavoriteInTray',False);
  TimerTrayIcon.Visible := FConfig.ReadBool('General','TimerForm_TimerInTray',False);

  Translate(FConfig.ReadString('General','Language',EN_US));
 end;
end;

// FORM ACTIONS
//------------------------------------------------------------------------------

procedure TMainForm.MyExcept(Sender:TObject; E:Exception);
begin
  {If E is Exception then
    Exit
  else
    Exit}
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

//Application.OnException := MyExcept;

//Create HotKeyManager
HotKeyManager := THotKeyManager.Create(Self);
HotKeyManager.OnHotKeyPressed := HotKeyManagerHotKeyPressed;
//Read inifile
RegIni(False, False);

TskMgrList := TStringList.Create;
ProcessList := TListBox.CreateParented(Handle);
ProcessList.Visible := False;

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

TskMgrList.Free;
ProcessList.Free;
KillTimer(Handle,TIMER1);
KillTimer(Handle,TIMER2);

//daca serviciul din windows nu era in true atunci nu se va da start la DPS
if isDPSServiceRunning = True then
if not ServiceRunning(nil, 'DPS') then ServiceStart('','DPS');
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
  ClearDPS;
  Application.ProcessMessages;
  for I := 0 to PTab.Tabs.Count-1 do
   begin
    AppName := Decode(FConfig.ReadString(IntToStr(I),'Name',''),'N90fL6FF9SXx+S');
    AppLocation := Decode(FConfig.ReadString(IntToStr(I),'Location',''),'N90fL6FF9SXx+S');
    DeleteFilesFromSysMaps(0,AppName,ExtractFileName(ChangeFileExt(AppLocation,'.lnk')));
    DeleteFilesFromSysMaps(1,AppName,ExtractFileName(ChangeFileExt(AppLocation,'.lnk')));
    RemoveAllFromRegistry(AppName,AppLocation);
   end;
 end;
end;
end;

procedure TMainForm.HotKeyManagerHotKeyPressed(HotKey: Cardinal; Index: Word);
var
 AppName, AppLocation, WorkingDir: String;
 I,l: Integer;
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
  WithoutWMHotkey;
  //se inchide procesul daca se apasa pe boss_hotkey
  if FConfig.ReadInteger('General','BossProcState',0) = 1 then
  begin
  //kill all running process
  for l := 0 to PTab.Tabs.Count-1 do
   begin
    AppName := Decode(FConfig.ReadString(IntToStr(l),'Name',''),'N90fL6FF9SXx+S');
    KillProcess(AppName);
   end;
  end;
  // se porneste ClearAllData daca se apasa pe boss_hotkey
  if FConfig.ReadBool('General', 'BossClearEthernetData', Main_CHKBOX8.Checked) then
  if EnableHotKey = False then ClearAllData();
 end;

//Get ClearData HotKey
if TextToHotKey(FConfig.ReadString('General','ClearData_Key', ''),True) = HotKey then
   ClearAllData();

//Get Process HotKey
for I := 0 to PTab.Tabs.Count-1 do
 begin
  AppName := Decode(FConfig.ReadString(IntToStr(I),'Name',''),'N90fL6FF9SXx+S');
  AppLocation := Decode(FConfig.ReadString(IntToStr(I),'Location',''),'N90fL6FF9SXx+S');
  WorkingDir := Decode(FConfig.ReadString(IntToStr(I),'WorkingDir',''),'N90fL6FF9SXx+S');
  if TextToHotKey(FConfig.ReadString(IntToStr(I),'Key', ''),True) = HotKey then
   TRun(AppName, AppLocation, IntToStr(I), WorkingDir);
 end;
end;

procedure TMainForm.WithoutWMHotkey; //Se ascunde de la mouse
var
  ProcessName: String;
  I: Integer;
begin
for I := 0 to PTab.Tabs.Count-1 do
 begin
  ProcessName := Decode(FConfig.ReadString(IntToStr(I),'Name',''),'N90fL6FF9SXx+S');
  if IsProcessRunning(ProcessName) then
  if isWindowVisible(GetWinHandleFromProcId(GetProcessID(ProcessName))) then
   begin
    HideWindowsForProcess(ProcessName);
    SetMasterMute(FConfig.ReadBool('General', 'Mute', Main_CHKBOX3.Checked));
   end;
 end;
end;

//procedure for create task managers list

procedure TMainForm.DoUpdateProcesses();
var
  i,j: integer;
  KillResult: Integer;
  AppName, AppLocation: String;
begin
  ProcessToList(ProcessList);

  //aici se inchide procesul cand se deschide taskmgr.exe
  if FConfig.ReadBool('General', 'AutoCloseAPP', Main_CHKBOX5.Checked) then
  begin
   if Edit3.Text <> '' then
   begin
   // killing only if running name from Edit3
    StrToList(Edit3.Text,';',TskMgrList);
    for j := 0 to TskMgrList.Count - 1 do
    if IsExistFromList(TskMgrList[j], ProcessList) then
     begin
     //kill all running process
      for i := 0 to PTab.Tabs.Count-1 do
        begin
         AppName := Decode(FConfig.ReadString(IntToStr(i),'Name',''),'N90fL6FF9SXx+S');
         KillResult := KillProcess(AppName);
        end;

      //Get ClearData
      if FConfig.ReadBool('General', 'Ethernet_Task', False) then
      if KillResult <> 0 then ClearAllData() else Exit;
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
end;

procedure TMainForm.Main_CHKBOX1Click(Sender: TObject);
var
  User: String;
begin
User := CurrentUserName;
with Sender as TCheckBox do
ScheduleRunAtStartup(Checked,ExtractFileName(ChangeFileExt(Application.ExeName,'')),Application.ExeName,User);
end;

procedure TMainForm.Main_CHKBOX4Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  Edit2.Enabled := not Checked;
  Edit4.Enabled := not Checked;
  Main_BTN6.Enabled := not Checked;
 end;
end;

procedure TMainForm.Main_CHKBOX5Click(Sender: TObject);
begin
with Sender as TCheckBox do if Checked then
SetTimer(Handle,TIMER2,1000,@TimerCallBack2) else KillTimer(Handle,TIMER2);
end;

procedure TMainForm.Main_CHKBOX6Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  if Checked = True then
   HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','BossKey', ''),True))
  else
   HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString('General','BossKey', ''),True));
 end;
end;

procedure TMainForm.Main_BTN5Click(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := Edit1;
  HOTKEYCHANGER_BTN1Click(Sender);
  Edit1.Text := MainForm.FConfig.ReadString(IntToStr(MainForm.PTab.TabIndex),'Key', '');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString(IntToStr(MainForm.PTab.TabIndex),'Key', ''),True));
    MainForm.FConfig.WriteString(IntToStr(MainForm.PTab.TabIndex),'Key',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    if Edit1.Text <> '' then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
    MainForm.Main_BTN5.Caption := Edit1.Text;
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
  Edit1.Text := MainForm.FConfig.ReadString('General','ClearData_Key', '');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString('General','ClearData_Key', ''),True));
    MainForm.FConfig.WriteString('General','ClearData_Key',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    if Edit1.Text <> '' then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
    MainForm.Main_BTN9.Caption := Edit1.Text;
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
  Edit1.Text := MainForm.FConfig.ReadString('General','BossKey', '');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString('General','BossKey', ''),True));
    MainForm.FConfig.WriteString('General','BossKey',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    MainForm.Main_BTN8.Caption := Edit1.Text;
    if Edit1.Text <> '' then
    if MainForm.Main_CHKBOX6.Checked = True then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
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
  s,d: String;
  NewFilePath, WorkingDirPath: String;
begin
s := ''; d:= '';
if SelectExe(String(_('GLOBAL_HINT_BTN_BTN6', FConfig.ReadString('General','Language',EN_US))), s,d) then
 begin
  if ExtractFileExt(s) = '.lnk' then
   begin
    //Extract info from .lnk
    NewFilePath := PathFromLNK(s);
    WorkingDirPath := WorkingDirFromLNK(s);
    if FileExists(NewFilePath) then
     begin
      Edit1.Text := ExtractFileName(NewFilePath);
      Edit2.Text := NewFilePath;
      Edit4.Text := WorkingDirPath;
     end;
   end else
   begin
    Edit1.Text := ExtractFileName(d);
    Edit2.Text := s;
    Edit4.Text := ExtractFilePath(s);
   end;
 end;
end;

procedure TMainForm.Main_BTN4Click(Sender: TObject);
begin
with ProcessesForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := ListBox1;
  ProcessToList(ListBox1);
  ListBox1.Sorted := True;
  ListBox1.Items.Delete(FindString(ListBox1.Items,ExtractFileName(ParamStr(0))));
  if (Showmodal <> mrCancel) and (ListBox1.ItemIndex <> -1) then
   begin
    Edit1.Text := ListBox1.Items[ListBox1.ItemIndex];
   end;
 end;
end;

procedure TMainForm.Main_BTN7Click(Sender: TObject);
begin
with ProcessesForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := ListBox1;
  ProcessToList(ListBox1);
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

procedure TMainForm.TimerImgClick(Sender: TObject);
begin
ShutdownForm.PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TMainForm.FavImgClick(Sender: TObject);
begin
LNK_Form.GeneralMenu.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
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
Main_RADGrp1.ItemIndex := FConfig.ReadInteger(IntToStr(PTab.TabIndex),'ProcState',0);
Main_BTN5.Caption := FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', '');
Edit4.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'WorkingDir',''),'N90fL6FF9SXx+S');
end;

procedure TMainForm.Main_BTN2Click(Sender: TObject);
begin
PTab.Tabs.Add(IntToStr(PTab.Tabs.Count));
PTab.TabIndex := PTab.Tabs.Count -1;
FConfig.WriteString(IntToStr(PTab.TabIndex),'Name','');
FConfig.WriteString(IntToStr(PTab.TabIndex),'Location','');
FConfig.WriteString(IntToStr(PTab.TabIndex),'Key','');
FConfig.WriteBool(IntToStr(PTab.TabIndex), 'NoRunFile', False);
FConfig.WriteInteger(IntToStr(PTab.TabIndex),'ProcState',0);
FConfig.WriteString(IntToStr(PTab.TabIndex),'WorkingDir','');
FConfig.UpdateFile;
PTabChange(Sender);
end;

procedure TMainForm.Main_BTN3Click(Sender: TObject);
var
 I: Integer;
begin
if PTab.Tabs.Count <> 0 then
if MessageDlg(_(GLOBAL_TEXT_MSG2, FConfig.ReadString('General','Language',EN_US)), mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', ''),True));
    FConfig.EraseSection(PTab.Tabs[PTab.TabIndex]);
    FConfig.UpdateFile;
    PTab.Tabs.Delete(PTab.TabIndex);
    //Daca mai sunt taburi atunci se sterge, in caz contrar se face unul gol
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
if Active = False then SetForegroundWindow(Handle);
end;

procedure TMainForm.FavTrayDblClick(Sender: TObject);
begin
with LNK_Form do
if Visible = False then
  begin
   TabsChange(LNK_Form);
   Show;
   SetForegroundWindow(Handle);
   LNK_Form.ActiveControl := LNK_Form.List;
  end else Hide;
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
  Edit1.Text := MainForm.FConfig.ReadString('General','MainKey', 'Shift+Ctrl+Alt+F12');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString('General','MainKey', 'Shift+Ctrl+Alt+F12'),True));
    MainForm.FConfig.WriteString('General','MainKey',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    if Edit1.Text <> '' then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
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
