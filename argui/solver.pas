unit solver;

interface

uses
   Classes, stdctrls, sysutils, Contnrs, Controls, DateUtils, Math, ResStrings,
   RazProbem, RazProbemBase;

const
   // odsotnosti v DDMIjih oznaèim s tipom Izmene 4 - Dorian
   C_ODS_SHIFT_NO = 4;

   // kaj je oznaka noène izmene
   C_NIGHTSHIFT_SHIFT_NO = 3;

//****************************************************************************
//
// DDMI - enake razporeditve na delovišèe, delovno mesto, izmeno.
//        vsebuje tudi zaèetek, konec in trajanje razporeditve
//        Z verzijo 2.0 sva z Dorianom uvedla odsotnosti tudi kot DDMI
//        Tipe odsotnosti obravnavamo kot en sam DDMI (ni važno ali gre za
//        BOL, POR, B30 ... važno je samo trajanje odsotnosti, ki jo dobimo
//        iz koledarja.
//
//****************************************************************************
type
   tDDMIElemType = (ddmiRazp, ddmiOdsot);

type
   tDDMIElem = record
      ddmi_nr: integer; // indeks, ki se samodejno generira
      // tip DDMIja
      ddmi_type: TDDMIElemType;

      // Razporeditev na delovišèe, delovno mesto, Izmeno (DDMI)
      depart_id: variant;
      depa: string;
      depa_opis: string;

      dem_id: variant;
      dem_sifra: string;
      dem_arm_oznaka: string;
      dem_naziv: string;

      shift_id: variant;
      shift_arm: string;
      shift_desc: string;
      shift_no: variant;

      // podatki o zaèetku, koncu in trajanju razporeditve
      start_hhmm: integer;
      stop_hhmm: integer;
      need_hhmm: integer;
   end;

   // pointer to DDMI
   pDDMIElem = ^tDDMIElem;

//****************************************************************************
//
// Kriteriji razporeda osebe
//    Vsaka oseba lahko vsebuje n kriterijev za oceno kvalitete delovnega razporeda
//    Kriterij vsebuje naslednje vrednosti, ki niso nujno vse v uporabi
//         - vsota ur
//         - saldo ur
//         - število dni
//         - zadnji pojav DDMIja
//    Poznamo letne, meseène, tedenske in dnevne kriterije
//    Kriteriji vsebujejo zakonske omejitve, ki jih lahko opcijsko tudi izkljuèimo
//    Vsak kriterij vsebuje seznam DDMIjev, ki nanj vplivajo
//
//****************************************************************************

   // tipi kriterijev - Vsota delovnih ur, Nedeljske in prazniène ure
   type
      tCriteriaType = (ctHours, ctSunHoly, ctNightShift);

   tCriteria = class (tObject)
      // kriterijske vrednosti osebe in zakonske omejitve razporeda.
      private
         fKind: tCriteriaType;// tip kriterija, hard coded naèin obnašanja
         fName: string;       // opcijski naziv kriterija

         fLimAktiv: boolean;  // Flag, ki vklaplja/ izklaplja preverjanje omejitev
         fOrder: integer;     // vrstni red pri preverjanju 1..n, 1 = prvi , n= zadnji

         fStartHours: integer; // zaèetna vrednost v minutah
         fEndHours: integer;   // konèna vrednost v minutah
         fSumHours: integer;   // vsota ur agregata v minutah
         fLimHoursLo: integer; // omejitev za spodnjo vrednost v minutah
         fLimHoursHi: integer; // omejitev za zgornjo vrednost v minutah

         fSaldo: integer;      // saldo ur agregata v minutah
         fLimSaldoLo: integer; // dopustna vrednost manjka ur v minutah
         fLimSaldoHi: integer; // dopustna vrednost viška ur v minutah

         fSumDays: integer;   // število pojav razporeditev
         fStartDays: integer; // zaèetna vrednost kriterija v dnevih
         fEndDays: integer;   // konèna vrednost kriterija v dnevih
         fLimDaysLo: integer; // spodnja omejitev števila dni
         fLimDaysHi: integer; // zgornja omejitev števila dni

         fLastOccur: TDateTime;   // zadnji pojav - zakljuèek dela
         fLimLastOccurLo: integer; // zadnji pojav - spodnja meja
         fLimlastOccurHi: integer; // zadnji pojav - zgornja meja

      public
         constructor Create(aKind: tCriteriaType; aName: string);
         destructor Destroy; override;
         procedure Init(nStartHours: integer; nStartDays: integer; aDate: TDate);
         procedure InfluenceDDMIAdd(aDate: TDate; aDDMI: pDDMIElem);
         procedure InfluenceDDMIRemove(aDate: TDate; aDDMI: pDDMIElem);
         procedure InfluenceStartValues(startHours, startDays: integer);
      published
         property StartHours: integer read fStartHours write fStartHours;
         property StopHours: integer read fEndHours;
         property SumHours: integer read fSumHours;
         property LimitHoursLo: integer read fLimHoursLo write fLimHoursLo;
         property LimitHoursHi: integer read fLimHoursHi write fLimHoursHi;

         property Saldo: integer read fSaldo;
         property LimitSaldoLo: integer read fLimSaldoLo write fLimSaldoLo;
         property LimitSaldoHi: integer read fLimSaldoHi write fLimSaldoHi;

         property StartDays: integer read fStartDays write fStartDays;
         property EndDays: integer read fEndDays;
         property SumDays: integer read fSumDays;
         property LimitDaysLo: integer read fLimDaysLo write fLimDaysLo;
         property LimitDaysHi: integer read fLimDaysHi write fLimDaysLo;

         property LastOccurance: TDateTime read fLastOccur write fLastOccur;
         property LimitOccuranceLo: integer read fLimLastOccurLo write fLimLastOccurLo;
         property LimitOccuranceHi: integer read fLimLastOccurHi write fLimLastOccurHi;

         property LimitsActive: boolean read fLimAktiv write fLimAktiv;
         property EvaluationOrder: integer read fOrder write fOrder;
   end;

//****************************************************************************
//
// Oseba - objekt s podatki osebe.
//    Vsaka oseba vsebuje seznam kriterijev
//    Vsaka oseba vsebuje dinamièni array dnevnih seznamov razpoložljivih DDMIjev.
//
//****************************************************************************

   // oseba
   tOseba = class (TObject)
      private
         fNdx_nr: integer;
         fMnr: integer;
         fCard_no: integer;
         fLname: string;
         fFname: string;
         fCritList: tObjectList; // seznam kriterijev osebe - tCriteria
         procedure AddCriteria (aCrit: tCriteria);
      public
         constructor Create;
         destructor Destroy; override;
         function GetCriteria (aCritKind: tCriteriaType): tCriteria;
         procedure RefreshAllCriteria (aDatum: TDate; aDDMI: pDDMIElem; mode: integer);
      published
         property MNR: Integer read fMNR write fMNR;
         property card_no: Integer read fCard_no write fCard_no;
         property lname: string read fLname write fLName;
         property fname: string read fFname write fFName;
   end;

   // kazalec na osebo
   pOseba = ^tOseba;

//****************************************************************************
//
// tRazpElem -  element razporeda osebe. Lahko je odsotnost, razporeditev ali fiksiranje
//
//****************************************************************************
   // tipi recordov v matriki razporeda
   type tRazpRecType = (rtEmpty, rtOdsot, rtRazp, rtFixIzmena, rtFixDM, rtFixDelovisce);

   tRazpElem = record
      recType: TRazpRecType; // tip zapisa
      in_date: TDateTime; // datum odsotnosti, razporeda ali fiksiranja

      // odsotnost preživimo brez kazalca na seznam VDjev
      pair_pk: integer; // id zapisa iz baze
      out_date: TDateTime;
      hours_id: integer;
      vp_id: string;
      vp_desc: string;
      status: string;
      cdate: TDateTime;
      cuser: string;
      ochange: TDateTime;
      ouser: string;

      // razpored vedno vsebuje kazalec na DDMI
      id: integer; // id zapisa iz baze
      DDMI: pDDMIElem; // kazalec na DDMI
      mnr_owner: integer; // lastnik razporeda
      priimekime_owner: string; // priimek in ime lastnika

      // oseba
      Oseba: tOseba;


   end;

   // kazalec na razpored
   pRazpElem = ^tRazpElem;

//****************************************************************************
//
// tPlan -  plan, ki vsebuje enodimenzionalni dinamièni array
//          dnevnih seznamov.
//
//          Vsak dnevni seznam je lista elementov tipa tPlanElem
//
//****************************************************************************

   // element plana
   tPlanElem = record
      DDMI: pDDMIElem;
      minOseb: integer;
      maxOseb: integer;
      Osebe: tObjectList; //seznam oseb, ki zasedajo ta DDMI
   end;

   // kazalec na element plana
   type pPlanElem = ^tPlanElem;

   // Celoten plan
   tPlan = class(TObject)
      private
         fDateFrom: TDate;
         fDateTo: TDate;
         fDayCount: integer; // število planskih dni
         fPlanList: array of TList; // array seznamov tipa tPlanElem
         function getIndxFromDate(aDatum: TDate): integer;
         function planListGetSize (aIndx: integer): integer;
         procedure planListsClear;
         procedure planListDestroy;
         procedure DisposeAllItemsOnList(aList: TList);
      public
         constructor Create;
         destructor Destroy; override;
         procedure Clear;
         procedure Init (odDneva, doDneva: TDate);
         procedure planListAdd (aDatum: TDate; aPlanElem: pPlanElem);
         function  planListGetElementCount (aDatum: TDate): integer;
         function  planListGetForDay (dayIndx: integer): tList;
         function  planListContainsDDMI(aDatum: TDate; aDDMI: pDDMIElem): boolean;
         function  planListFindElementByDDMI(aDatum: TDate; aDDMI: pDDMIElem): pPlanElem;
         procedure planListOsebaAdd(aDatum: TDate; aDDMI: pDDMIElem; aOseba: TOseba);
         procedure planListOsebaDel(aDatum: TDate; aDDMI: pDDMIElem; aOseba: TOseba);
         procedure SaveToFile (aFileName: string);
         procedure SetAllDayElementsToZero(DayIndx: integer);
      published
         property DayCount: integer read fDayCount;
         property FirstDay: TDate read fDateFrom;
         property LastDay: TDate read fDateTo;
   end;

   type
         tSolver = class; // forward declaration

