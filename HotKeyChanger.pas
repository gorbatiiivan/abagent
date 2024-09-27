{
Редактор горячих клавиш Delphi
Отлавливает не только Ctrl, Shift, Alt но и Win
Автор Горкун Григорий https://kuzduk.ru/delphi/kulibrary

НУЖНО СДЕЛАТЬ:
Запретить в ComboBox все HK: Up Dn Left Right PgUp PgDown чтоб при OnKeyDown они не меняли строку а делали только KeyToStr
Запретить потрею фокуса по Tab в ComboBox и Edit1
Перехватить все глобальные клавиши системы чтоб они не выпонгялись, а только  отображались редакторе, например Win чтоб не включалось меню пуск, или например Win + E
}
unit HotKeyChanger;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  THotKeyForm = class(TForm)
    chWin: TCheckBox;
    chAlt: TCheckBox;
    chShift: TCheckBox;
    chCtrl: TCheckBox;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    HOTKEYCHANGER_BTN2: TButton;
    HOTKEYCHANGER_BTN3: TButton;
    HOTKEYCHANGER_BTN1: TButton;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chWinClick(Sender: TObject);
    procedure chCtrlClick(Sender: TObject);
    procedure chShiftClick(Sender: TObject);
    procedure chAltClick(Sender: TObject);
    procedure HOTKEYCHANGER_BTN1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    _KeyDown: Boolean;
    procedure ModToCheckBox(const ModStr: string = '');
  public
    { Public declarations }
    procedure Translate(aLanguageID: String);
  end;

var
  HotKeyForm: THotKeyForm;

function kuHotKeyEditorExecute: Boolean;

//Key ~ Mod ~ Str
function  ModToStr: string; overload;
function  ModToStr(sMod: word): string; overload;
function  KeyToStr(Key: word): string;
procedure StrToKeyMod(ShortcutStr: string; var vKey, vMod: word);

//Key Down
function KeyDownly(Key: integer): Boolean;
function CtrlDown: Boolean;
function ShiftDown: Boolean;
function AltDown: Boolean;
function WinDown: Boolean;

implementation

uses Translation, Unit1;

{$R *.dfm}

procedure THotKeyForm.Translate(aLanguageID: String);
var
 TempInteger: Integer;
begin
  Caption := _(HOTKEYCHANGER_CPTN, aLanguageID);
  HOTKEYCHANGER_BTN1.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN1, aLanguageID);
  HOTKEYCHANGER_BTN2.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN2, aLanguageID);
  HOTKEYCHANGER_BTN3.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN3, aLanguageID);
end;

procedure THotKeyForm.FormCreate(Sender: TObject);
begin
Translate(MainForm.FConfig.ReadString('General','Language',EN_US));
end;

//============================================================================== kuHotKeyEditorExecute
function kuHotKeyEditorExecute: Boolean;
begin
if Application.FindComponent('FormHotKeys') = nil then
  Application.CreateForm(THotKeyForm, HotKeyForm);
end;

{$REGION ' Form '}

procedure THotKeyForm.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  sMod, sKey: string;
begin
//if (Key = 9) and (ActiveControl = Self) then begin
//  //не работает!
//  Perform(CM_DialogKey, VK_TAB, 0);
//  ActiveControl := Self;
//  Self.SetFocus;
//end;
sMod := ModToStr;
sKey := KeyToStr(Key);
_KeyDown := sKey <> '';
Edit1.text := sMod + sKey;
ModToCheckBox;
HotKeyForm.ComboBox1.ItemIndex := HotKeyForm.ComboBox1.Items.IndexOf(sKey);
end;

//------------------------------------------------------------------------------ Edit1 Key Up
procedure THotKeyForm.Edit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if not _KeyDown then begin
  ModToCheckBox('');
  Edit1.text := '';
end;
//if (KeyToStr(Key) = '') and (ModToStr = '') then
end;

//------------------------------------------------------------------------------ ComboBox Change

procedure THotKeyForm.ComboBox1Change(Sender: TObject);
var
 p: integer;
 s: string;
 sKey, sMod: word;
begin
 StrToKeyMod(Edit1.Text, sKey, sMod);
 Edit1.Text := ModToStr(sMod) + ComboBox1.Text;
end;

//------------------------------------------------------------------------------ ComboBox KeyDown
procedure THotKeyForm.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 s: string;
 //k: Word;
begin
 s := KeyToStr(Key);
 //k := Key;
 ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(s);
 //if Key = VK_TAB then ActiveControl := ComboBox1; //не работает
 Key := 0; //чтобы не обрабатывать клавиши Up, Down, Left, Right, Home, End, PgUp, PgDown,
end;

//------------------------------------------------------------------------------ chCtrl
procedure THotKeyForm.chCtrlClick(Sender: TObject);
var
 p: integer;
 s: string;
 sKey, sMod: word;
