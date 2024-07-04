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
    CheckBox1: TCheckBox;
    Button2: TButton;
    GroupBox3: TGroupBox;
    CheckBox3: TCheckBox;
    Edit3: TEdit;
    Button5: TButton;
    ProcessMenu: TPopupMenu;
    GroupBox4: TGroupBox;
    MousePosBox: TComboBox;
    Button6: TButton;
    GroupBox5: TGroupBox;
    CheckBox7: TCheckBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    BossCheckBox: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox8: TCheckBox;
    Button1: TButton;
    TitleBarPanel1: TTitleBarPanel;
    LogImg: TImage;
    Button7: TButton;
    RadioGroup2: TRadioGroup;
    TimerImage: TImage;
    PTab: TTabControl;
    Label1: TLabel;
    Edit1: TEdit;
    Button4: TButton;
    GroupBox1: TGroupBox;
    RadioGroup1: TRadioGroup;
    GroupBox8: TGroupBox;
    Label2: TLabel;
    CheckBox2: TCheckBox;
    Edit2: TEdit;
    Button3: TButton;
    Label3: TLabel;
    CheckBox4: TCheckBox;
    AddButton: TButton;
    RemoveButton: TButton;
    FavLNKImage: TImage;
    FavTray: TTrayIcon;
    TimerTrayIcon: TTrayIcon;
    ClearDataBtn: TButton;
    BossBtn: TButton;
    ProcessHotKeyBtn: TButton;
    ImageList1: TImageList;
    Edit4: TEdit;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure MousePosBoxChange(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LogImgClick(Sender: TObject);
    procedure TitleBarPanel1CustomButtons0Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure TimerImageClick(Sender: TObject);
    procedure PTabChange(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure RemoveButtonClick(Sender: TObject);
    procedure FavLNKImageClick(Sender: TObject);
    procedure FavTrayClick(Sender: TObject);
    procedure TimerTrayIconClick(Sender: TObject);
    procedure ClearDataBtnClick(Sender: TObject);
    procedure BossBtnClick(Sender: TObject);
    procedure ProcessHotKeyBtnClick(Sender: TObject);
    procedure BossCheckBoxClick(Sender: TObject);
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
     LNK_Utils, Help, Processes;

{$R *.dfm}

// form functions/procedure
//------------------------------------------------------------------------------

procedure TMainForm.WMSysCommand(var Message: TWMSysCommand);
begin
  if Message.CmdType = SC_CONTEXTHELP then
   begin
   with HelpForm do
    begin
     Position := poDesktopCenter;
     PageControl1.ActivePageIndex := 0;
     //Read HotKeys from ini to help form
     ListView1.Items[1].SubItems.Insert(0,FConfig.ReadString('General','ClearData_Key',''));
     ListView1.Items[2].SubItems.Insert(0,FConfig.ReadString('General','BossKey',''));
     ListView1.Items[3].SubItems.Insert(0,FConfig.ReadString('General','TimerForm_Timer_Key',''));
     ListView1.Items[4].SubItems.Insert(0,FConfig.ReadString('General','LNKForm_Favorites_Key',''));
     Show;
    end;
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
  if not IsProcessRunning(ProcessName) and (CheckBox2.Checked = False) then
   begin
    RunApplication(ExePath, '', WorkingDir);
   end else
   //Cand procesul e deschis, se apasa pe hotkey el se ascunde
   if isWindow(GetWinHandleFromProcId(GetProcessID(ProcessName))) then
    begin
     SetMasterMute(FConfig.ReadBool('General', 'Mute', CheckBox4.Checked));
     HideWindowsForProcess(ProcessName);
     end else
     //Daca procesul este ascuns, el se face vazut
    begin
     if FConfig.ReadBool('General', 'Mute', CheckBox4.Checked) then SetMasterMute(False);
     ShowAllHiddenWindowsInTaskbar();
     if FConfig.ReadInteger(Section,'ProcState',0) = 0 then
     RestoreWindowsForProcess(ProcessName);
    end;
 end;
end;

// ini file
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
  FConfig.WriteInteger(IntToStr(PTab.TabIndex),'ProcState',RadioGroup1.ItemIndex);
  FConfig.WriteString(IntToStr(PTab.TabIndex),'WorkingDir',Encode(Edit4.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteBool('General', 'AutoRun', CheckBox1.Checked);
  FConfig.WriteBool(IntToStr(PTab.TabIndex), 'NoRunFile', CheckBox2.Checked);
  FConfig.WriteBool('General', 'AutoCloseAPP', CheckBox3.Checked);
  FConfig.WriteBool('General', 'Mute', CheckBox4.Checked);
  FConfig.WriteBool('General', 'EnabledLogFile', CheckBox5.Checked);
  FConfig.WriteBool('General', 'Ethernet_Task', CheckBox7.Checked);
  FConfig.WriteBool('General', 'BossClearEthernetData', CheckBox8.Checked);
  FConfig.WriteBool('General', 'BossCheckBox', BossCheckBox.Checked);
  FConfig.WriteString('General','Task Manager Name', Encode(Edit3.Text,'N90fL6FF9SXx+S'));
  FConfig.WriteInteger('General', 'CursorPos', MousePosBox.ItemIndex);
  FConfig.WriteInteger('General','BossProcState',RadioGroup2.ItemIndex);
  FConfig.WriteBool('General','LNKForm_FavoriteInTray',FavTray.Visible);
  FConfig.WriteBool('General','TimerForm_TimerInTray',TimerTrayIcon.Visible);
  FConfig.WriteInteger('General','TabIndex',PTab.TabIndex);
  FConfig.UpdateFile;
 end else
 begin
  //Read all process to tabs
  ScanProcessListFromIni(FConfig,PTab);
  PTab.TabIndex := FConfig.ReadInteger('General','TabIndex',0);
  ProcessHotKeyBtn.Caption := FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', '');
  BossBtn.Caption := FConfig.ReadString('General','BossKey', '');
  //daca bosscheckbox este true atunci se activeaza bosskey
  if FConfig.ReadBool('General', 'BossCheckBox', False) then
  begin
   for I := 0 to PTab.Tabs.Count-1 do
   begin
    HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString(IntToStr(I),'Key', ''),True));
   end;
   HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','BossKey', ''),True));

   BossCheckBox.Checked := True;
  end else
  begin  //se intoarce la regim normal, adica lucreaza numai hotkey, fara bosskey
   for I := 0 to PTab.Tabs.Count-1 do
   begin
    HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString(IntToStr(I),'Key', ''),True));
   end;
   EnableHotKey := True;

   BossCheckBox.Checked := False;
  end;

  ClearDataBtn.Caption := FConfig.ReadString('General','ClearData_Key', '');
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','ClearData_Key', ''),True));
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','LNKForm_Favorites_Key',''),True));
  HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','TimerForm_Timer_Key',''),True));

  CheckBox1.Checked := FConfig.ReadBool('General', 'AutoRun', CheckBox1.Checked);

  CheckBox2.Checked := FConfig.ReadBool(IntToStr(PTab.TabIndex), 'NoRunFile', CheckBox2.Checked);
  //Close process when taskmanager running
  if FConfig.ReadBool('General', 'AutoCloseAPP', CheckBox3.Checked) then
   begin
    SetTimer(Handle,TIMER2,1000,@TimerCallBack2);
    CheckBox3.Checked := True
   end else
   begin
    CheckBox3.Checked := False;
   end;

  CheckBox4.Checked := FConfig.ReadBool('General', 'Mute', CheckBox4.Checked);
  //Log file
  if FConfig.ReadBool('General', 'EnabledLogFile', CheckBox5.Checked) then
   begin
    CheckBox5.Checked := True;
    LogWrite('User: ' + CurrentUserName, 'asAdmin: '+ABBoolToStr(HasAdministratorRights()), 'Open');
   end else CheckBox5.Checked := False;

  CheckBox7.Checked := FConfig.ReadBool('General', 'Ethernet_Task', CheckBox7.Checked);

  CheckBox8.Checked := FConfig.ReadBool('General', 'BossClearEthernetData', CheckBox8.Checked);

  CheckBox1.Enabled := HasAdministratorRights();
  CheckBox7.Enabled := HasAdministratorRights();
  CheckBox8.Enabled := HasAdministratorRights();
  ClearDataBtn.Enabled := HasAdministratorRights();

  Edit1.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Name',''),'N90fL6FF9SXx+S');
  Edit2.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'Location',''),'N90fL6FF9SXx+S');
  Edit3.Text := Decode(FConfig.ReadString('General','Task Manager Name', Edit3.Text),'N90fL6FF9SXx+S');
  Edit4 .Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'WorkingDir',''),'N90fL6FF9SXx+S');
  MousePosBox.ItemIndex := FConfig.ReadInteger('General', 'CursorPos', 0);
  MousePosBoxChange(Self);

  RadioGroup1.ItemIndex := FConfig.ReadInteger(IntToStr(PTab.TabIndex),'ProcState',0);
  RadioGroup2.ItemIndex := FConfig.ReadInteger('General','BossProcState',0);

  FavTray.Visible := FConfig.ReadBool('General','LNKForm_FavoriteInTray',False);
  TimerTrayIcon.Visible := FConfig.ReadBool('General','TimerForm_TimerInTray',False);
 end;
