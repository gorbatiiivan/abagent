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
        Height = 411
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
          05B30300000D00000000000000FFFFFFFFFFFFFFFF0100000000000000000000
          0011530068006F00770020006F00720020006800690064006500200066006F00
          72006D0012530068006900660074002B004300740072006C002B0041006C0074
          002B00460031003200700BEC1800000000FFFFFFFFFFFFFFFF00000000000000
          00000000000A43006C006500610072002000640061007400610000000000FFFF
          FFFFFFFFFFFF0000000000000000000000000B42006F0073007300200068006F
          0074006B006500790000000000FFFFFFFFFFFFFFFF0000000002000000000000
          0011530068006F00770020006F00720020006800690064006500200066006F00
          72006D0000000000FFFFFFFFFFFFFFFF00000000010000000000000011530068
          006F00770020006F00720020006800690064006500200066006F0072006D0000
          000000FFFFFFFFFFFFFFFF0100000001000000000000000B4300680061006E00
          6700650020007400610062007300084300740072006C002B0054006100620040
          02EC1800000000FFFFFFFFFFFFFFFF010000000100000000000000124F007000
          65006E002000730065006C006500630074006500640020006900740065006D00
          0545006E0074006500720058D71A1900000000FFFFFFFFFFFFFFFF0100000001
          00000000000000124F00700065006E0020006900740065006D0020006C006F00
          63006100740069006F006E00064300740072006C002B004C00C8D71A19000000
          00FFFFFFFFFFFFFFFF0100000001000000000000001143007200650061007400
          6500200061002000730068006F0072007400630075007400064300740072006C
          002B004E0070AE961C00000000FFFFFFFFFFFFFFFF0100000001000000000000
          0014520065006D006F00760065002000730065006C0065006300740065006400
          20006900740065006D0003440065006C0068CC961C00000000FFFFFFFFFFFFFF
          FF010000000100000000000000214100640064002000730065006C0065006300
          74006500640020006900740065006D00200074006F002000700072006F006300
          65007300730020006C00690073007400064300740072006C002B00500070BC96
          1C00000000FFFFFFFFFFFFFFFF010000000100000000000000074E0065007700
          2000740061006200064300740072006C002B00460020EC961C00000000FFFFFF
          FFFFFFFFFF0100000001000000000000000A500072006F007000650072007400
          6900650073000941006C0074002B0045006E0074006500720028D5961CFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        GroupView = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitHeight = 411
      end
    end
  end
end
