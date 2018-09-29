unit RazMain;

interface

uses Math, DateUtils, StdRut, SysUtils, RazProbemBase, RazProbem ;


type

  TOsebaIdx0 = 0..MxOseb ;
  TOsebeNaDMIEl = record
    last: 0..MxOsebNaDMI ;
    list: array[1..MxOsebNaDMI] of TDMI ; // seznam oseb, ki lahko delajo na nekem DMI
    pMest: smallint;                    // stevilo prostih mest tega DMI/dne
  end ;
  TOsebeNaDMI = array[0..MxDMI, TDanIdx] of TOsebeNaDMIEl ; // osebe, ki lahko delajo na nekem DMI, dne


  TVrstniRedVzorcev = array[1..MxOseb] of TSmIntRealPairArray ;

  TRazSolve = class(TRazProblem)
  private
    store: TObject ;  // store je class TDMIValsStore 
    OsebeNaDmi: TOsebeNaDMI ;   // OsebeNaDMI[dmi,o] so vse osebe, ki lahko delajo na dmi, dne d
    oceneOseb: TSmIntRealPairArray ;
    mozniDMI: TSmIntRealPairArray ;
    nProstihMest, nMoznihOseb: TDanVzorecInt ;

    vrVzorcevGlob: TVrstniRedVzorcev ;
    poDanSkupinah: boolean ;
    tmposebe: array[TOsebaIdx] of TOseba ;

    iter, varMark: Cardinal ;

    function osebaNaDMI( dmi: TDMI ; d: TDanIdx ; o: TOsebaIdx ) : boolean ;
    // vrne true ce je oseba o v OsebeNaDMI[dmi,d].list
    function DelOsebaNaDMI( dmi: TDMI ; d: TDanIdx ; o: TOsebaIdx ) : boolean ;
    function skupDelMin( min: smallint ): smallint ;
    function skupDelDni( d: smallint ): smallint ;

    function initOsebeNaDMI2( var oList: TOsebeList; lIdx: TOsebaIdx; d: TDanIdx ): boolean ;
    function preveriVzorec( d: TDanIdx; o: TOsebaIdx; vv: TVrstaVzorca ): boolean ;

    procedure undoPribijDMIVal  ;
    function propPribijDMIVal( dmi: TDMI; d: TDanIdx; o: TOsebaIdx ): boolean ;
    function propReduceDMIVal( dmi: TDMI; d: TDanIdx; o: TOsebaIdx ): boolean ;
    function propReduceKritNOk( d: TDanIdx; o: TOsebaIdx ): boolean ;
    // zbrise iz DMIVals[d,o] vse dmi ki krsijo kriterije in propagira spremembe s propReduceDMIVal
    function mozniDMIVzorca(vvDMI: TVrstaVzorca; d: TDanIdx; o: TOsebaIdx; var mDMI: TSmallIntArray) : boolean ;
    function dolociMestaVzorca(var oList: TOsebeList; fIdx, lIdx: TOsebaIdx; d: TDanIdx): boolean ;
    function oceniVzorceOsebe(o: TOsebaIdx; d: TDanIdx; vrVzorcev: TVrstniRedVzorcev ): smallint ;
    function canInsertDMI(d: TDanIdx; o: TOsebaIdx; dmi: TDMI ): boolean ;
    function canSwap(d: TDanIdx; o1, o2: TOsebaIdx ): boolean ;
    function popraviKritNOk(d: TDanIdx; sk: smallint ): boolean ;
    function sortOsebe(var oList: TOsebeList; lIdx: TOsebaIdx; d: TDanIdx): boolean ;
    procedure sortOsebePoMix(var oList: TOsebeList; fIdx, lIdx: TOsebaIdx; d: TDanIdx) ;
    procedure sortOsebePoUrah(var oList: TOsebeList; fIdx, lIdx: TOsebaIdx; d: TDanIdx) ;
    function razporediNeodvDnevi(oList: TOsebeList; lIdx: TOsebaIdx; d, doDne: TDanIdx) : boolean ;
    function razporediDan(oList: TOsebeList; lIdx: TOsebaIdx; d: TDanIdx) : boolean ;
    function razSkupino(oList: TOsebeList; lIdx: TOsebaIdx; d: TDanIdx) : boolean ;
    function razOsebeSkupine(var oList: TOsebeList; fIdx, lIdx: TOsebaIdx; d: TDanIdx) : boolean ;

    procedure postaviDMIValsOut( var DMIVals: TDMIVals );
    procedure popraviOsebeNaDMI( d: TDanIdx; o: TOsebaIdx; var newDMIVals: TDMIValsEl ) ;
  protected
    StartTime: LongWord ;
  public
    DMIVals: TDMIVals ;
    DMIValsOut: TDMIValsOut  ;
    Status: smallint ;
    PREVERI_PRIH_KRIT: boolean ;
    popravljajKrsenja: boolean ;
    FastAndSloppy: boolean ;
    VrstaSortaOseb: smallint ;
    stMinVSkupini, stDniVSkupini: smallint ;
    procedure wrtRazpored(oList: TOsebeList; lIdx: TOsebaIdx ) ;
    procedure izpisiDMI ;
    constructor Create ;
    procedure prepare ;
    function solve : boolean ;
    //function solveBrezSkupin: boolean ;
    procedure settings ; virtual ;
    function krsitveKrit( var krsitve: TkrsitveKrit ): integer ;
  end ;  {TRazSolve}


  TDMIValsElPlus = record
    mark: Cardinal;
    d: TDanIdx ;
    o: TOsebaIdx ;
    el: TDMIValsEl ;
    vKrit: TKritValList ;    // vrednosti kriterijev za osebo
  end ;


  TDMIValsStore = class
  private
    sto: array[1..MxStore] of TDMIValsElPlus ;
    function lastMark: Cardinal;
  public
    last: integer ;
    constructor Create ;
    procedure clear ;
    function put( mark: Cardinal; d: TDanIdx; o: TOsebaIdx; var DMIValsEl: TDMIValsEl; var vK: TKritValList ): boolean ;
    function restore( mark: Cardinal; var DMIVals: TDMIVals; var sel: TRazSolve ): boolean ;
  end ;


implementation


// *******
// ******* class TDMIValsStore

constructor TDMIValsStore.Create ;
begin
  last := 0 ;
end ;  {Create}


function TDMIValsStore.lastMark: Cardinal;
begin
  lastMark := sto[last].mark ;
end ;

procedure TDMIValsStore.clear ;
begin
  last := 0 ;
end ; {clear}

function TDMIValsStore.put( mark: Cardinal; d: TDanIdx; o: TOsebaIdx; var DMIValsEl: TDMIValsEl; var vK: TKritValList ): boolean ;
begin
  last := last + 1 ;
  Result := true ;
  if last > MxStore then
    Result := false
  else begin
    sto[last].mark := mark ;
    sto[last].d := d ;
    sto[last].o := o ;
    sto[last].el := DMIValsEl ;
    sto[last].vKrit := vK ;
    //  msg( 'Put: mark='+IntToStr(mark)+' d='+IntToStr(d)+'  o='+IntToStr(o) ) ;
  end ;
end ;  {put}


function TDMIValsStore.restore( mark: Cardinal; var DMIVals: TDMIVals; var sel: TRazSolve): boolean ;
var
  i: integer ;
  d: TDanIdx;
  o: TOsebaIdx;
  vv: TVrstaVzorca ;
