unit dmOra;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Oracle, Db, OracleData, Solver, Contnrs, Variants;

  const
  C_PARAM_ARM_DELOVISCA_TREE_ID =  'ARM_DELOVISCA_TREE_ID';
  C_PARAM_ARM_UCARD_TREE_ID =      'ARM_UCARD_TREE_ID';
  C_PARAM_ARM_NP_REVERSE_DAYS =    'ARM_NP_REVERSE_DAYS';
  C_PARAM_ARM_NP_REVERSE_SOURCE =  'ARM_NP_REVERSE_SOURCE';
  C_PARAM_ARM_RAZP_DATE_FROM =     'ARM_DATUM_RAZP_OD';

type
  TdmOracle = class(TDataModule)
    oraSession: TOracleSession;
    quDelovisca: TOracleDataSet;
    dsDelovisca: TDataSource;
    quRisUCard: TOracleDataSet;
    quArmDeme: TOracleDataSet;
    dsArmDeme: TDataSource;
    quRisShif: TOracleDataSet;
    dsRisShif: TDataSource;
    quRisUCardMNR: TIntegerField;
    quRisUCardLNAME: TStringField;
    quRisUCardFNAME: TStringField;
    quRisUCardEMPLOYED: TStringField;
    quRisUCardO_DEP_DESC: TStringField;
    quRisUCardCARD_NO: TFloatField;
    quRisUCardORG1: TIntegerField;
    quRisUCardORG2: TIntegerField;
    quRisUCardORG3: TIntegerField;
    quRisPraz: TOracleDataSet;
    quRisPrazSTEVILO: TFloatField;
    quSpol: TOracleDataSet;
    dsSpol: TDataSource;
    quTipZap: TOracleDataSet;
    dsTipZap: TDataSource;
    quIDCardFree: TOracleDataSet;
    dsIDCardFree: TDataSource;
    quIDCardFreeCARD_NO: TFloatField;
    quDDMIList: TOracleDataSet;
    quDDMIListOdsot: TOracleDataSet;
    quPlan: TOracleDataSet;
    quRazp: TOracleDataSet;
    quOdsot: TOracleDataSet;
    quDDMIOseb: TOracleDataSet;
    spLoadTmpDDMI: TOracleQuery;
    quRisPara: TOracleDataSet;
    quDistinctAdmin: TOracleDataSet;
    quLOVRisUCard: TOracleDataSet;
    quDepart: TOracleDataSet;
    quLastniki: TOracleDataSet;
    dsLastniki: TDataSource;
    quRisUCardAKT: TIntegerField;
    quRisUCardOPISODDELKA: TStringField;
    quDDMILocator: TOracleDataSet;
    quObveza: TOracleDataSet;
    quOdsotFromPair: TOracleDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure oraSessionAfterLogOn(Sender: TOracleSession);
    procedure DataModuleDestroy(Sender: TObject);
    procedure quDeloviscaBeforeOpen(DataSet: TDataSet);
    procedure quRisUCardBeforeOpen(DataSet: TDataSet);
    procedure quDepartBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    VerInfo: string;
    VerComment: string;
    VerModul: string;
    procedure SetVersionInfo;
    procedure LoadParameters;
    function ParamGetValue(pName: string; whatField: string):variant;

  public
    { Public declarations }
    paramDateRazpFrom: TDateTime;
    paramTreeIdDelo: integer;
    paramTreeIdUcard: integer;

    procedure OpenCommonQueries;
    function isPraznik (aDate: tDateTime): boolean;
    function GetVersionInfo: String;

    procedure SolverInit(odDatuma, doDatuma: TDate);
    procedure SolverLoadAll (razpID: integer; odDatuma, doDatuma: TDate; odsotVir: integer);
    procedure SolverOsebeLoad;
    procedure SolverDDMILoad (odDatuma, doDatuma: TDate; aOwner: integer);
    procedure SolverPlanLoad (aOwner: integer; odDatuma, doDatuma: TDate);
    procedure SolverAvailabilityLoad(odDatuma, doDatuma: TDate; aMNROwner: integer);
    procedure SolverRazpLoad(prenosId: integer; odDatuma, doDatuma: TDate);
    procedure SolverOdsotLoad(odDatuma, doDatuma: TDate; vir: integer);

    function LocateAndCreateDDMIElem(depart_id, dem_id, shift_id: integer): PDDMIElem;
  end;

var
  dmOracle: TdmOracle;

implementation

{$R *.DFM}

