unit fmRazDnevni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, Mask, ToolEdit, ExtCtrls, RXSplit, RxLookup,
  DB, dxmdaset, ComCtrls, dxtree, dxdbtree, OracleData, Grids, DBGrids,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxGrid, solver, resStrings, cxMemo, Contnrs, Math,
  cxTextEdit, Menus, cxContainer, cxMCListBox;

type
  TfmRazpD = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    edDatum: TDateEdit;
    sbPrev: TSpeedButton;
    sbNext: TSpeedButton;
    Panel3: TPanel;
    RxSplitter1: TRxSplitter;
    quPlan: TOracleDataSet;
    quPlanID: TFloatField;
    quPlanDATUM: TDateTimeField;
    quPlanDEPART_ID: TFloatField;
    quPlanDEM_ID: TFloatField;
    quPlanSHIFT_ID: TIntegerField;
    quPlanNUM_MIN: TIntegerField;
    quPlanNUM_OPT: TIntegerField;
    quPlanNUM_MAX: TIntegerField;
    Grid: TcxGrid;
    viDeDm: TcxGridDBBandedTableView;
    leDeDm: TcxGridLevel;
    dsPlan: TDataSource;
    quPlanDEPART: TStringField;
    quPlanDEPA_DESC: TStringField;
    quPlanSIFRA: TStringField;
    quPlanNAZIV: TStringField;
    quPlanARM_OZNAKA: TStringField;
    quPlanSHIFT_NO: TIntegerField;
    quPlanSHIFT_DESC: TStringField;
    viDeDmDEPA_DESC: TcxGridDBBandedColumn;
    viDeDmNAZIV: TcxGridDBBandedColumn;
    viDeDmSHIFT_DESC: TcxGridDBBandedColumn;
    viDeDmNUM_MIN: TcxGridDBBandedColumn;
    viDeDmColOsebe: TcxGridDBBandedColumn;
    viDeDmColNumOseb: TcxGridDBBandedColumn;
    viDeDmColNumDelta: TcxGridDBBandedColumn;
    Label1: TLabel;
    laDatum: TLabel;
    mnuPopup: TPopupMenu;
    miOsebaAdd: TMenuItem;
    miOsebaDel: TMenuItem;
    Panel4: TPanel;
    Label2: TLabel;
    Panel5: TPanel;
    Label3: TLabel;
    lbNerazp: TcxMCListBox;
    lbOdsot: TcxMCListBox;
    Panel6: TPanel;
    bbOk: TBitBtn;
    myStyles: TcxStyleRepository;
    cxStyleRaz1: TcxStyle;
    cxStyleRaz3: TcxStyle;
    cxStyleRaz4: TcxStyle;
    cxStyleRaz2: TcxStyle;
    xStyleFooter: TcxStyle;
    miAddOsebaNoCheck: TMenuItem;
    N1: TMenuItem;
    viDeDmDEPART_ID: TcxGridDBBandedColumn;
    viDeDmDEM_ID: TcxGridDBBandedColumn;
    viDeDmSHIFT_ID: TcxGridDBBandedColumn;
    procedure FormCreate(Sender: TObject);
    procedure sbPrevClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
    procedure miOsebaAddClick(Sender: TObject);
    procedure miOsebaDelClick(Sender: TObject);
    procedure viDeDmDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbNerazpMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbNerazpEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure viDeDmDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    { Private declarations }
    fOwner: variant;
    OsebaDrDr: TOseba; // oseba s katero delamo drag-drop operacijo
    rIndxDrDr: integer; // record index, v katerega drag - dropamo
    DDMIDrDr: pDDMIElem;
    procedure LoadPlan;
    procedure LoadOsebe;
    procedure LoadOdsot;
    procedure LoadNerazp;
    procedure LoadOsebeFocusedDDMI(aList: TObjectList);
  public
    { Public declarations }
    procedure SetDate(aDate: TDate);
    procedure SetOwner(aOwner: variant);
  end;