//****************************************************************************
//
// tRazpored -  objekt celotnega razporeda.
//          Vsebuje dvodimenzionalni dinamièni array razporeda. Element v polju
//          je kazalec na element tipa tRazpElem
//
//****************************************************************************
   // Celoten razpored
   tRazpored = class(TObject)
      private
         // matrika razporeda
         fDateFrom: TDate;
         fDateTo: TDate;
         fDayCount: integer; // število planskih dni
         fStevOseb: integer; // število oseb v razporedu
         fSolver: tSolver;

         mtxRazp: array of array of pRazpElem;

         // indikator sprememb razporeda proti zadnjem shranjevanju v bazo
         mtxLog: array of array of char;
         procedure MatrixInit;
         procedure MatrixClean;
         procedure MatrixDestroy;
         procedure SetDDMI (rIndx, cIndx, ddmiNr: integer;
                            aLUser: string; aLChange: TDateTime; aOwner: integer);
      public
         constructor Create(aSolver: tSolver);
         destructor Destroy; override;
         procedure Clear;
         procedure Init(nOseb: integer; odDneva, doDneva: TDate);
         procedure AddRemoveDDMI (aMNR: integer;
                                  aDatum: TDate;
                                  aDepart_id: variant;
                                  aDem_id: variant;
                                  aShift_id: variant;
                                  aLuser: string;
                                  aLChange: TDateTime;
                                  aOwner: integer);
         procedure AddRemoveOdsot (aMNR: integer;
                                   aDatum: TDate;
                                   aOdsot: pRazpElem;
                                   starthhmm, stophhmm, needhhmm: integer);
         procedure MtxElementSet(rIndx, cIndx: integer; aElem: pRazpElem);
         procedure MtxElementDel(rIndx, cIndx: integer);
         procedure SwapDDMIByIndx (srcRi, srcCi, trgRi, trgCi: integer);
         procedure SaveToFile (aFileName: string);
         procedure SaveDneviToFile (aFileName: string);
         procedure LoadResultsFromFile(aFileName: string;  aOwner: integer);
         procedure LoadResultsFromStructure(aResult: TDMIValsOut;  aOwner: integer);
         function GetRazporedElement(osIndx, dayIndx: integer): pRazpElem;
         procedure RemoveRazporedElement (aMNR: integer; aDatum: TDate);
         procedure DirtyFlagsClean;
         procedure DirtyFlagSet (rIndx, cIndx: integer; aFlag: char);
         function DirtyFlagGet (rIndx, cIndx: integer): char;
         function IsDirty: boolean;

      published
         property DayCount: integer read fDayCount;
         property StevOseb: integer read fStevOseb;
         property FirstDay: TDate read fDateFrom;
         property LastDay: TDate read fDateTo;
   end;

//****************************************************************************
//
// tAvailability - dnevne razpoložljivosti vseh oseb za vse dneve.
//          Vsebuje dvodimenzionalno dinamièno polje seznamov.
//          Element v matriki vsebuje minimiziran seznam DDMIjev, kar pomeni,
//          da ne vsebuje DDMIjev, ki jih ni v planski matriki.
//          Odsotnosti v tej strukturi ni!
//
//****************************************************************************

   tAvailability = class(TObject)
      private
         fDateFrom: TDate;
         fDateTo: TDate;
         fDayCount: integer; // število planskih dni
         fStevOseb: integer; // število oseb v razporedu
         fSolver: tSolver;
         mtxAvail: array of array of TList;
         procedure MatrixCreate;
         procedure MatrixDestroy;
      public
         constructor Create(aSolver: tSolver);
         destructor Destroy; override;
         procedure Init(nOseb: integer; odDneva, doDneva: TDate);
         procedure Clear;
         procedure AddDDMI (aMNR: integer;
                            aDatum: TDate;
                            aDepart_id: variant;
                            aDem_id: variant;
                            aShift_id: variant);
         function ContainsDDMI (aMNR: integer;
                                aDatum: TDate;
                                aDDMINr: integer): boolean;
         function ContainsDDMIByIndex (rIndx, cIndx: integer;
                                       aDDMINr: integer): boolean;
         procedure SaveToFile (aFileName: string);
         function GetListForOsebaDay(osebaIndx, dayIndx: integer): TList;
         function GetListForOsebaDayByMNR(aMNR: integer; aDay: tDate): TList;
         function GetStevOsebForDDMI(aDatum: TDate; aDDMINr: integer): integer;
         function GetStevRazpOsebForDay(aDay: tDate): integer;
      published
         property DayCount: integer read fDayCount;
         property StevOseb: integer read fStevOseb;
         property FirstDay: TDate read fDateFrom;
         property LastDay: TDate read fDateTo;
   end;


//****************************************************************************
//
// tSolver -  glavni objekt - razreševalec, ki vsebuje
//
//    seznam DDMIjev
//    seznam oseb s kriteriji in razpoložljivostjo
//    Plan
//    Razpored
//
//****************************************************************************

   // Glavni class za solver
   TSolver = class (TObject)
      private
         fDateFrom: TDate; // spodnji datum
         fDateTo: TDate;   // zgornji datum
         fStevDni: integer;  // število dni

      public
         // celoten plan
         Plan: tPlan;

         // razpored
         Razpored: tRazpored;

         // razpoložljivost
         Availability: tAvailability;

         // seznam oseb
         Osebe: TObjectList;

         // seznam DDMIjev
         DDMIList: TList;

         constructor Create;
         destructor Destroy; override;
         procedure Clear;
         procedure Init(nOseb: integer; odDneva, doDneva: TDate);

         procedure DDMIListAdd(aDDMI: pDDMIElem);
         procedure DDMIListClear;
         procedure DDMIListSaveToFile (aFileName: string; aDebug: boolean);
         function  DDMIListFind(depart_id, dem_id, shift_id: variant): pDDMIElem;
         function  DDMIListFindOdsot(starthhmm, stophhmm, needhhmm: integer): pDDMIElem;
         procedure DDMIFindAvailableOsebe(aDatum: tDate;
                                          aDDMI: pDDMIElem;
                                          aList: tObjectList;
                                          aStrictChecking: boolean);

         procedure OsebeListAdd(aOseba: tOseba);
         procedure OsebeListClear;
         procedure OsebeListSaveToFile(aFileName: string);
         function  OsebeListFind(aMnr: integer): tOseba;
         procedure OsebePrenosiSaveToFile(aFileName: string);
         procedure OsebeKritStartSaveToFile(aFileName: string);

         procedure CheckFeasibility;
         procedure CheckDateLimits(datumLow, datumHi: TDate);
        
   end;

   var
      globSolver: TSolver;

   // generalna funkcija za konverzijo iz ur v obliki HHMM v minute.
   function HHMM_To_Minutes(aHHMM: integer):integer;
   function Minutes_To_HHMM(aMinutes: integer):integer;

   // prikaz ur z loèilom kot string
   function FmtMinutesHHMM(minutes: integer; nHrsPrec: integer): String;
   function FmtHoursHHMM(hhhmm: integer): String;

implementation

uses dmOra;

// generalne funkcije

function HHMM_To_Minutes(aHHMM: integer):integer;
var ure, minute: integer;
begin

   ure := aHHMM div 100;

   minute := aHHMM mod 100;

   if (ure < 0) then
      Result := 60 * ure - minute
   else
      Result := 60 * ure + minute;
end;

function Minutes_To_HHMM(aMinutes: integer):integer;
var ure, minute: integer;
begin

   ure := aMinutes div 60;

   minute := aMinutes mod 60;

   if (ure < 0) then
      Result := 100 * ure - minute
   else
      Result := 100 * ure + minute;
end;

function FmtMinutesHHMM(minutes: integer; nHrsPrec: integer): String;
var ure, minute: integer;
    aFormat: string;
begin
   ure := minutes div 60;
   minute := minutes mod 60;

   if minutes < 0 then begin
      aFormat := '%-' + IntToStr(nHrsPrec) + '.' + IntToStr(nHrsPrec) + 'd:%2.2d';
      Result := Format(aFormat, [ure, minute*(-1)]);
   end else begin
      aFormat := '%' + IntToStr(nHrsPrec) + '.' + IntToStr(nHrsPrec) + 'd:%2.2d';
      // zaradi boljšega sortiranja nadomestimo minus z blankom
      Result := ' ' + Format(aFormat, [ure, minute]);
   end;
end;

function FmtHoursHHMM(hhhmm: integer): String;
var ure, minute: integer;
begin
   ure := hhhmm div 100;
   minute := hhhmm mod 100;

   if hhhmm < 0 then
      Result := Format('%-2.2d:%2.2d', [ure, minute*(-1)])
   else
      Result := Format('%2.2d:%2.2d', [ure, minute]);

end;

//---------------------------------------------------------------------------
//
// tSolver - implementation part
//
//---------------------------------------------------------------------------

constructor TSolver.Create;
begin
   inherited;
   DDMIList := TList.Create;
   Osebe := TObjectList.Create;
   Plan := tPlan.Create;
   Razpored := tRazpored.Create(self);
   Availability := tAvailability.Create(self);
end;

destructor TSolver.Destroy;
begin
   Clear;
   Availability.Destroy;
   Razpored.Destroy;
   Plan.Destroy;
   Osebe.Destroy;
   DDMIList.Destroy;
   inherited Destroy;
end;

procedure TSolver.Clear;
begin
   Availability.Clear;
   Razpored.Clear;
   Plan.Clear;
   OsebeListClear;
   DDMIListClear;
end;

procedure TSolver.Init(nOseb: integer; odDneva, doDneva: TDate);
begin
   fDateFrom := odDneva;
   fDateTo := doDneva;
   fStevDni := DaysBetween (odDneva, doDneva) + 1;
   Plan.Init(odDneva, doDneva);
   Razpored.Init(nOseb, fDateFrom, fDateTo);
   Availability.Init(nOseb, odDneva, doDneva);
end;

procedure TSolver.DDMIListAdd(aDDMI: pDDMIElem);
begin
   // doloèi številko ddmi-ja kot bodoèi index v listi
   aDDMI.ddmi_nr := DDMIList.Count+1;
   DDMIList.Add(aDDMI);
end;

procedure TSolver.DDMIListClear;
var
   ii: integer;
   anItem: pDDMIElem;
begin
   for ii:=0 to DDMIList.Count-1 do begin
      anItem := DDMIList.Items[ii];
      Dispose(anItem);
   end;
   DDMIList.Clear;
end;

function TSolver.DDMIListFind(depart_id, dem_id, shift_id: variant): pDDMIElem;
var
   i: integer;
   aDDMI: pDDMIElem;

begin
   for i := 0 to DDMIList.Count - 1 do begin
      aDDMI := DDMIList.Items[i];
      if ((aDDMI^.depart_id = depart_id) and
          (aDDMI^.dem_id = dem_id) and
          (aDDMI^.shift_id = shift_id)) then begin
         Result := aDDMI;
         exit;
      end;
   end;

   Result := nil;
end;

