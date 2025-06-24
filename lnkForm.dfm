object LNK_Form: TLNK_Form
  Left = 0
  Top = 0
  ActiveControl = FindEdit
  BorderIcons = []
  ClientHeight = 461
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  OnShow = FormShow
  TextHeight = 13
  object Tabs: TTabControl
    AlignWithMargins = True
    Left = 3
    Top = 77
    Width = 694
    Height = 381
    Align = alClient
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    OnChange = TabsChange
    object List: TListView
      Left = 4
      Top = 6
      Width = 686
      Height = 371
      Align = alClient
      BorderStyle = bsNone
      Columns = <
        item
          AutoSize = True
        end>
      ColumnClick = False
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      IconOptions.AutoArrange = True
      ReadOnly = True
      ParentDoubleBuffered = False
      ParentFont = False
      PopupMenu = PopupMenu
      SortType = stText
      TabOrder = 0
      OnDblClick = ListDblClick
      OnKeyDown = ListKeyDown
    end
  end
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    OnMouseDown = PanelMouseDown
    object LNK_SPD_BTN3: TSpeedButton
      Left = 673
      Top = 0
      Width = 20
      Height = 20
      Hint = 'Hide (Esc)'
      Caption = '_'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = LNK_SPD_BTN3Click
    end
    object Bevel2: TBevel
      Left = 183
      Top = 5
      Width = 9
      Height = 28
      Shape = bsLeftLine
    end
    object LNK_BTN1: TButton
      Left = 3
      Top = 3
      Width = 54
      Height = 32
      Hint = 'My Computer'
      ImageIndex = 0
      Images = ImageList1
      Style = bsSplitButton
      TabOrder = 0
      OnClick = LNK_BTN1Click
      OnDropDownClick = LNK_BTN1DropDownClick
    end
    object LNK_BTN2: TButton
      Tag = 1
      Left = 63
      Top = 3
      Width = 54
      Height = 32
      Hint = 'Settings'
      ImageIndex = 1
      Images = ImageList1
      Style = bsSplitButton
      TabOrder = 1
      OnClick = LNK_BTN2Click
      OnDropDownClick = LNK_BTN2DropDownClick
    end
    object FindEdit: TEdit
      Left = 191
      Top = 8
      Width = 135
      Height = 21
      TabOrder = 3
      OnChange = FindEditChange
    end
    object LNK_BTN3: TButton
      Left = 123
      Top = 3
      Width = 54
      Height = 32
      Hint = 'My Computer'
      ImageIndex = 2
      Images = ImageList1
      Style = bsSplitButton
      TabOrder = 2
      OnClick = LNK_BTN3Click
      OnDropDownClick = LNK_BTN3DropDownClick
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 36
    Width = 700
    Height = 38
    AutoSize = True
    ButtonHeight = 38
    ButtonWidth = 39
    Caption = 'ToolBar1'
    Images = ImageList3
    TabOrder = 2
  end
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 48
    Top = 104
    object LNK_LST_MENU_N1: TMenuItem
      Caption = 'Open'
      Default = True
      ShortCut = 13
      OnClick = ListDblClick
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object LNK_LST_MENU_N2: TMenuItem
      Caption = 'Open location'
      ShortCut = 16460
      OnClick = LNK_LST_MENU_N2Click
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object LNK_LST_MENU_N3: TMenuItem
      Caption = 'Create a shortcut'
      object LNK_LST_MENU_N3_N1: TMenuItem
        Caption = 'From file'
        ShortCut = 16462
        OnClick = LNK_LST_MENU_N3_N1Click
      end
      object LNK_LST_MENU_N3_N2: TMenuItem
        Caption = 'From folder'
        ShortCut = 16452
        OnClick = LNK_LST_MENU_N3_N2Click
      end
    end
    object LNK_LST_MENU_N4: TMenuItem
      Caption = 'Remove shortcut'
      ShortCut = 46
      OnClick = LNK_LST_MENU_N4Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object LNK_LST_MENU_N5: TMenuItem
      Caption = 'Copy to'
    end
    object LNK_LST_MENU_N6: TMenuItem
      Caption = 'Move to'
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object LNK_LST_MENU_N7: TMenuItem
      Caption = 'Add to process list'
      ShortCut = 16464
      OnClick = LNK_LST_MENU_N7Click
    end
    object LNK_LST_MENU_N16: TMenuItem
      Caption = 'Add to toolbar'
      ShortCut = 16468
      OnClick = LNK_LST_MENU_N16Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object LNK_LST_MENU_N8: TMenuItem
      Caption = 'New tab'
      ShortCut = 16454
      OnClick = LNK_LST_MENU_N8Click
    end
    object LNK_LST_MENU_N9: TMenuItem
      Caption = 'Delete tab'
    end
    object N25: TMenuItem
      Caption = '-'
    end
    object LNK_LST_MENU_N10: TMenuItem
      Caption = 'Import from system'
      object LNK_LST_MENU_N11: TMenuItem
        Caption = 'Apps'
        OnClick = LNK_LST_MENU_N11Click
      end
      object LNK_LST_MENU_N12: TMenuItem
        Caption = 'Folders'
        OnClick = LNK_LST_MENU_N12Click
      end
      object LNK_LST_MENU_N17: TMenuItem
        Caption = 'Add personal folders'
        OnClick = LNK_LST_MENU_N17Click
      end
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object LNK_LST_MENU_N13: TMenuItem
      Caption = 'Icons size'
      OnClick = N28Click
      object Small1: TMenuItem
        Caption = 'Small'
        Hint = '1'
        RadioItem = True
        OnClick = N26Click
      end
      object Normal1: TMenuItem
        Caption = 'Normal'
        Hint = '0'
        RadioItem = True
        OnClick = N26Click
      end
      object ExtraLarge1: TMenuItem
        Caption = 'Extra Large'
        Hint = '2'
        RadioItem = True
        OnClick = N26Click
      end
      object Jumbo1: TMenuItem
        Caption = 'Jumbo'
        Hint = '4'
        RadioItem = True
        OnClick = N26Click
      end
    end
    object LNK_LST_MENU_N14: TMenuItem
      Caption = 'Icons style'
      OnClick = N32Click
      object Icon1: TMenuItem
        Caption = 'Icon'
        Hint = '0'
        RadioItem = True
        OnClick = N33Click
      end
      object Tile1: TMenuItem
        Caption = 'Tile'
        Hint = '1'
        RadioItem = True
        OnClick = N33Click
      end
    end
    object N26: TMenuItem
      Caption = '-'
    end
    object LNK_LST_MENU_N15: TMenuItem
      Caption = 'Properties'
      ShortCut = 32781
      OnClick = LNK_LST_MENU_N15Click
    end
  end
  object GeneralMenu: TPopupMenu
    OnPopup = GeneralMenuPopup
    Left = 112
    Top = 104
    object LNK_GEN_MENU_N1: TMenuItem
      Caption = 'Show'
      Default = True
      OnClick = LNK_GEN_MENU_N1Click
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object LNK_GEN_MENU_N2: TMenuItem
      Caption = 'Do not hide automatically'
      OnClick = LNK_GEN_MENU_N2Click
    end
    object LNK_GEN_MENU_N3: TMenuItem
      Caption = 'Hide when opening'
      OnClick = LNK_GEN_MENU_N3Click
    end
    object LNK_GEN_MENU_N4: TMenuItem
      Caption = 'Prevent moving off screen'
      OnClick = LNK_GEN_MENU_N4Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object LNK_GEN_MENU_N6: TMenuItem
      Caption = 'Set HotKey'
      OnClick = LNK_GEN_MENU_N6Click
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object LNK_GEN_MENU_N5: TMenuItem
      Caption = 'Show tray icon'
      OnClick = LNK_GEN_MENU_N5Click
    end
    object LNK_GEN_MENU_N7: TMenuItem
      Caption = 'Show form with mouse'
      object LNK_GEN_MENU_N7_1: TMenuItem
        Caption = 'When moving the mouse'
        OnClick = LNK_GEN_MENU_N7_1Click
      end
    end
  end
  object ImageList1: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 32
    Width = 32
    Left = 51
    Top = 219
  end
  object ImageList2: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 32
    Width = 32
    Left = 107
    Top = 222
  end
  object TrayPopupMenu: TPopupMenu
    Images = TrayImageList
    OnPopup = TrayPopupMenuPopup
    Left = 179
    Top = 103
  end
  object TrayImageList: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Left = 235
    Top = 223
  end
  object ImageList3: TImageList
    ColorDepth = cd32Bit
    DrawingStyle = dsTransparent
    Height = 32
    Width = 32
    Left = 171
    Top = 222
  end
end
