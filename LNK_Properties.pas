unit LNK_Properties;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ShellAPI, Vcl.Mask;

type
  TProperties = class(TForm)
    GroupBox1: TGroupBox;
    Image1: TImage;
    Edit1: TLabeledEdit;
    Edit2: TLabeledEdit;
    Edit3: TLabeledEdit;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit5: TLabeledEdit;
    Edit4: TLabeledEdit;
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Properties: TProperties;

implementation

uses LNK_Utils, Utils;

{$R *.dfm}

procedure TProperties.Button4Click(Sender: TObject);
var
  s,d: string;
  Index: Word;
begin
  s := ''; d := '';
  Index := 0;
  if SelectExe('Select file',s,d) then
   begin
    Edit4.Text := WideUpperCase(s);
    Image1.Picture.Icon.Handle := ExtractAssociatedIcon(hInstance,PChar(s),Index);
   end;
end;

end.
