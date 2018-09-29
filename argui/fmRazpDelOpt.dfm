object fmRazpDeleteOpt: TfmRazpDeleteOpt
  Left = 567
  Top = 290
  BorderStyle = bsDialog
  Caption = 'Na'#269'in brisanja delovnih razporedov'
  ClientHeight = 308
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 316
    Height = 267
    Align = alClient
    TabOrder = 0
    object gbTurnus: TGroupBox
      Left = 16
      Top = 8
      Width = 281
      Height = 241
      Caption = 'Izberi na'#269'in brisanja'
      TabOrder = 0
      object rbDelAll: TRadioButton
        Left = 8
        Top = 24
        Width = 193
        Height = 17
        Caption = 'Bri'#353'i vse delovne razporede'
        TabOrder = 0
        OnClick = rbDelAllClick
      end
      object rbDelTur: TRadioButton
        Left = 8
        Top = 48
        Width = 153
        Height = 17
        Caption = 'Upo'#353'tevaj izmeno in koledar'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = rbDelTurClick
      end
      object cbIzmena1: TCheckBox
        Left = 29
        Top = 73
        Width = 161
        Height = 17
        Caption = 'Dopoldanska izmena'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object cbIzmena2: TCheckBox
        Left = 29
        Top = 92
        Width = 161
        Height = 17
        Caption = 'Popoldanska izmena'
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object cbIzmena3: TCheckBox
        Left = 29
        Top = 110
        Width = 161
        Height = 17
        Caption = 'No'#269'na izmena'
        TabOrder = 4
      end
      object cbPrazniki: TCheckBox
        Left = 29
        Top = 194
        Width = 97
        Height = 17
        Caption = 'Prazniki'
        TabOrder = 5
      end
      object cbDelovniki: TCheckBox
        Left = 30
        Top = 145
        Width = 97
        Height = 17
        Caption = 'Delovniki'
        Checked = True
        State = cbChecked
        TabOrder = 6
      end
      object cbSobote: TCheckBox
        Left = 30
        Top = 161
        Width = 97
        Height = 17
        Caption = 'Sobote'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
      object cbNedelje: TCheckBox
        Left = 30
        Top = 177
        Width = 97
        Height = 17
        Caption = 'Nedelje'
        TabOrder = 8
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 267
    Width = 316
    Height = 41
    Align = alBottom
    TabOrder = 1
    object bbOk: TBitBtn
      Left = 144
      Top = 8
      Width = 75
      Height = 25
      Caption = 'V redu'
      TabOrder = 0
      Kind = bkOK
    end
    object bbCancel: TBitBtn
      Left = 56
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Pozabi'
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
