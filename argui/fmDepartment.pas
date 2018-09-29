unit fmDepartment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DBCtrls, Mask;

type
  TfmDepart2 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bbCancel: TBitBtn;
    bbSave: TBitBtn;
    Label4: TLabel;
    edSifra: TDBEdit;
    edOpis: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    cbTipOE: TDBLookupComboBox;
    procedure bbSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDepart2: TfmDepart2;

implementation

uses fmdepart;

{$R *.dfm}

procedure TfmDepart2.bbSaveClick(Sender: TObject);
begin
  fmDepa.sbSave.OnClick(nil);
end;

end.
