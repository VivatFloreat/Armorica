unit fmOdsotOseb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxControls, cxGridCustomView,
  cxClasses, cxGridLevel, cxGrid, OracleData, StdCtrls, Buttons,
  cxGridBandedTableView, cxGridDBBandedTableView, ExtCtrls, OracleNavigator,
  cxRichEdit, cxButtonEdit, cxMemo, cxCheckGroup, cxBlobEdit, cxTextEdit,
  RXSpin, Menus, Oracle, DBCtrls, RxLookup, cxLookAndFeels,
  cxPropertiesStore, cxGridCustomPopupMenu, cxGridPopupMenu, SpeedBar,
  cxContainer, cxListBox, ImgList, cxMaskEdit, cxDropDownEdit,
  cxImageComboBox, cxHint, globals;

const
   C_TAG_MIN_OFF = 0;      // tag ID - offset v generiranih poljih za polje MIN

   // Imena stolpcev
   C_NAME_DAY = 'Day';
   C_NAME_MNR = 'MNR';

   // Širina stolpcev za odsotnosti
   C_MIN_WIDTH = 36;

type tOpers = (operOdsotNew, operOdsotDel, operOdsotOdobri, operOdsotZavrni,
               operSidrajRazp, operSidrajIzmeno);

type
  TfmOdsot = class(TForm)
    dsRisUCard: TDataSource;
    Panel1: TPanel;
    bbPopulate: TBitBtn;
    Panel2: TPanel;
    Grid: TcxGrid;
    viRisUCard: TcxGridDBBandedTableView;
    leRazp: TcxGridLevel;
    Panel3: TPanel;
    cbMesec: TComboBox;
    edLeto: TRxSpinEdit;
    mnuPopup: TPopupMenu;
    sdHTML: TSaveDialog;
    Label1: TLabel;
    Label2: TLabel;
    bbPrint: TBitBtn;
    Panel4: TPanel;
    bbSave: TBitBtn;
    bbCancel: TBitBtn;
    bbExcel: TBitBtn;
    viRazpByMNR: TcxGridDBBandedTableView;
    viRazpByMNRPRIIMEK_IME: TcxGridDBBandedColumn;
    quOdsotByMNR: TOracleDataSet;
    viRisUCardMNR: TcxGridDBBandedColumn;
    viRisUCardLNAME: TcxGridDBBandedColumn;
    viRisUCardFNAME: TcxGridDBBandedColumn;
    viRisUCardO_DEP_DESC: TcxGridDBBandedColumn;
    quOdsotByMNRMNR: TIntegerField;
    quOdsotByMNRHOURS_ID: TIntegerField;
    quOdsotByMNRVP_ID: TStringField;
    quOdsotByMNRIN_DATE: TDateTimeField;
    miOdsotDel: TMenuItem;
    miOdsotNew: TMenuItem;
    viRisUCardORG1: TcxGridDBBandedColumn;
    spDelOdsot: TOracleQuery;
    spInsOdsot: TOracleQuery;
    quOdsotByMNRPAIR_PK: TFloatField;
    quOdsotByMNRSTATUS: TStringField;
    viRisUCardNo: TcxGridDBBandedColumn;
    miOdsotOdobri: TMenuItem;
    miOdsotZavrni: TMenuItem;
    N1: TMenuItem;
    miSidrajRazp: TMenuItem;
    miSidrajTurnus: TMenuItem;
    myStyles: TcxStyleRepository;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyleRaz1: TcxStyle;
    cxStyleRaz3: TcxStyle;
    cxStyleRaz4: TcxStyle;
    cxStyleRaz2: TcxStyle;
    cxStyleOds1: TcxStyle;
    cxStyleOds2: TcxStyle;
    cxStyleOds3: TcxStyle;
    cxStylePraznikHeader: TcxStyle;
    cxStyleSobotaHeader: TcxStyle;
    cxStyleNedeljaHeader: TcxStyle;
    cxHintStyleController1: TcxHintStyleController;
    Timer1: TTimer;
    quOdsotByMNRDESCRIPTION: TStringField;
    quOdsotByMNROUT_DATE: TDateTimeField;
    quOdsotByMNRCDATE: TDateTimeField;
    quOdsotByMNRCUSER: TStringField;
    quOdsotByMNROUSER: TStringField;
    quOdsotByMNROCHANGE: TDateTimeField;
    N2: TMenuItem;
    quRisShif: TOracleDataSet;
    quRisShifSHIFT_ID: TIntegerField;
    quRisShifSHIFT_NO: TIntegerField;
    quRisShifARM_OZNAKA: TStringField;
    quRisShifDESCRIPTION: TStringField;
    spInsRazp: TOracleQuery;
    quRazpByMNR: TOracleDataSet;
    quRazpByMNRID: TFloatField;
    quRazpByMNRPRENOS_ID: TFloatField;
    quRazpByMNRMNR: TFloatField;
    quRazpByMNRDATUM: TDateTimeField;
    quRazpByMNRDEPART_ID: TFloatField;
    quRazpByMNRDEPA_DESC: TStringField;
    quRazpByMNRDEM_ID: TFloatField;
    quRazpByMNRSIFRA: TStringField;
    quRazpByMNRNAZIV: TStringField;
    quRazpByMNRSHIFT_ID: TIntegerField;
    quRazpByMNRDESCRIPTION: TStringField;
    quRazpByMNRARM_OZNAKA: TStringField;
    quRazpByMNRSHIFT_NO: TIntegerField;
    quRazpByMNRSHIFT_NO_RAZP: TIntegerField;
    quRazpByMNRCREATED: TDateTimeField;
    quRazpByMNRCUSER: TStringField;
    delArmRazp: TOracleQuery;
    quRazpByMNRDEPART: TStringField;
    quRisHour: TOracleDataSet;
    quRisHourHOURS_ID: TIntegerField;
    quRisHourVP_ID: TStringField;
    quRisHourDESCRIPTION: TStringField;
    quRisHourOPIS: TStringField;
    dsRisHour: TDataSource;
    Panel5: TPanel;
    edMsg: TEdit;
    bbDeleteOds: TBitBtn;
    bbDelSidranja: TBitBtn;
    sbPrev: TSpeedButton;
    sbNext: TSpeedButton;
    procedure bbPopulateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbPrintClick(Sender: TObject);
    procedure bbExcelClick(Sender: TObject);
    procedure miOdsotNewClick(Sender: TObject);
    procedure bbSaveClick(Sender: TObject);
    procedure OnDayXGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure miSidrajTurnusClick(Sender: TObject);
    procedure viRisUCardMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure mnuPopupPopup(Sender: TObject);
    procedure EnableDisablePopupMenuItems;
    procedure miOdsotDelClick(Sender: TObject);
    procedure miSidrajRazpClick(Sender: TObject);
    procedure miOdsotOdobriClick(Sender: TObject);
    procedure miOdsotZavrniClick(Sender: TObject);
    procedure sbPrevClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
  private
    { Private declarations }
    fHintDisplayed: Boolean;
    fGridRecord: TcxCustomGridRecord;
    fItem: TcxCustomGridTableItem;
    procedure InitCalendarGrid(aGridView: TcxGridDBBandedTableView);
    procedure LoadOdsot;
    procedure SaveOdsot;
    procedure SelectedCelsOper(aOper: tOpers; // operacija
                               aVal: variant; // text viden v gridu
                               aShiftNo: variant; // fiksiran turnus
                               aDepartId: variant; // fiksirano delovišèe
                               aDemId: variant; // fiksirano DM
                               aShiftId: variant); // fiksirana izmena
    procedure InitMemoryArray (rows, cols: integer);
    procedure SetMemoryArrayItem(rIndx, colIndx: integer; aRec: TDDMIRec);
    procedure ClearMemoryArrayItem(rIndx, colIndx: integer);
    procedure DeleteAllOdsot(aMNR: integer; aLowDate, aHighDate: TDate);
    function GetMemoryArrayItem(rIndx, colIndx: integer; var aRec: TDDMIRec): boolean;
    procedure PremakniMesec(koliko: integer);

  public
    { Public declarations }
  end;