begin
// ce (store[last].mark < mark) je bil v propPribitDMI DMI ze ustrezno pribit in
// smo povecali varMar, store[last].mark pa ne
  restore := false ;
  if (last = 0) or (sto[last].mark < mark) then
    exit ;
  if (sto[last].mark > mark) then begin
    sel.MsgHalt( 'TDMIValsStore.restore: zadnji dodani > varMatk',4, -1, -1 ) ;
    exit ;
  end ;
  i := last ;
  while (i > 0) and (sto[i].mark = mark) do begin
    d := sto[i].d ; o := sto[i].o ;
    if (DMIVals[d, o].nVals=1) and (sto[i].el.nVals<>1) then begin
      vv := sel.VrstaVzDMI(DMIVals[d, o].Vals[1]) ;
      sel.osebe[o].nePribiti := sel.osebe[o].nePribiti + 1 ;
      sel.nProstihMest[d,vv] := sel.nProstihMest[d,vv] + 1 ;
      sel.nMoznihOseb[d,vv] := sel.nMoznihOseb[d,vv] + 1 ;
      if vv <> 0 then // brisemo ze razporejen delovni dan (predpostavlja da oseba ni bila fiksirana)
        sel.osebe[o].delovni := sel.osebe[o].delovni - 1 ;
    end ;
    sel.osebe[o].vKrit := sto[i].vKrit ;
    // popravi se osebeNaDMI
    sel.popraviOsebeNaDMI( d, o, sto[i].el ) ;
    DMIVals[d, o] := sto[i].el ;
    i := i - 1 ;
  end ;
  last := i ;
  restore := true ;
end ;  {restore}

// *******
// ******* class TRazSolve


procedure TRazSolve.wrtRazpored(oList: TOsebeList; lIdx: TOsebaIdx ) ;
var
  o, k: TOsebaIdx ;
  i: smallint ;
  s: String ;
begin
  for k := 1 to lIdx do begin
     o := oList[k] ;
  s := '' ;
  for i := 1 to nDni do begin
     s := s + ' '+IntToStr(DMIVals[i,o].vals[1]);
     if DMIVals[i,o].nVals <> 1 then
       s := s + '*' ;
     if DMIVals[i,o].vals[1] < 10 then
       s := s + '  ' ;
     if i mod 10 = 0 then
       s := s + '    ' ;
  end ;
  s := s + ' * o' + intToStr(o) ;
  msg(s) ;
  end ;
end ;  {wrtRazpored}

procedure TRazSolve.izpisiDMI;
var
  oList: TOsebeList ;
  //i: smallint; // BUG do 8.6.2007
  i: smallint;
begin
  wrtKrit ;
  for i := 1 to nOseb do
    oList[i] := i ;
  msg( '**********   RESITEV  **********  iter= '+IntToStr(iter)  ) ;
  wrtRazpored(oList, nOseb) ;
end ;  {izpisiDMI}


function TRazSolve.DelOsebaNaDMI( dmi: TDMI ; d: TDanIdx ; o: TOsebaIdx ) : boolean ;
// iz OsebeNaDMI[dmi,d] zbrise oseb o
var
  dmiListIdx: 1..MxDMIList ;
begin
  for dmiListIdx := 1 to OsebeNaDMI[dmi,d].last do
     if OsebeNaDMI[dmi,d].list[dmiListIdx] = o then begin
       OsebeNaDMI[dmi,d].list[dmiListIdx] := OsebeNaDMI[dmi,d].list[OsebeNaDMI[dmi,d].last] ;
       OsebeNaDMI[dmi,d].last := OsebeNaDMI[dmi,d].last - 1 ;
       DelOsebaNaDMI := true ;
       exit ;
     end ;
  DelOsebaNaDMI := false ;
end ;  {DelOsebaNaDMI}


function TRazSolve.osebaNaDMI( dmi: TDMI ; d: TDanIdx ; o: TOsebaIdx ) : boolean ;
// vrne true ce je oseba o v OsebeNaDMI[dmi,d].list
var
  dmiListIdx: 1..MxDMIList ;
begin
  osebaNaDMI := true ;
  for dmiListIdx := 1 to OsebeNaDMI[dmi,d].last do
    if OsebeNaDMI[dmi,d].list[dmiListIdx] = o then
      exit ;
  osebaNaDMI := false ;
end ;  {osebaNaDMI}


function TRazSolve.skupDelMin( min: smallint ): smallint ;
// vrne skupino glede na opravljene delovne minute
begin
  Result := 1 + min div stMinVSkupini ;
end ;  {skupDelMin}

function TRazSolve.skupDelDni( d: smallint ): smallint ;
// vrne skupino glede na opravljene delovne dni
begin
  Result := 1 + d div StDniVSkupini ;
end ;  {skupDelDni}


constructor TRazSolve.Create ;
begin
  inherited Create ;
  store := TDMIValsStore.Create ;
  mozniDMI := TSmIntRealPairArray.Create(High(TDMIList)) ;
  poDanSkupinah := true ;  // za F5 = po locenih skupinah vsak dan
  stDniVSkupini := 5 ;  // dela ok  -Arm2006
  stMinVSkupini := 35*UraMinut ;  // ustreza 4 do 6 del.dnem - dela dobro, Arm2007
  VrstaSortaOseb := 2 ;  // sortOsebePoUrah(oList, fIdx, lIdx, d) ;
  popravljajKrsenja := true ;
  PREVERI_PRIH_KRIT := true ;  // tudi dobro po 14.2., celo malo bolje
  FastAndSloppy := true ;  // ce true potem omeji st.resitev; lahko hitreje ce resitev ne obstaja
end ;  {TRazSolve.Create}

procedure TRazSolve.settings ;
begin
end ;

procedure TRazSolve.prepare ;
// pripravi vse za sestavljanje razporeda in se klice pred sestavljanjem razporeda
var
  d: TDanIdx;
  sk: smallint ;
  oList: TOsebeList ;
  lIdx: TOsebaIdx ;
begin
  Status := -1 ;
  settings ; // override - spremeni nastavitve
  initProblem ;
  DMIVals := DMIValsInitial ;
  for d := 1 to nDni do begin
    povezaneOsebeDne( DMIVals, d ) ;
    for sk := 1 to stSk[d] do begin
      getOsebeSkupine( d, sk, oList, lIdx ) ;
    end ;
  end ;
  if (VrstaSortaOseb > 1) and not krit[PUrMesecMx].enabled then
    MsgHalt( 'PUrMesecMx mora biti omogocen da se uporablja za enakomerno razporeditev', 2, -1, -1) ;
  wrtKrit ;
  oceneOseb := TSmIntRealPairArray.Create(nOseb) ;
  varMark := 0 ;
  (store as TDMIValsStore).last := 0 ;  // ne dovolimo undo fiksiranja oseb
  iter := 0 ;
end ;  {TRazSolve.prepare}


procedure TRazSolve.postaviDMIValsOut( var DMIVals: TDMIVals );
// prepise trenutni razpored (v DMIVals) v DMIValsOut
var
  d: TDanIdx ;
  o: TOsebaIdx ;
begin
  for d := 1 to MxDnevi do
    for o := 1 to MxOseb do
      DMIValsOut[d,o] := DMIVals[d,o].Vals[1] ;
end ;  {postaviDMIValsOut}

function TRazSolve.initOsebeNaDMI2( var oList: TOsebeList; lIdx: TOsebaIdx; d: TDanIdx ): boolean ;
// priredi v vse OsebeNaDmi[dmi,d] vse tist osebe, ki lahko delajo na dmi
// v vsak osebeNaDMI[dmi,d] vstavimo osebe, ki imajo dmi v svoj DMIVals[d,o]
// in ki imajo stDMIvDP(dmi, d) > 0 (druge osebe se niso fiksirane na ta dmi)
// vrne false ce resitev brez krsenja kriterijev ne obstaja
var
  o, k: TOsebaIdx;
  dmi: TDMI ;
  dmiListIdx: TDMIListIdx ;
  vv: TVrstaVzorca ;
  dmiSkup: TDMISet ;
  stDMSkup: integer ;
