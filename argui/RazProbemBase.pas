unit RazProbemBase;

interface

uses SysUtils, StdRut ;

const

  NOMSG = true ;  // JAKL minimizira st messagov

  MxOseb = 250 ;  	        // Max. st. razlicnih Oseb
  MxDMI = 250 ;                 // Max. st. razlicnih Del.mest/Izmen <= MxDM * MxIz
  MxVrstVzorcev = 4 ; 	        // Max. st. Vzorcev; vzorec 4(=MxVrstVzorcev) pomeni bolnisko
  MxDnevi = 35 ; 	        // Max. st. mesecnih dni, oz. dni za katere sestavljamo razpored

  MxDelPlanDMI = 80 ;	        // Max. st. razlicnih DMIjev nekega dne v delovnem planu
  MxSkupin = MxOseb ;              // Max. st. neodvisnih skupin vsak dan
  UraMinut = 60 ;                  // st.minut v uri
  DanMinut = 24*UraMinut ;         // st.minut v dnevu
  KRSIDanPocitek = 99*UraMinut ;   // oznaka za krseno vrednost vKrit[PDanPocitek]

  // RazProblem
  MxOsebNaDMI = 80 ;            // Max. st. oseb, ki lahko delajo na nekem DMI nekega dne
  MxDMIList = 60 ;              // Max. st. DMIjev neke Osebe nekega Dne

  // RazMain
  MxStore = 5000 ;              // Max. st. domen DMI[dan,oseba], ki jih lahko shranimo v TDMIValsStore

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

// Dodajanje prevec pribitih oseb v delovni plan: ce oseba ni pribita, mora imeti vedno tudi DMI 0.
// Z drugimi besedami: ce je oseba nekega dne razpolozljiva na vec kot enem DMIju, potem mora biti
// eden izmed njenih DMI tudi 0. Napr. oseba ne more biti razpolozljiva le na dmijih 1 in 2.

// Po 30.03.2007 pove kriterij PVkdMesecMx max. st. NEPROSTIH vikendov mesecno (delo sob. ali ned.)
// Zacetna vr. tega kriterija pove st. neprostih vikendov prejsnji mesec (je lahko med 0 in 4)

type
  TDMI = 0..MxDMI ;                             // DMI=0 za virtualni (prosti) DMI
  TDMISet = set of TDMI ;
  TDanIdx = 1..MxDnevi ;
  TOsebaIdx = 1..MxOseb ;
  TOsebaIdx0 = 0..MxOseb ;
  TOsebeList = array[1..MxOseb] of TOsebaIdx0 ;  // seznam oseb za razpored
  TVrstaVzorca = 0..MxVrstVzorcev ;  		// mozne grupe izmen v vzorcu (vdop, vpop, vnoc, vpr) ;
  TKritVal = smallint ;                         // vrednost kriterija
  TTipDneva = (pra=0,pon=1,tor,sre,cet,pet,sob=6,ned=7) ;
  TDMIOseb = array[1..MxDnevi, 1..MxOseb] of TDMISet ;

  TTipKriterija =
  (PDanPocitek=1,  // min. pocitek med zap. del. dnevoma - v minutah
   PZapUrTedenMx=2, // - v minutah
   PUrMesecMx=3,    // // - v minutah
   PDniNPMesecMx=4,
   PVkdMesecMx=5,  // max. st. NEPROSTIH vikendov mesecno (po 30.03.2007)
   PZapDniTedenMx=6) ;

  TKriterijDesc = record
    enabled: boolean ;
    limit: TKritVal ;      // min. oz. max. vrednost (odvisno od tipa)
    dmiIgnore: boolean ;  // true ce je update kriterija neodvisen od dmi-ja
  end ;

  TKritValList = array[TTipKriterija] of TKritVal ;

  TOseba = record
    nePribiti: smallint ;                       // st.dni ko oseba ni pribita na en DMI
    delovni: smallint ;                         // st. ze razporejenih delovnih dni osebe,stevsi tudi fiksirane dni osebe, brez dopusta
    vKrit: TKritValList ;                       // vrednosti kriterijev za osebo
  end ;

  TDelPlanDan = record
    nDMI: 0..MxDelPlanDMI ;
    DPDMIList: array[1..MxDelPlanDMI] of TDMI ;	// DMIji tega dne
    nOsebList: array[1..MxDelPlanDMI] of smallint;// st.oseb. ki delajo na ustreznem DMIju
    tipDne: TTipDneva ;
  end ;

  TDMIListEl = record
    vz: TVrstaVzorca ;   // vrsta izmene DMIja
    zac, ur: smallint ;  // zacetek in stevilo del. ur DMIja - od 15.2 dalje v minutah
  end ;

  TDMIList = array[0..MxDMI] of TDMIListEl ;

  TkrsitveKrit = array[1..MxOseb] of record // dodano 29.03.2007: spisek krsenih kriterijev oseb
    dan: smallint ;  // prvi dan ko oseba krsi nek kriterij; ce dan=0 potem oseba ne krsi kriterijev
    kriterij: TTipKriterija ; // prvi krseni kriterij
    vrKrit: TKritVal ;  // vrednost prvega krsenega kriterija
  end ;

  TRazBaseProblem = class
  private
    procedure dajDopusteVDP ;
    procedure pripraviPodatke ;
    // v delovni plan vstavi vse bolniske in dopuste (vse dmi z vz=MxVrstVzorcev)
  protected
    constructor Create  ;

    procedure initDMIinDP ; virtual ;
    procedure initOsebe ; virtual ;
    procedure msg(s:string) ; virtual ;
    procedure error(s:string) ;  virtual ;
    procedure MsgHalt(s:string; koda, dan, oseba: smallint) ; virtual ;
    procedure shMsgOsebe(o: smallint ) ; virtual ;
    procedure shMsgDan(d: smallint ) ; virtual ;
    function isVeekend(d: TDanIdx): boolean ; // dodano 30.3.2007

  public
    nDni: TDanIdx ;
    nOseb: TOsebaIdx ;
    prviDanMeseca: TTipDneva ;
    danVkdIdx: array[TDanIdx] of smallint ;
    // zap. st.dneva med vikendi meseca (prva sob=1,prva ned=2, druga sob=3, ..), ostali dnevi 0
    stVikendov: smallint ;
    // st. vikendov v mesecu (prvi vikend steje tudi ce se mesec zacne na nedeljo)
    nDMI: TDMI ;
    osebe: array[TOsebaIdx] of TOseba ;
    DP: array[TDanIdx] of TDelPlanDan ;
    DMIList: TDMIList ;
    PrenosMin: array[TOsebaIdx] of smallint ; // prenosi minut iz prejsnjega meseca; neg.vr.pomeni primanjkjaj
    DMIOseb: ^TDMIOseb ;
    DMIValsFile, DPFile, OsFile, DMIFile, DneviFile, PrenosiFile, KritLimFile, KritStartFile: string ;
    startKrit: array[TOsebaIdx,TTipKriterija] of TKritVal ;  // mora biti v minutah (napr. 720 za 12 ur)

    procedure initRazBaseProblem ;

  end ;  {TRazBaseProblem}


  TRazKriteriji = class(TRazBaseProblem)
  private
    tmpKritEnabled: array[TTipKriterija] of boolean ;
    function newValOK(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; dmi: TDMI): boolean ;
  protected
    sprosceniKrit: boolean ;
    constructor Create  ;
    procedure initKriteriji ;
    procedure initKritOsebeDan1(kritIdx: TTipKriterija; o: TOsebaIdx) ;
    procedure sprostiKriterije ;
    procedure vrniKriterije ;
    function checkKritDanPocitek(dmi1, dmi2: TDMI): boolean ;
    function newVal(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; dmi: TDMI): TKritVal ;
    procedure undoNewVal(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; dmi: TDMI) ;
    function kritOK(o: TOsebaIdx): boolean ;
    function kritOKIgnorePocitek(o: TOsebaIdx): boolean ;
    function kritOKIgnoreTeden(o: TOsebaIdx): boolean ;
    function kritOKIgnoreNPVkd(o: TOsebaIdx): boolean ;
    function valOK(kritVal: TKritVal; kritIdx: TTipKriterija): boolean ;
    function danToVkdIdx(d: TDanIdx): smallint ;
    function postaviBit(bitIdx: smallint; v: TKritVal): TKritVal ;
    function VkdMesecValToVkdCount(kritVal: TKritVal ): TKritVal ;
    function newKritOK(d: TDanIdx; o: TOsebaIdx; dmi: TDMI): boolean ;
    function nKrsKrit(d: TDanIdx; o: TOsebaIdx; dmi: TDMI): smallint ;
    function nKrsKritNow( o: TOsebaIdx ) : smallint ;
    procedure updateKrit(d: TDanIdx; o: TOsebaIdx; dmi: TDMI) ;
    procedure updateKritOKOnly(d: TDanIdx; o: TOsebaIdx; dmi: TDMI) ;
    procedure sprostiKritOsebe(d: TDanIdx; o: TOsebaIdx; dmi: TDMI) ;

    procedure setKrit ; virtual ;

  public
    DOVOLIGotovoKrsKRIT: boolean ; // !! JAKL
    // ce false potem javljanje napake 5 z MsgHalt kadar
    // dolocena oseba, dolocenega dneva (za katerikoli DMI) zagotovo krsi kriterije
    BRISIDMIkiKrsKRIT: boolean ; // !! JAKL
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

    krit: array[TTipKriterija] of TKriterijDesc ;
    procedure wrtKrit ;
  end ;  {TKriteriji}

