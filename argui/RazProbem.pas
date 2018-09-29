unit RazProbem;

interface

uses Math, StdRut, SysUtils, RazProbemBase ;


type
  TDMIList = array[1..MxDMIList] of TDMI ;   // seznam DMIjev osebe, ki so prosti/zasedeni dolocenega Dne
  TDMIListIdx = 0..MxDMIList ;               // index v TDMIList
  TOsebNaDMIIdx0 = 0..MxOsebNaDMI ;


  TDMIValsEl = record                      // mozne vrednosti DMIja
    nVrsteVz: array [TVrstaVzorca] of smallint ;  // stevila moznih DMIjev po grupah izmen(dopV, popV, nocV)
    nVals: TDMIListIdx ;                   // stevilo moznih razlicnih vrednosti DMIja
    vals: TDMIList ;                       // seznam moznih vrednosti DMIja (DMIji osebe ki so prosti dolocenega Dne)
  end ;

  TDMIVals = array[TDanIdx, TOsebaIdx] of TDMIValsEl ;
  TDMIDanVals = array[TOsebaIdx] of TDMIValsEl ;

  TDanVzorecInt = array[1..MxDnevi, 0..MxVrstVzorcev] of smallint ;

  TDMIValsOut = array[TDanIdx, TOsebaIdx] of TDMI ;

  TRazProblem = class(TRazKriteriji)
  private
    function DMIValIdx( dmi: TDMI ; var DMIValsEl: TDMIValsEl ) : TDMIListIdx ;
    // vrne index DMI v DMIVals[Dan,Oseba]
  protected
    DMIValsInitial: TDMIVals ; // DMIValsDOInitial[d,o] so mozni DMIji osebe o dne d
  public
    stSk: array [TDanIdx] of smallint ;  // st. neodvisnih skupin oseb
    skOseb: array[TDanIdx, 1..MxOseb] of smallint ;  // indexi neodvisnih skupin oseb
    dmiSk: array [TDanIdx, 1..MxSkupin] of TDMISet ;

    constructor Create ;
    procedure getOsebeSkupine( d: TDanIdx; sk: smallint; var oList: TOsebeList; var lIdx: TOsebaIdx ) ;
    function dmiSkupine( var DMIVals: TDMIVals; d: TDanIdx; sk: smallint ): TDMISet ;
    procedure initProblem ;
    procedure initDMIVals( var DMIVals: TDMIVals ) ;
    procedure povezaneOsebeDne( var DMIVals: TDMIVals; d: TDanIdx ) ;


    function stDMIvDP( dmi: TDMI ; dan: TDanIdx ) : TOsebNaDMIIdx0 ;
    // st. oseb ki so v DP[dan] razporejene na dmi
    function VrstaVzDMI( dmi: TDMI ) : TVrstaVzorca ;

    procedure addDMIVal( dmi: TDMI; var DMIValsEl: TDMIValsEl ) ;
    // v DMIVals[Dan,Oseba] doda novo vrednost dmi, ter poveca ustrezno st. vzorca
    // to naredimo pri inicializaciji, in ko osebo prerazporedimo na drug DMI
    procedure delDMIVal( dmi: TDMI ; var DMIValsEl: TDMIValsEl ) ;
    // iz DMIVals[Dan,Oseba] zbrise vrednost dmi, ter zmanjsa ustrezno st. vzorca
    // to na zacetku pri fiksiranju oseb, in ko vrednost DMIja ni vec mogoca za to osebo
    function prostoMedDMI(var posDMIVals: TDMIValsEl): boolean ;
    // true ce je 0 med moznimi vrednostmi dmija
    function vplivDniKritOsebe(o: TOsebaIdx): TDanIdx ;
    // vrne st. zadnjih dni, ki vplivajo na kriterije osebe o (mozni krseni dnevi pred d)
    procedure recompKrit(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; var DMIVals: TDMIVals) ;
    // od dne=1 do d ponovno izracuna kriterij kritIdx osebe o
    // rezultat je vrednost kriterija od dnevu d (krsenja v prejsnjih dnevih so ignorirana)
    procedure recompAllKrit(d: TDanIdx; o: TOsebaIdx; var DMIVals: TDMIVals) ;
    function prihKritOk(d: TDanIdx; o: TOsebaIdx; var DMIVals: TDMIVals): boolean ;
    // true ce ima oseba o krsene gotove kriterija v prihodnosti (od d+1) dalje
    procedure updateKritSure(curD, d: TDanIdx; o: TOsebaIdx; var posDMIVals: TDMIValsEl) ;
    //procedure updateKritSure(d: TDanIdx; o: TOsebaIdx; var posDMIVals: TDMIValsEl) ;
    // za vse kriterije i: naredi update kriterija i le ce je gotova spremeba kriterija
    function minKritChange(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; var posDMIVals: TDMIValsEl): TKritVal ;
    procedure kritOkDMIVals(d: TDanIdx; o: TOsebaIdx; var posDMIVals, okDMIVals: TDMIValsEl) ;
    // izracuna okDMIVals tako da iz posDMIVals odstrani vse dmi, ki krsijo kriterije osebe o, dne d

    function preveriresitev( var DMIVals: TDMIVals) : boolean ;
    procedure zapisi( var DMIVals: TDMIVals );
    procedure preberi( var DMIVals: TDMIVals );
  end ;  {TRazProblem}



