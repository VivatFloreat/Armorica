unit fmFreeIDCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, cxControls,
  cxContainer, cxListBox, cxDBEdit;

type
  TfmSelFreeIDCard = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    grCards: TDBGrid;
    bbOk: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure grCardsDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSelFreeIDCard: TfmSelFreeIDCard;

implementation

uses dmOra;

{$R *.dfm}

procedure TfmSelFreeIDCard.FormShow(Sender: TObject);
begin
   dmOracle.quIDCardFree.Refresh;
end;

procedure TfmSelFreeIDCard.grCardsDblClick(Sender: TObject);
begin
   ModalResult := mrOk;
end;

end.
