unit fmRazDem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxSplitter, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, OracleData, ExtCtrls, cxPC, StdCtrls, Buttons,
  OracleNavigator, Menus, cxDBLookupComboBox;

type
   TAction = 1..3;

  TfmRazpDem = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    taArmCaDm: TOracleDataSet;
    taArmCaDmID: TFloatField;
    taArmCaDmMNR: TIntegerField;
    taArmCaDmDEM_ID: TFloatField;
    taArmCaDmSTATUS: TStringField;
    taArmCaDmVELJA_OD: TDateTimeField;
    taArmCaDmVELJA_DO: TDateTimeField;
    taArmCaDmCUSER: TStringField;
    taArmCaDmCREATED: TDateTimeField;
    taArmCaDmLUSER: TStringField;
    taArmCaDmLCHANGE: TDateTimeField;
    taArmCaDmDEME_NAZIV: TStringField;
    dsArmCaDm: TDataSource;
    quRisUCard: TOracleDataSet;
    dsUCard: TDataSource;
    cxSplitter1: TcxSplitter;
    taArmCaDe: TOracleDataSet;
    taArmCaDeID: TFloatField;
    taArmCaDeMNR: TIntegerField;
    taArmCaDeDEPART_ID: TFloatField;
    taArmCaDeSTATUS: TStringField;
    taArmCaDeVELJA_OD: TDateTimeField;
    taArmCaDeVELJA_DO: TDateTimeField;
    taArmCaDeCUSER: TStringField;
    taArmCaDeCREATED: TDateTimeField;
    taArmCaDeLUSER: TStringField;
    taArmCaDeLCHANGE: TDateTimeField;
    dsArmCade: TDataSource;
    taArmCaDeDEPART_NAZIV: TStringField;
    Panel4: TPanel;
    Panel5: TPanel;
    pcLeft: TcxPageControl;
    tsDM: TcxTabSheet;
    grArmCaDm: TcxGrid;
    tvArmCaDm: TcxGridDBTableView;
    tvArmCaDmID: TcxGridDBColumn;
    tvArmCaDmMNR: TcxGridDBColumn;
    tvArmCaDmDEM_ID: TcxGridDBColumn;
    tvArmCaDmDEME_NAZIV: TcxGridDBColumn;
    tvArmCaDmSTATUS: TcxGridDBColumn;
    tvArmCaDmVELJA_OD: TcxGridDBColumn;
    tvArmCaDmVELJA_DO: TcxGridDBColumn;
    leArmCaDm: TcxGridLevel;
    tsDEL: TcxTabSheet;
    grArmCaDe: TcxGrid;
    viArmCaDe: TcxGridDBTableView;
    viArmCaDeID: TcxGridDBColumn;
    viArmCaDeMNR: TcxGridDBColumn;
    viArmCaDeDEPART_ID: TcxGridDBColumn;
    viArmCaDeDEPART_NAZIV: TcxGridDBColumn;
    viArmCaDeSTATUS: TcxGridDBColumn;
    viArmCaDeVELJA_OD: TcxGridDBColumn;
    viArmCaDeVELJA_DO: TcxGridDBColumn;
    leArmCade: TcxGridLevel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    grUCard: TcxGrid;
    tvUCard: TcxGridDBTableView;
    leUCard: TcxGridLevel;
    Panel11: TPanel;
    BitBtn1: TBitBtn;
    sdExcel: TSaveDialog;
    bbExcelDM: TBitBtn;
    bbExcelDEL: TBitBtn;
    tsSHIF: TcxTabSheet;
    taArmCaSh: TOracleDataSet;
    taArmCaShID: TFloatField;
    taArmCaShMNR: TIntegerField;
    taArmCaShSHIFT_ID: TFloatField;
    taArmCaShSTATUS: TStringField;
    taArmCaShVELJA_OD: TDateTimeField;
    taArmCaShVELJA_DO: TDateTimeField;
    taArmCaShCUSER: TStringField;
    taArmCaShCREATED: TDateTimeField;
    taArmCaShLUSER: TStringField;
    taArmCaShLCHANGE: TDateTimeField;
    taArmCaShSHIFT_DESC: TStringField;
    dsArmCaSh: TDataSource;
    Panel12: TPanel;
    bbExcelSHIF: TBitBtn;
    tvArmCaSh: TcxGridDBTableView;
    leArmCaSh: TcxGridLevel;
    grArmCaSh: TcxGrid;
    taArmCaShPRIIMEK: TStringField;
    tvArmCaShMNR: TcxGridDBColumn;
    tvArmCaShPRIIMEK: TcxGridDBColumn;
    tvArmCaShSHIFT_DESC: TcxGridDBColumn;
    tvArmCaShSTATUS: TcxGridDBColumn;
    tvArmCaShVELJA_OD: TcxGridDBColumn;
    tvArmCaShVELJA_DO: TcxGridDBColumn;
    mnuPopup: TPopupMenu;
    Poveajizbrane1: TMenuItem;
    Postavivrednost1: TMenuItem;
    PreobrniIzbor1: TMenuItem;
    Izbraneprenesicopy1: TMenuItem;
    quRisUCardMNR: TIntegerField;
    quRisUCardPRIIMEKINIME: TStringField;
    quRisUCardEMPLOYED: TStringField;
    quRisUCardORG1: TIntegerField;
    quRisUCardORG2: TIntegerField;
    quRisUCardORG3: TIntegerField;
    tvUCardMNR: TcxGridDBColumn;
    tvUCardPRIIMEKINIME: TcxGridDBColumn;
    tvUCardEMPLOYED: TcxGridDBColumn;
    tvUCardORG1: TcxGridDBColumn;
    quRisUCardAKT: TIntegerField;
    tvUCardAKT: TcxGridDBColumn;
    quRisUCardDEPART: TStringField;
    tvUCardDEPART: TcxGridDBColumn;
    mnuPopupRight: TPopupMenu;
    miRazporedi: TMenuItem;
    miAddLeft: TMenuItem;
    miRemoveLeft: TMenuItem;
    N1: TMenuItem;
    taArmCaDeOE: TStringField;
    taArmCaShOE: TStringField;
    taArmCaShSHIFT_NO: TIntegerField;
    tvArmCaShSHIFT_NO: TcxGridDBColumn;
    N2: TMenuItem;
    miLookosebaDesno: TMenuItem;
    N3: TMenuItem;
    miLookOsebaLevo: TMenuItem;
    taArmCaDmPRIIMEK: TStringField;
    tvArmCaDmPRIIMEK: TcxGridDBColumn;
    taArmCaDePRIIMEK: TStringField;
    viArmCaDePRIIMEK: TcxGridDBColumn;
    taArmCaDmORG1: TIntegerField;
    tvArmCaDmORG1: TcxGridDBColumn;
    taArmCaDmOE: TStringField;
    tvArmCaDmOE: TcxGridDBColumn;
    taArmCaDeORG1: TIntegerField;
    taArmCaShORG1: TIntegerField;
    viArmCaDeORG1: TcxGridDBColumn;
    viArmCaDeOE: TcxGridDBColumn;
    tvArmCaShSHIFT_ID: TcxGridDBColumn;
    tvArmCaShORG1: TcxGridDBColumn;
    tvArmCaShOE: TcxGridDBColumn;
    procedure bbExcelDMClick(Sender: TObject);
    procedure bbExcelDELClick(Sender: TObject);
    procedure bbExcelSHIFClick(Sender: TObject);
    procedure Izbraneprenesicopy1Click(Sender: TObject);
    procedure Poveajizbrane1Click(Sender: TObject);
    procedure Postavivrednost1Click(Sender: TObject);
    procedure taArmCaDmBeforeOpen(DataSet: TDataSet);
    procedure taArmCaDeBeforeOpen(DataSet: TDataSet);
    procedure taArmCaShBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure miRazporediClick(Sender: TObject);
    procedure miAddLeftClick(Sender: TObject);
    procedure miLookosebaDesnoClick(Sender: TObject);
    procedure miLookOsebaLevoClick(Sender: TObject);
    procedure taArmCaDmAfterInsert(DataSet: TDataSet);
    procedure taArmCaDeAfterInsert(DataSet: TDataSet);
    procedure taArmCaShAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    procedure GridOperacijaLevoNaDesno(aSrcDC: TCXDBDataController; action: TAction);
    procedure GridOperacijaDesnoNaLevo(aDC: TCXDBDataController; action: TAction);
  public
    { Public declarations }
  end;

