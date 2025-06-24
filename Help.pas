unit Help;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, ShellAPI;

type
  THelpForm = class(TForm)
    HELPFORM_PAGECTRL1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    HELPFORM_LSTVIEW1: TListView;
    TabSheet3: TTabSheet;
    HELPFORM_MEMO1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PaintBox1: TPaintBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TabSheet4: TTabSheet;
    Memo1: TMemo;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Translate(aLanguageID: String);
  end;

var
  HelpForm: THelpForm;
  LaunchSnake: Boolean= False;

implementation

uses Translation, Unit1, SystemUtils, ABSnake;

{$R *.dfm}

procedure THelpForm.Translate(aLanguageID: String);
var
 TempInteger: Integer;
begin
  Caption := _(GLOBAL_CPTN_MENUITEM_Main_N1, aLanguageID);
  HELPFORM_PAGECTRL1.Pages[0].Caption := _(HELP_CPTN_PAGECTRL_TAB1, aLanguageID);
  HELPFORM_PAGECTRL1.Pages[1].Caption := _(HELP_CPTN_PAGECTRL_TAB2, aLanguageID);
  HELPFORM_PAGECTRL1.Pages[2].Caption := _(HELP_CPTN_PAGECTRL_TAB3, aLanguageID);
  HELPFORM_PAGECTRL1.Pages[3].Caption := _(HELP_CPTN_PAGECTRL_TAB4, aLanguageID);
  Label2.Caption := _(HELPFORM_CPTN_LBL_2, aLanguageID) + ReleaseDate;
  Label3.Caption := _(HELPFORM_CPTN_LBL_3, aLanguageID);
  Label4.Caption := _(HELPFORM_CPTN_LBL_4, aLanguageID);
  Label5.Caption := _(HELPFORM_CPTN_LBL_5, aLanguageID);
  Label6.Caption := _(HELPFORM_CPTN_LBL_6, aLanguageID);
  StrToList(_(HELPFORM_TEXT_MEMO1, aLanguageID),';',HELPFORM_MEMO1.Lines);
  HELPFORM_LSTVIEW1.Column[0].Caption := _(HELPFORM_TEXT_LSTVIEW_COL1, aLanguageID);
  HELPFORM_LSTVIEW1.Column[1].Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox2, aLanguageID);
  HELPFORM_LSTVIEW1.Groups.Items[0].Header := _(HELPFORM_TEXT_LSTVIEW_HEAD1, aLanguageID);
  HELPFORM_LSTVIEW1.Groups.Items[1].Header := _(GLOBAL_HINT_IMG_LogImg, aLanguageID);
  HELPFORM_LSTVIEW1.Groups.Items[2].Header := _(GLOBAL_HINT_IMG_TimerImg, aLanguageID);
  HELPFORM_LSTVIEW1.Groups.Items[3].Header := _(GLOBAL_HINT_IMG_FavImg, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[0].Caption := _(HELPFORM_TEXT_LSTVIEW_ITEM1, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[1].Caption := _(HELPFORM_TEXT_LSTVIEW_ITEM2, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[2].Caption := _(GLOBAL_CPTN_GRPBOX_GrpBox4, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[3].Caption := _(HELPFORM_TEXT_LSTVIEW_ITEM1, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[4].Caption := _(HELPFORM_TEXT_LSTVIEW_ITEM1, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[5].Caption := _(HELPFORM_TEXT_LSTVIEW_ITEM1, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[6].Caption := _(HELPFORM_TEXT_LSTVIEW_ITEM6, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[7].Caption := _(LNK_CPTN_MENUITEM_LST_N1, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[8].Caption := _(LNK_CPTN_MENUITEM_LST_N2, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[9].Caption := _(LNK_CPTN_MENUITEM_LST_N3, aLanguageID)+
                     ' '+LowerCase(_(LNK_CPTN_MENUITEM_LST_N3_N1, aLanguageID));
  HELPFORM_LSTVIEW1.Items.Item[10].Caption := _(LNK_CPTN_MENUITEM_LST_N3, aLanguageID)+
                     ' '+LowerCase(_(LNK_CPTN_MENUITEM_LST_N3_N2, aLanguageID));
  HELPFORM_LSTVIEW1.Items.Item[11].Caption := _(LNK_CPTN_MENUITEM_LST_N4, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[12].Caption := _(LNK_CPTN_MENUITEM_LST_N7, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[13].Caption := _(LNK_CPTN_MENUITEM_LST_N16_1, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[14].Caption := _(LNK_CPTN_MENUITEM_LST_N8, aLanguageID);
  HELPFORM_LSTVIEW1.Items.Item[15].Caption := _(LNK_CPTN_MENUITEM_LST_N15, aLanguageID);
end;

procedure GetAboutInfo;
var
 Icon: TIcon;
begin
 Icon := TIcon.Create;
  try
   GetIconFromFile(ExtractFileName(ParamStr(0)), Icon, 4);
   DrawIconToPaintBox(HelpForm.PaintBox1, Icon, 2, 2);
  finally
   Icon.Free;
  end;
end;

procedure THelpForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if LaunchSnake then
 begin
  DestroySnake;
  LaunchSnake := False;
  Label4.Visible := False;
 end;
end;

procedure THelpForm.FormCreate(Sender: TObject);
begin
Translate(MainForm.FConfig.ReadString('General','Language',EN_US));
end;

procedure THelpForm.FormResize(Sender: TObject);
begin
HELPFORM_LSTVIEW1.Columns.Items[0].Width := Width div 2;
HELPFORM_LSTVIEW1.Columns.Items[1].Width := Width div 2 - 70;
end;

procedure THelpForm.PaintBox1Click(Sender: TObject);
begin
CreateSnake(Self, PaintBox1);
LaunchSnake := True;
if LaunchSnake = True then
TThread.CreateAnonymousThread(procedure
  begin
    Label4.Visible := True;

    Sleep(10000);

    TThread.Synchronize(nil, procedure
    begin
      Label4.Visible := False;
    end);
  end).Start;
end;

procedure THelpForm.PaintBox1Paint(Sender: TObject);
var
 confstr: String;
begin
confstr := MainForm.FConfig.ReadString('General','Language',EN_US);
if LaunchSnake = True then
  PaintSnake(_(HELP_GLOBAL_TEXT_SNAKE1, confstr),_(HELP_GLOBAL_TEXT_SNAKE2, confstr))
   else GetAboutInfo;
end;

procedure THelpForm.Label5Click(Sender: TObject);
begin
 ShellExecute(0, 'open', PChar(Label5.Hint), nil, nil, SW_SHOWNORMAL);
end;

end.