var
  fmOdsot: TfmOdsot;
  mtxOdsot: array of array of TDDMIRec;

implementation

{$R *.dfm}
uses DateUtils, cxDataUtils, dmOra, cxGridExportLink, fmSelectShift,
  fmSelectDDMI, fmSelectOds;

procedure TfmOdsot.InitCalendarGrid (aGridView: TcxGridDBBandedTableView);
var
   aSelDate, aTmpDate: TDateTime;
   aColMin: TcxGridBandedColumn;
   i: integer;
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
   dmOracle.quRisUCard.Close;
   DestroyDayColumn;

   aSelDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1, 1, 0,0,0,0);

   for i:=1 to DaysInMonth(aSelDate) do begin
      aColMin := aGridView.CreateColumn;
      aColMin.Name := aGridView.Name + C_NAME_DAY + IntToStr(i);
      aTmpDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1, i, 0,0,0,0);
      tmp:=FormatDateTime ('ddd', aTmpDate);
      aColMin.Caption := IntToStr(i);
      aColMin.Position.BandIndex := 1;
      aColMin.Position.LineCount := 3;
      aColMin.Options.Editing := true;
      aColMin.Options.Filtering := false;
      aColMin.Tag := C_TAG_MIN_OFF + i;
      aColMin.DataBinding.ValueType := 'String';
      aColMin.PropertiesClass := TcxCustomMemoProperties; //??
      TcxCustomMemoProperties(aColMin.Properties).ScrollBars := ssVertical;
      TcxCustomMemoProperties(aColMin.Properties).WordWrap := true;
      aColMin.MinWidth := C_MIN_WIDTH;
      aColMin.Styles.OnGetContentStyle := OnDayXGetContentStyle;

      if (dmOracle.isPraznik(aTmpDate)) then begin
         aColMin.Styles.Header := cxStylePraznikHeader;
         aColMin.Styles.Content := cxStyleNedeljaHeader;
      end else begin
         case DayOfWeek(aTmpDate) of
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

   end;
   dmOracle.quRisUCard.Open;
end;

procedure TfmOdsot.InitMemoryArray (rows, cols: integer);
begin
   SetLength (mtxOdsot, rows, cols);
end;

procedure TfmOdsot.SetMemoryArrayItem(rIndx, colIndx: integer; aRec: TDDMIRec);
var aName: string;
    ii: integer;
begin
   aName:=viRisUCard.Columns[colIndx].Name;
   if (Pos(C_NAME_DAY, aName) > 0) then begin
      // Ime kolone je pravo, zato poglej tag - tam te èaka dan
      ii := viRisUCard.Columns[colIndx].Tag;
      mtxOdsot[rIndx, ii-1] := aRec;
   end;
end;

procedure TfmOdsot.ClearMemoryArrayItem(rIndx, colIndx: integer);
var aName: string;
    ii: integer;
    var aRec: TDDMIRec;
