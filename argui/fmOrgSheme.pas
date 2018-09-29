unit fmOrgSheme;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Grids, DBGrids, ExtCtrls, OracleNavigator,
  StdCtrls, Mask, DBCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, Buttons;

type
  TfmOrg_sheme = class(TForm)
    quOrg_sheme: TOracleDataSet;
    dsOrg_sheme: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    viOrgShema: TcxGridDBTableView;
    leOrgShema: TcxGridLevel;
    grOrgShema: TcxGrid;
    bbClose: TBitBtn;
    quOrg_shemeTREE_ID: TIntegerField;
    quOrg_shemeDESCRIPTION: TStringField;
    viOrgShemaTREE_ID: TcxGridDBColumn;
    viOrgShemaDESCRIPTION: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmOrg_sheme: TfmOrg_sheme;

implementation

{$R *.DFM}

procedure TfmOrg_sheme.FormCreate(Sender: TObject);
begin
   if not quOrg_Sheme.Active then
      quOrg_Sheme.Open;
end;

end.
