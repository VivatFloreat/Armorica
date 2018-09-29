object fmSolverOpt: TfmSolverOpt
  Left = 338
  Top = 178
  Width = 925
  Height = 610
  Caption = 'Opcije razre'#353'evalca'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 361
    Height = 542
    Align = alLeft
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 19
      Top = 132
      Width = 321
      Height = 105
      Caption = 'Zakonske omejitve'
      TabOrder = 0
      object rbCritStrict: TRadioButton
        Left = 8
        Top = 56
        Width = 249
        Height = 17
        Caption = 'Striktno upo'#353'tevaj zakonske omejitve'
        TabOrder = 0
      end
      object rbCritAllow: TRadioButton
        Left = 8
        Top = 80
        Width = 249
        Height = 17
        Caption = 'Dovoli kr'#353'enje zakonskih omejitev'
        TabOrder = 1
      end
      object rbCritAuto: TRadioButton
        Left = 8
        Top = 32
        Width = 225
        Height = 17
        Caption = 'Samodejno prilagajaj zakonske omejitve'
        Checked = True
        TabOrder = 2
        TabStop = True
      end
    end
    object gbDebug: TGroupBox
      Left = 18
      Top = 250
      Width = 321
      Height = 135
      Caption = 'Sled izvajanja'
      TabOrder = 1
      object edDir: TDirectoryEdit
        Left = 19
        Top = 97
        Width = 275
        Height = 21
        InitialDir = 'C:\projects\delphi\ris4win\armorica\arsolv'
        Enabled = False
        NumGlyphs = 1
        TabOrder = 0
        Text = 'C:\projects\delphi\ris4win\armorica\arsolv'
      end
      object rbDebugNone: TRadioButton
        Left = 16
        Top = 24
        Width = 113
        Height = 17
        Caption = 'Brez sledenja'
        TabOrder = 1
        OnClick = rbDebugNoneClick
      end
      object rbDebugNormal: TRadioButton
        Left = 17
        Top = 46
        Width = 113
        Height = 17
        Caption = 'Zgo'#353#269'eno'
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = rbDebugNoneClick
      end
      object rbDebugFull: TRadioButton
        Left = 18
        Top = 67
        Width = 113
        Height = 17
        Caption = 'Ob'#353'irno'
        TabOrder = 3
        OnClick = rbDebugNoneClick
      end
    end
    object rgScope: TRadioGroup
      Left = 24
      Top = 16
      Width = 313
      Height = 105
      Caption = 'Na'#269'in razre'#353'evanja'
      ItemIndex = 0
      Items.Strings = (
        'Celoten razpored'
        'Nedeljski in prazni'#269'ni razpored'
        'Iz seznama DDMI')
      TabOrder = 2
      OnClick = rgScopeClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 542
    Width = 917
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
  object Panel3: TPanel
    Left = 365
    Top = 0
    Width = 552
    Height = 542
    Align = alClient
    TabOrder = 2
    Visible = False
    object lbDDMIs: TcxMCListBox
      Left = 1
      Top = 42
      Width = 550
      Height = 499
      Align = alClient
      HeaderSections = <
        item
          Text = '#'
          Width = 30
        end
        item
          AllowClick = True
          Text = 'Turnus'
          Width = 55
        end
        item
          AllowClick = True
          SortOrder = soAscending
          Text = 'DM'
          Width = 150
        end
        item
          AllowClick = True
          Text = 'Delovi'#353#269'e'
          Width = 150
        end
        item
          AllowClick = True
          Text = 'Izmena'
          Width = 150
        end>
      MultiSelect = True
      Sorted = True
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 550
      Height = 41
      Align = alTop
      Caption = 'Seznam DDMI za razre'#353'evanje'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object RxSplitter1: TRxSplitter
    Left = 361
    Top = 0
    Width = 4
    Height = 542
    ControlFirst = Panel1
    Align = alLeft
  end
end