end;

//MainForm
//------------------------------------------------------------------------------

procedure TMainForm.MyExcept(Sender:TObject; E:Exception);
begin
  If E is Exception then
    Exit
  else
    Exit
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
LogImg.Picture.Graphic := LoadImageResource('log24');
TimerImage.Picture.Graphic := LoadImageResource('time24');
FavLNKImage.Picture.Graphic := LoadImageResource('star24');

Application.OnException := MyExcept;
//Create HotKeyManager
HotKeyManager := THotKeyManager.Create(Self);
HotKeyManager.OnHotKeyPressed := HotKeyManagerHotKeyPressed;
HotKeyManager.AddHotKey(TextToHotKey('Shift+Ctrl+Alt+F12',True));
//Read inifile
RegIni(False, False);

TskMgrList := TStringList.Create;
ProcessList := TListBox.CreateParented(Handle);

ReportMemoryLeaksOnShutdown := False;

//daca serviciul lucreaza atunci nu va trebui de oprit serviciul DPS
if ServiceRunning(nil, 'DPS') then
isDPSServiceRunning := True else isDPSServiceRunning := False;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
//Write logfile
if FConfig.ReadBool('General', 'EnabledLogFile', CheckBox5.Checked) then
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
if TextToHotKey('Shift+Ctrl+Alt+F12',True) = HotKey then
 begin
  Visible := not Visible;
  SetForegroundWindow(Handle);
 end;

