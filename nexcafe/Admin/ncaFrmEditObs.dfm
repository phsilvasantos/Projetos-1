object FrmEditObs: TFrmEditObs
  Left = 0
  Top = 0
  ActiveControl = edObs
  BorderStyle = bsToolWindow
  Caption = 'Observa'#231#245'es'
  ClientHeight = 165
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 18
  object LMDSimplePanel2: TLMDSimplePanel
    AlignWithMargins = True
    Left = 15
    Top = 116
    Width = 535
    Height = 34
    Margins.Left = 15
    Margins.Top = 0
    Margins.Right = 15
    Margins.Bottom = 15
    Align = alBottom
    Bevel.Mode = bmCustom
    TabOrder = 0
    object btnSalvar: TcxButton
      Left = 0
      Top = 0
      Width = 81
      Height = 34
      Cursor = crHandPoint
      Align = alLeft
      Caption = 'Ok'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
    end
    object btnCancelar: TcxButton
      AlignWithMargins = True
      Left = 96
      Top = 0
      Width = 74
      Height = 34
      Cursor = crHandPoint
      Margins.Left = 15
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Cancel = True
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsUnderline]
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
      LookAndFeel.Kind = lfFlat
      LookAndFeel.NativeStyle = False
      SpeedButtonOptions.CanBeFocused = False
      SpeedButtonOptions.AllowAllUp = True
      SpeedButtonOptions.Flat = True
    end
  end
  object edObs: TcxMemo
    AlignWithMargins = True
    Left = 15
    Top = 15
    Margins.Left = 15
    Margins.Top = 15
    Margins.Right = 15
    Margins.Bottom = 15
    Align = alClient
    Lines.Strings = (
      'edObs')
    ParentFont = False
    Properties.ScrollBars = ssVertical
    Properties.WantReturns = False
    Style.BorderStyle = ebsFlat
    Style.StyleController = FrmPri.cxEditStyleControllerTahoma10
    Style.TextColor = clBlue
    TabOrder = 1
    Height = 86
    Width = 535
  end
end