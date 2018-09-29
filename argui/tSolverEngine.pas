unit tSolverEngine;
// JAKL, ta razred je podoben kot JaklArSOLV, razen da so dostranjene procedure
//    procedure settings ; override ;
//    procedure shMsgOsebe(o: smallint ) ; override ;
//    function steviloKrsitevKrit: integer ; // dodatno za izracun stevila krsitev krit.
// Dodano pa je tudi (kot komentar) Konstante in tipi, ki so tudi pomembni zunaj TRazSolve

// ****************************************************************** //
{// ***** Konstante in tipi, ki so tudi pomembni zunaj TRazSolve ***** //
const
  MxOseb = 250 ;  	        // Max. st. razlicnih Oseb
  MxDMI = 250 ;                 // Max. st. razlicnih Del.mest/Izmen <= MxDM * MxIz
  MxVrstVzorcev = 4 ; 	        // Max. st. Vzorcev; vzorec 4(=MxVrstVzorcev) pomeni bolnisko
  MxDnevi = 35 ; 	        // Max. st. mesecnih dni, oz. dni za katere sestavljamo razpored

  MxDelPlanDMI = 40 ;	        // Max. st. razlicnih DMIjev nekega dne v delovnem planu
  MxOsebNaDMI = 80 ;            // Max. st. oseb, ki lahko delajo na nekem DMI nekega dne

// Bolniske in dopusti:
// so poljuben dmi, ki ima vrsto vzorca (v DMIList) enako MxVrstVzorcev
// imajo lahko poljuben zacetek, in cas trajanja.
// Oseba, ki ima bolnisko/dopust mora biti pribita na ta dmi.
// Dejansko vse dmi-je z vrstoVzorca=MxVrstVzorcev sam rocno vstavim v delovni plan DP, in naredim
// razpored, kot da gre za obicajen dmi.
// Od 12.3.2007 dalje: Bolniske in dopusti se upostevajo le v kritieriju PUrMesecMx. Ostalih
// kriterijev bolniska ali dopust ne spreminja!

// Pri koncnem izpisu upostevam tudi zacetne vrednosti kriterijev. Prenosov pri koncnem izpisu NE upostevam.
// Prenosi tudi NE vplivajo na izracun kriterijev. Tako ima lahko oseba napr. 300 ur prenosa
// iz prejsnjega meseca, pa kljub temu lahko naredimo razpored, ki ne krsi nobenega kriterija.
// Ce zelis, da prenos vpliva tudi na izracun kriterijev, moras na vrednost prenost nastaviti
// zacetno vrednost kriterija PUrMesecMx (tretji stolpec ustrezne osebe).
// Na ta nacin imas dejansko dve vrsti prenosov: 1) taki prenosi ur, ki vplivajo le na preferencni
// kriterij - za enakomernost razporeda, in 2) prenosi ur, ki vpivajo tudi na kriterije.

type
  TDMI = 0..MxDMI ;                             // DMI=0 za virtualni (prosti) DMI
  TDMISet = set of TDMI ;
  TDanIdx = 1..MxDnevi ;
  TOsebaIdx = 1..MxOseb ;
  TOsebaIdx0 = 0..MxOseb ;
  TVrstaVzorca = 0..MxVrstVzorcev ;  		// mozne grupe izmen v vzorcu (vdop, vpop, vnoc, vpr) ;
  TKritVal = smallint ;                         // vrednost kriterija
  TTipDneva = (pra=0,pon=1,tor,sre,cet,pet,sob=6,ned=7) ;
  TDMIOseb = array[1..MxDnevi, 1..MxOseb] of TDMISet ;

  TDelPlanDan = record
    nDMI: 0..MxDelPlanDMI ;
    DPDMIList: array[1..MxDelPlanDMI] of TDMI ;	// DMIji tega dne
    nOsebList: array[1..MxDelPlanDMI] of shortint;// st.oseb. ki delajo na ustreznem DMIju
    tipDne: TTipDneva ;
  end ;

  TDMIListEl = record
    vz: TVrstaVzorca ;   // vzorec DMIja
    zac, ur: smallint ;  // zacetek in stevilo del. ur DMIja
  end ;
  TDMIList = array[0..MxDMI] of TDMIListEl ;

  TTipKriterija =
    (PDanPocitek=1,  // min. pocitek med zap. del. dnevoma
     PZapUrTedenMx=2,
     PUrMesecMx=3,
     PDniNPMesecMx=4,
     PVkdMesecMx=5,  // max. st. delovnih vikendo mesecno
     PZapDniTedenMx=6) ;

  TRazBaseProblem = class
  // JAKL, to so samo uporabne zadeve iz tega razreda
  public
    nDni: TDanIdx ;
    nOseb: TOsebaIdx ;
    prviDanMeseca: TTipDneva ;
    nDMI: TDMI ;

    DP: array[TDanIdx] of TDelPlanDan ;
    DMIList: TDMIList ;
    PrenosMin: array[TOsebaIdx] of smallint ; // prenosi minut iz prejsnjega meseca; neg.vr.pomeni primanjkjaj
    DMIOseb: ^TDMIOseb ;
    startKrit: array[TOsebaIdx,TTipKriterija] of TKritVal ;  // vnos v formatu 2030
  end ;  // TRazBaseProblem


  TKriterijDesc = record
    enabled: boolean ;
    limit: TKritVal ;     // min. oz. max. vrednost (odvisno od tipa)
    dmiIgnore: boolean ;  // JAKL, dmiIgnore PUSTIS PRI MIRU; true ce je update kriterija neodvisen od dmi-ja
  end ;

  TKritValList = array[TTipKriterija] of TKritVal ;

  TRazKriteriji = class(TRazBaseProblem)
  // JAKL, to so samo uporabne zadeve iz tega razreda
  public
    krit: array[TTipKriterija] of TKriterijDesc ; // limite kriterijev
    DOVOLIGotovoKrsKRIT: boolean ;
    // ce false potem javljanje napake 5 z MsgHalt kadar
    // dolocena oseba, dolocenega dneva (za katerikoli DMI) zagotovo krsi kriterije
    BRISIDMIkiKrsKRIT: boolean ;
    // Ce BRISIDMIkiKrsKRIT=true potem se vrednosti DMIjev, ki gotovo krsijo kriterije
    // brisejo in se v sestavljanju razporeda ne morejo uporabljati. V primeru, da
    // razpored brez krsenja kriterijev obstaja, ga bomo na ta nacin bolj zagotovo nasli.
    // V primeru da razpored brez krsenja kriterijev ne obstaja, je mozno da z
    // BRISIDMIkiKrsKRIT=false dobimo manj krsitev kriterijev kot z BRISIDMIkiKrsKRIT=true,
    // saj lahko z eno krsitvijo odpravimo napr. dve drugi krsitve.
    // UPORABA: najprej poskusi poiskati razpored z DOVOLIGotovoKrsKRIT=false in
    // BRISIDMIkiKrsKRIT=true. Ce razpored ne obstaja bodisi popravi v ArGUI, bodisi
    // postavi DOVOLIGotovoKrsKRIT na true ali BRISIDMIkiKrsKRIT na false, odvisno od
    // tega kaj zelis.
  end ;  // TKriteriji
}// *** KONEC Konstante in tipi, ki so tudi pomembni zunaj TRazSolve *** //
// ******************************************************************** //

