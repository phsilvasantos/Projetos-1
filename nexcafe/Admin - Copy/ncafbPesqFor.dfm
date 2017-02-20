inherited fbPesqFor: TfbPesqFor
  Left = 300
  Top = 420
  Caption = 'Fornecedores'
  ClientHeight = 305
  ClientWidth = 457
  OldCreateOrder = True
  Position = poDesigned
  OnDestroy = FrmBasePaiDestroy
  ExplicitWidth = 473
  ExplicitHeight = 341
  PixelsPerInch = 96
  TextHeight = 13
  inherited panPri: TLMDSimplePanel
    Width = 457
    Height = 305
    ExplicitWidth = 457
    ExplicitHeight = 305
    inherited dxBarDockControl1: TdxBarDockControl
      Width = 457
      Height = 36
      ExplicitWidth = 457
      ExplicitHeight = 36
    end
    object LMDSimplePanel1: TLMDSimplePanel
      Left = 0
      Top = 36
      Width = 457
      Height = 5
      Align = alTop
      Bevel.Mode = bmCustom
      TabOrder = 0
    end
    object LMDSimplePanel2: TLMDSimplePanel
      Left = 0
      Top = 41
      Width = 457
      Height = 264
      Align = alClient
      Bevel.Mode = bmStandard
      Color = clWhite
      TabOrder = 3
      object dxBarDockControl2: TdxBarDockControl
        Left = 1
        Top = 1
        Width = 455
        Height = 30
        Align = dalTop
        BarManager = BarMgr
      end
      object Grid: TcxGrid
        Left = 1
        Top = 31
        Width = 455
        Height = 232
        Align = alClient
        BorderStyle = cxcbsNone
        TabOrder = 1
        LookAndFeel.Kind = lfFlat
        LookAndFeel.NativeStyle = False
        object TV: TcxGridDBTableView
          OnDblClick = btnOKClick
          OnKeyUp = TVKeyUp
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Visible = False
          Navigator.Visible = True
          DataController.DataModeController.GridMode = True
          DataController.DataSource = dsCli
          DataController.Filter.MaxValueListCount = 1000
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Filter.Active = True
          DataController.Filter.AutoDataSetFilter = True
          DataController.Filter.SupportedLike = False
          DataController.KeyFieldNames = 'Codigo'
          DataController.Options = [dcoCaseInsensitive, dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <
            item
              Links = <>
              SummaryItems.Separator = ', '
              SummaryItems = <
                item
                  Kind = skCount
                end>
            end>
          Filtering.ColumnPopup.MaxDropDownItemCount = 12
          OptionsBehavior.ImmediateEditor = False
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsData.Appending = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Nenhum fornecedor foi cadastrado ainda>'
          OptionsView.ColumnAutoWidth = True
          OptionsView.GroupByBox = False
          OptionsView.GroupFooters = gfVisibleWhenExpanded
          OptionsView.Header = False
          Preview.AutoHeight = False
          object TVNome: TcxGridDBColumn
            DataBinding.FieldName = 'Nome'
            PropertiesClassName = 'TcxMaskEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.MaxLength = 40
            Properties.ReadOnly = False
            FooterAlignmentHorz = taCenter
            Width = 174
          end
        end
        object GL: TcxGridLevel
          GridView = TV
        end
      end
    end
    object panMostrar: TPanel
      Left = 37
      Top = 110
      Width = 268
      Height = 29
      BevelOuter = bvNone
      TabOrder = 2
      object edBusca: TcxMaskEdit
        Left = 49
        Top = 4
        Properties.MaskKind = emkRegExpr
        Properties.MaxLength = 0
        Properties.OnChange = edBuscaPropertiesChange
        Style.LookAndFeel.Kind = lfFlat
        StyleDisabled.LookAndFeel.Kind = lfFlat
        StyleFocused.LookAndFeel.Kind = lfFlat
        StyleHot.LookAndFeel.Kind = lfFlat
        TabOrder = 0
        OnKeyUp = edBuscaKeyUp
        Width = 215
      end
      object cxLabel1: TcxLabel
        Left = 3
        Top = 5
        Caption = 'Localizar'
      end
    end
  end
  inherited BarMgr: TdxBarManager
    ImageOptions.LargeImages = dmImagens.im24
    ImageOptions.UseLargeImagesForLargeIcons = True
    Left = 72
    Top = 232
    DockControlHeights = (
      0
      0
      0
      0)
    inherited BarMgrBar1: TdxBar
      Caption = 'BarraComum'
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarControlContainerItem1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'cmOk'
        end
        item
          Visible = True
          ItemName = 'cmCancelar'
        end>
    end
    object BarMgrBar2: TdxBar [1]
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      BorderStyle = bbsNone
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 563
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'cmNovo'
        end
        item
          Visible = True
          ItemName = 'cmEditar'
        end
        item
          Visible = True
          ItemName = 'cmApagar'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    inherited cmNovo: TdxBarLargeButton
      LargeImageIndex = 6
      OnClick = cmNovoClick
      AutoGrayScale = True
      ShowCaption = True
      ImageIndex = -1
    end
    inherited cmEditar: TdxBarLargeButton
      LargeImageIndex = 2
      OnClick = cmEditarClick
      AutoGrayScale = True
      ShowCaption = True
      ImageIndex = 20
    end
    inherited cmApagar: TdxBarLargeButton
      LargeImageIndex = 7
      AutoGrayScale = True
      ShowCaption = True
      ImageIndex = 12
    end
    inherited cmAtualizar: TdxBarLargeButton
      Visible = ivNever
      PaintStyle = psCaptionGlyph
      GlyphLayout = glTop
    end
    inherited cmExportar: TdxBarLargeButton
      Visible = ivNever
      LargeImageIndex = 47
      GlyphLayout = glTop
    end
    inherited cmImprimir: TdxBarLargeButton
      Visible = ivNever
      LargeImageIndex = 7
      GlyphLayout = glTop
      SyncImageIndex = False
      ImageIndex = 22
    end
    inherited cmLayout: TdxBarLargeButton
      ImageIndex = -1
    end
    inherited cmPeriodo: TdxBarLargeButton
      ImageIndex = -1
    end
    object cmOk: TdxBarLargeButton
      Caption = '&Ok'
      Category = 0
      Hint = 'Ok'
      Visible = ivAlways
      LargeImageIndex = 5
      OnClick = btnOKClick
      AutoGrayScale = False
      GlyphLayout = glLeft
    end
    object cmCancelar: TdxBarLargeButton
      Caption = '&Cancelar'
      Category = 0
      Hint = 'Cancelar'
      Visible = ivAlways
      LargeImageIndex = 4
      OnClick = btnCancelarClick
      AutoGrayScale = False
      GlyphLayout = glLeft
    end
    object dxBarControlContainerItem1: TdxBarControlContainerItem
      Caption = 'New Item'
      Category = 0
      Hint = 'New Item'
      Visible = ivAlways
      Control = panMostrar
    end
  end
  inherited MenuGrid: TcxGridPopupMenu
    Top = 225
  end
  inherited pmLay: TdxBarPopupMenu
    Left = 392
    Top = 178
  end
  object Tab: TnxTable
    ActiveRuntime = True
    Database = Dados.db
    Timeout = 10000
    FilterOptions = [foCaseInsensitive]
    AfterOpen = TabAfterOpen
    BeforePost = TabBeforePost
    TableName = 'Cliente'
    IndexName = 'IFornecedorNome'
    Left = 40
    Top = 176
    object TabNome: TStringField
      FieldName = 'Nome'
      Size = 40
    end
    object TabEndereco: TStringField
      FieldName = 'Endereco'
      Size = 50
    end
    object TabBairro: TStringField
      FieldName = 'Bairro'
    end
    object TabCidade: TStringField
      FieldName = 'Cidade'
      Size = 30
    end
    object TabUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object TabInativo: TBooleanField
      FieldName = 'Inativo'
    end
    object TabCEP: TStringField
      FieldName = 'CEP'
      Size = 10
    end
    object TabObs: TMemoField
      FieldName = 'Obs'
      BlobType = ftMemo
    end
    object TabCpf: TStringField
      FieldName = 'Cpf'
      Size = 14
    end
    object TabRg: TStringField
      FieldName = 'Rg'
      Size = 14
    end
    object TabTelefone: TStringField
      FieldName = 'Telefone'
      Size = 15
    end
    object TabEmail: TMemoField
      FieldName = 'Email'
      BlobType = ftMemo
    end
    object TabUltVisita: TDateTimeField
      FieldName = 'UltVisita'
    end
    object TabCelular: TStringField
      FieldName = 'Celular'
      Size = 15
    end
    object TabTemDebito: TBooleanField
      FieldName = 'TemDebito'
    end
    object TabTipoAcessoPref: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'TipoAcessoPref'
    end
    object TabAlteradoEm: TDateTimeField
      FieldName = 'AlteradoEm'
    end
    object TabIncluidoPor: TStringField
      FieldName = 'IncluidoPor'
      Size = 10
    end
    object TabAlteradoPor: TStringField
      FieldName = 'AlteradoPor'
      Size = 10
    end
    object TabFornecedor: TBooleanField
      FieldName = 'Fornecedor'
    end
    object TabIncluidoEm: TDateTimeField
      FieldName = 'IncluidoEm'
    end
    object TabID: TAutoIncField
      FieldName = 'ID'
    end
  end
  object dsCli: TDataSource
    DataSet = Tab
    Left = 72
    Top = 176
  end
  object pmTempo: TdxBarPopupMenu
    BarManager = BarMgr
    ItemLinks = <>
    UseOwnFont = False
    Left = 128
    Top = 228
  end
  object pmSenha: TdxBarPopupMenu
    BarManager = BarMgr
    ItemLinks = <>
    UseOwnFont = False
    Left = 240
    Top = 224
  end
  object PopupMenu1: TPopupMenu
    Left = 544
    Top = 408
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 152
    Top = 152
  end
end