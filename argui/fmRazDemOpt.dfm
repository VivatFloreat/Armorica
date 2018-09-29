object fmRazpDemOpt: TfmRazpDemOpt
  Left = 474
  Top = 397
  Width = 310
  Height = 222
  Caption = 'Dodaj delovna mesta delovi'#353#269'u'
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
    Width = 302
    Height = 154
    Align = alClient
    TabOrder = 0
    object paDM: TPanel
      Left = 1
      Top = 1
      Width = 300
      Height = 152
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 24
        Top = 50
        Width = 93
        Height = 13
        Caption = 'Za'#269'etek veljavnosti'
      end
      object Label3: TLabel
        Left = 24
        Top = 93
        Width = 84
        Height = 13
        Caption = 'Konec veljavnosti'
      end
      object Label7: TLabel
        Left = 24
        Top = 16
        Width = 108
        Height = 13
        Caption = 'Izbranih delovnih mest:'
        FocusControl = bbCancel
      end
      object laCount: TLabel
        Left = 142
        Top = 17
        Width = 8
        Height = 13
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edFromDM: TcxDateEdit
        Left = 22
        Top = 66
        Properties.DateButtons = [btnClear, btnNow, btnToday]
        Properties.DateOnError = deToday
        Properties.SaveTime = False
        Properties.ShowTime = False
        TabOrder = 0
        Width = 121
      end
      object edToDM: TcxDateEdit
        Left = 22
        Top = 109
        TabOrder = 1
        Width = 121
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 154
    Width = 302
    Height = 41
    Align = alBottom
    TabOrder = 1
    object bbOK: TBitBtn
      Left = 9
      Top = 8
      Width = 139
      Height = 25
      Caption = 'Dodaj delovna mesta'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = bbOKClick
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
      Left = 155
      Top = 8
      Width = 139
      Height = 25
      Caption = 'Opusti'
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