implementation

// *******
// ******* class TRazProblem
// *******

constructor TRazProblem.Create ;
begin
  inherited Create ;
end ;

procedure TRazProblem.initProblem ;
var
  d, i: smallint ;
begin
  initKriteriji ;
  if DMIOseb = nil then
    MsgHalt( 'DMIOseb ni dolocen', 0, -1, -1 ) ;
  initDMIVals( DMIValsInitial ) ;
  Dispose( DMIOseb ) ;
  for d := 1 to nDni do begin
    stSk[d] := 0 ;
    for i := 1 to MxSkupin do
      dmiSk[d,i] := [] ;
  end ;    
end ;  {TRazProblem.initProblem}


procedure TRazProblem.initDMIVals( var DMIVals: TDMIVals ) ;
var
  d: TDanIdx ;
  o: TOsebaIdx ;
  dmi1: TDMI ;
  vv: TVrstaVzorca ;
  ki: TTipKriterija ;
  dmiListIdx: TDMIListIdx ;
  prevKrit: TKritValList ;
  stPribitihDMI: array[1..MxDnevi, 1..MxDMI] of byte ; // dodano 13.03.2007
  j, dmiIdx: smallint ;
  pribitDMI: boolean ;  // dodano 28.03.2007
begin
  for o := 1 to nOseb do begin
    osebe[o].nePribiti := nDni ;
    osebe[o].delovni := 0 ;
    for d := 1 to nDni do begin
      for vv := 0 to MxVrstVzorcev do
        DMIVals[d,o].nVrsteVz[vv] := 0 ;
      DMIVals[d,o].nVals := 0 ;
    end ;
  end ;
  for d := 1 to nDni do
    for dmi1 := 1 to nDMI do
      stPribitihDMI[d,dmi1] := 0 ;
  for o := 1 to nOseb do with Osebe[o] do begin
    for d := 1 to nDni do begin
      for dmi1 := 0 to nDMI do begin
        if dmi1 in DMIOseb^[d,o] then begin
          pribitDMI := (DMIOseb^[d,o] - [dmi1] = []) ;
          if pribitDMI or (dmi1 = 0) or (stDMIvDP( dmi1, d) > 0) then // !!! po 28.03.2007:tudi pribite osebe, ki niso v DP, dodamo v DP
            addDMIVal( dmi1, DMIVals[d,o] ) ;
          if (dmi1 <> 0) and (stDMIvDP( dmi1, d) = 0) then
            if not NOMSG then msg( 'initDMIVals: Oseba o'+IntToStr(o)+': DMI '+IntTostr(dmi1)+' ni v del.planu za d'+IntToStr(d)) ;
          // Pazi: problem napr. ce imata o1 in o2 samo dmi1 in dmi2, nimata pa dmi0 in sta to edini osebi na dmi1 in dmi2
          // potem nobena ni pribita in dmi1 in dmi2 ne damo v DP, torej resitev ne bo obstajala
          if not pribitDMI and (DMIVals[d,o].Vals[1] <> 0) then // dodano 28.03.2007
            MsgHalt( 'Nepribita oseba mora imeti vedno tudi dmi0(prosto)', 3, d, o ) ;
          // if (DMIVals[d,o].nVals = 1) and (DMIVals[d,o].Vals[1] <> 0) then begin // do 28.3.2007
          if pribitDMI and (DMIVals[d,o].Vals[1] <> 0) then begin // !!! po 28.3.2007
            stPribitihDMI[d,dmi1] := stPribitihDMI[d,dmi1]+1 ;
            if stPribitihDMI[d,dmi1] > stDMIvDP( dmi1, d) then begin // dodaj dmi v DP
              msg( 'Oseba '+IntToStr(o)+': prevec pribitih oseb; v DP dodajam dodaten DMI='+IntToStr(dmi1)+' dne '+IntToStr(d) ) ;
              // poiscem dmi
              dmiIdx := -1 ;
              for j := 1 to DP[d].nDMI do
                if DP[d].DPDMIList[j] = dmi1 then begin
                  dmiIdx := j ; break ;
                end ;
              if dmiIdx > 0 then
                DP[d].nOsebList[dmiIdx] := DP[d].nOsebList[dmiIdx] + 1
              else begin// vstavi dmi
                DP[d].nDMI := DP[d].nDMI + 1 ;
                DP[d].DPDMIList[DP[d].nDMI] := dmi1 ;
                DP[d].nOsebList[DP[d].nDMI] := 1 ;
              end ;
            end ;
          end ;
        end ;
      end ; {for dmi}
      if BRISIDMIkiKrsKRIT then begin // preverimo ce mozni dmiji ne krsijo kriterijev
        for dmiListIdx := 1 to DMIVals[d,o].nVals do begin
          if not newKritOK( d, o, DMIVals[d,o].Vals[dmiListIdx] ) then begin
            if DMIVals[d,o].nVals > 1 then begin
              delDMIVal( DMIVals[d,o].Vals[dmiListIdx], DMIVals[d,o] ) ; // brisemo dmi ki krsi kriterije iz DMIVals
            end ;
          end ;
        end ;
      end ;
      prevKrit := osebe[o].vKrit ;
      for ki := Low(TTipKriterija) to High(TTipKriterija) do
        if krit[ki].enabled then
          osebe[o].vKrit[ki] := minKritChange( ki, d, o, DMIVals[d,o] ) ;
      if not kritOK( o ) then begin
        if DOVOLIGotovoKrsKRIT then
          msg('  ***** initDMIVals(DOVOLIGotovoKrsKRIT=1): o'+IntToStr(o)+' vsekakor(katerikoli dmi) krsi kriterije dne d'+IntToStr(d))
        else
          MsgHalt('initDMIVals: o'+IntToStr(o)+' vsekakor(katerikoli dmi) krsi kriterije dne d'+IntToStr(d), 5, d, o) ;
        osebe[o].vKrit := prevKrit ;
        osebe[o].vKrit[PDanPocitek] := 0 ;
      end ;  // if preveriDMIpoKriterijih
    end ;  {for d}
  end ;
  for o := 1 to nOseb do
    for ki := Low(TTipKriterija) to High(TTipKriterija) do
      initKritOsebeDan1( ki, o ) ;
  // !!! dodano 29.03.2007 preverim ce je za vsak dmi iz DP vsaj ena razpolozljiva oseba
  for d := 1 to nDni do begin
    for dmi1 := 1 to nDMI do begin
      j := stDMIvDP( dmi1, d ) ;
      if j > 0 then begin // preverim ce je dovolj razpolozljivih oseb
        for o := 1 to nOseb do
          if DMIValIdx(dmi1, DMIVals[d,o])<>0 then // razpolozljiva oseba
            j := j - 1 ;
        if j > 0 then
          MsgHalt('Premalo oseb za izvajanje dela dne '+IntToStr(d), 3, d, dmi1) ;
      end ;
    end ;
  end ;
