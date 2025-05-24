unit MultiMMDeviceAPI;

{$MINENUMSIZE 4}

interface

uses
  Windows, ActiveX, ComObj;

const
  CLSID_MMDeviceEnumerator: TGUID = '{BCDE0395-E52F-467C-8E3D-C4579291692E}';
  IID_IMMDeviceEnumerator: TGUID = '{A95664D2-9614-4F35-A746-DE8DB63617E6}';
  IID_IMMDevice: TGUID = '{D666063F-1587-4E43-81F1-B948E807363F}';
  IID_IMMDeviceCollection: TGUID = '{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}';
  IID_IAudioSessionManager2: TGUID = '{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}';
  IID_IAudioSessionEnumerator: TGUID = '{E2F5BB11-0570-40CA-ACDD-3AA01277DEE8}';
  IID_IAudioSessionControl: TGUID = '{F4B1A599-7266-4319-A8CA-E70ACB11E8CD}';
  IID_IAudioSessionControl2: TGUID = '{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}';
  IID_ISimpleAudioVolume: TGUID = '{87CE5498-68D6-44E5-9215-6DA47EF883D8}';
  IID_IAudioSessionNotification: TGUID = '{641DD20B-4D41-49CC-ABA3-174B9477BB08}';

type
  EDataFlow = TOleEnum;
  ERole = TOleEnum;

const
  eRender = $00000000;
  eCapture = $00000001;
  eAll = $00000002;
  EDataFlow_enum_count = $00000003;

  eConsole = $00000000;
  eMultimedia = $00000001;
  eCommunications = $00000002;
  ERole_enum_count = $00000003;

