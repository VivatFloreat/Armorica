unit fmRazOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, RxLookup, Buttons, Oracle,
  cxGridDBDataDefinitions, cxGridCustomTableView;

type
  TfmRazpOpt = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    paDM: TPanel;
    cbDM: TCheckBox;
    edFromDM: TcxDateEdit;
    edToDM: TcxDateEdit;
    Label1: TLabel;
    Label3: TLabel;
    cbDMOldDelete: TCheckBox;
    Panel3: TPanel;
    bbOK: TBitBtn;
    bbCancel: TBitBtn;
    dbDM: TRxDBLookupCombo;
    Label5: TLabel;
    Panel5: TPanel;
    Panel4: TPanel;
    cbDEL: TCheckBox;
    paDEL: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    edFromDEL: TcxDateEdit;
    edToDel: TcxDateEdit;
    cbDELOldDelete: TCheckBox;
    Label6: TLabel;
    spInsRazp: TOracleQuery;
    Label7: TLabel;
    laCount: TLabel;
    dbDEL: TRxDBLookupCombo;
    cbStatusDM: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    cbStatusDEL: TComboBox;
    Panel6: TPanel;
    Panel7: TPanel;
    cbSHIF: TCheckBox;
    paSHIF: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edFromSHIF: TcxDateEdit;
    edToSHIF: TcxDateEdit;
    cbSHIFOldDelete: TCheckBox;
    dbSHIF: TRxDBLookupCombo;
    cbStatusSHIF: TComboBox;
    procedure cbDMClick(Sender: TObject);
    procedure cbDELClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbOKClick(Sender: TObject);
    procedure cbSHIFClick(Sender: TObject);
  private
    { Private declarations }
    f_adc: TcxGridDBDataController;
    procedure CheckInputs;
    procedure RazporediDelavce;
  public
    { Public declarations }
  end;

var
  fmRazpOpt: TfmRazpOpt;

implementation

uses fmRazDem, dmOra;
{$R *.dfm}

procedure TfmRazpOpt.cbDMClick(Sender: TObject);
begin
   if cbDM.Checked then
      paDM.Visible := true
   else
      paDM.Visible := false;
end;

procedure TfmRazpOpt.cbDELClick(Sender: TObject);
begin
   if cbDEL.Checked then
      paDEL.Visible := true
   else
      PAdel.Visible := FALSE;
end;

procedure TfmRazpOpt.FormCreate(Sender: TObject);
begin
   f_adc := fmRazpDem.tvUCard.DataController;
   laCount.Caption := IntToStr(f_adc.GetSelectedCount);
   edFromDM.Date := dmOracle.paramDateRazpFrom;
   edFromDEL.Date := dmOracle.paramDateRazpFrom;
   edFromShif.Date := dmOracle.paramDateRazpFrom;
end;

procedure TfmRazpOpt.CheckInputs;
begin
   if cbDM.Checked then begin
      if dbDM.KeyValue = Null then begin
        fmRazpOpt.dbDM.SetFocus;
        raise Exception.Create('Prosim izberite delovno mesto!');
      end;

      if (edFromDM.Date = Null) or (edFromDM.Date <= 0) then begin
         fmRazpOpt.edFromDM.SetFocus;
         raise Exception.Create('Prosim izberite zaèetek razporeditve na delovno mesto!');
      end;
   end;

   if cbDEL.Checked then begin
      if dbDEL.KeyValue = Null then begin
        fmRazpOpt.dbDEL.SetFocus;
        raise Exception.Create('Prosim izberite delovišèe!');
      end;

      if (edFromDEL.Date = Null) or (edFromDEL.Date <= 0) then begin
         fmRazpOpt.edFromDEL.SetFocus;
         raise Exception.Create('Prosim izberite zaèetek razporeditve na delovišèe!');
      end;
   end;

   if cbSHIF.Checked then begin
      if dbSHIF.KeyValue = Null then begin
        fmRazpOpt.dbSHIF.SetFocus;
        raise Exception.Create('Prosim izberite izmeno!');
      end;

      if (edFromSHIF.Date = Null) or (edFromSHIF.Date <= 0) then begin
         fmRazpOpt.edFromSHIF.SetFocus;
         raise Exception.Create('Prosim izberite zaèetek razporeditve v izmeno!');
      end;
   end;