function TSolver.DDMIListFindOdsot(starthhmm, stophhmm, needhhmm: integer): pDDMIElem;
var
   i: integer;
   aDDMI: pDDMIElem;

begin
   // ker so odsotnosti DDMIjev na koncu seznama se splaèa iskat od zadaj!
   // ujemati se mora samo ura zaèetka in trajanje
   for i := DDMIList.Count - 1 downto 0 do begin
      aDDMI := DDMIList.Items[i];
      if ((aDDMI^.start_hhmm = starthhmm) and
          (aDDMI^.shift_no = C_ODS_SHIFT_NO) and
          //(aDDMI^.stop_hhmm = stophhmm) and
          (aDDMI^.need_hhmm = needhhmm)) then begin
         Result := aDDMI;
         exit;
      end;
   end;

   Result := nil;
end;

procedure TSolver.DDMIFindAvailableOsebe(aDatum: tDate;
                                         aDDMI: pDDMIElem;
                                         aList: tObjectList;
                                         aStrictChecking: boolean);
var aMsg: string;
    cIndx, rIndx: integer;
    aOseba: tOseba;
begin
   if (aDatum < fDateFrom) or (aDatum > fDateTo) then begin
      aMsg := Format(C_EXCEPT_MSG_INVALID_DATE_RANGE, [dateToStr(fDateFrom), dateToStr(fDateTo)]);
      raise Exception.Create(aMsg);
   end;

   cIndx := DaysBetween(fDateFrom, aDatum);
   if (cIndx >= fStevDni) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   for rIndx := 0 to Osebe.Count - 1 do begin
      // Poišèi osebo iz seznama oseb
      aOseba := tOseba(Osebe.Items[rIndx]);
      if (Razpored.GetRazporedElement(aOseba.fNdx_nr, cIndx) = nil) then begin
         // oseba nima razporeda, torej je potencialni kandidat
         if aStrictChecking then begin
            if Availability.ContainsDDMI(aOseba.MNR, aDatum, aDDMI^.ddmi_nr) then
               // oseba ima na seznamu DDMIjev ta DDMI, zato jo dodaj
               aList.Add(aOseba);
         end else
            // nestriktno preverjanje, dovoli vsakršen razpored
            aList.Add(aOseba);
      end;
   end;
end;


procedure TSolver.DDMIListSaveToFile (aFileName: string; aDebug: boolean);
var
   fOut: TextFile;
   i: integer;
   aDDMI: pDDMIElem;

begin
   AssignFile(fOut, aFileName);
   Rewrite (fOut);

   // prva vrstica je število DDMIjev.
   writeln (fOut, IntToStr(DDMIList.Count));

   // sledi seznam DDMIjev.
   for i := 0 to DDMIList.Count - 1 do begin
      aDDMI := DDMIList.Items[i];
      write (fOut, IntToStr(aDDMI^.ddmi_nr) + ' ' + IntToStr(aDDMI^.shift_no));
      write (fOut, ' ' + IntToStr (aDDMI^.start_hhmm));
      //write (fOut, ' ' + IntToStr (aDDMI^.stop_hhmm));
      write (fOut, ' ' + IntToStr (aDDMI^.need_hhmm));
      // še opis ki niè ne moti
      write (fOut, ' ', aDDMI^.dem_naziv + '_' + aDDMI^.depa_opis + '_' + aDDMI^.shift_desc);

      if not aDebug then
         writeln(fOut)
      else begin
         write (fOut, ' ' + aDDMI^.depa_opis);
         write (fOut, ' ' + aDDMI^.dem_naziv);
         write (fOut, ' ' + aDDMI^.shift_desc);
         writeln(fOut);
      end;
   end;


   CloseFile (fOut);

end;

procedure TSolver.OsebeListAdd(aOseba: tOseba);
begin
   // doloèi številko osebe kot bodoèi index v listi
   aOseba.fNdx_nr := Osebe.Count;
   Osebe.Add(aOseba);
end;

procedure TSolver.OsebeListClear;
begin
   // ker gre za listo objektov, se elementi-osebe na listi pospravijo sami
   // (klièe se destruktor osebe)
   Osebe.Clear;
end;

function TSolver.OsebeListFind(aMnr: integer): tOseba;
var
   i: integer;
   aOseba: tOseba;

begin
   for i := 0 to Osebe.Count - 1 do begin
      aOseba := tOseba(Osebe.Items[i]);
      if (aOseba.MNR = aMnr) then begin
         Result := aOseba;
         exit;
      end;
   end;

   Result := nil;
end;


procedure TSolver.OsebeListSaveToFile(aFileName: string);
var
   fOut: TextFile;
   i: integer;
   aOseba: tOseba;

begin
   AssignFile(fOut, aFileName);
   Rewrite (fOut);

   // prva vrstica je število Oseb.
   writeln (fOut, IntToStr(Osebe.Count));

   // sledi seznam Oseb.
   for i := 0 to Osebe.Count - 1 do begin
      aOseba := tOseba(Osebe.Items[i]);
      write (fOut, IntToStr(i+1) + ' NDX=' + IntToStr(aOseba.fNdx_nr));
      write (fOut, ' MNR=' + IntToStr(aOseba.mnr));
      write (fOut, ' CARD_NO=' + IntToStr(aOseba.card_no));
      write (fOut, ' LNAME=' + aOseba.lname);
      writeln (fOut, ' FNAME=' + aOseba.fname);
   end;

   CloseFile (fOut);
end;

procedure tSolver.OsebePrenosiSaveToFile(aFileName: string);
var
   fOut: TextFile;
   i: integer;
   aOseba: tOseba;
   aCrit: tCriteria;

begin
   AssignFile(fOut, aFileName);
   try
      Rewrite (fOut);

      // sledi seznam Oseb.
      for i := 0 to Osebe.Count - 1 do begin
         aOseba := tOseba(Osebe.Items[i]);
         aCrit := aOseba.GetCriteria(ctHours);
         if aCrit = nil then
            Exception.Create('Ne najdem kritarija za osebo MNR=' + IntToStr(aOseba.MNR));

         writeln(fOut, Format('%d', [aCrit.StartHours div 60]),
                       Format('%2.2d', [abs(aCrit.StartHours mod 60)]));

         //writeln(fOut, aCrit.startHours div 60);
      end;
      CloseFile (fOut);
   except
      CloseFile (fOut);
      raise;
   end;
end;

procedure tSolver.OsebeKritStartSaveToFile(aFileName: string);
var
   fOut: TextFile;
   i: integer;
   aOseba: tOseba;
   aCrit: tCriteria;
   aCritNP: tCriteria;

begin
   AssignFile(fOut, aFileName);
   try
      Rewrite (fOut);

      // sledi seznam Oseb.
      for i := 0 to Osebe.Count - 1 do begin
         aOseba := tOseba(Osebe.Items[i]);
         aCrit := aOseba.GetCriteria(ctHours);
         aCritNP := aOseba.GetCriteria(ctSunHoly);
         if aCrit = nil then
            Exception.Create('Ne najdem kriterija URE za osebo MNR=' + IntToStr(aOseba.MNR));

         if aCritNP = nil then
            Exception.Create('Ne najdem kriterija NP za osebo MNR=' + IntToStr(aOseba.MNR));


         //writeln(fOut, 100*(aCrit.startHours div 60) + aCrit.startHours mod 60);
         writeln(fOut, '0', chr(09), // minimalni poèitek med zap. delovnima dnevoma
                       '0', chr(9),  // maks število delovnih ur zaporednih delovnih dni
                       Format('%d', [aCrit.startHours div 60]),
                       Format('%2.2d', [abs(aCrit.startHours mod 60)]), chr(09), // maks število delovnih ur
                       aCritNP.startDays, chr(09),       // maks število delovnih NP
                       '0', chr(09),                     // maks število delovnih vikendov
                       '0', chr(09));                    // maks število zapo delovnih dni
      end;
      CloseFile (fOut);
   except
      CloseFile (fOut);
      raise;
   end;
end;

procedure TSolver.CheckFeasibility;
var dIndx, j: integer;
    needOseb, imamOseb: integer; // potrebno in razpoložljivo št. oseb na doloèen DDMI
    sumNeedOseb, sumImamOseb: integer; // skupno potrebno in razpoložljivo število oseb na dan d
    aPlanList: tList;
    aMsg, aDay, aDDMi: string;
begin
   for dIndx := 0 to Plan.DayCount - 1 do begin
      aPlanList := globSolver.Plan.planListGetForDay(dIndx);
      sumNeedOseb := 0;
      if aPlanList <> nil then begin
         for j:=0 to aPlanList.Count - 1 do begin
            needOseb := pPlanElem(aPlanList.Items[j])^.minOseb;
            sumNeedOseb := sumNeedOseb + needOseb;
            imamOseb := Availability.GetStevOsebForDDMI(Plan.FirstDay + dIndx,
                                                        pPlanElem(aPlanList.Items[j])^.DDMI^.ddmi_nr);
            if imamOseb < needOseb then begin
               aDay := FormatDateTime('dd mmmm yyyy', globSolver.Plan.FirstDay + dIndx);
               aDDMI := Format ('%d (%s - %s - %s)',
                                 [pPlanElem(aPlanList.Items[j])^.DDMI^.ddmi_nr,
                                  pPlanElem(aPlanList.Items[j])^.DDMI^.depa_opis,
                                  pPlanElem(aPlanList.Items[j])^.DDMI^.dem_naziv,
                                  pPlanElem(aPlanList.Items[j])^.DDMI^.shift_desc
                                  ]
                                );
               aMsg := Format (C_EXCEPT_MSG_NO_SOLUTION, [aDay, aDDMI, needOseb, imamOseb]);
               raise Exception.Create (aMsg);
            end;
         end;
      end; // if aPlanList
      // za dan dIndx poglej koliko oseb imaš suma sumarum
      sumImamOseb := Availability.GetStevRazpOsebForDay(fDateFrom + dIndx);
      if (sumImamOseb < sumNeedOseb) then begin
         aDay := FormatDateTime('dd mmmm yyyy', globSolver.Plan.FirstDay + dIndx);
         aMsg := Format(C_EXCEPT_MSG_NO_SOLUTION_SUM, [aDay, sumNeedOseb, sumImamOseb]);
      end;
   end;
end;

procedure TSolver.CheckDateLimits(datumLow, datumHi: TDate);
begin
   if (Plan.fDateFrom <> datumLow) or (Plan.fDateTo <> datumHi) then begin
      raise Exception.Create (C_EXCEPT_MSG_SOLVER_NOT_INIT);
   end;
end;


//---------------------------------------------------------------------------
//
// tPlan - implementation part
//
//---------------------------------------------------------------------------

constructor tPlan.Create;
begin
   inherited;
   fDayCount := 0;
