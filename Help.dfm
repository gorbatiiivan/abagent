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
  ShowHint = True
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
        Height = 91
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
      object Label5: TLabel
        Left = 368
        Top = 325
        Width = 241
        Height = 13
        Cursor = crHandPoint
        Hint = 'https://abagent.sourceforge.io/'
        AutoSize = False
        Caption = 'ABAgent on the SourceForge.net'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = Label5Click
      end
      object Label6: TLabel
        Left = 368
        Top = 248
        Width = 241
        Height = 71
        AutoSize = False
        Caption = 'Label6'
        Layout = tlBottom
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
            Header = 'Log'
            GroupID = 1
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
            GroupID = 3
            State = [lgsNormal]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end>
        Items.ItemData = {
          05B30400001000000000000000FFFFFFFFFFFFFFFF0100000000000000000000
          0011530068006F00770020006F00720020006800690064006500200066006F00
          72006D0012530068006900660074002B004300740072006C002B0041006C0074
          002B004600310032007017D12600000000FFFFFFFFFFFFFFFF00000000000000
          00000000000A43006C006500610072002000640061007400610000000000FFFF
          FFFFFFFFFFFF0000000000000000000000000B42006F0073007300200068006F
          0074006B006500790000000000FFFFFFFFFFFFFFFF0000000001000000000000
          0011530068006F00770020006F00720020006800690064006500200066006F00
          72006D0000000000FFFFFFFFFFFFFFFF00000000020000000000000011530068
          006F00770020006F00720020006800690064006500200066006F0072006D0000
          000000FFFFFFFFFFFFFFFF00000000030000000000000011530068006F007700
          20006F00720020006800690064006500200066006F0072006D0000000000FFFF
          FFFFFFFFFFFF0100000003000000000000000B4300680061006E006700650020
          007400610062007300084300740072006C002B0054006100620068FDD0260000
          0000FFFFFFFFFFFFFFFF010000000300000000000000124F00700065006E0020
          00730065006C006500630074006500640020006900740065006D000545006E00
          74006500720000F4D02600000000FFFFFFFFFFFFFFFF01000000030000000000
          0000124F00700065006E0020006900740065006D0020006C006F006300610074
          0069006F006E00064300740072006C002B004C006804D12600000000FFFFFFFF
          FFFFFFFF0100000003000000000000001B430072006500610074006500200061
          002000730068006F00720074006300750074002000660072006F006D00200066
          0069006C006500064300740072006C002B004E00D80BD12600000000FFFFFFFF
          FFFFFFFF0100000003000000000000001D430072006500610074006500200061
          002000730068006F0072007400630075007400200066006F0072006D00200066
          006F006C00640065007200064300740072006C002B004400B023D12600000000
          FFFFFFFFFFFFFFFF01000000030000000000000014520065006D006F00760065
          002000730065006C006500630074006500640020006900740065006D00034400
          65006C00D029D12600000000FFFFFFFFFFFFFFFF010000000300000000000000
          214100640064002000730065006C006500630074006500640020006900740065
          006D00200074006F002000700072006F00630065007300730020006C00690073
          007400064300740072006C002B0050009806D12600000000FFFFFFFFFFFFFFFF
          0100000003000000000000000E410064006400200074006F00200074006F006F
          006C00620061007200064300740072006C002B005400581DD12600000000FFFF
          FFFFFFFFFFFF010000000300000000000000074E006500770020007400610062
          00064300740072006C002B004600101AD12600000000FFFFFFFFFFFFFFFF0100
          000003000000000000000A500072006F00700065007200740069006500730009
          41006C0074002B0045006E00740065007200582BD126FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFF}
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
    object TabSheet4: TTabSheet
      Caption = 'License'
      ImageIndex = 3
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 627
        Height = 413
        Align = alClient
        Alignment = taCenter
        Lines.Strings = (
          'MIT License'
          ''
          'Copyright (c) 2024-2025 G. Ivan'
          ''
          
            'Permission is hereby granted, free of charge, to any person obta' +
            'ining a copy'
          
            'of this software and associated documentation files (the "Softwa' +
            're"), to deal'
          
            'in the Software without restriction, including without limitatio' +
            'n the rights'
          
            'to use, copy, modify, merge, publish, distribute, sublicense, an' +
            'd/or sell'
          
            'copies of the Software, and to permit persons to whom the Softwa' +
            're is'
          'furnished to do so, subject to the following conditions:'
          ''
          
            'The above copyright notice and this permission notice shall be i' +
            'ncluded in all'
          'copies or substantial portions of the Software.'
          ''
          
            'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, ' +
            'EXPRESS OR'
          
            'IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT' +
            'ABILITY,'
          
            'FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVEN' +
            'T SHALL THE'
          
            'AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR' +
            ' OTHER'
          
            'LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ' +
            'ARISING FROM,'
          
            'OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DE' +
            'ALINGS IN THE'
          'SOFTWARE.')
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
end
