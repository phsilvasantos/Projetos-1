object FrmOpcoes: TFrmOpcoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderWidth = 10
  Caption = 'Op'#231#245'es'
  ClientHeight = 353
  ClientWidth = 548
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseWheel = FormMouseWheel
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object LMDSimplePanel1: TLMDSimplePanel
    AlignWithMargins = True
    Left = 0
    Top = 0
    Width = 548
    Height = 32
    Hint = ''
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 10
    Align = alTop
    Bevel.Mode = bmCustom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object btnOk: TcxButton
      Left = 0
      Top = 0
      Width = 81
      Height = 32
      Cursor = crHandPoint
      Align = alLeft
      Caption = '&Ok'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      TabOrder = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = btnOkClick
    end
    object btCancelar: TcxButton
      AlignWithMargins = True
      Left = 101
      Top = 0
      Width = 81
      Height = 32
      Cursor = crHandPoint
      Margins.Left = 20
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Cancel = True
      Caption = '&Cancelar'
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      ModalResult = 2
      TabOrder = 1
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = btCancelarClick
    end
  end
  object SB: TcxScrollBox
    Left = 0
    Top = 42
    Width = 548
    Height = 311
    Align = alClient
    Color = clWhite
    LookAndFeel.Kind = lfFlat
    LookAndFeel.NativeStyle = False
    ParentColor = False
    TabOrder = 1
    VertScrollBar.Tracking = True
  end
end