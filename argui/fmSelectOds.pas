unit fmSelectOds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, OracleData;

type
  TfmSelOds = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bbOk: TBitBtn;
    BitBtn1: TBitBtn;
    cbOdobrena: TCheckBox;
    viOdsot: TcxGridDBTableView;
    leOdsot: TcxGridLevel;
    grOdsot: TcxGrid;
    quRisHour: TOracleDataSet;
    quRisHourHOURS_ID: TIntegerField;
    quRisHourVP_ID: TStringField;
    quRisHourDESCRIPTION: TStringField;
    quRisHourOPIS: TStringField;
    dsRisHour: TDataSource;
    viOdsotVP_ID: TcxGridDBColumn;
    viOdsotDESCRIPTION: TcxGridDBColumn;
    quRisHourVRSTNIRED: TFloatField;
    viOdsotVRSTNIRED: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure viOdsotDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSelOds: TfmSelOds;

implementation

uses fmSetOpt;

{$R *.dfm}

procedure TfmSelOds.FormCreate(Sender: TObject);
begin
   if not quRisHour.Active then
      quRisHour.Open;
   if (fmSettings <> nil) then begin
      if fmSettings.rgOdsotSource.ItemIndex > 0 then begin
         // Vir odsotnosti je urna lista, vedno vnašamo odobreno
         cbOdobrena.Checked := true;
         cbOdobrena.Enabled := false;
      end;
   end;
   viOdsot.DataController.Groups.FullExpand;
end;

procedure TfmSelOds.FormDestroy(Sender: TObject);
begin
   quRisHour.Close;
end;

procedure TfmSelOds.viOdsotDblClick(Sender: TObject);
begin
   Modalresult := mrOk;
end;

end.
