object fmSelDDMI: TfmSelDDMI
  Left = 292
  Top = 175
  Width = 906
  Height = 640
  Caption = 'Izberi delovni polo'#382'aj osebe'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 572
    Width = 898
    Height = 41
    Align = alBottom
    TabOrder = 0
    object Panel2: TPanel
      Left = 716
      Top = 1
      Width = 181
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object bbCancel: TBitBtn
        Left = 8
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Pozabi'
        TabOrder = 0
        Kind = bkCancel
      end
      object bbOk: TBitBtn
        Left = 96
        Top = 8
        Width = 75
        Height = 25
        Caption = 'V redu'
        TabOrder = 1
        Kind = bkOK
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 898
    Height = 41
    Align = alTop
    TabOrder = 1
    object edMNR: TEdit
      Left = 16
      Top = 8
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object edDatumOd: TDateEdit
      Left = 160
      Top = 8
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 1
    end
    object edDatumDo: TDateEdit
      Left = 296
      Top = 8
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 2
    end
  end
  object lbDDMIs: TcxMCListBox
    Left = 0
    Top = 41
    Width = 898
    Height = 531
    Align = alClient
    HeaderSections = <
      item
        Text = '#'
      end
      item
        AllowClick = True
        Text = 'Turnus'
      end
      item
        AllowClick = True
        Text = 'DM'
        Width = 250
      end
      item
        AllowClick = True
        Text = 'Delovi'#353#269'e'
        Width = 250
      end
      item
        AllowClick = True
        Text = 'Izmena'
        Width = 250
      end>
    TabOrder = 2
    OnDblClick = lbDDMIsDblClick
  end
  object quDDMIOsebe: TOracleDataSet
    SQL.Strings = (
      'select '
      'dd.depart_id,'
      'depa.depart,'
      'depa.description,'
      'dd.dem_id,'
      'dem.sifra,'
      'dem.naziv,'
      'dd.shift_id,'
      'sh.description,'
      'sh.shift_no,'
      'sh.arm_oznaka'
      'from '
      '(select '
      '  ddmi.depart_id,'
      '  ddmi.dem_id,'
      '  ddmi.shift_id'
      '  from vi_arm_oseb_all_razp ddmi'
      '  where ddmi.mnr = :MNR'
      
        '  and sf_f_interval_is_presek (ddmi.cade_velja_od, ddmi.cade_vel' +
        'ja_do, :P_DATUM_OD, :P_DATUM_DO+1) = 1'
      
        '  and sf_f_interval_is_presek (ddmi.cadm_velja_od, ddmi.cadm_vel' +
        'ja_do, :P_DATUM_OD, :P_DATUM_DO+1) = 1'
      
        '  and sf_f_interval_is_presek (ddmi.cash_velja_od, ddmi.cash_vel' +
        'ja_do, :P_DATUM_OD, :P_DATUM_DO+1) = 1'
      'intersect'
      '  select distinct'
      '  depart_id,'
      '  dem_id,'
      '  shift_id'
      'from '
      '  ta_arm_plan'
      'where '
      '  (trunc(DATUM) >= :P_DATUM_OD) and '
      '  (trunc(DATUM) <= :P_DATUM_DO)) dd, '
      
        '                                                    ta_ris_depa ' +
        'depa, '
      
        '                                                    ta_arm_deme ' +
        'dem, '
      
        '                                                    ta_ris_shif ' +
        'sh'
      'where '
      '  dd.depart_id = depa.depart_id and'
      '  dd.dem_id = dem.id and'
      '  dd.shift_id = sh.shift_id'
      'order by'
      '  sh.shift_no,'
      '  dem.naziv,'
      '  depa.description')
    Variables.Data = {
      0300000003000000040000003A4D4E520300000000000000000000000B000000
      3A505F444154554D5F4F440C00000000000000000000000B0000003A505F4441
      54554D5F444F0C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000A000000090000004445504152545F49440100000000000600000044
      45504152540100000000000B0000004445534352495054494F4E010000000000
      0600000044454D5F4944010000000000050000004E415A495601000000000008
      00000053484946545F49440100000000000D0000004445534352495054494F4E
      5F310100000000000800000053484946545F4E4F0100000000000A0000004152
      4D5F4F5A4E414B41010000000000050000005349465241010000000000}
    ReadOnly = True
    Session = dmOracle.oraSession
    Left = 904
    Top = 8
    object quDDMIOsebeDEPART_ID: TFloatField
      FieldName = 'DEPART_ID'
    end
    object quDDMIOsebeDEPART: TStringField
      FieldName = 'DEPART'
      Size = 30
    end
    object quDDMIOsebeDESCRIPTION: TStringField
      DisplayLabel = 'Delovi'#353#269'e'
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object quDDMIOsebeDEM_ID: TFloatField
      FieldName = 'DEM_ID'
    end
    object quDDMIOsebeSIFRA: TStringField
      FieldName = 'SIFRA'
      Required = True
      Size = 30
    end
    object quDDMIOsebeNAZIV: TStringField
      DisplayLabel = 'Delovno mesto'
      FieldName = 'NAZIV'
      Size = 255
    end
    object quDDMIOsebeSHIFT_ID: TFloatField
      FieldName = 'SHIFT_ID'
    end
    object quDDMIOsebeDESCRIPTION_1: TStringField
      DisplayLabel = 'Naziv izmene'
      FieldName = 'DESCRIPTION_1'
      Size = 30
    end
    object quDDMIOsebeSHIFT_NO: TIntegerField
      DisplayLabel = 'Turnus'
      FieldName = 'SHIFT_NO'
      Required = True
    end
    object quDDMIOsebeARM_OZNAKA: TStringField
      DisplayLabel = 'Oznaka'
      FieldName = 'ARM_OZNAKA'
      Size = 30
    end
  end
  object dsDDMIOsebe: TDataSource
    AutoEdit = False
    DataSet = quDDMIOsebe
    Left = 904
    Top = 40
  end
end
