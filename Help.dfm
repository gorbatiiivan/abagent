object HelpForm: THelpForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Help'
  ClientHeight = 441
  ClientWidth = 635
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  TextHeight = 13
  object HELPFORM_PAGECTRL1: TPageControl
    Left = 0
    Top = 0
    Width = 635
    Height = 441
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    TabStop = False
    object TabSheet1: TTabSheet
      Caption = 'About'
      object Label1: TLabel
        Left = 368
        Top = 38
        Width = 241
        Height = 50
        AutoSize = False
        Caption = 'ABAgent'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 368
        Top = 94
        Width = 241
        Height = 25
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 368
        Top = 134
        Width = 241
        Height = 204
        AutoSize = False
        WordWrap = True
      end
      object PaintBox1: TPaintBox
        Left = 57
        Top = 78
        Width = 260
        Height = 260
        OnClick = PaintBox1Click
        OnPaint = PaintBox1Paint
      end
      object Label4: TLabel
        Left = 57
        Top = 342
        Width = 260
        Height = 51
        AutoSize = False
        Visible = False
        WordWrap = True
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Keyboard shortcut'
      ImageIndex = 1
      object HELPFORM_LSTVIEW1: TListView
        Left = 0
        Top = 0
        Width = 627
        Height = 413
        Align = alClient
        BorderStyle = bsNone
        Columns = <
          item
            Caption = 'Action'
            Width = 200
          end
          item
            Caption = 'HotKey'
            Width = 200
          end>
        ColumnClick = False
        GridLines = True
        Groups = <
          item
            Header = 'Main Form'
            GroupID = 0
            State = [lgsNormal]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end
          item
            Header = 'Timer'
            GroupID = 2
            State = [lgsNormal]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end
          item
            Header = 'Favorites'
            GroupID = 1
            State = [lgsNormal]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end>
        Items.ItemData = {
          05770400000F00000000000000FFFFFFFFFFFFFFFF0100000000000000000000
          0011530068006F00770020006F00720020006800690064006500200066006F00
          72006D0012530068006900660074002B004300740072006C002B0041006C0074
          002B0046003100320078A2DE2100000000FFFFFFFFFFFFFFFF00000000000000
          00000000000A43006C006500610072002000640061007400610000000000FFFF
          FFFFFFFFFFFF0000000000000000000000000B42006F0073007300200068006F
          0074006B006500790000000000FFFFFFFFFFFFFFFF0000000002000000000000
          0011530068006F00770020006F00720020006800690064006500200066006F00
          72006D0000000000FFFFFFFFFFFFFFFF00000000010000000000000011530068
          006F00770020006F00720020006800690064006500200066006F0072006D0000
          000000FFFFFFFFFFFFFFFF0100000001000000000000000B4300680061006E00
          6700650020007400610062007300084300740072006C002B0054006100620008
          CCDE2100000000FFFFFFFFFFFFFFFF010000000100000000000000124F007000
          65006E002000730065006C006500630074006500640020006900740065006D00
          0545006E0074006500720060B6DE2100000000FFFFFFFFFFFFFFFF0100000001
          00000000000000124F00700065006E0020006900740065006D0020006C006F00
          63006100740069006F006E00064300740072006C002B004C0080B5DE21000000
          00FFFFFFFFFFFFFFFF0100000001000000000000001B43007200650061007400
          6500200061002000730068006F00720074006300750074002000660072006F00
          6D002000660069006C006500064300740072006C002B004E00E0B2DE21000000
          00FFFFFFFFFFFFFFFF0100000001000000000000001D43007200650061007400
          6500200061002000730068006F0072007400630075007400200066006F007200
          6D00200066006F006C00640065007200064300740072006C002B00440070B2DE
          2100000000FFFFFFFFFFFFFFFF01000000010000000000000014520065006D00
          6F00760065002000730065006C00650063007400650064002000690074006500
          6D0003440065006C0090B8DE2100000000FFFFFFFFFFFFFFFF01000000010000
          0000000000214100640064002000730065006C00650063007400650064002000
          6900740065006D00200074006F002000700072006F0063006500730073002000
          6C00690073007400064300740072006C002B00500090A3DE2100000000FFFFFF
          FFFFFFFFFF0100000001000000000000000E410064006400200074006F002000
          74006F006F006C00620061007200064300740072006C002B0054004853DE2100
          000000FFFFFFFFFFFFFFFF010000000100000000000000074E00650077002000
          740061006200064300740072006C002B0046006852DE2100000000FFFFFFFFFF
          FFFFFF0100000001000000000000000A500072006F0070006500720074006900
          650073000941006C0074002B0045006E00740065007200E82BDE21FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        GroupView = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Information'
      ImageIndex = 2
      object HELPFORM_MEMO1: TMemo
        Left = 0
        Top = 0
        Width = 627
        Height = 413
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
end