implementation


// ***
// *** class  TRazBaseProblem
// ***

procedure TRazBaseProblem.msg(s:string) ;
begin
end ;
procedure TRazBaseProblem.error(s:string) ;
begin
end ;
procedure TRazBaseProblem.MsgHalt(s:string; koda, dan, oseba: smallint) ;
begin
end ;
procedure TRazBaseProblem.shMsgOsebe(o: smallint ) ;
begin
end ;
procedure TRazBaseProblem.shMsgDan(d: smallint )  ;
begin
end ;

procedure TRazBaseProblem.initDMIinDP ;
var
  inf: Text ;
  i, k, nd : integer ;
  format2030: boolean ;  // true ce format casa DMIjev tipa 2030 - po 15.2
begin
  // prebere seznam DMIjev iz DMIList
  assign(inf, DMIFile ) ;
  reset(inf) ;
  readln(inf, nDMI ) ;
  format2030 := false ;
  for i := 1 to nDMI do begin
    read( inf, k ) ;
    if (k > nDMI) or (k < 1) then
      MsgHalt( 'Napacen Idx DMI',1, -1, -1 ) ;
    if k <> i then
      msg('Pricakovana zaporedna st. DDMI' ) ;
    read( inf, DMIList[k].vz ) ; // ce je vz=MxVrstVzorcev potem to pomeni bolnisko oz. dopust
    // od 15.2. dalje ni vec v urah temvec tipa 2030 pomeni 20:30
    read( inf, DMIList[k].zac ) ;
    readln( inf, DMIList[k].ur ) ;
    if DMIList[k].ur > 24 then // nov format tipa 2030
      format2030 := true ;
  end ;
  close( inf ) ;
  if not format2030 then begin // pretvori v tip 2030
    //MsgHalt( 'Casi DMIjev morajo biti v formatu 2030', 1, -1, -1 ) ; // !! dodaj na koncu
    msg( 'Casi DMIjev so v URAH - pretvorba v tip 2030' ) ;
    for k := 1 to nDMI do begin
      DMIList[k].zac := 100 * DMIList[k].zac ;
      DMIList[k].ur := 100 * DMIList[k].ur ;
    end ;
  end ;
  // prebere delovni plan DP
  assign(inf, DPFile ) ;
  reset(inf) ;
  readln(inf, nDni ) ;
  // IdxDne  SteviloDMIjev [DMI1  StOseb1, DMI2  StOseb2, ..]
  for i := 1 to nDni do begin
    DP[i].tipDne := pra ;  // vse nastavimo na praznik
    read( inf, k ) ;
    if k <> i then
      msg( 'Napacen Idx Dne' ) ;
    read( inf, DP[i].nDMI ) ;  // stevilo DMIjev na DPju
    for k := 1 to DP[i].nDMI do begin
      read( inf, DP[i].DPDMIList[k] ) ;
      read( inf, DP[i].nOsebList[k] ) ;
    end ;
    readln(inf) ;
  end ;
  close( inf ) ;
  // prebere tipe dni
  assign(inf, DneviFile ) ;
  reset(inf) ;
  readln(inf, nd ) ;
  if nd > nDni then begin
    error( 'nDni se ne ujema, uporabim DPFile nDni='+IntToStr(nDni) ) ;
    nd := nDni ;
  end ;
  if nd < nDni then
    MsgHalt( 'nDni v DneviFile premajhen',1, -1, -1 ) ;
  for i := 1 to nd do begin
    readln( inf, k ) ;
    if (k > 7) or (k < 0) then
      MsgHalt( 'Napacen tip Dne',1, i, -1 ) ;
    DP[i].tipDne := TTipDneva(k) ;
  end ;
  close( inf ) ;
  // doloci prvi dan meseca
  k := 1 ;
  for i := 1 to nd do
    if DP[i].tipDne <> pra then begin
      k := i ; break ;
    end ;
  if DP[k].tipDne=pra then begin
    msg( 'Sami prazniki v mesecu, delam kot da je prvi dan ponedeljek' ) ;
    prviDanMeseca := pon ; 
  end else begin
    prviDanMeseca := DP[k].tipDne ;
    for i := k-1 downto 1 do
      if prviDanMeseca = pon then
        prviDanMeseca := ned
      else prviDanMeseca := Pred(prviDanMeseca) ;
  end ;