end;

destructor tPlan.Destroy;
begin
   Clear;
   PlanListDestroy;
   inherited Destroy;
end;

procedure tPlan.Clear;
begin
   PlanListsClear;
   fDateFrom := 0;
   fDateTo := 0;
   fDayCount := 0; 
end;

procedure tPlan.Init (odDneva, doDneva: TDate);
var
   i: integer;
   aList: TList;
begin
   planListDestroy;
   fDayCount := DaysBetween (odDneva, DoDneva) + 1;
   SetLength(fPlanList, fDayCount);
   fDateFrom := odDneva;
   fDateTo := doDneva;

   for i:= 0 to fDayCount - 1 do begin
      aList := TList.Create;
      fPlanList[i]:= aList;
   end;
end;

procedure tPlan.planListAdd (aDatum: TDate; aPlanElem: pPlanElem);
var indx: integer;
begin
   if (aDatum < fDateFrom) or (aDatum > fDateTo) then
      raise Exception.Create('Plan lahko vsebuje samo datume med '
                              + dateToStr(fDateFrom) + ' in ' + dateToStr(fDateTo));

   indx := DaysBetween(fDateFrom, aDatum);
   fPlanList[indx].Add(aPlanElem);
end;

procedure tPlan.DisposeAllItemsOnList(aList: TList);
var
   ii: integer;
   anItem: pPlanElem;
begin
   for ii:=0 to aList.Count-1 do begin
      anItem := aList.Items[ii];

      //anItem.Osebe .Destroy; ?? ne smeš, ker ubiješ osebe
      Dispose(anItem);
      aList.Items[ii] := nil;
   end;
   aList.Clear;
end;

// Pobriše vse elemente seznamov. Liste in array list ostanejo
procedure tPlan.planListsClear;
var
   i: integer;
begin
   for i:= 0 to fDayCount - 1 do begin
      if fPlanList[i] <> nil then begin
         DisposeAllItemsOnList(fPlanList[i]);
         fPlanList[i].Clear;
      end;
   end;
end;

// najprej pobriše vse elemente seznamov, potem unièi še same sezname in array
procedure tPlan.planListDestroy;
var i: integer;
begin
   planListsClear;
   for i:= 0 to fDayCount - 1 do begin
      if fPlanList[i] <> nil then begin
         fPlanList[i].Destroy;
      end;
   end;
   SetLength (fPlanList, 0);
end;

function tPlan.planListGetElementCount (aDatum: TDate): integer;
var indx: integer;
begin
   indx := getIndxFromDate(aDatum);
   Result := planListGetSize(indx);
end;

function tPlan.PlanListGetForDay (dayIndx: integer): tList;
begin
   if (dayIndx >= fDayCount) or (dayIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(dayIndx));

   Result := fPlanList[dayIndx];
end;

procedure tPlan.SetAllDayElementsToZero(DayIndx: integer);
var
   aList: tList;
   refElem: pPlanElem;
   ii: integer;
begin
   aList := PlanListGetForDay(dayIndx);
   if aList <> nil then begin
      for ii := 0 to aList.Count - 1 do begin
         refElem := pPlanElem(aList.Items[ii]);
         refElem^.minOseb := 0;
         refElem^.maxOseb := 0;
      end;
   end;
end;


function tPlan.planListContainsDDMI(aDatum: TDate; aDDMI: pDDMIElem): boolean;
var
   indx, i: integer;
   refElem: pPlanElem;
begin
   if (aDatum < fDateFrom) or (aDatum > fDateTo) then
      raise Exception.Create('Plan vsebuje samo datume med '
                              + dateToStr(fDateFrom) + ' in ' + dateToStr(fDateTo));

   indx := DaysBetween(fDateFrom, aDatum);

   for i := 0 to fPlanList[indx].Count - 1 do begin
      refElem := fPlanList[indx].Items[i];
      if (refElem^.DDMI^.ddmi_nr = aDDMI^.ddmi_nr) then begin
         Result := true;
         exit;
      end;
   end;

   Result := false;
end;

function tPlan.planListFindElementByDDMI(aDatum: TDate; aDDMI: pDDMIElem): pPlanElem;
var
   indx, i: integer;
   refElem: pPlanElem;
begin
   if (aDatum < fDateFrom) or (aDatum > fDateTo) then
      raise Exception.Create('Plan vsebuje samo datume med '
                              + dateToStr(fDateFrom) + ' in ' + dateToStr(fDateTo));

   indx := DaysBetween(fDateFrom, aDatum);

   for i := 0 to fPlanList[indx].Count - 1 do begin
      refElem := fPlanList[indx].Items[i];
      if (refElem^.DDMI^.ddmi_nr = aDDMI^.ddmi_nr) then begin
         Result := refElem;
         exit;
      end;
   end;

   Result := nil;
end;

procedure tPlan.planListOsebaAdd(aDatum: TDate; aDDMI: pDDMIElem; aOseba: TOseba);
var
   aMsg: string;
   aPlanElem: pPlanElem;
begin
   aPlanElem := planListFindElementByDDMI(aDatum, aDDMI);
   if aPlanElem = nil then begin
      aMsg := Format(C_EXCEPT_MSG_NO_PLAN_ELEMENT, [aDDMI^.ddmi_nr]);
      exit;
      //raise Exception.Create(aMsg);
   end;

   aPlanElem^.Osebe.Add(aOseba);
end;

procedure tPlan.planListOsebaDel(aDatum: TDate; aDDMI: pDDMIElem; aOseba: TOseba);
var
   aMsg: string;
   aPlanElem: pPlanElem;
begin
   aPlanElem := planListFindElementByDDMI(aDatum, aDDMI);
   if aPlanElem = nil then begin
      aMsg := Format(C_EXCEPT_MSG_NO_PLAN_ELEMENT, [aDDMI^.ddmi_nr]);
      exit;
      //raise Exception.Create(aMsg);
   end;

   aPlanElem^.Osebe.Extract(aOseba); // Skine se samo kazalec, oseba sama ostane živa
end;


procedure tPlan.SaveToFile (aFileName: string);
var
   fOut: TextFile;
   i, j, nElems: integer;
   aElem: pPlanElem;

begin
   AssignFile(fOut, aFileName);
   Rewrite (fOut);

   // zapiši število dni
   writeln (fOut, IntToStr(fDayCount));

   // sprehod skozi vse dneve plana
   for i := 0 to fDayCount - 1 do begin

      // koliko elementov imaš v dnevu i
      nElems := planListGetSize(i);

      // zapiši številko dneva in koliko DDMIjev imaš
      write (fOut, IntToStr (i+1) + ' ' + IntToStr (nElems));

      for j := 0 to nElems - 1 do begin
         // sprehod skozi celotno listo dneva i
         aElem := fPlanList[i].Items[j];

         // Za vsak DDMI zapiši število oseb
         write (fOut, ' ' + IntToStr(aElem^.DDMI.ddmi_nr) + ' ' + IntToStr(aElem^.minoseb));
      end;
      writeln (fOut);

   end;
   CloseFile(fOut);
end;

function tPlan.planListGetSize (aIndx: integer): integer;
begin
   Result := fPlanList[aIndx].Count;
end;

function tPlan.getIndxFromDate(aDatum: TDate): integer;
var indx: integer;
begin
   if (aDatum < fDateFrom) or (aDatum > fDateTo) then
      raise Exception.Create('Plan lahko vsebuje samo datume med '
                              + dateToStr(fDateFrom) + ' in ' + dateToStr(fDateTo));
   indx := DaysBetween(fDateFrom, aDatum);

   Result := indx;
end;

//---------------------------------------------------------------------------
//
// tOseba - implementation part
//
//---------------------------------------------------------------------------

constructor TOseba.Create;
begin
   inherited;
   fCritList := TObjectList.Create;
   AddCriteria(TCriteria.Create(ctHours, 'Delovne ure'));
   AddCriteria(TCriteria.Create(ctSunHoly, 'Nedeljsko in praznièno delo'));
   AddCriteria(TCriteria.Create(ctNightShift, 'Noèno delo'));
end;

destructor TOseba.Destroy;
begin
   inherited Destroy;
   fCritList.Destroy;
end;

procedure tOseba.AddCriteria (aCrit: tCriteria);
begin
   fCritList.Add(aCrit);
end;

procedure tOseba.RefreshAllCriteria (aDatum: TDate; aDDMI: pDDMIElem; mode: integer);
var
   i: integer;
   aCrit: tCriteria;
begin
   for i:=0 to fCritList.Count-1 do begin
      aCrit := TCriteria(fCritList.items[i]);

      if mode = 1 then
         aCrit.InfluenceDDMIAdd(aDatum, aDDMI)
      else
         aCrit.InfluenceDDMIRemove(aDatum, aDDMI);
   end;
end;

function tOseba.GetCriteria (aCritKind: tCriteriaType): tCriteria;
var
   i: integer;
   aCrit: tCriteria;
begin
   for i:=0 to fCritList.Count-1 do begin
      aCrit := TCriteria(fCritList.Items[i]);
      if aCrit.fKind = aCritKind then begin
         Result := aCrit;
         exit;
      end;
   end;

   Result := nil;

end;



//---------------------------------------------------------------------------
//
// tRazpored - implementation part
//
//---------------------------------------------------------------------------

constructor tRazpored.Create(aSolver: tSolver);
begin
   inherited Create;
   fDayCount := 0;
   fStevOseb := 0;
   fSolver := aSolver;
end;

destructor tRazpored.Destroy;

begin
   Clear;
   MatrixDestroy;
   inherited Destroy;
end;

procedure tRazpored.Init (nOseb: integer; odDneva, doDneva: TDate);
begin
   MatrixDestroy;
   fDayCount := DaysBetween (odDneva, DoDneva) + 1;
   fStevOseb := nOseb;
   fDateFrom := odDneva;
   fDateTo := doDneva;
   MatrixInit;
end;

procedure tRazpored.SetDDMI (rIndx, cIndx, ddmiNr: integer;
                             aLUser: string; aLChange: TDateTime; aOwner: integer);
var anOld, aRazpElem: pRazpElem;
    aDDMI: pDDMIElem;
    aLastnik: TOseba;
