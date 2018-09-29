program argui;

uses
  Forms,
  main in 'main.pas' {fmMain},
  dmOra in 'dmOra.pas' {dmOracle: TDataModule},
  fmArmDeme in 'fmArmDeme.pas' {fmArm_Deme},
  fmRisDepa in 'fmRisDepa.pas' {fmRis_Depa},
  fmRisShif in 'fmRisShif.pas' {fmRis_Shif},
  LogForm in 'LogForm.pas' {FormLogin},
  fmEmp in 'fmEmp.pas' {fmEmployee},
  fmEmpDetail in 'fmEmpDetail.pas' {fmEmpDet},
  fmRazDem in 'fmRazDem.pas' {fmRazpDem},
  fmRazOpt in 'fmRazOpt.pas' {fmRazpOpt},
  fmPlanDelo in 'fmPlanDelo.pas' {fmPlan},
  fmRazpOsebNew in 'fmRazpOsebNew.pas' {fmRazp},
  fmArPrint in 'fmArPrint.pas' {fmPrint},
  fmSelectDDMI in 'fmSelectDDMI.pas' {fmSelDDMI},
  base in '..\..\REP\BASE.pas' {fmBase},
  About in 'About.pas' {fmAbout},
  globals in 'globals.pas' {fmGlobals},
  fmFreeIDCard in 'fmFreeIDCard.pas' {fmSelFreeIDCard},
  fmSelectOds in 'fmSelectOds.pas' {fmSelOds},
  fmKopirajPlan in 'fmKopirajPlan.pas' {fmCopyPlan},
  fmRazDnevni in 'fmRazDnevni.pas' {fmRazpD},
  fmDepart in 'fmDepart.pas' {fmDepa},
  solver in 'solver.pas',
  fmRazpDelOpt in 'fmRazpDelOpt.pas' {fmRazpDeleteOpt},
  fmPersonalData in 'fmPersonalData.pas' {fmPersData},
  fmProgressShow in 'fmProgressShow.pas' {fmProgress},
  ResStrings in 'ResStrings.pas',
  fmOsebaSelect in 'fmOsebaSelect.pas' {fmOsebaSelectDDMI},
  tSolverEngine in 'tSolverEngine.pas',
  RazProbem in 'RazProbem.pas',
  RazProbemBase in 'RazProbemBase.pas',
  StdRut in 'StdRut.pas',
  fmSolverOptions in 'fmSolverOptions.pas' {fmSolverOpt},
  RazMain in 'RazMain.pas',
  fmDepartment in 'fmDepartment.pas' {fmDepart2},
  fmOrgSheme in 'fmOrgSheme.pas' {fmOrg_sheme},
  fmPassword in 'fmPassword.pas' {fmPass},
  fmSetOpt in 'fmSetOpt.pas' {fmSettings},
  AppRegistry in 'AppRegistry.pas',
  fmRazDemOpt in 'fmRazDemOpt.pas' {fmRazpDemOpt},
  fmSolveResults in 'fmSolveResults.pas' {fmResults},
  fmParams in 'fmParams.pas' {fmParam};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TdmOracle, dmOracle);
  Application.CreateForm(TfmMain, fmMain);
  FormLogin := TFormLogin.Create(Application);
  fmGlobals := tFmGlobals.Create(Application);

  if not dmOracle.oraSession.connected then
      FormLogin.ShowModal;

  if not dmOracle.oraSession.connected then
      exit;

  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