begin
   aName:=viRisUCard.Columns[colIndx].Name;
   if (Pos(C_NAME_DAY, aName) > 0) then begin
      // Ime kolone je pravo, zato poglej tag - tam te èaka dan
      ii := viRisUCard.Columns[colIndx].Tag;

      CleanRecord(aRec);

      mtxOdsot[rIndx, ii-1] := aRec;
   end;
end;

function TfmOdsot.GetMemoryArrayItem(rIndx, colIndx: integer; var aRec: TDDMIRec): boolean;
var aName: string;
    ii: integer;
begin
   aName:=viRisUCard.Columns[colIndx].Name;
   if (Pos(C_NAME_DAY, aName) > 0) then begin
      // Ime kolone je pravo, zato poglej tag - tam te èaka dan
      ii := viRisUCard.Columns[colIndx].Tag;
      aRec := mtxOdsot[rIndx, ii-1];

      if (aRec.mnr > 0) then
         GetMemoryArrayItem := true
      else
         GetMemoryArrayItem := false;

   end else
      // vrni prazen record
      GetMemoryArrayItem := false;
end;



procedure TfmOdsot.LoadOdsot;
var
   aLowDate, aHighDate: TDateTime;
   ci: integer;
   memRow: integer;
   aRecItem: TDDMIRec;
   aDisp: string;

function getColumnIndex (aDate: TDateTime): Integer;
var y,m,d,h,mi,ss,mm: word;
    i: integer;
    colName : string;
begin
   DecodeDateTime(aDate, y, m, d, h, mi, ss, mm);
   colName := viRisUCard.Name + C_NAME_DAY + IntToStr(d);
   for i:=0 to viRisUCard.ColumnCount -1 do begin
      if viRisUCard.Columns[i].Name = colName then begin
         Result := viRisUCard.Columns[i].Index;
         exit;
      end;
   end;
   Result := -1;
end;

begin
   aLowDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1, 1,
                               0,0,0,0);
   aHighDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1,
                                DaysInMonth(aLowDate),
                                0,0,0,0);

   // dinamièno polje odsotnosti v pomnilniku najprej pobrišemo - poshrinkamo
   InitMemoryArray (0,0);
   // dinamièno polje odsotnosti v pomnilniku zaradi specifiènega risanja
   InitMemoryArray (dmOracle.quRisUCard.RecordCount, DaysInMonth(aLowDate));

   // Sprehod skozi vse osebe
   dmOracle.quRisUCard.First;

   // sprehod skozi vse odsotnosti v tabeli RIS_PAIR_PLAN
   while not dmOracle.quRisUCard.Eof do begin
      edMsg.Text := IntToStr (dmOracle.quRisUCard.RecNo) + ' od ' +  IntToStr (dmOracle.quRisUCard.RecordCount);
      edMsg.Refresh;
      Application.ProcessMessages;
      // Za vsak zapis preglej plan
      with quOdsotByMNR do begin
         Close;
         SetVariable('P_DATUM_OD', aLowDate);
         SetVariable('P_DATUM_DO', aHighDate);
         SetVariable('P_MNR', dmOracle.quRisUCard.Fields[0].AsInteger);
         Open;

         viRisUCard.DataController.BeginUpdate;
         while not Eof do begin
            ci := getColumnIndex (quOdsotByMNRIN_DATE.AsDateTime);
            if (ci <> -1) then begin

               memRow := viRisUCard.DataController.RecNo;

               CleanRecord(aRecItem);
               aRecItem.recType := rtOdsot;
               aRecItem.pair_pk := quOdsotByMNRPAIR_PK.AsInteger;
               aRecItem.mnr := quOdsotByMNRMNR.AsInteger;
               aRecItem.in_date := quOdsotByMNRIN_DATE.AsDateTime;
               aRecItem.out_date := quOdsotByMNRIN_DATE.AsDateTime;
               aRecItem.hours_id := quOdsotByMNRHOURS_ID.AsInteger;
               aRecItem.vp_id := quOdsotByMNRVP_ID.AsString;
               aRecItem.vp_desc := quOdsotByMNRDESCRIPTION.AsString;
               aRecItem.status := quOdsotByMNRSTATUS.AsString;
               aRecItem.cdate := quOdsotByMNRCDATE.AsDateTime;
               aRecItem.cuser := quOdsotByMNRCUSER.AsString;
               aRecItem.ochange := quOdsotByMNROCHANGE.AsDateTime;
               aRecItem.ouser := quOdsotByMNROUSER.AsString;


               SetMemoryArrayItem(memRow - 1,
                                  ci,
                                  aRecItem);

               viRisUCard.DataController.SetEditValue(ci, aRecItem.vp_id, evsValue);
            end;
            quOdsotByMNR.Next;
         end;
         quOdsotByMNR.Close;
         viRisUCard.DataController.EndUpdate;
      end;


      with quRazpByMNR do begin
         Close;
         SetVariable('P_DATUM_OD', aLowDate);
         SetVariable('P_DATUM_DO', aHighDate);
         SetVariable('P_MNR', dmOracle.quRisUCard.Fields[0].AsInteger);

         Open;

         // sprehod skozi fiksiranja
         viRisUCard.DataController.BeginUpdate;
         while not Eof do begin
            ci := getColumnIndex (quRazpByMNRDATUM.AsDateTime);
            if (ci <> -1) then begin

               memRow := viRisUCard.DataController.RecNo;
               CleanRecord(aRecItem);
               aRecItem.recType := rtRazp;
               aRecItem.pair_pk := quRazpByMNRID.AsInteger;
               aRecItem.mnr := quRazpByMNRMNR.AsInteger;
               aRecItem.in_date := quRazpByMNRDATUM.AsDateTime;
               aRecItem.depart_id := quRazpByMNRDEPART_ID.AsVariant;
               aRecItem.depa := quRazpByMNRDEPART.AsString;
               aRecItem.depa_opis := quRazpByMNRDEPA_DESC.AsString;
               aRecItem.dem_id := quRazpByMNRDEM_ID.AsVariant;
               aRecItem.dem_sifra := quRazpByMNRSIFRA.AsString;
               aRecItem.dem_oznaka := quRazpByMNRARM_OZNAKA.AsString;
               aRecItem.dem_naziv := quRazpByMNRNAZIV.AsString;
               aRecItem.shift_id := quRazpByMNRSHIFT_ID.AsVariant;
               aRecItem.shift_no := quRazpByMNRSHIFT_NO.AsString;
               aRecItem.shift_desc := quRazpByMNRDESCRIPTION.AsString;
               aRecItem.shift_no_razp := quRazpByMNRSHIFT_NO_RAZP.asVariant;

               SetMemoryArrayItem(memRow - 1,
                                  ci,
                                  aRecItem);

               aDisp := aRecItem.dem_sifra + aRecItem.depa;
               viRisUCard.DataController.SetEditValue(ci, aDisp, evsValue);

            end;
            quRazpByMNR.Next;
         end;
         quRazpByMNR.Close;
         viRisUCard.DataController.EndUpdate;
      end;

      dmOracle.quRisUCard.Next;
   end;
   end;

