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
  CustomTitleBar.BackgroundColor = 11625216
  CustomTitleBar.ForegroundColor = clWhite
  CustomTitleBar.InactiveBackgroundColor = clWhite
  CustomTitleBar.InactiveForegroundColor = 10066329
  CustomTitleBar.ButtonForegroundColor = clWhite
  CustomTitleBar.ButtonBackgroundColor = 11625216
  CustomTitleBar.ButtonHoverForegroundColor = clWhite
  CustomTitleBar.ButtonHoverBackgroundColor = 8801024
  CustomTitleBar.ButtonPressedForegroundColor = clWhite
  CustomTitleBar.ButtonPressedBackgroundColor = 4663296
  CustomTitleBar.ButtonInactiveForegroundColor = 10066329
  CustomTitleBar.ButtonInactiveBackgroundColor = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
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
  object Main_LBL1: TLabel
    Left = 8
    Top = 101
    Width = 387
    Height = 21
    AutoSize = False
    Caption = 'Process list:'
    Layout = tlCenter
  end
  object Main_CHKBOX1: TCheckBox
    Left = 8
    Top = 36
    Width = 387
    Height = 17
    Caption = 'Start when I log on (with Admin privileges)'
    TabOrder = 0
    OnClick = Main_CHKBOX1Click
  end
  object Main_GrpBox3: TGroupBox
    Left = 8
    Top = 392
    Width = 437
    Height = 73
    Caption = 'Task Managers'
    TabOrder = 7
    object Main_CHKBOX5: TCheckBox
      Left = 15
      Top = 17
      Width = 419
      Height = 17
      Caption = 
        'Terminate all running processes when starting application from t' +
        'he list:'
      TabOrder = 0
      OnClick = Main_CHKBOX5Click
    end
    object Edit3: TEdit
      Left = 15
      Top = 40
      Width = 370
      Height = 21
      TabOrder = 1
    end
    object Main_BTN7: TButton
      Left = 391
      Top = 38
      Width = 28
      Height = 25
      Hint = 'Select from all running apps'
      Caption = '>>'
      TabOrder = 2
      OnClick = Main_BTN7Click
    end
  end
  object Main_GrpBox1: TGroupBox
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
    object Main_BTN1: TButton
      Left = 168
      Top = 21
      Width = 21
      Height = 21
      Hint = 'Help'
      Caption = '?'
      TabOrder = 1
      OnClick = Main_BTN1Click
    end
  end
  object Main_GrpBox5: TGroupBox
    Left = 8
    Top = 471
    Width = 437
    Height = 92
    Caption = 'Clear data (need Admin Privileges)'
    TabOrder = 9
    object Main_CHKBOX7: TCheckBox
      Left = 16
      Top = 32
      Width = 251
      Height = 17
      Hint = 'It only works if the checkbox "Task Managers" is checked'
      Caption = 'When starting Task Managers'
      TabOrder = 0
      OnClick = Main_CHKBOX7Click
    end
    object Main_GrpBox6: TGroupBox
      Left = 273
      Top = 16
      Width = 154
      Height = 64
      Caption = 'HotKey'
      TabOrder = 2
      object Main_BTN9: TButton
        Left = 8
        Top = 22
        Width = 137
        Height = 25
        Hint = 'Click to change HotKey'
        TabOrder = 0
        OnClick = Main_BTN9Click
      end
    end
    object Main_CHKBOX8: TCheckBox
      Left = 16
      Top = 55
      Width = 251
      Height = 17
      Caption = 'When hide from Boss HotKey'
      TabOrder = 1
      OnClick = Main_CHKBOX8Click
    end
    object Main_BTN11: TButton
      Left = 246
      Top = 15
      Width = 21
      Height = 21
      Hint = 'Help'
      Caption = '?'
      TabOrder = 3
      OnClick = Main_BTN11Click
    end
  end
  object Main_GrpBox4: TGroupBox
    Left = 451
    Top = 392
    Width = 153
    Height = 140
    Caption = 'Boss HotKey'
    TabOrder = 8
    object Main_CHKBOX6: TCheckBox
      Left = 16
      Top = 17
      Width = 121
      Height = 17
      Caption = 'Enabled'
      TabOrder = 0
      OnClick = Main_CHKBOX6Click
    end
    object Main_RADGrp2: TRadioGroup
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
      OnClick = Main_RADGrp2Click
    end
    object Main_BTN8: TButton
      Left = 8
      Top = 106
      Width = 137
      Height = 25
      Hint = 'Click to change HotKey'
      TabOrder = 2
      OnClick = Main_BTN8Click
    end
  end
  object Main_CHKBOX2: TCheckBox
    Left = 8
    Top = 60
    Width = 387
    Height = 17
    Caption = 'Enabled log file'
    TabOrder = 1
    OnClick = Main_CHKBOX2Click
  end
  object Main_BTN10: TButton
    Left = 451
    Top = 538
    Width = 153
    Height = 25
    Caption = 'Save'
    TabOrder = 11
    OnClick = Main_BTN10Click
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
        Hint = 'Hide'
        Width = 46
        Visible = True
        OnClick = TitleBarPanel1CustomButtons0Click
      end>
    DesignSize = (
      612
      30)
    object LogImg: TImage
      Left = 35
      Top = 3
      Width = 24
      Height = 24
      Cursor = crHandPoint
      Hint = 'Read log file'
      Center = True
      Transparent = True
      OnClick = LogImgClick
    end
    object TimerImg: TImage
      Left = 62
      Top = 3
      Width = 24
      Height = 24
      Cursor = crHandPoint
      Hint = 'Timer'
      Center = True
      PopupMenu = ShutdownForm.PopupMenu1
      Transparent = True
      OnClick = TimerImgClick
    end
    object FavImg: TImage
      Left = 89
      Top = 3
      Width = 24
      Height = 24
      Cursor = crHandPoint
      Hint = 'Favorites'
      Center = True
      PopupMenu = LNK_Form.GeneralMenu
      Transparent = True
      OnClick = FavImgClick
    end
    object MainImg: TImage
      Left = 8
      Top = 3
      Width = 24
      Height = 24
      Cursor = crHandPoint
      Hint = 'Main menu'
      Transparent = True
      OnClick = MainImgClick
    end
  end
  object PTab: TTabControl
    Left = 8
    Top = 128
    Width = 596
    Height = 258
    Style = tsButtons
    TabOrder = 6
    OnChange = PTabChange
    object Main_LBL2: TLabel
      Left = 15
      Top = 55
      Width = 76
      Height = 13
      Caption = 'Process Name :'
    end
    object Main_LBL5: TLabel
      Left = 15
      Top = 32
      Width = 173
      Height = 13
      Cursor = crHandPoint
      Caption = 'Click to show hidding process list'
      OnClick = Main_LBL5Click
      OnMouseEnter = Main_LBL5MouseEnter
      OnMouseLeave = Main_LBL5MouseLeave
    end
    object Edit1: TEdit
      Left = 15
      Top = 71
      Width = 218
      Height = 21
      TabOrder = 0
    end
    object Main_BTN4: TButton
      Left = 239
      Top = 69
      Width = 28
      Height = 25
      Hint = 'Select from all running apps'
      Caption = '>>'
      TabOrder = 1
      OnClick = Main_BTN4Click
    end
    object Main_GrpBox2: TGroupBox
      Left = 286
      Top = 32
      Width = 166
      Height = 62
      Caption = 'HotKey'
      TabOrder = 2
      object Main_BTN5: TButton
        Left = 8
        Top = 32
        Width = 150
        Height = 25
        Hint = 'Click to change HotKey'
        TabOrder = 0
        OnClick = Main_BTN5Click
      end
      object Main_CHKBOX9: TCheckBox
        Left = 8
        Top = 14
        Width = 150
        Height = 17
        Caption = 'Global Hot-Key'
        TabOrder = 1
        OnClick = Main_CHKBOX9Click
      end
    end
    object Main_RADGrp1: TRadioGroup
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
      OnClick = Main_RADGrp1Click
    end
    object GroupBox8: TGroupBox
      Left = 15
      Top = 100
      Width = 565
      Height = 141
      TabOrder = 4
      object Main_LBL3: TLabel
        Left = 14
        Top = 39
        Width = 71
        Height = 13
        Caption = 'File Location :'
      end
      object Main_LBL4: TLabel
        Left = 16
        Top = 88
        Width = 65
        Height = 13
        Caption = 'Working dir:'
      end
      object Main_LBL6: TLabel
        Left = 287
        Top = 88
        Width = 62
        Height = 13
        Caption = 'Parameters :'
      end
      object Main_CHKBOX4: TCheckBox
        Left = 14
        Top = 16
        Width = 289
        Height = 17
        Caption = 'Do not open'
        TabOrder = 0
        OnClick = Main_CHKBOX4Click
      end
      object Edit2: TEdit
        Left = 14
        Top = 58
        Width = 459
        Height = 21
        TabOrder = 1
      end
      object Main_BTN6: TButton
        Left = 479
        Top = 56
        Width = 70
        Height = 25
        Hint = 'Select executable file'
        Caption = '>>'
        TabOrder = 2
        OnClick = Main_BTN6Click
      end
      object Edit4: TEdit
        Left = 14
        Top = 104
        Width = 267
        Height = 21
        TabOrder = 3
      end
      object Edit5: TEdit
        Left = 287
        Top = 104
        Width = 267
        Height = 21
        TabOrder = 4
      end
    end
  end
  object Main_CHKBOX3: TCheckBox
    Left = 8
    Top = 83
    Width = 387
    Height = 17
    Caption = 'Mute when hide'
    TabOrder = 2
    OnClick = Main_CHKBOX3Click
  end
  object Main_BTN2: TButton
    Left = 556
    Top = 101
    Width = 21
    Height = 21
    Hint = 'New tab'
    Caption = '+'
    TabOrder = 4
    OnClick = Main_BTN2Click
  end
  object Main_BTN3: TButton
    Left = 583
    Top = 101
    Width = 21
    Height = 21
    Hint = 'Remove tab'
    Caption = 'X'
    TabOrder = 5
    OnClick = Main_BTN3Click
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
    OnDblClick = FavTrayDblClick
    Left = 208
    Top = 32
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
    OnDblClick = TimerTrayIconDblClick
    Left = 272
    Top = 32
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 344
    Top = 32
  end
  object MainMenu: TPopupMenu
    OnPopup = MainMenuPopup
    Left = 144
    Top = 32
    object Main_N1: TMenuItem
      Caption = 'Help'
      OnClick = Main_N1Click
    end
    object Main_N3: TMenuItem
      Caption = '-'
    end
    object Main_N2: TMenuItem
      Caption = 'Change HotKey'
      OnClick = Main_N2Click
    end
    object Main_N4: TMenuItem
      Caption = '-'
    end
    object Main_N5: TMenuItem
      Caption = 'Language'
      SubMenuImages = LangImgList
      object Main_N6: TMenuItem
        Caption = 'English'
        ImageIndex = 0
        OnClick = Main_N6Click
      end
      object Main_N7: TMenuItem
        Caption = #1056#1091#1089#1089#1082#1080#1081
        ImageIndex = 1
        OnClick = Main_N6Click
      end
      object Main_N8: TMenuItem
        Caption = 'Rom'#226'n'#259
        ImageIndex = 2
        OnClick = Main_N6Click
      end
    end
  end
  object LangImgList: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 30
    Width = 30
    Left = 392
    Top = 32
  end
end