end ; {initDMI}


procedure TRazBaseProblem.initOsebe ;
var
  i, j, k, SetLen, d, o, p, idxDneva, ddmi, nNe0Oseb, t: integer ;
  inF: Text ;
  nDniReadType3: smallint ;
begin
  assign(inf, OsFile ) ;
  reset(inf) ;
  readln(inf, nDniReadType3 ) ;
  if (nDniReadType3 <> 0) and (nDni>nDniReadType3) then
    MsgHalt( 'St. dni v specifikaciji Delovnega Plana vecje od st. dni pri specifikaciji DDMIjev oseb',1, -1, -1 ) ;
  for d := 1 to nDniReadType3 do begin
    readln(inf, idxDneva ) ;
    if idxDneva <> d then
      MsgHalt( 'Napacen idx dneva',1, d, -1 ) ;
    readln(inf, nNe0Oseb ) ;
    // loceno po dneh, za vsako osebo; vsaka vrstica mora biti takale:
    // ZapSt  SteviloDDMIjevOsebe  MozniDDMIjiOsebe
    i := 1 ; t := 0 ;
    while t < nNe0Oseb do begin
      t := t + 1 ;
      read( inf, k ) ;  // index osebe
      if k > nOseb then
        nOseb := k ;
      while i <= k do begin
        DMIOseb^[d,i] := [] ;
        if k = i then begin
          read( inf, SetLen ) ; // stevilo DDMIjev osebe
          for j := 1 to SetLen do begin
            read( inf, ddmi ) ; // DDMI osebe
            if (ddmi < 0) or (ddmi > nDMI) then
              MsgHalt( 'Napacen DMI osebe o'+intToStr(i),1, d, i ) ;
            DMIOseb^[d,i] := DMIOseb^[d,i] + [ddmi] ;
          end ;
        end else begin // k < i; prazna oseba z DMI = 0
          MsgHalt( 'Oseba '+IntToStr(i)+' dne '+IntToStr(d)+' ni v seznamu oseb', 1, d, i ) ; // dodano 13.3.2007 
          DMIOseb^[d,i] := DMIOseb^[d,i] + [0] ;
        end ;
        i := i + 1 ;
      end ;
      readln(inf) ;
    end ;  // while i < nNe0Oseb do begin
  end ;  //  for d := 1 to nDniReadType3 do begin
  close( inf ) ;
  msg( IntToStr(nOseb)+' oseb prebrano' ) ;
  // preberi prenose ur iz. prejs.mesecev (v formatu 2030)
  if FileExists( PrenosiFile ) then begin
    assign(inf, PrenosiFile ) ;
    reset(inf) ;
    for o := 1 to nOseb do begin
      readln(inf, p ) ;
      if (p > 20000) or (p < -20000) then
        MsgHalt( 'Prenos presega 200 ur',1, -1, o ) ;
      PrenosMin[o] := p ;
    end ;
    close( inf ) ;
  end else
    msg( PrenosiFile+' ne obstaja; uporabim 0 za vse osebe' ) ;
end ;  {initOsebe}


procedure TRazBaseProblem.dajDopusteVDP ;
// v delovni plan vstavi vse bolniske in dopuste (vse dmi z vz=MxVrstVzorcev)
var
  o: TOsebaIdx ;
  d: TDanIdx ;
  dmi: TDMI ;
  i, j, dmiIdx: smallint ;