end ;  {initDMIVals}


function TRazProblem.stDMIvDP( dmi: TDMI ; dan: TDanIdx ) : TOsebNaDMIIdx0 ;
// st. oseb ki so v DP[dan] razporejene na dmi
var
  DPdmiListIdx: 1..MxDelPlanDMI ;
begin
  stDMIvDP := 0 ;
  if dmi=0 then begin
    msg('stDMIvDP: dmi=0' ) ;
    stDMIvDP := 1 ;
  end ;
  for DPdmiListIdx := 1 to DP[dan].nDMI do
    if (dmi = DP[dan].DPDMIList[DPdmiListIdx]) then begin
      stDMIvDP := DP[dan].nOsebList[DPdmiListIdx] ;
      exit ;
    end ;
end ;  {stDMIvDP}



function TRazProblem.VrstaVzDMI( dmi: TDMI ) : TVrstaVzorca ;
begin
  Result := DMIList[dmi].vz ;
end ;  {VrstVzorcaDMI}


function TRazProblem.DMIValIdx(dmi: TDMI; var DMIValsEl: TDMIValsEl) : TDMIListIdx ;
// vrne index DMI v DMIValsEl (=DMIVals[Dan,Oseba])
  var
  i: integer ;
begin
  DMIValIdx := 0 ;
  for i := 1 to DMIValsEl.nVals do
    if DMIValsEl.Vals[i] = dmi then begin
      DMIValIdx := i ;
      break ;
    end ;
