unit fmPlanDelo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxControls, cxGridCustomView,
  cxClasses, cxGridLevel, cxGrid, OracleData, StdCtrls, Buttons,
  cxGridBandedTableView, cxGridDBBandedTableView, ExtCtrls, OracleNavigator,
  cxRichEdit, cxButtonEdit, cxMemo, cxCheckGroup, cxBlobEdit, cxTextEdit,
  RXSpin, Menus, Oracle, DBCtrls, RxLookup;

const
   C_TAG_MIN_OFF = 0;      // tag ID - offset v generiranih poljih za polje MIN
   C_TAG_OPT_OFF = 1000;   // tag ID - offset v generiranih poljih za polje OPT
   C_TAG_MAX_OFF = 2000;   // tag ID - offset v generiranih poljih za polje MAX

   C_NAME_MIN = 'DayMin';
   C_NAME_DEPART_ID = 'DEPART_ID';
   C_NAME_DEM_ID = 'DEM_ID';
   C_NAME_SHIFT_ID = 'SHIFT_ID';

type
  TfmPlan = class(TForm)
    quArmTmpDmx: TOracleDataSet;
    dsArmDeDm: TDataSource;
    myStyles: TcxStyleRepository;
    cxStyle1: TcxStyle;
    Panel1: TPanel;
    bbPopulate: TBitBtn;
    Panel2: TPanel;
    Grid: TcxGrid;
    viDeDm: TcxGridDBBandedTableView;
    leDeDm: TcxGridLevel;
    Panel3: TPanel;
    cbMesec: TComboBox;
    edLeto: TRxSpinEdit;
    cxStyleSobotaHeader: TcxStyle;
    cxStyleNedeljaHeader: TcxStyle;
    cxStyleDelovisceHeader: TcxStyle;
    cxStyleSobCon: TcxStyle;
    mnuPopup: TPopupMenu;
    Poveajizbrane1: TMenuItem;
    Postavivrednost1: TMenuItem;
    Zbriivrednosti1: TMenuItem;
    quLoadTmp: TOracleQuery;
    quArmTmpDmxDEPART_ID: TFloatField;
    quArmTmpDmxDEPART: TStringField;
    quArmTmpDmxDEPART_DESC: TStringField;
    quArmTmpDmxDEM_ID: TFloatField;
    quArmTmpDmxDEM_NAZIV: TStringField;
    quArmTmpDmxSHIFT_ID: TIntegerField;
    quArmTmpDmxSHIFT_DESC: TStringField;
    quArmTmpDmxSHIFT_ARM_OZNAKA: TStringField;
    viDeDmDEPART_DESC: TcxGridDBBandedColumn;
    viDeDmDEM_NAZIV: TcxGridDBBandedColumn;
    viDeDmSHIFT_ARM_OZNAKA: TcxGridDBBandedColumn;
    quPlan: TOracleDataSet;
    quPlanID: TFloatField;
    quPlanDATUM: TDateTimeField;
    quPlanDEPART_ID: TFloatField;
    quPlanDEM_ID: TFloatField;
    quPlanSHIFT_ID: TIntegerField;
    quPlanNUM_MIN: TIntegerField;
    quPlanNUM_OPT: TIntegerField;
    quPlanNUM_MAX: TIntegerField;
    viDeDmDEPART_ID: TcxGridDBBandedColumn;
    viDeDmDEM_ID: TcxGridDBBandedColumn;
    viDeDmSHIFT_ID: TcxGridDBBandedColumn;
    quDeletePlan: TOracleQuery;
    quInsertPlan: TOracleQuery;
    sdHTML: TSaveDialog;
    cxStyleNedCon: TcxStyle;
    Label1: TLabel;
    Label2: TLabel;
    bbPrint: TBitBtn;
    Panel4: TPanel;
    bbSave: TBitBtn;
    bbCancel: TBitBtn;
    bbExcel: TBitBtn;
    cbMini: TCheckBox;
    Panel5: TPanel;
    edMsg: TEdit;
    bbOk: TBitBtn;
    Label4: TLabel;
    cbPrenosID: TRxDBLookupCombo;
    edCount: TRxSpinEdit;
    Label3: TLabel;
    bbNewEmpty: TBitBtn;
    procedure bbPopulateClick(Sender: TObject);
    procedure viDeDmDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Poveajizbrane1Click(Sender: TObject);
    procedure Postavivrednost1Click(Sender: TObject);
    procedure Zbriivrednosti1Click(Sender: TObject);
    procedure bbSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbPrintClick(Sender: TObject);
    procedure bbExcelClick(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bbNewEmptyClick(Sender: TObject);
  private
    { Private declarations }
    doDeletePlanBeforeSave: boolean;
    procedure PrepareTmpTables(doMinimize: boolean);
    procedure InitCalendarGrid;
    procedure LoadPlan;
    procedure SavePlan;
    procedure SelectedCelsOper(aOper: integer);
  public
    { Public declarations }
  end;

var
  fmPlan: TfmPlan;

implementation

{$R *.dfm}
uses DateUtils, cxDataUtils, dmOra, cxGridExportLink,  fmKopirajPlan, ResStrings, appRegistry;


procedure TfmPlan.PrepareTmpTables(doMinimize: boolean);
var
   aLowDate, aHighDate: TDateTime;
   aDaNe: string;
begin
   aLowDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1, 1,
                               0,0,0,0);
   aHighDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1,
                                DaysInMonth(aLowDate),
                                0,0,0,0);

   if cbPrenosID.KeyValue = null then
      raise Exception.Create(C_EXCEPT_MSG_SELECT_OWNER);

   if doMinimize then
      aDaNe := 'D'
   else
      aDaNe := 'N';

   quLoadTmp.Close;
   quLoadTmp.SetVariable('P_DATUM_OD', aLowDate);
   quLoadTmp.SetVariable('P_DATUM_DO', aHighDate);
   quLoadTmp.SetVariable('P_MINIMIZE', aDaNe);
   quLoadTmp.SetVariable('P_MNR_OWNER', cbPrenosID.KeyValue);
   quLoadTmp.Execute;
