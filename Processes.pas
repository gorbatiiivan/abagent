unit Processes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TProcessesForm = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ProcessesForm: TProcessesForm;

implementation

{$R *.dfm}

procedure TProcessesForm.ListBox1DblClick(Sender: TObject);
begin
if ListBox1.ItemIndex <> -1 then
ProcessesForm.ModalResult := mrOk;
end;

end.