begin
  i := 0 ;
  for dmi := 0 to nDMI do begin
    if DMIList[dmi].vz <> MxVrstVzorcev then  // samo za bolniske in dopuste
      continue ;
    for d := 1 to nDni do
      for o := 1 to nOseb do
        if dmi in DMIOseb^[d,o] then begin // vstavi dmi v DP
          // poiscem dmi
          dmiIdx := -1 ;
          for j := 1 to DP[d].nDMI do
            if DP[d].DPDMIList[j] = dmi then begin
              dmiIdx := j ; break ;
            end ;
          if dmiIdx > 0 then
            DP[d].nOsebList[dmiIdx] := DP[d].nOsebList[dmiIdx] + 1
          else begin// vstavi dmi
            DP[d].nDMI := DP[d].nDMI + 1 ;  
            DP[d].DPDMIList[DP[d].nDMI] := dmi ;
            DP[d].nOsebList[DP[d].nDMI] := 1 ;
          end ;
          i := i + 1 ;
        end ;
  end ;
  msg( IntToStr(i)+' dopustov/bolniskih vstavljenih v delovni plan' ) ;
end ;  {dajDopusteVDP}


procedure TRazBaseProblem.pripraviPodatke ;
var
  i, k, j, o, minPren : integer ;
begin
  // pretvori case DMIjev v minute
  for k := 0 to nDMI do begin
    if (DMIList[k].zac mod 100 > UraMinut) or (DMIList[k].ur mod 100 > UraMinut) then
      MsgHalt( 'Casi DMIjev morajo biti v formatu tipa 2030 (kar pomeni 20:30)', 1, -1, -1 ) ;
    DMIList[k].zac := UraMinut*(DMIList[k].zac div 100) + (DMIList[k].zac mod 100) ;
    DMIList[k].ur := UraMinut*(DMIList[k].ur div 100) + (DMIList[k].ur mod 100) ;
  end ;
  // postavi danVkdIdx glede na prviDanMeseca
  if prviDanMeseca = pra then
    MsgHalt( 'Prvi dan meseca ne sme biti praznik', 1, 1, -1 ) ;
  k := Ord(prviDanMeseca) ;
  j := 1 ;
  stVikendov := 0 ;
  for i := 1 to nDni do begin
    if k = Ord(ned) then
      stVikendov := stVikendov + 1 ;
    //if k in [Ord(sob),Ord(ned)] then begin // sobota ali nedelja
    if isVeekend(i) then begin // sobota ali nedelja
      danVkdIdx[i] := j ;
      // if k = Ord(ned) then
      if (i > 1) and (danVkdIdx[i-1] <> 0) then // prejsnji dan tudi vikend
        j := j + 1 ;
    end else
      danVkdIdx[i] := 0 ;
    k := (k mod 7) + 1 ;
  end ;
  // pretvori prenose ur v minute in odstej minimalni prenos
  minPren := High(smallint) ;
  for o := 1 to nOseb do begin
    if PrenosMin[o] mod 100 > UraMinut then
      MsgHalt( 'Napacen format prenosov',1, -1, o ) ;
    if (PrenosMin[o] > 20000) or (PrenosMin[o] < -20000) then
      MsgHalt( 'Prenos presega 200 ur',1, -1, o ) ;
    PrenosMin[o] := UraMinut*(PrenosMin[o] div 100) + (PrenosMin[o] mod 100) ;
    minPren := MinInt(minPren, PrenosMin[o]) ;
  end ;
  // od vseh prenosov odstejem minimalni prenost, tako da je najmanjsi Prenos[o]=0
  for o := 1 to nOseb do
    PrenosMin[o] := PrenosMin[o] - minPren ;
  msg( 'Prvi dan meseca='+IntToStr(Ord(prviDanMeseca))+'  st.vikendov='+IntToStr(stVikendov)+'  min.prenos ur = '+IntToStr(minPren) ) ;
  if stVikendov > 9 then
    MsgHalt( 'Max. 9 vikendov v mesecu dovoljeno',1, -1, -1 ) ; // omejitev zarad kriterija PDelVkdMx in TKritVal=smallint
  dajDopusteVDP ;
end ; {pripraviPodatke}

function TRazBaseProblem.isVeekend(d: TDanIdx): boolean ; // dodano 30.3.2007
begin
  Result := (DP[d].tipDne = sob) or (DP[d].tipDne = ned) ; // sobota ali nedelja
  if DP[d].tipDne = pra then // tudi lahko sobota ali nedelja, izracunaj glede na prviDanMeseca
    Result := (d + Ord(prviDanMeseca)-1) mod 7 in [0,6] ;
end ;  {isVeekend}

constructor TRazBaseProblem.Create  ;
var
  pStr: string ;
begin
  PrenosiFile := '' ; KritLimFile := '' ;
//        pStr := 'P/P0'; PrenosiFile := 'Pren.txt' ; KritLimFile := 'KritLim.txt' ;
//        pStr := 'P/P1'; PrenosiFile := 'Pren.txt' ; KritLimFile := 'KritLim.txt' ;
//        pStr := 'P/P2'; PrenosiFile := 'Pren.txt' ; KritLimFile := 'KritLim.txt' ;
//        pStr := 'P/P3'; PrenosiFile := 'Pren.txt' ; KritLimFile := 'KritLim.txt' ;
//        pStr := 'P/P4'; PrenosiFile := 'Pren.txt' ; KritLimFile := 'KritLim.txt' ;
//        pStr := 'P/P4a'; PrenosiFile := 'Pren.txt' ; KritLimFile := 'KritLim.txt' ;
//        pStr := 'P/P4-Bol'; PrenosiFile := 'Pren.txt' ; KritLimFile := 'KritLim.txt' ;
//        pStr := 'P/P6'; PrenosiFile := 'Pren.txt' ; KritLimFile := 'KritLim.txt' ;
//        pStr := 'P/P6c'; PrenosiFile := 'Pren.txt' ; KritLimFile := 'KritLim.txt' ;
//        pStr := 'P/P10';  PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;
//        pStr := 'P/P11'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;
        pStr := 'P/P12'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;
//        pStr := 'P/P12bol'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;
//        pStr := 'P/P12-dodavDP'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;
//        pStr := 'P/P13'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;
//        pStr := 'P/P14'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;
//        pStr := 'P/P15'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ; // NERESLJIVO
//        pStr := 'P/P17'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;
//        pStr := 'P/P18'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;

