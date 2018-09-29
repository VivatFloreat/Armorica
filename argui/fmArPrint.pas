unit fmArPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls, StdCtrls, Buttons;

type
  TfmPrint = class(TForm)
    paCaption: TPanel;
    Panel3: TPanel;
    wbArPrint: TWebBrowser;
    bbPrintPreview: TBitBtn;
    Panel1: TPanel;
    bbClose: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure bbPrintPreviewClick(Sender: TObject);
  private
    { Private declarations }
    fURL: string;
    fReport: string;
  public
    { Public declarations }
    constructor Create (aOwner:tComponent; aReport, aURL: string);
    procedure doWebBrowse;
  end;

var
  fmPrint: TfmPrint;

implementation

{$R *.dfm}

constructor tFmPrint.Create (aOwner:tComponent; aReport, aURL: string);
begin
   inherited Create(aOwner);
   fUrl := aURL;
   fReport := aReport;
end;

procedure tFmPrint.doWebBrowse;
begin
   wbArPrint.Navigate(fURL);
end;

procedure TfmPrint.FormShow(Sender: TObject);
begin
   fmPrint.Caption := 'ARPRINT -' + fReport;
   doWebBrowse;
end;

procedure TfmPrint.bbPrintPreviewClick(Sender: TObject);
begin
   wbArPrint.ExecWB(OLECMDID_PRINTPREVIEW, OLECMDEXECOPT_PROMPTUSER);
end;

end.
