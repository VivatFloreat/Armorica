unit fmSolverOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit, cxControls,
  cxContainer, cxMCListBox, RXSplit;

type
  TfmSolverOpt = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    GroupBox1: TGroupBox;
    rbCritStrict: TRadioButton;
    rbCritAllow: TRadioButton;
    rbCritAuto: TRadioButton;
    gbDebug: TGroupBox;
    edDir: TDirectoryEdit;
    rbDebugNone: TRadioButton;
    rbDebugNormal: TRadioButton;
    rbDebugFull: TRadioButton;
    Panel3: TPanel;
    RxSplitter1: TRxSplitter;
    lbDDMIs: TcxMCListBox;
    Panel4: TPanel;
    rgScope: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure rbDebugNoneClick(Sender: TObject);
    procedure rgScopeClick(Sender: TObject);
  private
    { Private declarations }
    procedure PopulateDDMIListBox;
  public
    { Public declarations }
  end;

var
  fmSolverOpt: TfmSolverOpt;

implementation

{$R *.dfm}
uses Solver;


procedure TfmSolverOpt.FormCreate(Sender: TObject);
var aDir: string;
begin
   GetDir(0, aDir);
   edDir.Text := aDir;
   PopulateDDMIListBox;
end;

procedure TfmSolverOpt.rbDebugNoneClick(Sender: TObject);
begin
   edDir.Enabled := not (rbDebugNone.Checked);
end;

procedure TfmSolverOpt.rgScopeClick(Sender: TObject);
begin
   if rgScope.ItemIndex = 2 then
      Panel3.Visible := true
   else
      Panel3.Visible := false;
end;

procedure TfmSolverOpt.PopulateDDMIListBox;
var i: integer;
    aDDMI: pDDMIElem;
    aTxt: string;
begin
   for i:= 0 to globSolver.DDMIList.Count - 1 do begin
      aDDMI := pDDMIElem(globSolver.DDMIList.Items[i]);
      aTxt:=Format('%d;%d;%s;%s;%s', [aDDMI^.ddmi_nr,
                                      Integer(aDDMI^.shift_no),
                                      aDDMI^.dem_naziv,
                                      aDDMI^.depa_opis,
                                      aDDMI^.shift_desc]);
      if aDDMI^.shift_no <> C_ODS_SHIFT_NO then
         lbDDMIs.AddItem(aTxt, nil);
   end;
end;

end.