begin
  Result := True ;
  stDMSkup := 0 ;
  // na dmi=0 mora biti mora biti vedno tocno nOseb - st.vseh prostih mest
  osebeNaDMI[0,d].last := 0 ;
  osebeNaDMI[0,d].pMest := lIdx ;
  dmiSkup := dmiSk[d, skOseb[d, oList[1]]] ;
  for dmi := 1 to nDMI do begin
    if not (dmi in dmiSkup) then
      continue ;
    osebeNaDMI[dmi,d].last := 0 ;
    osebeNaDMI[dmi,d].pMest := stDMIvDP(dmi, d) ;
    stDMSkup := stDMSkup + osebeNaDMI[dmi,d].pMest ;
    osebeNaDMI[0,d].pMest := osebeNaDMI[0,d].pMest - osebeNaDMI[dmi,d].pMest ;
  end ;
  if stDMSkup > lIdx then
    MsgHalt('Premalo oseb za izvajanje dela dne '+IntToStr(d), 3, d, -1) ;
  for k := 1 to lIdx do begin
    o := oList[k] ;
    if DMIVals[d,o].nVals=1 then begin  // uredimo tudi DDMIje z eno samo vrednostjo
      dmi := DMIVals[d,o].Vals[1] ;
      if not (dmi in dmiSkup) then MsgHalt('Nemogoce',0, d, o ) ;
      osebe[o].nePribiti := osebe[o].nePribiti - 1 ;
      if VrstaVzDMI(dmi) <> 0 then
        osebe[o].delovni := osebe[o].delovni + 1 ;
      osebeNaDMI[dmi,d].pMest := osebeNaDMI[dmi,d].pMest - 1 ;
      updateKrit( d, o, dmi ) ;
      if not kritOK( o ) then begin
         msg('Pribita oseba '+IntToStr(o)+' ne izpolnjuje kriterijev: na DMI '+IntToStr(dmi)+' dne d'+IntToStr(d)) ;
        Result := False ;
        exit ;
      end ;
      if OsebeNaDMI[dmi,d].pMest < 0 then begin
        msg('Prevec oseb na DMI '+IntToStr(dmi)+' dne d'+IntToStr(d)) ;
        Result := False ;
        exit ;
      end ;
    end else begin
      for dmiListIdx := 1 to DMIVals[d,o].nVals do begin
        dmi := DMIVals[d,o].Vals[dmiListIdx] ;
        if not (dmi in dmiSkup) then MsgHalt('Nemogoce',0, d, o ) ;
        osebeNaDMI[dmi,d].last := osebeNaDMI[dmi,d].last + 1 ;
        osebeNaDMI[dmi,d].list[osebeNaDMI[dmi,d].last] := o ;
      end ;
    end ;
  end ;
  for vv := 0 to MxVrstVzorcev do
    nProstihMest[d,vv] := 0 ;
  for dmi := 0 to nDMI do begin
    if not (dmi in dmiSkup) then
      continue ;
    vv := VrstaVzDMI(dmi) ;
    nProstihMest[d,vv] := nProstihMest[d,vv] + osebeNaDMI[dmi,d].pMest ;
    if (dmi > 0) and (osebeNaDMI[dmi,d].pMest > osebeNaDMI[dmi,d].last) then begin
      //msg('Premalo oseb za izvajanje dela na DMI '+IntToStr(dmi)+' dne '+IntToStr(d)) ;
      MsgHalt('Premalo oseb za izvajanje dela na DMI '+IntToStr(dmi)+' dne '+IntToStr(d), 3, d, dmi) ;
      Result := False ; exit ;
    end ;
  end ;
end ;  {initOsebeNaDMI2}


procedure TRazSolve.popraviOsebeNaDMI( d: TDanIdx; o: TOsebaIdx; var newDMIVals: TDMIValsEl ) ;
// popravi osebeNaDMI ce se DMIVals poveca v NewDMIVals (po restore, oz undoPribij)
// domena DMIVals je manjsa od newDMIVals (v osebeNaDMI moramo dodati prej brisane osebe)
var
  dmi: TDMI ;
  dmiListIdx: TDMIListIdx ;
begin
  // za vse dmi iz newDMIVals vstavi osebo v osebeNaDmi
  for dmiListIdx := 1 to newDMIVals.nVals do begin
    dmi := newDMIVals.Vals[dmiListIdx] ;
    if not osebaNaDMI( dmi, d, o ) then begin
      osebeNaDMI[dmi,d].last := osebeNaDMI[dmi,d].last + 1 ;
      osebeNaDMI[dmi,d].list[osebeNaDMI[dmi,d].last] := o ;
    end ;
  end ;
  if newDMIVals.nVals=1 then begin// oseba fiksirana
    MsgHalt( 'Pribita Oseba v Store',0, d, o ) ;
  end else begin  // newDMIVals[d, o] ni pribit
    // ce se pribit DMIVals spremeni v nepribit NewDMIVals se sproti eno delovno mesto na dmi
    if DMIVals[d, o].nVals=1 then begin
      dmi := DMIVals[d, o].Vals[1] ;
      osebeNaDMI[dmi,d].pMest := osebeNaDMI[dmi,d].pMest + 1 ; // eno delovno mesto na dmi vec
    end ;
  end ;
end ;  {popraviOsebeNaDMI}


function TRazSolve.propReduceKritNOk( d: TDanIdx; o: TOsebaIdx ): boolean ;
// zbrise iz DMIVals[d,o] vse dmi ki krsijo kriterije in propagira spremembe s propReduceDMIVal
var
  dmi: TDMI ;
  dmiListIdx: TDMIListIdx ;
  tmpvKrit: TKritValList ;    // vrednosti kriterijev za osebo
  dmiKrsiKrit: boolean ;
begin
  if sprosceniKrit then begin
    Result := true ; exit ;
  end ;
  Result := false ;
  // za vse mozne dmi preveri ce pribitje na dmi krsi kaksen kriterije v naslednjih dneh
  for dmiListIdx := 1 to DMIVals[d,o].nVals do begin
    dmi := DMIVals[d,o].Vals[dmiListIdx] ;
    dmiKrsiKrit := false ;
    if not newKritOK( d, o, dmi ) then // ali dmi krsi kriterij dne d
      dmiKrsiKrit := true
    else if PREVERI_PRIH_KRIT then begin 
      // preverim ce dmi krsi kriterije prihodnjih dni
      tmpvKrit := osebe[o].vKrit ;
      updateKrit( d, o, dmi ) ;
      dmiKrsiKrit := not prihKritOK( d, o, DMIVals ) ;
      osebe[o].vKrit := tmpvKrit ; // vrnem stare kriterije
     end ;
    if dmiKrsiKrit then begin  // ce dmi krsi nek krierij ga zbrisem iz DMIVals[d,o]
      if not propReduceDMIVal( dmi, d, o ) then begin
        //msg('propReduceDMIVal' ) ;
        exit ;
      end ;  
    end ;
  end ;
  Result := true ;
end ;  {propReduceKritNOk}


function TRazSolve.propReduceDMIVal( dmi: TDMI; d: TDanIdx; o: TOsebaIdx ): boolean ;
begin
  propReduceDMIVal := false ;
  if (DMIVals[d,o].nVals=1) and (DMIVals[d,o].Vals[1] = dmi) then begin
    //msg('propReduceDMIVal: dmi '+IntToStr(dmi)+' ze pribit na brisano vrednost!' ) ;
    exit ;
  end ;
  // if dmi = 0 then MsgHalt( 'propReduceDMIVal: Brisanje dmi=0',0 ) ;
  if not osebaNaDMI( dmi, d, o ) then begin // dmi smo ze prej pobrisali, ali osebo fiksirali na drug dmi
    // msg( 'propReduceDMIVal: OK, vrednost dmi ze prej zbrisana' ) ;
    propReduceDMIVal := true ;
    exit
  end ;
  if dmiVals[d, o].nVals = 1 then // po brisanju dmi prazna domena
    exit ;
  if osebeNaDMI[dmi,d].last <= osebeNaDMI[dmi,d].pMest then // premalo oseb po brisanju tega dmi
    exit ;
  if dmiVals[d, o].nVals = 2 then begin  // pribijemo na drug dmi
    if dmi = dmiVals[d, o].Vals[1] then
      propReduceDMIVal := propPribijDMIVal( dmiVals[d, o].Vals[2], d, o )
    else propReduceDMIVal := propPribijDMIVal( dmiVals[d, o].Vals[1], d, o ) ;
    exit ;
  end ;
  if not (store as TDMIValsStore).put( varMark, d, o, DMIVals[d,o], osebe[o].vKrit ) then
    MsgHalt( 'Povecaj const MxStore; Prevec dodanih elementov',4, d, o ) ;
  delDMIVal( dmi, DMIVals[d, o] ) ;
  DelOsebaNaDMI( dmi, d, o ) ;
  propReduceDMIVal := true ;
end ;  {TRazSolve.propReduceDMIVal}


