unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls, ExtCtrls, StdCtrls, DBCtrls, DB, OracleData, jpeg;

type
  TfmAbout = class(TForm)
    Panel1: TPanel;
    Image2: TImage;
    Panel2: TPanel;
    laClientVersion: TLabel;
    Label2: TLabel;
    quGetDBVersion: TOracleDataSet;
    quGetDBVersionF_GET_RIS_VERSION_BUILD: TStringField;
    dsGetDBVersion: TDataSource;
    DBText1: TDBText;
    laClientVer: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbout: TfmAbout;

implementation

uses dmOra;

{$R *.dfm}

procedure TfmAbout.FormCreate(Sender: TObject);
begin
   laClientVer.Caption := dmOracle.GetVersionInfo;
end;

end.
