object fmOsebaSelectDDMI: TfmOsebaSelectDDMI
  Left = 438
  Top = 230
  Width = 495
  Height = 640
  Caption = 'Izberi osebe'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 487
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 5
      Width = 145
      Height = 13
      Caption = 'Razpolo'#382'ljive osebe za DDMI: '
    end
    object laDDMI: TLabel
      Left = 8
      Top = 24
      Width = 43
      Height = 13
      Caption = 'laDDMI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 572
    Width = 487
    Height = 41
    Align = alBottom
    TabOrder = 1
    object bbOk: TBitBtn
      Left = 392
      Top = 8
      Width = 75
      Height = 25
      Caption = 'V redu'
      TabOrder = 0
      Kind = bkOK
    end
    object bbCancel: TBitBtn
      Left = 304
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Pozabi'
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 487
    Height = 531
    Align = alClient
    TabOrder = 2
    object lbOsebe1: TcxMCListBox
      Left = 1
      Top = 1
      Width = 485
      Height = 529
      Align = alClient
      HeaderSections = <
        item
          AllowClick = True
          SortOrder = soAscending
          Text = 'MNR'
          Width = 56
        end
        item
          AllowClick = True
          MinWidth = 150
          SortOrder = soAscending
          Text = 'Priimek'
          Width = 150
        end
        item
          AllowClick = True
          MinWidth = 150
          SortOrder = soAscending
          Text = 'Ime'
          Width = 150
        end
        item
          AllowClick = True
          Text = 'Ure'
        end
        item
          AllowClick = True
          Text = 'Ned-Pra'
        end>
      MultiSelect = True
      TabOrder = 0
      OnDblClick = lbOsebe1DblClick
    end
  end
end
