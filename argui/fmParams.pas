unit fmParams;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, OracleData, Grids, DBGrids, ExtCtrls, OracleNavigator,
  StdCtrls, Mask, DBCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, Buttons, cxCalendar;

type
  TfmParam = class(TForm)
    quParams: TOracleDataSet;
    dsParams: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    viParams: TcxGridDBTableView;
    leParams: TcxGridLevel;
    grParams: TcxGrid;
    viParamsPNAME: TcxGridDBColumn;
    viParamsD_VALUE: TcxGridDBColumn;
    viParamsN_VALUE: TcxGridDBColumn;
    viParamsV_VALUE: TcxGridDBColumn;
    viParamsIS_VALUE: TcxGridDBColumn;
    viParamsDESCRIPTION: TcxGridDBColumn;
    Panel3: TPanel;
    bbClose: TBitBtn;
    bbInit: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure bbInitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmParam: TfmParam;

implementation

{$R *.DFM}

uses variants, dmOra;

procedure TfmParam.FormCreate(Sender: TObject);
begin
   if not quParams.Active then
      quParams.Open;
end;

procedure TfmParam.bbInitClick(Sender: TObject);
   procedure insPara (pname, desc:string; dvalue: tDate; nvalue: variant);
   begin
      quParams.Insert;
      quParams.FieldByName('PNAME').AsString := pname;
      quParams.FieldByName('DESCRIPTION').AsString := desc;

      if dvalue <> 0 then
         quParams.FieldByName('D_VALUE').AsDateTime := dvalue;

      if (nvalue <> null) then
         quParams.FieldByName('N_VALUE').AsInteger := nvalue;
      quParams.Post;
   end;

begin
   if not quParams.Locate('PNAME',
                          VarArrayOf([C_PARAM_ARM_RAZP_DATE_FROM]),
                          [loCaseInsensitive]) then
      insPara(C_PARAM_ARM_RAZP_DATE_FROM,
              'Privzeti datum razporeditve - od',
               Date,
               null);

   if not quParams.Locate('PNAME',
                          VarArrayOf([C_PARAM_ARM_UCARD_TREE_ID]),
                          [loCaseInsensitive]) then
      insPara(C_PARAM_ARM_UCARD_TREE_ID,
              'ID drevesa, iz katerega izhaja vidnost osebja',
               0,
               1);

   if not quParams.Locate('PNAME',
                          VarArrayOf([C_PARAM_ARM_DELOVISCA_TREE_ID]),
                          [loCaseInsensitive]) then
      insPara(C_PARAM_ARM_DELOVISCA_TREE_ID,
              'ID drevesa, v katerem se nahajajo delovišèa',
               0,
               1);
end;

end.
