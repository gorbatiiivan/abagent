object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biMaximize, biHelp]
  BorderStyle = bsDialog
  Caption = 'AB Agent'
  ClientHeight = 574
  ClientWidth = 612
  Color = clBtnFace
  CustomTitleBar.CaptionAlignment = taCenter
  CustomTitleBar.Control = TitleBarPanel1
  CustomTitleBar.Enabled = True
  CustomTitleBar.Height = 31
  CustomTitleBar.ShowIcon = False
  CustomTitleBar.BackgroundColor = 14120960
  CustomTitleBar.ForegroundColor = clWhite
  CustomTitleBar.InactiveBackgroundColor = clWhite
  CustomTitleBar.InactiveForegroundColor = 10066329
  CustomTitleBar.ButtonForegroundColor = clWhite
  CustomTitleBar.ButtonBackgroundColor = 14120960
  CustomTitleBar.ButtonHoverForegroundColor = clWhite
  CustomTitleBar.ButtonHoverBackgroundColor = 11362304
  CustomTitleBar.ButtonPressedForegroundColor = clWhite
  CustomTitleBar.ButtonPressedBackgroundColor = 7159040
  CustomTitleBar.ButtonInactiveForegroundColor = 10066329
  CustomTitleBar.ButtonInactiveBackgroundColor = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  GlassFrame.Enabled = True
  GlassFrame.Top = 31
  Position = poDesktopCenter
  ShowHint = True
  StyleElements = [seFont, seClient]
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 101
    Width = 73
    Height = 21
    AutoSize = False
    Caption = 'Process list:'
    Layout = tlCenter
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 37
    Width = 387
    Height = 17
    Caption = 'Start when I log on (with Admin privileges)'
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object Button2: TButton
    Left = 511
    Top = 538
    Width = 93
    Height = 25
    Caption = 'Save and Exit'
    TabOrder = 2
    OnClick = Button2Click
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 392
    Width = 437
    Height = 73
    Caption = 'Task Managers'
    TabOrder = 1
    object CheckBox3: TCheckBox
      Left = 15
      Top = 17
      Width = 404
      Height = 17
      Caption = 
        'Terminate all running processes when starting application from t' +
        'he list:'
      TabOrder = 0
      OnClick = CheckBox3Click
    end
    object Edit3: TEdit
      Left = 15
      Top = 40
      Width = 370
      Height = 21
      TabOrder = 1
    end
    object Button5: TButton
      Left = 391
      Top = 38
      Width = 28
      Height = 25
      Hint = 'Select from all running apps'
      Caption = '>>'
      TabOrder = 2
      OnClick = Button5Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 401
    Top = 37
    Width = 203
    Height = 52
    Caption = 'Hide process using the mouse'
    TabOrder = 3
    object MousePosBox: TComboBox
      Left = 16
      Top = 21
      Width = 145
      Height = 21
      Style = csDropDownList
      ItemIndex = 0
      TabOrder = 0
      Text = 'none'
      OnChange = MousePosBoxChange
      Items.Strings = (
        'none'
        'left'
        'right'
        'top'
        'bottom')
    end
    object Button6: TButton
      Left = 168
      Top = 21
      Width = 21
      Height = 21
      Hint = 'Help'
      Caption = '?'
      TabOrder = 1
      OnClick = Button6Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 8
    Top = 471
    Width = 437
    Height = 92
    Caption = 'Clear data (need Admin Privileges)'
    TabOrder = 4
    object CheckBox7: TCheckBox
      Left = 16
      Top = 32
      Width = 217
      Height = 17
      Hint = 'It only works if the checkbox "Task Managers" is checked'
      Caption = 'When starting Task Managers'
      TabOrder = 0
    end
    object GroupBox6: TGroupBox
      Left = 249
      Top = 23
      Width = 154
      Height = 57
      Caption = 'HotKey'
      TabOrder = 1
      object ClearDataBtn: TButton
        Left = 8
        Top = 22
        Width = 137
        Height = 25
        Hint = 'Click to change HotKey'
        TabOrder = 0
        OnClick = ClearDataBtnClick
      end
    end
    object CheckBox8: TCheckBox
      Left = 16
      Top = 55
      Width = 217
      Height = 17
      Caption = 'When hide from Boss HotKey'
      TabOrder = 2
    end
    object Button7: TButton
      Left = 409
      Top = 12
      Width = 21
      Height = 21
      Caption = '?'
      TabOrder = 3
      OnClick = Button7Click
    end
  end
  object GroupBox7: TGroupBox
    Left = 451
    Top = 392
    Width = 153
    Height = 140
    Caption = 'Boss HotKey'
    TabOrder = 5
    object BossCheckBox: TCheckBox
      Left = 16
      Top = 17
      Width = 121
      Height = 17
      Caption = 'Enabled'
      TabOrder = 0
      OnClick = BossCheckBoxClick
    end
    object RadioGroup2: TRadioGroup
      Left = 16
      Top = 41
      Width = 121
      Height = 57
      Caption = 'Process state'
      ItemIndex = 0
      Items.Strings = (
        'Hide process'
        'Kill process')
      TabOrder = 1
    end
    object BossBtn: TButton
      Left = 8
      Top = 106
      Width = 137
      Height = 25
      Hint = 'Click to change HotKey'
      TabOrder = 2
      OnClick = BossBtnClick
    end
  end
  object CheckBox5: TCheckBox
    Left = 8
    Top = 60
    Width = 387
    Height = 17
    Caption = 'Enabled log file'
    TabOrder = 6
  end
  object Button1: TButton
    Left = 451
    Top = 538
    Width = 54
    Height = 25
    Caption = 'Save'
    TabOrder = 7
    OnClick = Button1Click
  end
  object TitleBarPanel1: TTitleBarPanel
    Left = 0
    Top = 0
    Width = 612
    Height = 30
    CustomButtons = <
      item
        ButtonType = sbMinimize
        Enabled = True
        Hint = 'Hide (Shift+Ctrl+Alt+F12 Hide/Show)'
        Width = 46
        Visible = True
        OnClick = TitleBarPanel1CustomButtons0Click
      end>
    DesignSize = (
      612
      30)
    object LogImg: TImage
      Left = 3
      Top = 4
      Width = 24
      Height = 24
      Cursor = crHandPoint
      Hint = 'Read log file'
      Center = True
      Transparent = True
      OnClick = LogImgClick
    end
    object TimerImage: TImage
      Left = 30
      Top = 4
      Width = 24
      Height = 24
      Cursor = crHandPoint
      Hint = 'Timer'
      Center = True
      PopupMenu = ShutdownForm.PopupMenu1
      Transparent = True
      OnClick = TimerImageClick
    end
    object FavLNKImage: TImage
      Left = 57
      Top = 4
      Width = 24
      Height = 24
      Cursor = crHandPoint
      Hint = 'Favorites links'
      Center = True
      PopupMenu = LNK_Form.GeneralMenu
      Transparent = True
      OnClick = FavLNKImageClick
    end
  end
  object PTab: TTabControl
    Left = 8
    Top = 128
    Width = 596
    Height = 258
    Style = tsButtons
    TabOrder = 9
    OnChange = PTabChange
    object Label1: TLabel
      Left = 15
      Top = 40
      Width = 75
      Height = 13
      Caption = 'Process Name :'
    end
    object Edit1: TEdit
      Left = 15
      Top = 56
      Width = 218
      Height = 21
      TabOrder = 0
    end
    object Button4: TButton
      Left = 239
      Top = 54
      Width = 28
      Height = 25
      Hint = 'Select from all running apps'
      Caption = '>>'
      TabOrder = 1
      OnClick = Button4Click
    end
    object GroupBox1: TGroupBox
      Left = 286
      Top = 32
      Width = 154
      Height = 62
      Caption = 'HotKey'
      TabOrder = 2
      object ProcessHotKeyBtn: TButton
        Left = 8
        Top = 24
        Width = 137
        Height = 25
        Hint = 'Click to change HotKey'
        TabOrder = 0
        OnClick = ProcessHotKeyBtnClick
      end
    end
    object RadioGroup1: TRadioGroup
      Left = 458
      Top = 32
      Width = 122
      Height = 62
      Caption = 'Show process'
      ItemIndex = 0
      Items.Strings = (
        'Normal'
        'Minimized')
      TabOrder = 3
    end
    object GroupBox8: TGroupBox
      Left = 15
      Top = 100
      Width = 565
      Height = 141
      TabOrder = 4
      object Label2: TLabel
        Left = 14
        Top = 39
        Width = 66
        Height = 13
        Caption = 'File Location :'
      end
      object Label4: TLabel
        Left = 16
        Top = 88
        Width = 57
        Height = 13
        Caption = 'Working dir:'
      end
      object CheckBox2: TCheckBox
        Left = 14
        Top = 16
        Width = 289
        Height = 17
        Caption = 'Do not open'
        TabOrder = 0
        OnClick = CheckBox2Click
      end
      object Edit2: TEdit
        Left = 14
        Top = 58
        Width = 459
        Height = 21
        TabOrder = 1
      end
      object Button3: TButton
        Left = 479
        Top = 56
        Width = 70
        Height = 25
        Hint = 'Select executable file'
        Caption = '>>'
        TabOrder = 2
        OnClick = Button3Click
      end
      object Edit4: TEdit
        Left = 14
        Top = 104
        Width = 459
        Height = 21
        TabOrder = 3
      end
    end
  end
  object CheckBox4: TCheckBox
    Left = 8
    Top = 83
    Width = 387
    Height = 17
    Caption = 'Mute when hide'
    TabOrder = 10
  end
  object AddButton: TButton
    Left = 556
    Top = 101
    Width = 21
    Height = 21
    Hint = 'New tab'
    Caption = '+'
    TabOrder = 11
    OnClick = AddButtonClick
  end
  object RemoveButton: TButton
    Left = 583
    Top = 101
    Width = 21
    Height = 21
    Hint = 'Remove tab'
    Caption = 'X'
    TabOrder = 12
    OnClick = RemoveButtonClick
  end
  object ProcessMenu: TPopupMenu
    OwnerDraw = True
    Left = 264
    Top = 16
  end
  object FavTray: TTrayIcon
    Icon.Data = {
      0000010001001010000001002000680400001600000028000000100000002000
      0000010020000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000033B3FF0A2AA8FF4F2EA2FF0B00000000000000000000
      0000000000002EA2FF0B2AA8FF4F1CAAFF090000000000000000000000000000
      0000000000000000000029ADFF6A28ADFFFF28ADFFE728ACFF6C2BAAFF062BAA
      FF0628ACFF6C28ADFFE728ADFFFF27ACFF690000000000000000000000000000
      0000000000000000000026B3FF5127B2FFFF27B2FFFF27B2FFFF27B2FFDF27B2
      FFDF27B2FFFF27B2FFFF27B2FFFF26B3FF510000000000000000000000000000
      0000000000000000000028B5FF2626B7FFFF26B7FFFF26B7FFFF26B7FFFF26B7
      FFFF26B7FFFF26B7FFFF26B7FFFF29BAFF250000000000000000000000000000
      0000000000000000000000AAFF0325BCFFF625BCFFFF25BCFFFF25BCFFFF25BC
      FFFF25BCFFFF25BCFFFF25BCFFF600AAFF030000000000000000000000000000
      0000000000000000000024BEFF3F24C0FFF724C0FFFF24C0FFFF24C0FFFF24C0
      FFFF24C0FFFF24C0FFFF24C0FFF724BEFF3F0000000000000000000000000000
      00000000000024C6FF3F23C5FFF323C5FFFF23C5FFFF23C5FFFF23C5FFFF23C5
      FFFF23C5FFFF23C5FFFF23C5FFFF23C5FFF521C4FF4500000000000000000000
      000023C8FF4122CAFFF722CAFFFF22CAFFFF22CAFFFF22CAFFFF22CAFFFF22CA
      FFFF22CAFFFF22CAFFFF22CAFFFF22CAFFFF22CAFFF724CBFF40000000000000
      000021D0FF9221CFFFFF21CFFFFF21CFFFFF21CFFFFF21CFFFFF21CFFFFF21CF
      FFFF21CFFFFF21CFFFFF21CFFFFF21CFFFFF21CFFFFF22CFFF90000000000000
      00002BD5FF0620D3FF4021D2FF661FD3FF8B21D3FFC420D3FFFF20D3FFFF20D3
      FFFF20D3FFFF21D3FFC41FD3FF8B21D2FF6620D3FF402BD5FF06000000000000
      00000000000000000000000000000000000022DDFF0F1FD8FFEE1FD8FFFF1FD8
      FFFF1FD8FFF020DFFF1000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001EDDFF801EDDFFFF1EDD
      FFFF1EDDFF800000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001EE1FF111DE2FFF01DE2
      FFF01EE1FF110000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000001BE4FF301BE4
      FF2F000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000E3C70000E0070000E0070000E0070000E0070000E0070000C00300008001
      00008001000080010000F81F0000FC3F0000FC3F0000FE7F0000FFFF0000}
    PopupMenu = LNK_Form.GeneralMenu
    OnClick = FavTrayClick
    Left = 312
    Top = 16
  end
  object TimerTrayIcon: TTrayIcon
    Hint = 'Timer not active'
    Icon.Data = {
      0000010001001010000001002000680400001600000028000000100000002000
      0000010020000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F6B0721DF7AB6EBCF7AB6FE7F8B076F7F9B3
      7CF4FAB380CAFBB27E7BFFB6800E000000000000000000000000000000000000
      00000000000000000000F8AE706BF4A866FCECA96CFFEAB278FFE8AC70FFE8AD
      72FFEAAF77FFEEA96EFFF8B27EE8FBB47D3D0000000000000000000000000000
      000000000000F7AD715AF2A463FFE8AB6DFFF0BE8AFFFFEAD4FFFFEDDAFFFFED
      DAFFFFEDDBFFF0C69DFFE8A86CFFF8B17AF6FAB17D3100000000000000000000
      0000FF808004F5A869F6E7A86AFFFDD7B0FFFFEAD5FFFFEDDBFFFFEDDBFFFFED
      DBFFFFEDDBFFFFEDDBFFFDE7D1FFE8A76AFFFAB37FD1FF808002000000000000
      0000F6AB7076EDA361FFEBB278FFFFE3C4FFFFEDDBFF9083DBFFD7C7DCFFFFED
      DBFFFFEDDBFFFFEDDBFFFFECD9FFEBB886FFF2AC73FFFBB28042000000000000
      0000F5AA6DC6E9A96AFFFFDBB4FFFFE9D2FFFFEDDBFFC5B7DBFF776AD5FFF7E4
      D3FFFFEDDBFFFFEDDBFFFFEDDBFFFFECD9FFEAA86DFFF9B48084000000000000
      0000F6AA6BDBE7A869FFF9CFA3FFFFEBD7FFFFEDDBFFFFEDDBFF9A7B53FFAC90
      75FFCFBFDCFFCFBFDCFFCFBFDCFFD1B7C3FFDFA16DFFFAB3809E000000000000
      0000F5A96CD0E9AB6CFFFFDCB5FFFFEAD4FFFFEDDBFFFFEDDBFFB2946DFF866E
      8FFF6E63DDFF6E63DDFF6E63DDFF6E63DDFFD2987AFFFAB27F8F000000000000
      0000F7AB6D98ECA463FFF5C897FFFFE6CAFFFFEDDBFFFFEDDBFFB3956EFF846E
      98FF6E63DDFF6E63DDFF6F64DCFF8A6FB5FFE5A374FFF9B3805A000000000000
      0000F6AA711BF3A665FEE2A05DFFFFDEB9FFFFECDAFFFFEDDBFFB3956EFF846E
      98FF6E63DDFF6E63DDFF6F63DBFFCB8D64FFF8B37EEBFFB1760D000000000000
      000000000000F5A96EA0EFA462FFEBB47BFFF7D0A7FFFFECDAFFC7AE8CFF7E6B
      A9FF6E63DDFF826BBEFFB5878AFFF0AB78FFFAB4806200000000000000000000
      00000000000000000000F7AB6DBFF0A764FFE6A768FFEFBD89FFF2C99EFF9774
      A7FFA67F9AFFCD9270FFF2AE78FEFBB2807E0000000000000000000000000000
      00000000000000000000FFCEA42AFCBE87E9F5A96BF0F4A96DFFF0AA6FFFEDA9
      74FFF7B078FEFAB480C9FECA98DCFFDFB5180000000000000000000000000000
      000000000000FFE5C457FFE2C1F4FFE2C4A000000000F5AF7333FCC187E3FCCA
      9EB2F6B37B1B00000000FFDEB6CEFFE3C5EFFFEFDA3000000000000000000000
      000000000000FFE1C82AFFE2C1DBFFE8D18F00000000FFE4C768FFE1C0E2FFE8
      D1BBFFEDDC3A00000000FFE1C1BEFFE8CEC4FFE8DC1600000000000000000000
      00000000000000000000000000000000000000000000FFE3C2B4FFE5CAFFFFED
      DBFFFFEEDA75000000000000000000000000000000000000000000000000F00F
      0000E0070000C003000080010000800100008001000080010000800100008001
      000080010000C0030000E0070000E0070000C4230000C4230000FC3F0000}
    Icons = ImageList1
    PopupMenu = ShutdownForm.PopupMenu1
    OnClick = TimerTrayIconClick
    Left = 344
    Top = 16
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 376
    Top = 16
  end
end