// Velik problem, 116 oseb
//        pStr := 'P/B1'; PrenosiFile := pStr+'-'+'Pren.txt' ; KritLimFile := pStr+'-'+'KritLim.txt' ;

  pStr := pStr+'-' ;
  DPFile := pStr+'Plan.txt' ; OSFile := pStr+'Osebe.txt' ; DMIFile := pStr+'List.txt' ;
  DneviFile := pStr+'Dnevi.txt' ; DMIValsFile := pStr+'OUT' ;
  KritStartFile := pStr+'KritStart.txt' ;
end ;  {Create}


procedure TRazBaseProblem.initRazBaseProblem ;
var
  k, i : integer ;
begin
  new(DMIOseb) ;
  for k := 1 to MxDnevi do
    for i := 1 to MxOseb do
      DMIOseb^[k,i] := [] ;
  DMIList[0].vz := 0 ;    // dmi z vz=0 so prosto
  DMIList[0].zac := 1200 ;  // zacetek ob 12h, format 2030
  DMIList[0].ur := 0 ; // cas trajanja dmi=prosto mora biti 0
  for k := 1 to MxOseb do
    PrenosMin[k] := 0 ;

  initDMIinDP ; // override
  initOsebe ;  // override

  pripraviPodatke ; // pripravi indekse, pretvori case v minute, itd
end ;  {initRazBaseProblem}


// ***
// *** class  TRazKriteriji
// ***

constructor TRazKriteriji.Create  ;
begin
  inherited Create  ;
  DOVOLIGotovoKrsKRIT := true ;
  BRISIDMIkiKrsKRIT := true ;

  krit[PDanPocitek].enabled := true ;
  krit[PDanPocitek].dmiIgnore := false ;  // update kriterija je odvisen od dmi-ja
  krit[PDanPocitek].limit := 12 ;

  krit[PZapUrTedenMx].enabled := true ;  // max. zaporednih del.ur tedensko
  krit[PZapUrTedenMx].dmiIgnore := false ;  // update kriterija je odvisen od dmi-ja
  krit[PZapUrTedenMx].limit := 56 ;  // max.56 zap.del.ur tedensko

  krit[PUrMesecMx].enabled := true ;  // max. del. ur mescno
  krit[PUrMesecMx].dmiIgnore := false ;  // update kriterija je odvisen od dmi-ja
  krit[PUrMesecMx].limit := 186 ;

  krit[PZapDniTedenMx].enabled := true ;  // max. zaporednih del.dni tedensko
  krit[PZapDniTedenMx].dmiIgnore := true ;  // update kriterija je neodvisen od dmi-ja
  krit[PZapDniTedenMx].limit := 6 ;  // max.6 zap.del.dni tedensko

  krit[PDniNPMesecMx].enabled := false ;  // update kriterija je neodvisen od dmi-ja
  krit[PDniNPMesecMx].dmiIgnore := true ;  // update kriterija je neodvisen od dmi-ja
  krit[PDniNPMesecMx].limit := 4 ;

  krit[PVkdMesecMx].enabled := true ;  // max.st.NEPROSTIH vikendov;
  krit[PVkdMesecMx].dmiIgnore := true ;  // update kriterija je neodvisen od dmi-ja
  krit[PVkdMesecMx].limit := 3 ;
end ;  {Create}


procedure TRazKriteriji.initKriteriji ;
var
  o: integer ;
  i: TTipKriterija ;
begin
  initRazBaseProblem ;
  sprosceniKrit := false ;
  // nastavi zacetne vrednosti kriterijev
  for o := 1 to nOseb do begin
    // prvi trije kriteriji morajo biti v minutah, ostali v dnevih
    for i := Low(TTipKriterija) to High(TTipKriterija) do
      startKrit[o,i] := 0 ;
  end ;
  setKrit ;  // override

  // pretvorba ur v minute
  krit[PDanPocitek].limit := UraMinut*krit[PDanPocitek].limit ;
  krit[PUrMesecMx].limit := UraMinut*krit[PUrMesecMx].limit ;
  krit[PZapUrTedenMx].limit := UraMinut*krit[PZapUrTedenMx].limit ;
  // zacetne vrednosti kriterijev: pretvori format 2030 v minute
  for o := 1 to MxOseb do begin
    for i := Low(TTipKriterija) to High(TTipKriterija) do begin
      if i in [PDanPocitek,PUrMesecMx,PZapUrTedenMx] then begin // pretvori format 2030 v minute
        if startKrit[o,i] mod 100 > UraMinut then
          MsgHalt( 'Napacen format zacetnih vrednosti kriterijev za o'+IntToStr(o),1, -1, o ) ;
        startKrit[o,i] := UraMinut*(startKrit[o,i] div 100) + (startKrit[o,i] mod 100) ; // pretvorba formata 2030 v minute
      end ;
    end ;
    case startKrit[o,PVkdMesecMx] of
      0: ; // obicajna vrednost, nic prenosa
      1: // en delovni vikend prenosa iz prejsnjega meseca
         startKrit[o,PVkdMesecMx] := postaviBit( 10, 0 ) ;
      2: begin // dva delovna vikenda prenosa iz prejsnjega meseca
         startKrit[o,PVkdMesecMx] := postaviBit( 10, 0 ) ;
         startKrit[o,PVkdMesecMx] := postaviBit( 11, startKrit[o,PVkdMesecMx] ) ;
      end ;
      3: begin // trije delovni vikenda prenosa iz prejsnjega meseca
         startKrit[o,PVkdMesecMx] := postaviBit( 10, 0 ) ;
         startKrit[o,PVkdMesecMx] := postaviBit( 11, startKrit[o,PVkdMesecMx] ) ;
         startKrit[o,PVkdMesecMx] := postaviBit( 12, startKrit[o,PVkdMesecMx] ) ;
      end ;
      4: begin // stirje delovni vikenda prenosa iz prejsnjega meseca
         startKrit[o,PVkdMesecMx] := postaviBit( 10, 0 ) ;
         startKrit[o,PVkdMesecMx] := postaviBit( 11, startKrit[o,PVkdMesecMx] ) ;
         startKrit[o,PVkdMesecMx] := postaviBit( 12, startKrit[o,PVkdMesecMx] ) ;
         startKrit[o,PVkdMesecMx] := postaviBit( 13, startKrit[o,PVkdMesecMx] ) ;
      end ;
      else
        MsgHalt( 'Nedovoljena vrednost kriterija PVkdMesecMx',1, -1, o ) ;
    end ;
  end ;
  // nastavi zacetne kriterije prvega dne
  for o := 1 to MxOseb do
    for i := Low(TTipKriterija) to High(TTipKriterija) do
      initKritOsebeDan1( i, o ) ;
