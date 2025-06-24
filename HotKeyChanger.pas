unit HotKeyChanger;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

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
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chWinClick(Sender: TObject);
    procedure chCtrlClick(Sender: TObject);
    procedure chShiftClick(Sender: TObject);
    procedure chAltClick(Sender: TObject);
    procedure HOTKEYCHANGER_BTN1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FKeyDown: Boolean;
    procedure UpdateModifierCheckBoxes(const ModStr: string = '');
    procedure UpdateEditText;
    function GetCurrentModifiers: Word;
    procedure ClearAll;
  public
    procedure Translate(aLanguageID: String);
    function GetHotKeyString: string;
    procedure SetHotKeyString(const Value: string);
  end;

var
  HotKeyForm: THotKeyForm;

// Public functions
function CreateHotKeyEditor: Boolean;
function ModifierToString(aMod: Word): string;
function KeyToString(aKey: Word): string;
procedure StringToKeyModifier(const ShortcutStr: string; out vKey, vMod: Word);

// Key state functions
function IsKeyPressed(Key: Integer): Boolean;
function IsCtrlPressed: Boolean;
function IsShiftPressed: Boolean;
function IsAltPressed: Boolean;
function IsWinPressed: Boolean;

implementation

uses Translation, Unit1;

{$R *.dfm}

const
  // Modifier constants for better readability
  MOD_NONE = 0;

{ THotKeyForm }

procedure THotKeyForm.Translate(aLanguageID: String);
begin
  Caption := _(HOTKEYCHANGER_CPTN, aLanguageID);
  HOTKEYCHANGER_BTN1.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN1, aLanguageID);
  HOTKEYCHANGER_BTN2.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN2, aLanguageID);
  HOTKEYCHANGER_BTN3.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN3, aLanguageID);
end;

procedure THotKeyForm.FormCreate(Sender: TObject);
begin
  Translate(MainForm.FConfig.ReadString('General', 'Language', EN_US));
end;

procedure THotKeyForm.FormShow(Sender: TObject);
var
  sKey, sMod: Word;
begin
  UpdateModifierCheckBoxes(Edit1.Text);
  StringToKeyModifier(Edit1.Text, sKey, sMod);
  ComboBox1.ItemIndex:= ComboBox1.Items.IndexOf(KeyToString(sKey));
end;

procedure THotKeyForm.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  sMod, sKey: string;
begin
  sMod := ModifierToString(GetCurrentModifiers);
  sKey := KeyToString(Key);
  FKeyDown := sKey <> '';

  Edit1.Text := sMod + sKey;
  UpdateModifierCheckBoxes;
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(sKey);
end;

procedure THotKeyForm.Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not FKeyDown then
  begin
    UpdateModifierCheckBoxes('');
    Edit1.Text := '';
  end;
end;

procedure THotKeyForm.ComboBox1Change(Sender: TObject);
var
  sKey, sMod: Word;
begin
  StringToKeyModifier(Edit1.Text, sKey, sMod);
  Edit1.Text := ModifierToString(sMod) + ComboBox1.Text;
end;

procedure THotKeyForm.ComboBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  sKeyStr: string;
begin
  sKeyStr := KeyToString(Key);
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(sKeyStr);
  Key := 0; // Prevent default handling of navigation keys
end;

procedure THotKeyForm.chCtrlClick(Sender: TObject);
begin
  UpdateEditText;
end;

procedure THotKeyForm.chWinClick(Sender: TObject);
begin
  UpdateEditText;
end;

procedure THotKeyForm.chShiftClick(Sender: TObject);
begin
  UpdateEditText;
end;

procedure THotKeyForm.chAltClick(Sender: TObject);
begin
  UpdateEditText;
end;

procedure THotKeyForm.HOTKEYCHANGER_BTN1Click(Sender: TObject);
begin
  ClearAll;
end;

// Private methods

procedure THotKeyForm.UpdateModifierCheckBoxes(const ModStr: string);
begin
  if ModStr <> '' then
  begin
    chCtrl.Checked := Pos('Ctrl', ModStr) > 0;
    chShift.Checked := Pos('Shift', ModStr) > 0;
    chAlt.Checked := Pos('Alt', ModStr) > 0;
    chWin.Checked := Pos('Win', ModStr) > 0;
  end
  else
  begin
    chCtrl.Checked := IsCtrlPressed;
    chShift.Checked := IsShiftPressed;
    chAlt.Checked := IsAltPressed;
    chWin.Checked := IsWinPressed;
  end;
end;

procedure THotKeyForm.UpdateEditText;
var
  ModStr, KeyStr: string;
  sKey, sMod: Word;
begin
  // Get current modifier state from checkboxes
  sMod := MOD_NONE;
  if chCtrl.Checked then sMod := sMod or MOD_CONTROL;
  if chShift.Checked then sMod := sMod or MOD_SHIFT;
  if chAlt.Checked then sMod := sMod or MOD_ALT;
  if chWin.Checked then sMod := sMod or MOD_WIN;

  ModStr := ModifierToString(sMod);

  // Get key from ComboBox if selected
  if ComboBox1.ItemIndex >= 0 then
    KeyStr := ComboBox1.Text
  else
  begin
    StringToKeyModifier(Edit1.Text, sKey, sMod);
    KeyStr := KeyToString(sKey);
  end;

  Edit1.Text := ModStr + KeyStr;
end;

function THotKeyForm.GetCurrentModifiers: Word;
begin
  Result := MOD_NONE;
  if IsCtrlPressed then Result := Result or MOD_CONTROL;
  if IsShiftPressed then Result := Result or MOD_SHIFT;
  if IsAltPressed then Result := Result or MOD_ALT;
  if IsWinPressed then Result := Result or MOD_WIN;
