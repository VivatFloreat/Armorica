unit fmRisDepa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Grids, DBGrids, ExtCtrls, OracleNavigator,
  StdCtrls, Mask, DBCtrls, RXDBCtrl, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, cxCalendar, RXSplit, Buttons, cxTL,
  cxInplaceContainer, cxTLData, cxDBTL, ComCtrls, dxtree, dxdbtree, Menus;

type
  TfmRis_Depa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    quArmDeme: TOracleDataSet;
    quArmDedm: TOracleDataSet;
    dsArmDeDm: TDataSource;
    quArmDedmID: TFloatField;
    quArmDedmDEPART_ID: TFloatField;
    quArmDedmVELJA_OD: TDateTimeField;
    quArmDedmVELJA_DO: TDateTimeField;
    quArmDedmDEME_NAZIV: TStringField;
    quArmDedmDEM_ID: TFloatField;
    quArmDemeID: TFloatField;
    quArmDemeSIFRA: TStringField;
    quArmDemeNAZIV: TStringField;
    RxSplitter1: TRxSplitter;
    tvDelovisca: TdxDBTreeView;
    dsArmDeMe: TDataSource;
    Panel7: TPanel;
    bbClose: TBitBtn;
    Panel8: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    grDeDm: TcxGrid;
    viDeDm: TcxGridDBTableView;
    viDeDmDEM_ID: TcxGridDBColumn;
    viDeDmDEME_NAZIV: TcxGridDBColumn;
    viDeDmVELJA_OD: TcxGridDBColumn;
    viDeDmVELJA_DO: TcxGridDBColumn;
    leDeDm: TcxGridLevel;
    RxSplitter2: TRxSplitter;
    Panel5: TPanel;
    Panel6: TPanel;
    grDeMe: TcxGrid;
    viDeMe: TcxGridDBTableView;
    viDeMeID: TcxGridDBColumn;
    viDeMeSIFRA: TcxGridDBColumn;
    viDeMeNAZIV: TcxGridDBColumn;
    leDeMe: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure quArmDedmAfterInsert(DataSet: TDataSet);
    procedure viDeMeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRis_Depa: TfmRis_Depa;

implementation

uses dmOra, fmRazDemOpt;

{$R *.DFM}

procedure TfmRis_Depa.FormCreate(Sender: TObject);
begin
   // zagotovi osveževanje
   dmOracle.quDelovisca.Close;
   dmOracle.quDelovisca.Open;
   quArmDeme.Open;
   quArmDeDm.Open;
end;

procedure TfmRis_Depa.quArmDedmAfterInsert(DataSet: TDataSet);
begin
   if (quArmDeDmVELJA_OD.Value <= 0)  then
      quArmDeDmVELJA_OD.Value := dmOracle.paramDateRazpFrom;
end;

procedure TfmRis_Depa.viDeMeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if Button = mbRight then begin
      fmRazpDemOpt := tFmRazpDemOpt.Create(self);
      fmRazpDemOpt.ShowModal;
      fmRazpDemOpt.Destroy;
   end;
end;

end.