end ;  {initKriteriji}


procedure TRazKriteriji.initKritOsebeDan1(kritIdx: TTipKriterija; o: TOsebaIdx) ;
// nastavi kriterij osebe na zacetno vrednost ob dnevu 1
// nastavi zacetne vrednosti v MINUTAH (napr. 720 za 12ur oz. 1200)
begin
  osebe[o].vKrit[kritIdx] := startKrit[o,kritIdx] ;  // v minutah
end ;  {initKritOsebeDan1}


procedure TRazKriteriji.setKrit ;
// prebere limite kriterijev z datoteke
var
  i: TTipKriterija ;
  v: integer ;
  inf: Text ;
  o: integer ;
begin
  // bere Limite kriterijev: prvi trije kriteriji so v urah, ostali v dnevih
  if FileExists( KritLimFile ) then begin
    assign( inF, KritLimFile ) ; reset( inf ) ;
    for i := Low(TTipKriterija) to High(TTipKriterija) do begin
      readln( inf, v ) ;
      if v < 0 then
        krit[i].enabled := false
      else begin
        krit[i].limit := v ;
        krit[i].enabled := true ;
      end ;
    end ;
    close( inf ) ;
    //msg( 'Prebrani limiti kriterije:' ) ; wrtKrit ;
  end else
    msg(KritLimFile+' ne obstaja - uporabim DEFAULT vr. kriterijev' ) ;
  // preberi zacetne vr.kriterijev za vse osebe
  if FileExists( KritStartFile ) then begin
    assign( inf, KritStartFile ) ; reset( inf ) ;
    for o := 1 to MxOseb do begin
      for i := Low(TTipKriterija) to High(TTipKriterija) do
        read( inf, startKrit[o,i] ) ; // beremo v formatu 2030
      readln( inf ) ;
    end ;
    close( inf ) ;
    msg('Zacetne vr.kriterijev prebrane z '+KritStartFile ) ;
  end else
    msg(KritStartFile+' ne obstaja - uporabim DEFAULT zacetne vr. kriterijev' ) ;
end ;  {setKrit}


procedure TRazKriteriji.wrtKrit ;
var
  i: TTipKriterija ;
begin
  msg( 'Files: '+DPFile+', '+OSFile+', '+DMIFile+', '+DneviFile+', '+KritLimFile+', '+KritStartFile+', '+PrenosiFile+' >> '+DMIValsFile ) ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do
    if krit[i].enabled then
      msg( 'Kriterij '+IntToStr(ord(i))+'  limit = '+IntToStr(krit[i].limit) )
    else
      msg( 'Kriterij '+IntToStr(ord(i))+'  OFF' ) ;
end ;  {wrtKrit}

procedure TRazKriteriji.sprostiKriterije ;
// sprosti vse kriterije
var
  i: TTipKriterija ;
begin
  if sprosceniKrit then
    MsgHalt( 'sprostiKriterije: ze prej sprosceni kriteriji',0, -1, -1 ) ;
  sprosceniKrit := true ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do begin
    tmpKritEnabled[i] := krit[i].enabled ;
    krit[i].enabled := false ;
  end ;
end ;  {sprostiKriterije}

procedure TRazKriteriji.vrniKriterije ;
// vrni krit[i].enabled na vrednosti pred klicom sprostiKriterije
var
  i: TTipKriterija ;
begin
  if not sprosceniKrit then
    MsgHalt( 'vrniKriterije: kriteriji niso sprosceni',0, -1, -1 ) ;
  sprosceniKrit := false ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do 
    krit[i].enabled := tmpKritEnabled[i] ;
end ;  {vrniKriterije}


function TRazKriteriji.checkKritDanPocitek(dmi1, dmi2: TDMI): boolean ;
begin
  if (dmi1=0) or (dmi2=0) then // vedno ok ce je en dan prost
    Result := true
  else
    Result := DMIList[dmi1].zac + DMIList[dmi1].ur + krit[PDanPocitek].limit - DanMinut <= DMIList[dmi2].zac ;
end ;  {checkKritDanPocitek}


