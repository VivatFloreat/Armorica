unit fmRazpOsebNew;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxControls, cxGridCustomView,
  cxClasses, cxGridLevel, cxGrid, OracleData, StdCtrls, Buttons,
  cxGridBandedTableView, cxGridDBBandedTableView, ExtCtrls, OracleNavigator,
  cxRichEdit, cxButtonEdit, cxMemo, cxCheckGroup, cxBlobEdit, cxTextEdit,
  RXSpin, Menus, Oracle, DBCtrls, RxLookup, cxHint, globals,
  Mask, ToolEdit, cxContainer, cxMaskEdit, cxSpinEdit, Solver,ResStrings,
  cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox,
  cxPropertiesStore;

const
   C_MAXDNI = 35;          // max dni ki jih solver še prebavi

   C_DUMMY_RAZPORED_ID = -9999; // èe ne podamo šifre razporeda je ta rezervirann kot dummy

   C_TAG_MIN_OFF = 0;      // tag ID - offset v generiranih poljih za polje MIN
   C_TAG_OPT_OFF = 1000;   // tag ID - offset v generiranih poljih za polje OPT
   C_TAG_MAX_OFF = 2000;   // tag ID - offset v generiranih poljih za polje MAX
   C_TAG_CRITERIA = 3000;   // tag ID - offset v generiranih poljih za polje Kriterij

   // Imena stolpcev
   C_NAME_DAY = 'DAY';
   C_NAME_MNR = 'MNR';
   C_NAME_CARD_NO = 'CARD_NO';
   C_NAME_CRITERIA = 'CRIT';
   C_NAME_STATUS = 'STATUS';
   C_NAME_AKT = 'AKT';
   C_NAME_EMPLOYED = 'EMPLOYED';
   C_NAME_OPISODDELKA = 'OPISODDELKA';
   C_NAME_ORG1 = 'ORG1';

   // Širina stolpcev za odsotnosti
   C_MIN_WIDTH = 36;
   C_MIN_WIDTH_CRIT = 50;

   // Maksimalno število stolpcev za prikaz kriterijev
   // 1=prenos v mesec, 2=vsota ur v tem mesecu 3=ure na koncu meseca
   // 4 = število delovnih nedelj v tem letu 5 = število delovnih nedelj in praznikov na razporedu
   // 6= vsota ur na nedeljo in praznike
   // 7= število noènih šihtov v tem letu 8=število noènih šihtov na razporedu 9=Konèno število noènih
   MAX_CRITERIA = 9;

type tOpers = (operOdsotNew, operOdsotDel, operOdsotOdobri, operOdsotZavrni, operRazpSidraj, OperRazpDel);

