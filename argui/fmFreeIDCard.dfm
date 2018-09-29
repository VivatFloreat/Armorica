object fmSelFreeIDCard: TfmSelFreeIDCard
  Left = 631
  Top = 256
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Izberi prosto ID kartico'
  ClientHeight = 463
  ClientWidth = 232
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 232
    Height = 422
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object grCards: TDBGrid
      Left = 1
      Top = 1
      Width = 230
      Height = 420
      Align = alClient
      DataSource = dmOracle.dsIDCardFree
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = grCardsDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'CARD_NO'
          Title.Alignment = taRightJustify
          Title.Caption = #352't. kartice'
          Width = 133
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 422
    Width = 232
    Height = 41
    Align = alBottom
    TabOrder = 1
    object bbOk: TBitBtn
      Left = 32
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Izberi'
      TabOrder = 0
      Kind = bkOK
    end
    object BitBtn1: TBitBtn
      Left = 128
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Pozabi'
      TabOrder = 1
      Kind = bkCancel
    end
  end
end