interface

uses SysUtils, RazProbemBase, RazMain, Solver, dmOra, Classes;

type
   // TPlanScope - katere dneve plana vkljuèiš v reševanje.
   // psFull = razrešuješ kompleten plan
   // psSunHoly = razrešuješ samo nedelje in praznike.
   // psDDMIList = razrešuješ samo DDMIje, ki so v seznamu
   TPlanScope = (psFull, psSunHoly, psDDMIList);

   // naæin sortiranja oseb preferenènega kriterija
   TSortType = (stUre, stDnevi);

   TDebugMode = (dmNone, dmNormal, dmFull);

   // Exceptioni, ki se prozijo v MsgHalt
   EFatalError = class(Exception);

   EGotovoKrsenje = class(Exception);

   ENiResitve = class(Exception)
      public
         Datum: TDateTime;
         DayIndex: integer;
   end;

   // glavni razred za dostop do solverja
   TSolvInterface = class(TRazSolve)

   private
      fPlanScope: tPlanScope;
      fDebugMode: tDebugMode;
      fDDMIToSolve: TList;

      function getSortType: tSortType;
      procedure setSortType(aSortType: tSortType);

      function GetKritMinDnevniPocitek: integer;
      procedure SetKritMinDnevniPocitek(aDnevniPocitek: integer);
      function GetKritMinDnevniPocitekEnabled: boolean;
      procedure SetKritMinDnevniPocitekEnabled(aEnabled: boolean);

      function GetKritMaxUr7Dni: integer;
      procedure SetKritMaxUr7Dni(aUre: integer);
      function GetKritMaxUr7DniEnabled: boolean;
      procedure SetKritMaxUr7DniEnabled(aEnabled: boolean);

      function GetKritMaxUrMesec: integer;
      procedure SetKritMaxUrMesec(aUre: integer);
      function GetKritMaxUrMesecEnabled: boolean;
      procedure SetKritMaxUrMesecEnabled(aEnabled: boolean);

      function GetKritMaxZaporedniDD: integer;
      procedure SetKritMaxZaporedniDD(aDnevi: integer);
      function GetKritMaxZaporedniDDEnabled: boolean;
      procedure SetKritMaxZaporedniDDEnabled(aEnabled: boolean);

      function GetKritMaxNP: integer;
      procedure SetKritMaxNP(aDnevi: integer);
      function GetKritMaxNPEnabled: boolean;
      procedure SetKritMaxNPEnabled(aEnabled: boolean);

      function GetKritMaxWee: integer;
      procedure SetKritMaxWee(aStevilo: integer);
      function GetKritMaxWeeEnabled: boolean;
      procedure SetKritMaxWeeEnabled(aEnabled: boolean);

      function isDDMIOnSolveList(aDDMI: pDDMIElem): boolean;

   public
      // Uporabne zadeve:
      // TDMIValsOut = array[TDanIdx, TOsebaIdx] of TDMI ;
      // DMIValsOut: TDMIValsOut  ;
      // Status: smallint ;

      constructor Create;
      destructor Destroy;
      procedure DebugInit(aDebugMode: tDebugMode);

      procedure CheckLimits;

      procedure initDMIinDP ; override ;
      procedure initOsebe ; override ;
      procedure setKrit ; override ;

      procedure DDMITSAdd(aDDMI: pDDMIElem);
      procedure DDMITSClear;

      procedure solveBest ;
      procedure solveStrict ;

      procedure msg(s:string) ; override ;
      procedure error(s:string) ;  override ;
      procedure MsgHalt(s:string; koda, dan, oseba: smallint); override;
      procedure shMsgDan(d: smallint ); override;
   published
      property optKrsenjeKriterijevAllow: boolean read DOVOLIGotovoKrsKRIT write DOVOLIGotovoKrsKRIT default true;
      property optDeleteInvalidDDMI: boolean read BRISIDMIkiKrsKRIT write BRISIDMIkiKrsKRIT default true;
      property optPlanScope: tPlanScope read fPlanScope write fPlanScope default psFull;
      property optSortType: tSortType read GetSortType write SetSortType default stUre;
      property optGroupStevDni: smallint read stDniVSkupini write stDniVSkupini;
      property optGroupMinutes: smallint read stMinVSkupini write stMinVSkupini;
      property optDebugMode: tDebugMode read fDebugMode write fDebugMode default dmNormal;

      property optKritMinDnevniPocitek: integer read GetKritMinDnevniPocitek  write SetKritMinDnevniPocitek default 12;
      property optKritMinDnevniPocitekEnabled:boolean read GetKritMinDnevniPocitekEnabled write SetKritMinDnevniPocitekEnabled default true;

      property optKritMaxUr7Dni: integer read GetKritMaxUr7dni  write SetKritMaxUr7Dni default 56;
      property optKritMaxUr7DniEnabled: boolean read GetKritMaxUr7dniEnabled  write SetKritMaxUr7DniEnabled default true;

      property optKritMaxUrMesec: integer read GetKritMaxUrMesec  write SetKritMaxUrMesec default 186;
      property optKritMaxUrMesecEnabled: boolean read GetKritMaxUrMesecEnabled  write SetKritMaxUrMesecEnabled default true;

      property optKritMaxZaporedniDD: integer read GetKritMaxZaporedniDD  write SetKritMaxZaporedniDD default 6;
      property optKritMaxZaporedniDDEnabled: boolean read GetKritMaxZaporedniDDEnabled  write SetKritMaxZaporedniDDEnabled default true;

      property optKritMaxNP: integer read GetKritMaxNP  write SetKritMaxNP default 3;
      property optKritMaxNPEnabled: boolean read GetKritMaxNPEnabled  write SetKritMaxNPEnabled default true;

      property optKritMaxWee: integer read GetKritMaxWee  write SetKritMaxWee default 3;
      property optKritMaxWeeEnabled: boolean read GetKritMaxWeeEnabled  write SetKritMaxWeeEnabled default true;
  end ;