begin
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   if (rIndx >= fStevOseb) or (rIndx < 0) then
      raise Exception.Create('Neveljaven indeks osebe! Indx=' + IntToStr(rIndx));


   if (DDMINr > 0) then begin
      // oseba je razporejena bodisi na DDMI ali odsotnost
      // poišèi DDMi iz seznama DDMIjev
      if DDMINr > globSolver.DDMIList.Count then
         raise Exception.Create('Neveljaven DDMI! Indx=' + IntToStr(DDMINr));

      aDDMI := pDDMIElem(globSolver.DDMIList.Items[DDMINr-1]);

      if aDDMI = nil then
         raise Exception.Create('Ne najdem DDMI! DDMINr=' + IntToStr(DDMINr));

      // odsotnosti pusti pri miru
      if (aDDMI^.ddmi_type = ddmiOdsot) then
         exit;

      // preveri stari element razporeda
      anOld := GetRazporedElement(rIndx, cIndx);
      if (anOld <> nil) then begin
         if (anOld^.mnr_owner <> aOwner) then
            // tuji razpored pusti pri miru, ne smeš ga zvoziti!
            exit;

         if (anOld^.DDMI^.ddmi_nr = ddmiNr) then
            // èe se ddmi ni spremenil, ne naredi niè
            exit;
      end;

      // zbriši star element razporeda
      MtxElementDel(rIndx, cIndx);

      // ustvari nov element razporeda
      new(aRazpElem);
      aRazpElem^.recType := rtRazp;
      aRazpElem^.in_date := fDateFrom + cIndx;
      aRazpElem^.Oseba := TOseba(globSolver.Osebe.Items[rIndx]);
      aRazpElem^.DDMI := aDDMI;
      aRazpElem^.Cuser := aLuser;
      aRazpElem^.cdate := aLChange;
      aRazpElem^.mnr_owner := aOwner;

      aLastnik := fSolver.OsebeListFind(aOwner);
      if aLastnik <> nil then
         aRazpElem^.priimekime_owner := aLastnik.lname + ' ' +
                                        aLastnik.fname + ' (' +
                                        IntToStr(aOwner) + ')'
      else
         aRazpElem^.priimekime_owner := IntToStr(aOwner);

      // postavi kazalec nanj
      MtxElementSet(rIndx, cIndx, aRazpElem);

   end else begin
      // pazi, DDMI 0 = prosto ali nerazporejeno ali odsotnost z obvezo 0
      // Èe je na tem indxu že odsotnost, jo pusti pri miru
      anOld := mtxRazp[rIndx, cIndx];
      if (anOld <> nil) then begin
         if (anOld^.DDMI^.ddmi_type <> ddmiOdsot) then begin
            // zbriši star element razporeda
            MtxElementDel(rIndx, cIndx);
         end;
      end;
   end;
end;


procedure tRazpored.AddRemoveDDMI (aMNR: integer;
                                   aDatum: TDate;
                                   aDepart_id: variant;
                                   aDem_id: variant;
                                   aShift_id: variant;
                                   aLuser: string;
                                   aLChange: TDateTime;
                                   aOwner: integer);
var
   rIndx, cIndx: integer;
   aOseba: tOseba;
   aRazpElem: pRazpElem;
   aDDMI: pDDMIElem;
   txt1, aMsg: string;
   aLastnik: TOseba;

begin
   if (aDatum < fDateFrom) or (aDatum > fDateTo) then begin
      aMsg := Format(C_EXCEPT_MSG_INVALID_DATE_RANGE, [dateToStr(fDateFrom), dateToStr(fDateTo)]);
      raise Exception.Create(aMsg);
   end;

   cIndx := DaysBetween(fDateFrom, aDatum);
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   // Poišèi osebo iz seznama oseb
   aOseba := fSolver.OsebeListFind(aMNR);
   if aOseba = nil then
      raise Exception.Create('Ne najdem osebe! MNR=' + IntToStr(aMNR));

   // preveri èe že imaš v matriki zapis in èe, ga sprosti
   rIndx := aOseba.fNdx_nr;
   mtxElementDel(rIndx, cIndx);

   // poišèi DDMi iz seznama DDMIjev
   aDDMI := fSolver.DDMIListFind(aDepart_id, aDem_id, aShift_id);

   if (aDDMI = nil) then begin
      // nisem našel DDMI na seznamu, poišèi po vseh DDMIjih v bazi in dodaj v seznam
      aDDMI := dmOracle.LocateAndCreateDDMIElem(aDepart_id, aDem_id, aShift_id);

      // èe si ga našel, ga dodaj
      if aDDMI <> nil then
         fSolver.DDMIListAdd(aDDMI);

      // in še enkrat poišèi
      aDDMI := fSolver.DDMIListFind(aDepart_id, aDem_id, aShift_id);

      if (aDDMI = nil) then begin
         // èe ga nisi našel je pa res problem
         txt1 := FormatDateTime('dd.mm.yyyy', aDatum);
         aMsg := Format(C_EXCEPT_MSG_NO_DDMI_RAZP, [aMNR, txt1, aDepart_id, aDem_id, aShift_id]);
         raise Exception.Create(aMsg);
      end;
   end;

   // ustvari nov element razporeda
   new(aRazpElem);
   aRazpElem^.recType := rtRazp;
   aRazpElem^.in_date := aDatum;
   aRazpElem^.Oseba := aOseba;
   aRazpElem^.DDMI := aDDMI;
   aRazpElem^.cdate := alChange;
   aRazpElem^.cuser := aLUser;
   aRazpElem^.mnr_owner := aOwner;

   aLastnik := fSolver.OsebeListFind(aOwner);
   if aLastnik <> nil then
      aRazpElem^.priimekime_owner := aLastnik.lname + ' ' +
                                     aLastnik.fname + ' (' +
                                     IntToStr(aOwner) + ')'
   else
      aRazpElem^.priimekime_owner := IntToStr(aOwner);

   // postavi kazalec nanj
   mtxElementSet(rIndx, cIndx, aRazpElem);
end;

procedure tRazpored.RemoveRazporedElement (aMNR: integer; aDatum: TDate);
var
   rIndx, cIndx: integer;
   aOseba: tOseba;
   aMsg: string;

begin
   if (aDatum < fDateFrom) or (aDatum > fDateTo) then begin
      aMsg := Format(C_EXCEPT_MSG_INVALID_DATE_RANGE, [dateToStr(fDateFrom), dateToStr(fDateTo)]);
      raise Exception.Create(aMsg);
   end;

   cIndx := DaysBetween(fDateFrom, aDatum);
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   // Poišèi osebo iz seznama oseb
   aOseba := fSolver.OsebeListFind(aMNR);
   if aOseba = nil then
      raise Exception.Create('Ne najdem osebe! MNR=' + IntToStr(aMNR));

   // preveri èe že imaš v matriki zapis in èe, ga sprosti
   rIndx := aOseba.fNdx_nr;
   mtxElementDel(rIndx, cIndx);
end;

procedure tRazpored.AddRemoveOdsot (aMNR: integer;
                                    aDatum: TDate;
                                    aOdsot: pRazpElem;
                                    starthhmm, stophhmm, needhhmm: integer);
var
   rIndx, cIndx: integer;
   aOseba: tOseba;
   aDDMI: pDDMIElem;
   txt1, txt2: string;
begin
   if (aDatum < fDateFrom) or (floor(aDatum) > fDateTo) then
      raise Exception.Create('Razpored lahko vsebuje samo datume med '
                              + dateToStr(fDateFrom) + ' in ' + dateToStr(fDateTo));

   cIndx := DaysBetween(fDateFrom, aDatum);
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   // Poišèi osebo iz seznama oseb
   aOseba := fSolver.OsebeListFind(aMNR);
   if aOseba = nil then
      raise Exception.Create('Ne najdem osebe! MNR=' + IntToStr(aMNR));

   // preveri èe že imaš v matriki zapis in èe, ga sprosti
   rIndx := aOseba.fNdx_nr;

   // zbriši stari element
   MtxElementDel(rIndx, cIndx);

   // tudi odsotnostim nastavimo pripadajoè DDMI. Èe je oseba Prosta je
   // pribita na DDMI z obveznostjo 0 ur
   if ((aOdsot^.vp_id = 'PRO') or (dmOracle.isPraznik(aDatum))) then
      aDDMI := fSolver.DDMIListFindOdsot(starthhmm, stophhmm, 0)
   else
      aDDMI := fSolver.DDMIListFindOdsot(starthhmm, stophhmm, needhhmm);

   if aDDMI = nil then begin
      // lahko da se je vmes spremenila reg skupina in knjižena odsotnost
      // prikazuje èudne ure, zato ustvari nov DDMI za odsotnost
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
      aDDMI^.start_hhmm := starthhmm;
      aDDMI^.stop_hhmm := stophhmm;
      aDDMI^.need_hhmm := needhhmm;
      fSolver.DDMIListAdd(aDDMI);

      if ((aOdsot^.vp_id = 'PRO') or (dmOracle.isPraznik(aDatum))) then
         aDDMI := fSolver.DDMIListFindOdsot(starthhmm, stophhmm, 0)
      else
         aDDMI := fSolver.DDMIListFindOdsot(starthhmm, stophhmm, needhhmm);

      if aDDMI = nil then begin
         // èe ga sedaj ne najdeš, je pa res exception
         txt1 := FormatDateTime('dd.mm.yyyy', aDatum);
         txt2 := Format(C_EXCEPT_MSG_NO_DDMI_ODSOT, [aMNR, txt1]);
         raise Exception.Create(txt2);
      end;

   end;

   // nastavi tip recorda in kazalec na osebo
   aOdsot^.recType := rtOdsot;
   aOdsot^.Oseba := aOseba;
   aOdsot^.DDMI := aDDMI;

   // vpiši kazalec v matriko razporeda
   MtxElementSet(rIndx, cIndx, aOdsot);
end;

procedure tRazpored.MtxElementDel (rIndx, cIndx: integer);
var
   anOld: pRazpElem;
   aDatum: TDate;
   aOseba: TOseba;
begin
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   if (rIndx >= fStevOseb) or (rIndx < 0) then
      raise Exception.Create('Neveljaven indeks osebe! Indx=' + IntToStr(rIndx));

   anOld := mtxRazp[rIndx, cIndx];
   if (anOld <> nil) then begin
      aDatum:= fDateFrom + cIndx;
      aOseba := anOld^.Oseba;

      if (aOseba = nil) then
         raise Exception.Create('MtxElementDel: Neznana oseba! Indx=' + IntToStr(rIndx));

      mtxRazp[rIndx, cIndx]:= nil;
      aOseba.RefreshAllCriteria(aDatum, anOld^.DDMI, 0);
      fSolver.Plan.planListOsebaDel(aDatum, anOld^.DDMI, aOseba);
      dispose (anOld);
      DirtyFlagSet(rIndx, cIndx, 'D');
   end;
end;


procedure tRazpored.MtxElementSet (rIndx, cIndx: integer; aElem: pRazpElem);
var
   aDatum: TDate;
   aOseba: TOseba;
