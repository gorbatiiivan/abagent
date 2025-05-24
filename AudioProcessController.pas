unit AudioProcessController;

interface

uses
  Windows, SysUtils, Classes, ActiveX, PsAPI, MultiMMDeviceAPI;

const
  CLASS_IMMDeviceEnumerator : TGUID = '{BCDE0395-E52F-467C-8E3D-C4579291692E}';

type
  TAudioSession = class
  private
    FSessionControl: IAudioSessionControl2;
    FSimpleAudioVolume: ISimpleAudioVolume;
  public
    constructor Create(const ASessionControl: IAudioSessionControl2;
      const ASimpleAudioVolume: ISimpleAudioVolume);
    property SessionControl: IAudioSessionControl2 read FSessionControl;
    property SimpleAudioVolume: ISimpleAudioVolume read FSimpleAudioVolume;
  end;

  TAudioProcessController = class
  private
    FMMDeviceEnumerator: IMMDeviceEnumerator;
    FMMDevice: IMMDevice;
    FAudioSessionManager: IAudioSessionManager2;
    FAudioSessionEnumerator: IAudioSessionEnumerator;
    FSessionList: TList;
    function GetSessionCount: Integer;
    function GetSession(Index: Integer): TAudioSession;
    procedure EnumerateSessions;
  public
    constructor Create;
    destructor Destroy; override;
    procedure MuteProcess(const ProcessName: string; Mute: Boolean);
    procedure ToggleMuteProcess(const ProcessName: string);
    function IsProcessMuted(const ProcessName: string): Boolean;
    property SessionCount: Integer read GetSessionCount;
    property Sessions[Index: Integer]: TAudioSession read GetSession;
  end;

implementation

{ TAudioSession }

constructor TAudioSession.Create(const ASessionControl: IAudioSessionControl2;
  const ASimpleAudioVolume: ISimpleAudioVolume);
begin
  inherited Create;
  FSessionControl := ASessionControl;
  FSimpleAudioVolume := ASimpleAudioVolume;
end;

{ TAudioProcessController }

constructor TAudioProcessController.Create;
begin
  inherited;
  FSessionList := TList.Create;
  CoInitialize(nil);
  CoCreateInstance(CLASS_IMMDeviceEnumerator, nil, CLSCTX_ALL,
    IID_IMMDeviceEnumerator, FMMDeviceEnumerator);
  FMMDeviceEnumerator.GetDefaultAudioEndpoint(eRender, eConsole, FMMDevice);
  FMMDevice.Activate(IID_IAudioSessionManager2, CLSCTX_ALL, nil, FAudioSessionManager);
  EnumerateSessions;
end;

destructor TAudioProcessController.Destroy;
var
  I: Integer;
begin
  for I := 0 to FSessionList.Count - 1 do
    TAudioSession(FSessionList[I]).Free;
  FSessionList.Free;
  CoUninitialize;
  inherited;
end;

procedure TAudioProcessController.EnumerateSessions;
var
  SessionCount, I: Integer;
  SessionControl: IAudioSessionControl;
  SessionControl2: IAudioSessionControl2;
  SimpleAudioVolume: ISimpleAudioVolume;
begin
  FSessionList.Clear;
  FAudioSessionManager.GetSessionEnumerator(FAudioSessionEnumerator);
  FAudioSessionEnumerator.GetCount(SessionCount);

  for I := 0 to SessionCount - 1 do
  begin
    FAudioSessionEnumerator.GetSession(I, SessionControl);
    if Supports(SessionControl, IID_IAudioSessionControl2, SessionControl2) then
    begin
      if SessionControl.QueryInterface(IID_ISimpleAudioVolume, SimpleAudioVolume) = S_OK then
      begin
        FSessionList.Add(TAudioSession.Create(SessionControl2, SimpleAudioVolume));
      end;
    end;
  end;
end;

function TAudioProcessController.GetSession(Index: Integer): TAudioSession;
begin
  Result := TAudioSession(FSessionList[Index]);
end;

function TAudioProcessController.GetSessionCount: Integer;
begin
  Result := FSessionList.Count;
end;

procedure TAudioProcessController.MuteProcess(const ProcessName: string; Mute: Boolean);
var
  I: Integer;
  Session: TAudioSession;
  ProcessID: DWORD;
  ProcessHandle: THandle;
  ImagePath: array[0..MAX_PATH - 1] of Char;
  FileName: string;
begin
  EnumerateSessions; // Refresh sessions

  for I := 0 to SessionCount - 1 do
  begin
    Session := Sessions[I];
    if Session.SessionControl.GetProcessId(ProcessID) = S_OK then
    begin
      ProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ProcessID);
      if ProcessHandle <> 0 then
      try
        if GetModuleFileNameEx(ProcessHandle, 0, ImagePath, MAX_PATH) > 0 then
        begin
          FileName := ExtractFileName(ImagePath);
          if SameText(FileName, ProcessName) then
          begin
            Session.SimpleAudioVolume.SetMute(Mute, nil);
          end;
        end;
      finally
        CloseHandle(ProcessHandle);
      end;
    end;
  end;
end;

procedure TAudioProcessController.ToggleMuteProcess(const ProcessName: string);
var
  I: Integer;
  Session: TAudioSession;
  ProcessID: DWORD;
  ProcessHandle: THandle;
  ImagePath: array[0..MAX_PATH - 1] of Char;
  FileName: string;
  Mute: LongBool;
begin
  EnumerateSessions; // Refresh sessions

  for I := 0 to SessionCount - 1 do
  begin
    Session := Sessions[I];
    if Session.SessionControl.GetProcessId(ProcessID) = S_OK then
    begin
      ProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ProcessID);
      if ProcessHandle <> 0 then
      try
        if GetModuleFileNameEx(ProcessHandle, 0, ImagePath, MAX_PATH) > 0 then
        begin
          FileName := ExtractFileName(ImagePath);
          if SameText(FileName, ProcessName) then
          begin
            Session.SimpleAudioVolume.GetMute(Mute);
            Session.SimpleAudioVolume.SetMute(not Mute, nil);
          end;
        end;
      finally
        CloseHandle(ProcessHandle);
      end;
    end;
  end;
end;

function TAudioProcessController.IsProcessMuted(const ProcessName: string): Boolean;
var
  I: Integer;
  Session: TAudioSession;
  ProcessID: DWORD;
  ProcessHandle: THandle;
  ImagePath: array[0..MAX_PATH - 1] of Char;
  FileName: string;
  Mute: LongBool;
begin
  Result := False;
  EnumerateSessions; // Refresh sessions

  for I := 0 to SessionCount - 1 do
  begin
    Session := Sessions[I];
    if Session.SessionControl.GetProcessId(ProcessID) = S_OK then
    begin
      ProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ProcessID);
      if ProcessHandle <> 0 then
      try
        if GetModuleFileNameEx(ProcessHandle, 0, ImagePath, MAX_PATH) > 0 then
        begin
          FileName := ExtractFileName(ImagePath);
          if SameText(FileName, ProcessName) then
          begin
            Session.SimpleAudioVolume.GetMute(Mute);
            Result := Mute;
            Exit;
          end;
        end;
      finally
        CloseHandle(ProcessHandle);
      end;
    end;
  end;
end;

end.
