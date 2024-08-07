object LNK_ActionForm: TLNK_ActionForm
  Left = 191
  Top = 107
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'LNK_ActionForm'
  ClientHeight = 105
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 16
  object Label1: TLabel
    Left = 18
    Top = 11
    Width = 309
    Height = 14
    AutoSize = False
    Caption = 'Label'
  end
  object ComboBoxEx: TComboBoxEx
    Left = 18
    Top = 31
    Width = 309
    Height = 25
    ItemsEx = <>
    ItemHeight = 19
    TabOrder = 0
    Images = ImageList1
  end
  object Button1: TButton
    Left = 88
    Top = 68
    Width = 83
    Height = 28
    Caption = #1044#1072
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 176
    Top = 68
    Width = 83
    Height = 28
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object ImageList1: TImageList
    Left = 8
    Top = 64
  end
end