implementation

uses DateUtils, Dialogs, ResStrings;

// sled izvajanja, zelo koristno!
var LOGFILE: Text ;

constructor TSolvInterface.Create;
begin
   inherited Create ;
   fDDMIToSolve := TList.Create;
end ;

destructor TSolvInterface.Destroy;
begin
   fDDMIToSolve.Destroy;
   try
      msg('Konec sledenja, zapiram datoteko');
      close(LOGFILE);
   except
   end;
   inherited;
end;

procedure TSolvInterface.DebugInit(aDebugMode: tDebugMode);
var aMsg: string;
begin
   fDebugMode := aDebugMode;
   if fDebugMode <> dmNone then begin
      try
         assign(LOGFILE, 'Arsolv.log');
         rewrite(LOGFILE);
         aMsg := 'ARSOLV log datoteka. Debug level =';
         case fDebugMode of
            dmNone: aMsg := aMsg + 'OFF';
            dmNormal: aMsg := aMsg + 'Zgošèeno';
         else
            aMsg := aMsg + 'Podrobno';
         end;

         msg(aMsg);

      except
         // tihi exception
      end;
   end;
end;

procedure TSolvInterface.CheckLimits;
var aMsg: string;
    aDay: string;
    i, j: integer;
    aPlanList: TList;
begin
   if globSolver.DDMIList.Count >= MxDmi then begin
      aMsg := Format (C_EXCEPT_MSG_MAX_DDMI_LIMIT, [MxDmi, globSolver.DDMIList.Count]);
      raise Exception.Create (aMsg);
   end;

   if globSolver.Osebe.Count >= MxOseb then begin
      aMsg := Format (C_EXCEPT_MSG_MAX_OSEB_LIMIT, [MxOseb, globSolver.Osebe.Count]);
      raise Exception.Create (aMsg);
   end;

   for i:=0 to globSolver.Plan.DayCount-1 do begin
      aPlanList := globSolver.Plan.planListGetForDay(i);
      if aPlanList <> nil then begin
         if aPlanList.Count >= MxDelPlanDMI then begin
            aDay := FormatDateTime('dd mmmm yyyy', globSolver.Plan.FirstDay + i);
            aMsg := Format (C_EXCEPT_MSG_MAX_PLAN_DDMI_LIMIT, [aDay, MxDelPlanDMI, aPlanList.Count]);
            raise Exception.Create (aMsg);
         end;

         for j:=0 to aPlanList.Count - 1 do begin
            if pPlanElem(aPlanList.Items[j])^.minOseb >= MxOsebNaDMI then begin
               aDay := FormatDateTime('dd mmmm yyyy', globSolver.Plan.FirstDay + i);
               aMsg := Format (C_EXCEPT_MSG_MAX_PLAN_OSEBE_LIMIT, [aDay,
                                                                   j,
                                                                   MxOsebNaDMI,
                                                                   pPlanElem(aPlanList.Items[j])^.minOseb]);
               raise Exception.Create (aMsg);
            end;
         end;
      end;
   end;