end;


procedure TfmPlan.InitCalendarGrid;
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
      for i:=0 to viDeDm.ColumnCount -1 do begin
         // Vzemi ime kolone
         Name:=viDeDm.Columns[i].Name;

         if (Pos(C_NAME_MIN, Name) > 0) then begin
            // Ime kolone je pravo, zato jo unièi
            viDeDm.Columns[i].Destroy;
            // pobriši naslednjo rekurzivno, ker se je število kolon zmanjšalo!!!
            DestroyDayColumn;
            // takoj zapusti
            exit;
         end;
      end;
   end;

begin
   DestroyDayColumn;

   aSelDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1, 1, 0,0,0,0);

   for i:=1 to DaysInMonth(aSelDate) do begin
      aColMin := viDeDm.CreateColumn;
      aColMin.Name := C_NAME_MIN + IntToStr(i);
      aTmpDate := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1, i, 0,0,0,0);
      tmp:=FormatDateTime ('ddd', aTmpDate);
      aColMin.Caption := IntToStr(i);// + '(' + tmp + ')';
      aColMin.Position.BandIndex := 1;
      aColMin.Options.Editing := true;
      aColMin.Options.Filtering := false;
      aColMin.Tag := C_TAG_MIN_OFF + i;
      aColMin.DataBinding.ValueType := 'String';

      if (dmOracle.isPraznik(aTmpDate)) then begin
         aColMin.Styles.Header := cxStyleNedeljaHeader;
         aColMin.Styles.Content := cxStyleNedeljaHeader;
      end else begin
         case DayOfWeek(aTmpDate) of
            7: begin
                 aColMin.Styles.Header := cxStyleSobotaHeader;
                 aColMin.Styles.Content := cxStyleSobCon;
               end;
            1: begin
                 aColMin.Styles.Header := cxStyleNedeljaHeader;
                 aColMin.Styles.Content := cxStyleNedCon;
               end;
         end;
      end;

   end;
end;

