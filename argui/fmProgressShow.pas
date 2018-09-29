unit fmProgressShow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls;

type
  TfmProgress = class(TForm)
    ProgressBar1: TProgressBar;
    laInfo: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProgress: TfmProgress;

implementation

{$R *.dfm}

procedure TfmProgress.FormShow(Sender: TObject);
begin
   ProgressBar1.Position :=0;
end;

end.