procedure tDmOracle.LoadParameters;
var aResult: variant;
begin
   quRisPara.Open;
   // defaultni datum za zaèetek razporeditve
   aResult := dmOracle.ParamGetValue(C_PARAM_ARM_RAZP_DATE_FROM, 'D_VALUE');
   if aResult = null then
      ParamDateRazpFrom := EncodeDate(2007,4,1)
   else
      ParamDateRazpFrom := TDAteTime(aResult);

   // defaultni tree id za ucard
   ParamTreeIdUCard := dmOracle .ParamGetValue(C_PARAM_ARM_UCARD_TREE_ID, 'N_VALUE');
   if ParamTreeIdUCard = null then
      ParamTreeIdUCard := 1;

   // defaultni tree id za delovišèa
   paramTreeIdDelo := ParamGetValue(C_PARAM_ARM_DELOVISCA_TREE_ID, 'N_VALUE');
   if paramTreeIdDelo = null then
      paramTreeIdDelo := 1;

end;

function tDmOracle.ParamGetValue(pName: string; whatField: string):variant;
begin
   if quRisPara.Locate('PNAME', VarArrayOf([pName]), [loCaseInsensitive]) then
      Result := quRisPara.FieldByName(whatField).AsVariant
   else
      Result := null;
end;

function tDmOracle.isPraznik (aDate: tDateTime): boolean;
var
   aNum: integer;
begin
   with quRisPraz do begin
      Close;
      SetVariable ('P_DATE', aDate);
      Open;
      aNum := quRisPrazStevilo.asInteger;
   end;

   if aNum > 0 then
      isPraznik := true
   else
      isPraznik := false;
end;

procedure TDmOracle.SetVersionInfo;
const
   InfoNum = 2;
   InfoStr : array[1..InfoNum] of string = ('FileVersion', 'Comments');
var
   App, ExeName: String;
   VSize,VHandle,Len: DWORD;
   i, iPos: Integer;
   Buffer: PChar;
   Value: PChar;
begin
   Buffer := nil;

   App :=Application.ExeName;
   ExeName := ExtractFileName(Application.ExeName);

   iPos :=LastDelimiter('.',ExeName);
   VerModul := UpperCase(copy(ExeName,1,iPos-1));

   VSize := GetFileVersionInfoSize (PAnsiChar(App), VHandle);

   if VSize> 0 then begin
      try
         Buffer := AllocMem(VSize);
         GetFileVersionInfo(PChar(App),VHandle,VSize,Buffer);
         for i:=1 to InfoNum do begin
            if VerQueryValue(Buffer,PChar('StringFileInfo\042404E2\'+
                                    InfoStr[i]),Pointer(Value),Len) then

            case i of
               1: VerInfo := Value;
               2:VerComment := Value;
            end;
         end;

      finally
         FreeMem(Buffer,VSize);
      end;
   end;
end;


function TDMOracle.GetVersionInfo: string;
begin
   with dmOracle do begin
      Result := VerModul + ' ' + VerInfo + ' ' + VerComment;
   end;
end;

procedure TdmOracle.OpenCommonQueries;
begin
   quSpol.Open;
   quTipZap.Open;
   quIDCardFree.Open;
   quRisPara.Open;
   quDistinctAdmin.Open;
   quLOVRisUCard.Open;
   quDepart.Open;
   quLastniki.Open;
end;

procedure TdmOracle.DataModuleCreate(Sender: TObject);
begin
   SetVersionInfo;
   GlobSolver := TSolver.Create;
end;

procedure TdmOracle.oraSessionAfterLogOn(Sender: TOracleSession);
begin
   LoadParameters;
   OpenCommonQueries;
end;

// ===================================================================

procedure TdmOracle.SolverInit (odDatuma, doDatuma: TDate);
var nOseb: integer;
begin
   with quRisUCard do begin
      Open;
      nOseb:=RecordCount;
      Close;
   end;
   GlobSolver.Clear;
   GlobSolver.Init(nOseb, odDatuma, doDatuma);
end;

procedure TdmOracle.SolverLoadAll (razpID: integer; odDatuma, doDatuma: TDate; odsotVir: integer);
begin
   SolverDDMILoad (odDatuma, doDatuma, razpID);
   SolverPlanLoad (razpID, odDatuma, doDatuma);
   SolverOsebeLoad;
   SolverAvailabilityLoad (odDatuma, doDatuma, razpID);
   SolverRazpLoad (razpID, odDatuma, doDatuma);
   SolverOdsotLoad (odDatuma, doDatuma, odsotVir);
   globSolver.Razpored.DirtyFlagsClean;