procedure TfmPlan.SavePlan;
var
   aLowDate, aHighDate: TDateTime;
   i: integer;

   procedure SaveDateMatrix (ri: integer);
   var
      i: integer;
      aDay: integer;
      aDatum: TDateTime;
      aVal: variant;
      aMinNum: integer;
      aDepartId: integer;
      aDemId: integer;
      aShiftId: integer;
      colDepart, colDem, colShift: TcxGridBandedColumn;

   begin
      colDepart := viDeDm.GetColumnByFieldName(C_NAME_DEPART_ID);
      colDem := viDeDm.GetColumnByFieldName(C_NAME_DEM_ID);
      colShift := viDeDm.GetColumnByFieldName(C_NAME_SHIFT_ID);

      if (colDepart = nil) or (colDem = nil) or (colShift = nil) then
         exit;

      // sprehod skozi vse kolone
      for i:=0 to viDeDm.ColumnCount -1 do begin
         // vzemi ime kolone in preveri èe ustreza
         Name:=viDeDm.Columns[i].Name;

         if (Pos(C_NAME_MIN, Name) > 0) then begin
            aVal := viDeDm.DataController.GetValue(ri, i);

            if (aVal <> null) then begin
              // ime se ujema in vrednost obstaja, dan imaš v tagu
              aMinNum := Integer (aVal);
              aDay := viDeDm.Columns[i].Tag - C_TAG_MIN_OFF;
              aDatum := EncodeDateTime(edLeto.AsInteger, cbMesec.ItemIndex+1, aDay,
                                       0,0,0,0);
              aDepartId := viDeDm.DataController.GetValue(ri, colDepart.Index);
              aDemId := viDeDm.DataController.GetValue(ri, colDem.Index);
              aShiftId := viDeDm.DataController.GetValue(ri, colShift.Index);

              // nastavi parametre insert stavka
              with quInsertPlan do begin
                 Close;
                 SetVariable ('P_DATUM', aDatum);
                 SetVariable ('P_DEPART_ID', aDepartId);
                 SetVariable ('P_DEM_ID', aDemId);
                 SetVariable ('P_SHIFT_ID', aShiftId);
                 SetVariable ('P_NUM_MIN', aMinNum);
                 SetVariable ('P_NUM_OPT', aMinNum);
                 SetVariable ('P_NUM_MAX', aMinNum+1);
                 SetVariable ('P_MNR_OWNER', cbPrenosId.KeyValue);
                 Execute;
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

   if doDeletePlanBeforeSave then begin
      quDeletePlan.Close;
      quDeletePlan.SetVariable('P_DATUM_OD', aLowDate);
      quDeletePlan.SetVariable('P_DATUM_DO', aHighDate);
      quDeletePlan.SetVariable('P_MNR_OWNER', cbPrenosID.KeyValue);
      quDeletePlan.Execute;
   end;

   // Sprehod skozi grid DEPART - DEM - SHIFT
   for i := 0 to viDeDm.DataController.RecordCount - 1 do begin
      SaveDateMatrix (i);
   end;

   {
   // prejsnja metoda, sprehod skozi query in ne skozi grid
   quArmTmpDmx.First;
   while not quArmTmpDmx.Eof do begin
      // Za vsak zapis preglej plan
      SaveDateMatrix;
      quArmTmpDmx.Next;
   end;
   }

   dmOracle.oraSession.Commit;

end;


procedure TfmPlan.LoadPlan;
var
   aLowDate, aHighDate: TDateTime;
   ci: integer;

function getColumnIndex (aDate: TDateTime): Integer;
var y,m,d,h,mi,ss,mm: word;
    i: integer;
    colName : string;
begin
   DecodeDateTime(aDate, y, m, d, h, mi, ss, mm);
   colName := 'DayMin' + IntToStr(d);
   for i:=0 to viDeDm.ColumnCount -1 do begin
      if viDeDm.Columns[i].Name = colName then begin
         Result := viDeDm.Columns[i].Index;
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

   // Sprehod skozi vse zapise kombinacije DEPART - DEM - SHIFT
   quArmTmpDmx.First;

   while not quArmTmpDmx.Eof do begin
      edMsg.Text := IntToStr (quArmTmpDmx.RecNo) + ' od ' +  IntToStr (quArmTmpDmx.RecordCount);
      edMsg.Refresh;
      Application.ProcessMessages;
      // Za vsak zapis preglej plan
      quPlan.Close;
      quPlan.SetVariable('P_DATUM_OD', aLowDate);
      quPlan.SetVariable('P_DATUM_DO', aHighDate);
      quPlan.SetVariable('P_DEPART_ID', quArmTmpDmxDEPART_ID.AsInteger);
      quPlan.SetVariable('P_DEM_ID', quArmTmpDmxDEM_ID.AsInteger);
      quPlan.SetVariable('P_SHIFT_ID', quArmTmpDmxSHIFT_ID.AsInteger);
      quPlan.SetVariable('P_MNR_OWNER', cbPrenosID.KeyValue);
      quPlan.Open;

      // sprehod skozi plansko tabelo pri zgornjih pogojih! in postavitev pravih polj
      quPlan.First;
      viDeDm.DataController.BeginUpdate;
      while not quPlan.Eof do begin
         ci := getColumnIndex (quPlanDATUM.AsDateTime);
         //viDeDm.DataController.SetValue(2, ci, quPlanNUM_MIN.AsInteger);
         viDeDm.DataController.SetEditValue(ci, quPlanNUM_MIN.AsInteger,evsValue);
         quPlan.Next;
      end;
      viDeDm.DataController.EndUpdate;

      quArmTmpDmx.Next;
   end;


     {
      // prejsnja metoda, se ni obneslo
      KeyValues := VarArrayCreate([0,2], varInteger);
      while not quPlan.Eof do begin
         KeyValues[0] := quPlanDEPART_ID.AsInteger;
         KeyValues[1] := quPlanDEM_ID.AsInteger;
         KeyValues[2] := quPlanSHIFT_ID.AsInteger;

         if viDeDm.DataController.DataSet.Locate('DEPART_ID;DEM_ID;SHIFT_ID', KeyValues, []) then begin
            ci := getColumnIndex (quPlanDATUM.AsDateTime);
            viDeDm.DataController.SetEditValue(ci, quPlanNUM_MIN.AsInteger,evsValue);
         end;
         quPlan.Next;
      }