begin
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   if (rIndx >= fStevOseb) or (rIndx < 0) then
      raise Exception.Create('Neveljaven indeks osebe! Indx=' + IntToStr(rIndx));

   MtxElementDel(rIndx, cIndx);
   mtxRazp[rIndx, cIndx]:= aElem;

   DirtyFlagSet(rIndx, cIndx, 'I');

   aDatum:= fDateFrom + cIndx;
   aOseba := aElem^.Oseba;

   if (aOseba = nil) then
      raise Exception.Create('MtxElementSet: Neznana oseba! Indx=' + IntToStr(rIndx));

   aOseba.RefreshAllCriteria(aDatum, aElem^.DDMI, 1);
   fSolver.Plan.planListOsebaAdd(aDatum, aElem^.DDMI, aOseba);
end;

procedure tRazpored.SwapDDMIByIndx (srcRi, srcCi, trgRi, trgCi: integer);
var
   srcRec, trgRec: pRazpElem;
   tmpDDMI: pDDMIElem;
   oldOseba, newOseba: tOseba;
   aDatum: tDate;
begin
   if ((srcRi >= fStevOseb) or (srcRi < 0))  then
      raise Exception.Create('Izvor: Nepravilen index osebe!');

   if ((srcCi >= fDayCount) or (srcCi < 0)) then
      raise Exception.Create('Izvor: Nepravilen index dneva!');

   if ((trgRi >= fStevOseb) or (trgRi < 0))  then
      raise Exception.Create('Ponor: Nepravilen index osebe!');

   if ((trgCi >= fDayCount) or (trgCi < 0)) then
      raise Exception.Create('Izvor: Nepravilen index dneva!');

   srcRec := GetRazporedElement(srcRi, srcCi);
   trgRec := GetRazporedElement(trgRi, trgCi);

   if srcRec = nil then
      Exception.Create('Zamenjava DDMIjev oseb: izvor je prazen!');

   aDatum := fDateFrom + srcCi;

   if (trgRec = nil) then begin
      // ciljni record ne obstaja, prazna celica.
      // Element razporeda ohrani, zamenjaj samo kazalec na osebo
      // Izvorni record postavi na nil, ciljnega postavi na sprememnjeni src Record

      // stari osebi odštej kriterijske vrednosti
      oldOseba := srcRec^.Oseba;
      oldOseba.RefreshAllCriteria(srcRec^.in_date, srcRec^.DDMI, 0);
      // staro osebo odstrani iz seznama oseb DDMI - plan
      fSolver.Plan.planListOsebaDel(aDatum, srcRec^.DDMI, oldOseba);

      // poišèi novo osebo
      newOseba := tOseba(globSolver.Osebe.Items [trgRi]);
      srcRec^.Oseba := newOseba;
      mtxRazp[trgRi, trgCi] := srcRec;
      mtxRazp[srcRi, srcCi] := nil;

      // novi osebi prištej kriterije
      newOseba.RefreshAllCriteria(srcRec^.in_date, srcRec^.DDMI, 1);
      // novo osebo dodaj na sznam DDMI - plan
      fSolver.Plan.planListOsebaAdd(aDatum, srcRec^.DDMI, newOseba);

      // nastavi dirty flage
      fSolver.Razpored.DirtyFlagSet(trgRi, trgCi, 'I');
      fSolver.Razpored.DirtyFlagSet(srcRi, srcCi, 'D');
   end else begin
      // ciljni record obstaja. Kompatibilnost je zagotovljena.
      // Osebam samo zamenjamo DDMIje med seboj. Pred zamenjavo obem osebam odštej
      // vrednosti kriterijev DDMIjev
      srcRec^.Oseba.RefreshAllCriteria(srcRec^.in_date, srcRec^.DDMI, 0 );
      trgRec^.Oseba.RefreshAllCriteria(trgRec^.in_date, trgRec^.DDMI, 0 );

      // Obe osebi najprej zbriši iz povezave oseb na planu DDMIjev
      fSolver.Plan.planListOsebaDel(aDatum, srcRec^.DDMI, srcRec^.Oseba);
      fSolver.Plan.planListOsebaDel(aDatum, trgRec^.DDMI, trgRec^.Oseba);

      // zamenjajmo DDMIja
      tmpDDMI := srcRec^.DDMI;
      srcRec^.DDMI := trgRec^.DDMI;
      trgRec^.DDMI:=tmpDDMI;

      // Po zamenjavi prištej vrednosti kriterijev
      srcRec^.Oseba.RefreshAllCriteria(srcRec^.in_date, srcRec^.DDMI, 1 );
      trgRec^.Oseba.RefreshAllCriteria(trgRec^.in_date, trgRec^.DDMI, 1 );

      // Obe osebi sta zamenjani, dodajaj ju na planu DDMIjev
      fSolver.Plan.planListOsebaAdd(aDatum, srcRec^.DDMI, srcRec^.Oseba);
      fSolver.Plan.planListOsebaAdd(aDatum, trgRec^.DDMI, trgRec^.Oseba);

      // nastavi dirty flage
      fSolver.Razpored.DirtyFlagSet(trgRi, trgCi, 'D');
      fSolver.Razpored.DirtyFlagSet(trgRi, trgCi, 'I');
      fSolver.Razpored.DirtyFlagSet(srcRi, srcCi, 'D');
      fSolver.Razpored.DirtyFlagSet(srcRi, srcCi, 'I');
   end;
end;

procedure tRazpored.Clear;
begin
   MatrixClean;
   fDateFrom := 0;
   fDateTo := 0;
   fDayCount := 0;
   fStevOseb := 0;
end;

function TRazpored.GetRazporedElement(osIndx, dayIndx: integer):pRazpElem;
begin
   if osIndx >= fStevOseb then
      raise Exception.Create('Nepravilen index osebe!');

   if dayIndx >= fDayCount then
      raise Exception.Create('Nepravilen index dneva!');

   Result := pRazpElem(mtxRazp[osIndx, dayIndx]);
end;

procedure tRazpored.LoadResultsFromFile(aFileName: string;  aOwner: integer);
var
   r_ndx, c_ndx: integer;
   aDDMINr: integer;
   aDMIResult: TDMIValsOut;

   procedure impArsFile(aFileName: string; var aResult: TDMIValsOut);
   var
      arsFile: file of TDMIValsOut;
   begin
      assign (arsFile, aFileName);
      reset(arsFile);
      read(arsFile, aResult) ;
      close (arsFile);
   end;


begin
   if globSolver.Razpored.fDayCount > MxDnevi then
      raise Exception.Create('Preveliko število dni na izvoru!');

   if globSolver.Razpored.fStevOseb > MxOseb then
      raise Exception.Create('Preveliko število oseb na izvoru!');

   impArsFile(aFileName, aDMIResult);

   // prepiši vrednosti v razpored
   for r_ndx := 0 to globSolver.Razpored.fStevOseb-1 do begin
      for c_ndx := 0 to globSolver.Razpored.fDayCount-1 do begin
         aDDMINr := aDMIResult [c_ndx+1, r_ndx+1];
         SetDDMI(r_ndx, c_ndx, aDDMINr, '', Now, aOwner);
      end;
   end;
end;

procedure tRazpored.LoadResultsFromStructure(aResult: TDMIValsOut; aOwner: integer);
var
   r_ndx, c_ndx: integer;
   aDDMINr: integer;
begin
   // prepiši vrednosti v razpored
   for r_ndx := 0 to globSolver.Razpored.fStevOseb-1 do begin
      for c_ndx := 0 to globSolver.Razpored.fDayCount-1 do begin
         aDDMINr := aResult [c_ndx+1, r_ndx+1];
         SetDDMI(r_ndx, c_ndx, aDDMINr,
                 dmOracle.oraSession.LogonUsername,
                 Now, aOwner);
      end;
   end;
end;


procedure tRazpored.SaveDneviToFile (aFileName: string);
var
   fOut: TextFile;
   i: integer;
   aDatum: TDateTime;

begin
   AssignFile(fOut, aFileName);
   Rewrite (fOut);

   try
      // Zapiši število dnevov
      writeln (fOut, fDayCount);

      for i := 0 to fDayCount - 1 do begin
         // sprehod skozi vse dneve
         aDatum := FirstDay + i;
         if dmOracle.isPraznik(aDatum) then
            writeln (fOut, '0')
         else
            writeln (fOut, DayOfTheWeek(aDatum));
      end;
   finally
      CloseFile(fOut);
   end;
end;

procedure tRazpored.SaveToFile (aFileName: string);
var
   fOut: TextFile;
   i, j: integer;
   aDatum: TDateTime;
   aElem: pRazpElem;
   aOseba: tOseba;
   aDDMI: pDDMIElem;

   procedure Separator;
   begin
      writeln (fOut, '=====================================');
   end;

begin
   AssignFile(fOut, aFileName);
   Rewrite (fOut);

   try
      // sprehod skozi vse dneve plana
      for i := 0 to fDayCount - 1 do begin
         // Line separator
         Separator;
         aDatum := FirstDay + i;
         writeln (fOut, FormatDateTime('d, dd.mm.yyyy', aDatum));
         Separator;
         for j := 0 to fStevOseb - 1 do begin
            aElem := mtxRazp[j,i];
            if (aElem <> nil) then begin
               aOseba := aElem.Oseba;
               if (aOseba <> nil) then begin
                  write (fOut, IntToStr(aOseba.MNR) + ' ' +
                               aOseba.Lname + ' ' + aOseba.Fname);
               end;

               if aElem.recType = rtRazp then begin
                  aDDMI := aElem.DDMI;
                  if (aDDMI <> nil) then begin
                     write(fOut, ' ==>> DDMI_NR=', aDDMI^.ddmi_nr, ', ', aDDMI^.depa);
                     write(fOut, ', ', aDDMI^.dem_sifra);
                     write(fOut, ', ', aDDMI^.shift_arm);

                  end;
               end;

               if aElem.recType = rtOdsot then begin
                  aDDMI := aElem.DDMI;
                  write(fOut, ' ODSOTNOST ==>> DDMI_NR=',
                              aDDMI^.ddmi_nr, ', ',
                              aElem.vp_id, ', ',
                              aElem.vp_desc);
               end;

               writeln(fOut);

            end;
         end;

      end;
   finally
      CloseFile(fOut);
   end;
end;

procedure tRazpored.MatrixInit;
begin
   SetLength(mtxRazp, fStevOseb, fDayCount);
   SetLength(mtxLog, fStevOseb, fDayCount);
end;

procedure tRazpored.DirtyFlagsClean;
var
   i, j: integer;
begin
   for i:= 0 to fStevOseb-1 do begin
      for j:= 0 to fDayCount-1 do begin
         mtxLog[i,j] := chr(0);
      end;
   end;
end;

procedure tRazpored.DirtyFlagSet (rIndx, cIndx: integer;
                                  aFlag: char);