end ;  {DMIValIdx}

procedure TRazProblem.addDMIVal( dmi: TDMI; var DMIValsEl: TDMIValsEl ) ;
// v DMIValsEl doda novo vrednost dmi, ter poveca ustrezno st. vzorca
// to naredimo pri inicializaciji, in ko osebo prerazporedimo na drug DMI
var
  vv: TVrstaVzorca ;
  idx: TDMIListIdx ;
begin
  idx := DMIValIdx(dmi, DMIValsEl ) ;
  with DMIValsEl do begin
    if idx > 0 then begin // dmi ze obstaja v DMIValsEl
      MsgHalt( 'TRazProblem.addDMIVal: ta dmi ze v DMIVals',0, -1, -1 );
    end else begin
      if nVals >= MxDMIList then begin
        MsgHalt( 'Prevec DMI Vrednosti osebe',4, -1, -1 ) ;
        exit ;
      end ;
      nVals := nVals + 1 ;
      Vals[nVals] := dmi ;
      vv := VrstaVzDMI(dmi) ;
      nVrsteVz[vv] := nVrsteVz[vv] + 1 ;
    end ;
  end ;
end ;  {addDMIVal}


procedure TRazProblem.delDMIVal( dmi: TDMI ; var DMIValsEl: TDMIValsEl ) ;
// iz DMIVals[Dan,Oseba] zbrise vrednost dmi, ter zmanjsa ustrezno st. vzorca
// to na zacetku pri fiksiranju oseb, in ko vrednost DMIja ni vec mogoca za to osebo
var
  idx: TDMIListIdx ;
  vv: TVrstaVzorca ;
begin
  idx := DMIValIdx( dmi, DMIValsEl) ;
  if idx = 0 then
    MsgHalt( 'Brisanje neobstojecega DMI',0, -1, -1 ) ;
  with DMIValsEl do begin
    if nVals=1 then
      MsgHalt('DelDMIVal: dmi '+IntToStr(dmi)+' ze pribit!',0, -1, -1 ) ;
    Vals[idx] := Vals[nVals] ;
    nVals := nVals - 1 ;
    vv := VrstaVzDMI(dmi) ;
    nVrsteVz[vv] := nVrsteVz[vv] - 1 ;
  end ;
end ;  {delDMIVal}


function TRazProblem.prostoMedDMI(var posDMIVals: TDMIValsEl): boolean ;
// true ce je 0 med moznimi vrednostmi dmija
var
  dmiListIdx: TDMIListIdx ;
begin
  Result := true ;
  for dmiListIdx := 1 to posDMIVals.nVals do
    if posDMIVals.Vals[dmiListIdx]=0 then
      exit ;
  Result := false ;
end ;  {prestoMedDMI}

function TRazProblem.dmiSkupine( var DMIVals: TDMIVals; d: TDanIdx; sk: smallint ): TDMISet ;
var
  dmi: TDMI ;
  o: TOsebaIdx ;
begin
   Result := [] ;
   for o := 1 to nOseb do begin
     if skOseb[d,o] <> sk then
       continue ;
     for dmi := 0 to nDMI do begin
       if (DMIValIdx(dmi, DMIVals[d,o])<>0) then
         Result := Result + [dmi] ;
     end ;
   end ;
end ;  {dmiSkupine}