end;

procedure TfmPlan.SelectedCelsOper(aOper: integer);

  function SelectedRowCount: Integer;
  begin
    Result := viDeDm.Controller.SelectedRowCount;
  end;

  function SelectedColumnCount: Integer;
  begin
    Result := viDeDm.Controller.SelectedColumnCount;
  end;

  procedure SelectionIncVal (aInc: Integer);
  var
    I, J: Integer;
    val: Variant;
  begin
    for I := 0 to SelectedRowCount - 1 do begin
      for J := 0 to SelectedColumnCount - 1 do begin
        val := viDeDm.DataController.GetValue(
          viDeDm.Controller.SelectedRows[I].RecordIndex,
          viDeDm.Controller.SelectedColumns[J].Index);

        if not VarIsNull(val) then
          val := val + aInc;

        viDeDm.DataController.SetValue(
          viDeDm.Controller.SelectedRows[I].RecordIndex,
          viDeDm.Controller.SelectedColumns[J].Index,
          val);
      end;
   end;
  end;

  procedure SelectionSetVal (aVal: Integer);
  var
    I, J, rowIndx: Integer;
  begin
    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viDeDm.Controller.SelectedRows[I].RecordIndex;
      for J := 0 to SelectedColumnCount - 1 do begin
        viDeDm.DataController.SetValue(rowIndx,
                                       viDeDm.Controller.SelectedColumns[J].Index,
                                       aVal);
      end;
   end;
  end;

  procedure SelectionClearVal;
  var
    I, J, rowIndx: Integer;
  begin
    for I := 0 to SelectedRowCount - 1 do begin
      rowIndx := viDeDm.Controller.SelectedRows[I].RecordIndex;
      for J := 0 to SelectedColumnCount - 1 do begin
        viDeDm.DataController.SetValue(rowIndx,
                                       viDeDm.Controller.SelectedColumns[J].Index,
                                       null);
      end;
   end;
  end;

begin
   viDeDm.DataController.BeginUpdate;
   case aOper of
      1: SelectionIncVal (edCount.AsInteger);
      2: SelectionSetVal (edCount.AsInteger);
      3: SelectionClearVal;
   end;
   viDeDm.DataController.EndUpdate;
end;

