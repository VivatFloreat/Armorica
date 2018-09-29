unit LogForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls,DBTables,Registry,bde,DBCtrls, DBLists,
  RxDBComb, RXLookup, Db,  Mask, ToolEdit, BASE;

type
  TFormLogin = class(TfmBase)
    Panel1: TPanel;
    Panel2: TPanel;
    bbPotrdi: TBitBtn;
    bbPozabi: TBitBtn;
    Panel5: TPanel;
    paPassword: TPanel;
    Panel6: TPanel;
    lblIme: TLabel;
    lblGeslo: TLabel;
    edtUserName: TEdit;
    edtPassword: TEdit;
    paAlias: TPanel;
    Panel7: TPanel;
    Label1: TLabel;
    paMessage: TPanel;
    lblMessage: TLabel;
    Image1: TImage;
    Image2: TImage;
    spErrDetail: TSpeedButton;
    Panel3: TPanel;
    Image3: TImage;
    Panel4: TPanel;
    Image4: TImage;
    DataSource1: TDataSource;
    cbTNS: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure cbAliasChange(Sender: TObject);
    procedure spErrDetailClick(Sender: TObject);
    procedure bbPotrdiClick(Sender: TObject);
    procedure bbPozabiClick(Sender: TObject);
    procedure paMessageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
    Login_Attempts: Integer;
    procedure OpenDatabase(LogForm:Boolean);

  public
    { Public declarations }
  end;

const
  Max_Attempts_Allowed: integer = 3;

var
  FormLogin: TFormLogin;
  myMain: TForm;
  sSERVERNAME: string;
  aUserName, aPassword: string;

implementation

uses dmOra, ResStr, ResStrings;

{$R *.DFM}

var
 ErrDetail:String;

procedure TFormLogin.FormCreate(Sender: TObject);
var
  Reg: TRegistry;
  i: word;
  LogString: String;
  sTNSNAMES: String;
  sDEFAULT_TNS_ALIAS: String;
  sDEFAULT_UNAME: String;

 {$IFDEF DELPHI3}
   USize :LongInt;
 {$ENDIF DELPHI3}

 {$IFDEF DELPHI6}
   USize :LongWord;
 {$ENDIF DELPHI6}

   procedure TNStoCOMBO(sTNSNAMES:String);
   var slTNS :TStringList;
   begin
      slTNS := TStringList.Create;
      try
         repeat
            if (pos(';',sTNSNAMES) <> 0) then begin
               slTNS.Add(copy(sTNSNAMES,1,pos(';',sTNSNAMES)-1));
               sTNSNAMES := copy(sTNSNAMES,pos(';',sTNSNAMES)+1,length(sTNSNAMES));
            end else begin
               slTNS.Add(copy(sTNSNAMES,1,length(sTNSNAMES)));
               sTNSNAMES := '';
            end;
         until (length(sTNSNAMES)= 0);
         slTNS.Sort;
         cbTNS.Items := slTNS;
         cbTNS.Text := slTNS.Strings[0];
         if cbTNS.Items.IndexOf(sDEFAULT_TNS_ALIAS) <> -1 then
            cbTNS.ItemIndex:=cbTNS.Items.IndexOf(sDEFAULT_TNS_ALIAS);
      finally
         slTNS.Destroy;
      end;
   end;

begin
   dmOracle.OraSession.Connected := False;
   Reg := TRegistry.Create;
   try
     Reg.OpenKey(C_REGISTRY_KEYNAME_BASE, True);
     if Reg.ValueExists('TNSNAMES') then
       sTNSNAMES := AnsiUpperCase(Reg.ReadString('TNSNAMES'))
     else
       Reg.WriteString('TNSNAMES','');

     if Reg.ValueExists('DEFAULT_TNS_ALIAS') then
       sDEFAULT_TNS_ALIAS := AnsiUpperCase(Reg.ReadString('DEFAULT_TNS_ALIAS'))
     else
       Reg.WriteString('DEFAULT_TNS_ALIAS', cbTNS.Text);

     if Reg.ValueExists('USERNAME') then
       sDEFAULT_UNAME := AnsiUpperCase(Reg.ReadString('USERNAME'))
     else
       Reg.WriteString('USERNAME','');

   finally
      Reg.Free;
   end;

   TNStoCOMBO(sTNSNAMES);
   edtUserName.Text := sDEFAULT_UNAME;

   //Connect string preberem kot parameter programa (RIS/RIS@NTSERVER)

   if ParamCount <> 0 then begin
      LogString := ParamStr(1);
      sSERVERNAME :=copy(LogString,pos('@',LogString)+1,length(LogString)+1);
      aUserName:=copy(LogString,1,pos('/',LogString)-1);
      aPassword:=copy(LogString,pos('/',LogString)+1,(pos('@',LogString)-pos('/',LogString)-1));
      OpenDatabase(false);
   end;

end;