var
  fmRazpD: TfmRazpD;

implementation

uses fmOsebaSelect, DateUtils, dmOra, fmRazpOsebNew, StrUtils;

{$R *.dfm}

procedure TfmRazpD.FormCreate(Sender: TObject);
begin
   if globSolver.Razpored.DayCount <= 0 then
      raise Exception.Create(C_EXCEPT_MSG_SOLVER_NOT_INIT);
end;

procedure TfmRazpD.SetDate(aDate: TDate);
var aMsg: string;
begin
   if (aDate < globSolver.Razpored.FirstDay) or (aDate > globSolver.Razpored.LastDay) then begin
      aMsg := Format(C_EXCEPT_MSG_INVALID_DATE_RANGE, [dateToStr(globSolver.Razpored.FirstDay),
                                                       dateToStr(globSolver.Razpored.LastDay)]);
      raise Exception.Create(aMsg);
   end;
   edDatum.Date := aDate;

   aMsg := FormatDateTime('dddd, d. mmmm yyyy', aDate);
   laDatum.Caption := aMsg;

   LoadPlan;

   LoadOsebe;

   LoadOdsot;

   LoadNerazp;
end;

procedure TfmRazpD.SetOwner(aOwner: variant);
begin
   fOwner := aOwner;
end;


procedure TfmRazpD.LoadOsebeFocusedDDMI(aList: TObjectList);
var ii: integer;
    aOseba: TOseba;
    aTxt, aSunHoly, aHrs: string;
    aCritHrs, aCritSunHoly: tCriteria;
    ri, ci, ci2, ci3: integer;
begin
   aTxt := '';

   for ii := 0 to aList.Count-1 do begin
      aOseba := tOseba(aList.Items[ii]);
      if aOseba = nil then
         raise Exception.Create('Ne najdem osebe!');

      aCritHrs := aOseba.GetCriteria(ctHours);
      if aCritHrs <> nil then
         aHrs := FmtMinutesHHMM(aCritHrs.stopHours, 3)
      else
         aHrs := '???:??';

      aCritSunHoly := aOseba.GetCriteria(ctSunHoly);
      if aCritSunHoly <> nil then
         aSunHoly := IntToStr(aCritSunHoly.SumDays)
      else
         aSunHoly := '?';

      aTxt:=aTxt + Format('%s %s [U=%s NP=%s]', [aOseba.lname, aOseba.fname,aHrs, aSunHoly]);
      aTxt := aTxt + chr(13);
   end;

   ri := viDeDm.DataController.FocusedRecordIndex;
   ci := viDeDmColOsebe.Index;
   ci2 := viDeDmColNumOseb.Index;
   ci3 := viDeDmColNumDelta.Index;

   viDeDm.DataController.BeginUpdate;
   viDeDm.DataController.SetValue(ri, ci, aTxt);
   viDeDm.DataController.SetValue(ri, ci2, aList.count);
   viDeDm.DataController.SetValue(ri, ci3, aList.count -quPlanNUM_MIn.AsInteger) ;
   viDeDm.DataController.EndUpdate;
end;

procedure TfmRazpD.LoadOsebe;
var aDDMI: pDDMIElem;
   aPlanElem: pPlanElem;

begin
   with quPlan do begin
      First;

      while not eof do begin
         aDDMI := globSolver.DDMIListFind(quPlanDEPART_ID.AsInteger,
                                 quPlanDEM_ID.AsInteger,
                                 quPlanSHIFT_ID.AsInteger);
         if aDDMI <> nil then begin
            aPlanElem := globSolver.Plan.planListFindElementByDDMI(edDatum.Date, aDDMI);
            if aPlanElem <> nil then begin
               LoadOsebeFocusedDDMI(aPlanElem^.Osebe);
            end;
         end;

         Next;
      end;
   end;
end;