//Get TimerForm HotKey
if TextToHotKey(FConfig.ReadString('General','TimerForm_Timer_Key',''),True) = HotKey then
   TimerTrayIconClick(MainForm);

//Get Lnk_Form HotKey
if TextToHotKey(FConfig.ReadString('General','LNKForm_Favorites_Key',''),True) = HotKey then
   FavTrayClick(MainForm);

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
  if FConfig.ReadBool('General', 'BossClearEthernetData', CheckBox8.Checked) then
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
    SetMasterMute(FConfig.ReadBool('General', 'Mute', CheckBox4.Checked));
   end;
 end;
end;

//procedure for create task managers list
procedure TMainForm.DoUpdateProcesses();
var
  i,j,l: integer;
  KillResult: Integer;
  AppName, AppLocation: String;
begin
  ProcessToList(ProcessList);

  //aici se inchide procesul cand se deschide taskmgr.exe
  if FConfig.ReadBool('General', 'AutoCloseAPP', CheckBox3.Checked) then
  begin
   if Edit3.Text <> '' then
   begin
    StrToList(Edit3.Text,';',TskMgrList);
    for j := 0 to TskMgrList.Count - 1 do
    if IsExistFromList(TskMgrList[j], ProcessList) then
     begin
     //kill all running process
      for l := 0 to PTab.Tabs.Count-1 do
        begin
         AppName := Decode(FConfig.ReadString(IntToStr(l),'Name',''),'N90fL6FF9SXx+S');
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

procedure TMainForm.CheckBox1Click(Sender: TObject);
var
  User: String;
begin
User := CurrentUserName;
with Sender as TCheckBox do
ScheduleRunAtStartup(Checked,ExtractFileName(ChangeFileExt(Application.ExeName,'')),Application.ExeName,User);
end;

procedure TMainForm.CheckBox2Click(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  Edit2.Enabled := not Checked;
  Edit4.Enabled := not Checked;
  Button3.Enabled := not Checked;
 end;
end;

procedure TMainForm.CheckBox3Click(Sender: TObject);
begin
with Sender as TCheckBox do if Checked then
SetTimer(Handle,TIMER2,1000,@TimerCallBack2) else KillTimer(Handle,TIMER2);
end;

procedure TMainForm.BossCheckBoxClick(Sender: TObject);
begin
with Sender as TCheckBox do
 begin
  if Checked = True then
   HotKeyManager.AddHotKey(TextToHotKey(FConfig.ReadString('General','BossKey', ''),True))
  else
   HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString('General','BossKey', ''),True));
 end;
end;

