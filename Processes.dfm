object ProcessesForm: TProcessesForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Select process from list'
  ClientHeight = 501
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  TextHeight = 16
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 418
    Height = 440
    Align = alClient
    TabOrder = 0
    OnDblClick = ListBox1DblClick
    ExplicitLeft = 9
    ExplicitTop = 123
  end
  object Panel1: TPanel
    Left = 0
    Top = 440
    Width = 418
    Height = 61
    Align = alBottom
    TabOrder = 1
    object Button1: TButton
      Left = 114
      Top = 18
      Width = 83
      Height = 27
      Caption = 'Add'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 220
      Top = 18
      Width = 83
      Height = 27
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
end
