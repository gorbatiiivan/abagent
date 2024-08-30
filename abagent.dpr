program abagent;


{$R *.dres}

uses
  WinApi.Windows,
  Vcl.Forms,
  SysUtils,
  Unit1 in 'Unit1.pas' {MainForm},
  ShutdownUnit in 'ShutdownUnit.pas' {ShutdownForm},
  Utils in 'Utils.pas',
  MMDevApi in 'MMDevApi.pas',
  SystemUtils in 'SystemUtils.pas',
  SPGetSid in 'SPGetSid.pas',
  HotKeyManager in 'HotKeyManager.pas',
  lnkForm in 'lnkForm.pas' {LNK_Form},
  LNK_Utils in 'LNK_Utils.pas',
  LNK_Properties in 'LNK_Properties.pas' {Properties},
  HotKeyChanger in 'HotKeyChanger.pas' {HotKeyForm},
  Help in 'Help.pas' {HelpForm},
  Processes in 'Processes.pas' {ProcessesForm};

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_RELOCS_STRIPPED} //Удаление из exe таблицы релокаций.
{$SETPEFLAGS IMAGE_FILE_LINE_NUMS_STRIPPED} //Удаление из exe информации о номерах строк
{$SETPEFLAGS IMAGE_FILE_LOCAL_SYMS_STRIPPED} //Удаление local symbols

var
  ExtendedStyle: Longint;
begin
if Win32MajorVersion >= 6 then
 begin
  SetLastError(NO_ERROR);
  CreateSemaphore(nil,0,1,PWideChar('antiboss_Copyright_by_Ivan'));
  if GetLastError = ERROR_ALREADY_EXISTS then Exit;
  SetCurrentDir(ExtractFileDir(ParamStr(0)));
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TLNK_Form, LNK_Form);
  Application.CreateForm(TProperties, Properties);
  Application.CreateForm(TShutdownForm, ShutdownForm);
  Application.CreateForm(THotKeyForm, HotKeyForm);
  Application.CreateForm(THelpForm, HelpForm);
  Application.CreateForm(TProcessesForm, ProcessesForm);
  //Application.ShowMainForm := False;
  if not FileExists(ExtractFilePath(Application.ExeName) + CurrentUserName + '.ini') then
  begin
    Application.ShowMainForm := True;
    MainForm.RegIni(False, True);
  end;
  Application.Run;
 end else Exit;
end.
