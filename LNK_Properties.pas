unit LNK_Properties;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Winapi.ShellAPI, Vcl.Mask;

type
  TProperties = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    LNKPROP_EDIT2: TLabeledEdit;
    LNKPROP_EDIT1: TLabeledEdit;
    LNKPROP_EDIT3: TLabeledEdit;
    LNKPROP_BTN2: TButton;
    LNKPROP_BTN3: TButton;
    LNKPROP_BTN1: TButton;
    LNKPROP_EDIT4: TLabeledEdit;
    LNKPROP_EDIT5: TLabeledEdit;
    procedure LNKPROP_BTN1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Translate(aLanguageID: String);
  end;

var
  Properties: TProperties;

implementation

uses Unit1, SystemUtils, Translation;

{$R *.dfm}

procedure TProperties.Translate(aLanguageID: String);
begin
 Caption := _(LNK_CPTN_MENUITEM_LST_N15, aLanguageID);
 LNKPROP_EDIT1.EditLabel.Caption := _(LNK_GLOBAL_TEXT_MSG4, aLanguageID);
 LNKPROP_EDIT2.EditLabel.Caption := _(GLOBAL_CPTN_LBL_LBL3, aLanguageID);
 LNKPROP_EDIT3.EditLabel.Caption := _(LNK_HINT_BTN_BTN2, aLanguageID)+' :';
 LNKPROP_EDIT4.EditLabel.Caption := _(GLOBAL_CPTN_LBL_LBL4, aLanguageID);
 LNKPROP_EDIT5.EditLabel.Caption := _(LNKPROP_CPTN_LBLEDIT5, aLanguageID)+' :';
 LNKPROP_BTN1.Hint := _(PROC_HINT_BTN_BTN1, aLanguageID);
 LNKPROP_BTN2.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN2, aLanguageID);
 LNKPROP_BTN3.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN3, aLanguageID);
end;

procedure TProperties.FormCreate(Sender: TObject);
begin
Translate(MainForm.FConfig.ReadString('General','Language',EN_US));
end;

procedure TProperties.LNKPROP_BTN1Click(Sender: TObject);
var
 sFileName: string;
 Index: Word;
 Title, FileName, OKName: PChar;
begin
 Index := 0;
 Title := PChar(_(GLOBAL_TEXT_DIAG1, MainForm.FConfig.ReadString('General','Language',EN_US)));
 FileName := PChar(_(LNK_GLOBAL_TEXT_MSG4, MainForm.FConfig.ReadString('General','Language',EN_US)));
 OKName := PChar(_(PROC_CPTN_BTN_BTN2, MainForm.FConfig.ReadString('General','Language',EN_US)));
 if OpenFileDialog(Title, FileName, OKName, True, sFileName, ExtractFileDir(LNKPROP_EDIT2.Text)) then
  begin
   LNKPROP_EDIT5.Text := WideUpperCase(sFileName);
   Image1.Picture.Icon.Handle := ExtractAssociatedIcon(hInstance,PChar(sFileName),Index);
  end;
end;

end.
