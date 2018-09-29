object fmEmpDet: TfmEmpDet
  Left = 243
  Top = 141
  Width = 881
  Height = 767
  Caption = 'Podatki o delavcu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDefault
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 873
    Height = 113
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 86
      Top = 10
      Width = 33
      Height = 13
      Caption = 'MNR:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 79
      Top = 33
      Width = 37
      Height = 13
      Caption = 'Priimek:'
    end
    object Label3: TLabel
      Left = 91
      Top = 56
      Width = 20
      Height = 13
      Caption = 'Ime:'
    end
    object edMNR: TcxDBTextEdit
      Left = 126
      Top = 5
      DataBinding.DataField = 'MNR'
      DataBinding.DataSource = dsRisCard
      Properties.ReadOnly = False
      TabOrder = 0
      Width = 65
    end
    object cbAkt: TcxDBCheckBox
      Left = 197
      Top = 5
      Caption = 'Aktiven(a)'
      DataBinding.DataField = 'AKT'
      DataBinding.DataSource = dsRisCard
      Properties.Alignment = taLeftJustify
      Properties.ValueChecked = 1
      Properties.ValueUnchecked = 0
      Style.Shadow = False
      TabOrder = 1
      Width = 121
    end
    object edPriimek: TcxDBTextEdit
      Left = 126
      Top = 29
      DataBinding.DataField = 'LNAME'
      DataBinding.DataSource = dsRisCard
      TabOrder = 2
      Width = 177
    end
    object edIme: TcxDBTextEdit
      Left = 126
      Top = 53
      DataBinding.DataField = 'FNAME'
      DataBinding.DataSource = dsRisCard
      TabOrder = 3
      Width = 177
    end
    object Panel2: TPanel
      Left = 747
      Top = 1
      Width = 125
      Height = 111
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 4
      object bbSave: TBitBtn
        Left = 40
        Top = 5
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
        Left = 40
        Top = 33
        Width = 75
        Height = 25
        Cancel = True
        Caption = '&Pozabi'
        TabOrder = 1
        OnClick = bbCancelClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
    end
    object ImageRO: TcxDBImage
      Left = 0
      Top = 0
      TabStop = False
      DataBinding.DataField = 'SMALL_PICTURE'
      DataBinding.DataSource = dsRisCaPic
      Properties.CustomFilter = '*.jpg'
      Properties.GraphicClassName = 'TJPEGImage'
      Properties.PopupMenuLayout.MenuItems = []
      Properties.ReadOnly = True
      Properties.Stretch = True
      TabOrder = 5
      Height = 81
      Width = 73
    end
    object bbNext: TBitBtn
      Left = 187
      Top = 80
      Width = 30
      Height = 25
      Hint = 'Naslednji zapis'
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = bbNextClick
    end
    object bbPrev: TBitBtn
      Left = 157
      Top = 80
      Width = 30
      Height = 25
      Hint = 'Prej'#353'nji zapis'
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = bbPrevClick
    end
    object bbFirst: TBitBtn
      Left = 127
      Top = 80
      Width = 30
      Height = 25
      Hint = 'Prvi zapis'
      Caption = '|<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      OnClick = bbFirstClick
    end
    object bbLast: TBitBtn
      Left = 217
      Top = 80
      Width = 30
      Height = 25
      Hint = 'Zadnji zapis'
      Caption = '>|'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 9
      OnClick = bbLastClick
    end
    object gbDirectFind: TGroupBox
      Left = 320
      Top = 24
      Width = 193
      Height = 73
      TabOrder = 10
      Visible = False
      object Label26: TLabel
        Left = 10
        Top = 19
        Width = 33
        Height = 13
        Caption = 'MNR:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edAllMNR: TEdit
        Left = 52
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 0
      end
      object bbFind: TBitBtn
        Left = 56
        Top = 40
        Width = 75
        Height = 25
        Caption = 'Poi'#353#269'i'
        TabOrder = 1
        OnClick = bbFindClick
      end
    end
    object cbFindDirect: TCheckBox
      Left = 320
      Top = 8
      Width = 177
      Height = 17
      Caption = 'Omogo'#269'i iskanje po celi bazi'
      TabOrder = 11
      OnClick = cbFindDirectClick
    end
  end
  object pcEmployee: TcxPageControl
    Left = 0
    Top = 113
    Width = 873
    Height = 627
    Hint = 'Evidentiranje delovnega '#269'asa'
    ActivePage = tsOsnop
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    HotTrack = True
    Images = fmGlobals.Images32
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    MultiLine = True
    ParentFont = False
    TabOrder = 1
    TabSlants.Kind = skCutCorner
    OnChange = pcEmployeeChange
    ClientRectBottom = 627
    ClientRectRight = 873
    ClientRectTop = 41
    object tsOsnop: TcxTabSheet
      Caption = 'Osnovni podatki'
      Color = clBtnFace
      ImageIndex = 0
      ParentColor = False
      object Label4: TLabel
        Left = 34
        Top = 140
        Width = 64
        Height = 13
        Caption = 'Rojstni datum'
      end
      object Label6: TLabel
        Left = 34
        Top = 48
        Width = 18
        Height = 13
        Caption = 'IPN'
      end
      object Label7: TLabel
        Left = 217
        Top = 48
        Width = 62
        Height = 13
        Caption = #352't. ID kartice'
      end
      object Label12: TLabel
        Left = 217
        Top = 139
        Width = 21
        Height = 13
        Caption = 'Spol'
      end
      object Label13: TLabel
        Left = 217
        Top = 96
        Width = 31
        Height = 13
        Caption = 'EM'#352'O'
        FocusControl = edEMSO
      end
      object Label14: TLabel
        Left = 34
        Top = 96
        Width = 77
        Height = 13
        Caption = 'Dav'#269'na '#353'tevilka'
        FocusControl = edDavcna
      end
      object Label16: TLabel
        Left = 217
        Top = 184
        Width = 87
        Height = 13
        Caption = 'Zadnji delovni dan'
      end
      object Label21: TLabel
        Left = 32
        Top = 240
        Width = 27
        Height = 13
        Caption = 'Pla'#269'a'
        FocusControl = edPlaca
        Visible = False
      end
      object Label17: TLabel
        Left = 34
        Top = 7
        Width = 80
        Height = 13
        Alignment = taRightJustify
        Caption = 'Tip zaposlitve'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 34
        Top = 188
        Width = 79
        Height = 13
        Caption = 'Datum vstopa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edIPN: TcxDBTextEdit
        Left = 34
        Top = 64
        DataBinding.DataField = 'DEPART'
        DataBinding.DataSource = dsRisCard
        TabOrder = 1
        Width = 146
      end
      object edEMSO: TDBEdit
        Left = 217
        Top = 112
        Width = 144
        Height = 21
        DataField = 'EMSO'
        DataSource = dsRisCard
        TabOrder = 4
      end
      object edDavcna: TDBEdit
        Left = 34
        Top = 112
        Width = 145
        Height = 21
        DataField = 'DAVCNA'
        DataSource = dsRisCard
        TabOrder = 3
      end
      object edPlaca: TDBEdit
        Left = 32
        Top = 256
        Width = 43
        Height = 21
        DataField = 'HAS_SALARY'
        DataSource = dsRisCard
        TabOrder = 9
        Visible = False
      end
      object cbSpol: TRxDBLookupCombo
        Left = 217
        Top = 155
        Width = 113
        Height = 21
        DropDownCount = 8
        DisplayAllFields = True
        DataField = 'FEMALE'
        DataSource = dsRisCard
        DisplayEmpty = '?'
        LookupField = 'FEMALE'
        LookupDisplay = 'DESCRIPTION'
        LookupSource = dmOracle.dsSpol
        TabOrder = 6
      end
      object edBirthDate: TDBDateEdit
        Left = 34
        Top = 156
        Width = 121
        Height = 21
        DataField = 'BDATE'
        DataSource = dsRisCard
        NumGlyphs = 2
        TabOrder = 5
      end
      object cbEmployed: TRxDBLookupCombo
        Left = 34
        Top = 24
        Width = 145
        Height = 21
        DropDownCount = 8
        DataField = 'EMPLOYED'
        DataSource = dsRisCard
        DisplayEmpty = '?'
        LookupField = 'EMPLOYED'
        LookupDisplay = 'EMPLOYED; DESCRIPTION'
        LookupSource = dmOracle.dsTipZap
        TabOrder = 0
      end
      object edInDate: TDBDateEdit
        Left = 34
        Top = 204
        Width = 121
        Height = 21
        DataField = 'IN_DATE'
        DataSource = dsRisCard
        NumGlyphs = 2
        TabOrder = 7
      end
      object edOutDate: TDBDateEdit
        Left = 217
        Top = 204
        Width = 121
        Height = 21
        DataField = 'OUT_DATE'
        DataSource = dsRisCard
        NumGlyphs = 2
        TabOrder = 8
      end
      object edCardNo: TRxDBComboEdit
        Left = 218
        Top = 64
        Width = 121
        Height = 21
        DataField = 'CARD_NO'
        DataSource = dsRisCard
        NumGlyphs = 1
        TabOrder = 2
        OnButtonClick = edCardNoButtonClick
      end
      object Panel16: TPanel
        Left = 0
        Top = 545
        Width = 873
        Height = 41
        Align = alBottom
        TabOrder = 10
        object bbDeleteCard: TBitBtn
          Left = 16
          Top = 8
          Width = 161
          Height = 25
          Caption = 'Bri'#353'i podatke delavca'
          TabOrder = 0
          OnClick = bbDeleteCardClick
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            33333333333333333333333333333333333333FFFFFFFFFFFFF3300000000000
            003338888888888888F3309999999999903338F33333333338F3309999999999
            903338F33333333338F3309999999999903338FFFFFFFFFFF8F3300000000000
            0033388888888888883333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333333333333333
            3333333333333333333333333333333333333333333333333333}
          NumGlyphs = 2
        end
      end
    end
    object tsOstalo: TcxTabSheet
      Caption = 'Ostali podatki'
      ImageIndex = 16
      object Panel15: TPanel
        Left = 0
        Top = 0
        Width = 873
        Height = 586
        Align = alClient
        TabOrder = 0
        object Slika: TLabel
          Left = 16
          Top = 16
          Width = 23
          Height = 13
          Caption = 'Slika'
        end
        object Label19: TLabel
          Left = 199
          Top = 13
          Width = 70
          Height = 13
          Caption = 'Doma'#269'i naslov'
          FocusControl = DBEdit13
        end
        object Label11: TLabel
          Left = 199
          Top = 61
          Width = 71
          Height = 13
          Caption = 'Doma'#269'i telefon'
          FocusControl = DBEdit5
        end
        object Label20: TLabel
          Left = 199
          Top = 101
          Width = 31
          Height = 13
          Caption = 'E_mail'
          FocusControl = DBEdit14
        end
        object Label25: TLabel
          Left = 199
          Top = 149
          Width = 74
          Height = 13
          Caption = 'Slu'#382'beni naslov'
          FocusControl = DBEdit19
        end
        object Label18: TLabel
          Left = 199
          Top = 197
          Width = 75
          Height = 13
          Caption = 'Slu'#382'beni telefon'
          FocusControl = DBEdit12
        end
        object DBText1: TDBText
          Left = 16
          Top = 240
          Width = 345
          Height = 17
          DataField = 'IME'
          DataSource = dsRisCaPic
        end
        object dbImage: TcxDBImage
          Left = 15
          Top = 30
          DataBinding.DataField = 'SMALL_PICTURE'
          DataBinding.DataSource = dsRisCaPic
          Properties.CustomFilter = '*.jpg'
          Properties.GraphicClassName = 'TJPEGImage'
          Properties.Stretch = True
          TabOrder = 0
          Height = 204
          Width = 169
        end
        object DBEdit13: TDBEdit
          Left = 199
          Top = 29
          Width = 524
          Height = 21
          DataField = 'HOME_ADDR'
          DataSource = dsRisCard
          TabOrder = 1
        end
        object DBEdit5: TDBEdit
          Left = 199
          Top = 77
          Width = 524
          Height = 21
          DataField = 'HOME_TEL'
          DataSource = dsRisCard
          TabOrder = 2
        end
        object DBEdit14: TDBEdit
          Left = 199
          Top = 117
          Width = 524
          Height = 21
          DataField = 'EMAIL'
          DataSource = dsRisCard
          TabOrder = 3
        end
        object DBEdit19: TDBEdit
          Left = 199
          Top = 165
          Width = 524
          Height = 21
          DataField = 'WORK_ADDR'
          DataSource = dsRisCard
          TabOrder = 4
        end
        object DBEdit12: TDBEdit
          Left = 199
          Top = 213
          Width = 199
          Height = 21
          DataField = 'WORK_TEL'
          DataSource = dsRisCard
          TabOrder = 5
        end
        object bbLoadFromFile: TBitBtn
          Left = 18
          Top = 269
          Width = 161
          Height = 25
          Caption = 'Nalo'#382'i sliko iz datoteke'
          TabOrder = 6
          OnClick = bbLoadFromFileClick
        end
        object bbDelete: TBitBtn
          Left = 194
          Top = 269
          Width = 161
          Height = 25
          Caption = 'Bri'#353'i sliko iz baze'
          TabOrder = 7
          OnClick = bbDeleteClick
        end
      end
    end
    object tsOE: TcxTabSheet
      Caption = 'Organizacijske enote'
      ImageIndex = 24
      object Panel12: TPanel
        Left = 0
        Top = 0
        Width = 873
        Height = 73
        Align = alTop
        TabOrder = 0
        object Label8: TLabel
          Left = 24
          Top = 16
          Width = 48
          Height = 13
          Caption = 'Skupina 1'
          FocusControl = DBEdit2
        end
        object Label9: TLabel
          Left = 176
          Top = 16
          Width = 48
          Height = 13
          Caption = 'Skupina 2'
          FocusControl = DBEdit3
        end
        object Label10: TLabel
          Left = 320
          Top = 16
          Width = 48
          Height = 13
          Caption = 'Skupina 3'
          FocusControl = DBEdit4
        end
        object Label24: TLabel
          Left = 464
          Top = 16
          Width = 40
          Height = 13
          Caption = 'Lokacija'
          FocusControl = DBEdit18
        end
        object DBEdit2: TDBEdit
          Left = 24
          Top = 32
          Width = 134
          Height = 21
          DataField = 'ORG1'
          DataSource = dsRisCard
          TabOrder = 0
        end
        object DBEdit3: TDBEdit
          Left = 176
          Top = 32
          Width = 134
          Height = 21
          DataField = 'ORG2'
          DataSource = dsRisCard
          TabOrder = 1
        end
        object DBEdit4: TDBEdit
          Left = 320
          Top = 32
          Width = 134
          Height = 21
          DataField = 'ORG3'
          DataSource = dsRisCard
          TabOrder = 2
        end
        object DBEdit18: TDBEdit
          Left = 464
          Top = 32
          Width = 201
          Height = 21
          DataField = 'WORK_LOCA'
          DataSource = dsRisCard
          TabOrder = 3
        end
      end
      object grDepart: TcxGrid
        Left = 0
        Top = 73
        Width = 873
        Height = 513
        Align = alClient
        TabOrder = 1
        object viDepart: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = dsDepart
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsView.Navigator = True
          object viDepartMNR: TcxGridDBColumn
            DataBinding.FieldName = 'MNR'
            Visible = False
          end
          object viDepartDEPART_ID: TcxGridDBColumn
            Caption = 'Int. '#353'ifra OE'
            DataBinding.FieldName = 'DEPART_ID'
            Width = 69
          end
          object viDepartDEPART: TcxGridDBColumn
            DataBinding.FieldName = 'DEPART'
            MinWidth = 30
            Width = 232
          end
          object viDepartDEPART_DESC: TcxGridDBColumn
            DataBinding.FieldName = 'DEPART_DESC'
            MinWidth = 30
            Width = 398
          end
          object viDepartTREE_DESC: TcxGridDBColumn
            Caption = 'Shema'
            DataBinding.FieldName = 'TREE_DESC'
            Visible = False
            GroupIndex = 0
            MinWidth = 30
          end
        end
        object leDepart: TcxGridLevel
          GridView = viDepart
        end
      end
    end
    object tsRazporeditve: TcxTabSheet
      Caption = 'Razporeditve'
      ImageIndex = 29
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 873
        Height = 381
        Align = alClient
        TabOrder = 0
        object cxSplitter1: TcxSplitter
          Left = 1
          Top = 177
          Width = 871
          Height = 5
          AlignSplitter = salTop
          Control = Panel7
          Color = clBackground
          ParentColor = False
        end
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 871
          Height = 176
          Align = alTop
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object grCaDm: TcxGrid
            Left = 1
            Top = 25
            Width = 869
            Height = 150
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            LookAndFeel.Kind = lfUltraFlat
            object tvCaDm: TcxGridDBTableView
              NavigatorButtons.ConfirmDelete = False
              DataController.DataSource = dsArmCaDm
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsBehavior.FocusCellOnTab = True
              OptionsBehavior.FocusFirstCellOnNewRecord = True
              OptionsBehavior.GoToNextCellOnEnter = True
              OptionsBehavior.ImmediateEditor = False
              OptionsCustomize.ColumnGrouping = False
              OptionsView.Navigator = True
              OptionsView.GroupByBox = False
              object tvCaDmID: TcxGridDBColumn
                DataBinding.FieldName = 'ID'
                Visible = False
              end
              object tvCaDmMNR: TcxGridDBColumn
                DataBinding.FieldName = 'MNR'
              end
              object tvCaDmDEM_ID: TcxGridDBColumn
                DataBinding.FieldName = 'DEM_ID'
                Visible = False
              end
              object tvCaDmDEM_NAZIV: TcxGridDBColumn
                Caption = 'Delovno mesto'
                DataBinding.FieldName = 'DEM_NAZIV'
                Width = 196
              end
              object tvCaDmSTATUS: TcxGridDBColumn
                Caption = 'Status'
                DataBinding.FieldName = 'STATUS'
                Width = 100
              end
              object tvCaDmVELJA_OD: TcxGridDBColumn
                Caption = 'Velja od'
                DataBinding.FieldName = 'VELJA_OD'
                Width = 130
              end
              object tvCaDmVELJA_DO: TcxGridDBColumn
                Caption = 'Velja do'
                DataBinding.FieldName = 'VELJA_DO'
                Width = 131
              end
              object tvCaDmCUSER: TcxGridDBColumn
                DataBinding.FieldName = 'CUSER'
                Visible = False
              end
              object tvCaDmCREATED: TcxGridDBColumn
                DataBinding.FieldName = 'CREATED'
                Visible = False
              end
              object tvCaDmLUSER: TcxGridDBColumn
                DataBinding.FieldName = 'LUSER'
                Visible = False
              end
              object tvCaDmLCHANGE: TcxGridDBColumn
                DataBinding.FieldName = 'LCHANGE'
                Visible = False
              end
            end
            object leCaDm: TcxGridLevel
              GridView = tvCaDm
            end
          end
          object Panel4: TPanel
            Left = 1
            Top = 1
            Width = 869
            Height = 24
            Align = alTop
            Alignment = taLeftJustify
            Caption = 'Razporeditve na delovna mesta'
            TabOrder = 1
          end
        end
        object Panel9: TPanel
          Left = 1
          Top = 182
          Width = 871
          Height = 27
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Razporeditve na delovi'#353#269'a'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
        end
        object grCaDe: TcxGrid
          Left = 1
          Top = 209
          Width = 871
          Height = 171
          Align = alClient
          TabOrder = 3
          object tvCaDe: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            DataController.DataSource = dsArmCaDe
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.FocusFirstCellOnNewRecord = True
            OptionsBehavior.ImmediateEditor = False
            OptionsBehavior.FocusCellOnCycle = True
            OptionsCustomize.ColumnGrouping = False
            OptionsView.Navigator = True
            OptionsView.GroupByBox = False
            object tvCaDeID: TcxGridDBColumn
              DataBinding.FieldName = 'ID'
              Visible = False
            end
            object tvCaDeMNR: TcxGridDBColumn
              DataBinding.FieldName = 'MNR'
              Visible = False
            end
            object tvCaDeDEPART_ID: TcxGridDBColumn
              DataBinding.FieldName = 'DEPART_ID'
              Visible = False
            end
            object tvCaDeDEPART: TcxGridDBColumn
              Caption = #352'ifra delovi'#353#269'a'
              DataBinding.FieldName = 'DEPART'
              Visible = False
            end
            object tvCaDeDEPART_DESC: TcxGridDBColumn
              Caption = 'Delovi'#353#269'e'
              DataBinding.FieldName = 'DEPART_DESC'
            end
            object tvCaDeSTATUS: TcxGridDBColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STATUS'
              Width = 100
            end
            object tvCaDeVELJA_OD: TcxGridDBColumn
              Caption = 'Velja od'
              DataBinding.FieldName = 'VELJA_OD'
            end
            object tvCaDeVELJA_DO: TcxGridDBColumn
              Caption = 'Velja do'
              DataBinding.FieldName = 'VELJA_DO'
            end
            object tvCaDeCUSER: TcxGridDBColumn
              DataBinding.FieldName = 'CUSER'
              Visible = False
            end
            object tvCaDeCREATED: TcxGridDBColumn
              DataBinding.FieldName = 'CREATED'
              Visible = False
            end
            object tvCaDeLUSER: TcxGridDBColumn
              DataBinding.FieldName = 'LUSER'
              Visible = False
            end
            object tvCaDeLCHANGE: TcxGridDBColumn
              DataBinding.FieldName = 'LCHANGE'
              Visible = False
            end
          end
          object leCaDe: TcxGridLevel
            GridView = tvCaDe
          end
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 386
        Width = 873
        Height = 200
        Align = alBottom
        Caption = 'Panel5'
        TabOrder = 1
        object Panel10: TPanel
          Left = 1
          Top = 1
          Width = 871
          Height = 27
          Align = alTop
          Alignment = taLeftJustify
          Caption = 'Razporeditve v izmene'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object grCaSh: TcxGrid
          Left = 1
          Top = 28
          Width = 871
          Height = 171
          Align = alClient
          TabOrder = 1
          object tvCaSh: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            DataController.DataSource = dsCaSh
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.FocusFirstCellOnNewRecord = True
            OptionsBehavior.ImmediateEditor = False
            OptionsBehavior.FocusCellOnCycle = True
            OptionsCustomize.ColumnGrouping = False
            OptionsView.Navigator = True
            OptionsView.GroupByBox = False
            object tvCaShSHIFT_DESCRIPTION: TcxGridDBColumn
              Caption = 'Izmena'
              DataBinding.FieldName = 'SHIFT_DESCRIPTION'
              Width = 242
            end
            object tvCaShSTATUS: TcxGridDBColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STATUS'
              Width = 99
            end
            object tvCaShVELJA_OD: TcxGridDBColumn
              Caption = 'Velja od'
              DataBinding.FieldName = 'VELJA_OD'
            end
            object tvCaShVELJA_DO: TcxGridDBColumn
              Caption = 'Velja do'
              DataBinding.FieldName = 'VELJA_DO'
            end
          end
          object leCaSh: TcxGridLevel
            GridView = tvCaSh
          end
        end
      end
      object cxSplitter2: TcxSplitter
        Left = 0
        Top = 381
        Width = 873
        Height = 5
        AlignSplitter = salBottom
        Control = Panel5
        Color = clBackground
        ParentColor = False
      end
    end
    object tsAdmins: TcxTabSheet
      Caption = 'Administratorji'
      ImageIndex = 35
      object Panel14: TPanel
        Left = 0
        Top = 0
        Width = 873
        Height = 121
        Align = alTop
        TabOrder = 0
        object Label29: TLabel
          Left = 32
          Top = 9
          Width = 80
          Height = 13
          Caption = 'Nadrejeni - vodja'
          FocusControl = edNadrejeniMNR
        end
        object Label30: TLabel
          Left = 32
          Top = 49
          Width = 131
          Height = 13
          Caption = 'Nadrejeni - namestnik vodje'
          FocusControl = edNadrejeni2MNR
        end
        object Label31: TLabel
          Left = 400
          Top = 9
          Width = 36
          Height = 13
          Caption = 'Skrbnik'
          FocusControl = edSkrbnikMNR
        end
        object Label32: TLabel
          Left = 400
          Top = 49
          Width = 93
          Height = 13
          Caption = 'Skrbnik - namestnik'
          FocusControl = edSkrbnik2MNR
        end
        object edNadrejeniMNR: TDBEdit
          Left = 32
          Top = 25
          Width = 65
          Height = 21
          DataField = 'MNR_NADREJENI'
          DataSource = dsRisCard
          TabOrder = 0
        end
        object edNadrejeni2MNR: TDBEdit
          Left = 32
          Top = 65
          Width = 65
          Height = 21
          DataField = 'MNR_NADREJENI2'
          DataSource = dsRisCard
          TabOrder = 1
        end
        object edSkrbnikMNR: TDBEdit
          Left = 400
          Top = 24
          Width = 65
          Height = 21
          DataField = 'MNR_SKRBNIK'
          DataSource = dsRisCard
          TabOrder = 2
        end
        object edSkrbnik2MNR: TDBEdit
          Left = 400
          Top = 65
          Width = 65
          Height = 21
          DataField = 'MNR_SKRBNIK2'
          DataSource = dsRisCard
          TabOrder = 3
        end
        object cbNadrejeni: TRxDBLookupCombo
          Left = 99
          Top = 25
          Width = 273
          Height = 21
          DropDownCount = 8
          DataField = 'MNR_NADREJENI'
          DataSource = dsRisCard
          LookupField = 'MNR'
          LookupDisplay = 'PRIIMEKIME'
          LookupSource = dsLOVRisUCard
          TabOrder = 4
        end
        object cbNadrejeni2: TRxDBLookupCombo
          Left = 99
          Top = 65
          Width = 273
          Height = 21
          DropDownCount = 8
          DataField = 'MNR_NADREJENI2'
          DataSource = dsRisCard
          LookupField = 'MNR'
          LookupDisplay = 'PRIIMEKIME'
          LookupSource = dsLOVRisUCard
          TabOrder = 5
        end
        object cbSkrbnik: TRxDBLookupCombo
          Left = 467
          Top = 25
          Width = 273
          Height = 21
          DropDownCount = 8
          DataField = 'MNR_SKRBNIK'
          DataSource = dsRisCard
          LookupField = 'MNR'
          LookupDisplay = 'PRIIMEKIME'
          LookupSource = dsLOVRisUCard
          TabOrder = 6
        end
        object cbSkrbnik2: TRxDBLookupCombo
          Left = 467
          Top = 65
          Width = 273
          Height = 21
          DropDownCount = 8
          DataField = 'MNR_SKRBNIK2'
          DataSource = dsRisCard
          LookupField = 'MNR'
          LookupDisplay = 'PRIIMEKIME'
          LookupSource = dsLOVRisUCard
          TabOrder = 7
        end
      end
      object grRisUsRc: TcxGrid
        Left = 0
        Top = 121
        Width = 873
        Height = 465
        Align = alClient
        TabOrder = 1
        object viRisUsRc: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = dsRisUsRc
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.FocusFirstCellOnNewRecord = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsBehavior.FocusCellOnCycle = True
          OptionsView.Navigator = True
          object viRisUsRcMNR: TcxGridDBColumn
            DataBinding.FieldName = 'MNR'
            Visible = False
          end
          object viRisUsRcADMIN: TcxGridDBColumn
            Caption = 'Uporabnik'
            DataBinding.FieldName = 'ADMIN'
            SortIndex = 0
            SortOrder = soAscending
            Width = 334
          end
          object viRisUsRcCH_ALLOWED: TcxGridDBColumn
            DataBinding.FieldName = 'CH_ALLOWED'
            Width = 162
          end
        end
        object leRisUsRc: TcxGridLevel
          GridView = viRisUsRc
        end
      end
    end
    object tsStanja: TcxTabSheet
      Caption = 'Za'#269'etna stanja'
      ImageIndex = 33
      TabVisible = False
    end
    object tsEDC: TcxTabSheet
      Caption = 'Registracija delovnega '#269'asa'
      ImageIndex = 23
      TabVisible = False
      object Panel13: TPanel
        Left = 0
        Top = 0
        Width = 875
        Height = 73
        Align = alTop
        TabOrder = 0
        object Label5: TLabel
          Left = 16
          Top = 16
          Width = 135
          Height = 13
          Caption = 'Okraj'#353'ano ime (prikaz za CE)'
        end
        object cxDBTextEdit1: TcxDBTextEdit
          Left = 16
          Top = 32
          DataBinding.DataField = 'RNAME'
          DataBinding.DataSource = dsRisCard
          TabOrder = 0
          Width = 185
        end
      end
    end
    object tsPK: TcxTabSheet
      Caption = 'Pristopna kontrola'
      ImageIndex = 30
      TabVisible = False
    end
    object tsMalica: TcxTabSheet
      Caption = 'Boni, malice'
      ImageIndex = 32
      TabVisible = False
      object Label22: TLabel
        Left = 56
        Top = 40
        Width = 23
        Height = 13
        Caption = 'BON'
        FocusControl = DBEdit16
      end
      object Label23: TLabel
        Left = 136
        Top = 40
        Width = 75
        Height = 13
        Caption = 'BONDODATEK'
        FocusControl = DBEdit17
      end
      object DBEdit16: TDBEdit
        Left = 56
        Top = 56
        Width = 43
        Height = 21
        DataField = 'BONAKT'
        DataSource = dsRisCard
        TabOrder = 0
      end
      object DBEdit17: TDBEdit
        Left = 136
        Top = 56
        Width = 43
        Height = 21
        DataField = 'BONDODATEK'
        DataSource = dsRisCard
        TabOrder = 1
      end
    end
  end
  object dsRisUCard: TDataSource
    DataSet = dmOracle.quRisUCard
    Left = 528
    Top = 8
  end
  object taRisCard: TOracleDataSet
    SQL.Strings = (
      'select '
      '  t.ROWID,'
      '  t.*'
      'from '
      '  ta_ris_card t'
      'where'
      '  t.mnr = :MNR')
    Variables.Data = {
      0300000001000000040000003A4D4E5203000000040000000100000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000024000000030000004D4E5201000000000005000000524E414D450100
      0000000007000000434152445F4E4F01000000000003000000414B5401000000
      0000060000005455524E5553010000000000050000004C4E414D450100000000
      0006000000444550415254010000000000040000004F52473101000000000004
      0000004F52473201000000000008000000484F4D455F54454C01000000000004
      0000004F5247330100000000000600000046454D414C45010000000000050000
      00464E414D450100000000000500000042444154450100000000000400000045
      4D534F01000000000006000000444156434E4101000000000007000000494E5F
      44415445010000000000080000004F55545F4441544501000000000008000000
      454D504C4F594544010000000000090000004C4544495459594D4D0100000000
      0008000000574F524B5F54454C01000000000009000000484F4D455F41444452
      010000000000070000004C4348414E4745010000000000050000004C55534552
      01000000000005000000454D41494C0100000000000A0000004841535F53414C
      41525901000000000006000000424F4E414B540100000000000A000000424F4E
      444F444154454B01000000000007000000424F4E534F52540100000000000800
      000053554247524F55500100000000000D0000004D4E525F4E414452454A454E
      490100000000000E0000004D4E525F4E414452454A454E493201000000000009
      000000574F524B5F4C4F434101000000000009000000574F524B5F4144445201
      00000000000B0000004D4E525F534B52424E494B0100000000000C0000004D4E
      525F534B52424E494B32010000000000}
    Master = dmOracle.quRisUCard
    MasterFields = 'MNR'
    CommitOnPost = False
    Session = dmOracle.oraSession
    Left = 576
    Top = 8
    object taRisCardMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object taRisCardRNAME: TStringField
      FieldName = 'RNAME'
    end
    object taRisCardCARD_NO: TFloatField
      FieldName = 'CARD_NO'
    end
    object taRisCardAKT: TIntegerField
      FieldName = 'AKT'
    end
    object taRisCardTURNUS: TStringField
      FieldName = 'TURNUS'
      Size = 3
    end
    object taRisCardLNAME: TStringField
      FieldName = 'LNAME'
    end
    object taRisCardDEPART: TStringField
      FieldName = 'DEPART'
      Size = 10
    end
    object taRisCardORG1: TIntegerField
      FieldName = 'ORG1'
    end
    object taRisCardORG2: TIntegerField
      FieldName = 'ORG2'
    end
    object taRisCardHOME_TEL: TStringField
      FieldName = 'HOME_TEL'
      Size = 40
    end
    object taRisCardORG3: TIntegerField
      FieldName = 'ORG3'
    end
    object taRisCardFEMALE: TStringField
      FieldName = 'FEMALE'
      Size = 1
    end
    object taRisCardFNAME: TStringField
      FieldName = 'FNAME'
    end
    object taRisCardBDATE: TDateTimeField
      FieldName = 'BDATE'
    end
    object taRisCardEMSO: TStringField
      FieldName = 'EMSO'
      Size = 13
    end
    object taRisCardDAVCNA: TFloatField
      FieldName = 'DAVCNA'
    end
    object taRisCardIN_DATE: TDateTimeField
      FieldName = 'IN_DATE'
      Required = True
    end
    object taRisCardOUT_DATE: TDateTimeField
      FieldName = 'OUT_DATE'
    end
    object taRisCardEMPLOYED: TStringField
      FieldName = 'EMPLOYED'
      Required = True
      Size = 10
    end
    object taRisCardLEDITYYMM: TDateTimeField
      FieldName = 'LEDITYYMM'
    end
    object taRisCardWORK_TEL: TStringField
      FieldName = 'WORK_TEL'
      Size = 15
    end
    object taRisCardHOME_ADDR: TStringField
      FieldName = 'HOME_ADDR'
      Size = 40
    end
    object taRisCardLCHANGE: TDateTimeField
      FieldName = 'LCHANGE'
    end
    object taRisCardLUSER: TStringField
      FieldName = 'LUSER'
      Size = 30
    end
    object taRisCardEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 40
    end
    object taRisCardHAS_SALARY: TStringField
      FieldName = 'HAS_SALARY'
      Size = 3
    end
    object taRisCardBONAKT: TStringField
      FieldName = 'BONAKT'
      Size = 3
    end
    object taRisCardBONDODATEK: TStringField
      FieldName = 'BONDODATEK'
      Size = 3
    end
    object taRisCardBONSORT: TIntegerField
      FieldName = 'BONSORT'
    end
    object taRisCardSUBGROUP: TIntegerField
      FieldName = 'SUBGROUP'
    end
    object taRisCardMNR_NADREJENI: TIntegerField
      FieldName = 'MNR_NADREJENI'
    end
    object taRisCardMNR_NADREJENI2: TIntegerField
      FieldName = 'MNR_NADREJENI2'
    end
    object taRisCardWORK_LOCA: TStringField
      FieldName = 'WORK_LOCA'
      Size = 10
    end
    object taRisCardWORK_ADDR: TStringField
      FieldName = 'WORK_ADDR'
      Size = 40
    end
    object taRisCardMNR_SKRBNIK: TIntegerField
      FieldName = 'MNR_SKRBNIK'
    end
    object taRisCardMNR_SKRBNIK2: TIntegerField
      FieldName = 'MNR_SKRBNIK2'
    end
  end
  object dsRisCard: TDataSource
    DataSet = taRisCard
    OnStateChange = dsRisCardStateChange
    OnDataChange = dsRisCardDataChange
    Left = 576
    Top = 40
  end
  object taArmCaDm: TOracleDataSet
    SQL.Strings = (
      'select'
      '  rowid,'
      '  id,'
      '  mnr,'
      '  dem_id,'
      '  status,'
      '  velja_od,'
      '  velja_do,'
      '   cuser,'
      '   created,'
      '   luser,'
      '   lchange'
      'from '
      '  ta_arm_cadm'
      'where mnr = :mnr'
      'order by status asc, velja_od desc')
    Variables.Data = {0300000001000000040000003A4D4E52030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000A000000020000004944010000000000030000004D4E520100000000
      000600000044454D5F4944010000000000060000005354415455530100000000
      000800000056454C4A415F4F440100000000000800000056454C4A415F444F01
      0000000000050000004355534552010000000000070000004352454154454401
      0000000000050000004C55534552010000000000070000004C4348414E474501
      0000000000}
    Master = taRisCard
    MasterFields = 'MNR'
    DetailFields = 'MNR'
    Session = dmOracle.oraSession
    AfterInsert = taArmCaDmAfterInsert
    Left = 616
    Top = 8
    object taArmCaDmID: TFloatField
      FieldName = 'ID'
    end
    object taArmCaDmMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object taArmCaDmDEM_ID: TFloatField
      FieldName = 'DEM_ID'
      Required = True
    end
    object taArmCaDmDEM_NAZIV: TStringField
      FieldKind = fkLookup
      FieldName = 'DEM_NAZIV'
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
      ReadOnly = True
      Size = 30
    end
    object taArmCaDmCREATED: TDateTimeField
      FieldName = 'CREATED'
      ReadOnly = True
    end
    object taArmCaDmLUSER: TStringField
      FieldName = 'LUSER'
      ReadOnly = True
      Size = 30
    end
    object taArmCaDmLCHANGE: TDateTimeField
      FieldName = 'LCHANGE'
      ReadOnly = True
    end
  end
  object dsArmCaDm: TDataSource
    DataSet = taArmCaDm
    Left = 616
    Top = 40
  end
  object dsArmDeme: TDataSource
    DataSet = dmOracle.quArmDeme
    Left = 744
    Top = 240
  end
  object taArmCaDe: TOracleDataSet
    SQL.Strings = (
      'select'
      '  rowid,'
      '  id,'
      '  mnr,'
      '  depart_id,'
      '  status,'
      '  velja_od,'
      '  velja_do,'
      '   cuser,'
      '   created,'
      '   luser,'
      '   lchange'
      'from '
      '  ta_arm_cade'
      'where mnr = :mnr'
      'order by status asc, velja_od desc')
    Variables.Data = {0300000001000000040000003A4D4E52030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000A000000020000004944010000000000030000004D4E520100000000
      00060000005354415455530100000000000800000056454C4A415F4F44010000
      0000000800000056454C4A415F444F0100000000000500000043555345520100
      000000000700000043524541544544010000000000050000004C555345520100
      00000000070000004C4348414E4745010000000000090000004445504152545F
      4944010000000000}
    Master = taRisCard
    MasterFields = 'MNR'
    DetailFields = 'MNR'
    Session = dmOracle.oraSession
    AfterInsert = taArmCaDeAfterInsert
    Left = 648
    Top = 8
    object taArmCaDeID: TFloatField
      FieldName = 'ID'
    end
    object taArmCaDeMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object taArmCaDeDEPART_ID: TFloatField
      FieldName = 'DEPART_ID'
      Required = True
    end
    object taArmCaDeDEPART: TStringField
      FieldKind = fkLookup
      FieldName = 'DEPART'
      LookupDataSet = dmOracle.quDelovisca
      LookupKeyFields = 'DEPART_ID'
      LookupResultField = 'DEPART'
      KeyFields = 'DEPART_ID'
      Size = 30
      Lookup = True
    end
    object taArmCaDeDEPART_DESC: TStringField
      FieldKind = fkLookup
      FieldName = 'DEPART_DESC'
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
  end
  object dsArmCaDe: TDataSource
    DataSet = taArmCaDe
    Left = 648
    Top = 40
  end
  object taArmCash: TOracleDataSet
    SQL.Strings = (
      'select'
      '  rowid,'
      '  id,'
      '  mnr,'
      '  shift_id,'
      '  status,'
      '  velja_od,'
      '  velja_do,'
      '   cuser,'
      '   created,'
      '   luser,'
      '   lchange'
      'from '
      '  ta_arm_cash'
      'where mnr = :mnr'
      'order by status asc, velja_od desc')
    Variables.Data = {0300000001000000040000003A4D4E52030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      040000000A000000020000004944010000000000030000004D4E520100000000
      00060000005354415455530100000000000800000056454C4A415F4F44010000
      0000000800000056454C4A415F444F0100000000000500000043555345520100
      000000000700000043524541544544010000000000050000004C555345520100
      00000000070000004C4348414E47450100000000000800000053484946545F49
      44010000000000}
    Master = taRisCard
    MasterFields = 'MNR'
    DetailFields = 'MNR'
    Session = dmOracle.oraSession
    AfterInsert = taArmCashAfterInsert
    Left = 680
    Top = 8
    object taArmCashID: TFloatField
      FieldName = 'ID'
    end
    object taArmCashMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object taArmCashSHIFT_ID: TFloatField
      FieldName = 'SHIFT_ID'
      Required = True
    end
    object taArmCashSHIFT_DESCRIPTION: TStringField
      FieldKind = fkLookup
      FieldName = 'SHIFT_DESCRIPTION'
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
    object taArmCashVELJA_OD: TDateTimeField
      FieldName = 'VELJA_OD'
    end
    object taArmCaShVELJA_DO: TDateTimeField
      FieldName = 'VELJA_DO'
    end
    object taArmCaShCUSER: TStringField
      FieldName = 'CUSER'
      ReadOnly = True
      Size = 30
    end
    object taArmCaShCREATED: TDateTimeField
      FieldName = 'CREATED'
      ReadOnly = True
    end
    object taArmCaShLUSER: TStringField
      FieldName = 'LUSER'
      ReadOnly = True
      Size = 30
    end
    object taArmCaShLCHANGE: TDateTimeField
      FieldName = 'LCHANGE'
      ReadOnly = True
    end
  end
  object dsCaSh: TDataSource
    DataSet = taArmCash
    Left = 680
    Top = 40
  end
  object dsRisCaPic: TDataSource
    DataSet = taRisCapic
    Left = 712
    Top = 40
  end
  object taRisCapic: TOracleDataSet
    SQL.Strings = (
      'select t.rowid, t.id, t.mnr, t.ime, t.small_picture'
      'from '
      'ta_ris_capic t'
      'where mnr = :mnr')
    Variables.Data = {0300000001000000040000003A4D4E52030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000004000000020000004944010000000000030000004D4E520100000000
      0003000000494D450100000000000D000000534D414C4C5F5049435455524500
      0000000000}
    Master = taRisCard
    MasterFields = 'MNR'
    DetailFields = 'MNR'
    Session = dmOracle.oraSession
    AfterOpen = taRisCapicAfterRefresh
    AfterInsert = taRisCapicAfterInsert
    AfterRefresh = taRisCapicAfterRefresh
    Left = 712
    Top = 8
    object taRisCapicMNR: TIntegerField
      FieldName = 'MNR'
    end
    object taRisCapicIME: TStringField
      FieldName = 'IME'
      Required = True
      Size = 128
    end
    object taRisCapicSMALL_PICTURE: TBlobField
      FieldName = 'SMALL_PICTURE'
      BlobType = ftOraBlob
    end
  end
  object dsLOVRisUCard: TDataSource
    DataSet = dmOracle.quLOVRisUCard
    Left = 776
    Top = 241
  end
  object quRisCaDe: TOracleDataSet
    SQL.Strings = (
      'select'
      'ROWID,'
      'MNR,'
      'DEPART_ID'
      ''
      'from ta_ris_cade '
      ''
      'where mnr = :mnr')
    Variables.Data = {0300000001000000040000003A4D4E52030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000002000000030000004D4E52010000000000090000004445504152545F
      4944010000000000}
    Master = taRisCard
    MasterFields = 'MNR'
    DetailFields = 'MNR'
    Session = dmOracle.oraSession
    Left = 744
    Top = 9
    object quRisCaDeMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object quRisCaDeDEPART_ID: TIntegerField
      DisplayLabel = 'Int. '#353'ifra'
      FieldName = 'DEPART_ID'
      Required = True
    end
    object quRisCaDeDEPART: TStringField
      DisplayLabel = #352'ifra OE'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DEPART'
      LookupDataSet = dmOracle.quDepart
      LookupKeyFields = 'DEPART_ID'
      LookupResultField = 'DEPART'
      KeyFields = 'DEPART_ID'
      Size = 30
      Lookup = True
    end
    object quRisCaDeDEPART_DESC: TStringField
      DisplayLabel = 'Opis OE'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'DEPART_DESC'
      LookupDataSet = dmOracle.quDepart
      LookupKeyFields = 'DEPART_ID'
      LookupResultField = 'DESCRIPTION'
      KeyFields = 'DEPART_ID'
      Size = 30
      Lookup = True
    end
    object quRisCaDeTREE_DESC: TStringField
      DisplayLabel = 'Org. shema'
      DisplayWidth = 30
      FieldKind = fkLookup
      FieldName = 'TREE_DESC'
      LookupDataSet = dmOracle.quDepart
      LookupKeyFields = 'DEPART_ID'
      LookupResultField = 'TREE_DESC'
      KeyFields = 'DEPART_ID'
      Size = 30
      Lookup = True
    end
    object quRisCaDeTREE_ID: TIntegerField
      FieldKind = fkLookup
      FieldName = 'TREE_ID'
      LookupDataSet = dmOracle.quDepart
      LookupKeyFields = 'DEPART_ID'
      LookupResultField = 'TREE_ID'
      KeyFields = 'DEPART_ID'
      Lookup = True
    end
  end
  object dsDepart: TDataSource
    DataSet = quRisCaDe
    Left = 744
    Top = 41
  end
  object taRisUsrc: TOracleDataSet
    SQL.Strings = (
      'select'
      '  ROWID,'
      '  MNR,'
      '  RIS_USER,'
      '  CH_ALLOWED'
      'from '
      '  TA_RIS_USRC'
      'where mnr = :mnr'
      'order by'
      '  RIS_USER'
      '')
    Variables.Data = {0300000001000000040000003A4D4E52030000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000003000000030000004D4E52010000000000080000005249535F555345
      520100000000000A00000043485F414C4C4F574544010000000000}
    MasterFields = 'MNR'
    DetailFields = 'MNR'
    Session = dmOracle.oraSession
    Left = 704
    Top = 208
    object taRisUsrcMNR: TIntegerField
      FieldName = 'MNR'
      Required = True
    end
    object taRisUsrcADMIN: TStringField
      FieldKind = fkLookup
      FieldName = 'ADMIN'
      LookupDataSet = dmOracle.quDistinctAdmin
      LookupKeyFields = 'RIS_USER'
      LookupResultField = 'RIS_USER'
      KeyFields = 'RIS_USER'
      Size = 30
      Lookup = True
    end
    object taRisUsrcRIS_USER: TStringField
      DisplayLabel = 'Uporabnik'
      FieldName = 'RIS_USER'
      Required = True
      Size = 30
    end
    object taRisUsrcCH_ALLOWED: TStringField
      DisplayLabel = 'CC - BDS'
      FieldName = 'CH_ALLOWED'
      Size = 3
    end
  end
  object dsRisUsRc: TDataSource
    DataSet = taRisUsrc
    Left = 704
    Top = 240
  end
end
