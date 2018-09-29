unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, dmOra,
  Grids, DBGrids, Menus, SpeedBar, ExtCtrls, OleCtrls, SHDocVw, DB,
  OracleData, ComCtrls, cxListView, cxControls, cxContainer, cxTreeView,
  ToolWin, dxsbar;

type
  TfmMain = class(TForm)
    mnuMain: TMainMenu;
    Priprava1: TMenuItem;
    Delovia1: TMenuItem;
    Delovneizmene1: TMenuItem;
    Delovnamesta1: TMenuItem;
    Matinipodatki1: TMenuItem;
    Razporedi1: TMenuItem;
    Novmeseniplan1: TMenuItem;
    Kopiranje1: TMenuItem;
    Pregledzaposlenih1: TMenuItem;
    Pregledrazporeditev1: TMenuItem;
    DDMIgenerator1: TMenuItem;
    Uvozrazultatov1: TMenuItem;
    Pregledplana1: TMenuItem;
    miArprint: TMenuItem;
    quReports: TOracleDataSet;
    quReportsRPT_NAME: TStringField;
    quReportsRPT_PARAMS: TStringField;
    StatusBar1: TStatusBar;
    Oprogramu1: TMenuItem;
    Organizacijskestrukture1: TMenuItem;
    Organizacijskesheme1: TMenuItem;
    Organizacijskeenote1: TMenuItem;
    N2: TMenuItem;
    Arsolv1: TMenuItem;
    Planiranje1: TMenuItem;
    ToolBar1: TToolBar;
    tbMaticni: TToolButton;
    tbRazporeditve: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    N1: TMenuItem;
    miDDMIGenfast: TMenuItem;
    miNewPassword: TMenuItem;
    miPonastavi: TMenuItem;
    miParams: TMenuItem;
    miLogon: TMenuItem;
    procedure Delovneizmene1Click(Sender: TObject);
    procedure Delovnamesta1Click(Sender: TObject);
    procedure Delovia1Click(Sender: TObject);
    procedure Novmeseniplan1Click(Sender: TObject);
    procedure siPlanDeloClick(Sender: TObject);
    procedure Pregledzaposlenih1Click(Sender: TObject);
    procedure Pregledrazporeditev1Click(Sender: TObject);
    procedure Pregledplana1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Oprogramu1Click(Sender: TObject);
    procedure Kopiranje1Click(Sender: TObject);
    procedure Dnevnirazpored1Click(Sender: TObject);
    procedure Organizacijskeenote1Click(Sender: TObject);
    procedure Organizacijskesheme1Click(Sender: TObject);
    procedure miNewPasswordClick(Sender: TObject);
    procedure miPonastaviClick(Sender: TObject);
    procedure miParamsClick(Sender: TObject);
    procedure miLogonClick(Sender: TObject);
  private
    { Private declarations }
    myMenuHandler:TNotifyEvent;
    procedure DynamicMenuHandler(Sender: TObject);
    procedure DynaMenuLoad;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses fmRisShif, fmArmDeme, fmRisDepa, fmPlanW1, fmPlanDelo,
  fmEmp, fmRazDem, fmRazpOsebNew,
  fmArPrint, About, fmKopirajPlan, fmRazDnevni, fmDepart, fmOrgSheme,
  fmPassword, resStrings, appRegistry, fmParams, LogForm;

{$R *.DFM}

procedure TfmMain.Delovneizmene1Click(Sender: TObject);
begin
     fmRis_Shif := TfmRis_Shif.create(self);
     fmRis_Shif.ShowModal;
     fmRis_Shif.Destroy;
end;

procedure TfmMain.Delovnamesta1Click(Sender: TObject);
begin
   fmArm_Deme := TfmArm_Deme.create(self);
   fmArm_Deme.ShowModal;
   fmArm_Deme.Destroy;
end;

procedure TfmMain.Delovia1Click(Sender: TObject);
begin
   fmRis_Depa := TfmRis_Depa.create(self);
   fmRis_Depa.ShowModal;
   fmRis_Depa.Destroy;
end;

procedure TfmMain.Novmeseniplan1Click(Sender: TObject);
begin
   fmPlan := tFmPlan.Create(self);
   fmPlan.ShowModal;
   fmPlan.Destroy;