procedure TfmOdsot.bbPopulateClick(Sender: TObject);
begin
   if cbmesec.ItemIndex < 1 then
      raise exception.Create('Izberi mesec!');

   if edLeto.AsInteger < 1900 then
      raise exception.Create('Plan pred letom 1900!');

   InitCalendarGrid (viRisUCard);
   dmOracle.quRisUCard.Open;
   LoadOdsot;

   //viRisUCard.ApplyBestFit();

end;

procedure TfmOdsot.FormCreate(Sender: TObject);
var aY, aM, aD: Word;
begin
   DecodeDate (Date, aY, aM, aD);
   edLeto.Value := aY;
   cbMesec.ItemIndex := aM -1;
   //InitCalendarGrid (viRazp);
end;

procedure TfmOdsot.bbPrintClick(Sender: TObject);
begin
   sdHtml.FileName := 'Odsotnosti' + cbMesec.Text + edLeto.Text + '.html';
   sdHtml.FilterIndex := 1;
   if sdHTML.Execute then begin
      ExportGridToHTML(sdHTML.FileName, Grid);
   end;
end;

procedure TfmOdsot.bbExcelClick(Sender: TObject);
begin
   sdHtml.FileName := 'Odsotnosti' + cbMesec.Text + edLeto.Text + '.xls';
   sdHtml.FilterIndex := 2;
   if sdHTML.Execute then begin
         ExportGridToExcel(sdHTML.FileName, Grid);
   end;
end;

