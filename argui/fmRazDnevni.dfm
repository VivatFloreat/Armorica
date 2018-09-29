object fmRazpD: TfmRazpD
  Left = 232
  Top = 104
  Width = 1043
  Height = 817
  Caption = 'Razpored osebja - dnevni pogled'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1035
    Height = 41
    Align = alTop
    TabOrder = 0
    object sbPrev: TSpeedButton
      Left = 260
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
      Left = 284
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
    object Label1: TLabel
      Left = 11
      Top = 11
      Width = 81
      Height = 13
      Caption = 'Datum razporeda'
    end
    object laDatum: TLabel
      Left = 328
      Top = 13
      Width = 47
      Height = 13
      Alignment = taCenter
      Caption = 'laDatum'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edDatum: TDateEdit
      Left = 104
      Top = 8
      Width = 153
      Height = 21
      DefaultToday = True
      Enabled = False
      NumGlyphs = 2
      TabOrder = 0
    end
    object Panel6: TPanel
      Left = 920
      Top = 1
      Width = 114
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object bbOk: TBitBtn
        Left = 22
        Top = 8
        Width = 75
        Height = 25
        Caption = 'V redu'
        TabOrder = 0
        Kind = bkOK
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 1035
    Height = 749
    Align = alClient
    TabOrder = 1
    object Panel3: TPanel
      Left = 712
      Top = 1
      Width = 322
      Height = 747
      Align = alRight
      TabOrder = 0
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 320
        Height = 28
        Align = alTop
        TabOrder = 0
        object Label2: TLabel
          Left = 9
          Top = 7
          Width = 86
          Height = 13
          Caption = 'Odsotne osebe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object Panel5: TPanel
        Left = 1
        Top = 353
        Width = 320
        Height = 28
        Align = alTop
        TabOrder = 1
        object Label3: TLabel
          Left = 9
          Top = 7
          Width = 121
          Height = 13
          Caption = 'Nerazporejene osebe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object lbNerazp: TcxMCListBox
        Left = 1
        Top = 381
        Width = 320
        Height = 365
        Align = alClient
        DragMode = dmAutomatic
        HeaderSections = <
          item
            AllowClick = True
            MinWidth = 40
            Text = 'MNR'
            Width = 40
          end
          item
            AllowClick = True
            MinWidth = 50
            SortOrder = soAscending
            Text = 'Priimek'
            Width = 100
          end
          item
            AllowClick = True
            MinWidth = 50
            Text = 'Ime'
            Width = 100
          end
          item
            AllowClick = True
            Text = 'Ure'
            Width = 40
          end
          item
            AllowClick = True
            Text = 'NP'
            Width = 40
          end>
        Sorted = True
        TabOrder = 2
        OnEndDrag = lbNerazpEndDrag
        OnMouseDown = lbNerazpMouseDown
      end
      object lbOdsot: TcxMCListBox
        Left = 1
        Top = 29
        Width = 320
        Height = 324
        Align = alTop
        HeaderSections = <
          item
            AllowClick = True
            MinWidth = 40
            Text = 'MNR'
            Width = 58
          end
          item
            AllowClick = True
            MinWidth = 50
            SortOrder = soAscending
            Text = 'Priimek'
            Width = 100
          end
          item
            AllowClick = True
            MinWidth = 50
            Text = 'Ime'
            Width = 100
          end
          item
            AllowClick = True
            MinWidth = 40
            Text = 'Odsotnost'
            Width = 58
          end>
        Sorted = True
        TabOrder = 3
      end
    end
    object RxSplitter1: TRxSplitter
      Left = 708
      Top = 1
      Width = 4
      Height = 747
      ControlFirst = Grid
      ControlSecond = Panel3
      Align = alRight
      Color = clBackground
    end
    object Grid: TcxGrid
      Left = 1
      Top = 1
      Width = 707
      Height = 747
      Align = alClient
      PopupMenu = mnuPopup
      TabOrder = 2
      object viDeDm: TcxGridDBBandedTableView
        OnDragDrop = viDeDmDragDrop
        OnDragOver = viDeDmDragOver
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = dsPlan
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0'
            Kind = skSum
            Column = viDeDmNUM_MIN
          end
          item
            Format = '#,##0'
            Kind = skSum
            Column = viDeDmColNumOseb
          end
          item
            Format = '#,##0'
            Kind = skSum
            Column = viDeDmColNumDelta
          end>
        DataController.Summary.SummaryGroups = <
          item
            Links = <
              item
              end
              item
              end
              item
                Column = viDeDmNAZIV
              end>
            SummaryItems.Separator = ';'
            SummaryItems = <
              item
                Format = '#,##0'
                Kind = skSum
                Position = spFooter
                Column = viDeDmNUM_MIN
              end
              item
                Format = '#,##0'
                Kind = skSum
                Position = spFooter
                Column = viDeDmColNumDelta
              end
              item
                Format = '#,##0'
                Kind = skSum
                Position = spFooter
                Column = viDeDmColNumOseb
              end
              item
                Format = 'Planirano = #,##0'
                Kind = skSum
                Column = viDeDmNUM_MIN
              end
              item
                Format = 'Dejansko = #,##0'
                Kind = skSum
                Column = viDeDmColNumOseb
              end
              item
                Format = 'Vi'#353'ek/manjko = #,##0'
                Kind = skSum
                Column = viDeDmColNumDelta
              end>
          end
          item
            Links = <
              item
                Column = viDeDmDEPA_DESC
              end>
            SummaryItems = <
              item
                Format = '#,##0'
                Kind = skSum
                Position = spFooter
                Column = viDeDmNUM_MIN
              end
              item
                Format = '#,##0'
                Kind = skSum
                Position = spFooter
                Column = viDeDmColNumOseb
              end
              item
                Format = '#,##0'
                Kind = skSum
                Position = spFooter
                Column = viDeDmColNumDelta
              end>
          end>
        OptionsBehavior.CellHints = True
        OptionsSelection.CellMultiSelect = True
        OptionsView.Navigator = True
        OptionsView.CellAutoHeight = True
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupFooters = gfVisibleWhenExpanded
        OptionsView.GroupRowHeight = 18
        OptionsView.GroupSummaryLayout = gslAlignWithColumns
        OptionsView.BandHeaders = False
        Styles.Footer = xStyleFooter
        Bands = <
          item
            Caption = 'Delovi'#353#269'e in delovno mesto'
            FixedKind = fkLeft
            Width = 400
          end
          item
            Caption = 'Razporejeno osebje'
            Width = 250
          end>
        object viDeDmDEM_ID: TcxGridDBBandedColumn
          DataBinding.FieldName = 'DEM_ID'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 7
          Position.RowIndex = 0
        end
        object viDeDmDEPART_ID: TcxGridDBBandedColumn
          DataBinding.FieldName = 'DEPART_ID'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 6
          Position.RowIndex = 0
        end
        object viDeDmSHIFT_ID: TcxGridDBBandedColumn
          DataBinding.FieldName = 'SHIFT_ID'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 8
          Position.RowIndex = 0
        end
        object viDeDmDEPA_DESC: TcxGridDBBandedColumn
          DataBinding.FieldName = 'DEPA_DESC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Vert = taVCenter
          Visible = False
          GroupIndex = 0
          SortIndex = 1
          SortOrder = soAscending
          Width = 140
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object viDeDmNAZIV: TcxGridDBBandedColumn
          DataBinding.FieldName = 'NAZIV'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Vert = taVCenter
          SortIndex = 0
          SortOrder = soAscending
          Width = 103
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object viDeDmSHIFT_DESC: TcxGridDBBandedColumn
          DataBinding.FieldName = 'SHIFT_DESC'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Vert = taVCenter
          Width = 88
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object viDeDmNUM_MIN: TcxGridDBBandedColumn
          Caption = 'Plan'
          DataBinding.FieldName = 'NUM_MIN'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Vert = taVCenter
          Width = 38
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object viDeDmColNumOseb: TcxGridDBBandedColumn
          Caption = 'Razp'
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          FooterAlignmentHorz = taRightJustify
          Options.Editing = False
          Width = 48
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object viDeDmColNumDelta: TcxGridDBBandedColumn
          Caption = 'Razlika'
          DataBinding.ValueType = 'Integer'
          PropertiesClassName = 'TcxTextEditProperties'
          Properties.Alignment.Horz = taRightJustify
          Properties.Alignment.Vert = taVCenter
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taCenter
          Options.Editing = False
          Width = 47
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
        object viDeDmColOsebe: TcxGridDBBandedColumn
          Caption = 'Dan'
          DataBinding.ValueType = 'String'
          PropertiesClassName = 'TcxMemoProperties'
          Properties.Alignment = taCenter
          HeaderAlignmentHorz = taCenter
          Options.Editing = False
          Options.Filtering = False
          Width = 101
          Position.BandIndex = 1
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
      end
      object leDeDm: TcxGridLevel
        GridView = viDeDm
      end
    end
  end
  object quPlan: TOracleDataSet
    SQL.Strings = (
      'select'
      '  p.id,'
      '  p.datum,'
      '  p.depart_id,'
      '  depa.depart,'
      '  depa.description depa_desc, '
      '  p.dem_id,'
      '  dm.sifra,'
      '  dm.naziv,'
      '  p.shift_id,'
      '  sh.arm_oznaka,'
      '  sh.shift_no,'
      '  sh.description shift_desc,'
      '  num_min,'
      '  num_opt,'
      '  num_max'
      'from '
      
        '  ta_arm_plan p, ta_ris_depa depa, ta_arm_deme dm, ta_ris_shif s' +
        'h'
      'where '
      '  p.dem_id = dm.id and'
      '  p.depart_id = depa.depart_id and'
      '  p.shift_id = sh.shift_id and'
      '  DATUM = :P_DATUM and'
      '  MNR_OWNER = :P_MNR_OWNER'
      'order by '
      '  depa.description, dm.naziv, sh.shift_no'
      '')
    Variables.Data = {
      0300000002000000080000003A505F444154554D0C00000007000000786A0C0F
      010101000000000C0000003A505F4D4E525F4F574E4552030000000000000000
      000000}
    QBEDefinition.QBEFieldDefs = {
      040000000F00000002000000494401000000000005000000444154554D010000
      000000090000004445504152545F49440100000000000600000044454D5F4944
      0100000000000800000053484946545F4944010000000000070000004E554D5F
      4D494E010000000000070000004E554D5F4F5054010000000000070000004E55
      4D5F4D4158010000000000060000004445504152540100000000000900000044
      4550415F44455343010000000000050000005349465241010000000000050000
      004E415A49560100000000000A00000041524D5F4F5A4E414B41010000000000
      0800000053484946545F4E4F0100000000000A00000053484946545F44455343
      010000000000}
    Session = dmOracle.oraSession
    Left = 728
    Top = 9
    object quPlanID: TFloatField
      FieldName = 'ID'
      Required = True
    end
    object quPlanDATUM: TDateTimeField
      DisplayLabel = 'Datum'
      FieldName = 'DATUM'
      Required = True
    end
    object quPlanDEPART_ID: TFloatField
      FieldName = 'DEPART_ID'
      Required = True
    end
    object quPlanDEPART: TStringField
      FieldName = 'DEPART'
      Size = 30
    end
    object quPlanDEPA_DESC: TStringField
      DisplayLabel = 'Delovi'#353#269'e'
      FieldName = 'DEPA_DESC'
      Size = 30
    end
    object quPlanDEM_ID: TFloatField
      FieldName = 'DEM_ID'
    end
    object quPlanARM_OZNAKA: TStringField
      FieldName = 'ARM_OZNAKA'
      Size = 30
    end
    object quPlanSIFRA: TStringField
      FieldName = 'SIFRA'
      Required = True
      Size = 30
    end
    object quPlanNAZIV: TStringField
      DisplayLabel = 'DM'
      FieldName = 'NAZIV'
      Size = 255
    end
    object quPlanSHIFT_ID: TIntegerField
      FieldName = 'SHIFT_ID'
    end
    object quPlanSHIFT_DESC: TStringField
      DisplayLabel = 'Izmena (turnus)'
      FieldName = 'SHIFT_DESC'
      Size = 30
    end
    object quPlanSHIFT_NO: TIntegerField
      FieldName = 'SHIFT_NO'
      Required = True
    end
    object quPlanNUM_MIN: TIntegerField
      DisplayLabel = 'Minimalno '#353'tevilo'
      FieldName = 'NUM_MIN'
    end
    object quPlanNUM_OPT: TIntegerField
      FieldName = 'NUM_OPT'
    end
    object quPlanNUM_MAX: TIntegerField
      FieldName = 'NUM_MAX'
    end
  end
  object dsPlan: TDataSource
    DataSet = quPlan
    Left = 760
    Top = 8
  end
  object mnuPopup: TPopupMenu
    Left = 632
    Top = 313
    object miOsebaAdd: TMenuItem
      Caption = 'Dodaj osebo'
      OnClick = miOsebaAddClick
    end
    object miAddOsebaNoCheck: TMenuItem
      Caption = 'Dodaj osebo brez preverjanja!'
      OnClick = miOsebaAddClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miOsebaDel: TMenuItem
      Caption = 'Odstrani osebo'
      OnClick = miOsebaDelClick
    end
  end
  object myStyles: TcxStyleRepository
    Left = 8
    Top = 8
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
    end
    object cxStyleRaz2: TcxStyle
      AssignedValues = [svColor]
      Color = clSilver
    end
    object xStyleFooter: TcxStyle
      AssignedValues = [svColor]
      Color = clInfoBk
    end
  end
end