function TRazSolve.propPribijDMIVal( dmi: TDMI; d: TDanIdx; o: TOsebaIdx ): boolean ;
var
  dmi1: TDMI ;
  i, oIstiDMI: TOsebaIdx ;
  pDMIVals: TDMIList ;
  pOsebeNaDMI: TOsebeNaDMIEl ;
  vv, vv1: TVrstaVzorca ;
begin
  propPribijDMIVal := false ;
  for dmi1 := 0 to nDMI do  // ali je na preostalih dmi1 dovolj oseb da zapolnejo vsa prosta mesta
    if (dmi1 <> dmi) and osebaNaDMI( dmi1, d, o ) then begin
      if osebeNaDMI[dmi1, d].last - 1 < osebeNaDMI[dmi1, d].pMest then
        exit ;
  end ;
  if (DMIVals[d,o].nVals=1) then begin // ze prej pribit DMI
    if DMIVals[d,o].Vals[1] <> dmi then
      MsgHalt('propPribijDMIVal: pribijanje na za pribit dmi '+IntToStr(dmi),0, d, o )
    else propPribijDMIVal := true ;
    exit ;
  end ;
  if not newKritOK( d, o, dmi ) then begin// ali pribijanje krsi kriterije
    //msg( 'PropPrbijDMIVal: not newKritOK d='+IntToStr(d)+'  o='+IntToStr(o) ) ;
    exit ;
  end ;
  vv := VrstaVzDMI(dmi) ;
  if (DMIVals[d, o].nVrsteVz[vv]<=0) then
    MsgHalt( 'propPribij: nVrsteVz[vv]<=0',0, d, o) ;
  pDMIVals := DMIVals[d, o].Vals ;
  pOsebeNaDMI := osebeNaDMI[dmi,d] ;
  if not (store as TDMIValsStore).put( varMark, d, o, DMIVals[d,o], osebe[o].vKrit ) then
    MsgHalt( 'Povecaj const MxStore; Prevec dodanih elementov',4, d, o ) ;
  updateKrit( d, o, dmi) ;
  for vv1 := 0 to MxVrstVzorcev do
    DMIVals[d, o].nVrsteVz[vv1] := 0 ;
  DMIVals[d, o].nVrsteVz[vv] := 1 ;
  osebe[o].nePribiti := osebe[o].nePribiti - 1 ;
  nProstihMest[d,vv] := nProstihMest[d,vv] - 1 ;
  nMoznihOseb[d,vv] := nMoznihOseb[d,vv] - 1 ;
  if vv <> 0 then
    osebe[o].delovni := osebe[o].delovni + 1 ;
  DMIVals[d,o].nVals := 1 ;
  DMIVals[d,o].Vals[1] := dmi ;
  osebeNaDMI[dmi, d].pMest := osebeNaDMI[dmi, d].pMest - 1 ;
  for dmi1 := 0 to nDMI do
    if DelOsebaNaDMI( dmi1, d, o ) then begin  // zbrisemo o iz vseh drugih OsebeNaDMI[dmi1,dF]
      if osebeNaDMI[dmi1, d].last < osebeNaDMI[dmi1, d].pMest then // premalo oseb za dmi1
        exit ;
      // moramo najbrz se naprej propagirati?
    end ;
  if (osebeNaDMI[dmi, d].pMest = 0) then begin
    // vsem osebam, ki so lahko delale na tem dmi, zbrisemo dmi iz njihove domene, ter propagiramo
    for i := 1 to pOsebeNaDMI.last do begin
      oIstiDMI := pOsebeNaDMI.list[i] ;
      if (oIstiDMI <> o) and not propReduceDMIVal( dmi, d, oIstiDMI ) then
        exit ;
    end ;
  end ;
  propPribijDMIVal := true ;
  if (osebeNaDMI[dmi, d].pMest = 1) and (osebeNaDMI[dmi,d].last = 1) then
    propPribijDMIVal := propPribijDMIVal( dmi, d, osebeNaDMI[dmi,d].list[osebeNaDMI[dmi,d].last]) ;
end ;  {TRazSolve.propPribijDMIVal}


procedure TRazSolve.undoPribijDMIVal ;
// prekilce pribitje osebe na dmi in naredi vse potrebno: poveca st. prostih mest, in
// nalozi staro domeno domeno dmi iz storea
begin
   (store as TDMIValsStore).restore( varMark, DMIVals, Self ) ;
   varMark := varMark - 1 ;
//   msg('undo: varMArk='+IntToStr(VarMArk) ) ;
end ;  {undoPribijDMIVal}


function TRazSolve.canInsertDMI(d: TDanIdx; o: TOsebaIdx; dmi: TDMI ): boolean ;
// preveri ce vstavitev dmi na DMIVals[d,o] ne krsi kriterij PDanPocitek s prejsnjim
// in naslednjim dnem; preveri tudi PZapDniTedenMx
var
  v1, v2, vMx1, vMx2, minUr: TKritVal ;
  dc, dS: TDanIdx ;
  oneOK: boolean ;
  dmiListIdx: TDMIListIdx ;
  dSstart: smallint ;  
begin
  Result := true ;
  if dmi = 0 then  // prost dan lahko vedno vstavimo
    exit ;
  if not (krit[PDanPocitek].enabled) and (not krit[PZapUrTedenMx].enabled) and (not krit[PZapDniTedenMx].enabled) then
    exit ;
  if krit[PZapUrTedenMx].enabled or krit[PZapDniTedenMx].enabled then begin
    // meri najdaljso sekvenco 7 zaporednih dni zacensi z d-6
    vMx1 := 0 ; vMx2 := 0 ;  // mx. ure in mx.del.dnevi
    dSstart := d-6 ;
    for dS := MaxInt( 1, dSstart ) to d do begin  // dS je zacetek sekvence dolz. 7
      v1 := DMIList[dmi].ur ; // stejemo trajanje vstavljnega dmija
      v2 := 1 ; // en dan za vstavljneni dmi (zgoraj preverimo ce dmi<>prosto)
      for dc := dS to MinInt( nDni, dS+6 ) do begin // max 7 zaporednih dni
        if dc = d then // dmi dne d smo ze steli v v
          continue ;
        minUr := High(TKritVal) ;  // dolocimo najkrajsi izmed moznih dmi
        oneOK := true ;
        for dmiListIdx := 1 to DMIVals[dc,o].nVals do begin
          minUr := MinInt( minUr, DMIList[DMIVals[dc,o].Vals[dmiListIdx]].ur ) ;
          oneOK := oneOK and (DMIVals[dc,o].Vals[dmiListIdx] <> 0) ; // true ce so vsi dmi<>prosto
        end ;
        if oneOK then begin // sigurno je del.dan
          v1 := v1 + minUr ;  // steje vsoto najkrajsih dmijev
          vMx1 := MaxInt( vMx1, v1 ) ;
          v2 := v2 + 1 ;  //  steje del.dneve
          vMx2 := MaxInt( vMx2, v2 ) ;
        end else break ;
      end ;  
    end ;
    Result := Result and valOK( vMx1, PZapUrTedenMx ) ;
    Result := Result and valOK( vMx2, PZapDniTedenMx ) ;  // prej napaka
  end ;
  if krit[PDanPocitek].enabled then begin
    if d > 1 then begin
      if DMIVals[d-1,o].nVals > 1 then
        MsgHalt( 'canInsert: Nemogoce',0, d, o ) ;
      Result := Result and checkKritDanPocitek(DMIVals[d-1,o].Vals[1], dmi) ;
    end ;
    if d < nDni then begin
      oneOK := false ;
      for dmiListIdx := 1 to DMIVals[d+1,o].nVals do
        if checkKritDanPocitek(dmi, DMIVals[d+1,o].Vals[dmiListIdx]) then begin
          oneOK := true ; break ;
        end ;
      Result := Result and oneOK ;
    end ;
  end ;
end ;  {canInsertDMI}


function TRazSolve.canSwap(d: TDanIdx; o1, o2: TOsebaIdx ): boolean ;
// true ce lahko zamenjamo dmi-ja ze razporejenih oseb o1 in o2 
// smiselno preverjati le ce sta o1 in o2 v isti skupini
var
  dmi1, dmi2: TDMI ;
  dmiListIdx: TDMIListIdx ;
  ok, danPocitekEnabled, ZapUrTedenMxEnabled, ZapDniTedenMxEnabled: boolean ;
  i: TTipKriterija ;
  tKritEnabled: array[TTipKriterija] of boolean ;
