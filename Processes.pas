unit Processes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TProcessesForm = class(TForm)
    Panel1: TPanel;
    Proc_BTN2: TButton;
    Proc_BTN3: TButton;
    Proc_BTN1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ProcessListView: TListView;
    ListBox1: TListBox;
    procedure ListBox1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Proc_BTN1Click(Sender: TObject);
    procedure ProcessListViewDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RefreshButtonAction: Integer;
    procedure Translate(aLanguageID: String);
  end;

var
  ProcessesForm: TProcessesForm;

implementation

uses Unit1, Translation, SystemUtils;

{$R *.dfm}

procedure TProcessesForm.Translate(aLanguageID: String);
begin
 Caption := _(PROC_CPTN, aLanguageID);
 Proc_BTN1.Caption := _(PROC_CPTN_BTN_BTN1, aLanguageID);
 Proc_BTN3.Caption := _(HOTKEYCHANGER_CPTN_BTN_BTN3, aLanguageID);
 ProcessListView.Columns.Items[0].Caption := _(PROC_CPTN_COL1_LSTVIEW1, aLanguageID);
end;

procedure TProcessesForm.FormCreate(Sender: TObject);
begin
Translate(MainForm.FConfig.ReadString('General','Language',EN_US));
PageControl1.Pages[0].TabVisible := False;
PageControl1.Pages[1].TabVisible := False;
end;

procedure TProcessesForm.Proc_BTN1Click(Sender: TObject);
var
 I: Integer;
 AppName: String;
begin
case RefreshButtonAction of
0:
 begin
  ProcessToList(ListBox1.Items);
  RemoveDuplicateItems(ListBox1);
  ListBox1.Sorted := True;
  ListBox1.Items.Delete(FindString(ListBox1.Items,ExtractFileName(ParamStr(0))));
 end;
1:
 begin
  ProcessListView.Clear;
  with MainForm do
  for I := 0 to PTab.Tabs.Count-1 do
  begin
  AppName := Decode(FConfig.ReadString(IntToStr(I),'Name',''),'N90fL6FF9SXx+S');
  if IsProcessRunning(AppName) then
  AddSubItemsToItemByName(ProcessListView,AppName,IntToStr(GetProcessID_(AppName)))
  else DeleteItemByName(ProcessListView,AppName);
  end;
 end;
end;
end;

procedure TProcessesForm.ListBox1DblClick(Sender: TObject);
begin
if ListBox1.ItemIndex <> -1 then
ProcessesForm.ModalResult := mrOk;
end;

procedure TProcessesForm.ProcessListViewDblClick(Sender: TObject);
begin
if ProcessListView.ItemIndex <> -1 then
ProcessesForm.ModalResult := mrOk;
end;

end.
