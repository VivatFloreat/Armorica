unit fmRazpDelOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons;

type
  TfmRazpDeleteOpt = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    gbTurnus: TGroupBox;
    rbDelAll: TRadioButton;
    rbDelTur: TRadioButton;
    cbIzmena1: TCheckBox;
    cbIzmena2: TCheckBox;
    cbIzmena3: TCheckBox;
    cbPrazniki: TCheckBox;
    cbDelovniki: TCheckBox;
    cbSobote: TCheckBox;
    cbNedelje: TCheckBox;
    procedure rbDelAllClick(Sender: TObject);
    procedure rbDelTurClick(Sender: TObject);
  private
    { Private declarations }
    procedure EnableDisableCB;
  public
    { Public declarations }
  end;

var
  fmRazpDeleteOpt: TfmRazpDeleteOpt;

implementation

{$R *.dfm}

procedure TfmRazpDeleteOpt.EnableDisableCB;
begin
   if rbDelAll.Checked then begin
      cbIzmena1.Enabled := false;
      cbIzmena2.Enabled := false;
      cbIzmena3.Enabled := false;
      cbPrazniki.Enabled := false;
      cbDelovniki.Enabled := false;
      cbSobote.Enabled := false;
      cbNedelje.Enabled := false;
   end else begin
      cbIzmena1.Enabled := true;
      cbIzmena2.Enabled := true;
      cbIzmena3.Enabled := true;
      cbPrazniki.Enabled := true;
      cbDelovniki.Enabled := true;
      cbSobote.Enabled := true;
      cbNedelje.Enabled := true;
   end;
end;

procedure TfmRazpDeleteOpt.rbDelAllClick(Sender: TObject);
begin
   EnableDisableCB;
end;

procedure TfmRazpDeleteOpt.rbDelTurClick(Sender: TObject);
begin
   EnableDisableCB;
end;

end.
