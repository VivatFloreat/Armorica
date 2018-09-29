unit fmEmp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, OracleData, dmOra, ComCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, OracleNavigator,
  ExtCtrls, StdCtrls, Buttons, cxNavigator, cxDBNavigator, DBCtrls;

type
  TfmEmployee = class(TForm)
    dsRisUCard: TDataSource;
    Panel1: TPanel;
    grRisUCard: TcxGrid;
    tvRisCard: TcxGridDBTableView;
    lvRisCard: TcxGridLevel;
    Panel2: TPanel;
    bbDetails: TBitBtn;
    tvRisCardMNR: TcxGridDBColumn;
    tvRisCardLNAME: TcxGridDBColumn;
    tvRisCardFNAME: TcxGridDBColumn;
    tvRisCardEMPLOYED: TcxGridDBColumn;
    tvRisCardCARD_NO: TcxGridDBColumn;
    tvRisCardORG1: TcxGridDBColumn;
    tvRisCardORG2: TcxGridDBColumn;
    tvRisCardORG3: TcxGridDBColumn;
    bbNew: TBitBtn;
    tvRisCardAKT: TcxGridDBColumn;
    tvRisCardOPISODDELKA: TcxGridDBColumn;
    procedure bbDetailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tvRisCardCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure bbNewClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    dbFilters: TcxDBDataFilterCriteria;
    procedure CreateFilters;
  public
    { Public declarations }
  end;

var
  fmEmployee: TfmEmployee;

implementation

uses fmEmpDetail, AppRegistry, ResStrings;

{$R *.dfm}

procedure TfmEmployee.bbDetailsClick(Sender: TObject);
begin
   fmEmpDet := TfmEmpDet.Create (self);
   fmEmpDet.ShowModal;
   fmEmpDet.Destroy;
end;

procedure TfmEmployee.FormCreate(Sender: TObject);
begin
   //dmOracle.quRisCard.Open;
   if not dmOracle.quRisUCard.Active then
      dmOracle.quRisUCard.Open;
end;

procedure TfmEmployee.CreateFilters;
begin
   with tvRisCard.DataController.Filter.Root do begin
      Clear;
      BoolOperatorKind := fboAnd;
      AddItem(tvRisCardEMPLOYED, foEqual, 'RED', 'RED');
      AddItem(tvRisCardAKT, foEqual, 1, '1');
   end;
   tvRisCard.DataController.Filter.Active := True;
end;

procedure TfmEmployee.tvRisCardCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
   bbDetailsClick(Sender);
end;

procedure TfmEmployee.bbNewClick(Sender: TObject);
begin
   fmEmpDet := TfmEmpDet.Create (self);
   fmEmpDet.taRisCard.Insert;
   fmEmpDet.ShowModal;
   fmEmpDet.Destroy;
end;

procedure TfmEmployee.FormClose(Sender: TObject; var Action: TCloseAction);
var
   aRegistry: tAppRegistry;
begin
   aRegistry := tAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.SaveGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmEmployee.Name, tvRisCard);
   aRegistry.Free;
end;

procedure TfmEmployee.FormShow(Sender: TObject);
var
   aRegistry: tAppRegistry;
begin
   aRegistry := tAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.RestoreGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmEmployee.Name, tvRisCard);
   aRegistry.Free;
end;

end.
