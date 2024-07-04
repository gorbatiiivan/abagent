unit LNK_Action;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList, CommCtrl, ShellAPI, System.ImageList;

type
  TLNK_ActionForm = class(TForm)
    Label1: TLabel;
    ComboBoxEx: TComboBoxEx;
    Button1: TButton;
    Button2: TButton;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
  private
    { Public declarations }
  public
    procedure PathCombo;
  end;

var
  LNK_ActionForm: TLNK_ActionForm;

implementation

uses lnkForm, LNK_Utils;

{$R *.dfm}

procedure TLNK_ActionForm.PathCombo;
var
 InsertItem: TComboExItem;
 i: integer;
begin
ComboBoxEx.Items.Clear;
for I := 0 to lnk_Form.Tabs.Tabs.Count - 1 do
  begin
    InsertItem := ComboBoxEx.ItemsEx.Add;
    InsertItem.Caption := lnk_Form.Tabs.Tabs[I];
    InsertItem.ImageIndex :=GetIconIndex('', FILE_ATTRIBUTE_NORMAL);
  end;
end;

procedure TLNK_ActionForm.FormCreate(Sender: TObject);
var
 SysImageList:uint;
 SFI:TSHFileInfo;
begin
ImageList1.Handle:=SHGetFileInfo('',0,SFI,SizeOf(TSHFileInfo),SHGFI_SMALLICON or SHGFI_SYSICONINDEX);
SendMessage(ComboBoxEx.Handle, LVM_SETIMAGELIST, LVSIL_SMALL, ImageList1.Handle);
end;

end.
