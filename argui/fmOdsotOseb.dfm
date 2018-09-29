object fmOdsot: TfmOdsot
  Left = 185
  Top = 110
  Width = 1056
  Height = 854
  Caption = 'Odsotnosti in sidranja'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1048
    Height = 65
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 15
      Width = 32
      Height = 13
      Caption = 'Mesec'
    end
    object Label2: TLabel
      Left = 168
      Top = 15
      Width = 21
      Height = 13
      Caption = 'Leto'
    end
    object sbPrev: TSpeedButton
      Left = 58
      Top = 8
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333FF3333333333333003333333333333F77F33333333333009033
        333333333F7737F333333333009990333333333F773337FFFFFF330099999000
        00003F773333377777770099999999999990773FF33333FFFFF7330099999000
        000033773FF33777777733330099903333333333773FF7F33333333333009033
        33333333337737F3333333333333003333333333333377333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = sbPrevClick
    end
    object sbNext: TSpeedButton
      Left = 82
      Top = 8
      Width = 23
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333FF3333333333333003333
        3333333333773FF3333333333309003333333333337F773FF333333333099900
        33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
        99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
        33333333337F3F77333333333309003333333333337F77333333333333003333
        3333333333773333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = sbNextClick
    end
    object bbPopulate: TBitBtn
      Left = 296
      Top = 28
      Width = 75
      Height = 25
      Caption = '&Prika'#382'i'
      TabOrder = 0
      OnClick = bbPopulateClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333444444
        33333333333F8888883F33330000324334222222443333388F3833333388F333
        000032244222222222433338F8833FFFFF338F3300003222222AAAAA22243338
        F333F88888F338F30000322222A33333A2224338F33F8333338F338F00003222
        223333333A224338F33833333338F38F00003222222333333A444338FFFF8F33
        3338888300003AAAAAAA33333333333888888833333333330000333333333333
        333333333333333333FFFFFF000033333333333344444433FFFF333333888888
        00003A444333333A22222438888F333338F3333800003A2243333333A2222438
        F38F333333833338000033A224333334422224338338FFFFF8833338000033A2
        22444442222224338F3388888333FF380000333A2222222222AA243338FF3333
        33FF88F800003333AA222222AA33A3333388FFFFFF8833830000333333AAAAAA
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object cbMesec: TComboBox
      Left = 16
      Top = 31
      Width = 145
      Height = 21
      ItemHeight = 13
      ItemIndex = 3
      TabOrder = 1
      Text = 'April'
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
    object edLeto: TRxSpinEdit
      Left = 168
      Top = 31
      Width = 121
      Height = 21
      Value = 2006.000000000000000000
      TabOrder = 2
    end
    object Panel4: TPanel
      Left = 862
      Top = 1
      Width = 185
      Height = 63
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 3
      object bbSave: TBitBtn
        Left = 14
        Top = 8
        Width = 75
        Height = 25
        Caption = '&Shrani'
        Default = True
        TabOrder = 0
        OnClick = bbSaveClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
      object bbCancel: TBitBtn
        Left = 102
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Pozabi'
        TabOrder = 1
        Kind = bkCancel
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 1048
    Height = 721
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Grid: TcxGrid
      Left = 1
      Top = 1
      Width = 1046
      Height = 719
      Align = alClient
      TabOrder = 0
      object viRisUCard: TcxGridDBBandedTableView
        PopupMenu = mnuPopup
        OnMouseMove = viRisUCardMouseMove
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dsRisUCard
        DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = 'Skupaj : ####'
            Kind = skCount
            Column = viRisUCardMNR
          end>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CellHints = True
        OptionsSelection.CellMultiSelect = True
        OptionsView.Navigator = True
        Bands = <
          item
            Caption = 'Osebe'
            FixedKind = fkLeft
            Width = 344
          end
          item
            Caption = 'Koledar'
            Width = 652
          end>
        object viRisUCardORG1: TcxGridDBBandedColumn
          DataBinding.FieldName = 'ORG1'
          Visible = False
          GroupIndex = 0
          SortIndex = 0
          SortOrder = soAscending
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object viRisUCardMNR: TcxGridDBBandedColumn
          DataBinding.FieldName = 'MNR'
          Width = 35
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.LineCount = 3
          Position.RowIndex = 0
        end
        object viRisUCardLNAME: TcxGridDBBandedColumn
          DataBinding.FieldName = 'LNAME'
          PropertiesClassName = 'TcxMemoProperties'
          SortIndex = 1
          SortOrder = soAscending
          Width = 123
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.LineCount = 3
          Position.RowIndex = 0
        end
        object viRisUCardFNAME: TcxGridDBBandedColumn
          DataBinding.FieldName = 'FNAME'
          Width = 126
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.LineCount = 3
          Position.RowIndex = 0
        end
        object viRisUCardNo: TcxGridDBBandedColumn
          Caption = #352'tev. ID'
          DataBinding.FieldName = 'CARD_NO'
          Width = 43
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.LineCount = 3
          Position.RowIndex = 0
        end
        object viRisUCardO_DEP_DESC: TcxGridDBBandedColumn
          DataBinding.FieldName = 'O_DEP_DESC'
          Visible = False
          Width = 131
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
      end
      object viRazpByMNR: TcxGridDBBandedTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsSelection.CellMultiSelect = True
        Bands = <
          item
            Caption = 'Osebe'
            Width = 230
          end
          item
            Caption = 'Koledar'
            Width = 834
          end>
        object viRazpByMNRPRIIMEK_IME: TcxGridDBBandedColumn
          Caption = 'Priimek in ime'
          DataBinding.FieldName = 'PRIIMEK_IME'
          Width = 64
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      object leRazp: TcxGridLevel
        GridView = viRisUCard
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 786
    Width = 1048
    Height = 41
    Align = alBottom
    TabOrder = 2
    object bbPrint: TBitBtn
      Left = 120
      Top = 8
      Width = 99
      Height = 25
      Caption = 'Izvoz v HTML'
      TabOrder = 0
      OnClick = bbPrintClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object bbExcel: TBitBtn
      Left = 16
      Top = 8
      Width = 99
      Height = 25
      Caption = 'Izvoz v Excel'
      TabOrder = 1
      OnClick = bbExcelClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object Panel5: TPanel
      Left = 862
      Top = 1
      Width = 185
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object edMsg: TEdit
        Left = 24
        Top = 7
        Width = 153
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
    end
    object bbDeleteOds: TBitBtn
      Left = 227
      Top = 8
      Width = 129
      Height = 25
      Cancel = True
      Caption = '&Izbri'#353'i vse odsotnosti'
      TabOrder = 3
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
        3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
        03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
        33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
        0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
        3333333337FFF7F3333333333000003333333333377777333333}
      NumGlyphs = 2
    end
    object bbDelSidranja: TBitBtn
      Left = 363
      Top = 8
      Width = 129
      Height = 25
      Cancel = True
      Caption = '&Izbri'#353'i vsa sidranja'
      TabOrder = 4
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
        3333333777777777F3333330F777777033333337F3F3F3F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        33333337F7F7F7F7F3333330F080707033333337F7F7F7F7F3333330F0808070
        333333F7F7F7F7F7F3F33030F080707030333737F7F7F7F7F7333300F0808070
        03333377F7F7F7F773333330F080707033333337F7F7F7F7F333333070707070
        33333337F7F7F7F7FF3333000000000003333377777777777F33330F88877777
        0333337FFFFFFFFF7F3333000000000003333377777777777333333330777033
        3333333337FFF7F3333333333000003333333333377777333333}
      NumGlyphs = 2
    end
  end
  object dsRisUCard: TDataSource
    DataSet = dmOracle.quRisUCard
    Left = 736
    Top = 208
  end
  object mnuPopup: TPopupMenu
    OnPopup = mnuPopupPopup
    Left = 808
    Top = 121
    object miOdsotNew: TMenuItem
      Caption = 'Vnesi novo odsotnost'
      OnClick = miOdsotNewClick
    end
    object miOdsotOdobri: TMenuItem
      Caption = 'Odobri ozna'#269'ene odsotnosti'
      OnClick = miOdsotOdobriClick
    end
    object miOdsotZavrni: TMenuItem
      Caption = 'Zavrni ozna'#269'ene odsotnosti'
      OnClick = miOdsotZavrniClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miSidrajRazp: TMenuItem
      Caption = 'Sidraj razpored'
      OnClick = miSidrajRazpClick
    end
    object miSidrajTurnus: TMenuItem
      Caption = 'Sidraj turnus'
      OnClick = miSidrajTurnusClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miOdsotDel: TMenuItem
      Caption = 'Zbri'#353'i vrednosti'
      OnClick = miOdsotDelClick
    end
  end
  object sdHTML: TSaveDialog
    DefaultExt = '*.html'
    FileName = 'MesecniPlan'
    Filter = 'HTML datoteke|*.html|Excel datoteke|*.xls|Vse datoteke|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 848
    Top = 121
  end
  object quOdsotByMNR: TOracleDataSet
    SQL.Strings = (
      'select '
      ' p.pair_pk,'
      ' p.mnr,'
      ' p.in_date,'
      ' p.out_date,'
      ' p.hours_id,'
      ' h.vp_id,'
      ' h.description,'
      ' p.status,'
      ' p.cdate,'
      ' p.cuser,'
      ' p.ouser,'
      ' p.ochange'
      'from '
      ' ta_ris_pair_plan p, ta_ris_hour h'
      'where   '
      '  p.hours_id = h.hours_id and'
      '  p.mnr = :P_MNR and'
      '  trunc(p.in_date) >= :P_DATUM_OD and'
      '  trunc(p.in_date) <= :P_DATUM_DO and'
      '  h.is_odsot = '#39'DA'#39
      'order by '
      '  p.mnr, p.in_date')
    Variables.Data = {
      03000000030000000B0000003A505F444154554D5F4F440C0000000000000000
      0000000B0000003A505F444154554D5F444F0C00000000000000000000000600
      00003A505F4D4E52080000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000C000000030000004D4E5201000000000008000000484F5552535F49
      440100000000000500000056505F494401000000000007000000494E5F444154
      4501000000000007000000504149525F504B0100000000000600000053544154
      55530100000000000B0000004445534352495054494F4E010000000000080000
      004F55545F444154450100000000000500000043444154450100000000000500
      00004355534552010000000000050000004F5553455201000000000007000000
      4F4348414E4745010000000000}
    Session = dmOracle.oraSession
    Left = 816
    Top = 177
    object quOdsotByMNRPAIR_PK: TFloatField
      FieldName = 'PAIR_PK'
      Required = True
    end
    object quOdsotByMNRMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object quOdsotByMNRIN_DATE: TDateTimeField
      FieldName = 'IN_DATE'
      Required = True
    end
    object quOdsotByMNROUT_DATE: TDateTimeField
      FieldName = 'OUT_DATE'
    end
    object quOdsotByMNRHOURS_ID: TIntegerField
      FieldName = 'HOURS_ID'
    end
    object quOdsotByMNRVP_ID: TStringField
      FieldName = 'VP_ID'
      Required = True
      Size = 5
    end
    object quOdsotByMNRSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object quOdsotByMNRDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object quOdsotByMNRCDATE: TDateTimeField
      FieldName = 'CDATE'
    end
    object quOdsotByMNRCUSER: TStringField
      FieldName = 'CUSER'
      Size = 30
    end
    object quOdsotByMNROUSER: TStringField
      FieldName = 'OUSER'
      Size = 30
    end
    object quOdsotByMNROCHANGE: TDateTimeField
      FieldName = 'OCHANGE'
    end
  end
  object spDelOdsot: TOracleQuery
    SQL.Strings = (
      'begin'
      '   odsot.brisi (:P_MNR, :P_DATUM_OD, :P_DATUM_DO, :P_FORCE);'
      'end;')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000004000000060000003A505F4D4E520800000000000000000000000B00
      00003A505F444154554D5F4F440C00000000000000000000000B0000003A505F
      444154554D5F444F0C0000000000000000000000080000003A505F464F524345
      050000000000000000000000}
    Left = 864
    Top = 177
  end
  object spInsOdsot: TOracleQuery
    SQL.Strings = (
      'begin'
      '   odsot.vstavi(:P_MNR,'
      '                      :P_DATUM,'
      '                      :P_HOURS_ID,'
      '                      :P_VP_ID,'
      '                      :P_STATUS,'
      '                      :P_DELETE_OLD);'
      'end;')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000006000000060000003A505F4D4E520300000000000000000000000800
      00003A505F444154554D0C00000000000000000000000B0000003A505F484F55
      52535F4944030000000000000000000000090000003A505F5354415455530500
      000000000000000000000D0000003A505F44454C4554455F4F4C440500000000
      00000000000000080000003A505F56505F4944050000000000000000000000}
    Left = 904
    Top = 177
  end
  object myStyles: TcxStyleRepository
    Left = 768
    Top = 120
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clGradientActiveCaption
    end
    object cxStyle3: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object cxStyle4: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMenuHighlight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object cxStyle5: TcxStyle
      AssignedValues = [svColor]
      Color = clGradientActiveCaption
    end
    object cxStyleRaz1: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clAqua
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
    end
    object cxStyleRaz3: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clMenuHighlight
      TextColor = clYellow
    end
    object cxStyleRaz4: TcxStyle
    end
    object cxStyleRaz2: TcxStyle
      AssignedValues = [svColor]
      Color = clSilver
    end
    object cxStyleOds1: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clYellow
    end
    object cxStyleOds2: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clYellow
    end
    object cxStyleOds3: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clPurple
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clYellow
    end
    object cxStylePraznikHeader: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clYellow
    end
    object cxStyleSobotaHeader: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object cxStyleNedeljaHeader: TcxStyle
      AssignedValues = [svColor, svTextColor]
      Color = clMoneyGreen
      TextColor = clHighlight
    end
  end
  object cxHintStyleController1: TcxHintStyleController
    Global = False
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'MS Sans Serif'
    HintStyle.CaptionFont.Style = []
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'MS Sans Serif'
    HintStyle.Font.Style = []
    HintStyle.Rounded = True
    HintStyle.Standard = True
    Left = 728
    Top = 257
  end
  object Timer1: TTimer
    Left = 768
    Top = 257
  end
  object quRisShif: TOracleDataSet
    SQL.Strings = (
      'select'
      '   shift_id,'
      '   shift_no,'
      '   arm_oznaka,'
      '   description'
      'from ta_ris_shif ')
    QBEDefinition.QBEFieldDefs = {
      04000000040000000800000053484946545F4944010000000000080000005348
      4946545F4E4F0100000000000A00000041524D5F4F5A4E414B41010000000000
      0B0000004445534352495054494F4E010000000000}
    Session = dmOracle.oraSession
    Left = 768
    Top = 305
    object quRisShifSHIFT_ID: TIntegerField
      FieldName = 'SHIFT_ID'
      Required = True
    end
    object quRisShifSHIFT_NO: TIntegerField
      FieldName = 'SHIFT_NO'
      Required = True
    end
    object quRisShifARM_OZNAKA: TStringField
      FieldName = 'ARM_OZNAKA'
      Size = 30
    end
    object quRisShifDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 30
    end
  end
  object spInsRazp: TOracleQuery
    SQL.Strings = (
      'begin'
      'sp_p_arm_razp_ins(p_mnr => :p_mnr,'
      '                 p_datum => :p_datum,'
      '                 p_prenos_id => -1,'
      '                 p_depart_id => :p_depart_id,'
      '                 p_dem_id => :p_dem_id,'
      '                 p_shift_id => :p_shift_id,'
      '                 p_shift_no => :p_shift_no,'
      '                 p_daytype_id => :p_daytype_id,'
      '                 p_delete_old => '#39'N'#39');'
      'end;')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000007000000060000003A505F4D4E520800000000000000000000000800
      00003A505F444154554D0C00000000000000000000000C0000003A505F444550
      4152545F4944030000000000000000000000090000003A505F44454D5F494403
      00000000000000000000000B0000003A505F53484946545F4944030000000000
      0000000000000B0000003A505F53484946545F4E4F0300000000000000000000
      000D0000003A505F444159545950455F4944030000000000000000000000}
    Left = 864
    Top = 217
  end
  object quRazpByMNR: TOracleDataSet
    SQL.Strings = (
      'select '
      ' r.id,'
      ' r.prenos_id,'
      ' r.mnr,'
      ' r.datum, '
      ' r.depart_id,'
      ' depa.depart,'
      ' depa.description depa_desc,'
      ' r.dem_id,'
      ' deme.sifra,'
      ' deme.naziv,'
      ' r.shift_id,'
      ' shif.description,'
      ' shif.arm_oznaka,'
      ' shif.shift_no,'
      ' r.shift_no shift_no_razp,'
      ' r.created,'
      ' r.cuser'
      'from '
      
        ' ta_arm_razp r, ta_ris_shif shif, ta_ris_depa depa, ta_arm_deme ' +
        'deme'
      'where   '
      '  r.depart_id = depa.depart_id(+) and'
      '  r.dem_id = deme.id(+) and'
      '  r.shift_id = shif.shift_id(+) and'
      '  r.mnr = :P_MNR and'
      '  trunc(r.datum) >= :P_DATUM_OD and'
      '  trunc(r.datum) <= :P_DATUM_DO and'
      '  r.prenos_id = -1'
      'order by '
      '  r.mnr, r.datum')
    Variables.Data = {
      0300000003000000060000003A505F4D4E520800000000000000000000000B00
      00003A505F444154554D5F4F440C00000000000000000000000B0000003A505F
      444154554D5F444F0C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000011000000030000004D4E520100000000000B00000044455343524950
      54494F4E01000000000005000000435553455201000000000002000000494401
      0000000000090000005052454E4F535F49440100000000000500000044415455
      4D010000000000090000004445504152545F4944010000000000090000004445
      50415F444553430100000000000600000044454D5F4944010000000000050000
      005349465241010000000000050000004E415A49560100000000000800000053
      484946545F49440100000000000A00000041524D5F4F5A4E414B410100000000
      000800000053484946545F4E4F0100000000000D00000053484946545F4E4F5F
      52415A5001000000000007000000435245415445440100000000000600000044
      4550415254010000000000}
    Session = dmOracle.oraSession
    Left = 824
    Top = 217
    object quRazpByMNRID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object quRazpByMNRPRENOS_ID: TFloatField
      FieldName = 'PRENOS_ID'
      Required = True
    end
    object quRazpByMNRMNR: TFloatField
      FieldName = 'MNR'
      Required = True
    end
    object quRazpByMNRDATUM: TDateTimeField
      FieldName = 'DATUM'
      Required = True
    end
    object quRazpByMNRDEPART_ID: TFloatField
      FieldName = 'DEPART_ID'
    end
    object quRazpByMNRDEPART: TStringField
      FieldName = 'DEPART'
      Size = 30
    end
    object quRazpByMNRDEPA_DESC: TStringField
      FieldName = 'DEPA_DESC'
      Size = 30
    end
    object quRazpByMNRDEM_ID: TFloatField
      FieldName = 'DEM_ID'
    end
    object quRazpByMNRSIFRA: TStringField
      FieldName = 'SIFRA'
      Size = 30
    end
    object quRazpByMNRNAZIV: TStringField
      FieldName = 'NAZIV'
      Size = 255
    end
    object quRazpByMNRSHIFT_ID: TIntegerField
      FieldName = 'SHIFT_ID'
    end
    object quRazpByMNRARM_OZNAKA: TStringField
      FieldName = 'ARM_OZNAKA'
      Size = 30
    end
    object quRazpByMNRDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object quRazpByMNRSHIFT_NO: TIntegerField
      FieldName = 'SHIFT_NO'
    end
    object quRazpByMNRSHIFT_NO_RAZP: TIntegerField
      FieldName = 'SHIFT_NO_RAZP'
    end
    object quRazpByMNRCREATED: TDateTimeField
      FieldName = 'CREATED'
    end
    object quRazpByMNRCUSER: TStringField
      FieldName = 'CUSER'
      Size = 30
    end
  end
  object delArmRazp: TOracleQuery
    SQL.Strings = (
      'begin'
      
        '  sp_p_arm_razp_del(:P_MNR, :od_datuma, :do_datuma, :P_prenos_id' +
        ');'
      'end;')
    Session = dmOracle.oraSession
    Variables.Data = {
      03000000040000000A0000003A4F445F444154554D410C000000000000000000
      00000A0000003A444F5F444154554D410C00000000000000000000000C000000
      3A505F5052454E4F535F4944030000000000000000000000060000003A505F4D
      4E52080000000000000000000000}
    Left = 904
    Top = 217
  end
  object quRisHour: TOracleDataSet
    SQL.Strings = (
      'select '
      '  hours_id,'
      '  vp_id,'
      '  description,'
      '  vp_id || '#39'-'#39' ||  description  opis'
      'from '
      '  ta_ris_hour'
      'where '
      '  is_odsot = '#39'DA'#39
      'order by VP_ID')
    QBEDefinition.QBEFieldDefs = {
      040000000400000008000000484F5552535F4944010000000000040000004F50
      49530100000000000500000056505F49440100000000000B0000004445534352
      495054494F4E010000000000}
    Session = dmOracle.oraSession
    Active = True
    Left = 776
    Top = 177
    object quRisHourHOURS_ID: TIntegerField
      FieldName = 'HOURS_ID'
      Required = True
    end
    object quRisHourVP_ID: TStringField
      FieldName = 'VP_ID'
      Required = True
      Size = 5
    end
    object quRisHourDESCRIPTION: TStringField
      FieldName = 'DESCRIPTION'
      Size = 30
    end
    object quRisHourOPIS: TStringField
      FieldName = 'OPIS'
      Size = 36
    end
  end
  object dsRisHour: TDataSource
    DataSet = quRisHour
    Left = 776
    Top = 209
  end
end
