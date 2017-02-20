unit ncaFrmDebito;
{
    ResourceString: Dario 11/03/13
}

interface

uses
  Windows, ncErros, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxGraphics, cxEdit, cxDropDownEdit, cxCurrencyEdit,
  cxMaskEdit, cxRadioGroup, cxCustomData, cxFilter, cxData, cxDataStorage, DB,
  kbmMemTable, dxBarExtItems, dxBar, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, cxVGrid,
  cxDBVGrid, cxInplaceContainer, LMDCustomControl, LMDCustomPanel, ncDebito,
  LMDCustomBevelPanel, LMDSimplePanel, cxCheckBox, cxContainer, cxLabel,
  cxImageComboBox, Buttons, ncClassesBase, LMDControl,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, ncEspecie, ImgList,
  cxDBExtLookupComboBox, cxCalendar, ExtCtrls, cxTextEdit, ncMyImage;

type
  TFrmDebito = class(TForm)
    panCab2: TLMDSimplePanel;
    LMDSimplePanel2: TLMDSimplePanel;
    panTot: TLMDSimplePanel;
    BarMgr: TdxBarManager;
    cmGravar: TdxBarLargeButton;
    cmCancelar: TdxBarLargeButton;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    lbNomeCli: TcxLabel;
    cxLabel2: TcxLabel;
    cmRecibo: TdxBarControlContainerItem;
    cbRecibo: TcxCheckBox;
    cxLabel3: TcxLabel;
    Grid: TcxGrid;
    TV: TcxGridTableView;
    TVPagar: TcxGridColumn;
    TVDescr: TcxGridColumn;
    TVDataHora: TcxGridColumn;
    TVTotal: TcxGridColumn;
    GL: TcxGridLevel;
    LMDSimplePanel1: TLMDSimplePanel;
    lbTotal: TcxLabel;
    lbPromptPagar: TcxLabel;
    lbNenhum: TcxLabel;
    lbTodos: TcxLabel;
    cxImageList1: TcxImageList;
    lbEditObs: TcxLabel;
    cxStyle5: TcxStyle;
    edPagar: TcxCurrencyEdit;
    TimerPagar: TTimer;
    panObs: TLMDSimplePanel;
    lbObs: TcxLabel;
    imgObs: TMyImage;
    imgsOBS: TcxImageList;
    procedure cmNenhumClick(Sender: TObject);
    procedure cmTodosClick(Sender: TObject);
    procedure TVDblClick(Sender: TObject);
    procedure cmGravarClick(Sender: TObject);
    procedure cmCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure TVPagarCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure TVTotalCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure TVKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TVMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TVMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TVMouseLeave(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lbPromptPagarClick(Sender: TObject);
    procedure TimerPagarTimer(Sender: TObject);
    procedure edPagarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edPagarPropertiesChange(Sender: TObject);
    procedure imgObsClick(Sender: TObject);
    procedure lbEditObsClick(Sender: TObject);
  private
    { Private declarations }
    FDeb : TncDebito;
    FRes : Boolean;
    FNovo : Boolean;
    FTotDeb : Currency;
    FTotSel : Currency;
    FPagar : Currency;
    FMouseRec : Integer;

    procedure LeItem(aItem: Integer);

    function EditarPagEsp: Boolean;
    procedure SetTotDeb(const Value: Currency);
    procedure SetPagar(const Value: Currency);
    procedure SetTotSel(const Value: Currency);
    function GetObs: String;
    procedure SetObs(const Value: String);

    procedure EditObs;

    property TotDeb : Currency read FTotDeb write SetTotDeb;
    property Pagar: Currency read FPagar write SetPagar;
    property TotSel : Currency read FTotSel write SetTotSel;

    property Obs: String
      read GetObs write SetObs;
  public
    function Editar(aNovo: Boolean; aDeb: TncDebito; aNomeCli: String): Boolean;
    procedure Totaliza;
    { Public declarations }
  end;

var
  FrmDebito: TFrmDebito;

implementation

uses ncaDM, ncIDRecursos, ncaFrmPri, ufmImagens, ncaFrmPagEspecie,
  ncaFrmEditObs;

// START resource string wizard section
resourcestring
  SD�bitoPago = 'D�bito Pago';
  SAcessoM�q = 'Acesso M�q: ';
  SAcesso = 'Acesso';
  SVenda = 'Venda';
  SVenda_1 = 'Venda: ';
  SImpress�o = 'Impress�o';
  STempo = 'Tempo';
  STempo_1 = 'Tempo: ';
  SDebTotal = 'Total';
  SPagar = 'Pagar';
  SPagarMaiorSel = 'Valor a pagar n�o pode ser maior que o total dos itens selecionados (%s)';
  SPagarZero = 'Informe o valor a ser pago';
  SNenhumItemSelecionado = 'Selecione os itens que deseja pagar';

// END resource string wizard section


{$R *.dfm}

{ TFrmDebito }

procedure TFrmDebito.cmCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmDebito.cmGravarClick(Sender: TObject);
var I: Integer;
begin

  if FTotSel<0.0001 then begin
    Beep;
    ShowMessage(SNenhumItemSelecionado);
    Grid.SetFocus;
    Exit;
  end;

  if FPagar>FTotSel then begin
    Beep;
    ShowMessage(Format(SPagarMaiorSel, [CurrencyToStr(FTotSel)]));
    edPagar.SetFocus;
    Exit;
  end; 

  if FPagar<0.0001 then begin
    Beep;
    ShowMessage(SPagarZero);
    edPagar.SetFocus;
    Exit;
  end;
  
  if not EditarPagEsp then Exit;
  
  FRes := True;
  Close;

  with TV.DataController do 
  for I := FDeb.Itens.Count-1 downto 0 do
    if Values[I, 0]=False then begin
      FDeb.Itens[I].Free;
      FDeb.Itens.Delete(I);
    end;

  FDeb.Recibo := cbRecibo.Checked;
  FDeb.Obs := Obs;
end;

procedure TFrmDebito.cmNenhumClick(Sender: TObject);
var I: Integer;
begin
  with TV.DataController do 
  for I := 0 to FDeb.Itens.Count - 1 do
    Values[I, 0] := False;
  TotSel := 0;
end;

procedure TFrmDebito.cmTodosClick(Sender: TObject);
var 
  I: Integer;
  T: Currency;
begin
  T := 0; 
  with TV.DataController do
  for I := 0 to FDeb.Itens.Count - 1 do begin
    Values[I, 0] := True;
    T := T + FDeb.Itens[I].idTotal;
  end;
  TotSel := T;
end;

function TFrmDebito.Editar(aNovo: Boolean; aDeb: TncDebito; aNomeCli: String): Boolean;
var I : Integer;
begin
  FDeb := aDeb;
  FRes := False;
  FNovo := aNovo;
  lbNomeCli.Caption := aNomeCli;

  with Dados.CM.Config do begin
    if (RecImprimir>0) then
      cmRecibo.Visible := ivAlways else
      cmRecibo.Visible := ivNever;

    cbRecibo.Checked := aNovo and (RecImprimir=2);  
  end;

  if not aNovo then begin
    TVTotal.Caption := SD�bitoPago;
    cmGravar.Enabled := False;
    panTot.Enabled := False;
  end;
  
  with TV.DataController do 
  for I := 0 to FDeb.Itens.Count - 1 do begin
    AppendRecord;
    Values[I, 0] := True;
    LeItem(I);
    Values[I, 3] := FDeb.Itens[I].idTotal;
  end;

  Totaliza;
  Obs := FDeb.Obs;
  ShowModal;
  Result := FRes;
end;

function TFrmDebito.EditarPagEsp: Boolean;
var 
  P : TncPagEspecies; 
  aDesc: Currency;
  aDescPerc: Double;
  aDescPorPerc : Boolean;
begin
  P := TncPagEspecies.Create;
  try
    P.Assign(FDeb.PagEsp);
    aDesc := FDeb.Desconto;
    aDescPerc := FDeb.DescPerc;
    aDescPorPerc := FDeb.DescPorPerc;
    P.Obs := Obs;
    Result := TFrmPagEspecie.Create(Self).Editar(FNovo, P, nil, FPagar, aDesc, aDescPerc, aDescPorPerc, True, False);
    if Result then begin
      FDeb.Pago := FPagar-aDesc;
      FDeb.Total := FPagar;
      FDeb.Desconto := aDesc;
      FDeb.DescPerc := aDescPerc;
      FDeb.DescPorPerc := aDescPorPerc;
      Obs := P.Obs;
      FDeb.PagEsp.Assign(P);
    end;
  finally
    P.Free;
  end
end;

procedure TFrmDebito.EditObs;
begin
  Obs := TFrmEditObs.Create(Self).Editar(Obs);
  panObs.Height := 100;
end;

procedure TFrmDebito.edPagarMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  TimerPagar.Enabled := True;
end;

function FiltraCur(S: String): String;
var I : Integer;
begin
  Result := '';
  for I := 1 to Length(S) do
    if S[I] in ['0'..'9', ',', '.'] then
      Result := Result + S[I];
end;

procedure TFrmDebito.edPagarPropertiesChange(Sender: TObject);
begin
  edPagar.PostEditValue;
  Pagar := edPagar.Value;
end;

procedure TFrmDebito.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmDebito.FormCreate(Sender: TObject);
begin
  FPagar := 0;
  FTotDeb := 0;
  FTotSel := 0;
  FMouseRec := -1;
end;

procedure TFrmDebito.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    Key_F2    : if cmGravar.Enabled then cmGravarClick(nil);
    Key_Esc   : Close;
    Key_F4    : EditObs;
  end;
end;

procedure TFrmDebito.FormShow(Sender: TObject);
begin
  Grid.SetFocus;
  if (Screen.Width=640) then
    PostMessage(Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
end;

function TFrmDebito.GetObs: String;
begin
  Result := lbObs.Caption;
end;

procedure TFrmDebito.imgObsClick(Sender: TObject);
begin
  EditObs;
end;

procedure TFrmDebito.lbEditObsClick(Sender: TObject);
begin
  EditObs;
end;

procedure TFrmDebito.lbPromptPagarClick(Sender: TObject);
begin
  edPagar.SetFocus;
end;

procedure TFrmDebito.LeItem(aItem: Integer);
begin
  with TV.DataController do
  with Dados, FDeb.Itens[aItem] do
  case idTipoItem of
    itMovEst : begin
      Values[aItem, 2] := SVenda;
      if not tbMovEst.Locate('ID', idItemID, []) then Exit; // do not localize
      Values[aItem, 1] := tbMovEstDataHora.Value;
      if not tbPro.Locate('ID', tbMovEstProduto.Value, []) then Exit; // do not localize
      Values[aItem, 2] := tbMovEstQuant.AsString + ' x ' + tbProDescricao.Value;
    end;
  end;
end;

procedure TFrmDebito.SetObs(const Value: String);
begin
  lbObs.Caption := Value;
  panObs.Visible := (lbObs.Caption>'');
  imgObs.Top := 1;
end;

procedure TFrmDebito.SetPagar(const Value: Currency);
begin
  FPagar := Value;
  if not edPagar.Focused then
    edPagar.Value := Value;

  edPagar.Width := cxTextWidth(edPagar.StyleFocused.Font, CurrencyToStr(FPagar)) + 10;
end;

procedure TFrmDebito.SetTotDeb(const Value: Currency);
begin
  FTotDeb := Value;
  lbTotal.Caption := SDebTotal + ' = ' + CurrencyToStr(FTotDeb);
end;

procedure TFrmDebito.SetTotSel(const Value: Currency);
begin
  if Value=FTotSel then Exit;
  FTotSel := Value;
  Pagar := Value;
end;

procedure TFrmDebito.TimerPagarTimer(Sender: TObject);
begin
  TimerPagar.Enabled := False;
  edPagar.SelectAll;
end;

procedure TFrmDebito.Totaliza;
var
  I: Integer;
  V: Variant; 
  T, S: Currency;
begin
  T := 0;
  S := 0;
  with TV.DataController do
  for I := 0 to RecordCount-1 do begin
    V := Values[I, 0];
    if (V<>null) and (V=True) then
      S := S + FDeb.Itens[I].idTotal;
    T := T + FDeb.Itens[I].idTotal;
  end;
  TotDeb := T;
  TotSel := S;
end;

procedure TFrmDebito.TVDblClick(Sender: TObject);
var
  V: Variant;
  I: Integer;
begin
  if not panTot.Enabled then Exit;
  
  with TV.DataController do begin
    I := FocusedRecordIndex;
    V := not Values[I, 0];
    Values[I, 0] := V;
  end;

  Totaliza;
end;

procedure TFrmDebito.TVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = Key_Enter ) or (Key = Key_Espaco) then
    TVDblClick(nil);
end;

procedure TFrmDebito.TVMouseLeave(Sender: TObject);
var I : Integer;
begin
  if FMouseRec>-1 then begin
    I := FMouseRec;
    FMouseRec := -1;
    TV.ViewData.Records[I].Invalidate(TVPagar);
  end;
end;

procedure TFrmDebito.TVMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  AGridSite: TcxGridSite;
  RCH : TcxGridRecordCellHitTest;
  lastMR : Integer;  
begin
  LastMR := FMouseRec;
  
  FMouseRec := -1;
  
  AGridSite := Sender as TcxGridSite;
  AHitTest := TV.GetHitTest(X, Y);
  
  if AHitTest<>nil then
    AGridSite.Cursor := AHitTest.Cursor;

  if (AHitTest is TcxGridRecordCellHitTest) then begin
    RCH := TcxGridRecordCellHitTest(AHitTest);
    if RCH.Item.Index=0 then begin
      AGridSite.Cursor := crHandPoint;
      FMouseRec := RCH.GridRecord.Index;
    end;
  end;

  if (LastMR<>FMouseRec) then begin
    if lastMR>-1 then
      TV.ViewData.Records[lastMR].Invalidate(TVPagar);
    if FMouseRec>-1 then
      TV.ViewData.Records[FMouseRec].Invalidate(TVPagar);
  end;
end;

procedure TFrmDebito.TVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  AHitTest: TcxCustomGridHitTest;
  AGridSite: TcxGridSite;
begin
  AHitTest := TV.GetHitTest(X, Y);
  if (AHitTest is TcxGridRecordCellHitTest) then
    if TcxGridRecordCellHitTest(AHitTest).Item.Index=0 then 
      TVDblClick(nil);
end;

procedure TFrmDebito.TVPagarCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  with AViewInfo do
  if (Value <>null) and (Value=True) then 
    ACanvas.Font.Style := [fsBold];
    
  if FMouseRec = AViewInfo.GridRecord.Index then
    ACanvas.Font.Style := ACanvas.Font.Style + [fsUnderline];
end;

procedure TFrmDebito.TVTotalCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  with AViewInfo.GridRecord do
  if (Values[0] <>null) and (Values[0]=True) then 
    ACanvas.Font.Style := [fsBold];
end;

end.