begin
if chCtrl.Checked then
 begin
  StrToKeyMod(Edit1.Text, sKey, sMod);
  sMod := MOD_CONTROL xor sMod;
  Edit1.Text := ModToStr(sMod) + KeyToStr(sKey);
 end else
 begin
  s := Edit1.Text;
  p := pos('Ctrl+', Edit1.Text);
  if p <> 0 then Delete(s, p, 5);
  Edit1.Text := s;
 end;
end;

//------------------------------------------------------------------------------ chWin
procedure THotKeyForm.chWinClick(Sender: TObject);
var
 p: integer;
 s: string;
 sKey, sMod: word;
begin
 if chWin.Checked then
 begin
  StrToKeyMod(Edit1.Text, sKey, sMod);
  sMod := MOD_WIN xor sMod;
  Edit1.Text := ModToStr(sMod) + KeyToStr(sKey);
 end else
 begin
  s := Edit1.Text;
  p := pos('Win+', Edit1.Text);
  if p <> 0 then Delete(s, p, 4);
  Edit1.Text := s;
 end;
end;

//------------------------------------------------------------------------------ chShift
procedure THotKeyForm.chShiftClick(Sender: TObject);
var
 p: integer;
 s: string;
 sKey, sMod: word;
begin
if chShift.Checked then
 begin
  StrToKeyMod(Edit1.Text, sKey, sMod);
  sMod := MOD_SHIFT xor sMod;
  Edit1.Text := ModToStr(sMod) + KeyToStr(sKey);
 end else
 begin
  s := Edit1.Text;
  p := pos('Shift+', Edit1.Text);
  if p <> 0 then Delete(s, p, 6);
  Edit1.Text := s;
 end;
end;

//------------------------------------------------------------------------------ chAlt

procedure THotKeyForm.chAltClick(Sender: TObject);
var
 p: integer;
 s: string;
 sKey, sMod: word;
begin
if chAlt.Checked then
 begin
  StrToKeyMod(Edit1.Text, sKey, sMod);
  sMod := MOD_ALT xor sMod;
  //FormHotKeys.Caption := ModToStr(sMod) + '|||' + KeyToStr(sKey);
  Edit1.Text := ModToStr(sMod) + KeyToStr(sKey);
 end else
 begin
  s := Edit1.Text;
  p := pos('Alt+', Edit1.Text);
  if p <> 0 then Delete(s, p, 4);
  Edit1.Text := s;
 end;
end;

//------------------------------------------------------------------------------ Moding To CheckBox
procedure THotKeyForm.ModToCheckBox(const ModStr: string = '');
begin
if ModStr <> '' then begin
  chCtrl.Checked  := pos('Ctrl',  ModStr) <> 0;
  chShift.Checked := pos('Shift', ModStr) <> 0;
  chAlt.Checked   := pos('Ctrl',  ModStr) <> 0;
  chWin.Checked   := pos('Win',   ModStr) <> 0;
  exit;
end;
chCtrl.Checked  := CtrlDown;
chShift.Checked := ShiftDown;
chAlt.Checked   := AltDown;
chWin.Checked   := WinDown;
end;

procedure THotKeyForm.HOTKEYCHANGER_BTN1Click(Sender: TObject);
begin
Edit1.Text := '';
ComboBox1.ItemIndex := -1;
chShift.Checked := False;
chCtrl.Checked := False;
chWin.Checked := False;
chAlt.Checked := False;
end;

{$ENDREGION}
{$REGION '  Uni  Key ~ Mod ~ Str  '}
{
Key - клавиша
Mod - клавиша модификатор Ctrl, Shift, Alt, Win
ShiftState - набор модификаторов ssCtrl, ssShift, ssAlt. БЕЗ клавиши Win

ShortCutToText - uses Vcl.Menus
GetKeyNameText - uese Winapi.Windows
}

//------------------------------------------------------------------------------ Str To KeyMod
procedure StrToKeyMod(ShortcutStr: string; var vKey, vMod: word);
var k:word;
begin
 vMod := 0;
 if pos('Win+',  ShortcutStr)<>0 then vMod :=MOD_WIN or vMod;
 if pos('Shift+',ShortcutStr)<>0 then vMod :=MOD_SHIFT or vMod;
 if pos('Ctrl+', ShortcutStr)<>0 then vMod :=MOD_CONTROL or vMod;
 if pos('Alt+',  ShortcutStr)<>0 then vMod :=MOD_ALT or vMod;

if vMod <> 0 then
begin
  if pos('Win+',  ShortcutStr)<>0 then Delete(ShortcutStr, pos('Win+',  ShortcutStr),4);
  if pos('Shift+',ShortcutStr)<>0 then Delete(ShortcutStr, pos('Shift+',ShortcutStr),6);
  if pos('Ctrl+', ShortcutStr)<>0 then Delete(ShortcutStr, pos('Ctrl+', ShortcutStr),5);
  if pos('Alt+',  ShortcutStr)<>0 then Delete(ShortcutStr, pos('Alt+',  ShortcutStr),4);
end;

for k := 3 to 226 do
  if pos(ShortcutStr, KeyToStr(k)) <> 0 then begin
   vKey := k;
  //yy(ShortcutString+'|||'+Chr(vkey));
   break;
  end;