begin
  Result := false ;
  dmi1 := DMIVals[d,o1].Vals[1] ; dmi2 := DMIVals[d,o2].Vals[1] ;
  if dmi1=dmi2 then // nesmislena menjava
    exit ;
  if (dmi1 = 0) or (DMIVals[d,o1].nVals+DMIVals[d,o2].nVals>2) then
    MsgHalt('canSwap: Nemogoce',0, d, o1 ) ;
  if sprosceniKrit then
    MsgHalt('canSwap: Nemogoce',0, d, o1 ) ;
  // preverim ce lahko o2 dela na dmi1 in o1 na dmi2
  ok := false ; 
  for dmiListIdx := 1 to DMIValsInitial[d,o2].nVals do
    if dmi1 = DMIValsInitial[d,o2].Vals[dmiListIdx] then begin
      ok := true ; break ;
    end ;
  if not ok then exit ;
  ok := false ;
  for dmiListIdx := 1 to DMIValsInitial[d,o1].nVals do
    if dmi2 = DMIValsInitial[d,o1].Vals[dmiListIdx] then begin
      ok := true ; break ;
    end ;
  if not ok then exit ;
  ok := canInsertDMI( d, o2, dmi1) and canInsertDMI( d, o1, dmi2) ;
  if not ok then exit ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do
    tKritEnabled[i] := krit[i].enabled ;
  krit[PDanPocitek].enabled := false ;  // onemogoci kriterij PDanPocitek
  krit[PZapDniTedenMx].enabled := false ;
  krit[PZapUrTedenMx].enabled := false ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do begin
    if not valOK( osebe[o1].vKrit[i], i ) then // onemogocim kriterij ki je krsen ze pred menjavo
      krit[i].enabled := false ;
    if not valOK( osebe[o2].vKrit[i], i ) then // onemogocim kriterij ki je krsen ze pred menjavo
      krit[i].enabled := false ;
  end ;
  if newKritOK(d, o2, dmi1) and newKritOK(d, o1, dmi2) then // odoborim menjavo
    Result := true ;
  for i := Low(TTipKriterija) to High(TTipKriterija) do 
    krit[i].enabled := tKritEnabled[i] ;
end ;  {canSwap}


function TRazSolve.popraviKritNOk(d: TDanIdx; sk: smallint ): boolean ;
// popravi krsenje krit. oseb iz skupine sk dne d, z menjavami oseb v prejsnjih dneh
// za vsako osebo o1 iz skupine sk, ki krsi kriterije in za vse prejsnje dneve pd
// poskusaj o1 zamenjati z osebo o2, ki je v isti skupini kot o1 dne pd
var
  pd: TDanIdx ;
  oList: TOsebeList;
  lIdx, lIdxPd, k, o1, o2: TOsebaIdx;
  vsajEnoKrsenje, okip, okiNPVkd, prihOK: boolean ;
  ds: TDanIdx ;
  dmi1, dmi2: TDMI ;
  kk: smallint ;
  dsstart: smallint ;
begin
  Result := false ;
  vsajEnoKrsenje:= false ;
  getOsebeSkupine( d, sk, oList, lIdx ) ;
  //if d > 29 then
  //  msg('30') ;
  for k := 1 to lIdx do begin
    o1 := oList[k] ;  // izbere osebo o1 s krsenim krierijem
    if kritOk( o1 ) then
      continue
    else vsajEnoKrsenje:= true ;
    okip := kritOKIgnorePocitek( o1 ) ; // popravim le prej. dan ce je le krsenje PDanPocitek
    okiNPVkd := kritOKIgnoreNPVkd(o1 ) ; // popravim le sob, ned, praznike ce krsenje le teh dni
    dsstart := d ; dsstart := dsstart-vplivDniKritOsebe(o1) ;  // prepreci underflow
    ds := MaxInt(1, dsstart ) ;
    for pd := d downto ds do begin  // za trenutni dan in vse prejsnje dni pd
      if okiNPVkd and not (DP[pd].tipDne in [sob,ned,pra]) then
        continue ;
      if (DMIVals[pd,o1].Vals[1] = 0) or (DMIValsInitial[pd,o1].nVals = 1) then
        continue ;
       for o2 := 1 to nOseb do begin    
        if skOseb[pd, o2] <> skOseb[pd, o1] then
          continue ;
        // za vse o2, ki so v skupini z o1 dne pd
        if (o1 = o2) or (DMIValsInitial[pd,o2].nVals = 1) then // menjava ene in iste osebe
          continue ;
        dmi1 := DMIVals[pd,o1].Vals[1] ; dmi2 := DMIVals[pd,o2].Vals[1] ;
        // preveri ce menjava zmanjsa skupno st. krsenih kriterijev kk
        kk := nKrsKritNow(o1) + nKrsKritNow(o2) ;
        if okip then begin  // krsen le krit.pocitek; nujno da se dmi2 konca prej kot dmi1
          if DMIList[dmi2].zac + DMIList[dmi2].ur >= DMIList[dmi1].zac + DMIList[dmi1].ur then
            continue ;
        end ;
        if canSwap(pd, o1, o2) then begin  // o1 in o2 sta ze pribiti dne pd; o2 ni nujno pribita dne d
            DMIVals[pd, o1].Vals[1] := dmi2 ; DMIVals[pd, o2].Vals[1] := dmi1 ;
            recompAllKrit( d, o1, DMIVals ) ; recompAllKrit( d, o2, DMIVals ) ;
            // preveri ce o1 in o2 krsita gotove kriterije prihodnjih dni
            prihOK := true ;
            if PREVERI_PRIH_KRIT then 
              prihOK := prihKritOk(d, o1, DMIVals ) and prihKritOk(d, o2, DMIVals ) ;
            if (not prihOK) or (kk <= nKrsKritNow(o1) + nKrsKritNow(o2)) then begin  // naredi undo zamenjave
              DMIVals[pd, o1].Vals[1] := dmi1 ; DMIVals[pd, o2].Vals[1] := dmi2 ;
              recompAllKrit( d, o1, DMIVals ) ; recompAllKrit( d, o2, DMIVals ) ;
            end else begin
              msg( '-->  popraviKrsenjeKrit: d='+IntToStr(d)+'   pd='+IntToStr(pd)+':  SWAP  o'+IntToStr(o1)+
               '('+IntToStr(DMIVals[pd,o2].Vals[1])+')  with  o'+IntToStr(o2)+'('+IntToStr(DMIVals[pd,o1].Vals[1])+')' ) ;
              Result := true ; exit ;
            end ;
        end ;
      end ;  // za vse o2, ki so v skupini z o1 dne pd
    end ; // za vse prejsnje dni pd
  end ;
  if not vsajEnoKrsenje and sprosceniKrit then
    MsgHalt( 'Nemogoce: krit vseh oseb ok, d='+IntToStr(d),0, d, -1 ) ;
end ;  {popraviKritNOk}


function TRazSolve.dolociMestaVzorca(var oList: TOsebeList; fIdx, lIdx: TOsebaIdx; d: TDanIdx): boolean ;
// izracuna nMoznihOseb in nProstihMest
var
  o, oListIdx: TOsebaIdx ;
  vv: TVrstaVzorca ;
  dmi: TDMI ;
  n: smallint ;
  dmiSkup: TDMISet ;
