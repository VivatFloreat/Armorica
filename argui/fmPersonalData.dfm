object fmPersData: TfmPersData
  Left = 455
  Top = 165
  Width = 533
  Height = 640
  Caption = 'fmPersData'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 525
    Height = 81
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 16
      Width = 108
      Height = 13
      Caption = 'Podatki izbrane osebe:'
    end
    object edMNR: TEdit
      Left = 142
      Top = 10
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 0
    end
    object edLname: TEdit
      Left = 144
      Top = 36
      Width = 177
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object edFName: TEdit
      Left = 328
      Top = 36
      Width = 177
      Height = 21
      ReadOnly = True
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 81
    Width = 525
    Height = 491
    Align = alClient
    TabOrder = 1
    object Label2: TLabel
      Left = 16
      Top = 19
      Width = 133
      Height = 13
      Caption = 'Za'#269'etna vrednost  - saldo ur'
    end
    object Label3: TLabel
      Left = 16
      Top = 75
      Width = 144
      Height = 13
      Caption = 'Za'#269'etna vrednost  - '#353'tevilo NP'
    end
    object edStartHHMM: TcxTextEdit
      Left = 32
      Top = 40
      TabOrder = 0
      Width = 121
    end
    object edStartNP: TcxTextEdit
      Left = 32
      Top = 96
      TabOrder = 1
      Width = 121
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 572
    Width = 525
    Height = 41
    Align = alBottom
    TabOrder = 2
    object bbOk: TBitBtn
      Left = 333
      Top = 8
      Width = 75
      Height = 25
      Caption = 'V redu'
      TabOrder = 0
      OnClick = bbOkClick
      Kind = bkOK
    end
    object BitBtn1: TBitBtn
      Left = 421
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Pozabi'
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
