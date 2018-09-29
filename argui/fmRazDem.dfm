object fmRazpDem: TfmRazpDem
  Left = 213
  Top = 124
  Width = 1018
  Height = 730
  Caption = 'Razporeditve delavcev'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1010
    Height = 41
    Align = alTop
    TabOrder = 0
    object Panel11: TPanel
      Left = 891
      Top = 1
      Width = 118
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object BitBtn1: TBitBtn
        Left = 30
        Top = 8
        Width = 75
        Height = 25
        Caption = 'Zapri'
        TabOrder = 0
        Kind = bkClose
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 662
    Width = 1010
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 1010
    Height = 621
    Align = alClient
    TabOrder = 2
    object cxSplitter1: TcxSplitter
      Left = 545
      Top = 1
      Width = 3
      Height = 619
      Control = Panel4
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 544
      Height = 619
      Align = alLeft
      TabOrder = 1
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 542
        Height = 24
        Align = alTop
        Alignment = taLeftJustify
        Caption = 'Seznam razporeditev'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object pcLeft: TcxPageControl
        Left = 1
        Top = 25
        Width = 542
        Height = 593
        ActivePage = tsDM
        Align = alClient
        LookAndFeel.Kind = lfUltraFlat
        PopupMenu = mnuPopup
        TabOrder = 1
        ClientRectBottom = 593
        ClientRectRight = 542
        ClientRectTop = 24
        object tsDM: TcxTabSheet
          Caption = 'Razporeditve po DM'
          ImageIndex = 0
          object grArmCaDm: TcxGrid
            Left = 0
            Top = 0
            Width = 542
            Height = 528
            Align = alClient
            TabOrder = 0
            object tvArmCaDm: TcxGridDBTableView
              PopupMenu = mnuPopup
              OnDblClick = miLookOsebaLevoClick
              NavigatorButtons.ConfirmDelete = False
              DataController.DataSource = dsArmCaDm
              DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.ImmediateEditor = False
              OptionsBehavior.FocusCellOnCycle = True
              OptionsSelection.InvertSelect = False
              OptionsSelection.MultiSelect = True
              OptionsView.Navigator = True
              object tvArmCaDmID: TcxGridDBColumn
                DataBinding.FieldName = 'ID'
                Visible = False
              end
              object tvArmCaDmMNR: TcxGridDBColumn
                DataBinding.FieldName = 'MNR'
              end
              object tvArmCaDmPRIIMEK: TcxGridDBColumn
                Caption = 'Priimek in ime'
                DataBinding.FieldName = 'PRIIMEK'
                Width = 255
              end
              object tvArmCaDmDEM_ID: TcxGridDBColumn
                DataBinding.FieldName = 'DEM_ID'
                Visible = False
              end
              object tvArmCaDmOE: TcxGridDBColumn
                DataBinding.FieldName = 'OE'
                Visible = False
                GroupIndex = 1
                Options.Editing = False
                SortIndex = 2
                SortOrder = soAscending
                Width = 248
              end
              object tvArmCaDmSTATUS: TcxGridDBColumn
                Caption = 'Status'
                DataBinding.FieldName = 'STATUS'
                Width = 53
              end
              object tvArmCaDmDEME_NAZIV: TcxGridDBColumn
                Caption = 'Delovno mesto'
                DataBinding.FieldName = 'DEME_NAZIV'
                Visible = False
                GroupIndex = 0
                SortIndex = 0
                SortOrder = soAscending
                Width = 153
              end
              object tvArmCaDmVELJA_OD: TcxGridDBColumn
                Caption = 'Velja od'
                DataBinding.FieldName = 'VELJA_OD'
              end
              object tvArmCaDmVELJA_DO: TcxGridDBColumn
                Caption = 'Velja do'
                DataBinding.FieldName = 'VELJA_DO'
              end
              object tvArmCaDmORG1: TcxGridDBColumn
                DataBinding.FieldName = 'ORG1'
                Options.Editing = False
                SortIndex = 1
                SortOrder = soAscending
              end
            end
            object leArmCaDm: TcxGridLevel
              GridView = tvArmCaDm
            end
          end
          object Panel6: TPanel
            Left = 0
            Top = 528
            Width = 542
            Height = 41
            Align = alBottom
            TabOrder = 1
            object bbExcelDM: TBitBtn
              Left = 12
              Top = 8
              Width = 99
              Height = 25
              Caption = 'Izvoz v Excel'
              TabOrder = 0
              OnClick = bbExcelDMClick
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
          end
        end
        object tsDEL: TcxTabSheet
          Caption = 'Razporeditve po delovi'#353#269'ih'
          ImageIndex = 1
          object grArmCaDe: TcxGrid
            Left = 0
            Top = 0
            Width = 542
            Height = 528
            Align = alClient
            TabOrder = 0
            object viArmCaDe: TcxGridDBTableView
              PopupMenu = mnuPopup
              OnDblClick = miLookOsebaLevoClick
              NavigatorButtons.ConfirmDelete = False
              DataController.DataSource = dsArmCade
              DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.ImmediateEditor = False
              OptionsBehavior.FocusCellOnCycle = True
              OptionsSelection.MultiSelect = True
              OptionsView.Navigator = True
              object viArmCaDeID: TcxGridDBColumn
                DataBinding.FieldName = 'ID'
                Visible = False
              end
              object viArmCaDeMNR: TcxGridDBColumn
                DataBinding.FieldName = 'MNR'
              end
              object viArmCaDeDEPART_NAZIV: TcxGridDBColumn
                Caption = 'Delovi'#353#269'e'
                DataBinding.FieldName = 'DEPART_NAZIV'
                Visible = False
                GroupIndex = 0
                SortIndex = 0
                SortOrder = soDescending
              end
              object viArmCaDePRIIMEK: TcxGridDBColumn
                DataBinding.FieldName = 'PRIIMEK'
                Width = 186
              end
              object viArmCaDeDEPART_ID: TcxGridDBColumn
                DataBinding.FieldName = 'DEPART_ID'
                Visible = False
              end
              object viArmCaDeOE: TcxGridDBColumn
                DataBinding.FieldName = 'OE'
                Visible = False
                GroupIndex = 1
                SortIndex = 1
                SortOrder = soAscending
              end
              object viArmCaDeSTATUS: TcxGridDBColumn
                Caption = 'Status'
                DataBinding.FieldName = 'STATUS'
                Width = 77
              end
              object viArmCaDeVELJA_OD: TcxGridDBColumn
                Caption = 'Velja od'
                DataBinding.FieldName = 'VELJA_OD'
              end
              object viArmCaDeVELJA_DO: TcxGridDBColumn
                Caption = 'Velja do'
                DataBinding.FieldName = 'VELJA_DO'
              end
              object viArmCaDeORG1: TcxGridDBColumn
                DataBinding.FieldName = 'ORG1'
              end
            end
            object leArmCade: TcxGridLevel
              GridView = viArmCaDe
            end
          end
          object Panel7: TPanel
            Left = 0
            Top = 528
            Width = 542
            Height = 41
            Align = alBottom
            TabOrder = 1
            object bbExcelDEL: TBitBtn
              Left = 11
              Top = 8
              Width = 99
              Height = 25
              Caption = 'Izvoz v Excel'
              TabOrder = 0
              OnClick = bbExcelDELClick
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
          end
        end
        object tsSHIF: TcxTabSheet
          Caption = 'Razporeditve v izmene'
          ImageIndex = 2
          object Panel12: TPanel
            Left = 0
            Top = 528
            Width = 542
            Height = 41
            Align = alBottom
            TabOrder = 0
            object bbExcelSHIF: TBitBtn
              Left = 18
              Top = 8
              Width = 99
              Height = 25
              Caption = 'Izvoz v Excel'
              TabOrder = 0
              OnClick = bbExcelSHIFClick
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
          end
          object grArmCaSh: TcxGrid
            Left = 0
            Top = 0
            Width = 542
            Height = 528
            Align = alClient
            TabOrder = 1
            object tvArmCaSh: TcxGridDBTableView
              PopupMenu = mnuPopup
              OnDblClick = miLookOsebaLevoClick
              NavigatorButtons.ConfirmDelete = False
              DataController.DataSource = dsArmCaSh
              DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.ImmediateEditor = False
              OptionsBehavior.FocusCellOnCycle = True
              OptionsSelection.MultiSelect = True
              OptionsSelection.UnselectFocusedRecordOnExit = False
              OptionsView.Navigator = True
              object tvArmCaShMNR: TcxGridDBColumn
                DataBinding.FieldName = 'MNR'
              end
              object tvArmCaShPRIIMEK: TcxGridDBColumn
                Caption = 'Priimek in ime'
                DataBinding.FieldName = 'PRIIMEK'
                Width = 143
              end
              object tvArmCaShSHIFT_DESC: TcxGridDBColumn
                Caption = 'Izmena'
                DataBinding.FieldName = 'SHIFT_DESC'
                Visible = False
                GroupIndex = 0
                SortIndex = 0
                SortOrder = soAscending
                Width = 177
              end
              object tvArmCaShSHIFT_NO: TcxGridDBColumn
                DataBinding.FieldName = 'SHIFT_NO'
              end
              object tvArmCaShSTATUS: TcxGridDBColumn
                Caption = 'Status'
                DataBinding.FieldName = 'STATUS'
                Width = 58
              end
              object tvArmCaShVELJA_OD: TcxGridDBColumn
                Caption = 'Velja od'
                DataBinding.FieldName = 'VELJA_OD'
              end
              object tvArmCaShVELJA_DO: TcxGridDBColumn
                Caption = 'Velja do'
                DataBinding.FieldName = 'VELJA_DO'
              end
              object tvArmCaShSHIFT_ID: TcxGridDBColumn
                DataBinding.FieldName = 'SHIFT_ID'
                Visible = False
              end
              object tvArmCaShORG1: TcxGridDBColumn
                DataBinding.FieldName = 'ORG1'
              end
              object tvArmCaShOE: TcxGridDBColumn
                DataBinding.FieldName = 'OE'
                Visible = False
                GroupIndex = 1
                SortIndex = 1
                SortOrder = soAscending
              end
            end
            object leArmCaSh: TcxGridLevel
              GridView = tvArmCaSh
            end
          end
        end
      end
    end
    object Panel8: TPanel
      Left = 548
      Top = 1
      Width = 461
      Height = 619
      Align = alClient
      TabOrder = 2
      object Panel9: TPanel
        Left = 1
        Top = 1
        Width = 459
        Height = 24
        Align = alTop
        Alignment = taLeftJustify
        Caption = 'Seznam delavcev'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object Panel10: TPanel
        Left = 1
        Top = 577
        Width = 459
        Height = 41
        Align = alBottom
        TabOrder = 1
      end
      object grUCard: TcxGrid
        Left = 1
        Top = 25
        Width = 459
        Height = 552
        Align = alClient
        TabOrder = 2
        object tvUCard: TcxGridDBTableView
          PopupMenu = mnuPopupRight
          OnDblClick = miLookosebaDesnoClick
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = dsUCard
          DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.FocusCellOnCycle = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsSelection.MultiSelect = True
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.Navigator = True
          object tvUCardMNR: TcxGridDBColumn
            DataBinding.FieldName = 'MNR'
          end
          object tvUCardPRIIMEKINIME: TcxGridDBColumn
            Caption = 'Priimek in ime'
            DataBinding.FieldName = 'PRIIMEKINIME'
            Width = 199
          end
          object tvUCardORG1: TcxGridDBColumn
            Caption = 'Skupina'
            DataBinding.FieldName = 'ORG1'
          end
          object tvUCardAKT: TcxGridDBColumn
            DataBinding.FieldName = 'AKT'
          end
          object tvUCardEMPLOYED: TcxGridDBColumn
            Caption = 'Tip zaposlitve'
            DataBinding.FieldName = 'EMPLOYED'
            Width = 88
          end
          object tvUCardDEPART: TcxGridDBColumn
            DataBinding.FieldName = 'DEPART'
            Visible = False
            GroupIndex = 0
          end
        end
        object leUCard: TcxGridLevel
          GridView = tvUCard
        end
      end
    end
  end
  object taArmCaDm: TOracleDataSet
    SQL.Strings = (
      'select'
      '  t.rowid,'
      '  t.id,'
      '  t.mnr,'
      '  t.dem_id,'
      '  t.status,'
      '  t.velja_od,'
      '  t.velja_do,'
      '  t.cuser,'
      '  t.created,'
      '  t.luser,'
      '  t.lchange,'
      '  crd.org1'
      'from '
      '  ta_arm_cadm t, vi_risucard c, ta_ris_card crd'
      'where t.mnr = c.mnr'
      '  and t.mnr = crd.mnr'
      '  and c.tree_id = :P_TREE_ID'
      'order by c.lname, c.fname'
      ''
      ' ')
    Variables.Data = {
      03000000010000000A0000003A505F545245455F494403000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      040000000C000000020000004944010000000000030000004D4E520100000000
      000600000044454D5F4944010000000000060000005354415455530100000000
      000800000056454C4A415F4F440100000000000800000056454C4A415F444F01
      0000000000050000004355534552010000000000070000004352454154454401
      0000000000050000004C55534552010000000000070000004C4348414E474501
      0000000000040000004F524731010000000000020000004F45010000000000}
    Session = dmOracle.oraSession
    BeforeOpen = taArmCaDmBeforeOpen
    AfterInsert = taArmCaDmAfterInsert
    Left = 24
    Top = 8
    object taArmCaDmID: TFloatField
      FieldName = 'ID'
    end
    object taArmCaDmMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object taArmCaDmPRIIMEK: TStringField
      DisplayWidth = 80
      FieldKind = fkLookup
      FieldName = 'PRIIMEK'
      LookupDataSet = quRisUCard
      LookupKeyFields = 'MNR'
      LookupResultField = 'PRIIMEKINIME'
      KeyFields = 'MNR'
      Size = 100
      Lookup = True
    end
    object taArmCaDmDEM_ID: TFloatField
      FieldName = 'DEM_ID'
      Required = True
    end
    object taArmCaDmDEME_NAZIV: TStringField
      FieldKind = fkLookup
      FieldName = 'DEME_NAZIV'
      LookupDataSet = dmOracle.quArmDeme
      LookupKeyFields = 'ID'
      LookupResultField = 'NAZIV'
      KeyFields = 'DEM_ID'
      Size = 255
      Lookup = True
    end
    object taArmCaDmSTATUS: TStringField
      FieldName = 'STATUS'
      Required = True
      Size = 1
    end
    object taArmCaDmVELJA_OD: TDateTimeField
      FieldName = 'VELJA_OD'
    end
    object taArmCaDmVELJA_DO: TDateTimeField
      FieldName = 'VELJA_DO'
    end
    object taArmCaDmCUSER: TStringField
      FieldName = 'CUSER'
      Size = 30
    end
    object taArmCaDmCREATED: TDateTimeField
      FieldName = 'CREATED'
    end
    object taArmCaDmLUSER: TStringField
      FieldName = 'LUSER'
      Size = 30
    end
    object taArmCaDmLCHANGE: TDateTimeField
      FieldName = 'LCHANGE'
    end
    object taArmCaDmORG1: TIntegerField
      DisplayLabel = 'Skupina'
      FieldName = 'ORG1'
      ReadOnly = True
    end
    object taArmCaDmOE: TStringField
      DisplayLabel = 'Oddelek'
      FieldKind = fkLookup
      FieldName = 'OE'
      LookupDataSet = quRisUCard
      LookupKeyFields = 'MNR'
      LookupResultField = 'DEPART'
      KeyFields = 'MNR'
      ReadOnly = True
      Size = 90
      Lookup = True
    end
  end
  object dsArmCaDm: TDataSource
    DataSet = taArmCaDm
    Left = 24
    Top = 40
  end
  object quRisUCard: TOracleDataSet
    SQL.Strings = (
      'select '
      'c.MNR, '
      'c.akt,'
      'c.LNAME || '#39' '#39' || c.FNAME PriimekInIme,'
      'c.EMPLOYED,'
      'c.org1,'
      'c.org2,'
      'c.org3,'
      'u.depart || '#39' '#39' || u.o_dep_desc depart'
      ''
      'from '
      '  ta_ris_card c, vi_risucard u'
      'where '
      '  c.mnr = u.mnr'
      'order by '
      '  c.lname, c.fname'
      '')
    QBEDefinition.QBEFieldDefs = {
      0400000008000000030000004D4E5201000000000008000000454D504C4F5945
      440100000000000C000000505249494D454B494E494D45010000000000040000
      004F524731010000000000040000004F524732010000000000040000004F5247
      3301000000000003000000414B54010000000000060000004445504152540100
      00000000}
    Session = dmOracle.oraSession
    Left = 200
    Top = 8
    object quRisUCardMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object quRisUCardPRIIMEKINIME: TStringField
      FieldName = 'PRIIMEKINIME'
      Size = 41
    end
    object quRisUCardAKT: TIntegerField
      DisplayLabel = 'Aktivnost'
      FieldName = 'AKT'
    end
    object quRisUCardEMPLOYED: TStringField
      FieldName = 'EMPLOYED'
      Required = True
      Size = 10
    end
    object quRisUCardORG1: TIntegerField
      FieldName = 'ORG1'
    end
    object quRisUCardORG2: TIntegerField
      FieldName = 'ORG2'
    end
    object quRisUCardORG3: TIntegerField
      FieldName = 'ORG3'
    end
    object quRisUCardDEPART: TStringField
      DisplayLabel = 'Oddelek'
      FieldName = 'DEPART'
      Size = 30
    end
  end
  object dsUCard: TDataSource
    DataSet = quRisUCard
    Left = 200
    Top = 40
  end
  object taArmCaDe: TOracleDataSet
    SQL.Strings = (
      'select'
      '  t.rowid,'
      '  t.id,'
      '  t.mnr,'
      '  t.depart_id,'
      '  t.status,'
      '  t.velja_od,'
      '  t.velja_do,'
      '  t.cuser,'
      '  t.created,'
      '  t.luser,'
      '  t.lchange,'
      '  crd.org1'
      'from '
      '  ta_arm_cade t, vi_risucard c, ta_ris_card crd'
      'where t.mnr = c.mnr and'
      '  t.mnr = crd.mnr and '
      '  c.tree_id = :P_TREE_ID'
      'order by c.lname, c.fname')
    Variables.Data = {
      03000000010000000A0000003A505F545245455F494403000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      040000000B000000020000004944010000000000030000004D4E520100000000
      00060000005354415455530100000000000800000056454C4A415F4F44010000
      0000000800000056454C4A415F444F0100000000000500000043555345520100
      000000000700000043524541544544010000000000050000004C555345520100
      00000000070000004C4348414E4745010000000000090000004445504152545F
      4944010000000000040000004F524731010000000000}
    Session = dmOracle.oraSession
    BeforeOpen = taArmCaDeBeforeOpen
    AfterInsert = taArmCaDeAfterInsert
    Left = 64
    Top = 8
    object taArmCaDeID: TFloatField
      FieldName = 'ID'
    end
    object taArmCaDeMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object taArmCaDePRIIMEK: TStringField
      DisplayLabel = 'Priimek'
      FieldKind = fkLookup
      FieldName = 'PRIIMEK'
      LookupDataSet = quRisUCard
      LookupKeyFields = 'MNR'
      LookupResultField = 'PRIIMEKINIME'
      KeyFields = 'MNR'
      Size = 80
      Lookup = True
    end
    object taArmCaDeDEPART_ID: TFloatField
      FieldName = 'DEPART_ID'
      Required = True
    end
    object taArmCaDeDEPART_NAZIV: TStringField
      FieldKind = fkLookup
      FieldName = 'DEPART_NAZIV'
      LookupDataSet = dmOracle.quDelovisca
      LookupKeyFields = 'DEPART_ID'
      LookupResultField = 'DESCRIPTION'
      KeyFields = 'DEPART_ID'
      Size = 30
      Lookup = True
    end
    object taArmCaDeSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object taArmCaDeVELJA_OD: TDateTimeField
      FieldName = 'VELJA_OD'
    end
    object taArmCaDeVELJA_DO: TDateTimeField
      FieldName = 'VELJA_DO'
    end
    object taArmCaDeCUSER: TStringField
      FieldName = 'CUSER'
      Size = 30
    end
    object taArmCaDeCREATED: TDateTimeField
      FieldName = 'CREATED'
    end
    object taArmCaDeLUSER: TStringField
      FieldName = 'LUSER'
      Size = 30
    end
    object taArmCaDeLCHANGE: TDateTimeField
      FieldName = 'LCHANGE'
    end
    object taArmCaDeORG1: TIntegerField
      DisplayLabel = 'Skupina'
      FieldName = 'ORG1'
    end
    object taArmCaDeOE: TStringField
      DisplayLabel = 'Oddelek'
      FieldKind = fkLookup
      FieldName = 'OE'
      LookupDataSet = quRisUCard
      LookupKeyFields = 'MNR'
      LookupResultField = 'DEPART'
      KeyFields = 'MNR'
      ReadOnly = True
      Size = 30
      Lookup = True
    end
  end
  object dsArmCade: TDataSource
    DataSet = taArmCaDe
    Left = 64
    Top = 40
  end
  object sdExcel: TSaveDialog
    Filter = 'Excel datoteke|*.xls|Vse datoteke|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 50
    Top = 411
  end
  object taArmCaSh: TOracleDataSet
    SQL.Strings = (
      'select'
      '  t.rowid,'
      '  t.id,'
      '  t.mnr,'
      '  t.shift_id,'
      '  t.status,'
      '  t.velja_od,'
      '  t.velja_do,'
      '  t.cuser,'
      '  t.created,'
      '  t.luser,'
      '  t.lchange,'
      '  crd.org1'
      'from '
      '  ta_arm_cash t, vi_risucard c, ta_ris_card crd'
      'where t.mnr = c.mnr and'
      '  t.mnr = crd.mnr and'
      '  c.tree_id = :P_TREE_ID'
      'order by c.lname, c.fname'
      ''
      ''
      ''
      ' ')
    Variables.Data = {
      03000000010000000A0000003A505F545245455F494403000000000000000000
      0000}
    QBEDefinition.QBEFieldDefs = {
      040000000B000000020000004944010000000000030000004D4E520100000000
      00060000005354415455530100000000000800000056454C4A415F4F44010000
      0000000800000056454C4A415F444F0100000000000500000043555345520100
      000000000700000043524541544544010000000000050000004C555345520100
      00000000070000004C4348414E47450100000000000800000053484946545F49
      44010000000000040000004F524731010000000000}
    Session = dmOracle.oraSession
    BeforeOpen = taArmCaShBeforeOpen
    AfterInsert = taArmCaShAfterInsert
    Left = 104
    Top = 8
    object taArmCaShID: TFloatField
      FieldName = 'ID'
    end
    object taArmCaShMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object taArmCaShPRIIMEK: TStringField
      FieldKind = fkLookup
      FieldName = 'PRIIMEK'
      LookupDataSet = quRisUCard
      LookupKeyFields = 'MNR'
      LookupResultField = 'PRIIMEKINIME'
      KeyFields = 'MNR'
      Size = 80
      Lookup = True
    end
    object taArmCaShSHIFT_ID: TFloatField
      FieldName = 'SHIFT_ID'
      Required = True
    end
    object taArmCaShSHIFT_NO: TIntegerField
      DisplayLabel = 'Turnus'
      FieldKind = fkLookup
      FieldName = 'SHIFT_NO'
      LookupDataSet = dmOracle.quRisShif
      LookupKeyFields = 'SHIFT_ID'
      LookupResultField = 'SHIFT_NO'
      KeyFields = 'SHIFT_ID'
      Lookup = True
    end
    object taArmCaShSHIFT_DESC: TStringField
      FieldKind = fkLookup
      FieldName = 'SHIFT_DESC'
      LookupDataSet = dmOracle.quRisShif
      LookupKeyFields = 'SHIFT_ID'
      LookupResultField = 'description'
      KeyFields = 'SHIFT_ID'
      Size = 80
      Lookup = True
    end
    object taArmCaShSTATUS: TStringField
      FieldName = 'STATUS'
      Required = True
      Size = 1
    end
    object taArmCaShVELJA_OD: TDateTimeField
      FieldName = 'VELJA_OD'
    end
    object taArmCaShVELJA_DO: TDateTimeField
      FieldName = 'VELJA_DO'
    end
    object taArmCaShCUSER: TStringField
      FieldName = 'CUSER'
      Size = 30
    end
    object taArmCaShCREATED: TDateTimeField
      FieldName = 'CREATED'
    end
    object taArmCaShLUSER: TStringField
      FieldName = 'LUSER'
      Size = 30
    end
    object taArmCaShLCHANGE: TDateTimeField
      FieldName = 'LCHANGE'
    end
    object taArmCaShORG1: TIntegerField
      DisplayLabel = 'Skupina'
      FieldName = 'ORG1'
    end
    object taArmCaShOE: TStringField
      DisplayLabel = 'Oddelek'
      FieldKind = fkLookup
      FieldName = 'OE'
      LookupDataSet = quRisUCard
      LookupKeyFields = 'MNR'
      LookupResultField = 'DEPART'
      KeyFields = 'MNR'
      ReadOnly = True
      Size = 30
      Lookup = True
    end
  end
  object dsArmCaSh: TDataSource
    DataSet = taArmCaSh
    Left = 104
    Top = 40
  end
  object mnuPopup: TPopupMenu
    Left = 808
    Top = 9
    object Izbraneprenesicopy1: TMenuItem
      Caption = 'Izbrane prenesi - copy'
      Visible = False
      OnClick = Izbraneprenesicopy1Click
    end
    object Poveajizbrane1: TMenuItem
      Caption = 'Izbrane dodaj >>'
      OnClick = Poveajizbrane1Click
    end
    object Postavivrednost1: TMenuItem
      Caption = 'Izbrane odvzemi >>'
      OnClick = Postavivrednost1Click
    end
    object PreobrniIzbor1: TMenuItem
      Caption = 'Preobrni izbor'
      Visible = False
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object miLookOsebaLevo: TMenuItem
      Caption = 'Poglej osebo'
      OnClick = miLookOsebaLevoClick
    end
  end
  object mnuPopupRight: TPopupMenu
    Left = 856
    Top = 8
    object miRazporedi: TMenuItem
      Caption = 'Razporedi izbrane'
      OnClick = miRazporediClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miAddLeft: TMenuItem
      Caption = '<< Izbrane dodaj(+)'
      OnClick = miAddLeftClick
    end
    object miRemoveLeft: TMenuItem
      Caption = '<< Izbrane odvzemi'
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miLookosebaDesno: TMenuItem
      Caption = 'Poglej osebo'
      OnClick = miLookosebaDesnoClick
    end
  end
end
