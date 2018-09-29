unit fmEmpDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dmOra, cxControls, cxContainer, cxEdit, cxTextEdit, cxDBEdit,
  ExtCtrls, StdCtrls, OracleNavigator, DB, cxPC, cxMaskEdit,
  cxDropDownEdit, cxCalendar, OracleData, cxCheckBox, Buttons, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxDBData,
  cxSplitter, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Mask,
  DBCtrls, cxImage, cxBlobEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, RxLookup, Grids, DBGrids, ToolEdit, RXDBCtrl, ExtDlgs;

type
  TfmEmpDet = class(TForm)
    Panel1: TPanel;
    edMNR: TcxDBTextEdit;
    dsRisUCard: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    pcEmployee: TcxPageControl;
    tsOsnop: TcxTabSheet;
    tsRazporeditve: TcxTabSheet;
    taRisCard: TOracleDataSet;
    taRisCardMNR: TIntegerField;
    taRisCardRNAME: TStringField;
    taRisCardCARD_NO: TFloatField;
    taRisCardAKT: TIntegerField;
    taRisCardTURNUS: TStringField;
    taRisCardLNAME: TStringField;
    taRisCardDEPART: TStringField;
    taRisCardORG1: TIntegerField;
    taRisCardORG2: TIntegerField;
    taRisCardHOME_TEL: TStringField;
    taRisCardORG3: TIntegerField;
    taRisCardFEMALE: TStringField;
    taRisCardFNAME: TStringField;
    taRisCardBDATE: TDateTimeField;
    taRisCardEMSO: TStringField;
    taRisCardDAVCNA: TFloatField;
    taRisCardIN_DATE: TDateTimeField;
    taRisCardOUT_DATE: TDateTimeField;
    taRisCardEMPLOYED: TStringField;
    taRisCardLEDITYYMM: TDateTimeField;
    taRisCardWORK_TEL: TStringField;
    taRisCardHOME_ADDR: TStringField;
    taRisCardLCHANGE: TDateTimeField;
    taRisCardLUSER: TStringField;
    taRisCardEMAIL: TStringField;
    taRisCardHAS_SALARY: TStringField;
    taRisCardBONAKT: TStringField;
    taRisCardBONDODATEK: TStringField;
    taRisCardBONSORT: TIntegerField;
    taRisCardSUBGROUP: TIntegerField;
    taRisCardMNR_NADREJENI: TIntegerField;
    taRisCardMNR_NADREJENI2: TIntegerField;
    taRisCardWORK_LOCA: TStringField;
    taRisCardWORK_ADDR: TStringField;
    taRisCardMNR_SKRBNIK: TIntegerField;
    taRisCardMNR_SKRBNIK2: TIntegerField;
    dsRisCard: TDataSource;
    cbAkt: TcxDBCheckBox;
    edPriimek: TcxDBTextEdit;
    edIme: TcxDBTextEdit;
    Label4: TLabel;
    edIPN: TcxDBTextEdit;
    Label6: TLabel;
    Panel2: TPanel;
    bbSave: TBitBtn;
    bbCancel: TBitBtn;
    Panel3: TPanel;
    taArmCaDm: TOracleDataSet;
    dsArmCaDm: TDataSource;
    Panel5: TPanel;
    cxSplitter1: TcxSplitter;
    taArmCaDmID: TFloatField;
    taArmCaDmDEM_ID: TFloatField;
    taArmCaDmSTATUS: TStringField;
    taArmCaDmVELJA_OD: TDateTimeField;
    taArmCaDmVELJA_DO: TDateTimeField;
    taArmCaDmCUSER: TStringField;
    taArmCaDmCREATED: TDateTimeField;
    taArmCaDmLUSER: TStringField;
    taArmCaDmLCHANGE: TDateTimeField;
    taArmCaDmDEM_NAZIV: TStringField;
    dsArmDeme: TDataSource;
    Panel7: TPanel;
    grCaDm: TcxGrid;
    tvCaDm: TcxGridDBTableView;
    tvCaDmID: TcxGridDBColumn;
    tvCaDmMNR: TcxGridDBColumn;
    tvCaDmDEM_ID: TcxGridDBColumn;
    tvCaDmDEM_NAZIV: TcxGridDBColumn;
    tvCaDmSTATUS: TcxGridDBColumn;
    tvCaDmVELJA_OD: TcxGridDBColumn;
    tvCaDmVELJA_DO: TcxGridDBColumn;
    tvCaDmCUSER: TcxGridDBColumn;
    tvCaDmCREATED: TcxGridDBColumn;
    tvCaDmLUSER: TcxGridDBColumn;
    tvCaDmLCHANGE: TcxGridDBColumn;
    leCaDm: TcxGridLevel;
    Panel4: TPanel;
    cxSplitter2: TcxSplitter;
    Panel9: TPanel;
    taArmCaDe: TOracleDataSet;
    dsArmCaDe: TDataSource;
    tvCaDe: TcxGridDBTableView;
    leCaDe: TcxGridLevel;
    grCaDe: TcxGrid;
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
    taArmCaDeDEPART: TStringField;
    taArmCaDeDEPART_DESC: TStringField;
    tvCaDeID: TcxGridDBColumn;
    tvCaDeMNR: TcxGridDBColumn;
    tvCaDeDEPART_ID: TcxGridDBColumn;
    tvCaDeDEPART: TcxGridDBColumn;
    tvCaDeDEPART_DESC: TcxGridDBColumn;
    tvCaDeSTATUS: TcxGridDBColumn;
    tvCaDeVELJA_OD: TcxGridDBColumn;
    tvCaDeVELJA_DO: TcxGridDBColumn;
    tvCaDeCUSER: TcxGridDBColumn;
    tvCaDeCREATED: TcxGridDBColumn;
    tvCaDeLUSER: TcxGridDBColumn;
    tvCaDeLCHANGE: TcxGridDBColumn;
    taArmCash: TOracleDataSet;
    taArmCashID: TFloatField;
    taArmCashMNR: TIntegerField;
    taArmCaShSTATUS: TStringField;
    taArmCashVELJA_OD: TDateTimeField;
    taArmCaShVELJA_DO: TDateTimeField;
    taArmCaShCUSER: TStringField;
    taArmCaShCREATED: TDateTimeField;
    taArmCaShLUSER: TStringField;
    taArmCaShLCHANGE: TDateTimeField;
    taArmCashSHIFT_ID: TFloatField;
    Panel10: TPanel;
    grCaSh: TcxGrid;
    tvCaSh: TcxGridDBTableView;
    leCaSh: TcxGridLevel;
    dsCaSh: TDataSource;
    tvCaShSTATUS: TcxGridDBColumn;
    tvCaShVELJA_OD: TcxGridDBColumn;
    tvCaShVELJA_DO: TcxGridDBColumn;
    taArmCashSHIFT_DESCRIPTION: TStringField;
    tvCaShSHIFT_DESCRIPTION: TcxGridDBColumn;
    Label7: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edEMSO: TDBEdit;
    Label14: TLabel;
    edDavcna: TDBEdit;
    Label16: TLabel;
    Label21: TLabel;
    edPlaca: TDBEdit;
    dsRisCaPic: TDataSource;
    taRisCapic: TOracleDataSet;
    taRisCapicMNR: TIntegerField;
    taRisCapicIME: TStringField;
    taRisCapicSMALL_PICTURE: TBlobField;
    tsOE: TcxTabSheet;
    tsEDC: TcxTabSheet;
    tsPK: TcxTabSheet;
    tsMalica: TcxTabSheet;
    tsStanja: TcxTabSheet;
    tsAdmins: TcxTabSheet;
    tsOstalo: TcxTabSheet;
    Panel13: TPanel;
    Label5: TLabel;
    cxDBTextEdit1: TcxDBTextEdit;
    Panel12: TPanel;
    Label8: TLabel;
    DBEdit2: TDBEdit;
    Label9: TLabel;
    DBEdit3: TDBEdit;
    Label10: TLabel;
    DBEdit4: TDBEdit;
    Label24: TLabel;
    DBEdit18: TDBEdit;
    Label22: TLabel;
    DBEdit16: TDBEdit;
    Label23: TLabel;
    DBEdit17: TDBEdit;
    cbSpol: TRxDBLookupCombo;
    ImageRO: TcxDBImage;
    edBirthDate: TDBDateEdit;
    Label17: TLabel;
    cbEmployed: TRxDBLookupCombo;
    Label15: TLabel;
    edInDate: TDBDateEdit;
    edOutDate: TDBDateEdit;
    edCardNo: TRxDBComboEdit;
    bbNext: TBitBtn;
    bbPrev: TBitBtn;
    bbFirst: TBitBtn;
    bbLast: TBitBtn;
    Panel14: TPanel;
    Label29: TLabel;
    edNadrejeniMNR: TDBEdit;
    Label30: TLabel;
    edNadrejeni2MNR: TDBEdit;
    Label31: TLabel;
    edSkrbnikMNR: TDBEdit;
    Label32: TLabel;
    edSkrbnik2MNR: TDBEdit;
    cbNadrejeni: TRxDBLookupCombo;
    dsLOVRisUCard: TDataSource;
    cbNadrejeni2: TRxDBLookupCombo;
    cbSkrbnik: TRxDBLookupCombo;
    cbSkrbnik2: TRxDBLookupCombo;
    quRisCaDe: TOracleDataSet;
    quRisCaDeMNR: TIntegerField;
    quRisCaDeDEPART_ID: TIntegerField;
    quRisCaDeDEPART: TStringField;
    quRisCaDeDEPART_DESC: TStringField;
    quRisCaDeTREE_DESC: TStringField;
    viDepart: TcxGridDBTableView;
    leDepart: TcxGridLevel;
    grDepart: TcxGrid;
    dsDepart: TDataSource;
    quRisCaDeTREE_ID: TIntegerField;
    viDepartMNR: TcxGridDBColumn;
    viDepartDEPART_ID: TcxGridDBColumn;
    viDepartDEPART: TcxGridDBColumn;
    viDepartDEPART_DESC: TcxGridDBColumn;
    viDepartTREE_DESC: TcxGridDBColumn;
    Panel15: TPanel;
    dbImage: TcxDBImage;
    Slika: TLabel;
    Label19: TLabel;
    DBEdit13: TDBEdit;
    Label11: TLabel;
    DBEdit5: TDBEdit;
    Label20: TLabel;
    DBEdit14: TDBEdit;
    Label25: TLabel;
    DBEdit19: TDBEdit;
    Label18: TLabel;
    DBEdit12: TDBEdit;
    DBText1: TDBText;
    bbLoadFromFile: TBitBtn;
    bbDelete: TBitBtn;
    Panel16: TPanel;
    bbDeleteCard: TBitBtn;
    taRisUsrc: TOracleDataSet;
    taRisUsrcMNR: TIntegerField;
    taRisUsrcRIS_USER: TStringField;
    taRisUsrcCH_ALLOWED: TStringField;
    dsRisUsRc: TDataSource;
    viRisUsRc: TcxGridDBTableView;
    leRisUsRc: TcxGridLevel;
    grRisUsRc: TcxGrid;
    taRisUsrcADMIN: TStringField;
    viRisUsRcMNR: TcxGridDBColumn;
    viRisUsRcADMIN: TcxGridDBColumn;
    viRisUsRcCH_ALLOWED: TcxGridDBColumn;
    taArmCaDmMNR: TIntegerField;
    gbDirectFind: TGroupBox;
    edAllMNR: TEdit;
    Label26: TLabel;
    bbFind: TBitBtn;
    cbFindDirect: TCheckBox;
    procedure bbSaveClick(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
    procedure dsRisCardDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dsRisCardStateChange(Sender: TObject);
    procedure edCardNoButtonClick(Sender: TObject);
    procedure bbPrevClick(Sender: TObject);
    procedure bbNextClick(Sender: TObject);
    procedure bbFirstClick(Sender: TObject);
    procedure bbLastClick(Sender: TObject);
    procedure taRisCapicAfterInsert(DataSet: TDataSet);
    procedure bbLoadFromFileClick(Sender: TObject);
    procedure bbDeleteClick(Sender: TObject);
    procedure taRisCapicAfterRefresh(DataSet: TDataSet);
    procedure bbDeleteCardClick(Sender: TObject);
    procedure pcEmployeeChange(Sender: TObject);
    procedure bbFindClick(Sender: TObject);
    procedure cbFindDirectClick(Sender: TObject);
    procedure DisableEnableNavButtons(doEnable: boolean);
    procedure taArmCaDmAfterInsert(DataSet: TDataSet);
    procedure taArmCaDeAfterInsert(DataSet: TDataSet);
    procedure taArmCashAfterInsert(DataSet: TDataSet);
  private
    { Private declarations }
    oldMaster: tOracleDataSet;
    procedure doSaveChanges;
    procedure CreateFilters;
    procedure DeleteEmployee;
    procedure CloseQueries;
    procedure OpenQueries;

  public
    { Public declarations }
  end;

var
  fmEmpDet: TfmEmpDet;

implementation

uses fmFreeIDCard, fmEmp, ResStrings;

{$R *.dfm}

procedure TfmEmpDet.CreateFilters;
begin
end;


procedure TfmEmpDet.bbSaveClick(Sender: TObject);
begin
   doSaveChanges;
end;

procedure TfmEmpDet.doSaveChanges;
begin
   if dsRisCard.State = dsInsert then begin
      taRisCard.Post;
      taRisCard.CommitUpdates;
   end;

   if taRisCard.UpdateStatus = usModified then begin
      taRisCard.Post;
      taRisCard.CommitUpdates;
   end;
end;



procedure TfmEmpDet.bbCancelClick(Sender: TObject);
begin
   if taRisCard.UpdateStatus = usModified then begin
      if MessageDlg(C_FMEMPDETAIL_MSG_CONFIRM,
                     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                     Modalresult := mrCancel;
   end else
      ModalResult := mrCancel;
end;

procedure TfmEmpDet.dsRisCardDataChange(Sender: TObject; Field: TField);
begin
{
   if (taRisCard.State in [dsEdit]) and (taRisCard.Modified) and (taRisCard.UpdateStatus = usModified) then begin
      if MessageDlg('Ali naj shranim nastale spremembe?',
                     mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                     doSaveChanges;
   end;
}

end;

procedure TfmEmpDet.CloseQueries;
begin
   // tab 1 - splošni podatki
   taRisCard.Close;

   // tab 2 - ostali podatki
   taRisCapic.Close;

   // tab 3 - organizacijske enote
   quRisCade.Close;

   // tab 4 - razporeditve
   taArmCaDm.Close;
   taArmCaDe.Close;
   taArmCaSh.Close;

   // tab 5 - administratorji
   taRisUsrc.Close;
end;

procedure TfmEmpDet.OpenQueries;
begin
   // tab 1 - splošni podatki
   // vedno aktiven
   {
   if taRisCard.Active = false then
      taRisCard.Open;
   }

   // slika je vedno aktivna
   if taRisCapic.Active = false then
      taRisCapic.Open;

   // odvisno od taba kaj je aktivno
   case pcEmployee.ActivePageIndex of
      0: begin // osnovni podatki
         // tab 3 - organizacijske enote
         quRisCade.Close;
         // tab 4 - razporeditve
         taArmCaDm.Close;
         taArmCaDe.Close;
         taArmCaSh.Close;
         // tab 5 - administratorji
         taRisUsrc.Close;
      end;
      1: begin  // tab 2 - ostali podatki
         // tab 3 - organizacijske enote
         quRisCade.Close;
         // tab 4 - razporeditve
         taArmCaDm.Close;
         taArmCaDe.Close;
         taArmCaSh.Close;
         // tab 5 - administratorji
         taRisUsrc.Close;
      end;

      2: begin  // tab 3 - organizacijske enote
         if not quRisCade.Active then
            quRisCade.Open;
         // tab 4 - razporeditve
         taArmCaDm.Close;
         taArmCaDe.Close;
         taArmCaSh.Close;
         // tab 5 - administratorji
         taRisUsrc.Close;
      end;

      3: begin  // tab 4- razporeditve
         quRisCade.Close;
         // tab 4 - razporeditve
         if not taArmCaDm.Active then
            taArmCaDm.Open;
         if not taArmCaDe.Active then
            taArmCaDe.Open;
         if not taArmCaSh.Active then
            taArmCaSh.Open;
         // tab 5 - administratorji
         taRisUsrc.Close;
      end else // tab 5 - administratorji
         quRisCade.Close;
         // tab 4 - razporeditve
         taArmCaDm.Close;
         taArmCaDe.Close;
         taArmCaSh.Close;
         // tab 5 - administratorji
         if not taRisUsrc.Active then
            taRisUsRc.Open;
      end;

end;

procedure TfmEmpDet.FormCreate(Sender: TObject);
begin
   //dmOracle.quRisCard.Refresh;
   oldMaster := taRisCard.Master;

   if taRisCard.Active = false then
      taRisCard.Open;

   OpenQueries;
   CreateFilters;
end;

procedure TfmEmpDet.FormDestroy(Sender: TObject);
begin
   CloseQueries;
end;

procedure TfmEmpDet.dsRisCardStateChange(Sender: TObject);
begin
   if dsRisCard.State = dsInsert then begin
      bbPrev.Visible := false;
      bbNext.Visible := false;
      bbFirst.Visible := false;
      bbLast.Visible := false;
      edMNR.Enabled := true;
   end else begin
      bbPrev.Visible := true;
      bbNext.Visible := true;
      bbFirst.Visible := true;
      bbLast.Visible := true;
      edMNR.Enabled := false;
   end;
end;

procedure TfmEmpDet.edCardNoButtonClick(Sender: TObject);
begin
   fmSelFreeIDCard := tFMSelFreeIDCard.Create(self);
   with fmSelFreeIDCard do begin
      ShowModal;
      if ModalResult = mrOk then begin
         dsRisCard.Edit;
         taRisCardCARD_NO.Value := dmOracle.quIDCardFreeCARD_NO.AsInteger;
      end;
      Destroy;
   end;
end;

procedure TfmEmpDet.bbPrevClick(Sender: TObject);
begin
   fmEmployee.tvRisCard.NavigatorButtons.Prior.Click;
end;

procedure TfmEmpDet.bbNextClick(Sender: TObject);
begin
   fmEmployee.tvRisCard.NavigatorButtons.Next.Click;
end;

procedure TfmEmpDet.bbFirstClick(Sender: TObject);
begin
   fmEmployee.tvRisCard.NavigatorButtons.First.Click;
end;

procedure TfmEmpDet.bbLastClick(Sender: TObject);
begin
   fmEmployee.tvRisCard.NavigatorButtons.Last.Click;
end;

procedure TfmEmpDet.taRisCapicAfterInsert(DataSet: TDataSet);
begin
   taRisCapicMNR.Value := taRisCapic.GetVariable('MNR');
   taRisCapicIME.Value := 'MNR-' +
                          IntToStr (taRisCapic.GetVariable('MNR')) + '.jpg';
end;

procedure TfmEmpDet.bbLoadFromFileClick(Sender: TObject);
begin
   try
      DBImage.LoadFromFile;
      taRisCapic.Post;
   except
   end;
end;

procedure TfmEmpDet.bbDeleteClick(Sender: TObject);
begin
   taRisCapic.Edit;
   taRisCapic.Delete;
end;

procedure TfmEmpDet.taRisCapicAfterRefresh(DataSet: TDataSet);
begin
   if taRisCapic.RecordCount > 0 then
      bbDelete.Enabled := true
   else
      bbDelete.Enabled := false;
end;

procedure TfmEmpDet.DeleteEmployee;
begin
   try
      taRisCard.Delete;
      dmOracle.oraSession.Commit;
   except
      MessageDlg(C_FMEMPDETAIL_ERROR_DELETEEMPLOYEE, mtError,
                  [mbOk], 0);
   end;
end;

procedure TfmEmpDet.bbDeleteCardClick(Sender: TObject);
begin
   if (MessageDlg(C_fmEmpDetail_MSG_bbDeleteCardClick, mtConfirmation,
                  [mbYes, mbNo], 0) = mrYes) then
      DeleteEmployee;
end;

procedure TfmEmpDet.pcEmployeeChange(Sender: TObject);
begin
   OpenQueries;
end;

procedure TfmEmpDet.bbFindClick(Sender: TObject);
begin
   taRisCard.Close;
   taRisCard.SetVariable('MNR', StrToInt(edAllMNR.Text));
   taRisCard.Open;
end;

procedure TfmEmpDet.cbFindDirectClick(Sender: TObject);
begin
   gbDirectFind.Visible := cbFindDirect.Checked;

   taRisCard.Close;
   if cbFindDirect.Checked then
      taRisCard.Master := nil
   else begin
      taRisCard.Master := oldMaster;
      taRisCard.Open;
   end;
end;

procedure TfmEmpDet.DisableEnableNavButtons(doEnable: boolean);
begin
   bbFirst.Enabled := doEnable;
   bbPrev.Enabled := doEnable;
   bbNext.Enabled := doEnable;
   bbLast.Enabled := doEnable;
end;

procedure TfmEmpDet.taArmCaDmAfterInsert(DataSet: TDataSet);
begin
   if taArmCaDmVELJA_OD.Value <= 0 then
      taArmCaDmVELJA_OD.Value := dmOracle.paramDateRazpFrom;
end;

procedure TfmEmpDet.taArmCaDeAfterInsert(DataSet: TDataSet);
begin
   if taArmCaDeVELJA_OD.Value <= 0 then
      taArmCaDeVELJA_OD.Value := dmOracle.paramDateRazpFrom;

end;

procedure TfmEmpDet.taArmCashAfterInsert(DataSet: TDataSet);
begin
   if taArmCaShVELJA_OD.Value <= 0 then
      taArmCaShVELJA_OD.Value := dmOracle.paramDateRazpFrom;
end;

end.