end;

function TSolvInterface.getSortType:tSortType;
begin
   case VrstaSortaOseb of
      1: Result := stDnevi;
   else
      Result := stUre;
   end;
end;

procedure TSolvInterface.setSortType(aSortType: tSortType);
begin
   case aSortType  of
      stDnevi:
         VrstaSortaOseb := 1;
      stUre:
         VrstaSortaOseb := 2;
   end;
end;

// Funkcije za nastavljanje kriterija minimalnega dnevnega poèitka
function TSolvInterface.GetKritMinDnevniPocitek: integer;
begin
   Result := krit[PDanPocitek].limit;
end;

procedure TSolvInterface.SetKritMinDnevniPocitek(aDnevniPocitek: integer);
begin
   krit[PDanPocitek].limit := aDnevniPocitek;
end;

function TSolvInterface.GetKritMinDnevniPocitekEnabled: boolean;
begin
   Result := krit[PDanPocitek].Enabled;
end;

procedure TSolvInterface.SetKritMinDnevniPocitekEnabled(aEnabled: boolean);
begin
   krit[PDanPocitek].Enabled := aEnabled;
end;

// Funkcije za nastavljanje kriterija maksimalnega števila ur poljubnih 7 zaporednih dni
function TSolvInterface.GetKritMaxUr7Dni: integer;
begin
   Result := krit[PZapUrTedenMx].limit;
end;

procedure TSolvInterface.SetKritMaxUr7Dni(aUre: integer);
begin
   krit[PZapUrTedenMx].limit := aUre;
end;

function TSolvInterface.GetKritMaxUr7DniEnabled: boolean;
begin
   Result := krit[PZapUrTedenMx].Enabled;
end;

procedure TSolvInterface.SetKritMaxUr7DniEnabled(aEnabled: boolean);
begin
   krit[PZapUrTedenMx].Enabled := aEnabled;
end;

// Funkcije za nastavljanje kriterija maksimalnega števila ur meseèno
function TSolvInterface.GetKritMaxUrMesec: integer;
begin
   Result := krit[PUrMesecMx].limit;
end;

procedure TSolvInterface.SetKritMaxUrMesec(aUre: integer);
begin
   krit[PUrMesecMx].limit := aUre;
end;

function TSolvInterface.GetKritMaxUrMesecEnabled: boolean;
begin
   Result := krit[PUrMesecMx].Enabled;
end;

procedure TSolvInterface.SetKritMaxUrMesecEnabled(aEnabled: boolean);
begin
   krit[PUrMesecMx].Enabled := aEnabled;
end;

// Funkcije za nastavljanje kriterija maksimalnega števila zaporednih delovnih dni
function TSolvInterface.GetKritMaxZaporedniDD: integer;
begin
   Result := krit[PZapDniTedenMx].limit;
end;

procedure TSolvInterface.SetKritMaxZaporedniDD(aDnevi: integer);
begin
   krit[PZapDniTedenMx].limit := aDnevi;
end;

function TSolvInterface.GetKritMaxZaporedniDDEnabled: boolean;
begin
   Result := krit[PZapDniTedenMx].Enabled;
end;

procedure TSolvInterface.SetKritMaxZaporedniDDEnabled(aEnabled: boolean);
begin
   krit[PZapDniTedenMx].Enabled := aEnabled;
end;

// Funkcije za nastavljanje kriterija maksimalnega števila delovnih nedelj in praznikov
function TSolvInterface.GetKritMaxNP: integer;
begin
   Result := krit[PZapDniTedenMx].limit;
end;

procedure TSolvInterface.SetKritMaxNP(aDnevi: integer);
begin
   krit[PZapDniTedenMx].limit := aDnevi;
end;

function TSolvInterface.GetKritMaxNPEnabled: boolean;
begin
   Result := krit[PZapDniTedenMx].Enabled;
end;

procedure TSolvInterface.SetKritMaxNPEnabled(aEnabled: boolean);
begin
   krit[PZapDniTedenMx].Enabled := aEnabled;
end;

// Funkcije za nastavljanje kriterija maksimalnega števila delovnih vikendov
function TSolvInterface.GetKritMaxWee: integer;
begin
   Result := krit[PVkdMesecMx].limit;
end;

procedure TSolvInterface.SetKritMaxWee(aStevilo: integer);
begin
   krit[PVkdMesecMx].limit := aStevilo;
end;

function TSolvInterface.GetKritMaxWeeEnabled: boolean;
begin
   Result := krit[PVkdMesecMx].Enabled;
end;

procedure TSolvInterface.SetKritMaxWeeEnabled(aEnabled: boolean);
begin
   krit[PVkdMesecMx].Enabled := aEnabled;
end;



procedure TSolvInterface.solveBest ;
// v splosnem najboljsa metoda
begin
  DOVOLIGotovoKrsKRIT := true ;
  BRISIDMIkiKrsKRIT := true ;
// ujemi exeption iz MsgHalt zaradi naslednjih moznih napak:
//3: Napaka v delovnem planu - premalo oseb, ipd
//6: Resitev za nek dan s sproscenimi kriteriji ne obstaja
// v primeru teh exeptionov klici
//    BRISIDMIkiKrsKRIT := false ;
//    solve ;
  try
    solve ;
  except
    on ENiResitve do begin
      msg('EXCEPTION ENiResitve' ) ;
      BRISIDMIkiKrsKRIT := false ;
      solve ; // to naredi tipka F5
    end ;
  end ;