procedure TfmRazpD.LoadOdsot;
   var aRazp: pRazpElem;
       ii: integer;
       dayIndx: integer;

   procedure ShowOsebaOnList(aRazpElem: pRazpElem);
   var aTxt: string;
       aOseba: tOseba;
   begin
      if aRazpElem = nil then
         exit;

      aOseba := aRazpElem^.Oseba;
      if aOseba = nil then
         exit;

      aTxt := Format('%d;%s;%s;%s', [aOseba.MNR,
                                     aOseba.lname,
                                     aOseba.fname,
                                     aRazpElem^.vp_id]);
      lbOdsot.Items.Add(aTxt);
   end;
begin
   dayIndx := DaysBetween(globSolver.Razpored.firstDay, edDatum.date);

   lbOdsot.Items.Clear;
   for ii := 0 to globSolver.Razpored.StevOseb-1 do begin
      aRazp := globSolver.Razpored.GetRazporedElement(ii, dayIndx);
      if aRazp <> nil then begin
         if aRazp^.recType = rtOdsot then
            ShowOsebaOnList(aRazp);
      end;
   end;
end;

procedure TfmRazpD.LoadNerazp;
   var aRazp: pRazpElem;
       ii: integer;
       dayIndx: integer;

   procedure ShowOsebaNerazp(aOseba: tOseba);
   var aTxt, aSunHoly, aHrs: string;
       aCritHrs, aCritSunHoly: tCriteria;

   begin
      if aOseba = nil then
         exit;

      aCritHrs := aOseba.GetCriteria(ctHours);
      if aCritHrs <> nil then
         aHrs := FmtMinutesHHMM(aCritHrs.stopHours, 3)
      else
         aHrs := '???:??';

      aCritSunHoly := aOseba.GetCriteria(ctSunHoly);
      if aCritSunHoly <> nil then
         aSunHoly := IntToStr(aCritSunHoly.SumDays)
      else
         aSunHoly := '?';

      aTxt:=Format('%d;%s;%s;%s;%s', [aOseba.MNR, aOseba.lname, aOseba.fname, aHrs, aSunHoly]);

      lbNerazp.Items.Add(aTxt);
   end;
begin
   dayIndx := DaysBetween(globSolver.Razpored.firstDay, edDatum.date);

   lbNerazp.Items.Clear;
   for ii := 0 to globSolver.Razpored.StevOseb-1 do begin
      aRazp := globSolver.Razpored.GetRazporedElement(ii, dayIndx);
      if aRazp = nil then begin
            ShowOsebaNerazp(toseba(globSolver.Osebe.items[ii]));
      end;
   end;
end;


procedure TfmRazpD.LoadPlan;
begin
   with quPlan do begin
      Close;
      SetVariable('P_DATUM', edDatum.Date);
      SetVariable('P_MNR_OWNER', fOwner);
      Open;
   end;
end;

procedure TfmRazpD.sbPrevClick(Sender: TObject);
begin
   if edDatum.Date > globSolver.Razpored.FirstDay then begin
      edDatum.Date := edDatum.Date -1;
      SetDate(edDatum.Date);
   end;
end;

procedure TfmRazpD.sbNextClick(Sender: TObject);
begin
   if edDatum.Date < globSolver.Razpored.LastDay then begin
      edDatum.Date := edDatum.Date + 1;
      SetDate(edDatum.Date);
   end;
end;

procedure TfmRazpD.miOsebaAddClick(Sender: TObject);
var aList: tObjectList;
    aDDMI: pDDMIElem;
    aPlanElem: pPlanElem;
    aOseba: tOseba;
    i: integer;