begin
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   if (rIndx >= fStevOseb) or (rIndx < 0) then
      raise Exception.Create('Neveljaven indeks osebe! Indx=' + IntToStr(rIndx));

   // stari flag ne obstaja, takrat mrtvohladno postavimo
   if (mtxLog[rIndx, cIndx] = chr(0)) then begin
      mtxLog[rIndx, cIndx] := aFlag;
      exit;
   end;

   // stri flag že obstaja, tukaj pazi prehode med stanji

   // napram originalnemu zapisu smo že bili pobrisani
   if mtxLog[rIndx, cIndx] = 'D' then begin
      case aFlag of
         // po brisanju starega smo naredili insert novega, to je update
         'I': mtxLog[rIndx, cIndx] := 'U';
      else
         // 0, D = ni spremembe
      end;
      exit;
   end;

   // napram originalnemu zapisu smo bili insertani
   if mtxLog[rIndx, cIndx] = 'I' then begin
      case aFlag of
         // po insertu novega smo pobrisali zapis, kar pomeni stanje 0
         'D': mtxLog[rIndx, cIndx] := chr(0);
      else
         // 0, I ni spremembe
      end;
   end;

   // napram originalnemu zapisu smo bili updatani
   if mtxLog[rIndx, cIndx] = 'U' then begin
      case aFlag of
         // po updatu smo zapis pobrisali, kar pomeni stanje D
         'D': mtxLog[rIndx, cIndx] := 'D';
      else
         // 0, U ni spremembe
      end;
   end;
end;

function tRazpored.DirtyFlagGet (rIndx, cIndx: integer): char;
begin
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   if (rIndx >= fStevOseb) or (rIndx < 0) then
      raise Exception.Create('Neveljaven indeks osebe! Indx=' + IntToStr(rIndx));

   Result := mtxLog[rIndx, cIndx];
end;

function tRazpored.IsDirty: boolean;
var
   i, j: integer;
begin
   for i:= 0 to fStevOseb-1 do begin
      for j:= 0 to fDayCount-1 do begin
         if mtxLog[i,j] <> chr(0) then begin
            Result := true;
            exit;
         end;
      end;
   end;

   Result := false;

end;


procedure tRazpored.MatrixClean;
var
   i, j: integer;
begin
   for i:= 0 to fStevOseb-1 do begin
      for j:= 0 to fDayCount-1 do begin
         MtxElementDel(i,j);
      end;
   end;
end;


procedure tRazpored.MatrixDestroy;
begin
   MatrixClean;
   SetLength(mtxRazp, 0, 0);
   SetLength(mtxLog, 0, 0);
end;


//---------------------------------------------------------------------------
//
// tAvailability - implementation part
//
//---------------------------------------------------------------------------

constructor tAvailability.Create(aSolver: tSolver);
begin
   inherited Create;
   fDayCount := 0;
   fStevOseb := 0;
   fSolver := aSolver;
end;

destructor tAvailability.Destroy;
begin
   MatrixDestroy;
   inherited Destroy;
end;

procedure tAvailability.Init (nOseb: integer; odDneva, doDneva: TDate);
begin
   MatrixDestroy;
   fDayCount := DaysBetween (odDneva, DoDneva) + 1;
   fStevOseb := nOseb;
   fDateFrom := odDneva;
   fDateTo := doDneva;
   MatrixCreate;
end;

procedure tAvailability.Clear;
var
   i, j: integer;
   aList: TList;
begin
   for i:= 0 to fStevOseb-1 do begin
      for j:= 0 to fDayCount-1 do begin
         aList := mtxAvail[i,j];
         if (aList <> nil) then begin
            aList.Clear;
         end;
      end;
   end;
   fDayCount := 0;
   fDateFrom := 0;
   fDateTo := 0;
end;


// Kreiranje matrike s seznamom DDMIjev za osebe.
// matrika je 2D - za vsako osebo za vsak dan en seznam DDMIjev
procedure tAvailability.MatrixCreate;
var i,j: integer;
    aList: TList;
begin
   // nastavi velikost matrike
   SetLength(mtxAvail, fStevOseb, fDayCount);

   // kreiraj vse sezname
   for i:= 0 to fStevOseb - 1 do begin
      for j:= 0 to fDayCount - 1 do begin
         aList := TList.Create;
         mtxAvail[i,j]:= aList;
      end;
   end;
end;

// Unièenje - sprostitev pomnilnika 2D matrike razpoložljivosti.
// najprej pobriše vsebino seznamov, nato unièi sezname, nato unièi matriko
procedure tAvailability.MatrixDestroy;
   procedure MatrixCleanAndDestroyLists;
   var
      i, j: integer;
      aList: TList;
   begin
      for i:= 0 to fStevOseb-1 do begin
         for j:= 0 to fDayCount-1 do begin
            aList := mtxAvail[i,j];
            if (aList <> nil) then begin
               aList.Clear;
               aList.Destroy;
               mtxAvail[i,j] := nil;
            end;
         end;
      end;
   end;

begin
   MatrixCleanAndDestroyLists;
   SetLength(mtxAvail, 0, 0);
end;


// dodajanje DDMIja osebi aMNR na dan aDatum
procedure tAvailability.AddDDMI (aMNR: integer;
                                 aDatum: TDate;
                                 aDepart_id: variant;
                                 aDem_id: variant;
                                 aShift_id: variant);
var
   rIndx, cIndx: integer;
   aOseba: tOseba;
   aDDMI: pDDMIElem;
   txt1, aMsg: string;
begin
   if (aDatum < fDateFrom) or (aDatum > fDateTo) then
      raise Exception.Create('Razpoložljivost lahko vsebuje samo datume med '
                              + dateToStr(fDateFrom) + ' in ' + dateToStr(fDateTo));

   cIndx := DaysBetween(fDateFrom, aDatum);
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   // Poišèi osebo iz seznama oseb
   aOseba := fSolver.OsebeListFind(aMNR);
   if aOseba = nil then
      raise Exception.Create('Ne najdem osebe! MNR=' + IntToStr(aMNR));

   // poiši vrstico osebe, kjer se nahaja njen DDMI list
   rIndx := aOseba.fNdx_nr;

   // poišèi DDMi iz seznama DDMIjev
   aDDMI := fSolver.DDMIListFind(aDepart_id, aDem_id, aShift_id);

   if aDDMI = nil then begin
      // nisem našel DDMI na seznamu, poišèi po vseh DDMIjih v bazi in dodaj v seznam
      aDDMI := dmOracle.LocateAndCreateDDMIElem(aDepart_id, aDem_id, aShift_id);

      // èe si ga našel, ga dodaj
      if aDDMI <> nil then
         fSolver.DDMIListAdd(aDDMI);

      // in še enkrat poišèi
      aDDMI := fSolver.DDMIListFind(aDepart_id, aDem_id, aShift_id);

      if (aDDMI = nil) then begin
         // èe ga nisi našel je pa res problem
         txt1 := FormatDateTime('dd.mm.yyyy', aDatum);
         aMsg := Format(C_EXCEPT_MSG_NO_DDMI_RAZP, [aMNR, txt1, aDepart_id, aDem_id, aShift_id]);
         raise Exception.Create(aMsg);
      end;
   end;

   if not ContainsDDMIByIndex(rIndx, cIndx, aDDMI^.ddmi_nr) then
      // dodaj najdeni DDMI na seznam osebe na doloèeni dan samo, èe ga še nima
      mtxAvail[rIndx, cIndx].Add(aDDMI);
end;

function tAvailability.ContainsDDMI (aMNR: integer;
                                     aDatum: TDate;
                                     aDDMINr: integer): boolean;
var
   i, rIndx, cIndx: integer;
   aOseba: tOseba;
   aDDMIList: TList;
   aDDMI: pDDMIElem;
begin
   cIndx := DaysBetween(fDateFrom, aDatum);
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   // Poišèi osebo iz seznama oseb
   aOseba := fSolver.OsebeListFind(aMNR);
   if aOseba = nil then
      raise Exception.Create('Ne najdem osebe! MNR=' + IntToStr(aMNR));

   // poiši vrstico osebe, kjer se nahaja njen DDMI list
   rIndx := aOseba.fNdx_nr;

   // poišèi DDMi iz seznama DDMIjev
   aDDMIList := mtxAvail[rIndx, cIndx];
   for i:= 0 to aDDMIList.Count -1 do begin
      aDDMI := aDDMIList.Items[i];
      if aDDMI^.ddmi_nr = aDDMINr then begin
         Result:= true;
         exit;
      end;
   end;

   Result := false;
end;

function tAvailability.ContainsDDMIByIndex (rIndx, cIndx: integer; aDDMINr: integer): boolean;
var
   i: integer;
   aDDMIList: TList;
   aDDMI: pDDMIElem;
begin
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   if (rIndx >= fStevOseb) or (rIndx < 0) then
      raise Exception.Create('Neveljaven indeks osebe! Indx=' + IntToStr(rIndx));

   // poišèi DDMi iz seznama DDMIjev
   aDDMIList := mtxAvail[rIndx, cIndx];
   for i:= 0 to aDDMIList.Count -1 do begin
      aDDMI := aDDMIList.Items[i];
      if aDDMI^.ddmi_nr = aDDMINr then begin
         Result:= true;
         exit;
      end;
   end;

   Result := false;
end;

function tAvailability.GetListForOsebaDay(osebaIndx, dayIndx: integer): TList;
begin
   if (dayIndx >= fDayCount) or (dayIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(dayIndx));

   if (osebaIndx >= fStevOseb) or (osebaIndx < 0) then
      raise Exception.Create('Neveljaven indeks osebe! Indx=' + IntToStr(osebaIndx));

   // Vrni Listo DDMIjev
   Result := mtxAvail[osebaIndx, dayIndx];
end;

function tAvailability.GetListForOsebaDayByMNR(aMNR: integer; aDay: tDate): TList;
var
   aOseba: tOseba;
   dayIndx: integer;
   rIndx: integer;

begin
   if (aDay > fDateTo) or (aDay < fDateFrom) then
      raise Exception.Create('Neveljaven datum!');

   dayIndx := DaysBetween(fDateFrom, aDay);

   aOseba := globSolver.OsebeListFind(aMNR);
   if aOseba = nil then
      raise Exception.Create('Ne najdem osebe!');

   rIndx := aOseba.fNdx_nr;

   // Vrni Listo DDMIjev
   Result := mtxAvail[rIndx, dayIndx];
end;

function tAvailability.GetStevRazpOsebForDay(aDay: tDate): integer;
var
   dayIndx: integer;
   ttlOseb: integer;
   rIndx: integer;
   aList: tList;
