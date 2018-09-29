object fmSettings: TfmSettings
  Left = 410
  Top = 273
  Width = 686
  Height = 497
  Caption = 'Nastavitve'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 422
    Width = 678
    Height = 48
    Align = alBottom
    TabOrder = 0
    object Panel3: TPanel
      Left = 496
      Top = 1
      Width = 181
      Height = 46
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object bbSave: TBitBtn
        Left = 14
        Top = 9
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
        Left = 94
        Top = 9
        Width = 75
        Height = 25
        Caption = 'Pozabi'
        TabOrder = 1
        OnClick = bbCancelClick
        Kind = bkCancel
      end
    end
  end
  object tsShowMode: TcxPageControl
    Left = 0
    Top = 0
    Width = 678
    Height = 422
    ActivePage = tsColumns
    Align = alClient
    LookAndFeel.Kind = lfStandard
    TabOrder = 1
    ClientRectBottom = 420
    ClientRectLeft = 2
    ClientRectRight = 676
    ClientRectTop = 22
    object tsColumns: TcxTabSheet
      Caption = 'Vidni stolpci'
      ImageIndex = 0
      object gbColOsebe: TGroupBox
        Left = 16
        Top = 15
        Width = 193
        Height = 242
        Caption = 'Vidni stolpci - osebe'
        TabOrder = 0
        object cbMNR: TCheckBox
          Left = 24
          Top = 25
          Width = 152
          Height = 17
          Caption = 'Mati'#269'na '#353'tevilka'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object cbOseba: TCheckBox
          Left = 24
          Top = 47
          Width = 148
          Height = 17
          Caption = 'Priimek in ime'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object cbIDCard: TCheckBox
          Left = 24
          Top = 69
          Width = 153
          Height = 17
          Caption = #352'tevilka ID kartice'
          TabOrder = 2
        end
        object cbAkt: TCheckBox
          Left = 24
          Top = 92
          Width = 153
          Height = 17
          Caption = 'Oznaka aktivnosti'
          TabOrder = 3
        end
        object cbEmployed: TCheckBox
          Left = 24
          Top = 114
          Width = 148
          Height = 17
          Caption = 'Oznaka zaposlitve'
          TabOrder = 4
        end
        object cbOE: TCheckBox
          Left = 24
          Top = 137
          Width = 129
          Height = 17
          Caption = 'Organizacijska enota'
          TabOrder = 5
        end
        object cbORG1: TCheckBox
          Left = 25
          Top = 161
          Width = 129
          Height = 17
          Caption = 'Skupina'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
      end
      object gbColCriteria: TGroupBox
        Left = 224
        Top = 16
        Width = 193
        Height = 241
        Caption = 'Vidni stolpci - kriteriji'
        TabOrder = 1
        object cbUreIn: TCheckBox
          Left = 16
          Top = 26
          Width = 153
          Height = 17
          Caption = 'URE - za'#269'etna vsota'
          TabOrder = 0
        end
        object cbUre: TCheckBox
          Left = 16
          Top = 48
          Width = 153
          Height = 17
          Caption = 'URE - vsota razporeda'
          TabOrder = 1
        end
        object cbUreOut: TCheckBox
          Left = 16
          Top = 70
          Width = 153
          Height = 17
          Caption = 'URE - kon'#269'na vsota'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object cbNepIn: TCheckBox
          Left = 16
          Top = 92
          Width = 153
          Height = 17
          Caption = 'NEP - za'#269'etno '#353'tevilo'
          TabOrder = 3
        end
        object cbNep: TCheckBox
          Left = 16
          Top = 115
          Width = 153
          Height = 17
          Caption = 'NEP - '#353'tevilo'
          TabOrder = 4
        end
        object cbNepOut: TCheckBox
          Left = 16
          Top = 137
          Width = 153
          Height = 17
          Caption = 'NEP - kon'#269'no '#353'tevilo'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object cbNocIn: TCheckBox
          Left = 16
          Top = 159
          Width = 153
          Height = 17
          Caption = 'NO'#268' - za'#269'etno '#353'tevilo'
          TabOrder = 6
        end
        object cbNoc: TCheckBox
          Left = 16
          Top = 181
          Width = 153
          Height = 17
          Caption = 'NO'#268' - '#353'tevilo'
          TabOrder = 7
        end
        object cbNocOut: TCheckBox
          Left = 16
          Top = 204
          Width = 153
          Height = 17
          Caption = 'NO'#268' - kon'#269'no '#353'tevilo'
          Checked = True
          State = cbChecked
          TabOrder = 8
        end
      end
      object gbColCalendar: TGroupBox
        Left = 432
        Top = 16
        Width = 185
        Height = 240
        Caption = 'Vidni stolpci - koledar'
        TabOrder = 2
        object cbDelovniki: TCheckBox
          Left = 24
          Top = 25
          Width = 129
          Height = 17
          Caption = 'Delovniki'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object cbSobote: TCheckBox
          Left = 24
          Top = 48
          Width = 129
          Height = 17
          Caption = 'Sobote'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object cbNedelje: TCheckBox
          Left = 24
          Top = 71
          Width = 129
          Height = 17
          Caption = 'Nedelje'
          Checked = True
          State = cbChecked
          TabOrder = 2
        end
        object cbPrazniki: TCheckBox
          Left = 24
          Top = 94
          Width = 129
          Height = 17
          Caption = 'Prazniki'
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
      end
    end
    object cxTabSheet1: TcxTabSheet
      Caption = 'Na'#269'in prikaza'
      ImageIndex = 1
      object rgShowMode: TRadioGroup
        Left = 24
        Top = 32
        Width = 249
        Height = 281
        Caption = 'Vsebina razporeditvene oznake'
        ItemIndex = 0
        Items.Strings = (
          'Delovi'#353#269'e'
          'DM'
          'Izmena'
          'Delovi'#353#269'e + DM'
          'Delovi'#353#269'e + Izmena'
          'DM + Delovi'#353#269'e'
          'DM + Izmena'
          'Izmena + Delovi'#353#269'e'
          'Izmena + DM'
          'DM + Delovi'#353#269'e + Izmena'
          'Urni prikaz')
        TabOrder = 0
      end
      object rgOdsotSource: TRadioGroup
        Left = 296
        Top = 33
        Width = 185
        Height = 105
        Caption = 'Vir za prikaz odsotnosti'
        ItemIndex = 1
        Items.Strings = (
          'Planiranje odsotnosti'
          'Urna lista')
        TabOrder = 1
      end
    end
    object tsColor: TcxTabSheet
      Caption = 'Barve in fonti'
      ImageIndex = 2
    end
  end
end