begin
   aList := tObjectList.Create;

   aDDMI := globSolver.DDMIListFind(quPlanDEPART_ID.AsInteger,
                                    quPlanDEM_ID.AsInteger,
                                    quPlanSHIFT_ID.AsInteger);

   if aDDMI = nil then
      Exception.Create('Ne najdem DDMIja!');

   if Sender.ClassName = 'TMenuItem' then begin
      if TMenuItem(Sender).Name = 'miAddOsebaNoCheck' then
         globSolver.DDMIFindAvailableOsebe(edDatum.Date, aDDMI, aList, false)
      else
         globSolver.DDMIFindAvailableOsebe(edDatum.Date, aDDMI, aList, true);
   end else
      globSolver.DDMIFindAvailableOsebe(edDatum.Date, aDDMI, aList, true);


   fmOsebaSelectDDMI := tFmOsebaSelectDDMI.Create(self, aList, aDDMI);
   with fmOsebaSelectDDMI do begin
      ShowModal;
      if (ModalResult = mrOk) then begin
      // sprehod skozi vse osebe na listi in dodaj izbrane
         for i := 0 to lbOsebe1.Count - 1 do begin
            if lbOsebe1.Selected[i] then begin
               aOseba := tOseba(lbOsebe1.Items.Objects[i]);
               globSolver.Razpored.AddRemoveDDMI(aOseba.MNR,
                                                 edDatum.Date,
                                                 aDDMI^.depart_id,
                                                 aDDMI^.dem_id,
                                                 aDDMI^.shift_id,
                                                 dmOracle.oraSession.LogonUsername,
                                                 Now,
                                                 fmRazp.cbprenosId.KeyValue);
            end;
         end;
         // Za fokusirani record popravi seznam oseb
         aPlanElem := globSolver.Plan.planListFindElementByDDMI(edDatum.Date, aDDMI);
         if aPlanElem <> nil then
            LoadOsebeFocusedDDMI(aPlanElem^.Osebe);
         LoadNerazp;
      end;
   end;

   fmOsebaSelectDDMI.Destroy;
end;

procedure TfmRazpD.miOsebaDelClick(Sender: TObject);
var aDDMI: pDDMIElem;
    aPlanElem: pPlanElem;
    aOseba: tOseba;
    i: integer;
begin
   aDDMI := globSolver.DDMIListFind(quPlanDEPART_ID.AsInteger,
                                    quPlanDEM_ID.AsInteger,
                                    quPlanSHIFT_ID.AsInteger);

   if aDDMI = nil then
      Exception.Create('Ne najdem DDMIja!');

   // Za dani DDMI poišèi planski element
   aPlanElem := globSolver.Plan.planListFindElementByDDMI(edDatum.Date, aDDMI);
   if aPlanElem = nil then
      Exception.Create('Ne najdem Plana!');

   fmOsebaSelectDDMI := tFmOsebaSelectDDMI.Create(self, aPlanElem^.Osebe, aDDMI);
   with fmOsebaSelectDDMI do begin
      ShowModal;
      if (ModalResult = mrOk) then begin
      // sprehod skozi vse osebe na listi in odstrani izbrane
         for i := 0 to lbOsebe1.Count - 1 do begin
            if lbOsebe1.Selected[i] then begin
               aOseba := tOseba(lbOsebe1.Items.Objects[i]);
               globSolver.Razpored.RemoveRazporedElement(aOseba.MNR, edDatum.Date);
            end;
         end;
         // Za fokusirani record popravi seznam oseb
         aPlanElem := globSolver.Plan.planListFindElementByDDMI(edDatum.Date, aDDMI);
         LoadOsebeFocusedDDMI(aPlanElem^.Osebe);
         LoadNerazp;
      end;
   end;
   fmOsebaSelectDDMI.Destroy;
end;

procedure TfmRazpD.viDeDmDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
   HT: TcxCustomGridHitTest;
   aDemId, aDepaId, aShiftId: variant;
   aDDMI: pDDMIElem;