procedure TRazProblem.getOsebeSkupine( d: TDanIdx; sk: smallint; var oList: TOsebeList; var lIdx: TOsebaIdx ) ;
var
  j: TOsebaIdx0 ;
  o: TOsebaIdx ;
// v oList vrne vse osebe o za katere skOseb[d,o]=sk
begin
  j := 0 ;
  for o := 1 to nOseb do
    if skOseb[d,o] = sk then begin
      j := j + 1 ;
      oList[j] := o ;
    end ;
  if j <= 0 then MsgHalt( 'Skupina ne obstaja',0, d, -1 ) ;
  lIdx := j ;
end ;  {getOsebeSkupine}


procedure TRazProblem.povezaneOsebeDne( var DMIVals: TDMIVals; d: TDanIdx ) ;
// poisce skupine oseb, ki delajo na istih DDMIjih, dne d
var
  i, j: smallint ;
  dmi: TDMI ;
  spr: boolean ;
  s: string ;

procedure preimenuj(sk, novaSk: smallint ) ;
var
  k: smallint ;
begin
  // primenuj sk v novaSk
  for k := 1 to nOseb do begin
    if skOseb[d,k] = sk then
      skOseb[d,k] := novaSk ;
  end ;
  // preimenuj zadnjo skupino v sk
  for k := 1 to nOseb do begin
    if skOseb[d,k] = stSk[d] then
      skOseb[d,k] := sk ;
  end ;
  stSk[d] := stSk[d] - 1 ;
end ;

begin
  for i := 1 to nOseb do
    skOseb[d,i] := i ;
  stSk[d] := nOseb ;
  // na zacetku je vsaka oseba v svoji skupini, potem zdruzujemo skupine,
  // ce sta osebi iz razlicnih skupin na istem ddmi
  // dmi=0 ni v nobeni skupini; v skupino ga damo kasneje, ce ga ima lahko vsaj ena oseba
  spr := true ;
  while spr do begin
    spr := false ;
    for dmi := 1 to nDMI do begin
        i := 1 ;
        while i <= nOseb do begin
          j := i ;
          while j < nOseb do begin
            j := j + 1 ;
            if skOseb[d,i] = skOseb[d,j] then
              continue ;
            if (DMIValIdx(dmi, DMIVals[d,i])<>0) and (DMIValIdx(dmi, DMIVals[d,j])<>0) then begin
              // obe osebi delata na dmi - zdruzi skupine
              spr := true ;
              if skOseb[d,i] < skOseb[d,j] then
                preimenuj( skOseb[d,j], skOseb[d,i] )
              else
                preimenuj( skOseb[d,i], skOseb[d,j] ) ;
            end ;
          end ; // while j
          i := i + 1 ;
        end ;  // while i
    end ;  // for dmi
  end ;
// postavi dmiSk za dan d
  for i := 1 to stSk[d] do
    dmiSk[d,i] := dmiSkupine( DMIVals, d, i ) ;
end ;  {povezaneOsebeDne}


function TRazProblem.vplivDniKritOsebe(o: TOsebaIdx): TDanIdx ;
// vrne st. zadnjih dni, ki vplivajo na kriterije osebe o (mozni krseni dnevi pred d)
begin
  Result := MxDnevi ;
  if kritOKIgnorePocitek( o ) then
    Result := 1
  else begin
    if kritOKIgnoreTeden( o ) then
      Result := 6 ;
  end ;
end ;  {vplivDniKritOsebe}


procedure TRazProblem.recompAllKrit(d: TDanIdx; o: TOsebaIdx; var DMIVals: TDMIVals) ;
// od dne=1 do d ponovno izracuna kriterije osebe o
var
  i: TTipKriterija ;
begin
  for i := Low(TTipKriterija) to High(TTipKriterija) do
    if krit[i].enabled then
      recompKrit( i, d, o, DMIVals ) ;
end ;  {recompAllKrit}

procedure TRazProblem.recompKrit(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; var DMIVals: TDMIVals) ;
// od dne=1 do d ponovno izracuna kriterij kritIdx osebe o
// rezultat je vrednost kriterija od dnevu d (krsenja v prejsnjih dnevih so ignorirana)
var
  pd, ds: smallint ;