end;

procedure TfmRazpOpt.RazporediDelavce;
var i, ri: integer;
    f_mnr: integer;
    f_status, f_delete: string;
begin
   if not (cbDM.Checked or cbDEL.Checked or cbSHIF.Checked) then
      raise Exception.Create('Izberite vsaj eno vrsto razporeditev!');

   for i:= 0 to f_adc.GetSelectedCount-1 do begin
      ri := f_adc.GetSelectedRowIndex(i);
      f_adc.ChangeFocusedRowIndex(ri);
      f_mnr := f_adc.DataSet.FieldByName('MNR').Value;

      if cbDM.Checked then begin
         if cbStatusDM.ItemIndex = 0 then
            f_status := 'P'
         else
            f_status := 'S';

         if cbDMOldDelete.Checked then
            f_delete := 'D'
         else
            f_delete := 'N';


         spInsRazp.Close;
         spInsRazp.ClearVariables;
         spInsRazp.SetVariable('P_MNR', f_mnr);
         spInsRazp.SetVariable('P_ODDELEK', dbDM.KeyValue);
         spInsRazp.SetVariable('P_STATUS', f_status);
         spInsRazp.SetVariable('P_FROM', edFromDM.Date);
         if edToDM.Text <> '' then
            spInsRazp.SetVariable('P_TO', edToDM.Date);
         spInsRazp.SetVariable('P_KAM', 'DM');
         spInsRazp.SetVariable('P_DELETE', f_delete);
         spInsRazp.Execute;
      end;

      if cbDEL.Checked then begin
         if cbStatusDEL.ItemIndex = 0 then
            f_status := 'P'
         else
            f_status := 'S';

         if cbDELOldDelete.Checked then
            f_delete := 'D'
         else
            f_delete := 'N';


         spInsRazp.Close;
         spInsRazp.ClearVariables;
         spInsRazp.SetVariable('P_MNR', f_mnr);
         spInsRazp.SetVariable('P_ODDELEK', dbDEL.KeyValue);
         spInsRazp.SetVariable('P_STATUS', f_status);
         spInsRazp.SetVariable('P_FROM', edFromDEL.Date);
         if edToDM.Text <> '' then
            spInsRazp.SetVariable('P_TO', edToDEL.Date);
         spInsRazp.SetVariable('P_KAM', 'DEL');
         spInsRazp.SetVariable('P_DELETE', f_delete);
         spInsRazp.Execute;
      end;

      if cbSHIF.Checked then begin
         if cbStatusSHIF.ItemIndex = 0 then
            f_status := 'P'
         else
            f_status := 'S';

         if cbSHIFOldDelete.Checked then
            f_delete := 'D'
         else
            f_delete := 'N';

         spInsRazp.Close;
         spInsRazp.ClearVariables;
         spInsRazp.SetVariable('P_MNR', f_mnr);
         spInsRazp.SetVariable('P_ODDELEK', dbSHIF.KeyValue);
         spInsRazp.SetVariable('P_STATUS', f_status);
         spInsRazp.SetVariable('P_FROM', edFromSHIF.Date);
         if edToSHIF.Text <> '' then
            spInsRazp.SetVariable('P_TO', edToSHIF.Date);
         spInsRazp.SetVariable('P_KAM', 'SHIF');
         spInsRazp.SetVariable('P_DELETE', f_delete);
         spInsRazp.Execute;
      end;

 end;
end;


procedure TfmRazpOpt.bbOKClick(Sender: TObject);
begin
   CheckInputs;
   RazporediDelavce;
   MessageDlg ('Razporeditev je uspela!', mtInformation, [mbOk], 0);
end;

procedure TfmRazpOpt.cbSHIFClick(Sender: TObject);
begin
   if cbSHIF.Checked then
      paSHIF.Visible := true
   else
      paSHIF.Visible := false;
end;

end.