end;

procedure THotKeyForm.ClearAll;
begin
  Edit1.Text := '';
  ComboBox1.ItemIndex := -1;
  chShift.Checked := False;
  chCtrl.Checked := False;
  chWin.Checked := False;
  chAlt.Checked := False;
end;

// Public methods

function THotKeyForm.GetHotKeyString: string;
begin
  Result := Edit1.Text;
end;

procedure THotKeyForm.SetHotKeyString(const Value: string);
var
  vKey, vMod: Word;
begin
  StringToKeyModifier(Value, vKey, vMod);

  chCtrl.Checked := (vMod and MOD_CONTROL) <> 0;
  chShift.Checked := (vMod and MOD_SHIFT) <> 0;
  chAlt.Checked := (vMod and MOD_ALT) <> 0;
  chWin.Checked := (vMod and MOD_WIN) <> 0;

  Edit1.Text := Value;
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(KeyToString(vKey));
end;

// Global functions

function CreateHotKeyEditor: Boolean;
begin
  if Application.FindComponent('HotKeyForm') = nil then
    Application.CreateForm(THotKeyForm, HotKeyForm);
  Result := True;
end;

procedure StringToKeyModifier(const ShortcutStr: string; out vKey, vMod: Word);
var
  TempStr: string;
  k: Word;
begin
  TempStr := ShortcutStr;
  vKey := 0;
  vMod := MOD_NONE;

  // Parse modifiers - order matters for proper deletion
  if Pos('Shift+', TempStr) > 0 then
  begin
    vMod := vMod or MOD_SHIFT;
    Delete(TempStr, Pos('Shift+', TempStr), 6);
  end;

  if Pos('Ctrl+', TempStr) > 0 then
  begin
    vMod := vMod or MOD_CONTROL;
    Delete(TempStr, Pos('Ctrl+', TempStr), 5);
  end;

  if Pos('Win+', TempStr) > 0 then
  begin
    vMod := vMod or MOD_WIN;
    Delete(TempStr, Pos('Win+', TempStr), 4);
  end;

  if Pos('Alt+', TempStr) > 0 then
  begin
    vMod := vMod or MOD_ALT;
    Delete(TempStr, Pos('Alt+', TempStr), 4);
  end;

  // Find the key
  if TempStr <> '' then
  begin
    for k := 3 to 226 do
    begin
      if SameText(TempStr, KeyToString(k)) then
      begin
        vKey := k;
        Break;
      end;
    end;
  end;
end;

function KeyToString(aKey: Word): string;
begin
  case aKey of
    3: Result := 'Scroll Lock';
    8: Result := 'BackSpace';
    9: Result := 'Tab';
    12: Result := 'Num 5';
    13: Result := 'Enter';
    20: Result := 'Caps Lock';
    27: Result := 'Esc';
    32: Result := 'Space';
    33: Result := 'PgUp';
    34: Result := 'PgDn';
    35: Result := 'End';
    36: Result := 'Home';
    37: Result := 'Left';
    38: Result := 'Up';
    39: Result := 'Right';
    40: Result := 'Down';
    44: Result := 'PrintScreen';
    45: Result := 'Ins';
    46: Result := 'Del';
    48..57, 65..90: Result := Chr(aKey);
    96..105: Result := 'Num ' + IntToStr(aKey - 96);
    106: Result := 'Num *';
    107: Result := 'Num +';
    109: Result := 'Num -';
    110: Result := 'Num Del';
    111: Result := 'Num /';
    112..135: Result := 'F' + IntToStr(aKey - 111); // F1=112, so 112-111=1
    144: Result := 'PauseBreak';
    145: Result := 'ScrollLock';
    172: Result := 'M';
    173: Result := 'D';
    174: Result := 'C';
    175: Result := 'B';
    176: Result := 'P';
    177: Result := 'Q';
    178: Result := 'J';
    179: Result := 'G';
    183: Result := 'F';
    186: Result := ';';
    187: Result := '=';
    188: Result := '<';
    189: Result := '-';
    190: Result := '>';
    191: Result := '/';
    192: Result := '~';
    194: Result := 'F15';
    219: Result := '[';
    220, 226: Result := '\';
    221: Result := ']';
    222: Result := '''';
  else
    Result := '';
  end;
end;

function ModifierToString(aMod: Word): string;
begin
  Result := '';
  if (aMod and MOD_WIN) <> 0 then Result := Result + 'Win+';
  if (aMod and MOD_CONTROL) <> 0 then Result := Result + 'Ctrl+';
  if (aMod and MOD_SHIFT) <> 0 then Result := Result + 'Shift+';
  if (aMod and MOD_ALT) <> 0 then Result := Result + 'Alt+';
end;

// Key state functions

function IsKeyPressed(Key: Integer): Boolean;
var
  State: TKeyboardState;
begin
  GetKeyboardState(State);
  Result := (State[Key] and $80) <> 0;
end;

function IsCtrlPressed: Boolean;
begin
  Result := IsKeyPressed(VK_CONTROL);
end;

function IsShiftPressed: Boolean;
begin
  Result := IsKeyPressed(VK_SHIFT);
end;

function IsAltPressed: Boolean;
begin
  Result := IsKeyPressed(VK_MENU);
end;

function IsWinPressed: Boolean;
begin
  Result := IsKeyPressed(VK_LWIN) or IsKeyPressed(VK_RWIN);
end;

end.