procedure TfmOdsot.SelectedCelsOper(aOper: tOpers; // operacija
                                    aVal: variant; // text viden v gridu
                                    aShiftNo: variant; // fiksiran turnus ali status odobritve odsotnosti
                                    aDepartId: variant; // fiksirano delovišèe
                                    aDemId: variant; // fiksirano DM
                                    aShiftId: variant); // fiksirana izmena
  var
   aRec: TDDMIRec;

  function SelectedRowCount: Integer;
  begin
    Result := viRisUCard.Controller.SelectedRowCount;
  end;

  function SelectedColumnCount: Integer;
  begin
    Result := viRisUCard.Controller.SelectedColumnCount;
  end;

  // vnos nove odsotnosti
  procedure SelectionNewOdsot (aVal: Variant; aStatus: Variant; aRec: TDDMIRec);
  var
    I, J, rowIndx, colIndx: Integer;
    colMNR: TcxGridBandedColumn;
    aDay: integer;
    aVp: string;

  begin
    if aVal = null  then
      raise exception.Create('Izberi vrsto odsotnosti!');

    // tip odsotnosti dobiš v parametru
    aVp := aVal;

    // poišèi dodatne podatke odsotnosti in nastavi memory record
    if (quRisHour.Locate('VP_ID', VarArrayOf([aVP]), [])) then begin
       cleanRecord (aRec);
       aRec.recType := rtOdsot;
       aRec.status := aStatus;
       aRec.vp_desc := quRisHourDESCRIPTION.AsString;
       aRec.vp_id := aVP;
       aRec.hours_id := quRisHourHOURS_ID.AsInteger;
       aRec.cuser := dmOracle.oraSession.LogonUsername;
       aRec.cdate := Date;
    end;

    // zapomni si kolono kjer je MNR
    colMNR := viRisUCard.GetColumnByFieldName(C_NAME_MNR);

    // sprehod skozi oznaèene celice
    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viRisUCard.Controller.SelectedRows[I].RecordIndex;

      // mnr osebe!
      aRec.mnr :=viRisUCard.DataController.GetValue(rowIndx, colMNR.Index);

      for J := 0 to SelectedColumnCount - 1 do begin
        colIndx := viRisUCard.Controller.SelectedColumns[J].Index;

        // zapiši datum, ki je v tagu
        aDay := viRisUCard.Columns[colIndx].Tag - C_TAG_MIN_OFF;
        aRec.in_date := EncodeDateTime(edLeto.AsInteger, cbMesec.ItemIndex+1,
                                       aDay, 0,0,0,0);

        viRisUCard.DataController.SetValue(rowIndx, colIndx, aVal);
        SetMemoryArrayItem(rowIndx, colIndx, aRec);
      end;
   end;
  end;


  // sprememba statusa odsotnosti
  procedure SelectionSpremeniStatusOdsot (aStatus: Variant);
  var
    I, J, rowIndx, colIndx: Integer;

  begin

    // sprehod skozi oznaèene celice
    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viRisUCard.Controller.SelectedRows[I].RecordIndex;

      for J := 0 to SelectedColumnCount - 1 do begin
        colIndx := viRisUCard.Controller.SelectedColumns[J].Index;
        GetMemoryArrayItem(rowIndx, colIndx, aRec);

        // nastavi status
        aRec.status := aStatus;

        // pobriši ali nastavi userja in datum odobritve
        if (aStatus = 'V') then begin
          aRec.ouser := '';
          aRec.ochange := null;
        end else begin
          aRec.ouser := dmOracle.oraSession.LogonUsername;
          aRec.ochange := Date;
        end;
        SetMemoryArrayItem(rowIndx, colIndx, aRec);
      end;
   end;
  end;

  // vnos sidranja
  procedure SelectionSetSidranje (aVal: Variant; aRec: TDDMIRec);
  var
    I, J, rowIndx, colIndx: Integer;
    colMNR: TcxGridBandedColumn;
    aDay: integer;
    oldRec: TDDMIRec;

  begin

    // zapomni si kolono kjer je MNR
    colMNR := viRisUCard.GetColumnByFieldName(C_NAME_MNR);

    // dopolni podatke fiksiranih zadev
    if aRec.dem_id <> null then begin
      aRec.dem_sifra := fmSelDDMI.quDDMIOsebeSIFRA.asString;
      aRec.dem_naziv := fmSelDDMI.quDDMIOsebeNAZIV.asString;
    end;

    if aRec.depart_id <> null then begin
      aRec.depa := fmSelDDMI.quDDMIOsebeDEPART.AsString;
      aRec.depa_opis := fmSelDDMI.quDDMIOsebeDESCRIPTION.AsString;
    end;

    if aRec.shift_id <> null then begin
      aRec.shift_arm := fmSelDDMI.quDDMIOsebeARM_OZNAKA.AsString;
      aRec.shift_no_razp := fmSelDDMI.quDDMIOsebeSHIFT_NO.AsVariant;
      aRec.shift_desc := fmSelDDMI.quDDMIOsebeDESCRIPTION_1.AsString;
    end;

    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viRisUCard.Controller.SelectedRows[I].RecordIndex;

      // mnr osebe!
      aRec.mnr :=viRisUCard.DataController.GetValue(rowIndx, colMNR.Index);

      for J := 0 to SelectedColumnCount - 1 do begin
        colIndx := viRisUCard.Controller.SelectedColumns[J].Index;

        // zapiši datum, ki je v tagu
        aDay := viRisUCard.Columns[colIndx].Tag - C_TAG_MIN_OFF;
        aRec.in_date := EncodeDateTime(edLeto.AsInteger, cbMesec.ItemIndex+1,
                                       aDay, 0,0,0,0);

        // sidranje turnusa lahko samo èe spodaj ni odsotnosti
        if GetMemoryArrayItem (rowIndx, colIndx, oldRec) then begin
            if oldRec.recType <> rtOdsot then begin
               // prejšnja vrednost ni bila odsotnost, lahko prekriješ
               viRisUCard.DataController.SetValue(rowIndx, colIndx, aVal);
               SetMemoryArrayItem(rowIndx, colIndx, aRec);
            end;
        end else begin
            // prejšnje vrednosti ni bilo
            viRisUCard.DataController.SetValue(rowIndx, colIndx, aVal);
            SetMemoryArrayItem(rowIndx, colIndx, aRec);
        end;
      end;
   end;
  end;


  procedure SelectionClearValOds;
  var
    I, J, rowIndx, colIndx: Integer;
  begin
    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viRisUCard.Controller.SelectedRows[I].RecordIndex;
      for J := 0 to SelectedColumnCount - 1 do begin
        colIndx := viRisUCard.Controller.SelectedColumns[J].Index;
        viRisUCard.DataController.SetValue(rowIndx,
                                           viRisUCard.Controller.SelectedColumns[J].Index,
                                           null);
        ClearMemoryArrayItem(rowIndx, colIndx);
      end;
   end;
  end;

begin
   cleanRecord (aRec);
   viRisUCard.DataController.BeginUpdate;
   case aOper of
      operOdsotNew: begin
         // vnos nove odsotnosti
         SelectionNewOdsot (aVal, aShiftNo, aRec);
         end;

      operOdsotDel: begin
         // brisanje neodobrene odsotnosti
         SelectionClearValOds;
      end;

      operOdsotOdobri: begin
         // odobritev odsotnosti
         SelectionSpremeniStatusOdsot('O');
      end;

      operOdsotZavrni: begin
         // odobritev odsotnosti
         SelectionSpremeniStatusOdsot('Z');
      end;

      operSidrajIzmeno: begin
         // sidranje izmene
         aRec.recType := rtFixIzmena;
         aRec.shift_no_razp := aShiftNo;
         SelectionSetSidranje ('', aRec);
         end;

      operSidrajRazp: begin
         // sidranje Razporeda
         aRec.recType := rtRazp;
         aRec.depart_id := aDepartId;
         aRec.dem_id := aDemId;
         aRec.shift_id := aShiftId;
         SelectionSetSidranje (aVal, aRec);
         end;



   end;
   viRisUCard.DataController.EndUpdate;
end;


// vnos nove odsotnosti
procedure TfmOdsot.miOdsotNewClick(Sender: TObject);
var aVP, aStatus: string;
    aRes: TModalResult;

