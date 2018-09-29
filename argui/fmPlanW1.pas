unit fmPlanW1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RxLookup, DBCtrls, Grids, DBGrids, StdCtrls, RXSpin, DB,
  OracleData, RXDBCtrl, Buttons;

type
  TfmPlanWiz1 = class(TForm)
    quRisCcon: TOracleDataSet;
    dsRisCcon: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    cbMesec: TComboBox;
    cbLeto: TRxSpinEdit;
    bbShow: TBitBtn;
    quArmDeme: TOracleDataSet;
    quArmDedm: TOracleDataSet;
    quArmDedmID: TFloatField;
    quArmDedmDEM_ID: TFloatField;
    quArmDedmDEME_NAZIV: TStringField;
    quArmDedmDEPART_ID: TFloatField;
    quArmDedmVELJA_OD: TDateTimeField;
    quArmDedmVELJA_DO: TDateTimeField;
    dsArmDeDm: TDataSource;
    RxDBGrid1: TRxDBGrid;
    cbDelovisca: TRxDBLookupCombo;
    cbKoledar: TRxDBLookupCombo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPlanWiz1: TfmPlanWiz1;

implementation

{$R *.dfm}

end.