begin
   if (aDay > fDateTo) or (aDay < fDateFrom) then
      raise Exception.Create('Neveljaven datum!');

   // izraèunaj si datumski index
   dayIndx := DaysBetween(fDateFrom, aDay);

   // sprehodi se skozi vse osebe in za vsako preglej razpoložljivost.
   // Èe ima oseba vsaj 1 razpoložljivost, je oseba na voljo
   ttlOseb := 0;
   for rIndx := 0 to fStevOseb - 1 do begin
      aList := GetListForOsebaDay(rIndx, dayIndx);
      if aList <> nil then begin
         if aList.Count > 0 then
            ttlOseb := ttlOseb + 1;
      end;
   end;

   Result := ttlOseb;
end;


// vrne teoretièno najveèje število oseb za dani DDMi na dan aDatum
function tAvailability.GetStevOsebForDDMI(aDatum: TDate; aDDMINr: integer): integer;
var oIndx, cIndx: integer;
   aNum: integer;
   pRazp: pRazpElem;
begin
   cIndx := DaysBetween(fDateFrom, aDatum);
   if (cIndx >= fDayCount) or (cIndx < 0) then
      raise Exception.Create('Neveljaven indeks datuma! Indx=' + IntToStr(cIndx));

   aNum := 0; // skupno teoretièno število oseb, ki so na dan cIndx na voljo za aDdmiNr

   for oIndx := 0 to  fStevOseb - 1 do begin
      // poglejmo èe obstaja razpored za Osebo oIndx na dan cIndx
      pRazp := fSolver.Razpored.mtxRazp[oIndx, cIndx];
      if (pRazp <> nil) then begin
         // da, razpored obstaja
         if (pRazp^.recType = rtOdsot) then begin
            // oseba je odsotna, torej ni na voljo!
         end else begin
            // oseba je pribita, poglejmo èe na željeni DDMI
            if (pRazp^.DDMI^.ddmi_nr = aDDMINr) then
               aNum := aNum + 1;
         end
      end else begin
         // ne obstaja razpored, torej preverimo èe oseba lahko dela DDMI
         if ContainsDDMIByIndex (oIndx, cIndx, aDDMINr) then
            aNum := aNum + 1;
      end;
   end;

   Result := aNum;
end;

procedure tAvailability.SaveToFile (aFileName: string);
var i, j, k: integer;
    fOut: TextFile;
    aDDMIList: TList;
    pDDMI: pDDMIElem;
    pRazp: pRazpElem;
    doSkipDDMI: boolean;

begin
   AssignFile(fOut, aFileName);
   Rewrite (fOut);

   try
      // zapiši število dni
      writeln (fOut, IntToStr(fDayCount));

      // sprehod skozi vse dneve plana
      for i := 0 to fDayCount - 1 do begin
         // zapiši index dneva
         writeln (fOut, i+1);

         // zapiši koliko oseb imaš na dan i
         writeln (fOut, IntToStr (fStevOseb));

         // sprehod skozi vse osebe na dan i
         for j := 0 to fStevOseb - 1 do begin
            doSkipDDMI := false;
            // zapiši index osebe
            write(fOut, j+1, ' ');

            // poglejmo èe obstaja razpored
            pRazp := fSolver.Razpored.mtxRazp[j,i];
            if (pRazp <> nil) then begin
               // da, razpored obstaja
               if (pRazp^.recType = rtOdsot) then begin
                  // obstaja razpored tipa odsotnost!
                  if ((pRazp^.vp_id='PRO') or (pRazp^.DDMI^.need_hhmm = 0)) then begin
                     // gre za odsotnost brez obveze, oseba je lahko prosta
                     writeln (fOut, '1 0');
                  end else begin
                     // zapiši da je oseba pribita na DDMI odsotnosti
                     writeln (fOut, '1 ', pRazp^.DDMI^.ddmi_nr );
                  end;
                  doSkipDDMI := true;
               end;

               if (pRazp^.recType = rtRazp) then begin
                  // obstaja fiksiran razpored!
                  // zapiši da je oseba pribita na DDMI odsotnosti
                  writeln (fOut, '1 ', pRazp^.DDMI^.ddmi_nr );
                  doSkipDDMI := true;
               end;
            end;

            if not doSkipDDMI then begin
               // ne, razpored ne obstaja
               // vzemi seznam DDMIjev za osebo j na dan i
               aDDMIList := mtxAvail[j,i].Expand;

               if (aDDMIList <> nil) then begin
                  // zapiši število ddmijev, ki je vedno +1 saj je oseba lahko tudi prosta
                  write (fOut, aDDMIList.Count+1, ' 0');
                  // sprehod skozi seznam ddmijev osebe
                  for k := 0 to aDDMIList.Count-1 do begin
                     pDDMI := aDDMIList.Items[k];
                     write (fOut, ' ', pDDMI^.ddmi_nr);
                  end;

                  writeln(fOut);
               end;
            end;
         end;
       end;

    finally
       CloseFile(fOut);
    end;
end;

//---------------------------------------------------------------------------
//
// tCriteria - implementation part
//
//---------------------------------------------------------------------------

constructor tCriteria.Create(aKind: tCriteriaType; aName: string);
begin
   inherited Create;
   fName := aName;
   fKind := aKind;
end;



destructor tCriteria.Destroy;
begin
end;

procedure tCriteria.Init(nStartHours: integer; nStartDays: integer; aDate: TDate);
begin
   fStartHours := nStartHours;
   fSumHours := 0;
   fEndHours := nStartHours;

   fStartDays := nStartDays;
   fSumDays := 0;
   fEndDays := nStartDays;

   fLastOccur := aDate;
end;

procedure tCriteria.InfluenceStartValues(startHours, startDays: integer);
begin
   // najprej razveljavi vpliv starih zaèetnih vrednosti
   fEndHours := fEndHours - fStartHours;
   fEndDays := fEndDays - fStartDays;

   // uveljavi vpliv novih zaèetnih vrednosti
   fStartHours := startHours;
   fEndHours := fEndHours + fStartHours;
   fStartDays := startDays;
   fEndDays := fEndDays + fStartDays;
end;

procedure tCriteria.InfluenceDDMIAdd(aDate: TDate; aDDMI: pDDMIElem);
begin
   if aDDMI = nil then
      exit;

   if (aDate < globSolver.Razpored.fDateFrom) or (aDate > globSolver.Razpored.fDateTo) then
      Raise Exception.Create('Neveljaven datum razporeda! Datum=' + DateToStr(aDate));

   case fKind of
      ctSunHoly: begin
         // Tako najlaže ugotovim da gre za odsotnost. Ta ne vpliva na naš DDMI
         if aDDMI^.shift_no = C_ODS_SHIFT_NO then
            exit;

         if ((DayOfTheWeek(aDate) = 7) or (dmOracle.isPraznik(aDate))) then begin
            fSumHours := fSumHours + HHMM_To_Minutes(aDDMI^.need_hhmm);
            fEndHours := fEndHours + HHMM_To_Minutes(aDDMI^.need_hhmm);

            fSumDays := fSumDays + 1;
            fEndDays := fEndDays + 1;

            if aDate > fLastOccur then
               fLastOccur := aDate;
         end;
       end;
      ctNightShift: begin
         // Tako najlaže ugotovim da gre za odsotnost. Ta ne vpliva na naš DDMI
         if aDDMI^.shift_no = C_ODS_SHIFT_NO then
            exit;

         // oznaka turnusa je 3 izmena, kar je noèna
         if aDDMI^.shift_no = C_NIGHTSHIFT_SHIFT_NO then begin
            fSumHours := fSumHours + HHMM_To_Minutes(aDDMI^.need_hhmm);
            fEndHours := fEndHours + HHMM_To_Minutes(aDDMI^.need_hhmm);

            fSumDays := fSumDays + 1;
            fEndDays := fEndDays + 1;

            if aDate > fLastOccur then
               fLastOccur := aDate;
         end;
      end;

   else
      fSumHours := fSumHours + HHMM_To_Minutes(aDDMI^.need_hhmm);
      fEndHours := fEndHours + HHMM_To_Minutes(aDDMI^.need_hhmm);

      fSumDays := fSumDays + 1;
      fEndDays := fEndDays + 1;

      if aDate > fLastOccur then
         fLastOccur := aDate;
   end;
end;


procedure tCriteria.InfluenceDDMIRemove(aDate: TDate; aDDMI: pDDMIElem);
begin
   if aDDMI = nil then
      exit;

   if (aDate < globSolver.Razpored.fDateFrom) or (aDate > globSolver.Razpored.fDateTo) then
      Raise Exception.Create('Neveljaven datum razporeda! Datum=' + DateToStr(aDate));


   case fKind of
      ctSunHoly: begin
         // Tako najlaže ugotovim da gre za odsotnost. Ta ne vpliva na naš DDMI
         if aDDMI^.shift_no = C_ODS_SHIFT_NO then
            exit;

         if ((DayOfTheWeek(aDate) = 7) or (dmOracle.isPraznik(aDate))) then begin
            fSumHours := fSumHours - HHMM_To_Minutes(aDDMI^.need_hhmm);
            fEndHours := fEndHours - HHMM_To_Minutes(aDDMI^.need_hhmm);

            fSumDays := fSumDays - 1;
            fEndDays := fEndDays - 1;

            if aDate > fLastOccur then
               fLastOccur := aDate;
         end;
       end;

       ctNightShift: begin
         // Tako najlaže ugotovim da gre za odsotnost. Ta ne vpliva na naš DDMI
         if aDDMI^.shift_no = C_ODS_SHIFT_NO then
            exit;

         if aDDMI^.shift_no = C_NIGHTSHIFT_SHIFT_NO then begin
            fSumHours := fSumHours - HHMM_To_Minutes(aDDMI^.need_hhmm);
            fEndHours := fEndHours - HHMM_To_Minutes(aDDMI^.need_hhmm);

            fSumDays := fSumDays - 1;
            fEndDays := fEndDays - 1;

            if aDate > fLastOccur then
               fLastOccur := aDate;
         end;
       end;

   else
      fSumHours := fSumHours - HHMM_To_Minutes(aDDMI^.need_hhmm);
      fEndHours := fEndHours - HHMM_To_Minutes(aDDMI^.need_hhmm);

      fSumDays := fSumDays - 1;
      fEndDays := fEndDays - 1;

      if aDate > fLastOccur then
         fLastOccur := aDate;
   end;

   // vsota ur ne more biti manjša kot 0
   if fSumHours < 0 then
      fSumHours := 0;

   // vsota dni ne more biti manjša od 0
   if fSumDays < 0 then
      fSumDays := 0;

   // ne vem kaj storiti s tem
   if aDate <= fLastOccur then
      fLastOccur := aDate;

end;

end.
