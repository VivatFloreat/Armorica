object fmSelOds: TfmSelOds
  Left = 397
  Top = 133
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Izberi odsotnost'
  ClientHeight = 673
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 625
    Width = 431
    Height = 48
    Align = alBottom
    TabOrder = 0
    object bbOk: TBitBtn
      Left = 165
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Izberi'
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn1: TBitBtn
      Left = 253
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Pozabi'
      TabOrder = 1
      Kind = bkCancel
    end
    object cbOdobrena: TCheckBox
      Left = 16
      Top = 11
      Width = 129
      Height = 17
      Caption = 'Odobrena odsotnost'
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 431
    Height = 41
    Align = alTop
    TabOrder = 1
  end
  object grOdsot: TcxGrid
    Left = 0
    Top = 41
    Width = 431
    Height = 584
    Align = alClient
    TabOrder = 2
    object viOdsot: TcxGridDBTableView
      OnDblClick = viOdsotDblClick
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = dsRisHour
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsSelection.CellSelect = False
      OptionsView.ColumnAutoWidth = True
      object viOdsotVP_ID: TcxGridDBColumn
        DataBinding.FieldName = 'VP_ID'
        Width = 73
      end
      object viOdsotDESCRIPTION: TcxGridDBColumn
        DataBinding.FieldName = 'DESCRIPTION'
        Width = 245
      end
      object viOdsotVRSTNIRED: TcxGridDBColumn
        DataBinding.FieldName = 'VRSTNIRED'
        Visible = False
        GroupIndex = 0
        Width = 82
      end
    end
    object leOdsot: TcxGridLevel
      GridView = viOdsot
    end
  end
  object quRisHour: TOracleDataSet
    SQL.Strings = (
      'select '
      '  hours_id,'
      '  vp_id,'
      '  description,'
      '  vp_id || '#39'-'#39' ||  description  opis,'
      '  vrstnired'
      'from '
      '  ta_ris_hour'
      'where '
      '  is_odsot = '#39'DA'#39
      'order by VRSTNIRED, VP_ID')
    QBEDefinition.QBEFieldDefs = {
      040000000500000008000000484F5552535F4944010000000000040000004F50
      49530100000000000500000056505F49440100000000000B0000004445534352
      495054494F4E01000000000009000000565253544E49524544010000000000}
    Session = dmOracle.oraSession
    Left = 400
    Top = 9
    object quRisHourHOURS_ID: TIntegerField
      FieldName = 'HOURS_ID'
      Required = True
    end
    object quRisHourVP_ID: TStringField
      DisplayLabel = 'VD'
      FieldName = 'VP_ID'
      Required = True
      Size = 5
    end
    object quRisHourDESCRIPTION: TStringField
      DisplayLabel = 'Opis'
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object quRisHourOPIS: TStringField
      FieldName = 'OPIS'
      Size = 36
    end
    object quRisHourVRSTNIRED: TFloatField
      DisplayLabel = 'Skupine odsotnosti'
      FieldName = 'VRSTNIRED'
    end
  end
  object dsRisHour: TDataSource
    DataSet = quRisHour
    Left = 400
    Top = 41
  end
end
