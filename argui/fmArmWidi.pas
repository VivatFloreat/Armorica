unit fmArmWidi;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  Db, OracleData, DBCtrls, StdCtrls, ExtCtrls, Buttons, Oracle, ComCtrls,
  OracleNavigator, Grids, DBGrids, RXCtrls, RXDBCtrl, RxLookup, RXSplit;
type
  TfmArm_Widi = class(TForm)
    dsArmDeme: TDataSource;
    quArmDeme: TOracleDataSet;
    Panel1: TPanel;
    Label1: TLabel;
    cbDeme: TDBLookupComboBox;
    quRisCcon: TOracleDataSet;
    dsRisCcon: TDataSource;
    cbCalendar: TDBLookupComboBox;
    Label2: TLabel;
    quRisDTyp: TOracleQuery;
    buShow: TBitBtn;
    Panel2: TPanel;
    pcDays: TPageControl;
    quArmWidi: TOracleDataSet;
    Panel3: TPanel;
    dsArmWidi: TDataSource;
    quRisShif: TOracleDataSet;
    dsRisShif: TDataSource;
    quArmWidiID: TFloatField;
    quArmWidiDEME_ID: TFloatField;
    quArmWidiDAYTYPE_ID: TIntegerField;
    quArmWidiCALENDAR_ID: TIntegerField;
    quArmWidiSHIFT_ID: TIntegerField;
    quArmWidiSHIFT_DESC: TStringField;
    Panel4: TPanel;
    lbShifts: TDBLookupListBox;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    OracleNavigator1: TOracleNavigator;
    RxSplitter1: TRxSplitter;
    quArmWidiNUM_MIN: TIntegerField;
    quArmWidiNUM_OPT: TIntegerField;
    quArmWidiNUM_MAX: TIntegerField;
    DBGrid1: TDBGrid;
    procedure buShowClick(Sender: TObject);
    procedure pcDaysChange(Sender: TObject);
    procedure quArmWidiAfterInsert(DataSet: TDataSet);
    procedure grIzmeneDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lbShiftsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure grIzmeneDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure cbDemeClick(Sender: TObject);
    procedure lbShiftsClick(Sender: TObject);
    procedure lbShiftsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    procedure ShowDayShifts;
  public
    { Public declarations }
  end;

var
  fmArm_Widi: TfmArm_Widi;

implementation

{$R *.DFM}
uses Variants;

procedure TfmArm_Widi.buShowClick(Sender: TObject);
var
   iDay: integer;
   aPage : TTabSheet;
begin

     if cbCalendar.KeyValue = Null then
        raise Exception.Create('Prosim izberite koledar!');

     if cbDeme.KeyValue = Null then
        raise Exception.Create('Prosim izberite delovno mesto!');


     quRisDtyp.SetVariable ('CALENDAR', cbCalendar.KeyValue);
     quRisDtyp.Execute;

     for iDay := 0 to pcDays.PageCount-1 do begin
         pcDays.Pages[0].Destroy;
     end;

     while not quRisDtyp.Eof do begin
         aPage := TTabSheet.Create(pcDays);
         aPage.PageControl := pcDays;
         aPage.Caption := quRisDtyp.Field(1);
         aPage.Hint := quRisDtyp.Field(0);
         quRisDtyp.Next;
     end;

     if pcDays.PageCount > 0 then begin
        pcDays.ActivePage := pcDays.Pages[0];
        ShowDayShifts;
        pcDays.Visible := true;
     end;

end;

procedure TfmArm_Widi.pcDaysChange(Sender: TObject);
begin
     ShowDayShifts;
end;

procedure TfmArm_Widi.ShowDayShifts;
var daytype_id: integer;
begin
     with quArmWidi do begin
          Close;
          if (pcDays.ActivePage <> nil) then begin
             daytype_id :=  StrToInt(pcDays.ActivePage.Hint);
             SetVariable('CALENDAR', cbCalendar.KeyValue);
             SetVariable('DEME_ID', cbDeme.KeyValue);
             SetVariable('DAYTYPE_ID', daytype_id);
             Open;
          end;
     end;
end;



procedure TfmArm_Widi.quArmWidiAfterInsert(DataSet: TDataSet);
begin
     quArmWidi.FieldByName('CALENDAR_ID').AsString := cbCalendar.KeyValue;
     quArmWidi.FieldByName('DEME_ID').AsString := cbDeme.KeyValue;
     quArmWidi.FieldByName('DAYTYPE_ID').AsString := pcDays.ActivePage.Hint;
     quArmWidi.FieldByName('SHIFT_ID').AsString := lbShifts.KeyValue;
     quArmWidi.FieldByName('NUM_MIN').AsInteger := 1;
     quArmWidi.FieldByName('NUM_OPT').AsInteger := 1;
     quArmWidi.FieldByName('NUM_MAX').AsInteger := 1;
end;

procedure TfmArm_Widi.grIzmeneDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept := Source is TDBLookupListBox;
     lbShifts.DragCursor := crDrag;
end;

procedure TfmArm_Widi.lbShiftsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
   Accept := Source is TDBLookupListBox;
end;

procedure TfmArm_Widi.grIzmeneDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
     quArmWidi.Insert;
end;

procedure TfmArm_Widi.cbDemeClick(Sender: TObject);
begin
    ShowDayShifts;
end;

procedure TfmArm_Widi.lbShiftsClick(Sender: TObject);
var aDragObj: TDragObject;
begin

end;

procedure TfmArm_Widi.lbShiftsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if quArmWidi.Active then begin
      lbShifts.BeginDrag(false, 10);
      lbShifts.DragCursor := crHandPoint;
   end;
end;

end.
