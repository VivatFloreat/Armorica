object fmPlan: TfmPlan
  Left = 251
  Top = 109
  Width = 1018
  Height = 812
  Caption = 'Pregled mese'#269'nega plana delovi'#353#269
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
    Height = 57
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 10
      Width = 32
      Height = 13
      Caption = 'Mesec'
    end
    object Label2: TLabel
      Left = 176
      Top = 10
      Width = 21
      Height = 13
      Caption = 'Leto'
    end
    object Label4: TLabel
      Left = 254
      Top = 10
      Width = 77
      Height = 13
      Caption = 'Lastnik - skrbnik'
    end
    object bbPopulate: TBitBtn
      Left = 545
      Top = 23
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
      Top = 26
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
      Left = 176
      Top = 26
      Width = 73
      Height = 21
      Value = 2006.000000000000000000
      TabOrder = 2
    end
    object Panel4: TPanel
      Left = 824
      Top = 1
      Width = 185
      Height = 55
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 3
      object bbSave: TBitBtn
        Left = 14
        Top = 16
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
        Top = 16
        Width = 75
        Height = 25
        Caption = 'Pozabi'
        TabOrder = 1
        Kind = bkCancel
      end
    end
    object cbMini: TCheckBox
      Left = 631
      Top = 31
      Width = 113
      Height = 17
      Hint = 'Prikaz plana bo minimiziran (praznih vrstic se ne prikazuje)'
      Caption = 'Minimiziraj prikaz'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object cbPrenosID: TRxDBLookupCombo
      Left = 254
      Top = 26
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
    Top = 57
    Width = 1010
    Height = 687
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object Grid: TcxGrid
      Left = 1
      Top = 1
      Width = 1008
      Height = 685
      Align = alClient
      TabOrder = 0
      object viDeDm: TcxGridDBBandedTableView
        PopupMenu = mnuPopup
        OnDragDrop = viDeDmDragDrop
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dsArmDeDm
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.CellHints = True
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsSelection.CellMultiSelect = True
        OptionsView.Navigator = True
        Bands = <
          item
            Caption = 'Delovi'#353#269'e in delovno mesto'
            FixedKind = fkLeft
            Width = 371
          end
          item
            Caption = 'Koledar'
            Width = 652
          end>
        object viDeDmDEPART_DESC: TcxGridDBBandedColumn
          Caption = 'Delovi'#353#269'e'
          DataBinding.FieldName = 'DEPART_DESC'
          Visible = False
          GroupIndex = 0
          Options.Editing = False
          Options.ShowEditButtons = isebNever
          Options.CellMerging = True
          SortIndex = 0
          SortOrder = soDescending
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object viDeDmDEM_NAZIV: TcxGridDBBandedColumn
          Caption = 'DM'
          DataBinding.FieldName = 'DEM_NAZIV'
          Options.Editing = False
          Options.CellMerging = True
          SortIndex = 1
          SortOrder = soDescending
          Width = 166
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object viDeDmSHIFT_ARM_OZNAKA: TcxGridDBBandedColumn
          Caption = 'Izmena'
          DataBinding.FieldName = 'SHIFT_ARM_OZNAKA'
          Options.Editing = False
          Width = 188
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object viDeDmDEPART_ID: TcxGridDBBandedColumn
          DataBinding.FieldName = 'DEPART_ID'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object viDeDmDEM_ID: TcxGridDBBandedColumn
          DataBinding.FieldName = 'DEM_ID'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object viDeDmSHIFT_ID: TcxGridDBBandedColumn
          DataBinding.FieldName = 'SHIFT_ID'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
      end
      object leDeDm: TcxGridLevel
        GridView = viDeDm
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 744
    Width = 1010
    Height = 41
    Align = alBottom
    TabOrder = 2
    object Label3: TLabel
      Left = 655
      Top = 12
      Width = 82
      Height = 13
      Caption = 'Privzeta vrednost'
    end
    object bbPrint: TBitBtn
      Left = 357
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
      Left = 250
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
      Left = 842
      Top = 1
      Width = 167
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object edMsg: TEdit
        Left = 11
        Top = 8
        Width = 147
        Height = 21
        ReadOnly = True
        TabOrder = 0
      end
    end
    object bbOk: TBitBtn
      Left = 8
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Generator plana'
      Default = True
      TabOrder = 3
      OnClick = bbOkClick
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
      Layout = blGlyphRight
      NumGlyphs = 2
    end
    object edCount: TRxSpinEdit
      Left = 745
      Top = 8
      Width = 73
      Height = 21
      Value = 1.000000000000000000
      TabOrder = 4
    end
    object bbNewEmpty: TBitBtn
      Left = 143
      Top = 8
      Width = 99
      Height = 25
      Caption = 'Nov plan'
      TabOrder = 5
      OnClick = bbNewEmptyClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        003337777777777777F330FFFFFFFFFFF03337F3333FFF3337F330FFFF000FFF
        F03337F33377733337F330FFFFF0FFFFF03337F33337F33337F330FFFF00FFFF
        F03337F33377F33337F330FFFFF0FFFFF03337F33337333337F330FFFFFFFFFF
        F03337FFF3F3F3F3F7F33000F0F0F0F0F0333777F7F7F7F7F7F330F0F000F070
        F03337F7F777F777F7F330F0F0F0F070F03337F7F7373777F7F330F0FF0FF0F0
        F03337F733733737F7F330FFFFFFFF00003337F33333337777F330FFFFFFFF0F
        F03337FFFFFFFF7F373330999999990F033337777777777F733330FFFFFFFF00
        333337FFFFFFFF77333330000000000333333777777777733333}
      NumGlyphs = 2
    end
  end
  object quArmTmpDmx: TOracleDataSet
    SQL.Strings = (
      'select '
      '  depart_id,'
      '  depart,'
      '  depart_desc,'
      '  dem_id,'
      '  dem_naziv,'
      '  shift_id,'
      '  shift_desc,'
      '  shift_arm_oznaka || '#39'-'#39' || shift_desc "shift_arm_oznaka"'
      'from '
      '  ta_arm_tmp_dmx'
      'order by'
      '  depart_desc, dem_naziv, shift_arm_oznaka')
    QBEDefinition.QBEFieldDefs = {
      04000000080000000600000044454D5F49440100000000000900000044455041
      52545F49440100000000000800000053484946545F4944010000000000060000
      004445504152540100000000000B0000004445504152545F4445534301000000
      00000900000044454D5F4E415A49560100000000000A00000053484946545F44
      4553430100000000001000000053484946545F41524D5F4F5A4E414B41010000
      000000}
    DetailFields = 'DEPART_ID'
    Session = dmOracle.oraSession
    Left = 776
    Top = 176
    object quArmTmpDmxDEPART_ID: TFloatField
      FieldName = 'DEPART_ID'
    end
    object quArmTmpDmxDEPART: TStringField
      FieldName = 'DEPART'
      Required = True
      Size = 30
    end
    object quArmTmpDmxDEPART_DESC: TStringField
      FieldName = 'DEPART_DESC'
      Required = True
      Size = 30
    end
    object quArmTmpDmxDEM_ID: TFloatField
      FieldName = 'DEM_ID'
    end
    object quArmTmpDmxDEM_NAZIV: TStringField
      FieldName = 'DEM_NAZIV'
      Required = True
      Size = 255
    end
    object quArmTmpDmxSHIFT_ID: TIntegerField
      FieldName = 'SHIFT_ID'
    end
    object quArmTmpDmxSHIFT_DESC: TStringField
      FieldName = 'SHIFT_DESC'
      Required = True
      Size = 30
    end
    object quArmTmpDmxSHIFT_ARM_OZNAKA: TStringField
      FieldName = 'SHIFT_ARM_OZNAKA'
      Required = True
      Size = 30
    end
  end
  object dsArmDeDm: TDataSource
    DataSet = quArmTmpDmx
    Left = 776
    Top = 208
  end
  object myStyles: TcxStyleRepository
    Left = 904
    Top = 120
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clGradientActiveCaption
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
    object cxStyleSobCon: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNone
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clRed
    end
    object cxStyleNedCon: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      TextColor = clRed
    end
  end
  object mnuPopup: TPopupMenu
    Left = 936
    Top = 121
    object Poveajizbrane1: TMenuItem
      Caption = 'Pri'#353'tej / Od'#353'tej'
      OnClick = Poveajizbrane1Click
    end
    object Postavivrednost1: TMenuItem
      Caption = 'Postavi vrednost'
      OnClick = Postavivrednost1Click
    end
    object Zbriivrednosti1: TMenuItem
      Caption = 'Zbri'#353'i vrednost'
      OnClick = Zbriivrednosti1Click
    end
  end
  object quLoadTmp: TOracleQuery
    SQL.Strings = (
      'begin'
      '   sp_p_arm_load_tmp_dmx'
      '                (p_datum_od => :p_datum_od,'
      '                 p_datum_do => :p_datum_do,'
      #9#9'   p_mnr_owner => :p_mnr_owner,'#9'                 '
      '                 p_minimize => :p_minimize);'
      'end;')
    Session = dmOracle.oraSession
    Variables.Data = {
      03000000040000000B0000003A505F444154554D5F4F440C0000000000000000
      0000000B0000003A505F444154554D5F444F0C00000000000000000000000B00
      00003A505F4D494E494D495A450500000000000000000000000C0000003A505F
      4D4E525F4F574E4552030000000000000000000000}
    Left = 808
    Top = 177
  end
  object quPlan: TOracleDataSet
    SQL.Strings = (
      'select'
      '  id,'
      '  datum,'
      '  depart_id,'
      '  dem_id,'
      '  shift_id,'
      '  num_min,'
      '  num_opt,'
      '  num_max'
      'from '
      '  ta_arm_plan'
      'where '
      '  DEPART_ID = :P_DEPART_ID and'
      '  DEM_ID = :P_DEM_ID and'
      '  SHIFT_ID = :P_SHIFT_ID and'
      '  DATUM between :P_DATUM_OD and :P_DATUM_DO and'
      '  MNR_OWNER = :P_MNR_OWNER'
      ''
      '')
    Variables.Data = {
      03000000060000000B0000003A505F444154554D5F4F440C0000000000000000
      0000000B0000003A505F444154554D5F444F0C00000000000000000000000C00
      00003A505F4445504152545F4944080000000000000000000000090000003A50
      5F44454D5F49440800000000000000000000000B0000003A505F53484946545F
      49440800000000000000000000000C0000003A505F4D4E525F4F574E45520300
      00000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000800000002000000494401000000000005000000444154554D010000
      000000090000004445504152545F49440100000000000600000044454D5F4944
      0100000000000800000053484946545F4944010000000000070000004E554D5F
      4D494E010000000000070000004E554D5F4F5054010000000000070000004E55
      4D5F4D4158010000000000}
    Session = dmOracle.oraSession
    Left = 848
    Top = 177
    object quPlanID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object quPlanDATUM: TDateTimeField
      FieldName = 'DATUM'
      Required = True
    end
    object quPlanDEPART_ID: TFloatField
      FieldName = 'DEPART_ID'
      Required = True
    end
    object quPlanDEM_ID: TFloatField
      FieldName = 'DEM_ID'
    end
    object quPlanSHIFT_ID: TIntegerField
      FieldName = 'SHIFT_ID'
    end
    object quPlanNUM_MIN: TIntegerField
      FieldName = 'NUM_MIN'
    end
    object quPlanNUM_OPT: TIntegerField
      FieldName = 'NUM_OPT'
    end
    object quPlanNUM_MAX: TIntegerField
      FieldName = 'NUM_MAX'
    end
  end
  object quDeletePlan: TOracleQuery
    SQL.Strings = (
      'delete from  ta_arm_plan'
      'where (datum between :P_DATUM_OD and :P_DATUM_DO) '
      'and mnr_owner=:P_MNR_OWNER')
    Session = dmOracle.oraSession
    Variables.Data = {
      03000000030000000B0000003A505F444154554D5F4F440C0000000000000000
      0000000B0000003A505F444154554D5F444F0C00000000000000000000000C00
      00003A505F4D4E525F4F574E4552030000000000000000000000}
    Left = 888
    Top = 177
  end
  object quInsertPlan: TOracleQuery
    SQL.Strings = (
      'begin'
      'insert into ta_arm_plan '
      '('
      '   DATUM, '
      '   DEPART_ID, '
      '   DEM_ID, '
      '   SHIFT_ID, '
      '   NUM_MIN, '
      '   NUM_OPT, '
      '   NUM_MAX,'
      '   MNR_OWNER'
      ')'
      'values '
      '('
      '   :P_DATUM, '
      '   :P_DEPART_ID, '
      '   :P_DEM_ID, '
      '   :P_SHIFT_ID, '
      '   :P_NUM_MIN, '
      '   :P_NUM_OPT, '
      '   :P_NUM_MAX,'
      '   :P_MNR_OWNER'
      ');'
      'exception'
      '    when dup_val_on_index then '
      '          update ta_arm_plan  '
      '                 set num_min = :P_NUM_MIN, '
      '                       num_opt = :P_NUM_OPT, '
      '                       num_max = :P_NUM_MAX'
      '                  where mnr_owner = :P_MNR_OWNER and '
      '                        datum = :P_DATUM and  '
      '                        depart_id = :P_DEPART_ID and '
      '                        dem_id = :P_DEM_ID and'
      '                        shift_id = :P_SHIFT_ID;'
      'end;'
      ''
      '')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000008000000080000003A505F444154554D0C0000000000000000000000
      0C0000003A505F4445504152545F494403000000000000000000000009000000
      3A505F44454D5F49440300000000000000000000000B0000003A505F53484946
      545F49440300000000000000000000000A0000003A505F4E554D5F4D494E0300
      000000000000000000000A0000003A505F4E554D5F4F50540300000000000000
      000000000A0000003A505F4E554D5F4D41580300000000000000000000000C00
      00003A505F4D4E525F4F574E4552030000000000000000000000}
    Left = 928
    Top = 177
  end
  object sdHTML: TSaveDialog
    DefaultExt = '*.html'
    FileName = 'MesecniPlan'
    Filter = 'HTML datoteke|*.html|Excel datoteke|*.xls|Vse datoteke|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 928
    Top = 209
  end
end