end;

procedure TfmMain.siPlanDeloClick(Sender: TObject);
begin
   Novmeseniplan1Click(Sender);
end;

procedure TfmMain.Pregledzaposlenih1Click(Sender: TObject);
begin
   fmEmployee := TfmEmployee.Create(self);
   fmEmployee.ShowModal;
   fmEmployee.Destroy;
end;

procedure TfmMain.Pregledrazporeditev1Click(Sender: TObject);
begin
   fmRazpDem := TfmRazpDem.Create (self);
   fmRazpDem.ShowModal;
   fmRazpDem.Destroy;
end;

procedure TfmMain.Pregledplana1Click(Sender: TObject);
begin
   fmRazp := tFmRazp.Create(self);
   fmRazp.ShowModal;
   fmRazp.Destroy;
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
   DynaMenuLoad;
end;

procedure TfmMain.DynaMenuLoad;
var mi: TMenuItem;
begin
   with quReports do begin
      Open;
      while not EOF do begin
         mi := TMenuItem.Create(mnuMain);
         mi.Caption := quReportsRPT_NAME.AsString;
         mi.Hint := quReportsRPT_PARAMS.AsString;
         mi.OnClick := myMenuHandler;
         miArprint.Add(mi);
         Next;
      end;
      Close;
   end;
end;

procedure TfmMain.DynamicMenuHandler(Sender: TObject);
var aMi: TMenuItem;
begin
   if Sender is TMenuItem then begin
      aMi := Sender as TMenuItem;
      fmPrint := TfmPrint.Create(self, aMi.Caption, aMi.Hint);
      fmPrint.ShowModal;
      fmPrint.Destroy;
   end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   myMenuHandler := DynamicMenuHandler;
   Caption := dmOracle.GetVersionInfo;
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
   with dmOracle.oraSession do begin
      StatusBar1.Panels[0].Text := 'Uporabnik: ' + UpperCase(LogonUserName + '@' + LogonDataBase);
   end;
end;

procedure TfmMain.Oprogramu1Click(Sender: TObject);
begin
   fmAbout := TfmAbout.Create (self);
   fmAbout.ShowModal;
   fmAbout.Destroy;
end;

procedure TfmMain.Kopiranje1Click(Sender: TObject);
begin
   fmCopyPlan := tFmCopyPlan.create(self);
   fmCopyPlan.ShowModal;
   fmCopyPlan.destroy;
end;

procedure TfmMain.Dnevnirazpored1Click(Sender: TObject);
begin
   fmRazpD := tFmRazpD.create(self);
   fmRazpD.ShowModal;
   fmrazpD.Destroy;
end;

procedure TfmMain.Organizacijskeenote1Click(Sender: TObject);
begin
   fmDepa := tFmDepa.Create(self);
   fmDepa.ShowModal;
   fmDepa.Destroy;
end;

procedure TfmMain.Organizacijskesheme1Click(Sender: TObject);
begin
   fmOrg_Sheme := TfmOrg_Sheme.create(self);
   fmOrg_Sheme.ShowModal;
   fmOrg_Sheme.Destroy;
end;

procedure TfmMain.miNewPasswordClick(Sender: TObject);
begin
   fmPass := tFmPass.Create(self);
   fmPass.ShowModal;
   fmPass.Destroy;
end;

procedure TfmMain.miPonastaviClick(Sender: TObject);
var aReg: tAppRegistry;
begin
   if MessageDlg(C_FMMAIN_PONASTAVI_VSE, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
         exit;

   aReg := tAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aReg.DeleteSubKey(C_REGISTRY_KEYNAME_ARGUI);
end;

procedure TfmMain.miParamsClick(Sender: TObject);
begin
   fmParam := tFmParam.Create(self);
   fmParam.ShowModal;
   fmParam.Destroy;
end;

procedure TfmMain.miLogonClick(Sender: TObject);
begin
   dmOracle.oraSession.LogOff;
   FormLogin.ShowModal;
   if not dmOracle.oraSession.Connected then
      Application.Terminate;
   FormShow(Sender);
end;

end.