begin
  initKritOsebeDan1(kritIdx, o ) ;
  case kritIdx of
    PDanPocitek: ds := d-1 ;
    PZapUrTedenMx, PZapDniTedenMx: ds := d-6 ;
    else
      ds := 1 ;
  end ;
  for pd:=MaxInt( 1, ds ) to d do begin
    // popravljeno 29.2.2007, napaka pri P12, zdaj dovoljujem da ima iseba o dne d vec moznih dmi
    if DMIVals[pd,o].nVals = 1 then
      osebe[o].vKrit[kritIdx] := newVal( kritIdx, pd, o, DMIVals[pd,o].Vals[1] )
    else begin
      if pd < d then
        MsgHalt( 'recomKrit: dmiji za prejsnje dni morajo biti pribiti',0, pd, -1 ) ;
    end ;

  end ;
end ;  {recompKrit}


function TRazProblem.prihKritOk(d: TDanIdx; o: TOsebaIdx; var DMIVals: TDMIVals): boolean ;
// true ce ima oseba o krsene gotove kriterija v prihodnosti (od d+1) dalje
var
  tmpvKrit: TKritValList ;    // vrednosti kriterijev za osebo
  d1: TDanIdx ;
begin
  Result := true ;
  tmpvKrit := osebe[o].vKrit ;
  d1 := d ;
  while d1 < nDni do begin
    d1 := d1+1 ;
    updateKritSure(d, d1, o, DMIVals[d1, o]) ;
    if not kritOK(o) then begin // nek kriterij prihodnjega dne krsen
      Result := false ; break ;
    end ;
  end ;
  osebe[o].vKrit := tmpvKrit ; // vrnem stare kriterije
end ;  {prihKritOK}


procedure TRazProblem.updateKritSure(curD, d: TDanIdx; o: TOsebaIdx; var posDMIVals: TDMIValsEl) ;
// za vse kriterije i: naredi update kriterija i le ce je gotova spremeba kriterija, zacne z dnem d=curD+1
var
  i: TTipKriterija ;
begin
  for i := Low(TTipKriterija) to High(TTipKriterija) do begin
    if (i in [PZapUrTedenMx,PZapDniTedenMx]) and (d - curD > 6) then // ta pogoj je logicno pravilen
        continue ;  // samo za prihodnjih 6 dni
    if (i = PDanPocitek) and (d - curD > 1) then continue ;  // samo za prihodnji dan
    if krit[i].enabled then
      osebe[o].vKrit[i] := minKritChange( i, d, o, posDMIVals ) ;
  end ;
end ;  {updateKritSure}


function TRazProblem.minKritChange(kritIdx: TTipKriterija; d: TDanIdx; o: TOsebaIdx; var posDMIVals: TDMIValsEl): TKritVal ;
// vrne minimalno vrednost kriterija, ce dmi pribijemo na neko vrednost iz posDMIVals
var
  dmiListIdx: TDMIListIdx ;
  dmi: TDMI ;
  v, v1, minV, minV1: TKritVal ;
begin
  if prostoMedDMI(posDMIVals) then begin // dmi=0 (prosto) da vedno min.vrednost kriterija
    Result := newVal( kritIdx, d, o, 0 ) ;
    exit ;
  end ;
  if krit[kritIdx].dmiIgnore then begin
    Result := newVal( kritIdx, d, o, posDMIVals.Vals[1] ) ;
    exit ;
  end ;
  minV1 := High(TKritVal) ; minV := High(TKritVal) ;
  for dmiListIdx := 1 to posDMIVals.nVals do begin
    dmi := posDMIVals.Vals[dmiListIdx] ;
    v := newVal( kritIdx, d, o, dmi ) ;
    if kritIdx = PVkdMesecMx then
      v1 := VkdMesecValToVkdCount(v)
    else v1 := v ;
    if v1 < minV1 then begin
      minV1 := v1 ; minV := v ;
    end ;
  end ;
  Result := minV ;
end ;  {minKritChange}


procedure TRazProblem.kritOkDMIVals(d: TDanIdx; o: TOsebaIdx; var posDMIVals, okDMIVals: TDMIValsEl) ;
// izracuna okDMIVals tako da iz posDMIVals odstrani vse dmi, ki krsijo kriterije osebe o, dne d
var
  dmiListIdx: TDMIListIdx ;
  dmi: TDMI ;
  vv: TVrstaVzorca ;
