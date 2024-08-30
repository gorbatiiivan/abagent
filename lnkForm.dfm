object LNK_Form: TLNK_Form
  Left = 0
  Top = 0
  BorderIcons = []
  ClientHeight = 461
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  TextHeight = 13
  object Tabs: TTabControl
    AlignWithMargins = True
    Left = 3
    Top = 87
    Width = 694
    Height = 371
    Align = alClient
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 0
    OnChange = TabsChange
    object List: TListView
      Left = 4
      Top = 6
      Width = 686
      Height = 361
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
    Height = 84
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    OnMouseDown = PanelMouseDown
    object SpeedButton3: TSpeedButton
      Left = 170
      Top = 6
      Width = 34
      Height = 32
      Hint = 'Recycle Bin'
      ImageIndex = 2
      Images = ImageList1
      Flat = True
      OnClick = SpeedButton3Click
    end
    object HideButton: TSpeedButton
      Left = 673
      Top = 6
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
      OnClick = HideButtonClick
    end
    object Bevel1: TBevel
      Left = 42
      Top = 8
      Width = 9
      Height = 28
      Shape = bsLeftLine
    end
    object Bevel2: TBevel
      Left = 210
      Top = 8
      Width = 9
      Height = 28
      Shape = bsLeftLine
    end
    object SpeedButton1: TSpeedButton
      Left = 4
      Top = 6
      Width = 34
      Height = 32
      Hint = 'Timer'
      ImageIndex = 10
      Images = ImageList1
      Flat = True
      OnClick = SpeedButton1Click
    end
    object Button1: TButton
      Left = 50
      Top = 6
      Width = 54
      Height = 32
      Hint = 'My Computer'
      ImageIndex = 0
      Images = ImageList1
      Style = bsSplitButton
      TabOrder = 1
      OnClick = Button1Click
      OnDropDownClick = Button1DropDownClick
    end
    object Button2: TButton
      Tag = 1
      Left = 110
      Top = 6
      Width = 54
      Height = 32
      Hint = 'Settings'
      ImageIndex = 1
      Images = ImageList1
      Style = bsSplitButton
      TabOrder = 0
      OnClick = Button2Click
      OnDropDownClick = Button2DropDownClick
    end
    object ToolBar1: TToolBar
      Left = 0
      Top = 44
      Width = 272
      Height = 43
      Align = alNone
      ButtonHeight = 38
      ButtonWidth = 39
      Caption = 'ToolBar1'
      Images = ImageList1
      TabOrder = 2
    end
    object FindEdit: TEdit
      Left = 218
      Top = 11
      Width = 135
      Height = 21
      TabOrder = 3
      OnChange = FindEditChange
    end
  end
  object PopupMenu: TPopupMenu
    OnPopup = PopupMenuPopup
    Left = 48
    Top = 104
    object Open1: TMenuItem
      Caption = 'Open'
      Default = True
      ShortCut = 13
      OnClick = ListDblClick
    end
    object N20: TMenuItem
      Caption = '-'
    end
    object N17: TMenuItem
      Caption = 'Open location'
      ShortCut = 16460
      OnClick = N17Click
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Caption = 'Create a shortcut'
      ShortCut = 16462
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = 'Remove shortcut'
      ShortCut = 46
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N7: TMenuItem
      Caption = 'Copy to'
    end
    object N8: TMenuItem
      Caption = 'Move to'
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Addtoprocesslist1: TMenuItem
      Caption = 'Add to process list'
      ShortCut = 16464
      OnClick = Addtoprocesslist1Click
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = 'New tab'
      ShortCut = 16454
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = 'Delete tab'
    end
    object N25: TMenuItem
      Caption = '-'
    end
    object N21: TMenuItem
      Caption = 'Import from system'
      object N27: TMenuItem
        Caption = 'Apps'
        OnClick = N27Click
      end
      object N29: TMenuItem
        Caption = 'Folders'
        OnClick = N29Click
      end
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Iconssize1: TMenuItem
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
    object IconsStyle1: TMenuItem
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
    object N10: TMenuItem
      Caption = 'Properties'
      ShortCut = 32781
      OnClick = N10Click
    end
  end
  object GeneralMenu: TPopupMenu
    OnPopup = GeneralMenuPopup
    Left = 48
    Top = 160
    object N14: TMenuItem
      Caption = 'Show'
      Default = True
      OnClick = N14Click
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object N23: TMenuItem
      Caption = 'Do not hide automatically'
      OnClick = N23Click
    end
    object N24: TMenuItem
      Caption = 'Hide when opening'
      OnClick = N24Click
    end
    object N22: TMenuItem
      Caption = 'Prevent moving off screen'
      OnClick = N22Click
    end
    object N18: TMenuItem
      Caption = '-'
    end
    object N15: TMenuItem
      Caption = 'Hide from tray'
      OnClick = N15Click
    end
    object N16: TMenuItem
      Caption = 'Set HotKey'
      OnClick = N16Click
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
    Left = 51
    Top = 278
  end
end
