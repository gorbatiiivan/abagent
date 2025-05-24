program abagent;


{$R *.dres}

uses
  WinApi.Windows,
  Vcl.Forms,
  SysUtils,
  Unit1 in 'Unit1.pas' {MainForm},
  ShutdownUnit in 'ShutdownUnit.pas' {ShutdownForm},
  lnkForm in 'lnkForm.pas' {LNK_Form},
  LNK_Properties in 'LNK_Properties.pas' {Properties},
  HotKeyChanger in 'HotKeyChanger.pas' {HotKeyForm},
  Processes in 'Processes.pas' {ProcessesForm},
  Help in 'Help.pas' {HelpForm},
  MMDevApi in 'MMDevApi.pas',
  MultiMMDeviceAPI in 'MultiMMDeviceAPI.pas',
  SystemUtils in 'SystemUtils.pas',
  HotKeyManager in 'HotKeyManager.pas',
  Translation in 'Translation.pas',
  ABSnake in 'ABSnake.pas',
  WindowManagerUnit in 'WindowManagerUnit.pas',
  AudioProcessController in 'AudioProcessController.pas';

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_RELOCS_STRIPPED} //Удаление из exe таблицы релокаций.
{$SETPEFLAGS IMAGE_FILE_LINE_NUMS_STRIPPED} //Удаление из exe информации о номерах строк
{$SETPEFLAGS IMAGE_FILE_LOCAL_SYMS_STRIPPED} //Удаление local symbols
{$SETPEFLAGS IMAGE_FILE_LINE_NUMS_STRIPPED} // Удаление из exe информации о номерах строк

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
  Application.Run;
 end else Exit;
end.