begin
   with TcxGridSite(Sender) do begin
      begin
         // HT je target celica
         HT := ViewInfo.GetHitTest(X, Y);
         if HT is TcxGridRecordCellHitTest then begin
            // drag drop dovoljen samo na stolpcu oseb
            if CompareText (TcxGridRecordCellHitTest(HT).Item.Name, 'viDeDmColOsebe') <> 0 then begin
               // kolona ni prava, na svidenje
               Accept := false;
               exit;
            end;

            // zaèni preverjanje osebe
            if OsebaDrDr = nil then begin
               // drag-drop osebe ni
               Accept := false;
               exit;
            end;

            // dobodi skrite vrednosti DDMIja ki so v prvih 3 celicah grida
            aDemId := TcxGridRecordCellHitTest(HT).GridRecord.Values[0];
            aDepaId := TcxGridRecordCellHitTest(HT).GridRecord.Values[1];
            aShiftId := TcxGridRecordCellHitTest(HT).GridRecord.Values[2];

            // poišèi DDMI
            aDDMI := globSolver.DDMIListFind(aDepaId, aDemId, aShiftId);

            if aDDMI <> nil then begin
               // preveri, èe oseba ki jo drag-dropamo, na izbrani dan v razpoložljivosti
               // vsebuje DDMI, ki smo ga našli v gridu
               if globSolver.Availability.ContainsDDMI(OsebaDrDr.MNR, edDatum.Date, aDDMI^.ddmi_nr) then begin
                  Accept := true;
                  DDMIDrDr := aDDMI;
                  rIndxDrDr := TcxGridRecordCellHitTest(HT).GridRecord.recordIndex;
                  exit;
               end;
            end;
         end;
      end;

      // vsi ostali pogoji ne dovoljujejo zamenjave
      Accept := false;
   end;
end;

procedure TfmRazpD.lbNerazpMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

   function GetSelectedOsebaFromLB: tOseba;
   var aMNR, aPos: integer;
       aTxt: string;
   begin
      if lbNerazp.ItemIndex < 0 then begin
         Result := nil;
         exit;
      end;

      aTxt := lbNerazp.Items[lbNerazp.ItemIndex];
      aPos := Pos(lbNerazp.Delimiter, aTxt);
      aTxt := LeftStr(aTxt, aPos-1);
      aMNR := StrToInt(aTxt);

      Result := globSolver.OsebeListFind(aMNR);
   end;
begin
   // zaèni drag and drop operacijo
   lbNerazp.BeginDrag(false, 3);

   // sedaj pride na vrsto preverjanje osebe
   OsebaDrDr := GetSelectedOsebaFromLB;

   DDMIDrDr := nil;
   rIndxDrDr := -1;

   if OsebaDrDr <> nil then
       // zaèni drag and drop operacijo
      lbNerazp.BeginDrag(false, 3);
end;

procedure TfmRazpD.lbNerazpEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
   OsebaDrDr := nil;
   DDMIDrDr := nil;
   rIndxDrDr := -1;
end;

procedure TfmRazpD.viDeDmDragDrop(Sender, Source: TObject; X, Y: Integer);
var
   aPlanElem: pPlanElem;
begin
   if (OsebaDrDr = nil) or (DDMIDrDr = nil) then
      exit;


   globSolver.Razpored.AddRemoveDDMI(osebaDrDr.MNR,
                                     edDatum.Date,
                                     DDMIDrDr^.depart_id,
                                     DDMIDrDr^.dem_id,
                                     DDMIDrDr^.shift_id,
                                     dmOracle.oraSession.LogonUsername,
                                     Now,
                                     fmRazp.cbprenosId.KeyValue);

   // Za fokusirani record popravi seznam oseb
   if rIndxDrDr >= 0 then
      viDeDm.DataController.FocusedRecordIndex := rIndxDrDr;
   aPlanElem := globSolver.Plan.planListFindElementByDDMI(edDatum.Date, DDMIDrDr);
   if aPlanElem <> nil then
      LoadOsebeFocusedDDMI(aPlanElem^.Osebe);

   // oznaèeno osebo odstrani iz seznama
   lbNerazp.DeleteSelected;
end;

end.
