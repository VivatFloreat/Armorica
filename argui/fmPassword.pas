unit fmPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Oracle, Buttons;

type
  TfmPass = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edOld: TEdit;
    edNew: TEdit;
    Label2: TLabel;
    edCheck: TEdit;
    Label3: TLabel;
    bbOk: TBitBtn;
    BitBtn1: TBitBtn;
    spSpremeniGeslo: TOracleQuery;
    procedure bbOkClick(Sender: TObject);
    procedure PreveriGesla;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPass: TfmPass;

implementation

uses dmOra, ResStrings;

{$R *.dfm}

procedure TfmPass.PreveriGesla;
begin
   if (edOld.Text <> dmOracle.oraSession.LogonPassword) then begin
      edOld.SetFocus;
      raise Exception.Create(C_EXCEPT_MSG_OLD_PASSWORD_WRONG);
   end;

   if (edOld.text = edNew.Text) then begin
      edNew.SetFocus;
      raise Exception.Create (C_EXCEPT_MSG_NEW_PASSWORD_SAME);
   end;

   if (edNew.Text <> edCheck.Text) then begin
      edNew.SetFocus;
      raise Exception.Create (C_EXCEPT_MSG_NEW_PASSWORD_DONT_MATCH);
   end;

end;

procedure TfmPass.bbOkClick(Sender: TObject);
var Amsg: string;
begin
   PreveriGesla;
   with spSpremeniGeslo do begin
      SetVariable('P_USER', dmOracle.oraSession.LogonUsername);
      SetVariable('P_PASSWORD', edNew.Text);
      try
         Execute;
         MessageDlg (C_FMPASS_GESLO_SPREMENJENO_OK, mtInformation, [mbOk], 0);
         fmPass.ModalResult := mrOk;
      except
         on E:EOracleError do begin
            aMsg := C_FMPASS_GESLO_SPREMENJENO_ERR + ' Opis:' +  E.Message;
            MessageDlg (aMsg, mtError, [mbOk], 0);
         end;
      end;
   end;

end;

end.
