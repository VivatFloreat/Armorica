unit fmPersonalData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  StdCtrls, ExtCtrls, solver, Buttons;

type
  TfmPersData = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    edMNR: TEdit;
    edLname: TEdit;
    edFName: TEdit;
    Label2: TLabel;
    bbOk: TBitBtn;
    BitBtn1: TBitBtn;
    edStartHHMM: TcxTextEdit;
    edStartNP: TcxTextEdit;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
  private
    { Private declarations }
    fOseba: tOseba;
    fCritHours: TCriteria;
    fCritNP: TCriteria;
  public
    { Public declarations }
    constructor Create (aOwner:tComponent; rIndx: integer);
  end;

var
  fmPersData: TfmPersData;

implementation

{$R *.dfm}

constructor tFmPersData.Create (aOwner:tComponent; rIndx: integer);
begin
   inherited Create(aOwner);
   if (rIndx >= globSolver.Razpored.StevOseb) or (rIndx < 0) then
      raise Exception.Create('Neveljaven indeks osebe! Indx=' + IntToStr(rIndx));

   fOseba := TOseba(globSolver.Osebe.Items[rIndx]);
   if fOseba = nil then
      raise Exception.Create('Ne najdem osebe! Indx=' + IntToStr(rIndx));

end;

procedure TfmPersData.FormCreate(Sender: TObject);
begin
   edMNR.Text := IntToStr(fOseba.MNR);
   edLname.Text := fOseba.lname;
   edfname.Text := fOseba.fname;

   fCritHours := fOseba.GetCriteria(ctHours);
   if fCritHours = nil then
      raise Exception.Create('Ne najdem kriterija - ure!');

   edStartHHMM.Text := FmtMinutesHHMM(fCritHours.StartHours,3);

   fCritNP := fOseba.GetCriteria(ctSunHoly);
   if fCritNP = nil then
      raise Exception.Create('Ne najdem kriterija - NP!');

   edStartNP.Text := IntToStr(fCritNP.StartDays);

end;

procedure TfmPersData.bbOkClick(Sender: TObject);
var
   aDvopicje, aPredznak, aHH, aMM, aMinutes: integer;
   aZacStanjeNP: integer;

begin
   try
      aDvopicje := System.Pos(':', edStartHHMM.Text);
      if aDvopicje <= 0 then
         Raise Exception.Create('Vpišite uro v obliki -000:00!');

      aPredznak := System.Pos('-', edStartHHMM.Text);

      aHH := StrToInt(Copy(edStartHHMM.Text, aPredznak + 1, 3));
      aMM := StrToInt(Copy(edStartHHMM.Text, aDvopicje + 1, 2));

      aMinutes := HHMM_To_Minutes(aHH*100 + aMM);

      if aPredznak > 0 then
         aMinutes := -1 * aMinutes;

      aZacStanjeNP := StrToInt (edStartNP.Text);


      fCritHours.InfluenceStartValues(aMinutes, 0);

      fCritNP.InfluenceStartValues(0, aZacStanjeNP);



   except
      modalResult := mrNone;
      raise;
   end;

end;

end.