end;

procedure TdmOracle.SolverDDMILoad (odDatuma, doDatuma: TDate; aOwner: integer);
var
   aDDMI: pDDMIElem;

   procedure DDMILoad_Razpored;
   begin
      with quDDMIList do begin
         Close;
         SetVariable('P_DATUM_OD', odDatuma);
         SetVariable('P_DATUM_DO', doDatuma);
         SetVariable ('P_MNR_OWNER', aOwner);
         Open;
         First;
         while not eof do begin
            new (aDDMI);
            aDDMI^.ddmi_type := ddmiRazp;
            aDDMI^.depart_id := FieldByName('DEPART_ID').AsVariant;
            aDDMI^.depa := FieldByName('DEPART').AsString;
            aDDMI^.depa_opis := FieldByName('DESCRIPTION').AsString;
            aDDMI^.dem_id := FieldByName('DEM_ID').AsVariant;
            aDDMI^.dem_sifra := FieldByName('SIFRA').AsString;
            aDDMI^.dem_arm_oznaka := FieldByName('DEM_ARM_OZNAKA').AsString;
            aDDMI^.dem_naziv := FieldByName('NAZIV').AsString;
            aDDMI^.shift_id := FieldByName('SHIFT_ID').AsVariant;
            aDDMI^.shift_arm :=  FieldByName('ARM_OZNAKA').AsString;
            aDDMI^.shift_desc := FieldByName('SHIFT_DESC').AsString;
            aDDMI^.shift_no := FieldByName('SHIFT_NO').AsVariant;
            aDDMI^.start_hhmm := FieldByName('STARTHHMM').AsInteger;
            aDDMI^.stop_hhmm := FieldByName('STOPHHMM').AsInteger;
            aDDMI^.need_hhmm := FieldByName('NEEDHHMM').AsInteger;
            GlobSolver.DDMIListAdd(aDDMI);
            Next;
         end;
         Close;
      end;
   end;

   procedure DDMILoad_Odsotnosti;
   begin
      with quDDMIListOdsot do begin
         Close;
         SetVariable('P_DATUM_OD', odDatuma);
         SetVariable('P_DATUM_DO', doDatuma);
         Open;
         First;
         while not eof do begin
            new (aDDMI);
            aDDMI^.ddmi_type := ddmiOdsot;
            aDDMI^.depart_id := -1;
            aDDMI^.depa := '';
            aDDMI^.depa_opis := '';
            aDDMI^.dem_id := -1;
            aDDMI^.dem_sifra := '';
            aDDMI^.dem_arm_oznaka := '';
            aDDMI^.dem_naziv := 'Odsotnost';
            aDDMI^.shift_id := -1;
            aDDMI^.shift_arm := '';
            aDDMI^.shift_desc := '';
            aDDMI^.shift_no := C_ODS_SHIFT_NO; // odsotnosti so tipa 4
            aDDMI^.start_hhmm := FieldByName('START_HHMM').AsInteger;
            aDDMI^.stop_hhmm := FieldByName('STOP_HHMM').AsInteger;
            aDDMI^.need_hhmm := FieldByName('NEED_HHMM').AsInteger;
            GlobSolver.DDMIListAdd(aDDMI);
            Next;
         end;
         Close;
      end;
   end;

begin
   DDMILoad_Razpored;
   DDMILoad_Odsotnosti;
end;

procedure TdmOracle.SolverPlanLoad(aOwner: integer; odDatuma, doDatuma: TDate);
var
   aPlanElem: pPlanElem;
   aDDMI: pDDMIElem;
begin
   with quPlan do begin
      Close;
      SetVariable('P_DATUM_OD', odDatuma);
      SetVariable('P_DATUM_DO', doDatuma);
      SetVariable('P_MNR_OWNER', aOwner);
      Open;
      First;
      while not eof do begin
         new(aPlanElem);
         aDDMI := GlobSolver.DDMIListFind(FieldByName('DEPART_ID').AsVariant,
                                          FieldByName('DEM_ID').AsVariant,
                                          FieldByName('SHIFT_ID').AsVariant);

         aPlanElem.DDMI := aDDMI;
         aPlanElem.minOseb := FieldByName('NUM_MIN').AsInteger;
         aPlanElem.Osebe := TObjectList.Create;
         GlobSolver.Plan.planListAdd(FieldByName('DATUM').AsDateTime, aPlanElem);
         Next;
      end;
      Close;
   end;