begin
  Result := false ;
  for vv := 0 to MxVrstVzorcev do begin
    nProstihMest[d,vv] := 0 ;
    nMoznihOseb[d,vv] := 0 ;
  end ;
  dmiSkup := dmiSk[d, skOseb[d, oList[1]]] ;
  for dmi := 0 to nDMI do begin
    if not (dmi in dmiSkup) then
      continue ;
    vv := VrstaVzDMI(dmi) ;
    nProstihMest[d,vv] := nProstihMest[d,vv] + osebeNaDMI[dmi,d].pMest ;
  end ;
  for oListIdx := fIdx to lIdx do begin
    o := oList[oListIdx] ;
    n := 0 ;
    for vv := 0 to MxVrstVzorcev do begin
      if not preveriVzorec( d, o, vv ) then
        continue ;
      nMoznihOseb[d,vv] := nMoznihOseb[d,vv] + 1 ;
      n := n + 1 ;
    end ;
    if n = 0 then begin
      msg( 'oceniOsebeDne: nobenega moznega vzorca o'+IntToStr(o) ) ;
      exit ;
    end ;
  end ;
  // mora veljati: nProstihMest[0] := nOseb - vsehProstih ; // nOseb-vsehProstih ima ta dan prosto
  for vv := 0 to MxVrstVzorcev do begin
    if nMoznihOseb[d,vv] < nProstihMest[d,vv] then begin
      if not NOMSG then begin
        msg('Premalo razpolozljivih oseb - vzorca  '+IntToStr(vv)+'  ni mogoce razporediti dne '+IntToStr(d)) ;
      end ;
      exit ;  // vzorca ni mogoce razporediti - premalo oseb
    end ;
  end ;
  Result := true ;
end ;  {oceniOsebeDne}

function TRazSolve.preveriVzorec( d: TDanIdx; o: TOsebaIdx; vv: TVrstaVzorca ): boolean ;
// preveri ce izbira tega vzorca ne krsi nVrsteVz ali nProstihMest
begin
  Result := false ;
  if (DMIVals[d,o].nVals=1) then begin
    if VrstaVzDMI(DMIVals[d,o].Vals[1]) <> vv then
       exit ;
  end else begin
    if (DMIVals[d, o].nVrsteVz[vv]<=0) then
      exit ;
    if (nProstihMest[d,vv] < 1) then // vzorec ze zapolnjen
      exit ;
    if osebe[o].nePribiti <= 0 then begin // oseba ze popolnoma zasedene
      msg('PreveriVzorec: o'+IntToStr(o)+' ze popolnoma zasedena' ) ;
      exit ;
    end ;
  end ;
  Result := true ;
end ;  {preveriVzorec}


function TRazSolve.sortOsebe(var oList: TOsebeList; lIdx: TOsebaIdx; d: TDanIdx): boolean ;
// osebe sortira tako da so na zacetku oList tezje osebe oz. osebe ki so doslej delale manj
// vrne false ce oceniOsebeDne ne uspe
begin
  Result := dolociMestaVzorca( oList, 1, lIdx, d) ;
  if not Result then
    exit ;
  case VrstaSortaOseb of
    1: sortOsebePoMix(oList, 1, lIdx, d) ;  // Armorica 2006
    2: sortOsebePoUrah(oList, 1, lIdx, d) ;
    else MsgHalt('VrstaSortaOseb nepravilna',0, -1, -1 ) ;
  end ;
end ;  {sortOsebe}

procedure TRazSolve.sortOsebePoMix(var oList: TOsebeList; fIdx, lIdx: TOsebaIdx; d: TDanIdx) ;
// osebe sortira tako da so na zacetku oList osebe, ki imajo manj moznih vzorcev
// pribite osebe damo na zacetek seznama oseb
var
  o, i: TOsebaIdx ;
  vv: TVrstaVzorca ;
  prioriteta: real ;  // nizja prioriteta, prej osebo razporedimo
  nVz, nd, delDni : smallint ;
begin
  // tiste osebe, ki imajo zazeljenost 0 ali 1 so ze fiksirane na vzorec 0 oz. vzorec <>0
  oceneOseb.last := - 1 ;
  for i := fIdx to lIdx do begin
    o := oList[i] ;
    if (DMIVals[d,o].nVals=1) then begin
      prioriteta := 0 ;
    end else begin  // vzorec ni pribit
      nVz := 0 ; nd := 0 ;
      for vv := 0 to MxVrstVzorcev do
        if preveriVzorec( d, o, vv ) then begin
          nVz := nVz + 1 ;
          nd := nd + DMIVals[d,o].nVrsteVz[vv] ;  // stevilo dmijev tega vzorca vv
        end ;
      prioriteta := nVz ;  // prioriteta je stevilo moznih vzorcev osebe
      if nVz > 0 then begin // upostevamo tudi delovne dni: osebe z manj delovnimi dnevi razporedimo prej
        delDni := skupDelDni(osebe[o].delovni) ;
        prioriteta := 10 * delDni + prioriteta ;
      end ;
    end ;
    oceneOseb.Add(o, prioriteta ) ;
  end ;
  oceneOseb.SortByR ;
  for o := fIdx to lIdx do
    oList[o] := oceneOseb.a[o-fIdx] ;
end ;  {sortOsebePoMix}


procedure TRazSolve.sortOsebePoUrah(var oList: TOsebeList; fIdx, lIdx: TOsebaIdx; d: TDanIdx) ;
// osebe sortira tako da so na zacetku oList osebe, ki imajo manj moznih vzorcev
// pribite osebe damo na zacetek seznama oseb
var
  o, i: TOsebaIdx ;
  vv: TVrstaVzorca ;
  prioriteta: real ;  // nizja prioriteta, prej osebo razporedimo
  nVz, delUr : smallint ;
begin
  // tiste osebe, ki imajo zazeljenost 0 ali 1 so ze fiksirane na vzorec 0 oz. vzorec <>0
  oceneOseb.last := - 1 ;
  for i := fIdx to lIdx do begin
    o := oList[i] ;
    if (DMIVals[d,o].nVals=1) then begin
      prioriteta := 0 ;
    end else begin  // vzorec ni pribit
      nVz := 0 ;
      for vv := 0 to MxVrstVzorcev do
        if preveriVzorec( d, o, vv ) then
          nVz := nVz + 1 ;
      prioriteta := nVz ;  // prioriteta je stevilo moznih vzorcev osebe
      if nVz > 0 then begin // upostevamo tudi delovne dni: osebe z manj delovnimi dnevi razporedimo prej
        delUr := skupDelMin(PrenosMin[o]+osebe[o].vkrit[PUrMesecMx]) ;
        prioriteta := 10 * delUr + prioriteta ;
      end ;
    end ;
    oceneOseb.Add(o, prioriteta ) ;
  end ;
  oceneOseb.SortByR ;
  for o := fIdx to lIdx do
    oList[o] := oceneOseb.a[o-fIdx] ;
end ;  {sortOsebePoUrah}


function TRazSolve.mozniDMIVzorca(vvDMI: TVrstaVzorca; d: TDanIdx; o: TOsebaIdx; var mDMI: TSmallIntArray) : boolean ;
// za vse mozne vrednosti DMIjev vzorca vvDMI osebe o, dne d naredi forward checking in vrne
// seznam mozniDMI v katerih so mozne vrednosti DMIja, urejene po LCV hevristiki
// (najprej dmi z najvecjim st.prostih mest v DP in najmanj moznimi osebami);
// Ce je vednost dmi 0 (prosti dmi) v DMIVals[d,o] jo dodamo na konec mozniDMI
var
  dmi: TDMI ;
  vv: TVrstaVzorca ;
  i: integer ;
begin
  mozniDMI.last := -1 ;
  for i := 1 to DMIVals[d,o].nVals do begin // za vsem mozne DMI vzorca vvDMI, osebe o, dne d
    dmi := DMIVals[d,o].Vals[i] ;
    vv := VrstaVzDMI(dmi) ;
    if vv <> vvDMI then
      continue ;
    // preveri kateri dmi so mozni za osebo o glede na zakonske kriterije
    if (DMIVals[d,o].nVals > 1) and not newKritOK(d, o, dmi) then
      MsgHalt( 'NEMOGOCE???: mozniDMIVzorca: kriteriji krseni',0, d, o ) ;
    if dmi = 0 then begin
      mozniDMI.Add( dmi, 0 ) ;  // dmi=0 (prosto dodamo na konec seznama
    end else begin
      if (DMIVals[d, o].nVals=1) and (DMIVals[d, o].Vals[1] <> dmi) then
          MsgHalt('mozniDMIVzorca: dmi '+IntToStr(dmi)+' ze pribit!',3, d, o ) ;
      if (DMIVals[d, o].nVals<>1) and (osebeNaDMI[dmi, d].pMest = 0) then  // dmi ze popolnoma zaseden
        continue ;
      // nepotrebno; tudi propReduceDMIV preveri ce je premalo oseb da bi opravile ta dmi
      if OsebeNaDMI[dmi,d].last < osebeNaDMI[dmi, d].pMest then begin
        MsgHalt('MozniDMIVzorca: premalo razpolozljivih oseb dne '+IntToStr(d)+'  za dmi '+IntToStr(dmi),3, d, dmi ) ;
        continue ;
      end ;
      // najbolje najvecje st.prostih mest v DP in najmanjse st moznih oseb na tem dmi
      mozniDMI.Add( dmi, -1 * osebeNaDMI[dmi, d].pMest + 0.01 * OsebeNaDmi[dmi,d].last ) ;
    end ;
  end ;
  if mozniDMI.last >= 1 then begin
    mozniDMI.SortByR ;
  end ;
  Result := (mozniDMI.last >=0) ;
  if Result then begin  // prepisemo mozniDMI v mDMI
    SetLength(mDMI,mozniDMI.last+1) ;
    for i := 0 to Length(mDMI)-1 do
      mDMI[i] := mozniDMI.a[i] ;
  end ;
