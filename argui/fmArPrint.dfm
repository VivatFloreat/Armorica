object fmPrint: TfmPrint
  Left = 242
  Top = 144
  Width = 870
  Height = 640
  Caption = 'ARPRINT: Poro'#269'ilo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object paCaption: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 41
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object bbPrintPreview: TBitBtn
      Left = 8
      Top = 8
      Width = 129
      Height = 25
      Caption = 'Predogled tiskanja'
      TabOrder = 0
      OnClick = bbPrintPreviewClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555FFFFFFFFFF5555550000000000555557777777777F5555550FFFFFFFF
        0555557F5FFFF557F5555550F0000FFF0555557F77775557F5555550FFFFFFFF
        0555557F5FFFFFF7F5555550F000000F0555557F77777757F5555550FFFFFFFF
        0555557F5FFFFFF7F5555550F000000F0555557F77777757F5555550FFFFFFFF
        0555557F5FFF5557F5555550F000FFFF0555557F77755FF7F5555550FFFFF000
        0555557F5FF5777755555550F00FF0F05555557F77557F7555555550FFFFF005
        5555557FFFFF7755555555500000005555555577777775555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
    end
    object Panel1: TPanel
      Left = 768
      Top = 1
      Width = 93
      Height = 39
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object bbClose: TBitBtn
        Left = 10
        Top = 8
        Width = 75
        Height = 25
        Caption = '&Zapri'
        TabOrder = 0
        Kind = bkClose
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 41
    Width = 862
    Height = 572
    Align = alClient
    TabOrder = 1
    object wbArPrint: TWebBrowser
      Left = 1
      Top = 1
      Width = 860
      Height = 570
      Align = alClient
      TabOrder = 0
      ControlData = {
        4C000000E2580000E93A00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