begin
   fmSelOds := tFmSelOds.Create(self);
   try
      with fmSelOds do begin
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
                       null);

end;

procedure TfmOdsot.DeleteAllOdsot(aMNR: integer; aLowDate, aHighDate: TDate);
begin
   // najprej zbriši vse stare odsotnosti, forsirano, tudi odobrene
   spDelOdsot.SetVariable('P_MNR', aMNR);
   spDelOdsot.SetVariable('P_DATUM_OD', aLowDate);
   spDelOdsot.SetVariable('P_DATUM_DO', aHighDate);
   spDelOdsot.SetVariable('P_FORCE', 'D');
   spDelOdsot.Execute;
end;

procedure TfmOdsot.SaveOdsot;
var
   aLowDate, aHighDate: TDateTime;
   i: integer;

   procedure SaveDateMatrix (ri: integer);
   var
      colMNR: TcxGridBandedColumn;
      aMNR: integer;
      i: integer;
      aRec: TDDMIRec;

     begin

      // zapomni si MNR osebe, s katero se ukvarjaš
      colMNR := viRisUCard.GetColumnByFieldName(C_NAME_MNR);
      aMNR := viRisUCard.DataController.GetValue(ri, colMNR.Index);

      // najprej zbriši vse stare odsotnosti, forsirano, tudi odobrene
      DeleteAllOdsot(aMNR, aLowDate, aHighDate);

      // najprej zbriši stare fiksirane vrednosti
      delArmRazp.ClearVariables;
      delArmRazp.SetVariable('P_MNR', aMNR);
      delArmRazp.SetVariable('OD_DATUMA', aLowDate);
      delArmRazp.SetVariable('DO_DATUMA', aHighDate);
      delArmRazp.SetVariable('P_PRENOS_ID', -1);
      delArmRazp.Execute;

      // sprehod skozi vse stolpce ene osebe in iskanje ne-praznih stolpcev
      for i:=0 to viRisUCard.ColumnCount -1 do begin
         // vzemi ime kolone in preveri èe ustreza
         Name:=viRisUCard.Columns[i].Name;

         if (Pos(C_NAME_DAY, Name) > 0) then begin
            // ime kolone je pravo

            if GetMemoryArrayItem(ri, i, aRec) then begin
               if aRec.recType = rtOdsot then begin

                  //if aRec.status = 'V' then begin
                     // nastavi parametre procedure za vnos odsotnosti
                     with spInsOdsot do begin
                       ClearVariables;
                       SetVariable ('P_DATUM', aRec.in_date);
                       SetVariable ('P_MNR', aRec.mnr);
                       SetVariable ('P_VP_ID', aRec.vp_id);
                       SetVariable ('P_STATUS', aRec.Status);
                       SetVariable ('P_DELETE_OLD', 'D');
                       Execute;
                     end;
                  //end;
               end else begin
                  // sidranje
                  with spInsRazp do begin
                    ClearVariables;
                    SetVariable ('P_MNR', aRec.mnr);
                    SetVariable ('P_DATUM', aRec.in_date);
                    if ((aRec.depart_id <> null) and (aRec.depart_id <> 0)) then
                        SetVariable ('P_DEPART_ID', aRec.depart_id);

                    if ((aRec.dem_id <> null) and (aRec.dem_id <> 0)) then
                        SetVariable ('P_DEM_ID', aRec.dem_id);

                    if ((aRec.shift_id <> null) and (aRec.shift_id <> 0)) then
                        SetVariable ('P_SHIFT_ID', aRec.shift_id);

                    if ((aRec.shift_no_razp <> null) and (aRec.shift_no_razp <> 0)) then
                        SetVariable ('P_SHIFT_NO', aRec.shift_no_razp);

                    Execute;
                  end;
               end;
            end;
         end;
      end;
   end;

begin
   aLowDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1, 1,
                               0,0,0,0);
   aHighDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1,
                                DaysInMonth(aLowDate),
                                0,0,0,0);
   try
      // Sprehod skozi grid
      for i := 0 to viRisUCard.DataController.RecordCount - 1 do begin
         SaveDateMatrix (i);
      end;

      dmOracle.oraSession.Commit;
      MessageDlg('Uspešno shranjeno!', mtInformation, [mbOk], 0);
   except
      dmOracle.oraSession.Rollback;
      MessageDlg('Napaka med shranjevanjem!', mtError, [mbOk], 0);
   end;
end;

procedure TfmOdsot.bbSaveClick(Sender: TObject);
begin
   SaveOdsot;
end;

procedure TfmOdsot.OnDayXGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
var
  ri, ci: integer;
  aRec: TDDMIRec;
begin
  if (Assigned(AItem)) then begin
    ci := aitem.Index;
    ri := aRecord.RecordIndex;

    if not GetmemoryArrayItem(ri, ci, aRec) then
      exit;

    if aRec.recType = rtOdsot then begin
        // imamo odsotnost
      if (aRec.status = 'O') then
         aStyle := cxStyleOds1
      else if (aRec.status = 'Z') then
         aStyle := cxStyleOds2;

    end else begin
       // sidranje, ni odsotnost
       // Imamo prisotnost, razpored
       if aRec.shift_no_razp = 1 then begin
         aStyle := cxStyleRaz1;
       end else if aRec.shift_no_razp = 2 then begin
         aStyle := cxStyleRaz2;
       end else if aRec.shift_no_razp = 3 then begin
         aStyle := cxStyleRaz3;
       end;
    end;
  end;
end;