end ;  {mozniDMIVzorca}


function TRazSolve.oceniVzorceOsebe(o: TOsebaIdx; d: TDanIdx; vrVzorcev: TVrstniRedVzorcev ): smallint ;
// doloci prioriteto oseb na vzorcih tega dne za vse osebe oList[fIdx..lIdx]
// ce je vecja zazeljenost, bo vzorec izbran prej
// vrne stevilo primernih vzorcev osebe
var
  vv: TVrstaVzorca ;
  zazeljenost: real ;
  Dmin: real ; // max. st.del.dni osebe
begin
  Result := -1 ;
  for vv := 0 to MxVrstVzorcev do begin
    vrVzorcev[o].a[vv] := vv;
    vrVzorcev[o].r[vv] := 0;
    if nMoznihOseb[d,vv] < nProstihMest[d,vv] then begin
      if not NOMSG then begin
        error('Premalo razpolozljivih oseb - vzorca  '+IntToStr(vv)+'  ni mogoce razporediti dne '+IntToStr(d)) ;
      end ;
      exit ;  // vzorca ni mogoce razporediti - premalo oseb
    end ;
    if not preveriVzorec( d, o, vv ) then
      continue ;
    Dmin := 0.8 * nDni ;  
      // preverimo ce je mozen vzorec naslednjega dne
      if (DMIVals[d,o].nVals=1) and (VrstaVzDMI(DMIVals[d,o].Vals[1])=vv) then
        zazeljenost := 50
      else begin  // vzorec ni pribit
        if vv=0 then begin
          // zazeljenost prostega dne = kolikor dni manjka do tega da bi dosegli nDni-Dmin prostih dni
          zazeljenost := max( 1, nDni-Dmin - osebe[o].delovni ) ;
        end else begin
          // zazeljenost delovnega dne = kolikor dni manjka da bi dosegli Dmin delovnih dni
          zazeljenost := max( 1, (Dmin - osebe[o].delovni) )  ;
          if nProstihMest[d,vv] > 0 then begin // oseba ima raje vzorec na katerem je manj moznih oseb
            zazeljenost := zazeljenost + 0.3 - 0.1 * min( 3, nMoznihOseb[d,vv]/nProstihMest[d,vv] ) ;
            // lahko dajemo prednost cim daljsim vzorcem: dajemo prednost istemu vzorcu, kot je prejsnji dan
            if d > 1 then begin
              if DMIVals[d-1,o].nVals <> 1 then
                MsgHalt( 'ni mogoce: dmi prejsnjega dne ni pribit',0, d, o ) ;
              if vv = VrstaVzDMI(DMIVals[d-1,o].Vals[1]) then
                 zazeljenost := zazeljenost + 3 ;
            end ;
          end else //  nProstihMest[d,vv] = 0
            zazeljenost := 0 ;
        end ;
      end ;
      vrVzorcev[o].r[vv] := -1.0 * zazeljenost ;
  end ;
  vrVzorcev[o].SortByR ;
  vv := 0 ;
  while (vv < MxVrstVzorcev) and (vrVzorcev[o].r[vv] < 0) do
    vv := vv + 1 ;
  if (vrVzorcev[o].r[vv] < 0) then
    Result := vv
  else Result := vv-1 ;
end ;  {oceniVzorceOsebe}


function TRazSolve.razOsebeSkupine(var oList: TOsebeList; fIdx, lIdx: TOsebaIdx; d: TDanIdx) : boolean ;
//  msg('Tipka F5: razpored po metodi BREZ VZORCOV, po SKUPINAH' ) ;
var
    o: TOsebaIdx ;
    dmi: TDMI ;
    vv, v1: TVrstaVzorca ;
    i: smallint ;
    nVz: smallint ;
    mDMI: TSmallIntArray ;
  begin
    Result := false ;
    if fIdx > lIdx then begin  // dan d uspesno razporejen
      Result := true ; exit ;
    end ;
    iter := iter + 1 ;
    o := oList[fIdx] ;
    nVz := oceniVzorceOsebe(o, d, vrVzorcevGlob) ;
    if nVz < 0 then  // nobenega moznega vzorca osebe
      exit ;
    shMsgOsebe(fIdx) ;
    for v1 := 0 to nVz do begin
      vv := vrVzorcevGlob[o].a[v1] ;  // vzorci so urejeni po narascajoci prioriteti
      if DMIVals[d,o].nVals<>1 then begin
        if (nProstihMest[d,vv]-1 > lIdx-fIdx) or (nProstihMest[d,vv] < 1) then
          continue ;  // premalo oseb za vzorec
      end ;
      if not mozniDMIVzorca(vv, d, o, mDMI) then  //uredi mozne vrednosti DMIja po LCV
        continue ;
      for i := 0 to Length(mDMI)-1 do begin
        dmi := mDMI[i] ;  // prej huda napaka ker se mozniDMI rekurzivno spremeni
        varMark := varMark + 1 ;
        if not propPribijDMIVal( dmi, d, o ) then begin
          undoPribijDMIVal ;  // moramo vrniti tudi stare kriterije
          continue ;
        end ;
        Result := razOsebeSkupine( oList, fIdx+1, lIdx, d ) ;  // razporedi naslednjo osebo
        if Result then exit ;
        shMsgOsebe(fIdx) ;
        undoPribijDMIVal ;
        if FastAndSloppy then
          break ;
      end ;
    end ;
  end ;  {razOsebeSkupine}


function TRazSolve.razSkupino(oList: TOsebeList; lIdx: TOsebaIdx; d: TDanIdx) : boolean ;
//  msg('Tipka F5: razpored po metodi BREZ VZORCOV, po SKUPINAH' ) ;
var
  o: TOsebaIdx ;
begin
  Result := false ;
  if not initOsebeNaDMI2(oList, lIdx, d) then begin
    exit ;
  end ;
  for o := 1 to lIdx do
    if not propReduceKritNOk( d, oList[o] ) then begin// iz DMIVals[d,.] izloci dmi, ki krsijo kriterije
      exit ;
    end ;
  if not (sortOsebe(oList, lIdx, d) and razOsebeSkupine(oList, 1, lIdx, d)) then
    exit ;
  Result := true ;
end ;  {razSkupino}


function TRazSolve.razporediDan(oList: TOsebeList; lIdx: TOsebaIdx; d: TDanIdx) : boolean ;
//  msg('Tipka F5: razpored po metodi BREZ VZORCOV, po SKUPINAH' ) ;
var
  o, lIdx2: TOsebaIdx ;
  vv: TVrstaVzorca ;
  sk: smallint ;
  oList2: TOsebeList ;
  s: string ;
  allKritOk: boolean ;