type
  IAudioSessionEvents = interface;
  IAudioSessionNotification = interface;
  IAudioSessionControl = interface;
  IAudioSessionControl2 = interface;
  ISimpleAudioVolume = interface;
  IAudioSessionEnumerator = interface;
  IAudioSessionManager = interface;
  IAudioSessionManager2 = interface;
  IMMNotificationClient = interface;
  IMMEndpoint = interface;
  IMMDevice = interface;
  IMMDeviceCollection = interface;
  IMMDeviceEnumerator = interface;

  IPropertyStore = interface(IUnknown)
    ['{886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99}']
    function GetCount(out cProps: DWORD): HResult; stdcall;
    function GetAt(iProp: DWORD; out pkey: PROPERTYKEY): HResult; stdcall;
    function GetValue(const key: PROPERTYKEY; out pv: PROPVARIANT): HResult; stdcall;
    function SetValue(const key: PROPERTYKEY; const propvar: PROPVARIANT): HResult; stdcall;
    function Commit: HResult; stdcall;
  end;

  IAudioSessionEvents = interface(IUnknown)
    ['{24918ACC-64B3-37C1-8CA9-74A66E9957A8}']
    function OnDisplayNameChanged(NewDisplayName: LPCWSTR; EventContext: PGUID): HResult; stdcall;
    function OnIconPathChanged(NewIconPath: LPCWSTR; EventContext: PGUID): HResult; stdcall;
    function OnSimpleVolumeChanged(NewVolume: Single; NewMute: BOOL; EventContext: PGUID): HResult; stdcall;
    function OnChannelVolumeChanged(ChannelCount: UINT; NewChannelVolumeArray: PSingle;
      ChangedChannel: UINT; EventContext: PGUID): HResult; stdcall;
    function OnGroupingParamChanged(NewGroupingParam: PGUID; EventContext: PGUID): HResult; stdcall;
    function OnStateChanged(NewState: UINT): HResult; stdcall;
    function OnSessionDisconnected(DisconnectReason: UINT): HResult; stdcall;
  end;

  IAudioSessionNotification = interface(IUnknown)
    ['{641DD20B-4D41-49CC-ABA3-174B9477BB08}']
    function OnSessionCreated(NewSession: IAudioSessionControl): HResult; stdcall;
  end;

  IAudioSessionControl = interface(IUnknown)
    ['{F4B1A599-7266-4319-A8CA-E70ACB11E8CD}']
    function GetState(out pRetVal: UINT): HResult; stdcall;
    function GetDisplayName(out pRetVal: LPWSTR): HResult; stdcall;
    function SetDisplayName(Value: LPCWSTR; EventContext: PGUID): HResult; stdcall;
    function GetIconPath(out pRetVal: LPWSTR): HResult; stdcall;
    function SetIconPath(Value: LPCWSTR; EventContext: PGUID): HResult; stdcall;
    function GetGroupingParam(pRetVal: PGUID): HResult; stdcall;
    function SetGroupingParam(OverrideValue: PGUID; EventContext: PGUID): HResult; stdcall;
    function RegisterAudioSessionNotification(const NewNotifications: IAudioSessionEvents): HResult; stdcall;
    function UnregisterAudioSessionNotification(const NewNotifications: IAudioSessionEvents): HResult; stdcall;
  end;

  IAudioSessionControl2 = interface(IAudioSessionControl)
    ['{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}']
    function GetSessionIdentifier(out pRetVal: LPWSTR): HResult; stdcall;
    function GetSessionInstanceIdentifier(out pRetVal: LPWSTR): HResult; stdcall;
    function GetProcessId(out pRetVal: DWORD): HResult; stdcall;
    function IsSystemSoundsSession: HResult; stdcall;
    function SetDuckingPreference(optOut: BOOL): HResult; stdcall;
  end;

  ISimpleAudioVolume = interface(IUnknown)
    ['{87CE5498-68D6-44E5-9215-6DA47EF883D8}']
    function SetMasterVolume(fLevel: Single; EventContext: PGUID): HResult; stdcall;
    function GetMasterVolume(out pfLevel: Single): HResult; stdcall;
    function SetMute(bMute: BOOL; EventContext: PGUID): HResult; stdcall;
    function GetMute(out pbMute: BOOL): HResult; stdcall;
  end;

  IAudioSessionEnumerator = interface(IUnknown)
    ['{E2F5BB11-0570-40CA-ACDD-3AA01277DEE8}']
    function GetCount(out SessionCount: Integer): HResult; stdcall;
    function GetSession(SessionIndex: Integer; out Session: IAudioSessionControl): HResult; stdcall;
  end;

  IAudioSessionManager = interface(IUnknown)
    ['{BFA971F1-4D5E-40BB-935E-967039BFBEE4}']
    function GetAudioSessionControl(AudioSessionGuid: PGUID; StreamFlags: UINT;
      out SessionControl: IAudioSessionControl): HResult; stdcall;
    function GetSimpleAudioVolume(AudioSessionGuid: PGUID; StreamFlags: UINT;
      out AudioVolume: ISimpleAudioVolume): HResult; stdcall;
  end;

  IAudioSessionManager2 = interface(IAudioSessionManager)
    ['{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}']
    function GetSessionEnumerator(out SessionEnum: IAudioSessionEnumerator): HResult; stdcall;
    function RegisterSessionNotification(const SessionNotification: IAudioSessionNotification): HResult; stdcall;
    function UnregisterSessionNotification(const SessionNotification: IAudioSessionNotification): HResult; stdcall;
    function RegisterDuckNotification(sessionId: LPCWSTR; const duckNotification: IAudioSessionNotification): HResult; stdcall;
    function UnregisterDuckNotification(const duckNotification: IAudioSessionNotification): HResult; stdcall;
  end;

  IMMNotificationClient = interface(IUnknown)
    ['{7991EEC9-7E89-4D85-8390-6C703CEC60C0}']
    function OnDeviceStateChanged(pwstrDeviceId: LPCWSTR; dwNewState: DWORD): HResult; stdcall;
    function OnDeviceAdded(pwstrDeviceId: LPCWSTR): HResult; stdcall;
    function OnDeviceRemoved(pwstrDeviceId: LPCWSTR): HResult; stdcall;
    function OnDefaultDeviceChanged(flow: EDataFlow; role: ERole; pwstrDefaultDeviceId: LPCWSTR): HResult; stdcall;
    function OnPropertyValueChanged(pwstrDeviceId: LPCWSTR; const key: PROPERTYKEY): HResult; stdcall;
  end;

  IMMEndpoint = interface(IUnknown)
    ['{1BE09788-6894-4089-8586-9A2A6C265AC5}']
    function GetDataFlow(out pDataFlow: EDataFlow): HResult; stdcall;
  end;

  IMMDevice = interface(IUnknown)
    ['{D666063F-1587-4E43-81F1-B948E807363F}']
    function Activate(const iid: TGUID; dwClsCtx: DWORD; pActivationParams: PPropVariant;
      out ppInterface): HResult; stdcall;
    function OpenPropertyStore(stgmAccess: DWORD; out ppProperties: IPropertyStore): HResult; stdcall;
    function GetId(out ppstrId: LPWSTR): HResult; stdcall;
    function GetState(out pdwState: DWORD): HResult; stdcall;
  end;

  IMMDeviceCollection = interface(IUnknown)
    ['{0BD7A1BE-7A1A-44DB-8397-CC5392387B5E}']
    function GetCount(out pcDevices: UINT): HResult; stdcall;
    function Item(nDevice: UINT; out ppDevice: IMMDevice): HResult; stdcall;
  end;

  IMMDeviceEnumerator = interface(IUnknown)
    ['{A95664D2-9614-4F35-A746-DE8DB63617E6}']
    function EnumAudioEndpoints(dataFlow: EDataFlow; dwStateMask: DWORD;
      out ppDevices: IMMDeviceCollection): HResult; stdcall;
    function GetDefaultAudioEndpoint(dataFlow: EDataFlow; role: ERole;
      out ppEndpoint: IMMDevice): HResult; stdcall;
    function GetDevice(pwstrId: LPCWSTR; out ppDevice: IMMDevice): HResult; stdcall;
    function RegisterEndpointNotificationCallback(const pClient: IMMNotificationClient): HResult; stdcall;
    function UnregisterEndpointNotificationCallback(const pClient: IMMNotificationClient): HResult; stdcall;
  end;

implementation

end.
