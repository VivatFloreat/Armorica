unit StdRut;

interface

type
TFlagsArray = class
  private
    flags: array of boolean ;
    Size, StartIdx: integer ;
  public
    constructor Create( StartIdx0, EndIdx: integer ) ;
    procedure clear ;
    procedure setFlag( i: integer ) ;
    function hasFlag( i: integer ) : boolean ;
  end ;

TSmIntPairArray = class
  private
    Size: integer ;
  public
    a1, a2: array of smallint ;
    last: integer ;
    constructor Create( sz: integer ) ;
    procedure SortByA2 ;
  end ;

  TSmallIntArray = array of smallint ;
  TSmIntRealPairArray = class
  private
    Size: integer ;
  public
    a: TSmallIntArray ;
    r: array of real ;
    last: integer ;
    constructor Create( sz: integer ) ;
    procedure Add( aEl: integer ; rEl: real ) ;
    procedure SortByR ;
    procedure tst ;
  end ;


function MinInt(A, B: integer): integer;
function MaxInt(A, B: integer): integer;

implementation

uses Dialogs ;

procedure StdRutMsgHalt(s:string; koda: smallint) ;
// Kode=4: Prekoracitev meja arrayev, oz. konstant
begin
   MessageDlgPos(s, mtConfirmation, [mbOK] , 0, 80, 10) ;
   Halt ;
end ;

function MinInt(A, B: integer): integer; // Vrne manjsega od obeh parametrov
begin
  if A < B then
    MinInt := A
  else
    MinInt := B;
end;

function MaxInt(A, B: integer): integer; // Vrne vecjega od obeh parametrov
begin
  if A > B then
    MaxInt := A
  else
    MaxInt := B;
end;


// *******
// ******* class TFlagsArray

constructor TFlagsArray.Create( StartIdx0, EndIdx: integer ) ;
begin
  Size := 1+EndIdx-StartIdx ;
  StartIdx := StartIdx0 ;
  SetLength( flags, size ) ;
end ;

procedure TFlagsArray.clear ;
var i: integer ;
begin
  for i := 0 to Size-1 do
    flags[i] := false ;
end ;

procedure TFlagsArray.setFlag( i: integer ) ;
begin
  if (i < StartIdx) or (i+StartIdx >= Size) then
    StdRutMsgHalt( 'TFlagsArray.setFlag: index out of bounds',4 ) ;
  flags[i+StartIdx] := true ;
end ;

function TFlagsArray.hasFlag( i: integer ) : boolean ;
begin
  if (i < StartIdx) or (i+StartIdx >= Size) then
    StdRutMsgHalt( 'TFlagsArray.hasFlag: index out of bounds',4 ) ;
  hasFlag := flags[i+StartIdx] ;
end ;

// *******
// ******* class TSmIntPairArray

constructor TSmIntPairArray.Create( Sz: integer ) ;
begin
  Size := sz ;
  SetLength( a1, Size ) ;
  SetLength( a2, Size ) ;
  last := -1 ;
end ;

procedure TSmIntPairArray.SortbyA2 ;
  procedure QuickSort(iLo, iHi: Integer);
  var
    Lo, Hi, Mid, T: Integer;
  begin
    Lo := iLo;
    Hi := iHi;
    Mid := A2[(Lo + Hi) div 2];
    repeat
      while A2[Lo] < Mid do Inc(Lo);
      while A2[Hi] > Mid do Dec(Hi);
      if Lo <= Hi then begin
        T := A1[Lo];
        A1[Lo] := A1[Hi];
        A1[Hi] := T;
        T := A2[Lo];
        A2[Lo] := A2[Hi];
        A2[Hi] := T;
        Inc(Lo); Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QuickSort(iLo, Hi);
    if Lo < iHi then QuickSort(Lo, iHi);
  end;

begin
// sorts by a2, changes also a1
  if last < Low(A2) then
    StdRutMsgHalt( 'TSmIntPair.Sort: last', 4 ) ;
  QuickSort(Low(A2), last);
end;

// *******
// ******* class TSmIntrealPairArray

constructor TSmIntRealPairArray.Create( Sz: integer ) ;
begin
  Size := sz ;
  SetLength( a, Size ) ;
  SetLength( r, Size ) ;
  last := -1 ;
end ;

procedure TSmIntRealPairArray.Add( aEl: integer ; rEl: real ) ;
begin
  last := last + 1 ;
  if last >= Size then
    StdRutMsgHalt( 'TSmIntRealPairArray.Add: Prevec elementov',4 ) ;
  a[last] := aEl ;
  r[last] := rEl ;
end ;

procedure TSmIntRealPairArray.SortbyR ;
  procedure QuickSort(iLo, iHi: Integer);
  var
    Lo, Hi, T: integer;
    TR, Mid : real ;
  begin
    Lo := iLo;
    Hi := iHi;
    Mid := R[(Lo + Hi) div 2];
    repeat
      while R[Lo] < Mid do Inc(Lo);
      while R[Hi] > Mid do Dec(Hi);
      if Lo <= Hi then begin
        T := A[Lo];
        A[Lo] := A[Hi];
        A[Hi] := T;
        TR := R[Lo];
        R[Lo] := R[Hi];
        R[Hi] := TR;
        Inc(Lo); Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QuickSort(iLo, Hi);
    if Lo < iHi then QuickSort(Lo, iHi);
  end;

begin
// sorts by a2, changes also a1
  if last < Low(R) then
    StdRutMsgHalt( 'TSmIntRealPair.Sort: last',4 ) ;
  QuickSort(Low(R), last);
end;

procedure TSmIntRealPairArray.tst ;
var
  i: integer ;
begin
  for i := 0 to High(r) do begin
    a[i] := i ;
    r[i] := - i / 10 ;
  end ;
  last := 4 ;
  SortByR ;
  last := 19 ;
  SortByR ;
  last := 4 ;
  SortByR ;
end ;


end.
