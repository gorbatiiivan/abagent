object ShutdownForm: TShutdownForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Timer'
  ClientHeight = 321
  ClientWidth = 336
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 16
  object Image1: TImage
    Left = 175
    Top = 82
    Width = 64
    Height = 60
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Picture.Data = {
      055449636F6E0000010001001010100000000000280100001600000028000000
      10000000200000000100040000000000C0000000000000000000000000000000
      0000000000000000000080000080000000808000800000008000800080800000
      C0C0C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
      FFFFFF0000000008800000000000088888000000000888877788000008888777
      77880000888777117788000087771191778808008711A99177880880871A9AA1
      778808808719A991778808808719A9117788088087191187F7780880871187FF
      777887808787F7777887788087FF777787788000088777888880000000088800
      00000000FE3F0000F80F0000E007000080070000000300000001000000000000
      00000000000000000000000000000000000000000001000000070000801F0000
      E3FF0000}
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 10
    Top = 10
    Width = 316
    Height = 202
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Options'
    TabOrder = 0
    object Bevel3: TBevel
      Left = 10
      Top = 62
      Width = 294
      Height = 131
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Style = bsRaised
    end
    object Label2: TLabel
      Left = 218
      Top = 74
      Width = 59
      Height = 16
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'from now !'
    end
    object Label3: TLabel
      Left = 218
      Top = 104
      Width = 60
      Height = 16
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'localtime !'
    end
    object Label1: TLabel
      Left = 188
      Top = 24
      Width = 100
      Height = 24
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      AutoSize = False
      Caption = 'Windows'
      Layout = tlCenter
    end
    object Label7: TLabel
      Left = 132
      Top = 99
      Width = 5
      Height = 24
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = ':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object RadioButton1: TRadioButton
      Left = 19
      Top = 68
      Width = 46
      Height = 20
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'in'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 19
      Top = 101
      Width = 46
      Height = 20
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'at'
      TabOrder = 4
      OnClick = RadioButton1Click
    end
    object ComboBox1: TComboBox
      Left = 135
      Top = 68
      Width = 77
      Height = 24
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Style = csDropDownList
      TabOrder = 2
      Items.Strings = (
        'minutes'
        'hours')
    end
    object ComboBox_ExitMethod: TComboBox
      Left = 63
      Top = 24
      Width = 115
      Height = 24
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Style = csDropDownList
      DragCursor = crHandPoint
      TabOrder = 0
      OnChange = ComboBox_ExitMethodChange
      Items.Strings = (
        'PowerOff'
        'Shutdown'
        'Reboot'
        'Logoff'
        'StandBy')
    end
    object CheckBox1: TCheckBox
      Left = 19
      Top = 134
      Width = 285
      Height = 20
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'and force processes that don'#39't respond'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object UpDown1: TUpDown
      Left = 106
      Top = 68
      Width = 21
      Height = 24
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Associate = Edit1
      Max = 999
      TabOrder = 5
      OnClick = UpDown1Click
    end
    object Edit1: TEdit
      Left = 63
      Top = 68
      Width = 43
      Height = 24
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      TabOrder = 6
      Text = '0'
      OnChange = Edit1Change
      OnKeyPress = Edit1KeyPress
    end
    object CheckBox2: TCheckBox
      Left = 19
      Top = 161
      Width = 269
      Height = 21
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'disable wakeup events'
      Enabled = False
      TabOrder = 7
    end
  end
  object GroupBox2: TGroupBox
    Left = 10
    Top = 219
    Width = 316
    Height = 93
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Caption = 'Action'
    TabOrder = 1
    object Bevel1: TBevel
      Left = 10
      Top = 19
      Width = 294
      Height = 30
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Style = bsRaised
    end
    object Label4: TLabel
      Left = 19
      Top = 24
      Width = 161
      Height = 16
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'No reboot or shutdown set !'
    end
    object Button1: TButton
      Left = 10
      Top = 53
      Width = 294
      Height = 31
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Caption = 'Enable &Timer'
      Default = True
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Edit2: TEdit
    Left = 74
    Top = 108
    Width = 43
    Height = 24
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 2
    Text = '0'
    OnChange = Edit2Change
    OnKeyPress = Edit1KeyPress
  end
  object UpDown2: TUpDown
    Left = 117
    Top = 108
    Width = 18
    Height = 24
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Associate = Edit2
    Max = 23
    TabOrder = 3
  end
  object Edit3: TEdit
    Left = 156
    Top = 108
    Width = 43
    Height = 24
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    TabOrder = 4
    Text = '0'
    OnChange = Edit3Change
    OnKeyPress = Edit1KeyPress
  end
  object UpDown3: TUpDown
    Left = 199
    Top = 108
    Width = 19
    Height = 24
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Associate = Edit3
    Max = 59
    TabOrder = 5
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 256
    Top = 208
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 208
    Top = 206
    object N3: TMenuItem
      Caption = 'Show'
      Default = True
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = 'Show in tray'
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = 'Set HotKey'
      OnClick = N2Click
    end
  end
end