begin
  for vv := 0 to MxVrstVzorcev do
    okDMIVals.nVrsteVz[vv] := 0 ;
  okDMIVals.nVals := 0 ;
  for dmiListIdx := 1 to posDMIVals.nVals do begin
    dmi := posDMIVals.Vals[dmiListIdx] ;
    if newKritOK( d, o, dmi ) then
      addDMIVal( dmi, okDMIVals ) ;
    // else msg('dmi val not ok' ) ;
  end ;
end ;  {kritOkDMIVals}


function TRazProblem.preveriresitev( var DMIVals: TDMIVals ): boolean ;
var
  o: TOsebaIdx;
  d: TDanIdx ;
  dmi: TDMI ;
  i, kkFirst, k: integer ;
  ik: TTipKriterija ;
  vv: TVrstaVzorca ;
  st: array[TVrstaVzorca] of smallint ;
  sv: array[TVrstaVzorca] of smallint ;
  s: string ;
  oList: TOsebeList ;
  mxKrit: TKritValList ;
  prevKrit, osMxKrit: array[1..MxOseb] of TKritValList ;
  kk: boolean ;
  nKrsenih, nKrsInc: integer ;
  v: TkritVal ;
  vrstadne: TTipDneva ;  
begin
// Prenosi se pri izracunu vrednosti kriterijev ne upostevajo
  Result := true ;
  for i := 1 to nOseb do
    oList[i] := i ;
  for d := 1 to nDni do begin
    for dmi := 1 to nDMI do begin
      i := stDMIvDP(dmi, d) ;
      for o := 1 to nOseb do begin
        if DMIVals[d,o].Vals[1] = dmi then
          i := i - 1 ;
      end ;
      if i <> 0 then begin
        MsgHalt( 'Preveri resitev: NAPAKA: d'+IntToStr(d)+'  dmi= '+IntToStr(dmi),0, d, -1 ) ;
        Result := false ;
      end ;
    end ;
  end ;
  // izpisi statistike
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
  for vv := 0 to MxVrstVzorcev do
    sv[vv] := 0 ;
  for o := 1 to nOseb do begin
    for vv := 0 to MxVrstVzorcev do
      st[vv] := 0 ;
    kk := false ; kkFirst := 0 ;
    for d := 1 to nDni do begin
      if DMIVals[d,o].nVals <> 1 then begin
        MsgHalt( 'DMIVals ni Pribit:  d='+IntToStr(d)+'  o='+IntToStr(o),0, d, o ) ;
        Result := false ;
        exit ;
      end ;
      prevKrit[o] := osebe[o].vKrit ;
      updateKrit(d, o, DMIVals[d,o].Vals[1]) ;
      for ik := Low(TTipKriterija) to High(TTipKriterija) do begin
        if ik = PVkdMesecMx then
          v := VkdMesecValToVkdCount(osebe[o].vKrit[ik])
        else v := osebe[o].vKrit[ik] ;
        mxKrit[ik] := MaxInt(mxKrit[ik], v) ;
        osMxKrit[o,ik] := MaxInt(osMxKrit[o,ik], v) ;
      end ;
      if not kritOK(o) then begin // kriteriji krseni
        nKrsenih := nKrsenih + 1 ;
        kk := true ;
        if kkFirst = 0 then kkFirst := d ;
        for ik := Low(TTipKriterija) to High(TTipKriterija) do begin
          if not valOK( osebe[o].vKrit[ik], ik ) then begin
            if (ik <> PVkdMesecMx) and (prevKrit[o,ik] < osebe[o].vKrit[ik]) then
              nKrsInc := nKrsInc + 1 ;  // dodatna krsitev kriterija
            if (ik = PVkdMesecMx) and (VkdMesecValToVkdCount(prevKrit[o,ik]) < VkdMesecValToVkdCount(osebe[o].vKrit[ik])) then
              nKrsInc := nKrsInc + 1 ;  // dodatna krsitev kriterija
          end ;
        end ;
      end ;
      vv := VrstaVzDMI(DMIVals[d,o].Vals[1]) ;
      st[vv] := st[vv] + 1 ;
      sv[vv] := sv[vv] + 1 ;
    end ;
    s := 'o'+IntToStr(o)+':' ;
    if o < 10 then
      s := s + '  ' ;
    // izpisi se vzorce za vse osebe
    vrstadne := prviDanMeseca ;
    for d := 1 to nDni do begin
      vv := VrstaVzDMI(DMIVals[d,o].Vals[1]) ;
      s := s + IntToStr(vv) ;
      if vrstadne = ned then begin
        vrstadne := pon ;
        s := s + '  ' ;
      end else
        vrstadne := Succ(vrstadne) ;
    end ;
    s := s + '  N='+IntToStr(st[3]) + '  P='+IntToStr(st[0])+'    ' ;
    if st[0] < 10 then
      s := s +'  ' ;
    // izpise se kriterije
    //s := s + ' k:' ;
    for ik := Low(TTipKriterija) to High(TTipKriterija) do begin
      k := osMxKrit[o,ik] ;
      if ik in [PDanPocitek, PZapUrTedenMx, PUrMesecMx] then // spremeni minute v ure
        s := s + ' k'+IntToStr(Ord(ik))+'='+IntToStr(round(k/UraMinut))
      else  
        s := s + ' k'+IntToStr(Ord(ik))+'='+IntToStr(k) ;
      if (k >= 0) and (k < 10) then
        s := s + '  ' ;
      if (k >= 0) and (k < 100) then
        s := s + '  ' ;
    end ;
    s := s + '  *o'+intToStr(o) ;
    if kk then // kriteriji krseni
      s := s + ' -d'+IntToStr(kkFirst) ;
    msg( s ) ;
  end ;  //   for o := 1 to nOseb do

  // izpisi vzorce zadnjega dne oseb
  s := '===  ' ;
  for vv := 0 to MxVrstVzorcev do begin
    s := s + '   v'+IntToStr(vv)+'='+IntToStr(sv[vv]) ;
    if sv[vv] < 10 then
      s := s + '  ' ;
  end ;
  //s := s+ '   =skup.vz.;    mx.krit=' ;
  s := s+ '  ===  KrD='+IntToStr(nKrsenih)+'  ' ;
  for ik := Low(TTipKriterija) to High(TTipKriterija) do begin
    if ik in [PDanPocitek, PZapUrTedenMx, PUrMesecMx] then // spremeni minute v ure
      s := s + '   k'+IntToStr(Ord(ik))+'='+IntToStr(round(mxKrit[ik]/UraMinut))
    else
      s := s + '   k'+IntToStr(Ord(ik))+'='+IntToStr(mxKrit[ik]) ;
  end ;
  //msg( s+ '   KrD='+IntToStr(nKrsenih)+'  E='+IntToStr(nKrsInc) ) ;
  msg( s+ '    kK='+IntToStr(nKrsInc) ) ;
  if Result then
    msg( 'Resitev OK' ) ;
