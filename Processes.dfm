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
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 440
    Width = 418
    Height = 61
    Align = alBottom
    TabOrder = 0
    object Proc_BTN2: TButton
      Left = 192
      Top = 18
      Width = 100
      Height = 27
      Caption = 'Add'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object Proc_BTN3: TButton
      Left = 299
      Top = 18
      Width = 100
      Height = 27
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object Proc_BTN1: TButton
      Left = 9
      Top = 18
      Width = 100
      Height = 27
      Caption = 'Refresh'
      TabOrder = 2
      OnClick = Proc_BTN1Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 418
    Height = 440
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object ListBox1: TListBox
        Left = 0
        Top = 0
        Width = 410
        Height = 412
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = ListBox1DblClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object ProcessListView: TListView
        Left = 0
        Top = 0
        Width = 410
        Height = 412
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        Columns = <
          item
            AutoSize = True
            Caption = 'Hidding processes'
          end
          item
            Alignment = taRightJustify
            Caption = 'PID'
            Width = 100
          end>
        ColumnClick = False
        ReadOnly = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = ProcessListViewDblClick
      end
    end
  end
end