var
  fmRazpDem: TfmRazpDem;

implementation

uses fmRazOpt, cxGridExportLink, dmOra, appRegistry, ResStrings,
  fmEmpDetail;

{$R *.dfm}

procedure TfmRazpDem.bbExcelDMClick(Sender: TObject);
begin
   sdExcel.FileName := 'RazpDM.xls';
   if sdExcel.Execute then begin
      ExportGridToExcel(sdExcel.FileName, grArmCaDm);
   end;
end;

procedure TfmRazpDem.bbExcelDELClick(Sender: TObject);
begin
   sdExcel.FileName := 'RazpDEL.xls';
   if sdExcel.Execute then begin
      ExportGridToExcel(sdExcel.FileName, grArmCaDe);
   end;
end;

procedure TfmRazpDem.bbExcelSHIFClick(Sender: TObject);
begin
   sdExcel.FileName := 'RazpSHIF.xls';
   if sdExcel.Execute then begin
      ExportGridToExcel(sdExcel.FileName, grArmCaSh);
   end;
end;


procedure TfmRazpDem.GridOperacijaDesnoNaLevo(aDC: TCXDBDataController; action: TAction);
var
   i, iSel: integer;
   rIndx: integer;
   aRowInfo: TcxRowInfo;
   f_mnr: integer;

   procedure SelectByMNR(aMNR: integer; aSelected: boolean; aClear: boolean);
   var aView: TCXGridDBTableView;
   begin
      case pcLeft.ActivePageIndex of
         0: aView := tvArmCaDm;
         1: aView := viArmCaDe;
      else
         aView := tvArmCaSh;
      end;


      if aClear then
         aView.DataController.ClearSelection;

      with aView.DataController do begin
         if DataSet.Locate('MNR', VarArrayOf([aMNR]), []) then begin
            aView.Controller.FocusedRow.Selected := aSelected;
         end;
      end;
   end;