end ;  {preveriResitev}


procedure TRazProblem.zapisi( var DMIVals: TDMIVals );
// TDMIValsOut = array[TDanIdx, TOsebaIdx] of TDMI ;
var
  f: file of TDMIValsOut ;
  d: TDanIdx ;
  o: TOsebaIdx ;
  DMIValsOut: TDMIValsOut ;
begin
  msg( 'Zapisujem zadnjo resitev na '+DMIValsFile ) ;
  for d := 1 to MxDnevi do
    for o := 1 to MxOseb do
      DMIValsOut[d,o] := DMIVals[d,o].Vals[1] ;
  assign(f, DMIValsFile ) ;
  rewrite(f) ;
  write(f, DMIValsOut ) ;
  close( f ) ;
end ;

procedure TRazProblem.preberi( var DMIVals: TDMIVals );
// TDMIValsOut = array[TDanIdx, TOsebaIdx] of TDMI ;
var
  s: string ;
  f: file of TDMIValsOut ;
  d: TDanIdx ;
  o: TOsebaIdx ;
  DMIValsOut: TDMIValsOut ;
begin
  initProblem ;
  s := DMIValsFile ;
  msg( 'Berem DMIValsOut z  '+s ) ;
  assign(f, s ) ;
  reset(f) ;
  read(f, DMIValsOut ) ;
  close( f ) ;
  for d := 1 to MxDnevi do
    for o := 1 to MxOseb do begin
      DMIVals[d,o].nVals := 1 ;
      DMIVals[d,o].Vals[1] := DMIValsOut[d,o] ;
    end ;
end ;

end.
