unit Processes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TProcessesForm = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    Proc_BTN2: TButton;
    Proc_BTN3: TButton;
    Proc_BTN1: TButton;
    procedure ListBox1DblClick(Sender: TObject);
    procedure Proc_BTN1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Translate(aLanguageID: String);
  end;

var
  ProcessesForm: TProcessesForm;

implementation

uses Utils, Unit1, Translation;

{$R *.dfm}

procedure TProcessesForm.Translate(aLanguageID: String);
begin
 Caption := _(PROC_CPTN, aLanguageID);
 Proc_BTN1.Caption := _(PROC_CPTN_BTN_BTN1, aLanguageID);
 Proc_BTN2.Caption := _(PROC_CPTN_BTN_BTN2, aLanguageID);
 Proc_BTN3.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN3, aLanguageID);
end;

procedure TProcessesForm.FormCreate(Sender: TObject);
begin
Translate(MainForm.FConfig.ReadString('General','Language',EN_US));
end;

procedure TProcessesForm.Proc_BTN1Click(Sender: TObject);
begin
ProcessToList(ListBox1);
ListBox1.Sorted := True;
ListBox1.Items.Delete(FindString(ListBox1.Items,ExtractFileName(ParamStr(0))));
end;

procedure TProcessesForm.ListBox1DblClick(Sender: TObject);
begin
if ListBox1.ItemIndex <> -1 then
ProcessesForm.ModalResult := mrOk;
end;

end.
