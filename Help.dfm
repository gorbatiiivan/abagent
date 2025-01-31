object HelpForm: THelpForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Help'
  ClientHeight = 441
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnResize = FormResize
  TextHeight = 13
  object HELPFORM_PAGECTRL1: TPageControl
    Left = 0
    Top = 0
    Width = 635
    Height = 441
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'About'
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
          052E0400000E00000000000000FFFFFFFFFFFFFFFF0100000000000000000000
          0011530068006F00770020006F00720020006800690064006500200066006F00
          72006D0012530068006900660074002B004300740072006C002B0041006C0074
          002B00460031003200B0DB3E2100000000FFFFFFFFFFFFFFFF00000000000000
          00000000000A43006C006500610072002000640061007400610000000000FFFF
          FFFFFFFFFFFF0000000000000000000000000B42006F0073007300200068006F
          0074006B006500790000000000FFFFFFFFFFFFFFFF0000000002000000000000
          0011530068006F00770020006F00720020006800690064006500200066006F00
          72006D0000000000FFFFFFFFFFFFFFFF00000000010000000000000011530068
          006F00770020006F00720020006800690064006500200066006F0072006D0000
          000000FFFFFFFFFFFFFFFF0100000001000000000000000B4300680061006E00
          6700650020007400610062007300084300740072006C002B00540061006200A8
          9E3E2100000000FFFFFFFFFFFFFFFF010000000100000000000000124F007000
          65006E002000730065006C006500630074006500640020006900740065006D00
          0545006E0074006500720020223F2100000000FFFFFFFFFFFFFFFF0100000001
          00000000000000124F00700065006E0020006900740065006D0020006C006F00
          63006100740069006F006E00064300740072006C002B004C0048703E21000000
          00FFFFFFFFFFFFFFFF0100000001000000000000001B43007200650061007400
          6500200061002000730068006F00720074006300750074002000660072006F00
          6D002000660069006C006500064300740072006C002B004E00686F3E21000000
          00FFFFFFFFFFFFFFFF0100000001000000000000001D43007200650061007400
          6500200061002000730068006F0072007400630075007400200066006F007200
          6D00200066006F006C00640065007200064300740072006C002B004400C8C73E
          2100000000FFFFFFFFFFFFFFFF01000000010000000000000014520065006D00
          6F00760065002000730065006C00650063007400650064002000690074006500
          6D0003440065006C00C0243F2100000000FFFFFFFFFFFFFFFF01000000010000
          0000000000214100640064002000730065006C00650063007400650064002000
          6900740065006D00200074006F002000700072006F0063006500730073002000
          6C00690073007400064300740072006C002B005000F8C93E2100000000FFFFFF
          FFFFFFFFFF010000000100000000000000074E00650077002000740061006200
          064300740072006C002B00460090063F2100000000FFFFFFFFFFFFFFFF010000
          0001000000000000000A500072006F0070006500720074006900650073000941
          006C0074002B0045006E0074006500720040D43E21FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFF}
        GroupView = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
      end
    end
  end
end
