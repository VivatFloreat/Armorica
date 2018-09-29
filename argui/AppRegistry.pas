unit AppRegistry;

interface

uses
   Classes, Registry, ResStr, cxGridDBTableView,cxGridCustomView;

type
   TAppRegistry = class(TRegistry)
      private
         fRootKeyName: string;

      public
         constructor Create (aRootKeyName: string);
         function DeleteSubKey(aSubKey: string): boolean;
         procedure OpenSubKey (aSubKey: string);
         function ReadPropValString (aProperty: string; AllowCreation: boolean): string;
         function ReadPropValBool (aProperty: string; AllowCreation: boolean): boolean;
         function ReadPropValInt (aProperty: string; AllowCreation: boolean): integer;
         function ReadPropValBinary (aProperty: string;
                                     var aValue; maxSize: integer;
                                     AllowCreation: boolean): integer;

         procedure WritePropValString (aProperty: string; aValue: string);
         procedure WritePropValBinary (aProperty: string; var aBuffer; aSize: integer);
         procedure WritePropValBool (aProperty: string; aValue: boolean);
         procedure WritePropValInt (aProperty: string; aValue: integer);

         procedure SaveGridLayout (aStoreSubKey, aFormName: string; aTreeView: tcxGridDBTableView);
         procedure RestoreGridLayout (aStoreSubKey, aFormName: string; aTreeView: tcxGridDBTableView);

end;

implementation

   uses StrUtils, sysUtils, ResStrings;

   constructor TAppRegistry.Create (aRootKeyName: string);
   begin
      inherited Create;
      if RightStr(aRootKeyName,1) = '\' then
         fRootKeyName := Copy(aRootKeyname, 1, Length(aRootKeyName) - 1)
      else
         fRootKeyName := aRootKeyName;
   end;

   procedure TAppRegistry.OpenSubKey (aSubKey: string);
   var aKey: string;
       aErr: string;
   begin
      if LeftStr (aSubKey, 1) = '\' then
         aKey := fRootKeyName + aSubKey
      else
         aKey := fRootKeyName + '\' + aSubKey;

      if (OpenKey(aKey, true)=false) then begin
         aErr := Format (C_EXCEPT_REGISTRY_OPEN, [aKey]);
         raise Exception.Create(aErr);
      end;
   end;

   function TAppRegistry.ReadPropValString (aProperty: string; AllowCreation: boolean): string;
   begin
      if ValueExists(aProperty) then
         Result := AnsiUpperCase(ReadString(aProperty))
      else begin
         if AllowCreation then
            WriteString(aProperty, '');
         Result := '';
      end;
   end;

   function TAppRegistry.ReadPropValBinary (aProperty: string;
                                             var aValue; maxSize: integer;
                                             AllowCreation: boolean): integer;
   var foo: integer;
   begin
      if ValueExists(aProperty) then
         Result := ReadBinaryData(aProperty, aValue, maxSize)
      else begin
         if AllowCreation then
            WritePropValBinary(aProperty, foo, 0);
         Result := 0;
      end;
   end;

   procedure TAppRegistry.WritePropValString (aProperty: string; aValue: string);
   begin
      WriteString(aProperty, aValue);
   end;

   procedure TAppRegistry.WritePropValBinary (aProperty: string; var aBuffer; aSize: integer);
   begin
      WriteBinaryData(aProperty, aBuffer, aSize);
   end;


   function TAppRegistry.ReadPropValBool (aProperty: string; AllowCreation: boolean): boolean;
   begin
      if ValueExists(aProperty) then
         Result := ReadBool(aProperty)
      else begin
         if AllowCreation then
            WriteBool(aProperty, false);
         Result := false;
      end;
   end;

   procedure TAppRegistry.WritePropValBool (aProperty: string; aValue: boolean);
   begin
      WriteBool(aProperty, aValue);
   end;

   function TAppRegistry.ReadPropValInt (aProperty: string; AllowCreation: boolean): integer;
   begin
      if ValueExists(aProperty) then
         Result := ReadInteger(aProperty)
      else begin
         if AllowCreation then
            WriteInteger(aProperty, 0);
         Result := 0;
      end;
   end;

   procedure TAppRegistry.WritePropValInt (aProperty: string; aValue: integer);
   begin
      WriteInteger(aProperty, aValue);
   end;


   procedure TAppRegistry.SaveGridLayout (aStoreSubKey, aFormName: string; aTreeView: tcxGridDBTableView);
   var
      aKey: string;
      aSaveViewName: string;
   begin
      if LeftStr (aStoreSubKey, 1) = '\' then
         aKey := fRootKeyName + aStoreSubKey
      else
         aKey := fRootKeyName + '\' + aStoreSubKey;

      aSaveViewName := aFormName + '.' + aTreeView.Name;

      //Save settings to the Registry
      aTreeView.StoreToRegistry(aKey, False, [gsoUseFilter], aSaveViewName);
   end;


   procedure TAppRegistry.RestoreGridLayout (aStoreSubKey, aFormName: string; aTreeView: tcxGridDBTableView);
   var
      aKey: string;
      aSaveViewName: string;
   begin
      if LeftStr (aStoreSubKey, 1) = '\' then
         aKey := fRootKeyName + aStoreSubKey
      else
         aKey := fRootKeyName + '\' + aStoreSubKey;

      aSaveViewName := aFormName + '.' + aTreeView.Name;

      //Restore settings from the Registry
      aTreeView.RestoreFromRegistry(aKey, False, False, [gsoUseFilter], aSaveViewName);
   end;

   function TAppRegistry.DeleteSubKey(aSubKey: string): boolean;
   var aKey: string;
   begin
       if LeftStr (aSubKey, 1) = '\' then
         aKey := fRootKeyName + aSubKey
      else
         aKey := fRootKeyName + '\' + aSubKey;

      Result := DeleteKey(aKey);
   end;


end.