procedure TfmPlan.bbPopulateClick(Sender: TObject);
begin
   if not cbMini.Checked then begin
      if MessageDlg(C_FMPLANDELO_LOAD_NOT_MINI, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
         exit;
   end;

   if quArmTmpDmx.Active then
      quArmTmpDmx.Session.Commit;

   quArmTmpDmx.Close;

   if cbmesec.ItemIndex < 0 then
      raise exception.Create('Izberi mesec!');

   if edLeto.AsInteger < 1900 then
      raise exception.Create('Plan pred letom 1900!');

   InitCalendarGrid;

   PrepareTmpTables(cbMini.Checked);

   quArmTmpDmx.Open;

   // PRED NALAGANJEM OBVEZNO IZKLJUÈI FILTER
   viDeDm.DataController.Filter.Active := false;

   LoadPlan;

   viDeDm.ApplyBestFit();

   doDeletePlanBeforeSave := true;

end;

procedure TfmPlan.viDeDmDragDrop(Sender, Source: TObject; X, Y: Integer);
var recNo: integer;
begin
   recNo := viDeDm.Controller.SelectedColumnCount;

   MessageDlg('DragDrop! ColCount='+ IntToStr(recNo) + ' X=' + IntToStr(X) + ' Y=' + IntToStr(Y),
      mtInformation,
      [mbOk], 0);
end;

procedure TfmPlan.Poveajizbrane1Click(Sender: TObject);
begin
   SelectedCelsOper(1);
end;

procedure TfmPlan.Postavivrednost1Click(Sender: TObject);
begin
   SelectedCelsOper(2);
end;

procedure TfmPlan.Zbriivrednosti1Click(Sender: TObject);
begin
   SelectedCelsOper(3);
end;

procedure TfmPlan.bbSaveClick(Sender: TObject);
begin
   if cbPrenosID.KeyValue = null then
      raise Exception.Create(C_EXCEPT_MSG_SELECT_OWNER);

   if not quArmTmpDmx.Active then begin
      if MessageDlg(C_FMPLANDELO_PLAN_NOT_ACTIVE, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
         exit;
   end;

   if quArmTmpDmx.RecordCount <= 0 then begin
      if MessageDlg(C_FMPLANDELO_PLAN_EMPTY, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
         exit;
   end;

   try
      Cursor := crHourGlass;
      SavePlan;
      MessageDlg('Plan uspešno shranjen!',  mtInformation, [mbOk], 0);
   finally
      Cursor := crDefault;
   end;

end;

procedure TfmPlan.FormCreate(Sender: TObject);
var aY, aM, aD: Word;
begin
   DecodeDate (Date, aY, aM, aD);
   edLeto.Value := aY;
   cbMesec.ItemIndex := aM -1;
   InitCalendarGrid;
   cbPrenosId.KeyValue := dmOracle.quLastniki.FieldByName('MNR').AsInteger;
end;

procedure TfmPlan.bbPrintClick(Sender: TObject);
begin
   sdHtml.FileName := 'Plan' + cbMesec.Text + edLeto.Text + '.html';
   sdHtml.FilterIndex := 1;
   if sdHTML.Execute then begin
      ExportGridToHTML(sdHTML.FileName, Grid);
   end;


end;

procedure TfmPlan.bbExcelClick(Sender: TObject);
begin
   sdHtml.FileName := 'Plan' + cbMesec.Text + edLeto.Text + '.xls';
   sdHtml.FilterIndex := 2;
   if sdHTML.Execute then begin
         ExportGridToExcel(sdHTML.FileName, Grid);
   end;

end;

procedure TfmPlan.bbOkClick(Sender: TObject);
begin
   fmCopyPlan := tFmCopyPlan.create(self);
   fmCopyPlan.edFrom.Date := EncodeDateTime (edLeto.AsInteger,cbMesec.ItemIndex + 1, 1, 0,0,0,0);
   fmCopyPlan.ShowModal;
   fmCopyPlan.destroy;

end;

procedure TfmPlan.FormShow(Sender: TObject);
var
   aRegistry: tAppRegistry;
begin
   aRegistry := tAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.RestoreGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmPlan.Name, TcxGridDBTableView(viDeDm));
   aRegistry.Free;
end;

procedure TfmPlan.FormClose(Sender: TObject; var Action: TCloseAction);
var
   aRegistry: tAppRegistry;
begin
   aRegistry := tAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.SaveGridLayout(C_REGISTRY_KEYNAME_ARGUI, fmPlan.Name, TcxGridDBTableView(viDeDm));
   aRegistry.Free;
   doDeletePlanBeforeSave:=true;
end;

procedure TfmPlan.bbNewEmptyClick(Sender: TObject);
begin
   if quArmTmpDmx.Active then
      quArmTmpDmx.Session.Commit;
   quArmTmpDmx.Close;

   if cbmesec.ItemIndex < 0 then
      raise exception.Create('Izberi mesec!');

   if edLeto.AsInteger < 1900 then
      raise exception.Create('Plan pred letom 1900!');

   InitCalendarGrid;

   // nova matrika se vedno zaène neminimizirano z upoštevanimi filtri!
   PrepareTmpTables(false);

   quArmTmpDmx.Open;

   viDeDm.ApplyBestFit();

   doDeletePlanBeforeSave := false;
end;

end.
