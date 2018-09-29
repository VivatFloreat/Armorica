object fmEmployee: TfmEmployee
  Left = 208
  Top = 204
  Width = 952
  Height = 633
  Caption = 'Pregled delavcev'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 944
    Height = 561
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object grRisUCard: TcxGrid
      Left = 1
      Top = 1
      Width = 942
      Height = 559
      Align = alClient
      TabOrder = 0
      object tvRisCard: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        NavigatorButtons.Insert.Enabled = False
        NavigatorButtons.Delete.Enabled = False
        NavigatorButtons.Edit.Enabled = False
        NavigatorButtons.Post.Enabled = False
        OnCellDblClick = tvRisCardCellDblClick
        DataController.DataSource = dsRisUCard
        DataController.Options = [dcoAnsiSort, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = 'Skupaj: #,##0'
            Kind = skCount
            Column = tvRisCardMNR
          end>
        DataController.Summary.SummaryGroups = <
          item
            Links = <
              item
                Column = tvRisCardORG1
              end>
            SummaryItems = <
              item
                Format = 'Skupaj: #,##0'
                Kind = skCount
                Column = tvRisCardORG1
              end
              item
                Format = 'Skupaj: #,##0'
                Kind = skCount
                Position = spFooter
                Column = tvRisCardORG1
              end>
          end>
        OptionsBehavior.FocusCellOnTab = True
        OptionsBehavior.FocusCellOnCycle = True
        OptionsSelection.CellSelect = False
        OptionsView.Navigator = True
        OptionsView.Footer = True
        object tvRisCardMNR: TcxGridDBColumn
          DataBinding.FieldName = 'MNR'
        end
        object tvRisCardLNAME: TcxGridDBColumn
          DataBinding.FieldName = 'LNAME'
        end
        object tvRisCardFNAME: TcxGridDBColumn
          DataBinding.FieldName = 'FNAME'
        end
        object tvRisCardEMPLOYED: TcxGridDBColumn
          DataBinding.FieldName = 'EMPLOYED'
          Width = 92
        end
        object tvRisCardAKT: TcxGridDBColumn
          DataBinding.FieldName = 'AKT'
        end
        object tvRisCardCARD_NO: TcxGridDBColumn
          DataBinding.FieldName = 'CARD_NO'
          Width = 77
        end
        object tvRisCardORG1: TcxGridDBColumn
          Caption = 'Skupina 1:'
          DataBinding.FieldName = 'ORG1'
          SortIndex = 0
          SortOrder = soAscending
          Width = 77
        end
        object tvRisCardORG2: TcxGridDBColumn
          DataBinding.FieldName = 'ORG2'
          Width = 75
        end
        object tvRisCardORG3: TcxGridDBColumn
          DataBinding.FieldName = 'ORG3'
          Width = 77
        end
        object tvRisCardOPISODDELKA: TcxGridDBColumn
          DataBinding.FieldName = 'OPISODDELKA'
          Visible = False
          GroupIndex = 0
        end
      end
      object lvRisCard: TcxGridLevel
        GridView = tvRisCard
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 561
    Width = 944
    Height = 45
    Align = alBottom
    TabOrder = 1
    object bbDetails: TBitBtn
      Left = 16
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Podrobnosti'
      TabOrder = 0
      OnClick = bbDetailsClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
        000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
        00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
        F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
        0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
        FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
        FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
        0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
        00333377737FFFFF773333303300000003333337337777777333}
      NumGlyphs = 2
    end
    object bbNew: TBitBtn
      Left = 136
      Top = 8
      Width = 105
      Height = 25
      Caption = 'Nov delavec'
      TabOrder = 1
      OnClick = bbNewClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333003003
        3333333333303033333333333330003333333333333300333333333333330003
        3333333333330033333333300003300333333330AA03300333333330AA033333
        33330000AA00003333330AAAAAAAA03333330AAAAAAAA03333330000AA000033
        33333330AA03333333333330AA03333333333330000333333333}
    end
  end
  object dsRisUCard: TDataSource
    DataSet = dmOracle.quRisUCard
    Left = 8
    Top = 64
  end
end