end ;


procedure TSolvInterface.solveStrict ;
// metoda, ki ima tendenco da poskusa poiskati resitev brez krsenja kriterijev
// ce je za doloceno osebo, dolocenega dne, krsitev kriterijev neizogibna
// (zararadi prehudih omejitev), takoj javi napako z MsgHalt
begin
  DOVOLIGotovoKrsKRIT := false ;
  BRISIDMIkiKrsKRIT := true ;
// ujemi exeption iz MsgHalt zaradi naslednjih moznih napak:
//3: Napaka v delovnem planu - premalo oseb, ipd
//5: Dolocena oseba, dolocenega dneva (za katerikoli DMI) zagotovo krsi kriterije
//   (v ArGUI lahko javis da so DMIji te osebe neveljavni (in zahtevas nastavitev
//   drugacnih DMIjev), ce zelis spostovati vse kriterije)
//   Ta napaka se javi le ce je vrednost DopustiDMIkiGotovoKK enaka false.
//6: Resitev za nek dan s sproscenimi kriteriji ne obstaja
// v primeru teh exeptionov klici
//    BRISIDMIkiKrsKRIT := false ;
//    solve ;
  try
    solve ;
  except
    on EGotovoKrsenje do begin
      error('Striktno reševanje - zanesljivo kršenje kriterijev.') ;
      msg('Poskušam z metodo SolveBest');
      solveBest ;
    end ;
    on ENiResitve do begin
      error('Striktno reševanje - ni rešitve.') ;
      msg('Poskušam z metodo SolveBest');
      solveBest ;
    end ;
  end ;
end ;


procedure TSolvInterface.MsgHalt(s:string; koda, dan, oseba: smallint);
var aMsg: string;
    aDesc, aDayDesc: string;
    pDDMI: pDDMIElem;
    aDay: tDateTime;
    myException: ENiResitve;

   { Opis kode napake
   0: Notranja napaka (indikacija da je nekaj hudo narobe)
   1: Napaka v formatu podatkov
   2: Napaka v nastavitvah kriterijev ali v parametrih metod ArSolve
   3: Napaka v delovnem planu - premalo oseb, ipd
   4: Prekoracitev meja arrayev, oz. konstant
   5: Dolocena oseba, dolocenega dneva (za katerikoli DMI) zagotovo krsi kriterije
      (v ArGUI lahko javis da so DMIji te osebe neveljavni (in zahtevas nastavitev
      drugacnih DMIjev), ce zelis spostovati vse kriterije)
      Ta napaka se javi le ce je vrednost DopustiDMIkiGotovoKK enaka false.
   6: Resitev za nek dan s sproscenimi kriteriji ne obstaja
   Dodatno:
     Dan pove dan v katerem je do napake prislo; dan=-1 pomeni dan neznan
     Oseba poved osebe pri kateri je do napake prislo; oseba=-1 pomeni oseba neznana
     Ce koda=3 (premalo oseb), potem oseba pomeni dmi, za katerega je premalo oseb
   }
begin
   Status := -1 ; // indikacija da je napaka

   error(s);

   case koda of
     0: begin
         aMsg := Format('Notranja napaka razreševalca. OPIS= %s Oseba=%d  Dan=%d', [s, Oseba, Dan]);
         raise EFatalError.Create(aMsg);
     end;

     1: begin
         aMsg := Format('Napaka v vhodnem formatu podatkov! OPIS= %s', [s]);
         raise EFatalError.Create(aMsg);
     end;

     3: begin
         aDay := globSolver.razpored.FirstDay + (dan-1);
         aDayDesc := FormatDateTime ('dddd, dd. mmmm yyyy', aDay);

         if ((oseba > 0) and (oseba < globSolver.DDMIList.Count)) then begin
            // v Osebi je številka DDMIja za katerega je premalo oseb
            pDDMI := PDDMIElem(globSolver.DDMIList.Items[oseba-1]);
            aDesc := pDDMI^.dem_naziv + '-' +  pDDMI^.shift_desc + '-' + pDDMI^.depa_opis;
            aMsg := Format('Razpored ne obstaja. Pomanjkanje osebja %s (%s)!', [aDayDesc, aDesc]);
         end else
            aMsg := Format('Razpored ne obstaja. Pomanjkanje osebja %s !', [aDayDesc]);;

         myException := ENiResitve.Create(aMsg) ;
         myException.Datum := aDay;
         myException.DayIndex := dan-1;
         raise myException;

     end;

     4: begin
         aMsg := Format('Prekoraèitev notranjih omejitev razreševalca. OPIS= %s', [s]);
         raise EFatalError.Create(aMsg);
     end;

     5: begin
         aMsg := Format('Striktna rešitev ne obstaja. Oseba %d na dan %d zagotovo krši kriterije. OPIS= %s', [oseba, dan, s]);
         raise EGotovoKrsenje.Create(aMsg) ;
     end;

     6: begin
         aMsg := Format('Razpored ne obstaja. Oseba %d dan %d. OPIS= %s', [oseba, dan, s]);
         raise ENiResitve.Create(aMsg);
     end;
   else
      aMsg := Format('Neznana notranja napaka razreševalca KODA=%d OPIS=%s', [koda, s]);
      raise EFatalError.Create(aMsg);
   end ;