type
  TfmRazp = class(TForm)
    Panel1: TPanel;
    bbPopulate: TBitBtn;
    Panel2: TPanel;
    Grid: TcxGrid;
    Panel3: TPanel;
    sdHTML: TSaveDialog;
    bbPrint: TBitBtn;
    Panel4: TPanel;
    bbSave: TBitBtn;
    bbCancel: TBitBtn;
    bbExcel: TBitBtn;
    viRazpByMNR: TcxGridDBBandedTableView;
    leRazpByMNR: TcxGridLevel;
    cxHintStyleController1: TcxHintStyleController;
    Timer1: TTimer;
    dsRisUCard: TDataSource;
    viRazpByMNRMNR: TcxGridDBBandedColumn;
    viRazpByMNRLNAME: TcxGridDBBandedColumn;
    viRazpByMNRFNAME: TcxGridDBBandedColumn;
    viRazpByMNRORG1: TcxGridDBBandedColumn;
    viRazpByMNRCARD_NO: TcxGridDBBandedColumn;
    spInsRazp: TOracleQuery;
    delArmRazp: TOracleQuery;
    Label3: TLabel;
    quMNRCritFunc: TOracleQuery;
    MnuRazp: TMainMenu;
    Monosti1: TMenuItem;
    miDragDrop: TMenuItem;
    mnuPopup: TPopupMenu;
    miOdsotNew: TMenuItem;
    miOdsotOdobri: TMenuItem;
    miOdsotZavrni: TMenuItem;
    N2: TMenuItem;
    miOdsotDel: TMenuItem;
    dsRisHour: TDataSource;
    quRisHour: TOracleDataSet;
    quRisHourHOURS_ID: TIntegerField;
    quRisHourVP_ID: TStringField;
    quRisHourDESCRIPTION: TStringField;
    quRisHourOPIS: TStringField;
    spDelOdsot: TOracleQuery;
    spInsOdsot: TOracleQuery;
    N3: TMenuItem;
    miSidrajRazpored: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    edDatumOd: TDateEdit;
    edDatumDo: TDateEdit;
    sbNext: TSpeedButton;
    sbPrev: TSpeedButton;
    bbSolve: TBitBtn;
    quObveza: TOracleDataSet;
    edMsg: TEdit;
    miRazpDel: TMenuItem;
    Edit1: TMenuItem;
    miRazveljavi: TMenuItem;
    Orodja1: TMenuItem;
    miRandomizer: TMenuItem;
    N6: TMenuItem;
    miProsto: TMenuItem;
    miDnevni: TMenuItem;
    miProDel: TMenuItem;
    miRandomizerSunHoly: TMenuItem;
    cbPrenosID: TRxDBLookupCombo;
    miSelectAll: TMenuItem;
    miSelectDay: TMenuItem;
    N7: TMenuItem;
    viRazpByMNRAKT: TcxGridDBBandedColumn;
    viRazpByMNREMPLOYED: TcxGridDBBandedColumn;
    viRazpByMNROPISODDELKA: TcxGridDBBandedColumn;
    miSettings: TMenuItem;
    myStyles: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyleSobotaHeader: TcxStyle;
    cxStyleNedeljaHeader: TcxStyle;
    cxStyleDelovisceHeader: TcxStyle;
    cxStyleRaz1: TcxStyle;
    cxStyleRaz3: TcxStyle;
    cxStyleRaz4: TcxStyle;
    cxStyleRaz2: TcxStyle;
    cxStyleOds1: TcxStyle;
    cxStyleOds2: TcxStyle;
    cxStyleOds3: TcxStyle;
    cxStylePraznikHeader: TcxStyle;
    cxStyleOds4: TcxStyle;
    quDelOdsotRisPair: TOracleQuery;
    quInsOdsotRisPair: TOracleQuery;
    N1: TMenuItem;
    miPovleciSpusti: TMenuItem;
    procedure bbPopulateClick(Sender: TObject);
    procedure bbSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbPrintClick(Sender: TObject);
    procedure bbExcelClick(Sender: TObject);
    procedure viRazpByMNRMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure viRazpByMNRDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure viRazpByMNRDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure miKF1Click(Sender: TObject);
    procedure miDragDropClick(Sender: TObject);
    procedure miOdsotNewClick(Sender: TObject);
    procedure mnuPopupPopup(Sender: TObject);
    procedure miOdsotDelClick(Sender: TObject);
    procedure bbSolveClick(Sender: TObject);
    procedure sbPrevClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
    procedure miSidrajRazporedClick(Sender: TObject);
    procedure miRazpDelClick(Sender: TObject);
    procedure miRazveljaviClick(Sender: TObject);
    procedure viRazpByMNRCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure miRandomizerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure miDelovnikiClick(Sender: TObject);
    procedure miSoboteClick(Sender: TObject);
    procedure miNedeljeClick(Sender: TObject);
    procedure miPraznikiClick(Sender: TObject);
    procedure miDnevniClick(Sender: TObject);
    procedure miProstoClick(Sender: TObject);
    procedure miProDelClick(Sender: TObject);
    procedure miRandomizerSunHolyClick(Sender: TObject);
    procedure miSelectDayClick(Sender: TObject);
    procedure miSelectAllClick(Sender: TObject);
    procedure miSettingsClick(Sender: TObject);
    procedure viRazpByMNRDblClick(Sender: TObject);
    procedure miOdsotOdobriClick(Sender: TObject);
    procedure miOdsotZavrniClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    fHintDisplayed: Boolean;
    fGridRecord: TcxCustomGridRecord;
    fItem: TcxCustomGridTableItem;
    fColumn: TcxGridColumn;
    fBand: TcxGridBand;
    procedure PremakniMesec(koliko: integer);
    function getGridColumnIndex (aDate: TDateTime): Integer;
    function getColumnCriteriaIndex (aKFndx: integer): Integer;
    procedure InitCalendarGrid(aGridView: TcxGridDBBandedTableView);
    procedure InitCriteriaGrid (aGridView: TcxGridDBBandedTableView);
    procedure EnableDisablePopupMenuItems;

    procedure SaveRazpored;
    procedure OnDayXGetContentStyle(
              Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
              AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure Hint_Record(aHitTest: TcxCustomGridHitTest; X, Y: integer);
    procedure Hint_ColumnHeader(aHitTest: TcxCustomGridHitTest; X, Y: integer);
    procedure Hint_BandHeader(aHitTest: TcxCustomGridHitTest; X, Y: integer);
    procedure LoadMNRCriCol (ri: integer;
                             aMNR: integer;
                             aLowDate, aHighDate: TDateTime);
    procedure ShowHideColumns;
    function FormatCellData(sMode: integer; DDMI: pDDMIElem; aOwner: integer): string;
    procedure ShowCellData(aDispText: string; gri, gci: integer);
    procedure ShowOsebaCriteria(ri: integer);
    procedure SelectedCelsOper(aOper: tOpers; // operacija
                                   aVal: variant; // text viden v gridu
                                   aShiftNo: variant; // fiksiran turnus ali status odobritve odsotnosti
                                   aDepartId: variant; // fiksirano delovišèe
                                   aDemId: variant; // fiksirano DM
                                   aShiftId: variant; // fiksirana izmena
                                   aUser1: variant);

     procedure LoadGridFromSolver;

     procedure LoadObveza;
     procedure OpenCommonQueries;
     procedure SaveToFiles(trgDir: string);
     procedure ShowPersonalDetailData(ri: integer);
     procedure ProgressInit(nSteps, stepSize: integer);
     procedure ProgressInfo(msg: string);
     procedure ProgressClose;
     procedure SelectCells(odDneva, doDneva: tDate);
     procedure CreateDefaultFilter;
     procedure MyDataFormatHandler(Sender: TcxCustomGridTableItem;
                                      ARecordIndex: Integer;
                                      var AText: string);
     procedure GUIRestoreState;
     procedure GUIStoreState;

  public
    { Public declarations }
    CellShowMode: integer;
  end;

var
  fmRazp: TfmRazp;

implementation

{$R *.dfm}
uses DateUtils, cxDataUtils, dmOra, cxGridExportLink, fmSelectOds,
     fmSelectDDMI, fmRazpDelOpt, fmPersonalData, fmProgressShow,
     fmRazDnevni, tSolverEngine, fmSolverOptions, fmSetOpt, appRegistry, math,
     StrUtils, fmEmpDetail, fmSolveResults;

procedure TfmRazp.InitCalendarGrid (aGridView: TcxGridDBBandedTableView);
var
   aDat: TDateTime;
   aColMin: TcxGridBandedColumn;
   datIndx: integer;
   tmp: string;

   procedure DestroyDayColumn;
      var i: integer;
          Name: string;
   begin
      // Rekurzivni sprehod skozi vse kolone, unièi vse ki prikazujejo dneve
      for i:=0 to aGridView.ColumnCount -1 do begin
         // Vzemi ime kolone
         Name:=aGridView.Columns[i].Name;

         if (Pos(C_NAME_DAY, Name) > 0) then begin
            // Ime kolone je pravo, zato jo unièi
            aGridView.Columns[i].Destroy;
            // pobriši naslednjo rekurzivno, ker se je število kolon zmanjšalo!!!
            DestroyDayColumn;
            // takoj zapusti
            exit;
         end;
      end;
   end;

begin
   DestroyDayColumn;
   aDat := edDatumOd.Date;
   datIndx := 0;

   while (aDat <= edDatumDo.Date) do begin
      aColMin := aGridView.CreateColumn;
      aColMin.Name := aGridView.Name + C_NAME_DAY + IntToStr(datIndx);
      tmp:=FormatDateTime ('d', aDat);
      aColMin.Caption := tmp;
      aColMin.Position.BandIndex := 2;
      aColMin.Options.Editing := false;
      aColMin.Options.Filtering := false;
      aColMin.Tag := C_TAG_MIN_OFF + (datIndx);
      aColMin.MinWidth := C_MIN_WIDTH;
      aColMin.Styles.OnGetContentStyle := OnDayXGetContentStyle;
      aColMin.DataBinding.ValueType := 'String';
      aColMin.PropertiesClass := TcxCustomMemoProperties; // prikazujemo kot Memo field;
      TcxCustomMemoProperties(aColMin.Properties).WantReturns := true;
      TcxCustomMemoProperties(aColMin.Properties).Alignment := taCenter;

      if (dmOracle.isPraznik(aDat)) then begin
         aColMin.Styles.Header := cxStylePraznikHeader;
         aColMin.Styles.Content := cxStyleNedeljaHeader;
      end else begin
         case DayOfWeek(aDat) of
            7: begin
                 aColMin.Styles.Header := cxStyleSobotaHeader;
                 aColMin.Styles.Content := cxStyleSobotaHeader;
               end;
            1: begin
                 aColMin.Styles.Header := cxStyleNedeljaHeader;
                 aColMin.Styles.Content := cxStyleNedeljaHeader;
               end;
         end;
      end;

      aDat := aDat + 1;
      datIndx := datIndx + 1;
   end;
end;

procedure TfmRazp.MyDataFormatHandler(Sender: TcxCustomGridTableItem;
                                      ARecordIndex: Integer;
                                      var AText: string);
var aValue: variant;
begin
   aValue:=Sender.DataBinding.DataController.GetValue(aRecordIndex, Sender.Index);
   if aValue <> null then
      aText:=FmtMinutesHHMM(aValue, 3)
   else
      aText := '??:??';
end;


procedure TfmRazp.InitCriteriaGrid (aGridView: TcxGridDBBandedTableView);
var
   aCol: TcxGridBandedColumn;
   i: integer;

   procedure DestroyColumn;
      var i: integer;
          Name: string;
   begin
      // Rekurzivni sprehod skozi vse kolone, unièi vse ki prikazujejo kriterij
      for i:=0 to aGridView.ColumnCount -1 do begin
         // Vzemi ime kolone
         Name:=aGridView.Columns[i].Name;

         if (Pos(C_NAME_CRITERIA, Name) > 0) then begin
            // Ime kolone je pravo, zato jo unièi
            aGridView.Columns[i].Destroy;
            // pobriši naslednjo rekurzivno, ker se je število kolon zmanjšalo!!!
            DestroyColumn;
            // takoj zapusti
            exit;
         end;
      end;
   end;

begin
   DestroyColumn;

   for i:=1 to MAX_CRITERIA do begin
      aCol := aGridView.CreateColumn;
      aCol.Name := aGridView.Name + C_NAME_CRITERIA + IntToStr(i);
      case i of
         1: begin
            aCol.Caption := 'URE-v';
            aCol.Options.Editing := false;
            aCol.OnGetDataText := MyDataFormatHandler;
            aCol.Options.SortByDisplayText := isbtOff;

         end;
         2: begin
            aCol.Caption := 'URE';
            aCol.Options.Editing := false;
            aCol.OnGetDataText := MyDataFormatHandler;
            aCol.Options.SortByDisplayText := isbtOff;

         end;
         3: begin
            aCol.Caption := 'URE-i';
            aCol.Options.Editing := false;
            aCol.OnGetDataText := MyDataFormatHandler;
            aCol.Options.SortByDisplayText := isbtOff;

         end;
         // nedelje in prazniki
         4: begin
            aCol.Caption := 'NEP-v';
            aCol.Options.Editing := false;
         end;
         5: begin
            aCol.Caption := 'NEP';
            aCol.Options.Editing := false;
         end;
         6: begin
            aCol.Caption := 'NEP-i';
            aCol.Options.Editing := false;
         end;
         // Noèni delovniki
         7: begin
            aCol.Caption := 'NOC-v';
            aCol.Options.Editing := false;
         end;
         8: begin
            aCol.Caption := 'NOC';
            aCol.Options.Editing := false;
         end;
         9: begin
            aCol.Caption := 'NOC-i';
            aCol.Options.Editing := false;
         end;
      else
         aCol.Caption := '???-' + IntToStr(i);
         aCol.Options.Editing := false;
      end;

      aCol.Position.BandIndex := 1;
      // nastavitev alignmenta
      aCol.PropertiesClass := TcxTextEditProperties;
      TcxTextEditProperties(aCol.Properties).Alignment.Horz := taRightJustify;

      aCol.Options.Filtering := true;
      aCol.Options.VertSizing := true;
      aCol.Options.Moving := true;
      aCol.Tag := C_TAG_CRITERIA + i;
      aCol.MinWidth := C_MIN_WIDTH_CRIT;
      aCol.DataBinding.ValueType := 'Integer';
      aCol.Styles.Header := cxStyle1;
      aCol.Styles.Content := cxStyle1;
   end;
end;

procedure TfmRazp.ShowHideColumns;
var i, ci: integer;
    aDay: TDate;
    aColumn: TcxGridDBBandedColumn;
begin
   with fmSettings do begin

      ci := GetColumnCriteriaIndex(1);
      if ci > 1 then
         viRazpByMNR.Columns[ci].Visible := cbUreIn.Checked;

      ci := GetColumnCriteriaIndex(2);
      if ci > 1 then
         viRazpByMNR.Columns[ci].Visible := cbUre.Checked;

      ci := GetColumnCriteriaIndex(3);
      if ci > 1 then
         viRazpByMNR.Columns[ci].Visible := cbUreOut.Checked;

      ci := GetColumnCriteriaIndex(4);
      if ci > 1 then
         viRazpByMNR.Columns[ci].Visible := cbNepIn.Checked;

      ci := GetColumnCriteriaIndex(5);
      if ci > 1 then
         viRazpByMNR.Columns[ci].Visible := cbNep.Checked;

      ci := GetColumnCriteriaIndex(6);
      if ci > 1 then
         viRazpByMNR.Columns[ci].Visible := cbNepOut.Checked;

      ci := GetColumnCriteriaIndex(7);
      if ci > 1 then
         viRazpByMNR.Columns[ci].Visible := cbNocIn.Checked;

      ci := GetColumnCriteriaIndex(8);
      if ci > 1 then
         viRazpByMNR.Columns[ci].Visible := cbNoc.Checked;

      ci := GetColumnCriteriaIndex(9);
      if ci > 1 then
         viRazpByMNR.Columns[ci].Visible := cbNocOut.Checked;

      if (cbUreIn.Checked or cbUre.Checked or cbUreOut.Checked or
          cbNepIn.Checked or cbNep.Checked or cbNepOut.Checked or
          cbNocIn.Checked or cbNoc.Checked or cbNocOut.Checked) then
         viRazpByMNR.Bands[1].Visible := true
      else
         viRazpByMNR.Bands[1].Visible := false;

      // vidnost stolpcev osebe
      aColumn := viRazpByMNR.GetColumnByFieldName(C_NAME_MNR);
      if aColumn <> nil then
         // kolona je vidna èe ni grupiranja in èe je oznaèena kot vidna
         aColumn.Visible := ((aColumn.GroupIndex = -1) and (cbMNR.Checked));

      aColumn := viRazpByMNR.GetColumnByFieldName(C_NAME_CARD_NO);
      if aColumn <> nil then
         // kolona je vidna èe ni grupiranja in èe je oznaèena kot vidna
         aColumn.Visible := ((aColumn.GroupIndex = -1) and (cbIDCard.Checked));

      aColumn := viRazpByMNR.GetColumnByFieldName(C_NAME_AKT);
      if aColumn <> nil then
         // kolona je vidna èe ni grupiranja in èe je oznaèena kot vidna
         aColumn.Visible := ((aColumn.GroupIndex = -1) and (cbAkt.Checked));

      aColumn := viRazpByMNR.GetColumnByFieldName(C_NAME_EMPLOYED);
      if aColumn <> nil then
         // kolona je vidna èe ni grupiranja in èe je oznaèena kot vidna
         aColumn.Visible := ((aColumn.GroupIndex = -1) and (cbEmployed.Checked));

      aColumn := viRazpByMNR.GetColumnByFieldName(C_NAME_OPISODDELKA);
      if aColumn <> nil then
         // kolona je vidna èe ni grupiranja in èe je oznaèena kot vidna
         aColumn.Visible := ((aColumn.GroupIndex = -1) and (cbOE.Checked));

      aColumn := viRazpByMNR.GetColumnByFieldName(C_NAME_ORG1);
      if aColumn <> nil then
         // kolona je vidna èe ni grupiranja in èe je oznaèena kot vidna
         aColumn.Visible := ((aColumn.GroupIndex = -1) and (cbORG1.Checked));

      for i := 0 to globSolver.Razpored.DayCount-1 do begin
         aDay := globSolver.Razpored.FirstDay + i;

         ci := GetGridColumnIndex(aDay);
         if (ci < 0) then
            exit;

         if dmOracle.isPraznik(aDay) then begin
            viRazpByMNR.Columns[ci].Visible := cbPrazniki.Checked;
         end else begin
            case DayOfTheWeek(aDay) of
               1,2,3,4,5:
                  viRazpByMNR.Columns[ci].Visible := cbDelovniki.Checked;
               6:
                  viRazpByMNR.Columns[ci].Visible := cbSobote.Checked;
               7:
                  viRazpByMNR.Columns[ci].Visible := cbNedelje.Checked;
            end;
         end;
      end;
   end;
end;


// splošna funkcija ki za dani index kriterijske funkcije vrne index stolpca v gridu
function TfmRazp.getColumnCriteriaIndex (aKFndx: integer): Integer;
var i: integer;
    colName : string;
begin
   colName := viRazpByMNR.name + C_NAME_CRITERIA + IntToStr(aKFndx);
   for i:=0 to viRazpByMNR.ColumnCount -1 do begin
      if viRazpByMNR.Columns[i].Name = colName then begin
         Result := viRazpByMNR.Columns[i].Index;
         exit;
      end;
   end;
   Result := -1;
end;

// splošna funkcija ki za dani datum vrne index stolpca v gridu
function TfmRazp.getGridColumnIndex (aDate: TDateTime): Integer;
var i, dayOffset: integer;
    colName : string;
begin
   // pogruntaj koliko dni je odmaknjen od prvega dneva
   dayOffset := DaysBetween (edDatumOd.Date, aDate);

   // željeni stolpec se nahaja v 3 bandu, zato prištej št. stolpcev iz banda 1 in 2
   i := viRazpByMNR.Bands[0].ColumnCount +
        viRazpByMNR.Bands[1].ColumnCount +
        dayOffset;

   // za vsak sluèaj preveri ime stolpca
   colName := viRazpByMNR.name + C_NAME_DAY + IntToStr(dayOffset);
   if viRazpByMNR.Columns[i].Name = colName then
      Result := i
   else
      Result := -1;
end;

procedure TfmRazp.ShowPersonalDetailData(ri: integer);
begin
   fmPersData := tFmPersData.Create(self, ri);
   fmPersData.ShowModal;
   if fmPersData.ModalResult = mrOk then begin
      ShowOsebaCriteria(ri);
   end;

   fmPersData.Destroy;
end;

procedure TfmRazp.ShowOsebaCriteria(ri: integer);
var ci: integer;
    aOseba: TOseba;
    aKrit, aKritNedP, aKritNS: tCriteria;
begin
   aOseba := TOseba(globSolver.Osebe.Items[ri]);

   aKrit := aOseba.GetCriteria(ctHours);
   if aKrit <> nil then begin
      viRazpByMNR.DataController.BeginUpdate;
      // prenos ur iz prejšnjega meseca
      ci := GetColumnCriteriaIndex(1);
      viRazpByMNR.DataController.SetValue(ri, ci, aKrit.StartHours);
      //viRazpByMNR.DataController.SetValue(ri, ci, Minutes_To_HHMM(aKrit.StartHours));
      // vsota ur na razporedu
      ci := GetColumnCriteriaIndex(2);
      viRazpByMNR.DataController.SetValue(ri, ci, aKrit.SumHours);
      //viRazpByMNR.DataController.SetValue(ri, ci, Minutes_To_HHMM(aKrit.SumHours));
      // vsota ur na koncu meseca
      ci := GetColumnCriteriaIndex(3);
      viRazpByMNR.DataController.SetValue(ri, ci, aKrit.StopHours);
      //viRazpByMNR.DataController.SetValue(ri, ci, Minutes_To_HHMM(aKrit.StopHours));
      viRazpByMNR.DataController.EndUpdate;
   end;

   aKritNedP := aOseba.GetCriteria(ctSunHoly);
   if aKritNedP <> nil then begin
      viRazpByMNR.DataController.BeginUpdate;
      // delovne nedelje in prazniki v tem letu
      ci := GetColumnCriteriaIndex(4);
      viRazpByMNR.DataController.SetValue(ri, ci, IntToStr(aKritNedP.StartDays));
      // število delovnih nedelj in praznikov na razporedu
      ci := GetColumnCriteriaIndex(5);
      viRazpByMNR.DataController.SetValue(ri, ci, IntToStr(aKritNedP.SumDays));
      // konèno število NP
      ci := GetColumnCriteriaIndex(6);
      viRazpByMNR.DataController.SetValue(ri, ci, IntToStr(aKritNedP.EndDays));
      viRazpByMNR.DataController.EndUpdate;
   end;

   aKritNS := aOseba.GetCriteria(ctNightShift);
   if aKritNS <> nil then begin
      viRazpByMNR.DataController.BeginUpdate;
      // noèni delovniki v tem letu
      ci := GetColumnCriteriaIndex(7);
      viRazpByMNR.DataController.SetValue(ri, ci, IntToStr(aKritNS.StartDays));
      // noèni delovniki na razporedu
      ci := GetColumnCriteriaIndex(8);
      viRazpByMNR.DataController.SetValue(ri, ci, IntToStr(aKritNS.SumDays));
      // konèno število noènih
      ci := GetColumnCriteriaIndex(9);
      viRazpByMNR.DataController.SetValue(ri, ci, IntToStr(aKritNS.EndDays));
      viRazpByMNR.DataController.EndUpdate;
   end;
end;

function TfmRazp.FormatCellData(sMode: integer; DDMI: pDDMIElem; aOwner: integer): string;
var aDispText: string;
begin
   case sMode of
      0: aDispText := DDMI^.depa;
      1: aDispText := DDMI^.dem_arm_oznaka;
      2: aDispText := DDMI^.shift_arm;
      3: aDispText := DDMI^.depa + ' ' + DDMI^.dem_arm_oznaka;
      4: aDispText := DDMI^.depa + ' ' + DDMI^.shift_arm;
      5: aDispText := DDMI^.dem_arm_oznaka + ' ' + DDMI^.depa;
      6: aDispText := DDMI^.dem_arm_oznaka + ' ' + DDMI^.shift_arm;
      7: aDispText := DDMI^.shift_arm + ' ' + DDMI^.depa;
      8: aDispText := DDMI^.shift_arm + ' ' + DDMI^.dem_arm_oznaka;
      9: aDispText := DDMI^.dem_arm_oznaka + ' ' + DDMI^.depa + ' ' + DDMI^.shift_arm;
   else
      aDispText := FmtHoursHHMM(DDMI^.need_hhmm);
   end;

   if (aOwner <> cbPrenosID.KeyValue) then
      aDispText := '© ' + aDispText; 

   Result := aDispText;
end;

procedure TfmRazp.ShowCellData(aDispText: string; gri, gci: integer);
begin
   //viRazpByMNR.DataController.SetValue(gri, gci, aDispText);
   //viRazpByMNR.Columns[gci].Position.LineCount := aCellHeight;

   viRazpByMNR.DataController.SetEditValue(gci, aDispText, evsValue);

end;

procedure TfmRazp.ProgressInit(nSteps, stepSize: integer);
begin
   fmProgress.ProgressBar1.Step := stepSize;
   fmProgress.ProgressBar1.Min := 0;
   fmProgress.ProgressBar1.Max := nSteps;
end;

procedure TfmRazp.ProgressInfo(msg: string);
begin
   if not fmProgress.Showing then
      fmProgress.Show;

   fmProgress.laInfo.Caption := msg;
   fmProgress.ProgressBar1.StepIt;

   fmProgress.Refresh;
end;

procedure TfmRazp.ProgressClose;
begin
   fmProgress.Hide;
end;

procedure TfmRazp.LoadMNRCriCol (ri: integer;
                                 aMNR: integer;
                                 aLowDate, aHighDate: TDateTime);
begin
end;

procedure TfmRazp.LoadGridFromSolver;
var
   ri, dayIndx: integer;
   gci: integer;
   aRazp: pRazpElem;
   aValue: string;
begin
   // Sprehod skozi vse MNRje
   dmOracle.quRisUCard.First;

   while not dmOracle.quRisUCard.Eof do begin
      edMsg.Text := IntToStr (dmOracle.quRisUCard.RecNo) + ' od ' +  IntToStr (dmOracle.quRisUCard.RecordCount);
      edMsg.Refresh;
      Application.ProcessMessages;
      if viRazpByMNR.DataController.Filter.IsFiltering then
         viRazpByMNR.DataController.Filter.Clear;

      ri := viRazpByMNR.DataController.GetFocusedRecordIndex;

      viRazpByMNR.DataController.BeginUpdate;
      ShowOsebaCriteria(ri);
      for DayIndx := 0 to globSolver.Razpored.DayCount -1 do begin
         aRazp := globSolver.Razpored.GetRazporedElement(ri, dayIndx);
         if aRazp <> nil then begin
            if aRazp^.recType = rtRazp then begin
               gci := GetGridColumnIndex(aRazp^.in_date);

               aValue := FormatCellData(CellShowMode, aRazp^.DDMI, aRazp^.mnr_owner);

               ShowCellData(aValue, ri, gci);
            end;

            if aRazp^.recType = rtOdsot then begin
               gci := GetGridColumnIndex(aRazp^.in_date);
               aValue := aRazp^.vp_id;
               viRazpByMNR.DataController.SetEditValue(gci, aValue, evsValue);
            end;

         end;
      end;
      viRazpByMNR.DataController.EndUpdate;
      dmOracle.quRisUCard.Next;
   end;
end;

procedure TfmRazp.OpenCommonQueries;
begin
   if not dmOracle.quLastniki.Active then
      dmOracle.quLastniki.Open;

   if quRisHour.Active then
      quRisHour.Close;
   quRisHour.Open;
end;


procedure TfmRazp.LoadObveza;
begin
   with quObveza do begin
      Close;
      SetVariable('P_DATUM_OD', edDatumOd.Date);
      SetVariable('P_DATUM_DO', edDatumDo.Date);
      Open;
   end;
end;


procedure TfmRazp.bbPopulateClick(Sender: TObject);
var msg: string;
begin

   if ((edDatumOd.Date = 0) or (edDatumDo.Date = 0)) then
      raise exception.Create(C_EXCEPT_MSG_SELECT_DATES);

   if (DaysBetween(edDatumOd.Date, edDatumDo.Date) > C_MAXDNI) then begin
      msg := Format (C_EXCEPT_MSG_DAYS_EXCEEDED, [C_MAXDNI]);
      raise exception.Create(msg);
   end;

   if cbPrenosID.KeyValue = null then
      raise Exception.Create(C_EXCEPT_MSG_SELECT_OWNER);

   try
      ProgressInit(6,1); // skupno 6 korakov, velikost koraka = 1
      ProgressInfo(C_PROGRESS_INFO_INIT);

      // Inicializacija solverja in load vseh podatkov za izbrano obdobje
      dmOracle.SolverInit(edDatumOd.Date, edDatumDo.Date);

      ProgressInfo(C_PROGRESS_INFO_AVAILABILITY_LOAD);

      if cbPrenosID.KeyValue <> null then
         dmOracle.SolverLoadAll(cbPrenosID.KeyValue,
                                edDatumOd.Date, edDatumDo.Date,
                                fmSettings.rgOdsotSource.ItemIndex)
      else
         dmOracle.SolverLoadAll(C_DUMMY_RAZPORED_ID,
                                edDatumOd.Date,
                                edDatumDo.Date,
                                fmSettings.rgOdsotSource.ItemIndex);

      ProgressInfo(C_PROGRESS_INFO_CALENDAR_LOAD);

      LoadObveza;

      ProgressInfo(C_PROGRESS_INFO_GRID_PREPARE);

      InitCriteriaGrid (viRazpByMNR);
      InitCalendarGrid (viRazpByMNR);

      ShowHideColumns;

      miDragDropClick (self);

      ProgressInfo(C_PROGRESS_INFO_DATA_SHOW);

      dmOracle.quRisUCard.Open;
      Grid.FocusedView := viRazpByMNR;
      LoadGridFromSolver;

      // Nastavi filtre in grouping na gridu
      GUIRestoreState;

      ProgressInfo(C_PROGRESS_INFO_GRID_SIZE);

      viRazpByMNR.ApplyBestFit();
   finally
      ProgressClose;
   end;

end;


procedure TfmRazp.bbSaveClick(Sender: TObject);
begin
   if cbPrenosID.KeyValue = null then
      raise Exception.Create(C_EXCEPT_MSG_SELECT_OWNER);
   Screen.Cursor := crHourGlass;
   SaveRazpored;
   Screen.Cursor := crDefault;
end;

procedure TfmRazp.FormCreate(Sender: TObject);
var aY, aM, aD: word;
begin
   CellShowMode := 0; // delovišèe
   DecodeDate (Date, aY, aM, aD);
   edDatumOd.Date := EncodeDate(aY, aM, 1);
   edDatumDo.Date := EndOfTheMonth(Date);
   fmProgress := tFmProgress.Create(self);
   OpenCommonQueries;
   fmSettings := tFmSettings.Create(self);
   fmResults := tfmResults.Create(self);
   CellShowMode := fmSettings.rgShowMode.ItemIndex;
   cbPrenosId.KeyValue := dmOracle.quLastniki.FieldByName('MNR').AsInteger;
end;

procedure TfmRazp.bbPrintClick(Sender: TObject);
begin
   sdHTML.FileName := 'Razpored' + FormatDateTime ('mmmyyyy', edDatumOd.Date) +'.html';
   sdHTML.FilterIndex := 1;
   if sdHTML.Execute then begin
      ExportGridToHTML(sdHTML.FileName, Grid);
   end;
end;

procedure TfmRazp.bbExcelClick(Sender: TObject);
begin
   sdHTML.FileName := 'Razpored' + FormatDateTime ('mmmyyyy', edDatumOd.Date) +'.xls';
   sdHTML.FilterIndex := 2;
   if sdHTML.Execute then begin
         ExportGridToExcel(sdHTML.FileName, Grid);
   end;
end;

// glavna procedura za prikazovanje hintov
procedure TfmRazp.viRazpByMNRMouseMove(Sender: TObject;
                                       Shift: TShiftState;
                                       X, Y: Integer);
var
   AHitTest: TcxCustomGridHitTest;

begin
   //determine the current mouse position
   aHitTest := viRazpByMNR.ViewInfo.GetHitTest(X, Y);
   //hide displayed hint if mouse is not over a grid cell

   case AHitTest.HitTestCode of
      htColumnHeader:
         Hint_ColumnHeader(aHitTest, X, Y);

      htBandHeader:
         Hint_BandHeader(aHitTest, X, Y);

      htCell:
         Hint_Record(aHitTest, X, Y);
   else
      timer1.Enabled := False;
      cxHintStyleController1.HideHint;
      exit;
   end;

   //start the hide hint timer
   Timer1.Enabled := True;
end;

procedure TfmRazp.Hint_Record(aHitTest: TcxCustomGridHitTest; X, Y: integer);
var
   aHint: string;
   ri, ci, dayIndx: integer;
   aRec: pRazpElem;
   aDirtyFlag: char;
begin
   with TcxGridRecordCellHitTest(AHitTest) do
   ///check the current record and column over which the mouse is placed
   if (fGridRecord <> GridRecord) or (fItem <> Item) or not FHintDisplayed then begin
      //redisplay hint window is mouse has been moved to a new cell
      cxHintStyleController1.HideHint;
      Timer1.Enabled := False;

      //store the current record and column
      fItem := Item;
      fGridRecord := GridRecord;

      //obtain the current cell display text
      ri := GridRecord.RecordIndex;
      ci := Item.Index;
      dayIndx := Item.Tag;

      // Èe stolpec ni pravi, ne prikazuj hinta - samo za stolpce z razporedom
      if (System.Pos(C_NAME_DAY, Item.Name) <= 0) then
         exit;

      // preverjanje èe so indeksi izven dosega
      if (ri >= globSolver.Razpored.StevOseb) or (dayIndx >= globSolver.Razpored.DayCount) then
         exit;

      // po defaultu je hint kar display text
      aHint := viRazpByMNR.DataController.DisplayTexts[ri, ci];

      with viRazpByMNR.Site.ClientToScreen(Point(X, Y)) do
      begin
         FHintDisplayed := True;

         // prepare hint
         aRec := GlobSolver.Razpored.GetRazporedElement(ri, dayIndx);
         if aRec <> nil then begin

            DateSeparator := '.';
            ShortDateFormat := 'dddd (d mmmm)';
            aHint := 'Datum: '+ DateToStr (aRec^.in_date) + chr(13);

            try
               if aRec^.recType = rtRazp then begin
                  // prisotnosti
                  aHint := aHint + 'DM: ' + aRec^.DDMI^.dem_naziv + chr(13);
                  aHint := aHint + 'Delovišèe: ' + aRec^.DDMI^.depa_opis + chr(13);
                  aHint := aHint + 'Izmena: ' + intToStr(aRec^.DDMI^.shift_no) + ' (' +
                           aRec^.DDMI^.shift_arm + ') ' + chr(13);

                  aHint := aHint + 'Obdobje: ' + FmtHoursHHMM(aRec^.DDMI^.start_hhmm) + '-' +
                           FmtHoursHHMM(aRec^.DDMI^.stop_hhmm);

                  aHint := aHint + chr(13) + 'Ure: ' + FmtHoursHHMM(aRec^.DDMI^.need_hhmm);
                  aHint := aHint + chr(13) + 'Lastnik: ' + aRec^.priimekime_owner;
                  aHint := aHint + chr(13) + 'Zadnji uporabnik: ' + aRec^.cuser;
                  aHint := aHint + chr(13) + 'Zadnja sprememba: ' + DateToStr (aRec^.cdate);
               end else begin
                  // odsotnosti
                  aHint := aHint + aRec^.vp_desc + chr(13);
                  aHint := aHint + 'Vnesel: ' + aRec^.cuser + ', ' +
                           DateToStr(aRec^.cdate) + chr(13);

                  if aRec^.status = 'O' then
                     aHint := aHint + 'Odobril: ' + aRec^.ouser + ', ' + DateToStr(aRec^.ochange);

                  if aRec.status = 'Z' then
                     aHint := aHint + 'Zavrnil: ' + aRec^.ouser + ', ' + DateToStr(aRec^.ochange);

                  aHint := aHint + chr(13) + 'DDMI: ' + IntToStr(aRec^.DDMI^.ddmi_nr);
                  aHint := aHint + chr(13) + 'Ure: ' + FmtHoursHHMM(aRec^.DDMI^.need_hhmm);
               end;
            except
               aHint := '';
            end;

         end else
            // ni razporeda, ni hinta
            aHint := '';

         // zaèasno!!
         aDirtyFlag := globSolver.Razpored.DirtyFlagGet(ri, dayIndx);

         if aDirtyFlag <> chr(0) then
            aHint := aHint + chr(13) + 'Sprememba: ' + aDirtyFlag;

         cxHintStyleController1.ShowHint(X, Y, '', AHint);
      end;
   end;
end;

procedure TfmRazp.Hint_ColumnHeader(aHitTest: TcxCustomGridHitTest; X, Y: integer);
var aHint: string;
    aDate: TDate;
    aCritNo: integer;
begin
   with TcxGridColumnHeaderHitTest(AHitTest) do begin
      if (fColumn <> Column) or not FHintDisplayed then begin
         //redisplay hint window is mouse has been moved to a new cell
         cxHintStyleController1.HideHint;
         Timer1.Enabled := False;

         //store the current record and column
         fColumn := Column;
         aHint := '';

         // Èe stolpec ni pravi, ne prikazuj hinta - samo za stolpce z razporedom
         if (System.Pos(C_NAME_DAY, Column.Name) > 0) then begin
            // header koledarj
            aDate := globSolver.Razpored.FirstDay + Column.Tag;
            aHint := FormatDateTime('dddd, d. mmmm yyyy', aDate);
         end else begin
            if (System.Pos(C_NAME_CRITERIA, Column.Name) > 0) then begin
               // header of criteria column
               aCritNo := Column.Tag - C_TAG_CRITERIA;
               case aCritNo of
                  1: aHint := 'Ure - prenos od prej';
                  2: aHint := 'Ure - vsota razporeda';
                  3: aHint := 'Ure - konèna vsota';
                  4: aHint := 'Število delovnih nedelj in praznikov - prenos od prej';
                  5: aHint := 'Število delovnih nedelj in praznikov razporeda';
                  6: aHint := 'Število delovnih nedelj in praznikov - konèno število';
                  7: aHint := 'Število noènih delovnikov - prenos';
                  8: aHint := 'Število noènih delovnikov razporeda';
                  9: aHint := 'Število noènih delovnikov - konèno število';
               end;
            end;
         end;

         with viRazpByMNR.Site.ClientToScreen(Point(X, Y)) do begin
            FHintDisplayed := True;
            cxHintStyleController1.ShowHint(X, Y, '', aHint);
            Timer1.Enabled := True;
         end;
      end;
   end;
end;

procedure TfmRazp.Hint_BandHeader(aHitTest: TcxCustomGridHitTest; X, Y: integer);
begin
   exit; // za band ni potrebe prikazovanja hinta
   with TcxGridBandHeaderHitTest(AHitTest) do begin
      if (fBand <> Band) or not FHintDisplayed then begin
         //redisplay hint window is mouse has been moved to a new cell
         cxHintStyleController1.HideHint;
         Timer1.Enabled := False;

         //store the current record and column
         fBand := Band;
         with viRazpByMNR.Site.ClientToScreen(Point(X, Y)) do begin
            FHintDisplayed := True;
            cxHintStyleController1.ShowHint(X, Y, '',  aHitTest.ClassType.ClassName + Band.DisplayName);
            Timer1.Enabled := True;
         end;
      end;
   end;
end;

// barvanje razporeda
procedure TfmRazp.OnDayXGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  ri, ci: integer;
  aRec: pRazpElem;

begin
  if (Assigned(AItem)) then begin
    ci := aitem.Tag;
    ri := aRecord.RecordIndex;

    try
       aRec := globSolver.Razpored.GetRazporedElement(ri,ci);

       if aRec = nil then
         exit;

       if aRec^.recType = rtRazp then begin

          // Imamo prisotnost, razpored
          // sprejemni zdravnih zaèasno hard-coded
          if aRec^.DDMI^.dem_arm_oznaka = 'SZ' then begin
            aStyle := cxStyleRaz4;
          end else begin
            if aRec^.DDMI.shift_no = '1' then begin
               aStyle := cxStyleRaz1;
            end else begin
               if aRec^.DDMI.shift_no = '2' then begin
                  aStyle := cxStyleRaz2;
               end else begin
                  aStyle := cxStyleRaz3;
               end;
            end;
          end;
       end else begin
         // imamo odsotnost
         if (aRec^.vp_id = 'BOL') or (aRec^.vp_id = 'B30') then
            aStyle := cxStyleOds1
         else if (aRec^.vp_id = 'DOP') then
            aStyle := cxStyleOds2
         else if (aRec^.vp_id = 'PRO') then
            aStyle := cxStyleOds4
         else if (aRec^.vp_id = 'POR') then
            aStyle := cxStyleOds3
         else
            // vse ostale ods. kot dopust
            aStyle := cxStyleOds2;
       end;
    except
    end;
  end;
end;

// procedura za preverjanje veljavnosti operacije drag - drop
procedure TfmRazp.viRazpByMNRDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  HT: TcxCustomGridHitTest;
  trgTag, srcTag: integer;
  trgRi, srcRi: integer;
  srcRec, trgRec: pRazpElem;
begin
   with TcxGridSite(Sender) do begin
      begin
         // HT je target celica
         HT := ViewInfo.GetHitTest(X, Y);
         if HT is TcxGridRecordCellHitTest then begin
            // drag drop dovoljen samo na stolpcih razporeda
            if System.Pos(C_NAME_DAY, viRazpByMNR.Controller.FocusedColumn.Name) <= 0 then begin
               // kolona ne vsebuje imena dneva, na svidenje
               Accept := false;
               exit;
            end;

            // drag drop dovoljen samo na stolpcih razporeda
            if System.Pos(C_NAME_DAY, TcxGridRecordCellHitTest(HT).Item.Name) <= 0 then begin
               // kolona ne vsebuje imena dneva, na svidenje
               Accept := false;
               exit;
            end;

            trgTag := TcxGridRecordCellHitTest(HT).Item.Tag;
            trgRi := TcxGridRecordCellHitTest(HT).GridRecord.RecordIndex;
            srcTag := viRazpByMNR.Controller.FocusedColumn.Tag;
            srcRi := viRazpByMNR.Controller.FocusedRow.RecordIndex;
            if trgTag <> srcTag then begin
               // drag izven izbranega dneva, na svidenje
               Accept := false;
               exit;
            end else begin
               // drag v istem dnevu, let's go! Preveri izvorno celico - razpored
               srcRec := globSolver.Razpored.GetRazporedElement(srcRi, srcTag);

               if (srcRec <> nil) then begin
                  // izvorna celica je polna, preveri vsebino
                  if (srcRec^.recType = rtOdsot) then begin
                     // izvorna celica je odsotnost, na svidenje
                     Accept := false;
                     exit;
                  end else begin
                     // izvorna celica je polna in vsebuje razpored; preveri kaj je na ciljni celici

                     if srcRec^.mnr_owner <> cbPrenosId.KeyValue then begin
                        // nisem lastnik razporeda, na svidenje
                        Accept := false;
                        exit;
                     end;

                     trgRec := globSolver.Razpored.GetRazporedElement(trgRi, trgTag);
                     if (trgRec <> nil) then begin
                        // ciljna celica je polna
                        if (trgRec^.recType = rtOdsot) then begin
                           // ciljna celica vsebuje odsotnost, na svidenje!
                           Accept := false;
                           exit;
                        end;

                        // izvorna in ciljna celica sta polni in obe vsebujeta razpored
                        if trgRec^.mnr_owner <> cbPrenosId.KeyValue then begin
                           // nisem lastnik ciljne celice, na svidenje
                           Accept := false;
                           exit;
                        end;

                        // preveri navzkrižno kompatibilnost
                        if (globSolver.Availability.ContainsDDMIByIndex(trgRi,
                                                                        trgTag,
                                                                        srcRec^.DDMI^.ddmi_nr) and
                            globSolver.Availability.ContainsDDMIByIndex(srcRi,
                                                                        trgTag,
                                                                        trgRec^.DDMI^.ddmi_nr))
                        then begin
                           // dovoli zamenjavo èe sta osebi v obe smeri kompatibilni
                           Accept := true;
                           exit;
                        end else begin
                           // osebi nista navzkrižno kompatibilni
                           Accept := false;
                           exit;
                        end;
                     end else begin
                        // ciljna celica je prazna, preveri kompatibilnost samo v eno smer za swap
                        if (globSolver.Availability.ContainsDDMIByIndex(trgRi,
                                                                        trgTag,
                                                                        srcRec^.DDMI^.ddmi_nr))
                        then begin
                           Accept := true;
                           exit;
                        end;
                     end;
                  end;
               end else begin
                  // izvorna celica je prazna, ne dovoli drag & drop
                  Accept := false;
                  exit;
               end;
            end;
         end;
      end;
      // vsi ostali pogoji ne dovoljujejo zamenjave
      Accept := false;
   end;
end;

procedure TfmRazp.viRazpByMNRDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
   HT: TcxCustomGridHitTest;
   trgTag, srcTag, ci: integer;
   trgRi, srcRi: integer;

   procedure SwapDisplayItems (sRi, sCi, dRi, dCi: integer);
   var aValue: variant;
   begin
      with viRazpByMNR do begin
         aValue := DataController.GetValue(dRi, dCi);
         DataController.BeginUpdate;
         DataController.SetValue(dRi,
                                 dCi,
                                 DataController.GetValue(sRi, sCi));
         DataController.SetValue(sRi, sCi, aValue);

         ShowOsebaCriteria(sRi);
         ShowOsebaCriteria(dRi);

         DataController.EndUpdate;
      end;
   end;

begin
   with TcxGridSite(Sender) do
   begin
      // HT je target celica
      HT := ViewInfo.GetHitTest(X, Y);
      if HT is TcxGridRecordCellHitTest then begin
         trgTag := TcxGridRecordCellHitTest(HT).Item.Tag;
         trgRi := TcxGridRecordCellHitTest(HT).GridRecord.RecordIndex;
         srcTag := viRazpByMNR.Controller.FocusedColumn.Tag;
         srcRi := viRazpByMNR.Controller.FocusedRow.RecordIndex;
         ci := viRazpByMNR.Controller.FocusedColumn.Index;

         GlobSolver.Razpored.SwapDDMIByIndx(srcRi, srcTag, trgRi, trgTag);
         SwapDisplayItems(srcRi, ci, trgRi, ci);
      end;
   end;
end;

procedure TfmRazp.SaveRazpored;
var
   i: integer;

   procedure DeleteAllOdsot(aMNR: integer; aLowDate, aHighDate: TDate);
   begin
      // najprej zbriši vse stare odsotnosti, forsirano, tudi odobrene
      spDelOdsot.SetVariable('P_MNR', aMNR);
      spDelOdsot.SetVariable('P_DATUM_OD', aLowDate);
      spDelOdsot.SetVariable('P_DATUM_DO', aHighDate);
      spDelOdsot.SetVariable('P_FORCE', 'D');
      spDelOdsot.Execute;
   end;

   procedure DeleteOdsotRisPair(aMNR: integer; aDate: TDate);
   var dMsg, oMsg, aMsg: string;
   begin
      with quDelOdsotRisPair do begin
         Close;
         SetVariable('P_MNR', aMNR);
         SetVariable('P_DATUM', aDate);
         try
            Execute;
         except
            on E:EOracleError do begin
               dMsg := FormatDateTime('dddd, d. mmmm yyyy', aDate);
               oMsg := IntToStr(aMNR);
               aMsg := Format(C_FMRAZPOSEB_ERROR_DELETE_ODSOT, [dMsg, oMsg, e.Message]);
               ShowMessage(aMsg);
               raise;
            end;
         end;
      end;
   end;

   procedure InsertOdsotRisPair(aRazp: pRazpElem);
   var
      aDatOd, aDatDo: TDateTime;
      aMinutes: integer;
   begin
      aMinutes := solver.HHMM_To_Minutes(aRazp^.DDMI^.start_hhmm);
      aDatOd := aRazp^.in_date +
                EncodeTime(aMinutes div 60,
                           aMinutes mod 60,
                           0, 0);

      aMinutes := solver.HHMM_To_Minutes(aRazp^.DDMI^.stop_hhmm);
      aDatDo := aRazp^.in_date +
                EncodeTime(aMinutes div 60,
                           aMinutes mod 60,
                           0, 0);


      with quInsOdsotRisPair do begin
         Close;
         SetVariable('P_MNR', aRazp^.Oseba.MNR);
         SetVariable('P_IN_DATE', aDatOd);
         SetVariable('P_OUT_DATE', aDatDo);
         SetVariable('P_HOURS_ID', aRazp^.hours_id);
         Execute;
      end;
   end;

   procedure DeleteRazpored(aMNR: integer; aLowDate, aHighDate: TDate; PrenosID: integer);
   begin
      // zbriši stari razpored
      delArmRazp.ClearVariables;
      delArmRazp.SetVariable('P_MNR', aMNR);
      delArmRazp.SetVariable('OD_DATUMA', aLowDate);
      delArmRazp.SetVariable('DO_DATUMA', aHighDate);
      delArmRazp.SetVariable('P_PRENOS_ID', PrenosID);
      delArmRazp.Execute;
   end;

   procedure SaveDateMatrix (ri: integer);
   var
      colMNR: TcxGridBandedColumn;
      aMNR: integer;
      i: integer;
      aRazp: pRazpElem;
      aDirtyFlag: char;
      aDate: TDateTime;
      dMsg, oMsg, aMsg: string;

     begin

      // zapomni si MNR osebe, s katero se ukvarjaš
      colMNR := viRazpByMNR.GetColumnByFieldName(C_NAME_MNR);
      aMNR := viRazpByMNR.DataController.GetValue(ri, colMNR.Index);


      {sprememba z uvedbo dirty flaga 28.6.2007 => brišemo samo spremenjene
      if fmSettings.rgOdsotSource.ItemIndex = 0 then
         // samo èe je vir odsotnosti "planiranje odsotnosti"
         // zbrišemo vse stare odsotnosti, forsirano, tudi odobrene
         DeleteAllOdsot(aMNR, aLowDate, aHighDate);
      }

      // zbriši stari razpored
      {
         sprememba z uvedbo dirty flaga 28.6.2007 => brišemo samo spremenjene
         DeleteRazpored(aMNR, aLowDate, aHighDate, cbPrenosId.KeyValue);
      }

      // sprehod skozi razpored in shranjevanje ne-praznih stolpcev
      for i:=0 to globSolver.Razpored.DayCount - 1 do begin
         aRazp := globSolver.Razpored.GetRazporedElement(ri, i);
         
         aDate := edDatumOd.Date + i;

         if (aRazp <> nil) then begin
            if aRazp^.recType = rtOdsot then
               // preventivno zbriši razpored pod odsotnostjo
               DeleteRazpored(aMNR, aDate, aDate, cbPrenosId.KeyValue);
         end;

         // poglej èe se je vsebina celice spremenila
         aDirtyFlag := globSolver.Razpored.DirtyFlagGet(ri, i);
         if (aDirtyFlag <> chr(0)) then begin
            // gremo v akcijo, samo èe imamo spremembo

            // najprej zbriši razpored, èe obstaja
            DeleteRazpored(aMNR, aDate, aDate, cbPrenosId.KeyValue);

            // zbrišemo stare odsotnosti

            if fmSettings.rgOdsotSource.ItemIndex = 0 then
               // èe je vir odsotnosti "planiranje odsotnosti" brišemo iz ris_pair_plan
               DeleteAllOdsot(aMNR, aDate, aDate)
            else
               // èe je vir urna lista brišemo iz urne liste
               DeleteOdsotRisPair(aMnr, aDate);

            if (aRazp <> nil) then begin
               // èe obstaja nov zapis, ga vneseš
               case aRazp^.recType of
                  rtRazp: begin   // razpored
                     if (aRazp^.mnr_owner = cbPrenosId.KeyValue) then begin
                        // samo èe sem lastnik razporeda, lahko shranim
                        spInsRazp.ClearVariables;
                        spInsRazp.SetVariable ('P_MNR', aRazp^.Oseba.MNR);
                        spInsRazp.SetVariable ('P_DATUM', aRazp^.in_date);
                        spInsRazp.SetVariable ('P_PRENOS_ID', cbPrenosId.KeyValue);
                        spInsRazp.SetVariable ('P_DEPART_ID', aRazp^.DDMI^.depart_id);
                        spInsRazp.SetVariable ('P_DEM_ID', aRazp^.DDMI^.dem_id);
                        spInsRazp.SetVariable ('P_SHIFT_ID', aRazp^.DDMI^.shift_id);
                        try
                           spInsRazp.Execute;
                        except
                           on E:EOracleError do begin
                              if E.ErrorCode = 1 then begin //ORA-0001 : DUP_VAL_ON_INDEX
                                 dMsg := FormatDateTime('dddd, d. mmmm yyyy', aRazp^.in_date);
                                 oMsg := aRazp^.Oseba.lname + ' ' +
                                         aRazp^.Oseba.fname + ' (' +
                                         IntToStr(aRazp^.Oseba.MNR) + ')';
                                 aMsg := Format(C_FMRAZPOSEB_RAZPORED_EXISTS, [dMsg, oMsg]);
                                 ShowMessage(aMsg);
                              end;
                           end;
                        end;
                     end;
                  end;
                  rtOdsot: begin
                     // vnos odsotnosti izvršimo samo, èe je vir za odsotnosti
                     // "planiranje odsotnosti"
                     // nastavi parametre procedure za vnos odsotnosti
                     if fmSettings.rgOdsotSource.ItemIndex = 0 then begin
                        with spInsOdsot do begin
                           ClearVariables;
                           SetVariable ('P_MNR', aRazp^.Oseba.MNR);
                           SetVariable ('P_DATUM', aRazp^.in_date);
                           SetVariable ('P_VP_ID', aRazp^.vp_id);
                           SetVariable ('P_STATUS', aRazp^.Status);
                           SetVariable ('P_DELETE_OLD', 'D');
                           Execute;
                        end;
                     end else begin
                        InsertOdsotRisPair(aRazp);
                     end;
                  end;
               end;
            end;
         end; //aDirtyFlag
      end; // for
   end;

begin
   try
      // Sprehod skozi grid
      for i := 0 to viRazpByMNR.DataController.RecordCount - 1 do begin
         SaveDateMatrix (i);
      end;

      dmOracle.oraSession.Commit;
      globSolver.Razpored.DirtyFlagsClean;
      MessageDlg('Uspešno shranjeno!', mtInformation, [mbOk], 0);
   except
      dmOracle.oraSession.Rollback;
      MessageDlg('Napaka med shranjevanjem!', mtError, [mbOk], 0);
   end;

end;


procedure TfmRazp.miKF1Click(Sender: TObject);
begin
   ShowHideColumns;
end;

procedure TfmRazp.miDragDropClick(Sender: TObject);
begin
   if TMenuItem(Sender).Name = 'miDragDrop' then
      miPovleciSpusti.Checked := miDragDrop.Checked
   else
      miDragDrop.Checked := miPovleciSpusti.Checked;

   if (miDragDrop.Checked) then
      viRazpByMNR.DragMode := dmAutomatic
   else
      viRazpByMNR.DragMode := dmManual;
end;

procedure TfmRazp.miOdsotNewClick(Sender: TObject);
var aStatus, aVP: string;
    aRes: TModalresult;
begin
   fmSelOds := tFmSelOds.Create(self);
   try
      with fmSelOds do begin
         cxHintStyleController1.HideHint;
         ShowModal;
         aRes := ModalResult;
         if  aRes = mrOk then begin
            aVP:=fmSelOds.quRisHourVP_ID.AsString;
            if fmSelOds.cbOdobrena.Checked then
               aStatus := 'O'
            else
               aStatus := 'V';
         end;
         Destroy;
      end;
   finally
   end;


   if aRes = mrOk then
      SelectedCelsOper(operOdsotNew,
                       aVP,
                       aStatus,
                       null,
                       null,
                       null,
                       null);

end;

procedure TfmRazp.EnableDisablePopupMenuItems;
var
   nRows, nCols: integer;

   // procedura onemogoèi vse opcije popup menija
   procedure DisableAllItems;
   var ii:integer;
   begin
      for ii := 0 to mnuPopup.Items.Count - 1 do begin
         mnuPopup.Items.Items[ii].Enabled := false;
      end;
   end;

   // procedura omogoèi vnos nove neodobrene odsotnosti
   procedure miOdsotNewEnable;
   var I, J: integer;
       rowIndx, colIndx: integer;
       aRec: pRazpElem;
   begin
      if ((nRows < 1) or (nCols < 1)) then
         // èe ni niè izbrano tudi niè ne moremo storiti
         exit;

      {
      if fmSettings.rgOdsotSource.ItemIndex > 0 then
         // èe vir odsotnosti ni "Planiranje odsotnosti", potem pozabi na vnos
         exit;
      }

      // preglej izbrano podroèje. Samo èe je podroèje prazno se vnos prižge
      for I := 0 to nRows - 1 do begin
         rowIndx := viRazpByMNR.Controller.SelectedRows[I].RecordIndex;

         for J := 0 to nCols - 1 do begin
            colIndx := viRazpByMNR.Controller.SelectedColumns[J].Tag;
            aRec := globSolver.Razpored.GetRazporedElement(rowIndx, colIndx);
            if (aRec <> nil) then begin
               // našel sem odsotnost ali razpored, na svidenje
               if aRec.recType in [rtOdsot, rtRazp] then
                  exit;
            end;
         end;
      end;

      miOdsotNew.Enabled := true;
      miProsto.Enabled := true;
   end;

   // procedura omogoèi brisanje, odobritev in zavrnitev neodobrenih odsotnosti
   procedure miOdsotDelEnable;
   var I, J: integer;
       rowIndx, colIndx: integer;
       aRec: pRazpElem;
   begin
      if ((nRows < 1) or (nCols < 1)) then
         // èe ni niè izbrano tudi niè ne moremo storiti
         exit;

      {
      if fmSettings.rgOdsotSource.ItemIndex > 0 then
         // èe vir odsotnosti ni "Planiranje odsotnosti", potem pozabi na vnos
         exit;
      }

      // Preglej izbrano podroèje. Èe podroèje vsebuje vsaj eno
      // odsotnost, omogoèi brisanje le - te.
      // Èe podroèje vsebuje vsaj eno neodobreno odsotnost, omogoèi tudi odobritev / zavrnitev
      for I := 0 to nRows - 1 do begin
         rowIndx := viRazpByMNR.Controller.SelectedRows[I].RecordIndex;

         for J := 0 to nCols - 1 do begin
            colIndx := viRazpByMNR.Controller.SelectedColumns[J].Tag;

            aRec := globSolver.Razpored.GetRazporedElement(rowIndx, colIndx);
            if (aRec <> nil) then begin
               if aRec^.recType = rtOdsot then begin
                  // našel odsotnost, omogoèi brisanje
                  miOdsotDel.Enabled := true;
                  miProDel.Enabled := true;

                  if aRec^.status = 'V' then begin
                     miOdsotOdobri.Enabled := true;
                     miOdsotZavrni.Enabled := true;;
                  end;
               end;
            end;
         end;
      end;
   end;

   // procedura omogoèi brisanje, odobritev in zavrnitev neodobrenih odsotnosti
   procedure miRazpDelEnable;
   var I, J: integer;
       rowIndx, colIndx: integer;
       aRec: pRazpElem;
   begin
      if ((nRows < 1) or (nCols < 1)) then
         // èe ni niè izbrano tudi niè ne moremo storiti
         exit;

      // Preglej izbrano podroèje. Èe podroèje vsebuje vsaj en
      // razpored, omogoèi brisanje le - tega.
      for I := 0 to nRows - 1 do begin
         rowIndx := viRazpByMNR.Controller.SelectedRows[I].RecordIndex;

         for J := 0 to nCols - 1 do begin
            colIndx := viRazpByMNR.Controller.SelectedColumns[J].Tag;

            aRec := globSolver.Razpored.GetRazporedElement(rowIndx, colIndx);
            if (aRec <> nil) then begin
               if aRec^.recType = rtRazp then begin

                  {
                  if (aRec^.mnr_owner <> cbPrenosId.KeyValue) then begin
                     // èe obmoèje vsebuje vsaj en tuji razpored, ni možno brisanje
                     miRazpDel.Enabled := false;
                     exit;
                  end;
                  }
                  // našel razpored, omogoèi brisanje
                  miRazpDel.Enabled := true;
               end;
            end;
         end;
      end;
   end;

   // procedura omogoèi sidranje DDMI
   procedure miSidrajDDMIEnable;
   var rowIndx, colIndx, J: integer;
       aRec: pRazpElem;
   begin
      if ((nRows <> 1) or (nCols < 1)) then
         // izbrana mora biti natanko 1 vrstica
         exit;

      rowIndx := viRazpByMNR.Controller.SelectedRows[0].RecordIndex;

      for J := 0 to nCols - 1 do begin
         // preglej vrstico.
         colIndx := viRazpByMNR.Controller.SelectedColumns[J].Tag;

         aRec := globSolver.Razpored.GetRazporedElement(rowIndx, colIndx);
         if (aRec <> nil) then begin
            if aRec^.recType = rtRazp then begin
               // našel sem razpored
               if (aRec^.mnr_owner <> cbPrenosId.KeyValue) then begin
                  // èe obmoèje vsebuje vsaj en tuji razpored, ni možen vnos novega razporeda
                  miSidrajRazpored.Enabled := false;
                  exit;
               end;
            end else begin
               // našel sem odsotnost, na svidenje;
               miSidrajRazpored.Enabled := false;
               exit;
            end;
         end;
      end;

      miSidrajRazpored.Enabled := true;
   end;

begin
   nRows := viRazpByMNR.Controller.SelectedRowCount;
   nCols := viRazpByMNR.Controller.SelectedColumnCount;

   // najprej onemogoèi vse izbire
   DisableAllItems;

   // Vnos nove odsotnosti je možen samo, èe selekcija ne prekriva obstojeèe
   // odsotnosti ali razporeda.
   miOdsotNewEnable;

   // Brisanje odsotnosti je možno samo, èe selekcija vsebuje vsaj eno neodobreno
   // odsotnost.
   miOdsotDelEnable;

   // Brisanje razporeda je možno samo, èe selekcija vsebuje vsaj en razpored
   // odsotnost.
   miRazpDelEnable;

   // omogoèi vnos razporeda
   miSidrajDDMIEnable;

   // Dnevni pogled je vedno omogoèen
   miDnevni.Enabled := true;

   // Oznaèi vse in oznaèi dan sta vedno omogoèena
   miSelectAll.Enabled := true;
   miSelectDay.Enabled := true;

   // Povleci spusti vedno enabled
   miPovleciSpusti.Enabled := true;
end;



procedure TfmRazp.mnuPopupPopup(Sender: TObject);
begin
   EnableDisablePopupMenuItems;
end;

procedure TfmRazp.SelectCells(odDneva, doDneva: tDate);
var fColFrom, fColTo: TCXGridColumn;
begin
   fColFrom := TCXGridColumn(viRazpByMNR.Columns[GetGridColumnIndex(odDneva)]);
   fColTo := TCXGridColumn(viRazpByMNR.Columns[GetGridColumnIndex(doDneva)]);

   viRazpByMNR.Controller.SelectCells(fColFrom, fColTo, 0, viRazpByMNR.DataController.GetRowCount-1);
end;

procedure TfmRazp.SelectedCelsOper(aOper: tOpers; // operacija
                                   aVal: variant; // text viden v gridu
                                   aShiftNo: variant; // fiksiran turnus ali status odobritve odsotnosti
                                   aDepartId: variant; // fiksirano delovišèe
                                   aDemId: variant; // fiksirano DM
                                   aShiftId: variant; // fiksirana izmena
                                   aUser1: variant); // praznik da ne

  function SelectedRowCount: Integer;
  begin
    Result := viRazpByMNR.Controller.SelectedRowCount;
  end;

  function SelectedColumnCount: Integer;
  begin
    Result := viRazpByMNR.Controller.SelectedColumnCount;
  end;

  // vnos nove odsotnosti
  procedure SelectionNewOdsot (aVp: string;
                               aStatus: Variant);
  var
    I, J, rowIndx, colIndx: Integer;
    colMNR: TcxGridBandedColumn;
    aDay: integer;
    pOdsot: pRazpElem;
    aDate: TDate;
    aMNR: integer;

  begin
    if aVp = null  then
      raise exception.Create('Izberi vrsto odsotnosti!');

    // zapomni si stolpec, kjer je MNR
    colMNR := viRazpByMNR.GetColumnByFieldName(C_NAME_MNR);

    // sprehod skozi oznaèene celice, lahko tudi za veè oseb za veè dni
    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viRazpByMNR.Controller.SelectedRows[I].RecordIndex;

      // mnr osebe!
      aMNR :=viRazpByMNR.DataController.GetValue(rowIndx, colMNR.Index);

      // sprehod skozi vse dneve za osebo in vnos novih zapisov

      for J := 0 to SelectedColumnCount - 1 do begin
         colIndx := viRazpByMNR.Controller.SelectedColumns[J].Index;

         // izraèunaj na kateri datum dodajaš odsotnost
         aDay := viRazpByMNR.Columns[colIndx].Tag - C_TAG_MIN_OFF;
         aDate := globSolver.Razpored.FirstDay + aDay;

         // poišèi dodatne podatke odsotnosti in nastavi memory record
         if (quRisHour.Locate('VP_ID', VarArrayOf([aVP]), [])) then begin
            new(pOdsot);
            pOdsot^.recType := rtOdsot;
            pOdsot^.in_date := aDate;

            pOdsot^.hours_id := quRisHourHOURS_ID.AsInteger;
            pOdsot^.vp_id := aVP;
            pOdsot^.vp_desc := quRisHourDESCRIPTION.AsString;
            pOdsot^.status := aStatus;

            if aStatus = 'O' then begin
               pOdsot^.ouser := dmOracle.oraSession.LogonUsername;
               pOdsot^.ochange := Date;
            end;

            pOdsot^.cuser := dmOracle.oraSession.LogonUsername;
            pOdsot^.cdate := Date;

            // poišèi obvezo za ta da
            if (quObveza.Locate('MNR;CDATE', VarArrayOf([aMNR, aDate]), [])) then begin
               globSolver.Razpored.AddRemoveOdsot(aMNR,
                                                  aDate,
                                                  pOdsot,
                                                  quObveza.FieldByName ('START_HHMM').AsInteger,
                                                  quObveza.FieldByName ('STOP_HHMM').AsInteger,
                                                  quObveza.FieldByName ('NEED_HHMM').AsInteger);
            end else
               raise Exception.Create(C_EXCEPT_MSG_NO_VI_RIS08);

            // za konec nastavi vrednost celice v Gridu - GUI
            viRazpByMNR.DataController.BeginUpdate;
            viRazpByMNR.DataController.SetValue(rowIndx, colIndx, aVal);
            //viRazpByMNR.DataController.SetEditValue(colIndx, aVal, evsValue);
            viRazpByMNR.DataController.EndUpdate;

         end;
         ShowOsebaCriteria(rowIndx);
      end;
   end;
  end;


  // sprememba statusa odsotnosti
  procedure SelectionSpremeniStatusOdsot (aStatus: Variant);
  var
    I, J, rowIndx, colIndx: Integer;
    aRec: pRazpElem;

  begin
    // sprehod skozi oznaèene celice
    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viRazpByMNR.Controller.SelectedRows[I].RecordIndex;

      for J := 0 to SelectedColumnCount - 1 do begin
        colIndx := viRazpByMNR.Controller.SelectedColumns[J].Tag;

        aRec := globSolver.Razpored.GetRazporedElement(rowIndx, colIndx);

        // nastavi status
        aRec^.status := aStatus;

        // pobriši ali nastavi userja in datum odobritve
        if (aStatus = 'V') then begin
          aRec^.ouser := '';
          aRec^.ochange := null;
        end else begin
          aRec^.ouser := dmOracle.oraSession.LogonUsername;
          aRec^.ochange := Date;
        end;
      end;
   end;
  end;

  procedure SelectionDeleteValues(whatType: tRazpRecType;
                                  ShiftNo: variant;
                                  delovniki: boolean;
                                  sobote: boolean;
                                  nedelje: boolean;
                                  prazniki: boolean;
                                  VP_ID: variant);
  var
    I, J, rowIndx, colIndx: Integer;
    aRazpElem: pRazpElem;
    doDelete, doDelete1, doDelete2: boolean;
  begin
    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viRazpByMNR.Controller.SelectedRows[I].RecordIndex;
      for J := 0 to SelectedColumnCount - 1 do begin
         colIndx := viRazpByMNR.Controller.SelectedColumns[J].Tag;
         aRazpElem := globSolver.Razpored.GetRazporedElement(rowIndx, colIndx);
         doDelete := false;
         doDelete1 := false;
         doDelete2 := true;

         if (aRazpElem <> nil) then begin
            if (aRazpElem^.recType = whatType) then begin

               if aRazpElem^.recType = rtOdsot then begin
                  // odsotnost, extra pogoj za brisanje
                  if VP_ID <> null then begin
                     if (aRazpElem^.vp_id = VP_ID) then
                        // VP ki ga brišemo prinesemo v ShiftNo
                        doDelete2 := true
                     else
                        doDelete2 := false;
                  end else
                     doDelete2 := true;
               end;


               // preverjanje na koledar
               if dmOracle.isPraznik(aRazpElem^.in_date) then begin
                  if prazniki then
                     doDelete1 := true;
               end else begin
                  if delovniki then begin
                     if DayOfTheWeek(aRazpElem^.in_date) in [1,2,3,4,5] then
                        doDelete1 := true;
                  end;

                  if sobote then begin
                     if DayOfTheWeek(aRazpElem^.in_date) = 6 then
                        doDelete1 := true;
                  end;

                  if nedelje then begin
                     if DayOfTheWeek(aRazpElem^.in_date) = 7 then
                        doDelete1 := true;
                  end;
               end;

               //preverjanje na turnus
               if ShiftNo = null then begin
                  // null, briši ne glede na oznako turnusa
                  doDelete := true;
               end else begin
                  if (aRazpElem^.DDMI^.shift_no = ShiftNo) then
                     doDelete := true;
               end;

               // preveri lastništvo, èe nisi lastnik, nema brisanja
               if ((aRazpElem^.recType = rtRazp) and
                   (aRazpElem^.mnr_owner <> cbprenosID.KeyValue)) then
                  doDelete := false;

               if doDelete and doDelete1 and doDelete2 then begin
                  globSolver.Razpored.MtxElementDel(rowIndx, colIndx);
                  colIndx := viRazpByMNR.Controller.SelectedColumns[J].Index;
                  // zbriši text v gridu
                  viRazpByMNR.DataController.BeginUpdate;
                  viRazpByMNR.DataController.SetValue(rowIndx, colIndx, '');
                  //viRazpByMNR.DataController.SetEditValue(colIndx, '', evsValue);
                  viRazpByMNR.DataController.EndUpdate;
               end;
            end;
         end;
      end;
      ShowOsebaCriteria(rowIndx);
   end;
  end;

  // vnos sidranja
  procedure SelectionSetRazpored (aVal: string; DepartID, DemID, ShiftID: variant);
  var
    I, J, rowIndx, colIndx: Integer;
    colMNR: TcxGridBandedColumn;
    aDay: integer;
    aDate: TDate;
    aMNR: integer;
    aRazpElem: pRazpElem;
    aTxt: string;

  begin
    // zapomni si kolono kjer je MNR
    colMNR := viRazpByMNR.GetColumnByFieldName(C_NAME_MNR);

    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viRazpByMNR.Controller.SelectedRows[I].RecordIndex;

      // mnr osebe!
      aMNR := viRazpByMNR.DataController.GetValue(rowIndx, colMNR.Index);

      for J := 0 to SelectedColumnCount - 1 do begin
        colIndx := viRazpByMNR.Controller.SelectedColumns[J].Index;

        // izraèunaj datum, dobiš ga v tagu
        aDay := viRazpByMNR.Columns[colIndx].Tag - C_TAG_MIN_OFF;
        aDate := globSolver.Razpored.FirstDay + aDay;

        // nastavi element razporeda
        globSolver.Razpored.AddRemoveDDMI(aMNR, aDate, departID, DemID, ShiftID,
                                          dmOracle.oraSession.LogonUsername,
                                          Now,
                                          cbPrenosId.KeyValue);

        // nastavi naèin prikaza v celici
        aRazpElem := globSolver.Razpored.GetRazporedElement(rowIndx, aDay);
        aTxt := FormatCellData(CellShowMode, aRazpElem^.DDMI, aRazpElem^.mnr_owner);

        // nastavi text v gridu
        viRazpByMNR.DataController.SetEditValue(colIndx, aTxt, evsValue);

      end;
      ShowOsebaCriteria(rowIndx);
   end;
  end;

begin
   viRazpByMNR.DataController.BeginUpdate;
   case aOper of
      operOdsotNew: begin
         // vnos nove odsotnosti
         SelectionNewOdsot (aVal, aShiftNo);
         end;

      operOdsotDel: begin
         // brisanje neodobrene odsotnosti
         SelectionDeleteValues(rtOdsot, null, true, true, true, true, aVal);
      end;

      operOdsotOdobri: begin
         // odobritev odsotnosti
         SelectionSpremeniStatusOdsot('O');
      end;

      operOdsotZavrni: begin
         // odobritev odsotnosti
         SelectionSpremeniStatusOdsot('Z');
      end;

      operRazpSidraj: begin
         // sidranje razporeda
         SelectionSetRazpored(aVal, aDepartID, aDemId, aShiftID);
      end;

      operRazpDel: begin
         // brisanje razporeda
         SelectionDeleteValues(rtRazp, aShiftNo, aDepartId, aDemId, aShiftId, aUser1, null)
      end;

   end;
   viRazpByMNR.DataController.EndUpdate;
end;


procedure TfmRazp.miOdsotDelClick(Sender: TObject);
begin
   Screen.Cursor := crHourglass;
   SelectedCelsOper(operOdsotDel,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null);
   Screen.Cursor := crDefault;
end;

procedure TfmRazp.miSidrajRazporedClick(Sender: TObject);
   var
      colMNR: TcxGridBandedColumn;
      rowIndx: integer;
      loDat, hiDat: TDAteTime;
      aDisp: string;
      myDDMI: pDDMIElem;

   function GetSelectedDDMIFromLB: pDDMIElem;
   var i, aPos: integer;
       aTxt: string;
       aDDMINr: integer;
       aDDMI: pDDMIElem;
   begin
      with fmSelDDMI do begin
         for i := 0 to lbDDMIs.Count - 1 do begin
            if lbDDMIs.Selected[i] then begin
               aTxt := lbDDMIs.Items[i];
               aPos := Pos(lbDDMIs.Delimiter, aTxt);
               aTxt := LeftStr(aTxt, aPos-1);
               aDDMINr := StrToInt(aTxt);
               aDDMI := globSolver.DDMIList.Items[aDDMINr-1];
               Result := aDDMI;
               exit;
            end;
         end;
      end;
      Result := nil;
   end;

   function getLowHighDateFromSelection(var loDate: TDateTime; var hiDate: TDateTime): boolean;
   var
      nCols: integer;
      loColIndx, hiColIndx: integer;
      aLoDay, aHiDay: integer;
   begin
      // datum od-do ugotovimo is selectiona
      nCols := viRazpByMNR.Controller.SelectedColumnCount;

      try
         // najdi indexa skrajne leve in desne celice
         loColIndx := viRazpByMNR.Controller.SelectedColumns[0].Index;
         hiColIndx := viRazpByMNR.Controller.SelectedColumns[nCols-1].Index;

         // zapiši datum, ki je v tagu
         aLoDay := viRazpByMNR.Columns[loColIndx].Tag - C_TAG_MIN_OFF;
         aHiDay := viRazpByMNR.Columns[hiColIndx].Tag - C_TAG_MIN_OFF;

         loDate := edDatumOd.Date + aLoDay;
         hiDate:= edDatumOd.Date + aHiDay;

         Result := true;

      except
         Result := false;
      end;

   end;

begin

   // zapomni si kolono kjer je MNR
   colMNR := viRazpByMNR.GetColumnByFieldName(C_NAME_MNR);
   rowIndx := viRazpByMNR.Controller.SelectedRows[0].RecordIndex;

   fmSelDDMI := TfmSelDDMI.create(self);
   cxHintStyleController1.HideHint;
   with fmSelDDMI do begin
      // mnr osebe!
      edMNR.Text :=  viRazpByMNR.DataController.GetValue(rowIndx, colMNR.Index);

      if getLowHighDateFromSelection (loDat, hiDat) then begin
         edDatumOd.Date := loDat;
         edDatumDo.Date := hiDat;
         ShowModal;

         if ModalResult = mrOk then begin
            // poišèi DDMI ki je izbran v dialogu
            myDDMI := GetSelectedDDMIFromLB;

            if myDDMI <> nil then begin
               aDisp := FormatCellData(CellShowMode, myDDMI, cbPrenosID.KeyValue);
               SelectedCelsOper(operRazpSidraj,
                             aDisp,
                             null,
                             myDDMI^.depart_id,
                             myDDMI^.dem_id,
                             myDDMI^.shift_id,
                             null);

            end;
         end;
      end else
         MessageDlg ('Napaka pri izboru!', mtError, [mbOk], 0);
      Destroy;
   end;
end;

procedure TfmRazp.SaveToFiles(trgDir: string);
var
   aFName: string;
begin
   aFName := trgDir + '\' + 'P9-List.txt';
   GlobSolver.DDMIListSaveToFile(aFName, false);

   aFName := trgDir + '\' + 'P9-Osebe_seznam.txt';
   globSolver.OsebeListSaveToFile(aFName);

   aFName := trgDir + '\' + 'P9-Plan.txt';
   GlobSolver.Plan.SaveToFile(aFName);

   aFName := trgDir + '\' + 'P9-Razp.txt';
   GlobSolver.Razpored.SaveToFile(aFName);

   aFName := trgDir + '\' + 'P9-Dnevi.txt';
   GlobSolver.Razpored.SaveDneviToFile(aFName);

   aFName := trgDir + '\' + 'P9-Osebe.txt';
   GlobSolver.Availability.SaveToFile(aFName);

   aFName := trgDir + '\' + 'P9-Pren.txt';
   GlobSolver.OsebePrenosiSaveToFile(aFName);

   aFName := trgDir + '\' + 'P9-KritStart.txt';
   GlobSolver.OsebeKritStartSaveToFile(aFName);
end;


procedure TfmRazp.bbSolveClick(Sender: TObject);
var
   raz: TSolvInterface;
   aDebugM: tDebugMode;
   SolveItAgain: boolean;
   bDontAskMe: boolean;
   bUncomplete: boolean;
label
   SOLVE_HERE;

procedure FillDDMIsToSolve;
var i, aPos: integer;
    aTxt: string;
    aDDMINr: integer;
    aDDMI: pDDMIElem;
begin
   with fmSolverOpt do begin
      for i := 0 to lbDDMIs.Count - 1 do begin
         if lbDDMIs.Selected[i] then begin
            aTxt := lbDDMIs.Items[i];
            aPos := Pos(lbDDMIs.Delimiter, aTxt);
            aTxt := LeftStr(aTxt, aPos-1);
            aDDMINr := StrToInt(aTxt);
            aDDMI := globSolver.DDMIList.Items[aDDMINr-1];
            raz.DDMITSAdd(aDDMI);
         end;
      end;
   end;
end;

procedure CheckFeasibility;
// v bistvu kopija procedure Solver.CheckFeasibility, samo da lahko interaktivno popravljaš plan
var dIndx, j, needOseb, imamOseb: integer;
    sumNeedOseb, sumImamOseb: integer; // skupno potrebno in razpoložljivo število oseb na dan d
    aPlanList: tList;
    aMsg, aDay, aDDMi: string;

begin
   for dIndx := 0 to globSolver.Plan.DayCount - 1 do begin
      aPlanList := globSolver.Plan.planListGetForDay(dIndx);
      sumNeedOseb := 0;
      if aPlanList <> nil then begin
         for j:=0 to aPlanList.Count - 1 do begin
            needOseb := pPlanElem(aPlanList.Items[j])^.minOseb;
            sumNeedOseb := sumNeedOseb + needOseb;
            imamOseb := globSolver.Availability.GetStevOsebForDDMI(globSolver.Plan.FirstDay + dIndx,
                                                        pPlanElem(aPlanList.Items[j])^.DDMI^.ddmi_nr);

            if (imamOseb < needOseb) then begin
               aDay := FormatDateTime('dd mmmm yyyy', globSolver.Plan.FirstDay + dIndx);
               aDDMI := Format ('%d (%s - %s - %s)',
                                 [pPlanElem(aPlanList.Items[j])^.DDMI^.ddmi_nr,
                                  pPlanElem(aPlanList.Items[j])^.DDMI^.depa_opis,
                                  pPlanElem(aPlanList.Items[j])^.DDMI^.dem_naziv,
                                  pPlanElem(aPlanList.Items[j])^.DDMI^.shift_desc
                                  ]
                                );
               aMsg := Format (C_EXCEPT_MSG_NO_SOLUTION,
                               [aDay, aDDMI, needOseb, imamOseb]);

               if bDontAskMe then begin
                  pPlanElem(aPlanList.Items[j])^.minOseb := imamOseb;
                  bUncomplete := true;
               end else begin
                   case MessageDlg(aMsg + ' ' + C_FMRAZPOSEB_MINIMIZE_PLAN,
                                   mtConfirmation, [mbYes, mbNo, mbYesToAll], 0) of
                     mrYes: begin// prilagajanje plana!
                        pPlanElem(aPlanList.Items[j])^.minOseb := imamOseb;
                        bUncomplete := true;
                     end;
                     mrYesToAll:
                        bDontAskMe := true;
                   else
                     raise Exception.Create (aMsg);
                   end;
               end;

               fmResults.memo.Lines.Add(aMsg + ' ' + C_FMRAZPOSEB_PLAN_MINIMIZED);
            end;
         end;
      end;

      // za dan dIndx poglej koliko oseb imaš suma sumarum
      sumImamOseb := globSolver.Availability.GetStevRazpOsebForDay(globSolver.Razpored.FirstDay + dIndx);
      if (sumImamOseb < sumNeedOseb) then begin
         aDay := FormatDateTime('dd mmmm yyyy', globSolver.Plan.FirstDay + dIndx);
         aMsg := Format(C_EXCEPT_MSG_NO_SOLUTION_SUM, [aDay, sumNeedOseb, sumImamOseb]);

         fmResults.memo.Lines.Add(aMsg + ' ' + C_FMRAZPOSEB_DAY_SKIPED);

         if bDontAskMe then
            // prilagajanje plana! Na ta dan vsem elementom postavim 0
            globSolver.Plan.SetAllDayElementsToZero(dIndx)
         else begin
            case MessageDlg(aMsg + ' ' + C_FMRAZPOSEB_SKIP_DAY,
                              mtConfirmation, [mbYes, mbNo, mbYesToAll], 0) of
               mrYes: begin
                  // prilagajanje plana! Na ta dan vsem elementom postavim 0
                  globSolver.Plan.SetAllDayElementsToZero(dIndx);
                  bUncomplete := true;
               end;
               mrYesToAll: begin
                  bDontAskMe := true;
                  // prilagajanje plana! Na ta dan vsem elementom postavim 0
                  globSolver.Plan.SetAllDayElementsToZero(dIndx);
                  bUncomplete := true;
               end;
            else
               raise Exception.Create (aMsg);
            end;
         end;
      end;
   end;
end;

begin
   fmResults.Header;
   fmSolverOpt := tfmSolverOpt.Create(self);
   raz := TSolvInterface.Create;
   bUncomplete := false;

   try
      ProgressInit(5,1); // skupno 5 korakov, velikost koraka = 1
      ProgressInfo(C_PROGRESS_INFO_SOLVER_CHECK);
      // preveri omejitve razreševalca
      raz.CheckLimits;

      ProgressInfo(C_PROGRESS_INFO_SOLVER_CHECK_RUN);
      // preveri èe se datumi ujemajo oz. je bil solver inicializiran
      globSolver.CheckDateLimits(edDatumOd.Date, edDatumDo.Date);

      fmSolverOpt.ShowModal;

      with fmSolverOpt do begin
         if (ModalResult = mrOK) then begin

            // nastavi debug mode
            if rbDebugNone.Checked then
               aDebugM := dmNone
            else begin
               if rbDebugNormal.Checked then
                  aDebugM := dmNormal
               else
                  aDebugM := dmFull;
            end;

            raz.DebugInit(aDebugM);

            if rgScope.ItemIndex = 0 then begin
               raz.optPlanScope := psFull;
               fmResults.memo.Lines.Add('Naèin razreševanja: Celotni razpored.');
            end else begin
               if rgScope.ItemIndex = 1 then begin
                  // razrešujemo samo nedelje in praznike, prilagodi
                  // parametre
                  fmResults.memo.Lines.Add('Naèin razreševanja: Nedelje in prazniki.');
                  raz.optPlanScope := psSunHoly;
                  raz.optSortType := stUre;
                  raz.optGroupMinutes := 300;
               end else begin
                  // razrešujemo samo iz liste DDMIjev
                  fmResults.memo.Lines.Add('Naèin razreševanja: Izbrani seznam DDMI.');
                  raz.optPlanScope := psDDMIList;
                  raz.optSortType := stUre;
                  raz.optGroupMinutes := 300;
                  FillDDMIsToSolve;
               end;
            end;

            bDontAskMe := false;

            // sedaj preveri rešljivost problema, ampak samo èe razrešuješ na ful
            if raz.optPlanScope = psFull then
               CheckFeasibility;

            // zapisuj debug info v datoteko
            SaveToFiles(edDir.Text);

SOLVE_HERE: ProgressInfo(C_PROGRESS_INFO_SOLVING);

            // tukaj šele poklièemo solver
            try
               SolveItAgain := false;
               if rbCritAuto.Checked then begin
                  raz.SolveBest;
               end else begin
                  if rbCritStrict.Checked then begin
                     raz.SolveStrict;
                  end else begin
                     // ta metoda je najmanj striktna
                     raz.optKrsenjeKriterijevAllow := true;
                     raz.optDeleteInvalidDDMI := false;
                     raz.solve;
                  end;
               end;
            except
               on E: ENiResitve do begin
                  // dajmo userju možnost, da preskoèi problematièni dan.
                  fmResults.memo.Lines.Add(E.Message + ' ' + C_FMRAZPOSEB_DAY_SKIPED);
                  if bDontAskMe then begin
                     bUncomplete := true;
                     globSolver.Plan.SetAllDayElementsToZero(E.DayIndex);
                     solveItAgain := true;
                  end else begin
                     // V bistvo za ta dan pobijemo plan => ni razporeda
                     case MessageDlg(E.Message + ' ' + C_FMRAZPOSEB_SKIP_DAY,
                                 mtConfirmation, [mbYes, mbNo, mbYesToAll], 0) of
                        mrYes: begin
                           // prilagajanje plana! Na ta dan ukinem celoten plan
                           // v bistvu vsem elementom v planu zahtevam 0 oseb
                           globSolver.Plan.SetAllDayElementsToZero(E.DayIndex);
                           bUncomplete := true;
                           solveItAgain := true;
                        end;
                        mrYesToAll: begin
                           // prilagajanje plana! Na ta dan ukinem celoten plan
                           // v bistvu vsem elementom v planu zahtevam 0 oseb
                           globSolver.Plan.SetAllDayElementsToZero(E.DayIndex);
                           bUncomplete := true;
                           solveItAgain := true;
                           bDontAskMe := true;
                        end;

                     else
                        raise Exception.Create (E.Message);
                     end;
                  end;
               end;
            end;

            if SolveItAgain then
               goto SOLVE_HERE;
             // Sprem Status pove uspeh/neuspeh solverja
            // Status = 0 ==> neuspesen razpored
            // Status = 1 ==> ok
            // Status = -1 ==> napaka
            // Ce Status=1 potem je rezultat v spremenljivki DMIValsOut: TDMIValsOut
            //  TDMIValsOut = array[TDanIdx, TOsebaIdx] of TDMI ;
            if raz.Status > 0 then begin
               raz.preveriresitev(raz.DMIVals); // NEPOTREBNO

               fmResults.Footer;

               if bUncomplete then
                  fmResults.memo.Lines.Add('NAPAKA: Rešitev je delna.')
               else
                  fmResults.memo.Lines.Add('OK: Rešitev ustreza.');

               fmResults.ShowModal;

               globSolver.Razpored.LoadResultsFromStructure(raz.DMIValsOut, cbPrenosId.KeyValue);
               ProgressInfo(C_PROGRESS_INFO_DATA_SHOW);
               LoadGridFromSolver;
            end;

            ProgressInfo(C_PROGRESS_INFO_GRID_SIZE);
            viRazpByMNR.ApplyBestFit();

         end;
      end;
   finally
      ProgressClose;
      raz.Destroy;
      fmSolverOpt.Destroy;
   end;

  {
  //tako je bilo vèasih ko solver ni bil integriran
  SaveToFiles;

  MessageDlg ('Problem uspešno zapisan v vmesne datoteke. Poženi razreševalca in shrani rezultat!',
               mtWarning, [mbOK], 0);
  if (MessageDlg ('Ali uvozim rezultate iz razreševalca?',
                mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
      globSolver.Razpored.LoadResultsFromFile(edFName.FileName);
      LoadGridFromSolver;
  end;
  }
end;

procedure TfmRazp.PremakniMesec(koliko: integer);
var aY, aM, aD: word;
    anOldDate: tDate;
begin
   anOldDate := edDatumOd.Date;
   DecodeDate (anOldDate, aY, aM, aD);

   aM := aM + koliko;

   if aM > 12 then begin
      aM := 1;
      aY := aY + 1;
   end;

   if aM <= 0 then begin
      aM := 12;
      aY := aY -1;
   end;

   edDatumOd.Date := EncodeDate(aY, aM, 1);
   edDatumDo.Date := EndOfTheMonth(edDatumOd.Date);
end;


procedure TfmRazp.sbPrevClick(Sender: TObject);
begin
   PremakniMesec(-1);
end;

procedure TfmRazp.sbNextClick(Sender: TObject);
begin
   PremakniMesec(1);
end;

procedure TfmRazp.miRazpDelClick(Sender: TObject);
var aRes: TModalresult;
begin
   fmRazpDeleteOpt := tFmRazpDeleteOpt.Create(self);

   with fmRazpDeleteOpt do begin
      cxHintStyleController1.HideHint;
      ShowModal;
      aRes := ModalResult;
      if aRes = mrOk then begin
         Screen.Cursor := crHourglass;
         if rbDelAll.Checked then begin
            SelectedCelsOper(operRazpDel,
                             null,
                             null,
                             true,
                             true,
                             true,
                             true);
         end else begin
            if cbIzmena1.Checked then
               SelectedCelsOper(operRazpDel,
                             null,
                             1,
                             cbDelovniki.Checked,
                             cbSobote.Checked,
                             cbNedelje.Checked,
                             cbPrazniki.Checked);
            if cbIzmena2.Checked then
               SelectedCelsOper(operRazpDel,
                             null,
                             2,
                             cbDelovniki.Checked,
                             cbSobote.Checked,
                             cbNedelje.Checked,
                             cbPrazniki.Checked);
            if cbIzmena3.Checked then
               SelectedCelsOper(operRazpDel,
                             null,
                             3,
                             cbDelovniki.Checked,
                             cbSobote.Checked,
                             cbNedelje.Checked,
                             cbPrazniki.Checked);
         end;
         Screen.Cursor := crDefault;
      end;
      Destroy;
   end;

end;

procedure TfmRazp.miRazveljaviClick(Sender: TObject);
var odD, doD: tDate;
    n: integer;
begin
   // ponovno naloži razpored in odsotnosti

   n := globSolver.Razpored.StevOseb;
   odD := globSolver.Razpored.FirstDay;
   doD := globSolver.Razpored.LastDay;

   if (globSolver.Razpored.StevOseb <= 0) or (globSolver.Razpored.DayCount <= 0) then
      raise exception.Create(C_EXCEPT_MSG_SOLVER_NOT_INIT);

   ProgressInit (3,1);

   ProgressInfo(C_PROGRESS_INFO_RAZPORED_LOAD);
   globSolver.Razpored.Clear;
   globSolver.Razpored.Init(n, odD, doD);

   if cbPrenosID.KeyValue <> null then
      dmOracle.SolverRazpLoad(cbPrenosID.KeyValue, edDatumOd.Date, edDatumDo.Date)
   else
      dmOracle.SolverRazpLoad(C_DUMMY_RAZPORED_ID, edDatumOd.Date, edDatumDo.Date);

   dmOracle.SolverOdsotLoad (globSolver.Razpored.FirstDay,
                             globSolver.Razpored.LastDay,
                             fmSettings.rgOdsotSource.ItemIndex);

   globSolver.Razpored.DirtyFlagsClean;

   ProgressInfo(C_PROGRESS_INFO_DATA_SHOW);
   LoadGridFromSolver;

   ProgressInfo(C_PROGRESS_INFO_GRID_SIZE);
   viRazpByMNR.ApplyBestFit();

   ProgressClose;

end;

procedure TfmRazp.viRazpByMNRCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
   ri: integer;
begin
   if system.Pos(C_NAME_CRITERIA, ACellViewInfo.Item.Name) > 0 then begin
      ri := ACellViewInfo.GridRecord.RecordIndex;
      ShowPersonalDetailData(ri);
   end;
end;

procedure TfmRazp.miRandomizerClick(Sender: TObject);
var
   ri: integer;
   aOseba: TOseba;
   aCritHours: tCriteria;
   rndHours: integer;

begin
   for ri := 0 to globSolver.Razpored.StevOseb-1 do begin
      aOseba := tOseba(globSolver.Osebe.Items[ri]);
      aCritHours := aOseba.GetCriteria(ctHours);
      rndHours := random (40);
      rndHours := rndHours - 20;
      // pretvori v minute
      rndHours := rndHours * 60;
      aCritHours.InfluenceStartValues(rndHours, 0);
      ShowOsebaCriteria(ri);
   end;
end;

procedure TfmRazp.FormDestroy(Sender: TObject);
begin
   fmProgress.Destroy;
   fmSettings.Destroy;
   fmResults.Destroy;
   globSolver.Clear;
   GUIStoreState;
end;

procedure TfmRazp.miDelovnikiClick(Sender: TObject);
begin
   ShowHideColumns;
end;

procedure TfmRazp.miSoboteClick(Sender: TObject);
begin
   ShowHideColumns;
end;

procedure TfmRazp.miNedeljeClick(Sender: TObject);
begin
   ShowHideColumns;
end;

procedure TfmRazp.miPraznikiClick(Sender: TObject);
begin
   ShowHideColumns;
end;

procedure TfmRazp.miDnevniClick(Sender: TObject);
var aDay: tDate;
   aColumn: tCxGridColumn;

begin
   cxHintStyleController1.HideHint;
   with TcxGridSite(Sender) do begin
      // preveri èe je fokusirana celica prava - koledarèek
      aColumn := viRazpByMNR.Controller.FocusedColumn;
      if System.Pos(C_NAME_DAY, aColumn.Name) <= 0 then
         // celica ni prava, na svidenje
         exit
      else
         aDay := globSolver.Razpored.FirstDay + aColumn.Tag;
   end;

   fmRazpD := tFmRazpD.Create(self);
   fmRazpD.SetOwner(cbPrenosID.KeyValue);
   fmRazpD.SetDate(aDay);

   fmRazpD.ShowModal;
   fmRazpD.Destroy;

   ProgressInit (1,1);

   ProgressInfo(C_PROGRESS_INFO_DATA_SHOW);
   LoadGridFromSolver;

   {
   ProgressInfo(C_PROGRESS_INFO_GRID_SIZE);
   viRazpByMNR.ApplyBestFit();
   }

   ProgressClose;

end;

procedure TfmRazp.miProstoClick(Sender: TObject);
begin
   SelectedCelsOper(operOdsotNew,
                 'PRO',
                 'O',
                 null,
                 null,
                 null,
                 null);

end;

procedure TfmRazp.miProDelClick(Sender: TObject);
begin
   SelectedCelsOper(operOdsotDel,
                    'PRO',
                    null,
                    null,
                    null,
                    null,
                    null);

end;

procedure TfmRazp.miRandomizerSunHolyClick(Sender: TObject);
var
   ri: integer;
   aOseba: TOseba;
   aCrit: tCriteria;
   rndDays: integer;
begin
   for ri := 0 to globSolver.Razpored.StevOseb-1 do begin
      aOseba := tOseba(globSolver.Osebe.Items[ri]);
      aCrit := aOseba.GetCriteria(ctSunHoly);
      rndDays := random (3);
      aCrit.InfluenceStartValues(0, rndDays);
      ShowOsebaCriteria(ri);
   end;
end;

procedure TfmRazp.miSelectDayClick(Sender: TObject);
var aDay: tDate;
   aColumn: tCxGridColumn;
begin
   cxHintStyleController1.HideHint;
   with TcxGridSite(Sender) do begin
      // preveri èe je fokusirana celica prava - koledarèek
      aColumn := viRazpByMNR.Controller.FocusedColumn;
      if System.Pos(C_NAME_DAY, aColumn.Name) <= 0 then
         // celica ni prava, na svidenje
         exit
      else
         aDay := globSolver.Razpored.FirstDay + aColumn.Tag;
   end;

   SelectCells(aDay, aDay);

end;

procedure TfmRazp.miSelectAllClick(Sender: TObject);
begin
   SelectCells(globSolver.Razpored.FirstDay, globSolver.Razpored.LastDay);
end;

procedure TfmRazp.CreateDefaultFilter;
begin
   with viRazpByMNR.DataController.Filter.Root do begin
      Clear;
      BoolOperatorKind := fboAnd;
      AddItem(viRazpByMNREMPLOYED, foEqual, 'RED', 'RED');
      AddItem(viRazpByMNRAKT, foEqual, 1, '1');
   end;
   viRazpByMNR.DataController.Filter.Active := True;
end;

procedure TfmRazp.GUIStoreState;
var aStream: TMemoryStream;
    aBuffer: array [1..2048] of integer;
    aRegistry: TAppRegistry;
    i: integer;
    aValue: string;
    aColumn: TcxGridDBBandedColumn;


begin
   // Stanje filtra shrani na stream
   aStream := TMemoryStream.Create;
   viRazpByMNR.DataController.Filter.SaveToStream(aStream);
   aStream.Position := 0;

   // Prepiši stream v buffer
   aStream.Read(aBuffer, min(aStream.Size, 2048));

    // binarno vrednost filtra shrani v registry
   aRegistry := TAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.OpenSubKey(C_REGISTRY_KEYNAME_ARGUI + '\fmRazp');
   aRegistry.WritePropValBinary('Filter', aBuffer, aStream.Size);

   // Shrani imena stolpcev za grupiranje
   aValue := '';
   for i := 0 to viRazpByMnr.GroupedColumnCount - 1 do begin
      aColumn := TCXGridDBBandedColumn(viRazpByMNR.GroupedColumns[i]);
      aValue:=aValue + aColumn.DataBinding.FieldName +  ';';
   end;
   aRegistry.WritePropValString('GroupColumns', aValue);

   // Shrani imena stolpcev za sortiranje
   aValue := '';
   for i := 0 to viRazpByMnr.SortedItemCount - 1 do begin
      aColumn := TCXGridDBBandedColumn(viRazpByMNR.SortedItems[i]);
      aValue:=aValue + aColumn.DataBinding.FieldName;
      // dodaj oznako za smer sortiranja (a ali d)
      if aColumn.SortOrder = soAscending then
         aValue:=aValue + 'a;'
      else
         aValue:=aValue + 'd;';
   end;
   aRegistry.WritePropValString('SortColumns', aValue);

   aRegistry.Free;

   // sprosti stream
   aStream.Free;
end;

procedure TfmRazp.GUIRestoreState;
var aStream: TMemoryStream;
    aRegistry: TAppRegistry;
    aBuffer: array [1..2048] of integer;
    aSize: integer;
    aGroupedColumns, aSortedColumns: string;

procedure RestoreGrouping(grNames: string);
var aCName: string;
    curPos, nextPos: integer;
    nFields: integer;
    aColumn: TcxGridDBBandedColumn;

begin
   // clear existing grouping
   viRazpByMNR.DataController.Groups.ClearGrouping;

   nextPos := 1;
   curPos := 1;
   nFields := 0;

   if Length(grNames) <= 1 then
      exit;

   while curPos <= Length(grNames) do begin
      nextPos := PosEx(';', grNames, curPos);

      aCName := Copy(grNames, curPos, nextPos-curPos);
      if Length(aCName) > 0 then begin
         nFields := nFields + 1;
         aColumn := viRazpByMNR.GetColumnByFieldName(aCName);
         if aColumn <> nil then begin
            aColumn.GroupIndex := nFields;
            aColumn.Visible := false;
         end;
      end;

      curPos := nextPos + 1;
   end;
end;

procedure RestoreSorting(srtNames: string);
var aCName: string;
    curPos, nextPos: integer;
    nFields: integer;
    aColumn: TcxGridDBBandedColumn;
    aField, aSort: string;

begin
   // clear existing grouping
   viRazpByMNR.DataController.ClearSorting(true);

   nextPos := 1;
   curPos := 1;
   nFields := 0;

   if Length(srtNames) <= 1 then
      exit;

   while curPos <= Length(srtNames) do begin
      nextPos := PosEx(';', srtNames, curPos);

      aCName := Copy(srtNames, curPos, nextPos-curPos);
      if Length(aCName) > 0 then begin
         nFields := nFields + 1;
         aField := Copy(aCName, 1, Length(aCName)-1);
         aSort := RightStr(aCName, 1);
         aColumn := viRazpByMNR.GetColumnByFieldName(aField);
         if aColumn <> nil then begin
            aColumn.SortIndex := nFields;
            if upperCase(aSort) = 'A' then
               aColumn.SortOrder := soAscending
            else
               aColumn.SortOrder := soDescending;

            // column visible only if not group column
            aColumn.Visible := (aColumn.GroupIndex = -1);
         end;
      end;

      curPos := nextPos + 1;
   end;
end;


begin
   aRegistry := TAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.OpenSubKey(C_REGISTRY_KEYNAME_ARGUI + '\fmRazp');
   aSize := aRegistry.ReadPropValBinary('Filter', aBuffer, 2048, false);
   aGroupedColumns := aRegistry.ReadPropValString('GroupColumns', false);
   aSortedColumns := aRegistry.ReadPropValString('SortColumns', false);

   aRegistry.Free;

   RestoreGrouping(aGroupedColumns);
   RestoreSorting(aSortedColumns);

   // restore filter
   aStream := TMemoryStream.Create;
   try
      aStream.WriteBuffer(aBuffer, aSize);
      aStream.Position := 0;
      viRazpByMNR.DataController.Filter.LoadFromStream(aStream);
   except
      CreateDefaultFilter;
   end;

   aStream.Free;

end;


procedure TfmRazp.miSettingsClick(Sender: TObject);
begin
   cxHintStyleController1.HideHint;
   fmSettings.ShowModal;
   if fmSettings.ModalResult = mrOk then begin

      CellShowMode := fmSettings.rgShowMode.ItemIndex;

      try
         // preveri èe se datumi ujemajo oz. je bil solver inicializiran
         globSolver.CheckDateLimits(edDatumOd.Date, edDatumDo.Date);
      except
         // èe ni inicializiran, niè hudega
         exit;
      end;

      ProgressInit(2,1); // skupno 6 korakov, velikost koraka = 1
      ProgressInfo(C_PROGRESS_INFO_DATA_SHOW);

      ShowHideColumns;
      LoadGridFromSolver;

      ProgressInfo(C_PROGRESS_INFO_GRID_SIZE);
      viRazpByMNR.ApplyBestFit();

      ProgressClose;
   end;
end;

procedure TfmRazp.viRazpByMNRDblClick(Sender: TObject);
begin
   fmEmpDet := tFmEmpDet.Create(self);
   fmEmpDet.taRisCard.Close;
   fmEmpDet.taRisCard.Master := dmOracle.quRisUCard;
   fmEmpDet.taRisCard.Open;
   fmEmpDet.DisableEnableNavButtons (false);
   fmEmpDet.pcEmployee.activePage := fmEmpDet.tsRazporeditve;
   fmEmpDet.ShowModal;
   fmEmpDet.Destroy;
end;

procedure TfmRazp.miOdsotOdobriClick(Sender: TObject);
begin
   SelectedCelsOper(operOdsotOdobri,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null);
end;

procedure TfmRazp.miOdsotZavrniClick(Sender: TObject);
begin
   SelectedCelsOper(operOdsotZavrni,
                    null,
                    null,
                    null,
                    null,
                    null,
                    null);
end;

procedure TfmRazp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if globSolver.Razpored <> nil then begin
      if globSolver.Razpored.IsDirty then begin
         if (MessageDlg(C_FMRAZPOSEB_RAZPORED_DIRTY,  mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then
            Action := caNone;
      end;
   end;
end;

end.
