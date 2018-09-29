object fmRazp: TfmRazp
  Left = 220
  Top = 104
  Width = 1018
  Height = 870
  Caption = 'Razpored osebja - mese'#269'ni pogled'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MnuRazp
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1010
    Height = 54
    Align = alTop
    TabOrder = 0
    object Label3: TLabel
      Left = 279
      Top = 8
      Width = 84
      Height = 13
      Caption = 'Lastnik razporeda'
    end
    object Label1: TLabel
      Left = 16
      Top = 9
      Width = 55
      Height = 13
      Caption = 'Od datuma:'
    end
    object Label2: TLabel
      Left = 16
      Top = 32
      Width = 52
      Height = 13
      Caption = 'Do datuma'
    end
    object sbNext: TSpeedButton
      Left = 232
      Top = 5
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
    object sbPrev: TSpeedButton
      Left = 208
      Top = 5
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
    object bbPopulate: TBitBtn
      Left = 589
      Top = 22
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
    object Panel4: TPanel
      Left = 824
      Top = 1
      Width = 185
      Height = 52
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object bbSave: TBitBtn
        Left = 14
        Top = 19
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
        Top = 19
        Width = 75
        Height = 25
        Caption = 'Pozabi'
        TabOrder = 1
        Kind = bkCancel
      end
    end
    object edDatumOd: TDateEdit
      Left = 80
      Top = 4
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 2
    end
    object edDatumDo: TDateEdit
      Left = 80
      Top = 28
      Width = 121
      Height = 21
      NumGlyphs = 2
      TabOrder = 3
    end
    object bbSolve: TBitBtn
      Left = 672
      Top = 23
      Width = 75
      Height = 25
      Caption = 'Razre'#353'i!'
      TabOrder = 4
      OnClick = bbSolveClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      NumGlyphs = 2
    end
    object cbPrenosID: TRxDBLookupCombo
      Left = 280
      Top = 24
      Width = 281
      Height = 21
      DropDownCount = 8
      LookupField = 'MNR'
      LookupDisplay = 'PriimekIme'
      LookupSource = dmOracle.dsLastniki
      TabOrder = 5
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 54
    Width = 1010
    Height = 727
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Grid: TcxGrid
      Left = 1
      Top = 1
      Width = 1008
      Height = 725
      Align = alClient
      TabOrder = 0
      object viRazpByMNR: TcxGridDBBandedTableView
        PopupMenu = mnuPopup
        OnDblClick = viRazpByMNRDblClick
        OnDragDrop = viRazpByMNRDragDrop
        OnDragOver = viRazpByMNRDragOver
        OnMouseMove = viRazpByMNRMouseMove
        NavigatorButtons.ConfirmDelete = False
        OnCellDblClick = viRazpByMNRCellDblClick
        DataController.DataSource = dsRisUCard
        DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.BandHeaderHints = False
        OptionsSelection.CellMultiSelect = True
        OptionsView.Navigator = True
        Bands = <
          item
            Caption = 'Osebe'
            FixedKind = fkLeft
            Options.HoldOwnColumnsOnly = True
            Width = 334
          end
          item
            Caption = 'Kazalniki'
            FixedKind = fkLeft
            Options.HoldOwnColumnsOnly = True
            Width = 159
          end
          item
            Caption = 'Koledar'
            Options.HoldOwnColumnsOnly = True
            Width = 834
          end>
        object viRazpByMNRORG1: TcxGridDBBandedColumn
          Caption = 'Skupina:'
          DataBinding.FieldName = 'ORG1'
          Visible = False
          GroupIndex = 0
          SortIndex = 0
          SortOrder = soAscending
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object viRazpByMNRMNR: TcxGridDBBandedColumn
          DataBinding.FieldName = 'MNR'
          Width = 24
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object viRazpByMNRLNAME: TcxGridDBBandedColumn
          DataBinding.FieldName = 'LNAME'
          Width = 115
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object viRazpByMNRFNAME: TcxGridDBBandedColumn
          DataBinding.FieldName = 'FNAME'
          Width = 84
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object viRazpByMNRCARD_NO: TcxGridDBBandedColumn
          DataBinding.FieldName = 'CARD_NO'
          Visible = False
          Width = 30
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object viRazpByMNRAKT: TcxGridDBBandedColumn
          DataBinding.FieldName = 'AKT'
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object viRazpByMNREMPLOYED: TcxGridDBBandedColumn
          DataBinding.FieldName = 'EMPLOYED'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object viRazpByMNROPISODDELKA: TcxGridDBBandedColumn
          Caption = 'Org. enota'
          DataBinding.FieldName = 'OPISODDELKA'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
      end
      object leRazpByMNR: TcxGridLevel
        GridView = viRazpByMNR
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 781
    Width = 1010
    Height = 43
    Align = alBottom
    TabOrder = 2
    object bbPrint: TBitBtn
      Left = 112
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
      Left = 8
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
    object edMsg: TEdit
      Left = 768
      Top = 8
      Width = 297
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
  end
  object sdHTML: TSaveDialog
    DefaultExt = '*.html'
    FileName = 'MesecniPlan'
    Filter = 'HTML datoteke|*.html|Excel datoteke|*.xls|Vse datoteke|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 848
    Top = 137
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
    Left = 736
    Top = 137
  end
  object Timer1: TTimer
    Left = 880
    Top = 137
  end
  object dsRisUCard: TDataSource
    DataSet = dmOracle.quRisUCard
    Left = 16
    Top = 137
  end
  object spInsRazp: TOracleQuery
    SQL.Strings = (
      'begin'
      'sp_p_arm_razp_ins(p_mnr => :p_mnr,'
      '                 p_datum => :p_datum,'
      '                 p_prenos_id => :p_prenos_id,'
      '                 p_depart_id => :p_depart_id,'
      '                 p_dem_id => :p_dem_id,'
      '                 p_shift_id => :p_shift_id,'
      '                 p_shift_no => :p_shift_no,'
      '                 p_daytype_id => :p_daytype_id,'
      '                 p_delete_old => '#39'D'#39');'
      'end;')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000008000000060000003A505F4D4E520300000000000000000000000800
      00003A505F444154554D0C00000000000000000000000C0000003A505F444550
      4152545F4944030000000000000000000000090000003A505F44454D5F494403
      00000000000000000000000B0000003A505F53484946545F4944030000000000
      0000000000000B0000003A505F53484946545F4E4F0300000000000000000000
      000D0000003A505F444159545950455F49440300000000000000000000000C00
      00003A505F5052454E4F535F4944030000000000000000000000}
    Left = 768
    Top = 177
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
      4E52030000000000000000000000}
    Left = 736
    Top = 177
  end
  object quMNRCritFunc: TOracleQuery
    SQL.Strings = (
      'begin'
      ':p_result := sf_f_arm_get_mnr_criteria(:p_mnr, '
      '                             :p_prenos_id,'
      '                             :p_datum_od,'
      '                             :p_datum_do,'
      '                             :p_key_id,'
      '                             :p_key_in, '
      '                             :p_what);'
      'end;')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000008000000090000003A505F524553554C540300000000000000000000
      00060000003A505F4D4E520300000000000000000000000C0000003A505F5052
      454E4F535F49440300000000000000000000000B0000003A505F444154554D5F
      4F440C00000000000000000000000B0000003A505F444154554D5F444F0C0000
      000000000000000000090000003A505F4B45595F494403000000000000000000
      0000070000003A505F57484154050000000000000000000000090000003A505F
      4B45595F494E050000000000000000000000}
    Left = 56
    Top = 137
  end
  object MnuRazp: TMainMenu
    Left = 912
    Top = 137
    object Edit1: TMenuItem
      Caption = 'Uredi'
      object miRazveljavi: TMenuItem
        Caption = 'Razveljavi spremembe'
        Hint = 'Ponovno prika'#382'i zadnji shranjeni razpored'
        OnClick = miRazveljaviClick
      end
    end
    object Monosti1: TMenuItem
      Caption = 'Mo'#382'nosti'
      object miDragDrop: TMenuItem
        AutoCheck = True
        Caption = 'Povleci-Spusti'
        Checked = True
        OnClick = miDragDropClick
      end
      object miSettings: TMenuItem
        Caption = 'Nastavitve'
        OnClick = miSettingsClick
      end
    end
    object Orodja1: TMenuItem
      Caption = 'Orodja'
      Visible = False
      object miRandomizer: TMenuItem
        Caption = 'Naklju'#269'ni generator za'#269'etnih stanj'
        OnClick = miRandomizerClick
      end
      object miRandomizerSunHoly: TMenuItem
        Caption = 'Naklju'#269'ni generator Ned-Pra'
        OnClick = miRandomizerSunHolyClick
      end
    end
  end
  object mnuPopup: TPopupMenu
    OnPopup = mnuPopupPopup
    Left = 776
    Top = 137
    object miPovleciSpusti: TMenuItem
      AutoCheck = True
      Caption = 'Povleci - spusti'
      Checked = True
      OnClick = miDragDropClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miSelectAll: TMenuItem
      Caption = 'Ozna'#269'i vse'
      OnClick = miSelectAllClick
    end
    object miSelectDay: TMenuItem
      Caption = 'Ozna'#269'i dan'
      OnClick = miSelectDayClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object miOdsotNew: TMenuItem
      Caption = 'Vnesi odsotnost'
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
    object N2: TMenuItem
      Caption = '-'
    end
    object miOdsotDel: TMenuItem
      Caption = 'Zbri'#353'i odsotnosti'
      OnClick = miOdsotDelClick
    end
    object miRazpDel: TMenuItem
      Caption = 'Zbri'#353'i delovne razporede'
      OnClick = miRazpDelClick
    end
    object miProDel: TMenuItem
      Caption = 'Zbri'#353'i PROSTO'
      OnClick = miProDelClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miSidrajRazpored: TMenuItem
      Caption = 'Vnesi delovni razpored'
      OnClick = miSidrajRazporedClick
    end
    object miProsto: TMenuItem
      Caption = 'Vnesi PROSTO'
      OnClick = miProstoClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object miDnevni: TMenuItem
      Caption = 'Dnevni pogled'
      OnClick = miDnevniClick
    end
  end
  object dsRisHour: TDataSource
    DataSet = quRisHour
    Left = 696
    Top = 353
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
      '  is_odsot = '#39'DA'#39' or vp_id = '#39'PRO'#39
      'order by VP_ID')
    QBEDefinition.QBEFieldDefs = {
      040000000400000008000000484F5552535F4944010000000000040000004F50
      49530100000000000500000056505F49440100000000000B0000004445534352
      495054494F4E010000000000}
    Session = dmOracle.oraSession
    Left = 696
    Top = 321
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
    Left = 736
    Top = 209
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
    Left = 768
    Top = 209
  end
  object quObveza: TOracleDataSet
    SQL.Strings = (
      'select '
      '  o.mnr,'
      '  o.cdate,'
      '  o.start_hhmm,'
      '  o.stop_hhmm,'
      '  o.need_hhmm'
      'from '
      '  vi_ris_vi08 o, vi_risucard c'
      'where '
      '  o.mnr = c.mnr and'
      '  cdate between :P_DATUM_OD and :P_DATUM_DO'
      '')
    Variables.Data = {
      03000000020000000B0000003A505F444154554D5F4F440C0000000000000000
      0000000B0000003A505F444154554D5F444F0C0000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000005000000030000004D4E520100000000000500000043444154450100
      000000000A00000053544152545F48484D4D0100000000000900000053544F50
      5F48484D4D010000000000090000004E4545445F48484D4D010000000000}
    Session = dmOracle.oraSession
    Left = 736
    Top = 321
  end
  object myStyles: TcxStyleRepository
    Left = 808
    Top = 136
    object cxStyle1: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clGradientActiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object cxStyleSobotaHeader: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHighlight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object cxStyleNedeljaHeader: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMenuHighlight
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
    end
    object cxStyleDelovisceHeader: TcxStyle
      AssignedValues = [svColor]
      Color = clGradientActiveCaption
    end
    object cxStyleRaz1: TcxStyle
      AssignedValues = [svFont]
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
      AssignedValues = [svColor, svTextColor]
      Color = clYellow
      TextColor = clRed
    end
    object cxStyleRaz2: TcxStyle
      AssignedValues = [svColor]
      Color = clSilver
    end
    object cxStyleOds1: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clRed
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clYellow
    end
    object cxStyleOds2: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clAqua
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
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
    object cxStyleOds4: TcxStyle
      AssignedValues = [svColor]
      Color = clLime
    end
  end
  object quDelOdsotRisPair: TOracleQuery
    SQL.Strings = (
      'delete from vi_risupair'
      'where '
      '  mnr = :P_MNR and'
      '  trunc(in_date) = trunc(:P_DATUM) and'
      '  hours_id in '
      '  (select hours_id '
      '   from ta_ris_hour '
      '   where is_odsot='#39'DA'#39' and nvl(is_usr1, '#39'DA'#39') = '#39'DA'#39')')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000002000000060000003A505F4D4E520300000000000000000000000800
      00003A505F444154554D0C0000000000000000000000}
    Left = 736
    Top = 246
  end
  object quInsOdsotRisPair: TOracleQuery
    SQL.Strings = (
      'insert into vi_risupair p (mnr, in_date, out_date, hours_id)'
      'values (:P_MNR, :P_IN_DATE, :P_OUT_DATE, :P_HOURS_ID)'
      '')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000004000000060000003A505F4D4E520300000000000000000000000A00
      00003A505F494E5F444154450C00000000000000000000000B0000003A505F4F
      55545F444154450C00000000000000000000000B0000003A505F484F5552535F
      4944030000000000000000000000}
    Left = 768
    Top = 246
  end
end
