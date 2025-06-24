object LogForm: TLogForm
  Left = 0
  Top = 0
  Caption = 'LogForm'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 15
  object LogListView: TListView
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    ParentCustomHint = False
    Align = alClient
    Columns = <
      item
        Width = 150
      end
      item
        Width = 200
      end
      item
        Width = 270
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ShowColumnHeaders = False
    TabOrder = 0
    ViewStyle = vsReport
  end
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 32
    Top = 32
    object LOG_LST_MENU_N1: TMenuItem
      Caption = 'Show'
      Default = True
      OnClick = LOG_LST_MENU_N1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object LOG_LST_MENU_N2: TMenuItem
      Caption = 'Change hotkey'
      OnClick = LOG_LST_MENU_N2Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object LOG_LST_MENU_N3: TMenuItem
      Caption = 'Show events from file'
      OnClick = LOG_LST_MENU_N3Click
    end
  end
end
