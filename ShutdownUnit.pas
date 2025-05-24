unit ShutdownUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Menus, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TShutdownForm = class(TForm)
    Timer_GrpBox1: TGroupBox;
    Bevel3: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label7: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    ComboBox1: TComboBox;
    ComboBox_ExitMethod: TComboBox;
    CheckBox1: TCheckBox;
    UpDown1: TUpDown;
    Edit1: TEdit;
    CheckBox2: TCheckBox;
    GroupBox2: TGroupBox;
    Bevel1: TBevel;
    Label4: TLabel;
    Button1: TButton;
    Edit2: TEdit;
    UpDown2: TUpDown;
    Edit3: TEdit;
    UpDown3: TUpDown;
    Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    Timer_N2: TMenuItem;
    Timer_N3: TMenuItem;
    Timer_N1: TMenuItem;
    N4: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure ComboBox_ExitMethodChange(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure RadioButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Timer_N2Click(Sender: TObject);
    procedure Timer_N3Click(Sender: TObject);
    procedure Timer_N1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure update_widgets;
    function getmethod : byte;
    function do_reboot(var method : byte) : DWORD;
  public
    { Public declarations }
    procedure saveshutdowntoini();
    procedure Translate(aLanguageID: String);
  end;

const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';

var
  ShutdownForm: TShutdownForm;

  shutdown_tick : DWORD;
  first_show, start_enabled : boolean;
  method : byte;
  last_err : DWORD;
  hToken : THandle;
  tkp : TOKEN_PRIVILEGES;
  ReturnLength: DWORD;

  cmdl_force : boolean = false;
  cmdl_ignw  : boolean = false; // ignore wakeup on Standby
  cmdl_action : integer = -1;
  cmdl_action_param : string = '';

implementation

uses Unit1, HotKeyChanger, HotKeyManager, lnkForm, Translation, SystemUtils;

function SetSuspendState( Hibernate, ForceCritical, DisableWakeEvent: Boolean): Boolean; stdcall; external 'powrprof.dll';

{$R *.dfm}

procedure TShutdownForm.Translate(aLanguageID: String);
var
 TempInteger: Integer;
begin
 Caption := _(GLOBAL_HINT_IMG_TimerImg, aLanguageID);
 Timer_GrpBox1.Caption := _(Timer_CPTN_GRPBOX_GrpBox1, aLanguageID);
 //Load items and read itemindex to ComboBox
 TempInteger := ComboBox_ExitMethod.ItemIndex;
 StrToList(_(Timer_TEXT_COMBO_ComboBox1, aLanguageID),';',ComboBox_ExitMethod.Items);
 ComboBox_ExitMethod.ItemIndex := TempInteger;
 //-----------------------------------------------------------------------------
 RadioButton1.Caption := _(Timer_CPTN_RADBTN_RADBTN1, aLanguageID);
 //Load items and read itemindex to ComboBox
 TempInteger := ComboBox1.ItemIndex;
 StrToList(_(Timer_TEXT_COMBO_ComboBox2, aLanguageID),';',ComboBox1.Items);
 ComboBox1.ItemIndex := TempInteger;
 //-----------------------------------------------------------------------------
 Label2.Caption := _(Timer_CPTN_LBL_LBL2, aLanguageID);
 RadioButton2.Caption := _(Timer_CPTN_RADBTN_RADBTN2, aLanguageID);
 Label3.Caption := _(Timer_CPTN_LBL_LBL3, aLanguageID);
 CheckBox1.Caption := _(Timer_CPTN_CHKBOX_CHKBOX1, aLanguageID);
 CheckBox2.Caption := _(Timer_CPTN_CHKBOX_CHKBOX2, aLanguageID);
 GroupBox2.Caption := _(HELPFORM_TEXT_LSTVIEW_COL1, aLanguageID);
 Label4.Caption := _(Timer_CPTN_LBL_LBL4, aLanguageID);
 Button1.Caption := _(Timer_CPTN_BTN_BTN1, aLanguageID);
 Timer_N1.Caption := _(LNK_CPTN_MENUITEM_GEN_N1, aLanguageID);
 Timer_N2.Caption := _(LNK_CPTN_MENUITEM_GEN_N5, aLanguageID);
 Timer_N3.Caption := _(GLOBAL_CPTN_MENUITEM_Main_N2, aLanguageID);
end;

procedure getTimerParam();
var
 i: byte;
begin
for i := 1 to paramcount do
  begin
    if (paramstr(i) = '--enable') then
      start_enabled := true;

    if (paramstr(i) = '--force') then
      cmdl_force := true;

    if (paramstr(i) = '--ignore_wakeup') then
      cmdl_ignw := true;

    if (UpperCase(paramstr(i)) = '--POWEROFF') then
    begin
      cmdl_action := 0;
      if paramcount > i then
        cmdl_action_param := paramstr(i+1);
    end;

    if (UpperCase(paramstr(i)) = '--SHUTDOWN') then
    begin
      cmdl_action := 1;
      if paramcount > i then
        cmdl_action_param := paramstr(i+1);
    end;

    if (UpperCase(paramstr(i)) = '--REBOOT') then
    begin
      cmdl_action := 2;
      if paramcount > i then
        cmdl_action_param := paramstr(i+1);
    end;

    if (UpperCase(paramstr(i)) = '--LOGOFF') then
    begin
      cmdl_action := 3;
      if paramcount > i then
        cmdl_action_param := paramstr(i+1);
    end;

    if (UpperCase(paramstr(i)) = '--STANDBY') then
    begin
      cmdl_action := 4;
      if paramcount > i then
        cmdl_action_param := paramstr(i+1);
    end;
   ShutdownForm.ParentWindow := MainForm.Handle;
   ShutdownForm.Show;
   ShutdownForm.Hide;
  end;
end;

function lz(i : integer) : string;
begin
  if i < 10 then
    lz := '0'+inttostr(i)
  else
    lz := inttostr(i)
end;

function isdigit(c : char) : boolean;
begin
  isdigit := ((ord(c) > 47) and (ord(c) < 58));
end;

function string_is_digit(s: string) : boolean;
var
  all_digit : boolean;
  i : integer;
begin
  all_digit := true;
  for i := 1 to length(s) do
    all_digit := all_digit and isdigit(s[i]);
  string_is_digit := all_digit;
end;

function TShutdownForm.getmethod : byte;
var
  buffer : byte;
begin
  buffer := 0;
  if (ComboBox_ExitMethod.ItemIndex = 0) then buffer := 1;
  if (ComboBox_ExitMethod.ItemIndex = 1) then buffer := 3;
  if (ComboBox_ExitMethod.ItemIndex = 2) then buffer := 5;
  if (ComboBox_ExitMethod.ItemIndex = 3) then buffer := 7;
  if (ComboBox_ExitMethod.ItemIndex = 4) then buffer := 9;
  buffer := buffer + ord(checkbox1.checked);
  getmethod := buffer;
end;

(* ExitWindowsEx : http://msdn2.microsoft.com/en-us/library/aa376868.aspx *)
function TShutdownForm.do_reboot(var method : byte) : DWORD;
var
  uFlags : Cardinal;
begin
  last_err := 0;

  if ((method < 9) or (method > 11)) then
  begin
    case method of
      1 : uFlags :=  EWX_POWEROFF;
      2 : uFlags :=  EWX_POWEROFF + EWX_FORCE + EWX_FORCEIFHUNG;
      3 : uFlags :=  EWX_SHUTDOWN;
      4 : uFlags :=  EWX_SHUTDOWN + EWX_FORCE + EWX_FORCEIFHUNG;
      5 : uFlags :=  EWX_REBOOT;
      6 : uFlags :=  EWX_REBOOT + EWX_FORCE + EWX_FORCEIFHUNG;
      7 : uFlags :=  EWX_LOGOFF;
      8 : uFlags :=  EWX_LOGOFF + EWX_FORCE + EWX_FORCEIFHUNG;
    else
      uFlags := 0;
    end;

    if (uFlags > 0) then
      if not ExitWindowsEx(uFlags, $80000000)
        then last_err := GetLastError();
  end
  else
  begin
    // Standy need different api call...
    SetSuspendState(true, (method=10), Checkbox2.checked);
  end;

  do_reboot := last_err;
end;

procedure TShutdownForm.update_widgets;
begin
   Edit1.Enabled := RadioButton1.Checked;
   UpDown1.Enabled := RadioButton1.Checked;
   Edit2.Enabled := RadioButton2.Checked;
   UpDown2.Enabled := RadioButton2.Checked;
   Edit3.Enabled := RadioButton2.Checked;
   UpDown3.Enabled := RadioButton2.Checked;
   ComboBox1.Enabled := RadioButton1.Checked;
   Checkbox2.enabled:= ComboBox_ExitMethod.itemindex = 4;

   Edit1.text := inttostr(UpDown1.Position);
   Edit2.text := inttostr(UpDown2.Position);
   Edit3.text := inttostr(UpDown3.Position);
end;

procedure TShutdownForm.saveshutdowntoini();
var
 command_str : string;
const
 time_scale : array[0..1] of char = ('m', 'h');
begin
 // save latest settings ...
 MainForm.FConfig.WriteInteger('General','TimerForm_action', ComboBox_ExitMethod.ItemIndex);
 MainForm.FConfig.WriteInteger('General','TimerForm_force', ord(CheckBox1.Checked));
 MainForm.FConfig.WriteInteger('General','TimerForm_ignore_wakeup', ord(CheckBox2.Checked));
if RadioButton1.Checked then
 begin
  command_str := 'i' + lz(UpDown1.Position) + time_scale[ComboBox1.ItemIndex];
  MainForm.FConfig.WriteString('General','TimerForm_command', command_str);
 end else
 begin
  command_str := 'a' + lz(UpDown2.Position) + lz(UpDown3.Position);
  MainForm.FConfig.WriteString('General','TimerForm_command', command_str);
 end;
 MainForm.FConfig.UpdateFile;
end;

procedure TShutdownForm.FormCreate(Sender: TObject);
var
 action, force, ignore_wakeup : byte;
 command_str : string;
 i, errcode : integer;
begin
Translate(MainForm.FConfig.ReadString('General','Language',EN_US));

getTimerParam();

first_show := true;
ComboBox1.ItemIndex := 2;
ComboBox_ExitMethod.ItemIndex := 2;
UpDown1.Position := 1;
UpDown2.Position := 12;
UpDown3.Position := 0;

if first_show then
  begin
    first_show := false;

    if Length(cmdl_action_param)>0 then
    begin
      cmdl_action_param := MainForm.FConfig.ReadString('General','TimerForm_command','a0100');
      action := cmdl_action;
      command_str := cmdl_action_param;
      force := ord(cmdl_force);
      ignore_wakeup := ord(cmdl_ignw);
    end
      else
    begin
      action := 0;
      ignore_wakeup := 0;
      force := 1;
      command_str := 'i2h';
      action := MainForm.FConfig.ReadInteger('General','TimerForm_action',action);
      force := MainForm.FConfig.ReadInteger('General','TimerForm_force',force);
      ignore_wakeup := MainForm.FConfig.ReadInteger('General','TimerForm_ignore_wakeup',ignore_wakeup);
      command_str := MainForm.FConfig.ReadString('General','TimerForm_command','a0100');
    end;

    ComboBox_ExitMethod.ItemIndex := action;
    CheckBox1.Checked := boolean(force);
    CheckBox2.Checked := boolean(ignore_wakeup);

    if (length(command_str) >= 3) then
    begin
      if command_str[1] = 'i' then
      begin
        RadioButton1.checked := true;
        combobox1.ItemIndex := ord(command_str[length(command_str)] = 'h');
        delete(command_str, 1, 1);
        delete(command_str, length(command_str), 1);
        val(command_str, i, errcode);
        UpDown1.Position := i;
        UpDown2.Position := 0;
        UpDown3.Position := 0;
      end
        else
      begin
        RadioButton2.checked := true;
        delete(command_str, 1, 1);
        val(command_str[1]+command_str[2], i, errcode);
        UpDown2.Position := i;
        val(command_str[3]+command_str[4], i, errcode);
        UpDown3.Position := i;
        UpDown1.Position := 1;
        combobox1.ItemIndex := 1;
      end;
    end;

    if start_enabled then
    begin
      start_enabled := false;
      Button1.OnClick(NIL);
    end;

    update_widgets();
  end;
end;

procedure TShutdownForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = ORD(VK_ESCAPE) then Hide;

if Key = ORD(VK_F1) then MainForm.Main_N1Click(Self);
end;

procedure TShutdownForm.Button1Click(Sender: TObject);
var
  faktor : DWORD;
  command_str : string;
const
  time_scale : array[0..1] of char = ('m', 'h');
begin
  update_widgets();
  if Timer1.enabled then
  begin
    Timer1.enabled := false;
    label4.caption := _(Timer_CPTN_LBL_LBL4, MainForm.FConfig.ReadString('General','Language',EN_US));
    Button1.Caption := _(Timer_CPTN_BTN_BTN1, MainForm.FConfig.ReadString('General','Language',EN_US));
    Timer_GrpBox1.Enabled := true;
    Timer1.Enabled := false;
    MainForm.TimerImg.Hint := _(Timer_GLOBAL_TEXT_MSG1, MainForm.FConfig.ReadString('General','Language',EN_US));
    MainForm.TimerTrayIcon.Hint := _(Timer_GLOBAL_TEXT_MSG1, MainForm.FConfig.ReadString('General','Language',EN_US));
    LNK_Form.LNK_SPD_BTN1.Hint := _(Timer_GLOBAL_TEXT_MSG1, MainForm.FConfig.ReadString('General','Language',EN_US));
  end
    else
  begin
    // save latest settings ...
    MainForm.FConfig.WriteInteger('General','TimerForm_action', ComboBox_ExitMethod.ItemIndex);
    MainForm.FConfig.WriteInteger('General','TimerForm_force', ord(CheckBox1.Checked));
    MainForm.FConfig.WriteInteger('General','TimerForm_ignore_wakeup', ord(CheckBox2.Checked));
    MainForm.FConfig.UpdateFile;

    if RadioButton1.Checked then
    begin
      command_str := 'i' + lz(UpDown1.Position) + time_scale[ComboBox1.ItemIndex];
      MainForm.FConfig.WriteString('General','TimerForm_command', command_str);
      MainForm.FConfig.UpdateFile;
      if (UpDown1.Position >= 0)  and ((ComboBox1.ItemIndex = 0) or (ComboBox1.ItemIndex = 1)) then
      begin
        faktor := 1;
        if (ComboBox1.ItemIndex = 0) then
          faktor := 1000*60;
        if (ComboBox1.ItemIndex = 1) then
          faktor := 1000*60*60;
        Button1.Caption := _(Timer_CPTN_BTN_BTN1_2, MainForm.FConfig.ReadString('General','Language',EN_US));
        shutdown_tick := faktor*DWORD(UpDown1.Position) + GetTickCount;
        Timer_GrpBox1.Enabled := false;
        Timer1.enabled := true;
      end
        else
          MessageBox(0, PChar(_(Timer_GLOBAL_TEXT_MSG2, MainForm.FConfig.ReadString('General','Language',EN_US))),
          PChar(_(Timer_GLOBAL_TEXT_MSG3, MainForm.FConfig.ReadString('General','Language',EN_US))), MB_OK);
    end
      else
    begin
      command_str := 'a' + lz(UpDown2.Position) + lz(UpDown3.Position);
      MainForm.FConfig.WriteString('General','TimerForm_command', command_str);
      MainForm.FConfig.UpdateFile;
      Timer_GrpBox1.Enabled := false;
      Timer1.enabled := true;
      Button1.Caption :=  _(Timer_CPTN_BTN_BTN1_2, MainForm.FConfig.ReadString('General','Language',EN_US));
    end;
  end;
end;

procedure TShutdownForm.Timer1Timer(Sender: TObject);
var
  lt : TSystemTime;
  buffer : longint;
  last_err : DWORD;
  Transl_IN,Transl_AT: String;
begin
  Transl_IN := ' '+_(Timer_CPTN_RADBTN_RADBTN1, MainForm.FConfig.ReadString('General','Language',EN_US))+' ';
  Transl_AT := ' '+_(Timer_CPTN_RADBTN_RADBTN2, MainForm.FConfig.ReadString('General','Language',EN_US))+' ';
  method := 0;
  if RadioButton1.Checked then
  begin
    label4.Caption := ComboBox_ExitMethod.Text + Transl_IN + inttostr((shutdown_tick - GetTickCount()) div 1000 + 1) +
    _(Timer_GLOBAL_TEXT_MSG4, MainForm.FConfig.ReadString('General','Language',EN_US));
    MainForm.TimerImg.Hint := label4.caption;
    MainForm.TimerTrayIcon.Hint := label4.caption;
    LNK_Form.LNK_SPD_BTN1.Hint := label4.Caption;
    buffer := shutdown_tick - GetTickCount();
    if (buffer <= 0) then
      method := getmethod;
  end
    else
  begin
    label4.caption := ComboBox_ExitMethod.Text + Transl_AT + Edit2.Text + ':' + Edit3.Text +
    ' '+_(Timer_CPTN_LBL_LBL3, MainForm.FConfig.ReadString('General','Language',EN_US));

    MainForm.TimerImg.Hint := label4.caption;
    MainForm.TimerTrayIcon.Hint := label4.caption;
    LNK_Form.LNK_SPD_BTN1.Hint := label4.Caption;
    GetLocalTime(lt);
    if (lt.wHour = Word(UpDown2.Position)) and (lt.wMinute = Word(UpDown3.Position)) then
      method := getmethod;
  end;

  if method > 0 then
  begin
    Timer1.enabled := false;

    last_err := do_reboot(method);
    if (last_err > 0) then
    begin
      if (last_err = 1314) then
      begin
        OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken);
        LookupPrivilegeValue(nil, SE_SHUTDOWN_NAME, tkp.Privileges[0].Luid);
        tkp.PrivilegeCount := 1;  // one privilege to set
        tkp.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
        AdjustTokenPrivileges(hToken, False, tkp, 0,  nil, ReturnLength);
        last_err := do_reboot(method);
        if (last_err > 0) then
         begin
          MainForm.TimerImg.Hint := _(Timer_GLOBAL_TEXT_MSG5, MainForm.FConfig.ReadString('General','Language',EN_US))
          +inttostr(last_err)+_(Timer_GLOBAL_TEXT_MSG6, MainForm.FConfig.ReadString('General','Language',EN_US));
          MainForm.TimerTrayIcon.Hint := MainForm.TimerImg.Hint;
          LNK_Form.LNK_SPD_BTN1.Hint := MainForm.TimerImg.Hint;
         end else
          Exit; //From original code:Application.Destroy;
       end;
      //
    end
      else
    Exit; //From original code:Application.Destroy;
  end;
end;

procedure TShutdownForm.Edit1Change(Sender: TObject);
begin
  if (length(Edit1.Text) > 0) then
    if string_is_digit(Edit1.Text) then
    begin
      Updown1.Position := strtoint(Edit1.Text);
      update_widgets();
      Edit1.SelStart := length(Edit1.text);
      Edit1.SelLength := 0;
    end;
end;

procedure TShutdownForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',#8]) then
    key := #0
end;

procedure TShutdownForm.Edit2Change(Sender: TObject);
begin
  if (length(Edit2.Text) > 0) then
    if string_is_digit(Edit2.Text) then
      Updown2.Position := strtoint(Edit2.Text);
end;

procedure TShutdownForm.Edit3Change(Sender: TObject);
begin
  if (length(Edit3.Text) > 0) then
    if string_is_digit(Edit3.Text) then
      Updown3.Position := strtoint(Edit3.Text);
end;

procedure TShutdownForm.ComboBox_ExitMethodChange(Sender: TObject);
begin
update_widgets();
end;

procedure TShutdownForm.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
update_widgets;
end;

procedure TShutdownForm.RadioButton1Click(Sender: TObject);
begin
update_widgets();
end;

//Menu
procedure TShutdownForm.PopupMenu1Popup(Sender: TObject);
begin
Timer_N2.Checked := MainForm.FConfig.ReadBool('General','TimerForm_TimerInTray',False);
end;

procedure TShutdownForm.Timer_N2Click(Sender: TObject);
begin
with Sender as TMenuItem do
  begin
    Checked := not Checked;
    MainForm.TimerTrayIcon.Visible := Checked;
    MainForm.FConfig.WriteBool('General','TimerForm_TimerInTray',Checked);
    MainForm.FConfig.UpdateFile;
  end;
end;

procedure TShutdownForm.Timer_N3Click(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  HOTKEYCHANGER_BTN1Click(Sender);
  Edit1.Text := MainForm.FConfig.ReadString('General','TimerForm_Timer_Key','');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString('General','TimerForm_Timer_Key',''),True));
    MainForm.FConfig.WriteString('General','TimerForm_Timer_Key',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    if Edit1.Text <> '' then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
   end;
 end;
end;

procedure TShutdownForm.Timer_N1Click(Sender: TObject);
begin
if not ShutdownForm.Showing then
 begin
  ShutdownForm.Position := poDesktopCenter;
  ShutdownForm.Show;
  SetForegroundWindow(ShutdownForm.Handle);
 end else
  begin
   if not ShutdownForm.Timer1.Enabled then
      MainForm.TimerImg.Hint := _(Timer_GLOBAL_TEXT_MSG1, MainForm.FConfig.ReadString('General','Language',EN_US));
      MainForm.TimerTrayIcon.Hint := _(Timer_GLOBAL_TEXT_MSG1, MainForm.FConfig.ReadString('General','Language',EN_US));
      LNK_Form.LNK_SPD_BTN1.Hint := _(Timer_GLOBAL_TEXT_MSG1, MainForm.FConfig.ReadString('General','Language',EN_US));
   ShutdownForm.Close;
  end;
end;

end.