begin
   with adc do begin
      iSel:=GetSelectedCount;
      for i := 0 to iSel-1 do begin
         rIndx := GetSelectedRowIndex(i);
         aRowInfo := aDC.GetRowInfo(rIndx);
         //if aRowInfo.Level >= Groups.GroupingItemCount then begin
            ChangeFocusedRowIndex(rIndx);
            // do some work
            f_mnr := DataSet.FieldByName('MNR').Value;
            case action of
               1:
                  SelectByMNR(f_mnr, true, true);
               2:
                  SelectByMNR(f_mnr, true, false);
               3:
                  SelectByMNR(f_mnr, false, false);
            end;

         //end;
      end;
   end;
end;

procedure TfmRazpDem.GridOperacijaLevoNaDesno(aSrcDC: TCXDBDataController; action: TAction);
var
   i, iSel: integer;
   rIndx: integer;
   aRowInfo: TcxRowInfo;
   f_mnr: integer;

   procedure SelectByMNR(aMNR: integer; aSelected: boolean; aClear: boolean);
   begin
      if aClear then
         tvUCard.DataController.ClearSelection;

      with tvUCard.DataController do begin
         if DataSet.Locate('MNR', VarArrayOf([aMNR]), []) then begin
            tvUCard.Controller.FocusedRow.Selected := aSelected;
         end;
      end;
   end;


begin
   with aSrcDC do begin
      iSel:=GetSelectedCount;
      for i := 0 to iSel-1 do begin
         rIndx := GetSelectedRowIndex(i);
         aRowInfo := asrcDC.GetRowInfo(rIndx);
         //if aRowInfo.Level >= Groups.GroupingItemCount then begin
            ChangeFocusedRowIndex(rIndx);
            // do some work
            f_mnr := DataSet.FieldByName('MNR').Value;
            case action of
               1:
                  SelectByMNR(f_mnr, true, true);
               2:
                  SelectByMNR(f_mnr, true, false);
               3:
                  SelectByMNR(f_mnr, false, false);
            end;

         //end;
      end;
   end;
end;


procedure TfmRazpDem.Izbraneprenesicopy1Click(Sender: TObject);
begin
   if fmRazpDem.tvArmCaDm.Focused then
      GridOperacijaDesnoNaLevo (tvArmCaDm.DataController, 1);

   if fmRazpDem.viArmCaDe.Focused then
      GridOperacijaDesnoNaLevo (viArmCaDe.DataController, 1);

   if fmRazpDem.tvArmCaSh.Focused then
      GridOperacijaDesnoNaLevo (tvArmCaSh.DataController, 1);
end;

procedure TfmRazpDem.Poveajizbrane1Click(Sender: TObject);
begin
   case pcLeft.ActivePageIndex of
      0: GridOperacijaLevoNaDesno (tvArmCaDm.DataController, 2);
      1: GridOperacijaLevoNaDesno (viArmCaDe.DataController, 2);
      2: GridOperacijaLevoNaDesno (tvArmCaSh.DataController, 2);
   end;
end;

procedure TfmRazpDem.Postavivrednost1Click(Sender: TObject);
begin
   case pcLeft.ActivePageIndex of
      0: GridOperacijaLevoNaDesno (tvArmCaDm.DataController, 3);
      1: GridOperacijaLevoNaDesno (viArmCaDe.DataController, 3);
      2: GridOperacijaLevoNaDesno (tvArmCaSh.DataController, 3);
   end;
