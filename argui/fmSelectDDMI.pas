unit fmSelectDDMI;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, ExtCtrls, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, OracleData, StdCtrls, Buttons, Mask, ToolEdit,
  cxContainer, cxMCListBox, solver;

type
  TfmSelDDMI = class(TForm)
    quDDMIOsebe: TOracleDataSet;
    dsDDMIOsebe: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    bbCancel: TBitBtn;
    bbOk: TBitBtn;
    Panel3: TPanel;
    edMNR: TEdit;
    edDatumOd: TDateEdit;
    edDatumDo: TDateEdit;
    quDDMIOsebeDEPART_ID: TFloatField;
    quDDMIOsebeDEPART: TStringField;
    quDDMIOsebeDESCRIPTION: TStringField;
    quDDMIOsebeDEM_ID: TFloatField;
    quDDMIOsebeNAZIV: TStringField;
    quDDMIOsebeSHIFT_ID: TFloatField;
    quDDMIOsebeDESCRIPTION_1: TStringField;
    quDDMIOsebeSHIFT_NO: TIntegerField;
    quDDMIOsebeARM_OZNAKA: TStringField;
    quDDMIOsebeSIFRA: TStringField;
    lbDDMIs: TcxMCListBox;
    procedure FormActivate(Sender: TObject);
    procedure lbDDMIsDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure PopulateListBox;
  public
    { Public declarations }
  end;

var
  fmSelDDMI: TfmSelDDMI;

implementation

{$R *.dfm}

procedure TfmSelDDMI.FormActivate(Sender: TObject);
begin
   quDDMIOsebe.Close;
   quDDMiOsebe.SetVariable('MNR', StrToInt(edMNR.Text));
   quDDMiOsebe.SetVariable('P_DATUM_OD', edDatumOd.Date);
   quDDMiOsebe.SetVariable('P_DATUM_DO', edDatumDo.Date);
   quDDMIOsebe.Open;
   PopulateListBox;
end;

procedure TfmSelDDMI.PopulateListBox;
var
   aMNR: integer;
   aList: TList;
   i: integer;
   aDDMIElem: pDDMIElem;
   aTxt: string;
begin
   aMNR := StrToInt(edMNR.Text);
   aList := globSolver.Availability.GetListForOsebaDayByMNR(aMNR, edDatumOd.Date);
   for i := 0 to aList.Count - 1 do begin
      aDDMIElem := pDDMIElem(aList.Items[i]);
      aTxt := Format ('%d;%d;%s;%s;%s (%s - %s)',
                      [aDDMIElem^.ddmi_nr,
                       Integer(aDDMIElem^.shift_no),
                       aDDMIElem^.dem_naziv,
                       aDDMIElem^.depa_opis,
                       aDDMIElem^.shift_desc,
                       solver.FmtHoursHHMM(aDDMIElem^.start_hhmm),
                       solver.FmtHoursHHMM(aDDMIElem^.stop_hhmm)]);

      lbDDMIs.AddItem(aTxt, nil);
   end;
end;

procedure TfmSelDDMI.lbDDMIsDblClick(Sender: TObject);
begin
   ModalResult := mrOk;
end;

end.
