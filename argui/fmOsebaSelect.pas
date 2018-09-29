unit fmOsebaSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Contnrs,
  Dialogs, StdCtrls, Solver, cxControls, cxContainer, cxListBox, ExtCtrls,
  Buttons, cxMCListBox;

type
  TfmOsebaSelectDDMI = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    laDDMI: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    lbOsebe1: TcxMCListBox;
    procedure FormCreate(Sender: TObject);
    procedure lbOsebeDblClick(Sender: TObject);
    procedure lbOsebe1DblClick(Sender: TObject);
  private
    { Private declarations }
    fList: TObjectList;
    fDDMI: pDDMIElem;
    procedure PopulateListBox;
  public
    { Public declarations }
    constructor Create (aOwner:tComponent; aList: TObjectList; aDDMI: pDDMIElem);
  end;

var
  fmOsebaSelectDDMI: TfmOsebaSelectDDMI;

implementation

{$R *.dfm}


constructor TfmOsebaSelectDDMI.Create (aOwner:tComponent; aList: TObjectList; aDDMI: pDDMIElem);
begin
   inherited Create(aOwner);
   fList := aList;
   fDDMI := aDDMI;
end;

procedure TfmOsebaSelectDDMI.FormCreate(Sender: TObject);
var
   aLbl: string;
begin
   PopulateListBox;
   aLbl := Format('%s - %s - %s', [fDDMI^.depa_opis, fDDMI^.dem_naziv, fDDMI^.shift_desc]);
   laDDMI.Caption := aLbl;
end;

procedure TfmOsebaSelectDDMI.PopulateListBox;
var i: integer;
    aTxt, aHrs, aSunHoly: String;
    aOseba: tOseba;
    aCritHrs, aCritSunHoly: tCriteria;
begin
   lbOsebe1.Items.Clear;
   for i:=0 to fList.Count - 1 do begin
      aOseba := tOseba(fList.Items[i]);
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

      aCritSunHoly := aOseba.GetCriteria(ctSunHoly);
      aTxt:=Format('%d;%s;%s;%s;%s', [aOseba.MNR, aOseba.lname, aOseba.fname,aHrs, aSunHoly]);
      lbOsebe1.AddItem(aTxt, aOseba);
   end;
end;

procedure TfmOsebaSelectDDMI.lbOsebeDblClick(Sender: TObject);
begin
   Modalresult := mrOk;
end;

procedure TfmOsebaSelectDDMI.lbOsebe1DblClick(Sender: TObject);
begin
   Modalresult := mrOk;
end;

end.
