object fmPlanWiz1: TfmPlanWiz1
  Left = 266
  Top = 208
  Width = 870
  Height = 640
  Caption = 'Priprava plana delovi'#353#269'a - korak 1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 32
    Width = 50
    Height = 13
    Caption = 'Delovi'#353#269'e:'
  end
  object Label2: TLabel
    Left = 344
    Top = 24
    Width = 39
    Height = 13
    Caption = 'Koledar:'
  end
  object cbMesec: TComboBox
    Left = 88
    Top = 96
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'cbMesec'
    Items.Strings = (
      'Januar'
      'Februar'
      'Marec'
      'April'
      'Maj'
      'Junij'
      'Julij'
      'Avgust'
      'September'
      'Oktober'
      'November'
      'December')
  end
  object cbLeto: TRxSpinEdit
    Left = 240
    Top = 96
    Width = 121
    Height = 21
    MaxValue = 9999.000000000000000000
    MinValue = 2000.000000000000000000
    Value = 2006.000000000000000000
    TabOrder = 1
  end
  object bbShow: TBitBtn
    Left = 88
    Top = 128
    Width = 75
    Height = 25
    Caption = 'bbShow'
    TabOrder = 2
  end
  object RxDBGrid1: TRxDBGrid
    Left = 88
    Top = 176
    Width = 553
    Height = 249
    DataSource = dsArmDeDm
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object cbDelovisca: TRxDBLookupCombo
    Left = 80
    Top = 24
    Width = 225
    Height = 21
    DropDownCount = 8
    LookupField = 'DEPART_ID'
    LookupDisplay = 'DESCRIPTION'
    LookupSource = dmOracle.dsDelovisca
    TabOrder = 4
  end
  object cbKoledar: TRxDBLookupCombo
    Left = 392
    Top = 24
    Width = 145
    Height = 21
    DropDownCount = 8
    LookupField = 'CALENDAR'
    LookupDisplay = 'DESCRIPTION'
    LookupSource = dsRisCcon
    TabOrder = 5
  end
  object quRisCcon: TOracleDataSet
    SQL.Strings = (
      'select'
      'calendar, description'
      'from ta_ris_ccon'
      'order by calendar')
    ReadBuffer = 25
    Optimize = True
    Debug = False
    StringFieldsOnly = False
    SequenceField.ApplyMoment = amOnPost
    OracleDictionary.EnforceConstraints = False
    OracleDictionary.UseMessageTable = False
    OracleDictionary.DefaultValues = False
    OracleDictionary.DynamicDefaults = False
    OracleDictionary.FieldKinds = False
    OracleDictionary.DisplayFormats = False
    OracleDictionary.RangeValues = False
    OracleDictionary.RequiredFields = True
    QBEDefinition.SaveQBEValues = True
    QBEDefinition.AllowFileWildCards = True
    QBEDefinition.QBEFontColor = clNone
    QBEDefinition.QBEBackgroundColor = clNone
    QBEDefinition.QBEFieldDefs = {
      03000000020000000800000043414C454E44415201000000000B000000444553
      4352495054494F4E0100000000}
    Cursor = crDefault
    ReadOnly = False
    LockingMode = lmCheckImmediate
    QueryAllRecords = True
    CountAllRecords = False
    RefreshOptions = []
    CommitOnPost = True
    CachedUpdates = False
    QBEMode = False
    Session = dmOracle.oraSession
    DesignActivation = False
    Active = True
    Left = 632
    Top = 32
  end
  object dsRisCcon: TDataSource
    DataSet = quRisCcon
    Left = 632
    Top = 72
  end
  object quArmDeme: TOracleDataSet
    SQL.Strings = (
      'select '
      '  id,'
      '  sifra,'
      '  naziv'
      'from '
      '  ta_arm_deme'
      'order by'
      '  naziv'
      '  '
      '  ')
    ReadBuffer = 25
    Optimize = True
    Debug = False
    StringFieldsOnly = False
    SequenceField.ApplyMoment = amOnPost
    OracleDictionary.EnforceConstraints = False
    OracleDictionary.UseMessageTable = False
    OracleDictionary.DefaultValues = False
    OracleDictionary.DynamicDefaults = False
    OracleDictionary.FieldKinds = False
    OracleDictionary.DisplayFormats = False
    OracleDictionary.RangeValues = False
    OracleDictionary.RequiredFields = True
    QBEDefinition.SaveQBEValues = True
    QBEDefinition.AllowFileWildCards = True
    QBEDefinition.QBEFontColor = clNone
    QBEDefinition.QBEBackgroundColor = clNone
    QBEDefinition.QBEFieldDefs = {
      0300000003000000020000004944010000000005000000534946524101000000
      00050000004E415A49560100000000}
    Cursor = crDefault
    ReadOnly = False
    LockingMode = lmCheckImmediate
    QueryAllRecords = True
    CountAllRecords = False
    RefreshOptions = []
    CommitOnPost = True
    CachedUpdates = False
    QBEMode = False
    Session = dmOracle.oraSession
    DesignActivation = False
    Active = True
    Left = 672
    Top = 32
  end
  object quArmDedm: TOracleDataSet
    SQL.Strings = (
      'select '
      '  rowid, '
      '  id,'
      '  dem_id, '
      '  depart_id,'
      '  velja_od, '
      '  velja_do'
      'from '
      '  arm_dedm'
      'where depart_id = :depart_id')
    ReadBuffer = 25
    Optimize = True
    Debug = False
    Variables.Data = {
      03000000010000000A0000003A4445504152545F494404000000080000000000
      00000000364000000000}
    StringFieldsOnly = False
    SequenceField.ApplyMoment = amOnPost
    OracleDictionary.EnforceConstraints = False
    OracleDictionary.UseMessageTable = False
    OracleDictionary.DefaultValues = False
    OracleDictionary.DynamicDefaults = False
    OracleDictionary.FieldKinds = False
    OracleDictionary.DisplayFormats = False
    OracleDictionary.RangeValues = False
    OracleDictionary.RequiredFields = True
    QBEDefinition.SaveQBEValues = True
    QBEDefinition.AllowFileWildCards = True
    QBEDefinition.QBEFontColor = clNone
    QBEDefinition.QBEBackgroundColor = clNone
    QBEDefinition.QBEFieldDefs = {
      03000000050000000600000044454D5F49440100000000090000004445504152
      545F494401000000000800000056454C4A415F4F440100000000080000005645
      4C4A415F444F01000000000200000049440100000000}
    Cursor = crDefault
    Master = dmOracle.quDelovisca
    MasterFields = 'DEPART_ID'
    DetailFields = 'DEPART_ID'
    ReadOnly = False
    LockingMode = lmCheckImmediate
    QueryAllRecords = True
    CountAllRecords = False
    RefreshOptions = []
    CommitOnPost = True
    CachedUpdates = False
    QBEMode = False
    Session = dmOracle.oraSession
    DesignActivation = False
    Active = True
    Left = 720
    Top = 32
    object quArmDedmID: TFloatField
      DisplayWidth = 12
      FieldName = 'ID'
      Required = True
    end
    object quArmDedmDEM_ID: TFloatField
      DisplayWidth = 10
      FieldName = 'DEM_ID'
      Required = True
    end
    object quArmDedmDEME_NAZIV: TStringField
      DisplayWidth = 306
      FieldKind = fkLookup
      FieldName = 'DEME_NAZIV'
      LookupDataSet = quArmDeme
      LookupKeyFields = 'ID'
      LookupResultField = 'NAZIV'
      KeyFields = 'DEM_ID'
      Size = 255
      Lookup = True
    end
    object quArmDedmDEPART_ID: TFloatField
      DisplayWidth = 12
      FieldName = 'DEPART_ID'
      Required = True
    end
    object quArmDedmVELJA_OD: TDateTimeField
      DisplayWidth = 22
      FieldName = 'VELJA_OD'
      Required = True
    end
    object quArmDedmVELJA_DO: TDateTimeField
      DisplayWidth = 22
      FieldName = 'VELJA_DO'
    end
  end
  object dsArmDeDm: TDataSource
    DataSet = quArmDedm
    Left = 720
    Top = 72
  end
end