begin {razporediDan}
  Result := false ;
  for o := 1 to lIdx do begin
    vrVzorcevGlob[oList[o]] := TSmIntRealPairArray.Create(MxVrstVzorcev+1) ;
    for vv := 0 to MxVrstVzorcev do
      vrVzorcevGlob[oList[o]].Add(vv, 0);
  end ;
  for o := 1 to nOseb do  // shrani osebe, kot so pred razporejanjem dne d
    tmposebe[o] := osebe[o] ;
  for sk := 1 to stSk[d] do begin
    getOsebeSkupine( d, sk, oList2, lIdx2 ) ;
    s := ' osebe: ' ;
    for o := 1 to lIdx2 do begin
      s := s + ' o' + IntToStr(oList2[o]) ;
    end ;
    if not razSkupino(oList2, lIdx2, d) then begin
      for o := 1 to lIdx2 do begin  // naredi undo sprememb
        DMIVals[d,oList2[o]] := DMIValsInitial[d,oList2[o]] ;
        osebe[oList2[o]] := tmposebe[oList2[o]] ;
      end ;
      sprostiKriterije ;
      if not popravljajKrsenja then
        msg( 'Dan '+IntToStr(d)+s+' - KRITERIJI sprosceni' ) ;
      Result := razSkupino(oList2, lIdx2, d) ;
      vrniKriterije ;
      if not Result then begin  //razpored dneva ne obstaja
        MsgHalt('Resitev za dan d'+IntToStr(d)+' s sproscenimi kriteriji ne obstaja!', 6, d, -1) ;
        exit ;
      end ;
      if not popravljajKrsenja then begin
        for o := 1 to lIdx2 do // uporabi kriterije oseb, ki niso krseni
          updateKritOKOnly(d, oList2[o], DMIVals[d,oList2[o]].Vals[1]) ;
        continue ;
      end ;
      for o := 1 to lIdx2 do  // uporabi kriterije, ceprav so krseni
        updateKrit(d, oList2[o], DMIVals[d,oList2[o]].Vals[1]) ;
      repeat
        Result := popraviKritNOk(d, skOseb[d, oList2[1]]) ;
        allKritOk := true ;
        for o := 1 to lIdx2 do
          if not kritOk(oList2[o]) then
            allKritOk := false ;
      until allKritOk or not Result ;
      for o := 1 to lIdx2 do // vrni stare kriterije
        osebe[oList2[o]] := tmposebe[oList2[o]] ;
      for o := 1 to lIdx2 do // uporabi kriterije oseb, ki niso krseni
        updateKritOKOnly(d, oList2[o], DMIVals[d,oList2[o]].Vals[1]) ;
      if allKritOk then begin
        msg( 'Dan '+IntToStr(d)+s+' - KRITERIJI OK (menjave oz. krs.le prih.dnevi)' ) ;
      end else begin
        msg( 'Dan '+IntToStr(d)+s+' - KRITERIJI sprosceni' ) ;
      end ;
    end ;
  end ;  // for sk := 1 to raz.stSk[d] do begin
  Result := true ;
end ;  {razporediDan}


function TRazSolve.razporediNeodvDnevi(oList: TOsebeList; lIdx: TOsebaIdx; d, doDne: TDanIdx) : boolean ;
//  msg('Tipka F5: razpored po metodi BREZ VZORCOV, po SKUPINAH' ) ;
begin  {razporediNeodvDnevi}
  Result := false ;
  while d <= doDne do begin
    shMsgDan(d) ;
    Result := razporediDan( oList, lIdx, d ) ;
    if not Result then
      exit ;
    (store as TDMIValsStore).clear ; varMark := 0 ;
    d := d + 1 ;
  end ;
  if not NOMSG then
    msg( '**********   RESITEV  **********  iter= '+IntToStr(iter)  ) ;
  msg( 'RazporediNEODV: Elapsed Milisconds = '+IntToStr(MilliSecondOfTheDay(Now)-StartTime) ) ;
end ;  {razporediNeodvDnevi}


function TRazSolve.solve: boolean ;
//  sestavi razpored
//  msg('Tipka F5: razpored po metodi BREZ VZORCOV, po SKUPINAH' ) ;
var
  oList: TOsebeList ;
  //  i: smallint ;  // !!! do 8.6.2007 BUG!!! smallint oseb > 128
  i: smallint ;  // po 8.6.2007 ok

begin
  prepare ;
  for i := 1 to nOseb do
    oList[i] := i ;
  Status := 0 ;
  StartTime := MilliSecondOfTheDay(Now) ;
  Result := razporediNeodvDnevi(oList, nOseb, 1, nDni) ;
  if Result then begin
    Status := 1 ;
    postaviDMIValsOut(DMIVals );
  end ;
end ;  {solve}

function TRazSolve.krsitveKrit( var krsitve: TkrsitveKrit ): integer ;
//TkrsitveKrit = array[1..MxOseb] of record // dodano 29.03.2007: spisek krsenih kriterijev oseb
//  dan: smallint ;  // prvi dan ko oseba krsi nek kriterij; ce dan=0 potem oseba ne krsi kriterijev
//  kriterij: TTipKriterija ; // prvi krseni kriterij
//  vrKrit: TKritVal ;  // vrednost prvega krsenega kriterija
//end ;
// JAKL: klices kot:
// var stkrsenihKriterijev: integer ; krsitve: TkrsitveKrit ;
// stkrsenihKriterijev := krsitveKrit( krsitve ) ;
var
  o: TOsebaIdx;
  d: TDanIdx ;
  dmi: TDMI ;
  i, kkFirst, k: integer ;
  ik: TTipKriterija ;
  vv: TVrstaVzorca ;
  mxKrit: TKritValList ;
  prevKrit, osMxKrit: array[1..MxOseb] of TKritValList ;
  kk: boolean ;
  nKrsenih, nKrsInc: integer ;
  v: TkritVal ;
begin
// Prenosi se pri izracunu vrednosti kriterijev ne upostevajo
  initKriteriji ;
  nKrsenih := 0 ;  // steje dni, ko so kriteriji krseni
  nKrsInc := 0 ; // steje dni, ko so kriteriji krseni in hkrati povecani; steje vse krsene kriterije za vse osebe
  for ik := Low(TTipKriterija) to High(TTipKriterija) do begin
    mxKrit[ik] := 0 ;
    for o := 1 to nOseb do begin
      prevKrit[o,ik] := 0 ;
      osMxKrit[o, ik] := 0 ;
    end ;
  end ;
  for o := 1 to nOseb do begin
    kk := false ; kkFirst := 0 ;
    krsitve[o].dan := 0 ;
    for d := 1 to nDni do begin
      prevKrit[o] := osebe[o].vKrit ;
      updateKrit(d, o, DMIVals[d,o].Vals[1]) ;
      for ik := Low(TTipKriterija) to High(TTipKriterija) do begin
        if ik = PVkdMesecMx then
          v := VkdMesecValToVkdCount(osebe[o].vKrit[ik])
        else v := osebe[o].vKrit[ik] ;
        if v > mxKrit[ik] then
          mxKrit[ik] := v ;
        if v > osMxKrit[o,ik] then
        osMxKrit[o,ik] := v ;
      end ;
      if not kritOK(o) then begin // kriteriji krseni
        nKrsenih := nKrsenih + 1 ;
        kk := true ;
        if kkFirst = 0 then kkFirst := d ;
        for ik := Low(TTipKriterija) to High(TTipKriterija) do begin
          if not valOK( osebe[o].vKrit[ik], ik ) then begin
            if krsitve[o].dan = 0 then begin // prva krsitev; vstavi jo v krsitve
              krsitve[o].dan := d ;
              krsitve[o].kriterij := ik ;
              if (ik = PVkdMesecMx) then
                krsitve[o].vrKrit := VkdMesecValToVkdCount(osebe[o].vKrit[ik])
              else krsitve[o].vrKrit := osebe[o].vKrit[ik] ;
            end ;
            if (ik <> PVkdMesecMx) and (prevKrit[o,ik] < osebe[o].vKrit[ik]) then
              nKrsInc := nKrsInc + 1 ;  // dodatna krsitev kriterija
            if (ik = PVkdMesecMx) and (VkdMesecValToVkdCount(prevKrit[o,ik]) < VkdMesecValToVkdCount(osebe[o].vKrit[ik])) then
              nKrsInc := nKrsInc + 1 ;  // dodatna krsitev kriterija
          end ;
        end ;
      end ;
    end ;
  end ;  //   for o := 1 to nOseb do
  Result := nKrsInc ;
end ;  {krsitveKrit}

end.