function TRazKriteriji.newVal(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; dmi: TDMI): TKritVal ;
// izracuna vrednost kriterija kritIdx osebe o, ce osebo o, dne d, pribijemo na dmi
// spremeba 13.03.2007: Bolniske in dopusti spreminjajo le kriterij PUrMesecMx, ostale
// kriterije pustijo nespremenjene
begin
   if not krit[kritIdx].enabled then begin
     Result := osebe[o].vKrit[kritIdx] ; exit ;
   end ;
   case kritIdx of
     PDanPocitek: begin
       // vkrit[o] = minute konca dela dne d; -limit ce je dan d prosto
       if (dmi = 0) or (DMIList[dmi].vz = MxVrstVzorcev) then // dmi prosto resetira ta kriterij
         Result := 0
       else begin // vrne KRSIDanPocitek ce dmi krsi kriterij PDanPocitek
         if osebe[o].vKrit[kritIdx]+krit[kritIdx].limit - DanMinut > DMIList[dmi].zac then
           Result:= KRSIDanPocitek
         else Result := (DMIList[dmi].zac + DMIList[dmi].ur)  ; // ura konca dela
       end ;
     end ;
     PZapUrTedenMx: begin // zaporedno st. del.dni (ali ure?) v zadnjih 7 dnevih
       if (dmi = 0) or (DMIList[dmi].vz = MxVrstVzorcev) then // dmi prosto resetira ta kriterij
         Result := 0
       else Result := osebe[o].vKrit[kritIdx] + DMIList[dmi].ur ; // delovne ure
     end ;
     PZapDniTedenMx: begin// zaporedno st. del.dni (ali ure?) v zadnjih 7 dnevih
       if (dmi = 0) or (DMIList[dmi].vz = MxVrstVzorcev) then // dmi prosto resetira ta kriterij
         Result := 0
       else Result := osebe[o].vKrit[kritIdx] + 1 ; // delovni dnevi
     end ;
     PUrMesecMx: Result := osebe[o].vKrit[kritIdx] + DMIList[dmi].ur ;
     PDniNPMesecMx:
       if (dmi<>0) and (DMIList[dmi].vz<>MxVrstVzorcev) and ((DP[d].tipDne = ned) or (DP[d].tipDne = pra)) then // nedelja ali praznik
         Result := osebe[o].vKrit[kritIdx] + 1
       else Result := osebe[o].vKrit[kritIdx]  ;
     PVkdMesecMx:
       if (dmi<>0) and (DMIList[dmi].vz<>MxVrstVzorcev) and isVeekend(d) then begin // sobota ali nedelja
         Result := postaviBit( danToVkdIdx(d), osebe[o].vKrit[kritIdx] ) ;
       end else Result := osebe[o].vKrit[kritIdx]  ;
   end ;
end ;  {newVal}


function TRazKriteriji.danToVkdIdx(d: TDanIdx): smallint ;
// vrne zaporedno st.dneva med vikendi meseca (prva sob=1,prva ned=2, druga sob=3, ..)
begin
  Result := danVkdIdx[d] ; // zap. st.dneva med vikendi meseca 
  if Result <= 0 then
    MsgHalt( 'danToVkdIdx: dan='+IntToStr(d)+' ni vikend?', 1, d, -1 ) ;
end ;  {danToVkdIdx}

function TRazKriteriji.postaviBit(bitIdx: smallint; v: TKritVal): TKritVal ;
// postavi bit bitIdx v v na 1; napaka ce je ta bit ze postavljen
var v1: TKritVal ;
//tbitIdx: smallint;
begin
  //tbitIdx:=bitIdx ;
  if (bitIdx > 14) or (bitIdx < 1)then
    MsgHalt( 'postaviBit: bitIdx '+IntToStr(bitIdx)+' prevelik ali premajhen',4, -1, -1 ) ;
  Result := 1 ;
  v1 := v ;
  while bitIdx > 1 do begin
    bitIdx := bitIdx - 1 ;
    Result := Result * 2 ;
    v1 := v1 div 2 ;
  end ;
  if v1 mod 2 = 0 then // bit se ni postavljen - dodano 30.3.2007
    Result := Result + v
  else Result := v ;  
//  msg( 'Postavi bit '+IntToStr(tbitIdx)+' v '+IntToStr(v)+' = '+IntToStr(Result)) ;
end ;  {postaviBit}

function TRazKriteriji.VkdMesecValToVkdCount(kritVal: TKritVal ): TKritVal ;
// vrne stevilo vikendov (=zaporednih postavljenih bitov) v kritVal
begin
  // s := '' ; v := kritVal ;
  Result := 0 ;
  if kritVal < 0 then
    MsgHalt('VkdMesecValToVkdCount: invalid kritVal',0, -1, -1 ) ;
  while kritVal > 0 do begin
    // s := s + IntToStr(kritVal mod 2) + IntToStr((kritVal div 2) mod 2) ;
    //if (kritVal mod 2=1) and ((kritVal div 2) mod 2=1) then // bita sob. in ned. postavljena - do 30.03.2007
    if (kritVal mod 2=1) then // bit vikenda postavljen - po 30.03.2007
      Result := Result + 1 ;
    //kritVal := kritVal div 4 ;
    kritVal := kritVal div 2 ; // po 30.03.2004
  end ;
//  if v > 15000 then
//    msg( 'Vkd('+IntToStr(v)+') = '+s+' = '+IntToStr(Result) ) ;
end ;  {VkdMesecValOK}

function TRazKriteriji.valOK(kritVal: TKritVal; kritIdx: TTipKriterija): boolean ;
// vrne true, ce je vrednost kritVal ustrezna za kriterij kritIdx
begin
  if not krit[kritIdx].enabled then begin
     Result := true ; exit ;
  end ;
  Result := false ;
  case kritIdx of
    PDanPocitek:
      if kritVal<>KRSIDanPocitek then
        Result := true ;
    PVkdMesecMx: // hranimo en bit za vsak vikend (po 30.3.2007)
      if VkdMesecValToVkdCount(kritVal) <= krit[kritIdx].limit then
        Result := true ;
    PUrMesecMx, PDniNPMesecMx, PZapUrTedenMx, PZapDniTedenMx:// dolocene so max. vrednosti za kriterij
      if kritVal <= krit[kritIdx].limit then
        Result := true ;
  end ;
end ;  {valOK}


function TRazKriteriji.newValOK(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; dmi: TDMI): boolean ;
// preveri izpolnjenost kriterija kritIdx osebe o, ce osebo o, dne d, pribijemo na dmi
var
  v: TKritVal ;
begin
  v := newVal(kritIdx, d, o, dmi) ;
  Result := valOK( v, kritIdx ) ;
end ;  {newValOK}


function TRazKriteriji.kritOK(o: TOsebaIdx): boolean ;
// preveri ce so za osebo o izpolnjeni vsi omogoceni kriteriji
var
  i: TTipKriterija ;
