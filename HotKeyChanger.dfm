object HotKeyForm: THotKeyForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 211
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object chWin: TCheckBox
    Left = 90
    Top = 63
    Width = 55
    Height = 17
    Caption = 'Win'
    TabOrder = 2
    OnClick = chWinClick
  end
  object chAlt: TCheckBox
    Left = 165
    Top = 63
    Width = 55
    Height = 17
    Caption = 'Alt'
    TabOrder = 3
    OnClick = chAltClick
  end
  object chShift: TCheckBox
    Left = 18
    Top = 20
    Width = 55
    Height = 17
    Caption = 'Shift'
    TabOrder = 0
    OnClick = chShiftClick
  end
  object chCtrl: TCheckBox
    Left = 18
    Top = 63
    Width = 55
    Height = 17
    Caption = 'Ctrl'
    TabOrder = 1
    OnClick = chCtrlClick
  end
  object ComboBox1: TComboBox
    Left = 152
    Top = 16
    Width = 145
    Height = 21
    Style = csDropDownList
    DropDownCount = 33
    TabOrder = 4
    OnChange = ComboBox1Change
    OnKeyDown = ComboBox1KeyDown
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      'A'
      'B'
      'C'
      'D'
      'E'
      'F'
      'G'
      'H'
      'I'
      'J'
      'K'
      'L'
      'M'
      'N'
      'O'
      'P'
      'Q'
      'R'
      'S'
      'T'
      'U'
      'V'
      'W'
      'X'
      'Y'
      'Z'
      'F1'
      'F2'
      'F3'
      'F4'
      'F5'
      'F6'
      'F7'
      'F8'
      'F9'
      'F10'
      'F11'
      'F12'
      'Space'
      'Tab'
      'Up'
      'Down'
      'Left'
      'Right'
      'Home'
      'End'
      'PgUp'
      'PgDn'
      'Ins'
      'Enter'
      'Del'
      'Backspace'
      'Esc'
      'Menu'
      'CapsLock'
      'PauseBreak'
      'PrintScreen'
      'ScrollLock'
      '~'
      '-'
      '='
      '['
      ']'
      '<'
      '>'
      ';'
      #39
      '/'
      '\'
      'Num 0'
      'Num 1'
      'Num 2'
      'Num 3'
      'Num 4'
      'Num 5'
      'Num 6'
      'Num 7'
      'Num 8'
      'Num 9'
      'Num +'
      'Num -'
      'Num *'
      'Num /'
      'Num .')
  end
  object Edit1: TEdit
    Left = 18
    Top = 104
    Width = 202
    Height = 21
    AutoSelect = False
    ReadOnly = True
    TabOrder = 5
    OnKeyDown = Edit1KeyDown
    OnKeyUp = Edit1KeyUp
  end
  object HOTKEYCHANGER_BTN2: TButton
    Left = 34
    Top = 160
    Width = 119
    Height = 33
    Caption = 'Set'
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
  object HOTKEYCHANGER_BTN3: TButton
    Left = 159
    Top = 160
    Width = 119
    Height = 33
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 8
  end
  object HOTKEYCHANGER_BTN1: TButton
    Left = 226
    Top = 100
    Width = 71
    Height = 28
    Caption = 'Clear'
    TabOrder = 6
    OnClick = HOTKEYCHANGER_BTN1Click
  end
end
