object Properties: TProperties
  Left = 191
  Top = 107
  BorderIcons = []
  BorderStyle = bsToolWindow
  Caption = 'Properties'
  ClientHeight = 321
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poDesktopCenter
  ShowHint = True
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 9
    Top = 9
    Width = 476
    Height = 256
    TabOrder = 0
    object Image1: TImage
      Left = 18
      Top = 28
      Width = 35
      Height = 35
    end
    object Edit1: TLabeledEdit
      Left = 70
      Top = 75
      Width = 398
      Height = 24
      EditLabel.Width = 30
      EditLabel.Height = 16
      EditLabel.Caption = 'Path:'
      TabOrder = 1
      Text = ''
    end
    object Edit2: TLabeledEdit
      Left = 70
      Top = 28
      Width = 398
      Height = 24
      EditLabel.Width = 40
      EditLabel.Height = 16
      EditLabel.Caption = 'Name:'
      TabOrder = 0
      Text = ''
    end
    object Edit3: TLabeledEdit
      Left = 70
      Top = 123
      Width = 398
      Height = 24
      EditLabel.Width = 73
      EditLabel.Height = 16
      EditLabel.Caption = 'Parameters:'
      TabOrder = 2
      Text = ''
    end
    object Button4: TButton
      Left = 440
      Top = 220
      Width = 23
      Height = 23
      Hint = 'Click to change icon'
      Caption = '>>'
      TabOrder = 5
      OnClick = Button4Click
    end
    object Edit5: TLabeledEdit
      Left = 70
      Top = 173
      Width = 398
      Height = 24
      EditLabel.Width = 71
      EditLabel.Height = 16
      EditLabel.Caption = 'Working dir:'
      TabOrder = 3
      Text = ''
    end
    object Edit4: TLabeledEdit
      Left = 70
      Top = 220
      Width = 363
      Height = 24
      EditLabel.Width = 78
      EditLabel.Height = 16
      EditLabel.Caption = 'Icon location:'
      TabOrder = 4
      Text = ''
    end
  end
  object Button2: TButton
    Left = 158
    Top = 281
    Width = 83
    Height = 27
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button3: TButton
    Left = 255
    Top = 281
    Width = 83
    Height = 27
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