begin
  Result := false ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do begin
     if not valOK( osebe[o].vKrit[i], i ) then
       exit ;
   end ;
   Result := true ;
end ;  {kritOK}


function TRazKriteriji.newKritOK(d: TDanIdx; o: TOsebaIdx; dmi: TDMI): boolean ;
// preveri izpolnjenost vseh kriterijev osebe o, ce osebo o, dne d, pribijemo na dmi
var
  i: TTipKriterija ;
begin
  Result := false ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do begin
    // if krit[i].enabled and (dmi in krit[i].dmiSet) and not newValOK( i, d, o, dmi) then
    if not newValOK( i, d, o, dmi) then
       exit ;
  end ;
  Result := true ;
end ;  {newKritOK}


function TRazKriteriji.kritOKIgnorePocitek(o: TOsebaIdx): boolean ;
// preveri ce so za osebo o izpolnjeni vsi omogoceni kriteriji - ignorira pocitek
var
  danPocitekEnabled: boolean ;
begin
  danPocitekEnabled := krit[PDanPocitek].enabled ;
  krit[PDanPocitek].enabled := false ;  // onemogoci kriterij PDanPocitek
  Result := kritOK( o ) ;
  krit[PDanPocitek].enabled := danPocitekEnabled ;
end ;  {kritOKIgnorePocitek}

function TRazKriteriji.kritOKIgnoreTeden(o: TOsebaIdx): boolean ;
// preveri ce so za osebo o izpolnjeni vsi omogoceni kriteriji razen
// dnevnih in ted. krit. to je PDanPocitek, PZapUrTedenProsto in PZapUrTedenMx
begin
  Result :=
    valOK(osebe[o].vKrit[PUrMesecMx], PUrMesecMx) and
    valOK(osebe[o].vKrit[PVkdMesecMx],PVkdMesecMx) and
    valOK(osebe[o].vKrit[PDniNPMesecMx],PDniNPMesecMx) ;
end ;  {kritOKIgnoreTeden}


function TRazKriteriji.kritOKIgnoreNPVkd(o: TOsebaIdx): boolean ;
// preveri ce so za os. o izpolnjeni vsi krit razen PDniNPMesecMx in PVikendMesecProsto ;
// to je kriterijev, ki se nanasajo na nedeljo, praznik ali vikend
begin
  Result :=
    valOK(osebe[o].vKrit[PDanPocitek], PDanPocitek) and
    valOK(osebe[o].vKrit[PZapUrTedenMx], PZapUrTedenMx) and
    valOK(osebe[o].vKrit[PZapDniTedenMx], PZapDniTedenMx) and
    valOK(osebe[o].vKrit[PUrMesecMx], PUrMesecMx) ;
end ;  {kritOKIgnoreNPVkd}


function TRazKriteriji.nKrsKrit(d: TDanIdx; o: TOsebaIdx; dmi: TDMI): smallint ;
// vrne st. krsenih kriterijev, ce osebo o pribijemo na dmi
var
  i: TTipKriterija ;
begin
  Result := 0 ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do
    //if krit[i].enabled and (dmi in krit[i].dmiSet) and not newValOK( i, d, o, dmi) then
    if not newValOK( i, d, o, dmi) then
       Result := Result + 1 ;
end ;  {nKrsKrit}

function TRazKriteriji.nKrsKritNow( o: TOsebaIdx ) : smallint ;
// vrne trenutno st. krsenih kriterijev
var
  i: TTipKriterija ;
begin
  Result := 0 ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do
    if not ValOK( osebe[o].vKrit[i], i) then
       Result := Result + 1 ;
end ;  {nKrsKrit}


procedure TRazKriteriji.updateKrit(d: TDanIdx; o: TOsebaIdx; dmi: TDMI) ;
// izracuna vrednosti kriterijev osebe o, ce osebo o, dne d, pribijemo na dmi
var
  i: TTipKriterija ;
begin
  for i := Low(TTipKriterija) to High(TTipKriterija) do begin
    if krit[i].enabled then
      osebe[o].vKrit[i] := newVal( i, d, o, dmi ) ;
  end ;
end ;  {updateKrit}


procedure TRazKriteriji.updateKritOKOnly(d: TDanIdx; o: TOsebaIdx; dmi: TDMI) ;
// samo za kriterije, ki niso krseni izracuna vrednosti kriterijev osebe o, ce osebo o, dne d, pribijemo na dmi
var
  i: TTipKriterija ;
begin
  for i := Low(TTipKriterija) to High(TTipKriterija) do begin
    if newValOK( i, d, o, dmi ) then
      osebe[o].vKrit[i] := newVal( i, d, o, dmi ) ;
  end ;
end ;  {updateKritOKOnly}

procedure TRazKriteriji.sprostiKritOsebe(d: TDanIdx; o: TOsebaIdx; dmi: TDMI) ;
// zmanjsa vrednosti kriterijev, ce osebo o sprostimo, tako da ne dela vec na dmi
var
  i: TTipKriterija ;
begin
  for i := Low(TTipKriterija) to High(TTipKriterija) do
    undoNewVal( i, d, o, dmi ) ;
end ;  {sprostiKritOsebe}

procedure TRazKriteriji.undoNewVal(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; dmi: TDMI) ;
// izracuna vrednost kriterija kritIdx osebe o, ce osebo o, dne d, sprostimo z dmi
// popravi kriterij osebe, tako da odsteje razliko, ki jo naredi pribitje dmija
// ne dela za PDanPocitek, PZapUrTedenMx, PZapUrTedenProsto, ipd
var
  newV, oldV: TKritVal ;
begin
  oldV := osebe[o].vKrit[kritIdx] ;
  newV := newVal(kritIdx, d, o, dmi ) ;
  osebe[o].vKrit[kritIdx] := osebe[o].vKrit[kritIdx] - (newV-oldV) ;
end ;  {undoNewVal}

end.
