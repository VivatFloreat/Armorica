object fmPass: TfmPass
  Left = 439
  Top = 305
  Width = 285
  Height = 200
  Caption = 'Spremeni geslo'
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
    Width = 277
    Height = 132
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 32
      Width = 56
      Height = 13
      Caption = 'Staro geslo:'
    end
    object Label2: TLabel
      Left = 48
      Top = 64
      Width = 57
      Height = 13
      Caption = 'Novo geslo:'
    end
    object Label3: TLabel
      Left = 48
      Top = 96
      Width = 36
      Height = 13
      Caption = 'Preveri:'
    end
    object edOld: TEdit
      Left = 116
      Top = 27
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 0
    end
    object edNew: TEdit
      Left = 116
      Top = 59
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object edCheck: TEdit
      Left = 116
      Top = 91
      Width = 121
      Height = 21
      PasswordChar = '*'
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 132
    Width = 277
    Height = 41
    Align = alBottom
    TabOrder = 1
    object bbOk: TBitBtn
      Left = 60
      Top = 8
      Width = 76
      Height = 25
      Caption = 'Potrdi'
      Default = True
      TabOrder = 0
      OnClick = bbOkClick
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
    object BitBtn1: TBitBtn
      Left = 156
      Top = 8
      Width = 76
      Height = 25
      Caption = 'Opusti'
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object spSpremeniGeslo: TOracleQuery
    SQL.Strings = (
      'begin'
      #9'sp_p_spremeni_geslo(:P_USER, :P_PASSWORD);'
      'end;')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000002000000070000003A505F555345520500000000000000000000000B
      0000003A505F50415353574F5244050000000000000000000000}
    Left = 16
    Top = 8
  end
end
