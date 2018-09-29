unit DDMIFinder;

interface

uses
   Classes, stdctrls, sysutils;

type
   tDDMI = record
      nr: integer;
      depart_id: variant;
      dem_id: variant;
      shift_id: variant;
   end;

   // pointer to structure
   pDDMI = ^tDDMI;

   TDDMIFinder = class(TObject)
      rowList: array of TList;
      fRowCount: integer;

   private
      procedure AddElement (nRow: integer; aElement: pDDMI);
      function GetElementCount (nRow: integer): integer;
      function GetFirstElement (nRow: integer; var aElement: pDDMI):boolean;
      function GetElementAtIndex (nRow: integer; idx: integer): pDDMI;

   public
      constructor Create;
      destructor Destroy;
      procedure Init (nRows: integer);
      function GetRowCount: integer;
      procedure AddDDMI (aRi, aDDMI: integer);
      function ContainsDDMI (aRi, aDDMI: integer):boolean;
      procedure ListAllDDMI (aRi: integer; aMemo: TMemo);
   end;

implementation

constructor TDDMIFinder.Create;
begin
end;

destructor TDDMIFinder.Destroy;
var i: integer;
begin
   inherited;
   for i:= 0 to fRowCount - 1 do begin
      rowList[i].Free;
   end;
   SetLength (rowList, 0);
end;

procedure TDDMIFinder.Init(nRows: integer);
var
   i: integer;
   aList: TList;

begin
   SetLength (rowList, nRows);
   fRowCount := nRows;
   for i:= 0 to nRows - 1 do begin
      aLIst := TList.Create;
      rowList[i]:= aList;
   end;
end;


procedure TDDMIFinder.AddElement (nRow: integer; aElement: pDDMI);
begin
   rowList[nRow].Add(aElement);
end;

function TDDMIFinder.GetFirstElement (nRow: integer; var aElement: pDDMI):boolean;
begin
   if rowList[nRow].Count > 0 then begin
      aElement := rowList[nRow].First;
      GetFirstElement := true;
   end else
      GetFirstElement := false;
end;

function TDDMIFinder.GetElementAtIndex (nRow: integer; idx: integer): pDDMI;
begin
   if rowList[nRow].Count >= idx then
      GetElementAtIndex := rowList[nRow].Items[idx]
   else
      GetElementAtIndex := nil;
end;

// PUBLIC methods

function TDDMIFinder.GetElementCount (nRow: integer): integer;
begin
   GetElementCount := rowList[nRow].Count;
end;

function TDDMIFinder.GetRowCount: integer;
begin
   GetRowCount := fRowCount;
end;

procedure TDDMIFinder.AddDDMI (aRi, aDDMI: integer);
var aPtr: pDDMI;
begin
   new (aPtr);
   aPtr^.nr := aDDMI;
   AddElement(aRi, aPtr);
end;

function TDDMIFinder.ContainsDDMI (aRi, aDDMI: integer):boolean;
var
   i: integer;
   ptd: pDDMI;
begin
   for i:=0 to GetElementCount (aRi) -1 do begin
      ptd := GetElementAtIndex (aRi, i);
      if ptd <> nil then begin
         if ptd^.nr = aDDMI then begin
            Result := true;
            exit;
         end;
      end;
   end;

   Result := false;

end;

procedure TDDMIFinder.ListAllDDMI (aRi: integer; aMemo: TMemo);
var
   i: integer;
   ptd: pDDMI;
   aLine: string;
begin
   aLine := '';
   for i:=0 to GetElementCount (aRi) -1 do begin
      ptd := GetElementAtIndex (aRi, i);
      if ptd <> nil then begin
         aLine := aLine + IntToStr(ptd^.nr) + ', ';
      end;
   end;
   aMemo.Lines.Add(aLine);
end;

end.