end;

//------------------------------------------------------------------------------ Key To Str
function KeyToStr(Key: word): string;
//спасибо n0wheremany
var sKey: String;
begin
case key of
     3:sKey:='Scroll Lock';
     8:sKey:='BackSpace';
     9:sKey:='Tab';
    12:sKey:='Num 5';
    13:sKey:='Enter';

    20:sKey:='Caps Lock';
    27:sKey:='Esc';
    32:sKey:='Space';
    33:sKey:='PgUp';
    34:sKey:='PgDn';
    35:sKey:='End';
    36:sKey:='Home';
    37:sKey:='Left';
    38:sKey:='Up';
    39:sKey:='Right';
    40:sKey:='Down';
    44:sKey:='PrintScreen';
    45:sKey:='Ins';
    46:sKey:='Del';

    48..57,
    65..90 :sKey:=Chr(key);

    96..105:sKey:='Num '+inttostr(key-96);

   106:sKey:='Num *';
   107:sKey:='Num +';
   109:sKey:='Num -';
   110:sKey:='Num Del';
   111:sKey:='Num /';

   112..135:sKey:='F'+inttostr(key-111);

   144:sKey:='PauseBreak';
   145:sKey:='ScrollLock';

   172:sKey:='M';
   173:sKey:='D';
   174:sKey:='C';
   175:sKey:='B';
   176:sKey:='P';
   177:sKey:='Q';
   178:sKey:='J';
   179:sKey:='G';
   183:sKey:='F';

   186:sKey:=';';
   187:sKey:='=';
   188:sKey:='<';
   190:sKey:='>';
   189:sKey:='-';
   192:sKey:='~';
   194:sKey:='F15';
   219:sKey:='[';
   221:sKey:=']';
   222:sKey:='''';

   191:sKey:='/';
   220:sKey:='\';
   226:sKey:='\';

   else
   begin
     sKey:='';
//     exit;
   end;
end;
Result := sKey;
end;

//------------------------------------------------------------------------------ Mod To Str
function ModToStr: string; overload;
var s: String;
begin
Result := '';

//if ((HiWord(GetKeyState(VK_LWIN))<>0) or (HiWord(GetKeyState(VK_RWIN))<>0)) then Result := 'Win+';
//if HiWord(GetKeyState(VK_CONTROL))<>0 then Result := Result + 'Ctrl+';
//if HiWord(GetKeyState(VK_SHIFT))<>0   then Result := Result + 'Shift+';
//if HiWord(GetKeyState(VK_MENU))<>0    then Result := Result + 'Alt+';

if WinDown   then Result := 'Win+';
if CtrlDown  then Result := Result + 'Ctrl+';
if ShiftDown then Result := Result + 'Shift+';
if AltDown   then Result := Result + 'Alt+';
end;

//------------------------------------------------------------------------------ Mod To Str
function ModToStr(sMod: word): string; overload;
begin
Result := '';
if (sMod = MOD_WIN or sMod)     then Result := 'Win+';
if (sMod = MOD_CONTROL or sMod) then Result := Result + 'Ctrl+';
if (sMod = MOD_SHIFT or sMod)   then Result := Result + 'Shift+';
if (sMod = MOD_ALT or sMod)     then Result := Result + 'Alt+';
end;

{$ENDREGION}
{$REGION '  Uni Key Down  '}

//------------------------------------------------------------------------------ Key Downly
function KeyDownly(Key: integer): Boolean;
{
вжата ли клавиша?
Ctrl  = VK_Control
Shift = VK_Shift
Alt   = VK_Menu
MouseRight = VK_RBUTTON
}
var
 State : TKeyboardState;
begin
GetKeyboardState(State);
Result := ( (State[Key] and 128) <> 0 );
//Result := HiWord(GetKeyState(Key)) <> 0 ;
end;

//------------------------------------------------------------------------------ Ctrl
function CtrlDown: Boolean;
//вжата ли клавиша Ctrl?
begin
Result := KeyDownly(VK_CONTROL);
end;

//------------------------------------------------------------------------------ Shift
function ShiftDown: Boolean;
//вжата ли клавиша Shift?
begin
Result := KeyDownly(VK_SHIFT);
end;

//------------------------------------------------------------------------------ Alt
function AltDown: Boolean;
//вжата ли клавиша Alt?
begin
Result := KeyDownly(VK_MENU);
end;

//------------------------------------------------------------------------------ Win
function WinDown: Boolean;
//вжата ли клавиша Alt?
begin
Result := KeyDownly(VK_LWIN) or KeyDownly(VK_RWIN);
end;

//------------------------------------------------------------------------------ KeyDownEmulate
procedure KeyDownEmulate(Component: TComponent;  Key: Word; Shift: TShiftState = []);
var k: word;
begin
//эмулируем нажатие клавиши чтоб всё сработало точно также как и в kuShellListView.pas
k := Key;
//LVS.KeyDown(k, []);
end;

{$ENDREGION}

end.