end ;  {MsgHalt}


// ************************************************** //
// *** Nepomembne zadeve, lahko uporabis info v ArGUI **** //
procedure TSolvInterface.msg(s:string) ;
var aLogEntry: string;
begin
   aLogEntry := FormatDateTime('dd.mm.yyyy hh:nn:ss " MSG >> "', Date + Time);
   aLogEntry := aLogEntry + s;
   if fDebugMode <> dmNone then begin
      try
         writeln( LOGFILE, aLogEntry ) ;
      except
      end;
   end;
end ;

procedure TSolvInterface.error(s:string) ;
var aLogEntry: string;
begin
   aLogEntry := FormatDateTime('dd.mm.yyyy hh:nn:ss " ERR >> " ', Date + Time);
   aLogEntry := aLogEntry + s;
   if fDebugMode <> dmNone then begin
      try
         writeln( LOGFILE, aLogEntry ) ;
      except
      end;
   end;

   writeln(LOGFILE, aLogEntry);
end ;

procedure TSolvInterface.shMsgDan(d: smallint )  ;
begin
end ;
// *** KONEC Nepomembne zadeve, lahko uporabis info v ArGUI **** //
// ************************************************************* //


// ********************************************************************************** //
// *** NASTAVITEV PROBLEMA ZA ARSolve (procedure initDMIinDP, initOsebe,setKrit) **** //
procedure TSolvInterface.initDMIinDP ;
var
  i, k, nDDMIs : integer ;
  aDDMI: pDDMIElem;
  aPlanList: tList;
  aPlanElem: pPlanElem;
  aDay: TDateTime;
  aMsg: string;
begin
// primer opisa problme:
// Imamo 30 dni, priv dan v mesecu je ponedeljek. Dmijev je 10, vsi se zacnejo ob 6h in trajajo 8h.
// Del.plana zahteva vsak dan po eno osebo na dmi1, dmi2 in dmi3
// Oseb je 5. Vsaka lahko dela vsak dan na dmijih 0 do 3.
// Oseba 4 ima 100 ur prenosa iz prejs.meseca. Ostale osebe imajo 0 ur prenosa iz prejs.meseca.
// Kriteriji so nastavljeni na default vrednosti. Njihove zacetne vrednosti so 0 za vse osebe, razen:
// oseba 1 je zadnji dan v mesecu z delom koncala ob 22h
// oseba 2 je prvi dan tega meseca ze delala do 4h zjutraj
// oseba 1 je konec prejsnjega meseca delala ze 5 zaporednih dni
   nDni := globSolver.Razpored.DayCount;
   // TTipDneva = (pra=0,pon=1,tor,sre,cet,pet,sob=6,ned=7);

   prviDanMeseca := tTipDneva(DayOfTheWeek(globSolver.razpored.FirstDay));

   nDMI := globSolver.DDMIList.Count;  // VNESI st. DDMIjev
   aMsg := Format ('Število dnevov: %d Število DMIjev: %d', [nDni, nDMI]);
   msg(aMsg);

   // vnasanje DDMI_List
   for i := 1 to nDMI do begin
      aDDmi := pDDMIElem(globSolver.DDMIList.Items[i-1]);
      DMIList[i].vz := aDDMI^.shift_no;
      DMIList[i].zac := aDDMI^.start_hhmm;
      if aDDMI^.shift_no <> C_ODS_SHIFT_NO then
         // gre za razpored, ne za odsotnost. Takrat smatraš ure vedno normalno
         DMIList[i].ur := aDDMI^.need_hhmm
      else begin
         // gre za DMI tipa odsotnost. Razlièna obravnava èe razrešujemo parcialno ali na full
         if fPlanScope = psFull then
            DMIList[i].ur := aDDMI^.need_hhmm
         else
            { Pri parcialnem razreševanju odsotnosti ne smejo vplivati na razpored
              ur, zato so vse odsotnosti kot 0:00 ur
            }
            DMIList[i].ur := 0;
      end;

      if fDebugMode = dmFull then begin
         aMsg := Format ('DMI %d : Vzorec=%d, Start=%d Ur = %d', [i,
                                                                  DMIList[i].vz,
                                                                  DMIList[i].zac,
                                                                  DMIList[i].ur]);
         msg(aMsg);
      end;
   end;

   // vnašanje plana
   for i := 1 to nDni do begin
      // DP[i].tipDne := pon ;  // VNESI tip dne (pra,pon, tor,..,sob,ned)
      aPlanList := globSolver.Plan.PlanListGetForDay(i-1);

      // izraèunaj dan
      aDay := globSolver.Razpored.FirstDay + (i-1);

      // nastavi tip dneva
      if dmOracle.isPraznik(aDay) then
         DP[i].tipDne := pra
      else
         DP[i].tipDne :=tTipDneva(DayOfTheWeek(aDay));

      if fPlanScope = psSunHoly then begin
         // razrešujemo samo nedelje in praznike
         if DP[i].tipDne in [pra, ned] then begin
            // nastavi koliko DDMIjev vsebuje dan i
            DP[i].nDMI := aPlanList.Count;  // VNESI stevilo DDMIjev tega dne

            for k := 1 to DP[i].nDMI do begin
               aPlanElem := pPlanElem(aPlanList.Items[k-1]);
               DP[i].DPDMIList[k] := aPlanElem.DDMI^.ddmi_nr; // VNESI k-ti DDMI
               DP[i].nOsebList[k] := aPlanElem.minOseb;  // VNESI st. oseb na k-tem DDDMIju
            end ;
         end else begin
            // ni plana na ne-nedeljo ali praznik
            DP[i].nDMI := 0;
         end;
      end else begin
         if fPlanScope = psDDMIList then begin
            // razrešujemo samo tiste DDMIje, ki so v seznamu fDDMIToSolve
            // moramo sproti šteti koliko DDMIjev bom sploh reševal ta dan.
            nDDMIs := 0;
            for k := 0 to aPlanList.Count-1 do begin
               // i ... indeks dneva, k ... k -ti element v planski matriki za dan i
               aPlanElem := pPlanElem(aPlanList.Items[k]);
               if isDDMIOnSolveList(aPlanElem^.DDMI) then begin
                  nDDMIs := nDDMIs + 1;
                  DP[i].DPDMIList[nDDMIs] := aPlanElem.DDMI^.ddmi_nr; // VNESI k-ti DDMI
                  DP[i].nOsebList[nDDMIs] := aPlanElem.minOseb;  // VNESI st. oseb na k-tem DDDMIju
               end;
            end ;
            // na koncu nastavi koliko DDMIjev si sploh našel na dan i
            DP[i].nDMI := nDDMIs;


         end else begin
            // razrešujemo kompleten plan
            // nastavi koliko DDMIjev vsebuje dan i
            DP[i].nDMI := aPlanList.Count;  // VNESI stevilo DDMIjev tega dne

            for k := 1 to DP[i].nDMI do begin
               aPlanElem := pPlanElem(aPlanList.Items[k-1]);
               DP[i].DPDMIList[k] := aPlanElem.DDMI^.ddmi_nr; // VNESI k-ti DDMI
               DP[i].nOsebList[k] := aPlanElem.minOseb;  // VNESI st. oseb na k-tem DDDMIju
            end ;
         end;
      end;

      // debug
      if fDebugMode = dmFull then begin
         aMsg := 'Plan za dan ' + IntToStr(i) + ' Število DMIjev = ' + IntToStr(DP[i].nDMI);
         msg(aMsg);
      end;

      if fDebugMode = dmFull then begin
         for k := 1 to DP[i].nDMI do begin
            aMsg := Format ('DDMINr=%d Oseb=%d', [DP[i].DPDMIList[k], DP[i].nOsebList[k]]);
            msg(aMsg)
         end;
      end;
  end ;