end;

procedure TdmOracle.SolverOsebeLoad;
var
   aOseba: tOseba;

begin
   with dmOracle.quRisUCard do begin
      Open;
      First;
      while not eof do begin
         aOseba := TOseba.Create;
         aOseba.MNR := FieldByName('MNR').AsInteger;
         aOseba.card_no := FieldByName('CARD_NO').AsInteger;
         aOseba.lname := FieldByName('LNAME').AsString;
         aOseba.fname := FieldByName('FNAME').AsString;
         GlobSolver.osebeListAdd(aOseba);
         Next;
      end;
      Close;
   end;
end;

procedure TdmOracle.SolverAvailabilityLoad(odDatuma, doDatuma: TDate; aMNROwner: integer);
var aMNR: integer;
    aDatum : tDateTime;
    aDepartId, aDemId, aShiftId: variant;
begin
   with spLoadTmpDDMI do begin
      // ker gre za temporary tabelo, s commitom pobrišemo stare recorde
      Session.Commit;
      SetVariable ('P_DATUM_OD', odDatuma);
      SetVariable ('P_DATUM_DO', doDatuma);
      SetVariable ('P_MNR_OWNER', aMNROwner);
      SetVariable ('P_LOAD_MNR_PRIMARY', 'DA');
      Execute;
   end;

   with quDDMIOseb do begin
      Open;
      while not eof do begin
         aMNR := FieldByName('MNR').AsInteger;
         aDatum := FieldByName('DATUM').AsDateTime;
         aDepartId := FieldByName('DEPART_ID').AsVariant;
         aDemId := FieldByName('DEM_ID').AsVariant;
         aShiftId := FieldByName('SHIFT_ID').AsVariant;
         globSolver.Availability.AddDDMI(aMNR, aDatum, aDepartId, aDemId, aShiftId);
         Next;
      end;
      Close;
   end;
end;

procedure TdmOracle.SolverRazpLoad(prenosId: integer; odDatuma, doDatuma: TDate);
var aMNR: integer;
    aDatum : tDateTime;
    aDepartId, aDemId, aShiftId: variant;
    aLuser: string;
    aLChange: TDateTime;
    aOwner: integer;
begin
   with quRazp do begin
      Close;
      SetVariable('P_PRENOS_ID', prenosId);
      SetVariable('P_DATUM_OD', odDatuma);
      SetVariable('P_DATUM_DO', doDatuma);
      Open;
      First;
      while not eof do begin
         aMNR := FieldByName('MNR').AsInteger;
         aDatum := FieldByName('DATUM').AsDateTime;
         aDepartId := FieldByName('DEPART_ID').AsVariant;
         aDemId := FieldByName('DEM_ID').AsVariant;
         aShiftId := FieldByName('SHIFT_ID').AsVariant;
         aLUser := FieldByName('LUSER').AsString;
         aLChange := FieldByName('LCHANGE').AsDateTime;
         aOwner := FieldByName('PRENOS_ID').AsInteger;
         globSolver.Razpored.AddRemoveDDMI(aMNR, aDatum, aDepartId, aDemId, aShiftId,
                                           aLUser, aLChange, aOwner);
         Next;
      end;
   end;
end;

procedure TdmOracle.SolverOdsotLoad(odDatuma, doDatuma: TDate; vir: integer);
var
   virOdsot: tOracleDataSet;
   pOdsot: pRazpElem;
   aMNR: integer;
   aDatum: TDateTime;
   aStartHHMM, aStopHHMM, aNeedHHMM: integer;
