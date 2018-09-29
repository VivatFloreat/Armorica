object fmRazpOpt: TfmRazpOpt
  Left = 289
  Top = 295
  Width = 837
  Height = 347
  Caption = 'Razporedi delavca(e)'
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
    Width = 305
    Height = 279
    Align = alLeft
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 303
      Height = 40
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object cbDM: TCheckBox
        Left = 22
        Top = 15
        Width = 129
        Height = 17
        Caption = 'Na delovno mesto'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbDMClick
      end
    end
    object paDM: TPanel
      Left = 1
      Top = 41
      Width = 303
      Height = 237
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 24
        Top = 50
        Width = 101
        Height = 13
        Caption = 'Za'#269'etek razporeditve'
      end
      object Label3: TLabel
        Left = 24
        Top = 93
        Width = 92
        Height = 13
        Caption = 'Konec razporeditve'
      end
      object Label5: TLabel
        Left = 24
        Top = 8
        Width = 71
        Height = 13
        Caption = 'Delovno mesto'
      end
      object Label8: TLabel
        Left = 24
        Top = 144
        Width = 91
        Height = 13
        Caption = 'Status razporeditve'
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
      object cbDMOldDelete: TCheckBox
        Left = 25
        Top = 198
        Width = 145
        Height = 17
        Caption = 'Pobri'#353'i stare razporeditve'
        TabOrder = 2
      end
      object dbDM: TRxDBLookupCombo
        Left = 24
        Top = 24
        Width = 257
        Height = 21
        DropDownCount = 8
        LookupField = 'ID'
        LookupDisplay = 'NAZIV'
        LookupSource = dmOracle.dsArmDeme
        TabOrder = 3
      end
      object cbStatusDM: TComboBox
        Left = 24
        Top = 160
        Width = 145
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Primarna'
        Items.Strings = (
          'Primarna'
          'Sekundarna')
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 279
    Width = 829
    Height = 41
    Align = alBottom
    TabOrder = 1
    object Label7: TLabel
      Left = 8
      Top = 16
      Width = 87
      Height = 13
      Caption = 'Izbranih delavcev:'
      FocusControl = bbCancel
    end
    object laCount: TLabel
      Left = 104
      Top = 16
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
    object bbOK: TBitBtn
      Left = 179
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Razporedi delavce'
      Default = True
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
      Left = 313
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Opusti'
      TabOrder = 1
      Kind = bkCancel
    end
  end
  object Panel5: TPanel
    Left = 305
    Top = 0
    Width = 307
    Height = 279
    Align = alClient
    TabOrder = 2
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 305
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object cbDEL: TCheckBox
        Left = 14
        Top = 16
        Width = 129
        Height = 17
        Caption = 'Na delovi'#353#269'e'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbDELClick
      end
    end
    object paDEL: TPanel
      Left = 1
      Top = 34
      Width = 305
      Height = 244
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Label2: TLabel
        Left = 16
        Top = 60
        Width = 101
        Height = 13
        Caption = 'Za'#269'etek razporeditve'
      end
      object Label4: TLabel
        Left = 16
        Top = 99
        Width = 92
        Height = 13
        Caption = 'Konec razporeditve'
      end
      object Label6: TLabel
        Left = 16
        Top = 16
        Width = 47
        Height = 13
        Caption = 'Delovi'#353#269'e'
      end
      object Label9: TLabel
        Left = 19
        Top = 150
        Width = 91
        Height = 13
        Caption = 'Status razporeditve'
      end
      object edFromDEL: TcxDateEdit
        Left = 16
        Top = 76
        TabOrder = 0
        Width = 121
      end
      object edToDel: TcxDateEdit
        Left = 16
        Top = 115
        TabOrder = 1
        Width = 121
      end
      object cbDELOldDelete: TCheckBox
        Left = 19
        Top = 205
        Width = 145
        Height = 17
        Caption = 'Pobri'#353'i stare razporeditve'
        TabOrder = 2
      end
      object dbDEL: TRxDBLookupCombo
        Left = 16
        Top = 32
        Width = 257
        Height = 21
        DropDownCount = 8
        LookupField = 'DEPART_ID'
        LookupDisplay = 'DESCRIPTION'
        LookupSource = dmOracle.dsDelovisca
        TabOrder = 3
      end
      object cbStatusDEL: TComboBox
        Left = 18
        Top = 167
        Width = 145
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Primarna'
        Items.Strings = (
          'Primarna'
          'Sekundarna')
      end
    end
  end
  object Panel6: TPanel
    Left = 612
    Top = 0
    Width = 217
    Height = 279
    Align = alRight
    TabOrder = 3
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 215
      Height = 33
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object cbSHIF: TCheckBox
        Left = 14
        Top = 15
        Width = 129
        Height = 17
        Caption = 'V izmeno'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = cbSHIFClick
      end
    end
    object paSHIF: TPanel
      Left = 1
      Top = 34
      Width = 215
      Height = 303
      BevelOuter = bvNone
      TabOrder = 1
      object Label10: TLabel
        Left = 16
        Top = 60
        Width = 101
        Height = 13
        Caption = 'Za'#269'etek razporeditve'
      end
      object Label11: TLabel
        Left = 16
        Top = 99
        Width = 92
        Height = 13
        Caption = 'Konec razporeditve'
      end
      object Label12: TLabel
        Left = 16
        Top = 16
        Width = 34
        Height = 13
        Caption = 'Izmena'
      end
      object Label13: TLabel
        Left = 19
        Top = 150
        Width = 91
        Height = 13
        Caption = 'Status razporeditve'
      end
      object edFromSHIF: TcxDateEdit
        Left = 16
        Top = 76
        TabOrder = 0
        Width = 121
      end
      object edToSHIF: TcxDateEdit
        Left = 16
        Top = 115
        TabOrder = 1
        Width = 121
      end
      object cbSHIFOldDelete: TCheckBox
        Left = 19
        Top = 205
        Width = 145
        Height = 17
        Caption = 'Pobri'#353'i stare razporeditve'
        TabOrder = 2
      end
      object dbSHIF: TRxDBLookupCombo
        Left = 16
        Top = 32
        Width = 193
        Height = 21
        DropDownCount = 8
        LookupField = 'SHIFT_ID'
        LookupDisplay = 'description'
        LookupSource = dmOracle.dsRisShif
        TabOrder = 3
      end
      object cbStatusSHIF: TComboBox
        Left = 18
        Top = 167
        Width = 145
        Height = 21
        ItemHeight = 13
        ItemIndex = 0
        TabOrder = 4
        Text = 'Primarna'
        Items.Strings = (
          'Primarna'
          'Sekundarna')
      end
    end
  end
  object spInsRazp: TOracleQuery
    SQL.Strings = (
      'begin'
      ' sp_p_arm_mnr_razp_ins(:P_MNR,'
      '                       :P_ODDELEK,'
      '                       :P_STATUS,'
      '                       :P_FROM,'
      '                       :P_TO,'
      '                       :P_KAM,'
      '                       :P_DELETE); '
      'end;'
      '')
    Session = dmOracle.oraSession
    Variables.Data = {
      0300000007000000060000003A505F4D4E520800000000000000000000000A00
      00003A505F4F4444454C454B080000000000000000000000090000003A505F53
      5441545553050000000000000000000000070000003A505F46524F4D0C000000
      0000000000000000050000003A505F544F0C0000000000000000000000060000
      003A505F4B414D050000000000000000000000090000003A505F44454C455445
      050000000000000000000000}
    Left = 152
    Top = 17
  end
end
