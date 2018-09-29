unit fmRisShif;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Grids, DBGrids, ExtCtrls, OracleNavigator,
  StdCtrls, Mask, DBCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, Buttons;

type
  TfmRis_Shif = class(TForm)
    quRIS_SHIF: TOracleDataSet;
    dsRIS_SHIF: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    viShif: TcxGridDBTableView;
    leShif: TcxGridLevel;
    grShif: TcxGrid;
    viShifSHIFT_ID: TcxGridDBColumn;
    viShifARM_OZNAKA: TcxGridDBColumn;
    viShifSHIFT_NO: TcxGridDBColumn;
    viShifDESCRIPTION: TcxGridDBColumn;
    viShifSTARTHHMM: TcxGridDBColumn;
    viShifSTOPHHMM: TcxGridDBColumn;
    viShifDURATION_MIN: TcxGridDBColumn;
    Panel3: TPanel;
    bbClose: TBitBtn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRis_Shif: TfmRis_Shif;

implementation

{$R *.DFM}

procedure TfmRis_Shif.FormCreate(Sender: TObject);
begin
   quRis_Shif.Open;
end;

end.