end ; {initDMIinDP}


procedure TSolvInterface.initOsebe ;
var
   dIndx, oIndx, ii: integer;
   aFinalSet: TDMISet;
   doSkipDDMI: boolean;
   pRazp: pRazpElem;
   aMsg: string;
   aCrit: TCriteria;

   procedure FillAvailabilitySet(osebaIndx, dayIndx: integer; var aSet: TDMISet);
   var aAvail: TList;
       aDDMI: pDDMIElem;
       i: integer;
   begin

      if fPlanScope = psSunHoly then begin
         // obdelujemo samo nedelje in praznike
         if DP[dayIndx+1].tipDne in [pra, ned] then begin

            aAvail := globSolver.Availability.GetListForOsebaDay(osebaIndx, dayIndx);

            for i := 0 to aAvail.Count - 1 do begin
               aDDMI := pDDMIElem(aAvail.Items[i]);
               aSet := aSet + [aDDMI^.ddmi_nr];
            end;
         end else begin
            // obdelujemo samo nedelje in praznike, na ne- nedeljo in praznik naj bo oseba prosta
            aSet := [0];
         end;
      end else begin
         // normalna obdelava plana
         aAvail := globSolver.Availability.GetListForOsebaDay(osebaIndx, dayIndx);

         for i := 0 to aAvail.Count - 1 do begin
            aDDMI := pDDMIElem(aAvail.Items[i]);
            aSet := aSet + [aDDMI^.ddmi_nr];
         end;
      end;
   end;

begin
   // Nastavi št. oseb
   nOseb := globSolver.Razpored.StevOseb;

   // sprehod skozi vse dneve plana
   for dIndx := 1 to globSolver.Razpored.DayCount  do begin
      // sprehod skozi vse osebe na dan i
      for oIndx := 1 to nOseb do begin

         aFinalSet := [];
         doSkipDDMI := false;

         // poglejmo èe obstaja razpored
         pRazp := globSolver.Razpored.GetRazporedElement(oIndx-1, dIndx-1);
         if (pRazp <> nil) then begin
            // da, element obstaja, poglej kakšnega tipa
            if (pRazp^.recType = rtOdsot) then begin
               // obstaja razpored tipa odsotnost!
               if ((pRazp^.vp_id='PRO') or (pRazp^.DDMI^.need_hhmm = 0)) then
                  // gre za odsotnost brez obveze, osebo naredimo prosto
                  aFinalSet := [0]
               else
                  // druge vrste odsotnosti - bolniške etc
                  // zapiši da je oseba pribita na DDMI odsotnosti
                  aFinalSet := [pRazp^.DDMI^.ddmi_nr];

               // vedno kadar gre za odsotnost izpusti filanje DDMIjev
               doSkipDDMI := true;
            end;

            if (pRazp^.recType = rtRazp) then begin
               // obstaja fiksiran razpored! Vedno ga pribij, tudi èe razrešuješ samo nedelje - praznike
               aFinalSet := [pRazp^.DDMI^.ddmi_nr];
               // prepreèi obdelavo v nadaljevanju
               doSkipDDMI := true;
            end;
         end;

         if not doSkipDDMI then begin
            // dodaj prosti DDMI
            aFinalSet := [0];
            // dodaj DDMIje osebe
            FillAvailabilitySet(oIndx-1, dIndx-1, aFinalSet);
         end;

         aMsg := Format('Dan %d Oseba %d DDMIs=', [dIndx, oIndx]);
         for ii:=0 to nDMI do begin
            if ii in aFinalSet then
               aMsg := aMsg + IntToStr(ii) + ', ';
         end;

         if fDebugMode = dmFull then
            msg(aMsg);

         DMIOseb^[dIndx,oIndx] := aFinalSet;
      end;
    end;

   for oIndx := 1 to nOseb do begin
      aCrit := TOseba(globSolver.Osebe.Items[oIndx-1]).GetCriteria(ctHours);
      PrenosMin[oIndx] := Minutes_To_HHMM(aCrit.StartHours); // prenos ur v formatu 2030
   end;

