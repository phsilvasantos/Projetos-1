object FrmWebPopup: TFrmWebPopup
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Mensagem:'
  ClientHeight = 206
  ClientWidth = 379
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object WB: TMyBrowser
    Left = 0
    Top = 0
    Width = 379
    Height = 206
    Align = alClient
    TabOrder = 0
    OnNavigateComplete2 = WBNavigateComplete2
    OnDocumentComplete = WBDocumentComplete
    OnNavigateError = WBNavigateError
    OnGetWebApi = WBGetWebApi
    ExplicitLeft = 71
    ExplicitTop = 48
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C0000002C2700004A1500000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object TimerErro: TTimer
    Enabled = False
    Interval = 30000
    OnTimer = TimerErroTimer
    Left = 64
    Top = 48
  end
end