end;

procedure TfmRazpDem.taArmCaDmBeforeOpen(DataSet: TDataSet);
begin
   taArmCaDm.SetVariable('P_TREE_ID', dmOracle.paramTreeIdUcard);
end;

procedure TfmRazpDem.taArmCaDeBeforeOpen(DataSet: TDataSet);
begin
   taArmCaDe.SetVariable('P_TREE_ID', dmOracle.paramTreeIdUcard);
end;

procedure TfmRazpDem.taArmCaShBeforeOpen(DataSet: TDataSet);
begin
   taArmCaSh.SetVariable('P_TREE_ID', dmOracle.paramTreeIdUcard);
end;

procedure TfmRazpDem.FormCreate(Sender: TObject);
begin
   taArmCaDm.Open;
   taArmCade.Open;
   taArmCash.Open;
   quRisUCard.Open;
end;

procedure TfmRazpDem.FormClose(Sender: TObject; var Action: TCloseAction);
var
   aRegistry: tAppRegistry;
begin
   aRegistry := tAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.SaveGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmRazpDem.Name, tvArmCaDm);
   aRegistry.SaveGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmRazpDem.Name, viArmCaDe);
   aRegistry.SaveGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmRazpDem.Name, tvArmCaSh);
   aRegistry.SaveGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmRazpDem.Name, tvUCard);
   aRegistry.Free;
end;

procedure TfmRazpDem.FormShow(Sender: TObject);
var
   aRegistry: tAppRegistry;
begin
   aRegistry := tAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.RestoreGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmRazpDem.Name, tvArmCaDm);
   aRegistry.RestoreGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmRazpDem.Name, viArmCaDe);
   aRegistry.RestoreGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmRazpDem.Name, tvArmCaSh);
   aRegistry.RestoreGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmRazpDem.Name, tvUCard);
   aRegistry.Free;
end;

procedure TfmRazpDem.miRazporediClick(Sender: TObject);
begin
   fmRazpOpt := TfmRazpOpt.Create(self);
   fmRazpOpt.ShowModal;
   fmRazpOpt.Destroy;
   taArmCadm.Refresh;
   taArmCaDe.Refresh;
   taArmCaSh.Refresh;
end;

procedure TfmRazpDem.miAddLeftClick(Sender: TObject);
begin
   GridOperacijaDesnoNaLevo (tvUCard.DataController, 2);
end;

procedure TfmRazpDem.miLookosebaDesnoClick(Sender: TObject);
begin
   fmEmpDet := tFmEmpDet.Create(self);
   fmEmpDet.taRisCard.Close;
   fmEmpDet.taRisCard.Master := quRisUcard;
   fmEmpDet.taRisCard.Open;
   fmEmpDet.DisableEnableNavButtons (false);
   fmEmpDet.pcEmployee.activePage := fmEmpDet.tsRazporeditve;
   fmEmpDet.ShowModal;
   fmEmpDet.Destroy;
end;

procedure TfmRazpDem.miLookOsebaLevoClick(Sender: TObject);
begin
   fmEmpDet := tFmEmpDet.Create(self);
   fmEmpDet.taRisCard.Close;

   case pcLeft.ActivePageIndex of
      0: fmEmpDet.taRisCard.Master := taArmCaDm;
      1: fmEmpDet.taRisCard.Master := taArmCaDe;
   else
      fmEmpDet.taRisCard.Master := taArmCaSh;
   end;

   fmEmpDet.taRisCard.Open;
   fmEmpDet.DisableEnableNavButtons (false);
   fmEmpDet.pcEmployee.activePage := fmEmpDet.tsRazporeditve;
   fmEmpDet.ShowModal;
   fmEmpDet.Destroy;

end;

procedure TfmRazpDem.taArmCaDmAfterInsert(DataSet: TDataSet);
begin
   if taArmCaDmVELJA_OD.Value <= 0 then
      taArmCaDmVELJA_OD.Value := dmOracle.paramDateRazpFrom;
end;

procedure TfmRazpDem.taArmCaDeAfterInsert(DataSet: TDataSet);
begin
   if taArmCaDeVELJA_OD.Value <= 0 then
      taArmCaDeVELJA_OD.Value := dmOracle.paramDateRazpFrom;
end;

procedure TfmRazpDem.taArmCaShAfterInsert(DataSet: TDataSet);
begin
   if taArmCaShVELJA_OD.Value <= 0 then
      taArmCaShVELJA_OD.Value := dmOracle.paramDateRazpFrom;
end;

end.