procedure TfmOdsot.miSidrajTurnusClick(Sender: TObject);
var ii:integer;
begin
   fmSelShift := TfmSelShift.create(self);
   with fmSelShift do begin
      ShowModal;
      if ModalResult = mrOk then begin
         ii := rgShifts.ItemIndex;
         SelectedCelsOper(operSidrajIzmeno,
                          '',
                          rgShifts.Items[ii],
                          null,
                          null,
                          null);
      end;
      Destroy;
   end;
end;

procedure TfmOdsot.viRisUCardMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  aHint: string;
  ri, ci: integer;
  aRec: TDDMIRec;
begin
   //determine the current mouse position
  aHitTest := viRisUCard.ViewInfo.GetHitTest(X, Y);
  //hide displayed hint if mouse is not over a grid cell
  if AHitTest.HitTestCode <> htCell then
  begin
    timer1.Enabled := False;
    cxHintStyleController1.HideHint;
    Exit;
  end;

  with TcxGridRecordCellHitTest(AHitTest) do
  ///check the current record and column over which the mouse is placed
    if (FGridRecord <> GridRecord) or (FItem <> Item) or not FHintDisplayed then
    begin
      //redisplay hint window is mouse has been moved to a new cell
      cxHintStyleController1.HideHint;
      Timer1.Enabled := False;
      //store the current record and column
      FItem := Item;
      FGridRecord := GridRecord;
      //obtain the current cell display text
      ri := GridRecord.RecordIndex;
      ci := Item.Index;

      AHint := viRisUCard.DataController.DisplayTexts[ri, ci];

      with viRisUCard.Site.ClientToScreen(Point(X, Y)) do
      begin
        FHintDisplayed := True;
        // show hint
        if GetMemoryArrayItem(ri, ci, aRec) then begin
            DateSeparator := '.';
            ShortDateFormat := 'dddd (d mmmm)';
            aHint := DateToStr (aRec.in_date) + chr(13);

            if aRec.recType = rtOdsot then begin
               // odsotnosti
               aHint := aHint + aRec.vp_desc + chr(13);
               aHint := aHint + 'Vnesel: ' + aRec.cuser + ', ' + DateToStr(aRec.cdate) + chr(13);

               if aRec.status = 'O' then
                  aHint := aHint + 'Odobril: ' + aRec.ouser + ', ' + DateToStr(aRec.ochange);

               if aRec.status = 'Z' then
                  aHint := aHint + 'Zavrnil: ' + aRec.ouser + ', ' + DateToStr(aRec.ochange);
            end else begin
               // sidranja
               if aRec.dem_id <> null then
                  aHint := aHint + aRec.dem_naziv + chr(13);
               if aRec.depart_id <> null then
                  aHint := aHint + aRec.depa_opis + chr(13);
               if aRec.shift_id <> null then
                  aHint := aHint + aRec.shift_desc + chr(13);
               if aRec.shift_no_razp <> null then
                  aHint := aHint + 'Turnus ' + IntToStr (aRec.shift_no_razp);
             end;

        end else
           aHint := '';

        cxHintStyleController1.ShowHint(X, Y, '', AHint);
      end;
      //start the hide hint timer
      Timer1.Enabled := True;
    end;

end;

procedure TfmOdsot.EnableDisablePopupMenuItems;
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
       aRec: TDDMIRec;
   begin
      if ((nRows < 1) or (nCols < 1)) then
         // èe ni niè izbrano tudi niè ne moremo storiti
         exit;

      // preglej izbrano podroèje. Èe je odsotnost že bila vnešena se opcija
      // ne bo prižgala
      for I := 0 to nRows - 1 do begin
         rowIndx := viRisUCard.Controller.SelectedRows[I].RecordIndex;

         for J := 0 to nCols - 1 do begin
            colIndx := viRisUCard.Controller.SelectedColumns[J].Index;
            GetMemoryArrayItem(rowIndx, colIndx, aRec);
            // našel sem odsotnost, na svidenje
            if aRec.recType = rtOdsot then
               exit;
         end;
      end;
      miOdsotNew.Enabled := true;
   end;

   // procedura omogoèi brisanje, odobritev in zavrnitev neodobrenih odsotnosti
   procedure miOdsotDelEnable;
   var I, J: integer;
       rowIndx, colIndx: integer;
       aRec: TDDMIRec;
       foundFix: boolean;
   begin
      if ((nRows < 1) or (nCols < 1)) then
         // èe ni niè izbrano tudi niè ne moremo storiti
         exit;

      // prižgano brisanje
      miOdsotDel.Enabled := true;
      foundFix := false;

      // preglej izbrano podroèje. Èe celotno podroèje ne vsebuje vsaj ene
      // odsotnosti se opcija ne bo prižgala
      for I := 0 to nRows - 1 do begin
         rowIndx := viRisUCard.Controller.SelectedRows[I].RecordIndex;

         for J := 0 to nCols - 1 do begin
            colIndx := viRisUCard.Controller.SelectedColumns[J].Index;

            if GetMemoryArrayItem(rowIndx, colIndx, aRec) then begin

               if aRec.recType <> rtOdsot then begin
                  // našel fiksiranje, ugasni odobravanje odsotnosti
                  miOdsotOdobri.Enabled := false;
                  miOdsotZavrni.Enabled := false;
                  foundFix := true;
               end else begin
                  // našel odsotnost
                  if (aRec.status <> 'V') then begin
                     // odsotnost je že odobrena/ zavrnjena
                     miOdsotDel.Enabled := false;
                     exit;
                  end;

               end;
            end else
               foundFix := true;
         end;
      end;

      if not foundFix then begin
         miOdsotOdobri.Enabled := true;
         miOdsotZavrni.Enabled := true;
      end;
   end;

   // procedura omogoèi sidranje turnusa
   procedure miSidrajTurnusEnable;
   begin
      if ((nRows < 1) or (nCols < 1)) then
         // èe ni niè izbrano tudi niè ne moremo storiti
         exit;

      miSidrajTurnus.Enabled := true;
   end;

   // procedura omogoèi sidranje turnusa
   procedure miSidrajDDMIEnable;
   begin
      if ((nRows <> 1) or (nCols < 1)) then
         // izbrana mora biti natanko 1 vrstica
         exit;

      miSidrajRazp.Enabled := true;
   end;


