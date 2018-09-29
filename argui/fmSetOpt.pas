unit fmSetOpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxPropertiesStore, Buttons, AppRegistry,
  cxPC, cxControls;

type
  TfmSettings = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    bbSave: TBitBtn;
    bbCancel: TBitBtn;
    tsShowMode: TcxPageControl;
    tsColumns: TcxTabSheet;
    gbColOsebe: TGroupBox;
    cbMNR: TCheckBox;
    cbOseba: TCheckBox;
    cbIDCard: TCheckBox;
    cbAkt: TCheckBox;
    cbEmployed: TCheckBox;
    cbOE: TCheckBox;
    gbColCriteria: TGroupBox;
    cbUreIn: TCheckBox;
    cbUre: TCheckBox;
    cbUreOut: TCheckBox;
    cbNepIn: TCheckBox;
    cbNep: TCheckBox;
    cbNepOut: TCheckBox;
    cbNocIn: TCheckBox;
    cbNoc: TCheckBox;
    cbNocOut: TCheckBox;
    gbColCalendar: TGroupBox;
    cbDelovniki: TCheckBox;
    cbSobote: TCheckBox;
    cbNedelje: TCheckBox;
    cbPrazniki: TCheckBox;
    cbORG1: TCheckBox;
    cxTabSheet1: TcxTabSheet;
    rgShowMode: TRadioGroup;
    tsColor: TcxTabSheet;
    rgOdsotSource: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure bbSaveClick(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
  private
    { Private declarations }
    procedure PreberiRegistry;
    procedure ShraniRegistry;
    function RegistryExists: boolean;
  public
    { Public declarations }
  end;

var
  fmSettings: TfmSettings;

implementation

uses ResStrings;

{$R *.dfm}



procedure TfmSettings.PreberiRegistry;
var aPropName: string;
    i: integer;
    aChecked: boolean;
    aRegistry: TAppRegistry;
begin
   aRegistry := TAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.OpenSubKey(C_REGISTRY_KEYNAME_ARGUI + '\fmSettings');

   try
      for i:= 0 to gbColOsebe.ControlCount - 1 do begin
         if gbColOsebe.Controls[i].ClassName = 'TCheckBox' then begin
            aPropName := gbColOsebe.Controls[i].Name;
            aChecked := aRegistry.ReadPropValBool(aPropName, true);
            TCheckBox(gbColOsebe.Controls[i]).Checked := aChecked;
         end;
      end;

      for i:= 0 to gbColCriteria.ControlCount - 1 do begin
         if gbColCriteria.Controls[i].ClassName = 'TCheckBox' then begin
            aPropName := gbColCriteria.Controls[i].Name;
            aChecked := aRegistry.ReadPropValBool(aPropName, true);
            TCheckBox(gbColCriteria.Controls[i]).Checked := aChecked;
         end;
      end;

      for i:= 0 to gbColCalendar.ControlCount - 1 do begin
         if gbColCalendar.Controls[i].ClassName = 'TCheckBox' then begin
            aPropName := gbColCalendar.Controls[i].Name;
            aChecked := aRegistry.ReadPropValBool(aPropName, true);
            TCheckBox(gbColCalendar.Controls[i]).Checked := aChecked;
         end;
      end;

      // preberi show mode
      aPropName := rgShowMode.Name;
      i := aRegistry.ReadPropValInt(aPropName, true);
      rgShowMode.ItemIndex := i;

      // preberi vir za odsotnosti
      aPropName := rgOdsotSource.Name;
      i := aRegistry.ReadPropValInt(aPropName, true);
      rgOdsotSource.ItemIndex := i;

   finally
      aRegistry.CloseKey;
      aRegistry.Free;
   end;
end;

function TfmSettings.RegistryExists: boolean;
var aResult: boolean;
    aRegistry: TAppRegistry;
begin
   aRegistry := TAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aResult := aRegistry.KeyExists(C_REGISTRY_KEYNAME_BASE + '\' +
                                  C_REGISTRY_KEYNAME_ARGUI + '\fmSettings');
   aRegistry.Free;

   Result := aResult;
end;


procedure TfmSettings.ShraniRegistry;
var aPropName: string;
    i: integer;
    aChecked: boolean;
    aRegistry: TAppRegistry;
begin
   aRegistry := TAppRegistry.Create(C_REGISTRY_KEYNAME_BASE);
   aRegistry.OpenSubKey(C_REGISTRY_KEYNAME_ARGUI + '\fmSettings');

   try
      for i:= 0 to gbColOsebe.ControlCount -1 do begin
         if gbColOsebe.Controls[i].ClassName = 'TCheckBox' then begin
            aPropName := gbColOsebe.Controls[i].Name;
            aChecked := TCheckBox(gbColOsebe.Controls[i]).Checked;
            aRegistry.WritePropValBool(aPropName, aChecked);
         end;
      end;

      for i:= 0 to gbColCriteria.ControlCount -1 do begin
         if gbColCriteria.Controls[i].ClassName = 'TCheckBox' then begin
            aPropName := gbColCriteria.Controls[i].Name;
            aChecked := TCheckBox(gbColCriteria.Controls[i]).Checked;
            aRegistry.WritePropValBool(aPropName, aChecked);
         end;
      end;

      for i:= 0 to gbColCalendar.ControlCount -1 do begin
         if gbColCalendar.Controls[i].ClassName = 'TCheckBox' then begin
            aPropName := gbColCalendar.Controls[i].Name;
            aChecked := TCheckBox(gbColCalendar.Controls[i]).Checked;
            aRegistry.WritePropValBool(aPropName, aChecked);
         end;
      end;

      // shrani show mode
      aPropName := rgShowMode.Name;
      i:=rgShowMode.ItemIndex;
      if i < 0 then
         i := 0;
      aRegistry.WritePropValInt(aPropName, i);

      // shrani naèin prikaza odsotnosti
      aPropName := rgOdsotSource.Name;
      i:=rgOdsotSource.ItemIndex;
      if i < 0 then
         i := 0;
      aRegistry.WritePropValInt(aPropName, i);

   finally
      aRegistry.CloseKey;
      aRegistry.Free;
   end;

end;


procedure TfmSettings.FormCreate(Sender: TObject);
begin
   if RegistryExists then
      PreberiRegistry
   else
      ShraniRegistry;

end;

procedure TfmSettings.bbSaveClick(Sender: TObject);
begin
   ShraniRegistry;
   ModalResult := mrOk;
end;

procedure TfmSettings.bbCancelClick(Sender: TObject);
begin
   // undo changes
   if RegistryExists then
      PreberiRegistry
   else
      ShraniRegistry;
end;

end.