end ;  {initOsebe}


procedure TSolvInterface.setKrit ;
// prebere limite kriterijev z datoteke
var
   i: TTipKriterija ;
   o: integer ;
   aCrit: TCriteria;
begin
   // nastavi Limite kriterijev: prvi trije kriteriji so v urah, ostali v dnevih
   krit[PDanPocitek].enabled := true ;
   krit[PDanPocitek].limit := 12 ;

   krit[PZapUrTedenMx].enabled := true ;  // max. zaporednih del.ur tedensko
   krit[PZapUrTedenMx].limit := 56 ;  // max.56 zap.del.ur tedensko

   krit[PUrMesecMx].enabled := true ;  // max. del. ur mescno
   krit[PUrMesecMx].limit := 186 ;

   krit[PZapDniTedenMx].enabled := true ;  // max. zaporednih del.dni tedensko
   krit[PZapDniTedenMx].limit := 6 ;  // max.6 zap.del.dni tedensko

   krit[PDniNPMesecMx].enabled := true ; // max. st.del.nedelj in praznikov = OFF
   krit[PDniNPMesecMx].limit := 3 ;

   krit[PVkdMesecMx].enabled := true ;  // max.st.prostih vikendov;
   krit[PVkdMesecMx].limit := 3 ;

   // doloci zacetne vr.kriterijev za vse osebe. Naèeloma so 0
   for o := 1 to nOseb do begin
      // najprej vse kriterije za to osebo postavi na 0
      for i := Low(TTipKriterija) to High(TTipKriterija) do
         // kriteriji DanPocitek,PUrMesecMx,PZapUrTedenMx v formatu 2030, ostali v dnevih
         startKrit[o,i] := 0 ;  // zacetna vrednos kriterija i osebe o

      // nastavi zaèetno število nedelj in praznikov
      aCrit := TOseba(globSolver.Osebe.Items[o-1]).GetCriteria(ctSunHoly);
      startKrit[o, PDniNPMesecMx] := aCrit.StartDays;
   end;

  //startKrit[1, PDanPocitek] := 2200 ; // oseba 1 je zadnji dan v mesecu z delom koncala ob 22h
  //startKrit[2, PDanPocitek] := 400 ;  // oseba 2 je prvi dan tega meseca ze delala do 4h zjutraj
  //startKrit[1, PZapDniTedenMx] := 5 ; // oseba 1 je konec prejsnjega meseca delala ze 5 zaporednih dni
  // Pazi, posebnost PVkdMesecMx:
  // startKrit[1,PVkdMesecMx] = 1 ==> pomeni da se mesec zacne na nedeljo, in je oseba prejsnji dan delala
  // startKrit[1,PVkdMesecMx] = 2 ==>; pomeni da ima oseba en vikend prenosa iz prejsnjega meseca
  // startKrit[1,PVkdMesecMx] = 3 ==> pomeni da ima oseba dva vikenda prenosa iz prejsnjega meseca
end ;  {setKrit}
// **************************************************************************************** //
// *** KONEC NASTAVITEV PROBLEMA ZA ARSolve (procedure initDMIinDP, initOsebe,setKrit) **** //

// procedura pobriše seznam DDMIjev, ki naj se solvajo v primeru parcialnega solvanja
procedure TSolvInterface.DDMITSClear;
var
   ii: integer;
   anItem: pDDMIElem;
begin
   for ii:=0 to fDDMIToSolve.Count-1 do begin
      anItem := fDDMIToSolve.Items[ii];
      Dispose(anItem);
   end;
   fDDMIToSolve.Clear;
end;

// procedura doda na seznam DDMIjev, ki se solvajo v primeru parcialnega solvanja, nov DDMI
procedure TSolvInterface.DDMITSAdd(aDDMI: pDDMIElem);
begin
   // doloèi številko ddmi-ja kot bodoèi index v listi
   fDDMIToSolve.Add(aDDMI);
end;

function TSolvInterface.isDDMIOnSolveList(aDDMI: pDDMIElem): boolean;
var
   i: integer;
   refElem: pDDMIElem;
begin

   for i := 0 to fDDMIToSolve.Count - 1 do begin
      refElem := pDDMIElem (fDDMIToSolve.Items[i]);
      if (refElem^.ddmi_nr = aDDMI^.ddmi_nr) then begin
         Result := true;
         exit;
      end;
   end;

   Result := false;
end;

end.