procedure TFormLogin.FormShow(Sender: TObject);
var Appl: string;
begin
   FormLogin.Height:=285;
   spErrDetail.Visible := False;

   Caption := dmOracle.GetVersionInfo;
   //if cbTNS.Items.Count = 0 then begin
     FormLogin.Height:=326;
     paAlias.Visible:=True;
   //end;

   if length(cbTNS.Text) = 0 then
     cbTNS.SetFocus
   else if length(edtUserName.text) = 0 then
     edtUserName.SetFocus
   else
     edtPassword.SetFocus;
end;

procedure TFormLogin.OpenDatabase(LogForm:Boolean);
var ErrorCode : String;

  procedure COMBOtoTNS;
  var slTNS :TStringList;
    sTNS :String;
    i:Integer;
    Reg : TRegistry;
  begin
     slTNS := TStringList.Create;
     try
      slTNS.AddStrings(cbTNS.Items);
      if slTNS.IndexOf(cbTNS.Text) = -1 then
        slTNS.Add(cbTNS.Text);
      slTNS.Sort;
      for i := 0 to slTNS.Count -1 do begin
        if length(sTNS)>0 then  sTNS := sTNS+ ';';
        sTNS := sTNS + slTNS.Strings[i];
      end;

      if length(sTNS)>0 then begin
       Reg := TRegistry.Create;
       try
          Reg.OpenKey(C_REGISTRY_KEYNAME_BASE, True);
          Reg.WriteString('TNSNAMES',sTNS);
          Reg.WriteString('DEFAULT_TNS_ALIAS', cbTNS.Text);
          Reg.WriteString('USERNAME', edtUserName.Text );
       finally
        Reg.Free;
       end;
      end;

     finally
       slTNS.Destroy;
     end;
  end;

begin

   if LogForm then begin
      //v tem primeru je LogForm viden
      inc(Login_Attempts);
      Image2.Visible:=False;
      Image1.Visible:=False;
      lblMessage.Width := paMessage.Width - 10;

      Refresh;

      dmOracle.oraSession.LogonDatabase := cbTNS.text;
      dmOracle.oraSession.LogonPassword := edtPassword.text;
      dmOracle.oraSession.LogonUsername := edtUserName.text;

      Screen.Cursor:=crHourglass;
      try
         dmOracle.oraSession.Connected := True;

         if dmOracle.oraSession.Connected then begin
            COMBOtoTNS;
            Close;
         end;

      except
         on E:Exception do begin
            Screen.Cursor:= crDefault;
            spErrDetail.Visible := true;
            ErrDetail := E.Message+edtUserName.text+'/'+edtPassword.text+'@'+cbTNS.text;

            lblMessage.Caption := E.Message;
            ErrorCode := '';
            if pos('ORA-',E.Message) <> 0 then
               ErrorCode := trim(copy(E.Message,pos('ORA-',E.Message),pos(':',E.Message)-1));
            Image1.Visible:=True;
            if ErrorCode = 'ORA-01017' then
               lblMessage.Caption := 'Napaèno uporabniško ime ali geslo!'
            else begin
               lblMessage.Caption := 'Napaka pri prijavi; '+ErrorCode;
            end;

            if Login_Attempts = Max_Attempts_Allowed then begin
               Screen.Cursor:=crDefault;
               sleep(1000);
               Image1.Visible:=False;
               Image2.Visible:=True;
               Refresh;
               sleep(2000);
               Close;
            end;
         end;
      end;
   end else begin
      //Oziroma kadar se program klièe s connectStringom = *.exe -uusername/password@tnsalias

      dmOracle.oraSession.LogonDatabase := sSERVERNAME;
      dmOracle.oraSession.LogonPassword := aPassword;
      dmOracle.oraSession.LogonUsername := aUserName;

      try
         dmOracle.oraSession.Connected := True;
      except
         on E:Exception do begin
            OpenDatabase(true);
         end;
      end;
 end;

end;

procedure TFormLogin.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
   spErrDetail.Visible := False;
   if Key = #13 then begin
    Key := #0;
    PostMessage(Handle, WM_NEXTDLGCTL,0,0);
   end;
end;

procedure TFormLogin.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then begin
    Key := #0;
    bbPotrdiClick(nil);
  end;
end;

procedure TFormLogin.cbAliasChange(Sender: TObject);
begin
  inherited;
  edtPassword.SetFocus;
end;

procedure TFormLogin.spErrDetailClick(Sender: TObject);
begin
  inherited;
  MessageDlg(ErrDetail,mtError,[mbOK],0);
end;

procedure TFormLogin.bbPotrdiClick(Sender: TObject);
begin
  inherited;
  spErrDetail.Visible := False;
  edtUserName.SetFocus;
  OpenDatabase(True);
end;

procedure TFormLogin.bbPozabiClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFormLogin.paMessageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   inherited;
   if (Shift = [ssShift,ssCtrl,ssLeft]) then begin
      FormLogin.Height:=317;
      paAlias.Visible:=True;
   end else begin
      FormLogin.Height:=285;
      paAlias.Visible:=False;
   end;
end;

end.
