unit fmSolveResults;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfmResults = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    memo: TMemo;
    bbClose: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Header;
    procedure Footer;
  end;

var
  fmResults: TfmResults;

implementation

{$R *.dfm}
uses Solver, DateUtils;


procedure TfmResults.Header;
var aMsg: string;
    aDat1, aDat2: string;
begin
   memo.Clear;
   with globSolver do begin
      aDat1 := FormatDateTime('dd mmmm yyyy', Plan.FirstDay);
      aDat2 := FormatDateTime('dd mmmm yyyy', Plan.LastDay);
      aMsg := Format('Razreševanje razporeda za %d dni (%s do %s).',
                      [Plan.DayCount, aDat1, aDat2]);
      memo.Lines.Add(aMsg);
      aDat1 := FormatDateTime('hh:mm:ss.zzz', Date + Time);
      aMsg := Format ('Zaèetek razreševanja ob %s', [aDat1]);
      memo.Lines.Add(aMsg);
      memo.Lines.Add('=====================================================');
   end;
end;

procedure TfmResults.Footer;
var aMsg: string;
    aDat1: string;
begin
   aDat1 := FormatDateTime('hh:mm:ss.zzz', Date + Time);
   aMsg := Format ('Konec razreševanja ob %s', [aDat1]);

   memo.Lines.Add('=====================================================');
   memo.Lines.Add(aMsg);
end;

end.
