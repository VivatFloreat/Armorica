unit fmKopirajPlan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ToolEdit, ExtCtrls, Buttons, Oracle, DB,
  OracleData, RxLookup;

type
  TfmCopyPlan = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edPon: TDateEdit;
    Label2: TLabel;
    edTor: TDateEdit;
    Label3: TLabel;
    edSre: TDateEdit;
    Label4: TLabel;
    edCet: TDateEdit;
    Label5: TLabel;
    edPet: TDateEdit;
    Label6: TLabel;
    edSob: TDateEdit;
    Label7: TLabel;
    edNed: TDateEdit;
    Label8: TLabel;
    edPra: TDateEdit;
    Label9: TLabel;
    edFrom: TDateEdit;
    Label10: TLabel;
    edTo: TDateEdit;
    cbDeleteOld: TCheckBox;
    Panel4: TPanel;
    bbOk: TBitBtn;
    BitBtn1: TBitBtn;
    spCopyPlan: TOracleQuery;
    quPrviPraz: TOracleDataSet;
    quPrviPrazPDATE: TDateTimeField;
    Label11: TLabel;
    cbPrenosID: TRxDBLookupCombo;
    procedure edPonChange(Sender: TObject);
    procedure edFromChange(Sender: TObject);
    procedure bbOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure SetAllOtherDates;
  public
    { Public declarations }
  end;

var
  fmCopyPlan: TfmCopyPlan;

implementation

{$R *.dfm}
uses DateUtils, dmOra, ResStrings;

procedure TfmCopyPlan.SetAllOtherDates;
begin
   if (edPon.Date <> 0) then begin
      if (edTor.Date = 0) then
         edTor.Date := edPon.Date + 1;

      if (edSre.Date = 0) then
         edSre.Date := edPon.Date + 2;

      if (edCet.Date = 0) then
         edCet.Date := edPon.Date + 3;

      if (edPet.Date = 0) then
         edPet.Date := edPon.Date + 4;

      if (edSob.Date = 0) then
         edSob.Date := edPon.Date + 5;

      if (edNed.Date = 0) then
         edNed.Date := edPon.Date + 6;

      if (edPra.Date = 0) then begin
         quPrviPraz.Close;
         quPrviPraz.SetVariable('P_DATE', edPon.Date);
         quPrviPraz.Open;
         edPra.Date := quPrviPrazPDATE.asdateTime;
      end;

   end;
end;


procedure TfmCopyPlan.edPonChange(Sender: TObject);
begin
   setAllOtherDates;
end;

procedure TfmCopyPlan.edFromChange(Sender: TObject);
begin
   if (edFrom.Date <> 0) then begin
      if (edTo.Date = 0) then
         edTo.Date := EndOfTheMonth(edFrom.Date);
   end;
end;

procedure TfmCopyPlan.bbOkClick(Sender: TObject);
begin
   if cbPrenosID.KeyValue = null then
      raise Exception.Create(C_EXCEPT_MSG_SELECT_OWNER);

   if edFrom.Date = 0 then begin
      edFrom.SetFocus;
      raise Exception.Create(C_FMKOPIRAJPLAN_EXCEPTION_BBOKCLICKDATEDOWN);
   end;

   if edTo.Date = 0 then begin
      edTo.setFocus;
      raise Exception.Create(C_FMKOPIRAJPLAN_EXCEPTION_BBOKCLICKDATEUP);
   end;

   if (cbdeleteOld.Checked) then begin
      if MessageDlg(C_FMKOPIRAJPLAN_MSG_BBOKCLICK,
                     mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      exit;
   end;

   try
      Screen.Cursor := crHourglass;

      with spCopyPlan do begin
         SetVariable('p_mnr_owner', cbPrenosId.KeyValue);
         SetVariable('p_datum_od', edFrom.Date);
         SetVariable('p_datum_do', edTo.Date);
         SetVariable('p_template_pon', edPon.Date);
         SetVariable('p_template_tor', edTor.Date);
         SetVariable('p_template_sre', edSre.Date);
         SetVariable('p_template_cet', edCet.Date);
         SetVariable('p_template_pet', edPet.Date);
         SetVariable('p_template_sob', edSob.Date);
         SetVariable('p_template_ned', edNed.Date);
         SetVariable('p_template_pra', edPra.Date);
         if cbDeleteOld.Checked then
            SetVariable('p_delete_old', 'D')
         else
            SetVariable('p_delete_old', 'N');
         Execute;
      end;
      dmOracle.oraSession.Commit;
      Screen.Cursor := crDefault;
      MessageDlg (C_FMKOPIRAJPLAN_MSG_BBOKCLICKGEN, mtInformation, [mbOk], 0);
   except
      Screen.Cursor := crDefault;
      MessageDlg (C_FMKOPIRAJPLAN_MSG_BBOKCLICKGENERR, mtError, [mbOk], 0);
   end;

end;

procedure TfmCopyPlan.FormCreate(Sender: TObject);
begin
   if not dmOracle.quLastniki.Active then
      dmOracle.quLastniki.Open;
   cbPrenosId.KeyValue := dmOracle.quLastniki.FieldByName('MNR').AsInteger;
end;

end.
