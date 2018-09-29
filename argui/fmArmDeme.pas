unit fmArmDeme;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Grids, DBGrids, ExtCtrls, OracleNavigator,
  StdCtrls, Mask, DBCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, Buttons;

type
  TfmArm_Deme = class(TForm)
    quARM_DEME: TOracleDataSet;
    dsARM_DEME: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    viDeMe: TcxGridDBTableView;
    leDeMe: TcxGridLevel;
    grDeMe: TcxGrid;
    viDeMeID: TcxGridDBColumn;
    viDeMeSIFRA: TcxGridDBColumn;
    viDeMeNAZIV: TcxGridDBColumn;
    bbClose: TBitBtn;
    viDeMeARM_OZNAKA: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmArm_Deme: TfmArm_Deme;

implementation

{$R *.DFM}

procedure TfmArm_Deme.FormCreate(Sender: TObject);
begin
   quArm_Deme.Open;
end;

end.