begin
   nRows := viRisUCard.Controller.SelectedRowCount;
   nCols := viRisUCard.Controller.SelectedColumnCount;

   // najprej onemogoèi vse izbire
   DisableAllItems;

   // Vnos nove odsotnosti je možen samo, èe selekcija ne prekriva obstojeèe
   // odsotnosti. Prekritje sidranja je dovoljeno
   miOdsotNewEnable;

   // Brisanje odsotnosti je možno samo, èe selekcija vsebuje vsaj eno neodobreno
   // odsotnost.
   miOdsotDelEnable;

   // Prižgi menu za sidranje turnusa
   miSidrajTurnusEnable;

   // Prižgi menu za sidranje razporeda
   miSidrajDDMIEnable;

end;

procedure TfmOdsot.mnuPopupPopup(Sender: TObject);
begin
   EnableDisablePopupMenuItems;
end;

procedure TfmOdsot.miOdsotDelClick(Sender: TObject);
begin
   SelectedCelsOper(operOdsotDel,
                    '',
                    null,
                    null,
                    null,
                    null);
end;

procedure TfmOdsot.miSidrajRazpClick(Sender: TObject);
var
   colMNR: TcxGridBandedColumn;
   rowIndx: integer;
   loDat, hiDat: TDAteTime;
   aDisp: string;

   function getLowHighDateFromSelection(var loDate: TDateTime; var hiDate: TDateTime): boolean;
   var
      nCols: integer;
      loColIndx, hiColIndx: integer;
      aLoDay, aHiDay: integer;
   begin
      // datum od-do ugotovimo is selectiona
      nCols := viRisUCard.Controller.SelectedColumnCount;

      try
         // najdi indexa skrajne leve in desne celice
         loColIndx := viRisUCard.Controller.SelectedColumns[0].Index;
         hiColIndx := viRisUCard.Controller.SelectedColumns[nCols-1].Index;

         // zapiši datum, ki je v tagu
         aLoDay := viRisUCard.Columns[loColIndx].Tag - C_TAG_MIN_OFF;
         aHiDay := viRisUCard.Columns[hiColIndx].Tag - C_TAG_MIN_OFF;


         loDate := EncodeDateTime(edLeto.AsInteger, cbMesec.ItemIndex+1,
                                         aLoDay, 0,0,0,0);
         hiDate:= EncodeDateTime(edLeto.AsInteger, cbMesec.ItemIndex+1,
                                         aHiDay, 0,0,0,0);

         Result := true;

      except
         Result := false;
      end;

   end;

begin

   // zapomni si kolono kjer je MNR
   colMNR := viRisUCard.GetColumnByFieldName(C_NAME_MNR);
   rowIndx := viRisUCard.Controller.SelectedRows[0].RecordIndex;

   fmSelDDMI := TfmSelDDMI.create(self);
   with fmSelDDMI do begin
      // mnr osebe!
      edMNR.Text :=  viRisUCard.DataController.GetValue(rowIndx, colMNR.Index);

      if getLowHighDateFromSelection (loDat, hiDat) then begin
         edDatumOd.Date := loDat;
         edDatumDo.Date := hiDat;
         ShowModal;

         if ModalResult = mrOk then begin
            aDisp := quDDMIOsebeSIFRA.AsString + quDDMIOsebeDEPART.AsString;

            SelectedCelsOper(operSidrajRazp,
                             aDisp,
                             null,
                             quDDMIOsebeDEPART_ID.AsVariant,
                             quDDMIOsebeDEM_ID.AsVariant,
                             quDDMIOsebeSHIFT_ID.AsVariant);


         end;
      end else
         MessageDlg ('Napaka pri izboru!', mtError, [mbOk], 0);
      Destroy;
   end;

end;

procedure TfmOdsot.miOdsotOdobriClick(Sender: TObject);
begin
   SelectedCelsOper(operOdsotOdobri,
                    null,
                    null,
                    null,
                    null,
                    null);
end;

procedure TfmOdsot.miOdsotZavrniClick(Sender: TObject);
begin
      SelectedCelsOper(operOdsotZavrni,
                    null,
                    null,
                    null,
                    null,
                    null);
end;

procedure TfmOdsot.sbPrevClick(Sender: TObject);
begin
   PremakniMesec(-1);
end;

procedure TfmOdsot.sbNextClick(Sender: TObject);
begin
   PremakniMesec(1);
end;

procedure TfmOdsot.PremakniMesec(koliko: integer);
var newIndx: integer;
begin

   newIndx := cbMesec.ItemIndex + koliko;

   if newIndx > 11 then begin
      cbMesec.ItemIndex := 0;
      edleto.Value := edLeto.Value + 1;
      exit;
   end;

   if newIndx < 0 then begin
      cbMesec.ItemIndex := 11;
      edleto.Value := edLeto.Value -1;
      exit;
   end;

   cbMesec.ItemIndex := newIndx;
end;

end.
