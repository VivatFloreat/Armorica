unit fmRazDemOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, RxLookup, Buttons, Oracle,
  cxGridDBDataDefinitions, cxGridCustomTableView;

type
  TfmRazpDemOpt = class(TForm)
    Panel1: TPanel;
    paDM: TPanel;
    edFromDM: TcxDateEdit;
    edToDM: TcxDateEdit;
    Label1: TLabel;
    Label3: TLabel;
    Panel3: TPanel;
    bbOK: TBitBtn;
    bbCancel: TBitBtn;
    Label7: TLabel;
    laCount: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bbOKClick(Sender: TObject);
  private
    { Private declarations }
    f_adc: TcxGridDBDataController;
    procedure CheckInputs;
    procedure RazporediDM;
  public
    { Public declarations }
  end;

var
  fmRazpDemOpt: TfmRazpDemOpt;

implementation

uses dmOra, fmRisDepa, resStrings;
{$R *.dfm}

procedure TfmRazpDemOpt.FormCreate(Sender: TObject);
begin
   f_adc := fmRis_Depa.viDeMe.DataController;
   laCount.Caption := IntToStr(f_adc.GetSelectedCount);
   edFromDM.Date := dmOracle.paramDateRazpFrom;
end;

procedure TfmRazpDemOpt.CheckInputs;
begin
   if (f_adc.GetSelectedCount <= 0) then
      raise Exception.Create(C_EXCEPT_MSG_SELECT_DM);

   if (edFromDM.Date = Null) or (edFromDM.Date <= 0) then begin
      edFromDM.SetFocus;
      raise Exception.Create(C_EXCEPT_MSG_SELECT_DATE_FROM_DM);
   end;
end;

procedure TfmRazpDemOpt.RazporediDM;
var i, ri: integer;
    f_dem_id: integer;
begin
   for i:= 0 to f_adc.GetSelectedCount-1 do begin
      ri := f_adc.GetSelectedRowIndex(i);
      f_adc.ChangeFocusedRowIndex(ri);
      f_dem_id := f_adc.DataSet.FieldByName('ID').Value;

      with fmRis_Depa.quArmDeDm do begin
         Insert;
         FieldByName('DEM_ID').AsInteger := f_dem_id;
         FieldByname ('VELJA_OD').AsDateTime := edFromDM.Date;
         if (edToDM.Date <> Null) and (edToDM.Date > 0) then
            FieldByname ('VELJA_DO').AsDateTime := edToDM.Date;
         Post;
      end;
   end;
end;


procedure TfmRazpDemOpt.bbOKClick(Sender: TObject);
begin
   CheckInputs;
   RazporediDM;
   MessageDlg (C_FMRAZPDEMOPT_DODELITEV_OK, mtInformation, [mbOk], 0);
end;

end.
