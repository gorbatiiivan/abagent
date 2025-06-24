unit Log;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus,
  System.Generics.Collections;

type
  TLogForm = class(TForm)
    LogListView: TListView;
    PopupMenu: TPopupMenu;
    LOG_LST_MENU_N1: TMenuItem;
    N1: TMenuItem;
    LOG_LST_MENU_N2: TMenuItem;
    N2: TMenuItem;
    LOG_LST_MENU_N3: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LOG_LST_MENU_N1Click(Sender: TObject);
    procedure LOG_LST_MENU_N2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupMenuPopup(Sender: TObject);
    procedure LOG_LST_MENU_N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Translate(aLanguageID: String);
  end;

var
  LogForm: TLogForm;
  AClose: Boolean = False;
  LangID: String;

implementation

uses Unit1, HotKeyChanger, SystemUtils, HotKeyManager, Translation;

{$R *.dfm}

procedure LoadSysEvents(ListView: TListView);
var
  EventDescriptions: TDictionary<DWORD, string>;
begin
  EventDescriptions := TDictionary<DWORD, string>.Create;
  try
    EventDescriptions.Add(6005, _(LOGFORM_GLOBAL_TEXT_MSG4, LangID));
    EventDescriptions.Add(6006, _(LOGFORM_GLOBAL_TEXT_MSG5, LangID));
    EventDescriptions.Add(6008, _(LOGFORM_GLOBAL_TEXT_MSG6, LangID));
    EventDescriptions.Add(41, _(LOGFORM_GLOBAL_TEXT_MSG7, LangID));
    EventDescriptions.Add(109, _(LOGFORM_GLOBAL_TEXT_MSG8, LangID));
    EventDescriptions.Add(107, _(LOGFORM_GLOBAL_TEXT_MSG9, LangID));
    EventDescriptions.Add(27, _(LOGFORM_GLOBAL_TEXT_MSG10, LangID));

    LoadSystemEventLog(ListView, EventDescriptions);
  finally
    EventDescriptions.Free;
  end;
end;

procedure TLogForm.Translate(aLanguageID: String);
begin
  Caption := _(GLOBAL_HINT_IMG_LogImg, aLanguageID);
  LOG_LST_MENU_N1.Caption := _(LNK_CPTN_MENUITEM_GEN_N1, aLanguageID);
  LOG_LST_MENU_N2.Caption := _(GLOBAL_CPTN_MENUITEM_Main_N2, aLanguageID);
  LOG_LST_MENU_N3.Caption := _(LOGFORM_CPTN_MENUITEM_N3, aLanguageID);
end;

procedure TLogForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if AClose = false then
 begin
  Action := caNone;
 end else Action := caHide;
end;

procedure TLogForm.FormCreate(Sender: TObject);
begin
LangID := MainForm.FConfig.ReadString('General','Language',EN_US);
Translate(LangID);
end;

procedure TLogForm.FormResize(Sender: TObject);
begin
LogListView.Columns[0].Width := LogListView.Width div 3 - 10;
LogListView.Columns[1].Width := LogListView.Width div 3 - 10;
LogListView.Columns[2].Width := LogListView.Width div 3 - 10;
end;

procedure TLogForm.FormShow(Sender: TObject);
begin
LangID := MainForm.FConfig.ReadString('General','Language',EN_US);
Translate(LangID);

ActiveControl := LogListView;
LogListView.Clear;
SetForegroundWindow(Handle);

TThread.CreateAnonymousThread(procedure
  begin
    Caption := _(LOGFORM_GLOBAL_TEXT_MSG2, LangID);
    AClose := False;

    Sleep(1000);

    TThread.Synchronize(nil, procedure
    begin
     if MainForm.FConfig.ReadBool('General', 'EnabledLogFile', False) = False then
     begin
      LoadSysEvents(LogListView);
      Caption := _(LOGFORM_GLOBAL_TEXT_MSG3, LangID);
     end else
     begin
      LoadFileEventLog(LogListView);
      LogListView.CustomSort(@SortListView, 0 or ($100 * Ord(not False)));
      if FileExists(ExtractFilePath(Application.ExeName) + 'Events.log') then
       Caption := _(LOGFORM_GLOBAL_TEXT_MSG3, LangID)
      else
       Caption := _(LOGFORM_GLOBAL_TEXT_MSG1, LangID);
     end;
     AClose := True;
    end);
  end).Start;
end;

procedure TLogForm.LOG_LST_MENU_N1Click(Sender: TObject);
begin
Position := poDesktopCenter;
Show;
end;

procedure TLogForm.LOG_LST_MENU_N2Click(Sender: TObject);
begin
with HotKeyForm do
 begin
  Position := poDesktopCenter;
  HOTKEYCHANGER_BTN1Click(Sender);
  Edit1.Text := MainForm.FConfig.ReadString('General','LogForm_Log_Key','');
  if (Showmodal <> mrCancel) then
   begin
    MainForm.HotKeyManager.RemoveHotKey(TextToHotKey(MainForm.FConfig.ReadString('General','LogForm_Log_Key',''),True));
    MainForm.FConfig.WriteString('General','LogForm_Log_Key',Edit1.Text);
    MainForm.FConfig.UpdateFile;
    if Edit1.Text <> '' then
    MainForm.HotKeyManager.AddHotKey(TextToHotKey(Edit1.Text,True));
   end;
 end;
end;

procedure TLogForm.PopupMenuPopup(Sender: TObject);
begin
LOG_LST_MENU_N3.Checked := MainForm.FConfig.ReadBool('General', 'EnabledLogFile', False);
end;

procedure TLogForm.LOG_LST_MENU_N3Click(Sender: TObject);
begin
with Sender as TMenuItem do
 with MainForm do
  begin
   Checked := not Checked;
   FConfig.WriteBool('General', 'EnabledLogFile', Checked);
   FConfig.UpdateFile;
  end;
end;

end.