begin
   // vedno bom odsotnosti prikazal po trenutni obvezi
   with quObveza do begin
      Close;
      SetVariable('P_DATUM_OD', odDatuma);
      SetVariable('P_DATUM_DO', doDatuma);
      Open;
   end;

   if vir = 0 then
      // vir je modul "planiranje odsotnosti"
      virOdsot := quOdsot
   else
      // vir je "urna lista"
      virOdsot := quOdsotFromPair;

   with virOdsot do begin
      Close;
      SetVariable('P_DATUM_OD', odDatuma);
      SetVariable('P_DATUM_DO', doDatuma);
      Open;
      First;
      while not eof do begin
         aMNR := FieldByName('MNR').AsInteger;
         aDatum := FieldByName('IN_DATE').AsDateTime;
         new(pOdsot);
         pOdsot^.recType := rtOdsot;
         pOdsot^.in_date := FieldByName('IN_DATE').AsDateTime;
         pOdsot^.out_date := FieldByName('OUT_DATE').AsDateTime;
         pOdsot^.pair_pk := FieldByName('PAIR_PK').AsInteger;
         pOdsot^.hours_id := FieldByName ('HOURS_ID').AsInteger;
         pOdsot^.vp_id := FieldByName ('VP_ID').AsString;
         pOdsot^.vp_desc := FieldByName ('DESCRIPTION').AsString;
         pOdsot^.status := FieldByName ('STATUS').AsString;
         pOdsot^.cdate  := FieldByName('CDATE').AsDateTime;
         pOdsot^.cuser := FieldByName ('CUSER').AsString;
         pOdsot^.ochange := FieldByName('OCHANGE').AsDateTime;
         pOdsot^.ouser := FieldByName ('OUSER').AsString;


         if pOdsot^.vp_id = 'PRO' then begin
            aStarthhmm := FieldByName ('START_HHMM').AsInteger;
            aStophhmm := FieldByName ('START_HHMM').AsInteger;
            aNeedHHmm := 0;
         end else begin
            aStarthhmm := FieldByName ('START_HHMM').AsInteger;
            aStophhmm := FieldByName ('STOP_HHMM').AsInteger;
            aNeedHHmm := FieldByName ('NEED_HHMM').AsInteger;
         end;

         globSolver.Razpored.AddRemoveOdsot(aMNR,
                                            aDatum,
                                            pOdsot,
                                            aStartHHMM,
                                            aStopHHMM,
                                            aNeedHHMM);
         Next;
      end;
   end;
end;

procedure TdmOracle.DataModuleDestroy(Sender: TObject);
begin
   GlobSolver.Destroy;
end;

procedure TdmOracle.quDeloviscaBeforeOpen(DataSet: TDataSet);
begin
   quDelovisca.SetVariable('TREE_ID', paramTreeIdDelo);
end;

procedure TdmOracle.quRisUCardBeforeOpen(DataSet: TDataSet);
begin
   quRisUCard.SetVariable('P_TREE_ID', paramTreeIdUCard);
end;


procedure TdmOracle.quDepartBeforeOpen(DataSet: TDataSet);
begin
   quDepart.SetVariable('P_TREE_ID', paramTreeIdUCard);
end;

function TdmOracle.LocateAndCreateDDMIElem(depart_id, dem_id, shift_id: integer): PDDMIElem;
var aDDMI: pDDMIElem;
begin
   with quDDMILocator do begin
      if Active then
         Close;
      SetVariable('P_DEPART_ID', depart_id);
      SetVariable('P_DEM_ID', dem_id);
      SetVariable('P_SHIFT_ID', shift_id);
      Open;
   end;

   if quDDMILocator.RecordCount < 1 then begin
      // èe ne najdemo DDMIja vrni null
      quDDMILocator.Close;
      Result := nil;
      exit;
   end;

   quDDMILocator.First;

   new (aDDMI);
   with quDDMILocator do begin
      aDDMI^.ddmi_type := ddmiRazp;
      aDDMI^.depart_id := FieldByName('DEPART_ID').AsVariant;
      aDDMI^.depa := FieldByName('DEPART').AsString;
      aDDMI^.depa_opis := FieldByName('DESCRIPTION').AsString;
      aDDMI^.dem_id := FieldByName('DEM_ID').AsVariant;
      aDDMI^.dem_sifra := FieldByName('SIFRA').AsString;
      aDDMI^.dem_arm_oznaka := FieldByName('DEM_ARM_OZNAKA').AsString;
      aDDMI^.dem_naziv := FieldByName('NAZIV').AsString;
      aDDMI^.shift_id := FieldByName('SHIFT_ID').AsVariant;
      aDDMI^.shift_arm :=  FieldByName('ARM_OZNAKA').AsString;
      aDDMI^.shift_desc := FieldByName('SHIFT_DESC').AsString;
      aDDMI^.shift_no := FieldByName('SHIFT_NO').AsVariant;
      aDDMI^.start_hhmm := FieldByName('STARTHHMM').AsInteger;
      aDDMI^.stop_hhmm := FieldByName('STOPHHMM').AsInteger;
      aDDMI^.need_hhmm := FieldByName('NEEDHHMM').AsInteger;
   end;

   quDDMILocator.Close;
   Result := aDDMI;

end;

end.