procedure TMainForm.ProcessHotKeyBtnClick(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := Edit1;
  Caption := 'HotKey changer';
  Button3Click(Sender);
  Edit1.Text := MainForm.FConfig.ReadString(IntToStr(MainForm.PTab.TabIndex),'Key', '');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString(IntToStr(MainForm.PTab.TabIndex),'Key', ''),True));
    MainForm.FConfig.WriteString(IntToStr(MainForm.PTab.TabIndex),'Key',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    if Edit1.Text <> '' then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
    MainForm.ProcessHotKeyBtn.Caption := Edit1.Text;
   end;
 end;
end;

procedure TMainForm.ClearDataBtnClick(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := Edit1;
  Caption := 'HotKey changer';
  Button3Click(Sender);
  Edit1.Text := MainForm.FConfig.ReadString('General','ClearData_Key', '');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString('General','ClearData_Key', ''),True));
    MainForm.FConfig.WriteString('General','ClearData_Key',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    if Edit1.Text <> '' then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
    MainForm.ClearDataBtn.Caption := Edit1.Text;
   end;
 end;
end;

procedure TMainForm.BossBtnClick(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := Edit1;
  Caption := 'HotKey changer';
  Button3Click(Sender);
  Edit1.Text := MainForm.FConfig.ReadString('General','BossKey', '');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString('General','BossKey', ''),True));
    MainForm.FConfig.WriteString('General','BossKey',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    MainForm.BossBtn.Caption := Edit1.Text;
    if Edit1.Text <> '' then
    if MainForm.BossCheckBox.Checked = True then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
   end;
 end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
RegIni(True, False);
RegIni(False, False);
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
RegIni(True, False);
Close;
end;

procedure TMainForm.Button3Click(Sender: TObject);
var
  s,d: String;
  NewFilePath, WorkingDirPath: String;
begin
s := ''; d:= '';
if SelectExe('Select executable file', s,d) then
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

procedure TMainForm.Button4Click(Sender: TObject);
begin
with ProcessesForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := ListBox1;
  ProcessToList(ListBox1);
  if (Showmodal <> mrCancel) then
   begin
    Edit1.Text := ListBox1.Items[ListBox1.ItemIndex];
   end;
 end;
end;

procedure TMainForm.Button5Click(Sender: TObject);
begin
with ProcessesForm do
 begin
  Position := poDesktopCenter;
  ActiveControl := ListBox1;
  ProcessToList(ListBox1);
  if (Showmodal <> mrCancel) then
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

procedure TMainForm.Button6Click(Sender: TObject);
begin
ShowMessage('Hide all processes when the mouse is moved to the selected screen position');
end;

procedure TMainForm.Button7Click(Sender: TObject);
begin
ShowMessage('1. Clear data usage Ethernet (need Admin Privileges)'+#10+
            '2. Delete data from the "Recent and Prefetch" folder (only what is launched from this application, including the program itself)'+#10+
            '3. Delete data from registry.');
end;

procedure TMainForm.LogImgClick(Sender: TObject);
var
 AFile: String;
begin
AFile := ExtractFilePath(Application.ExeName) + CurrentUserName + '.log';
if FileExists(AFile) then
RunApplication(AFile, '', PChar(ExtractFilePath(AFile)))
else
ShowMessage('The log file does not exist.');
end;

procedure TMainForm.TimerImageClick(Sender: TObject);
begin
ShutdownForm.PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
end;

procedure TMainForm.FavLNKImageClick(Sender: TObject);
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
CheckBox2.Checked := FConfig.ReadBool(IntToStr(PTab.TabIndex), 'NoRunFile', CheckBox2.Checked);
RadioGroup1.ItemIndex := FConfig.ReadInteger(IntToStr(PTab.TabIndex),'ProcState',0);
ProcessHotKeyBtn.Caption := FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', '');
Edit4.Text := Decode(FConfig.ReadString(IntToStr(PTab.TabIndex),'WorkingDir',''),'N90fL6FF9SXx+S');
end;

procedure TMainForm.AddButtonClick(Sender: TObject);
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

procedure TMainForm.RemoveButtonClick(Sender: TObject);
var
 I: Integer;
begin
if PTab.Tabs.Count <> 0 then
if MessageDlg('Do you really want to delete selected tab?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
   begin
    HotKeyManager.RemoveHotKey(TextToHotKey(FConfig.ReadString(IntToStr(PTab.TabIndex),'Key', ''),True));
    FConfig.EraseSection(PTab.Tabs[PTab.TabIndex]);
    FConfig.UpdateFile;
    PTab.Tabs.Delete(PTab.TabIndex);
    //Daca mai sunt taburi atunci se sterge, in caz contrar se face unul gol
    if PTab.Tabs.Count = 0 then AddButtonClick(Sender) else
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
var
 Input: TInput;
begin
ZeroMemory(@Input, SizeOf(Input));
SendInput(1, Input, SizeOf(Input));
with LNK_Form do
if isWindowVisible(Handle) then
 begin
  Hide;
 end else
if not isWindowVisible(Handle) then
  begin
   TabsChange(LNK_Form);
   Show;
   SetForegroundWindow(Handle);
  end;
LNK_Form.ActiveControl := LNK_Form.List;
end;

procedure TMainForm.TimerTrayIconClick(Sender: TObject);
var
 Input: TInput;
begin
ZeroMemory(@Input, SizeOf(Input));
SendInput(1, Input, SizeOf(Input));
with ShutdownForm do
if Visible = False then
 begin
  Position := poDesktopCenter;
  Show;
  SetForegroundWindow(Handle);
 end else
  begin
   Hide;
  end;
end;

end.
