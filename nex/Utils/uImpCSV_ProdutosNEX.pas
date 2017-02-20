unit uImpCSV_ProdutosNEX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, nxdb, nxseAllEngines, nxsdServerEngine, nxsrServerEngine,
  nxllTransport, nxptBasePooledTransport, nxtwWinsockTransport, nxllComponent,
  Grids, DBGrids, nxreRemoteServerEngine;

type
  TForm16 = class(TForm)
    nxSession1: TnxSession;
    nxDB: TnxDatabase;
    nxTCP: TnxWinsockTransport;
    PB: TProgressBar;
    Button1: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    tEst: TnxTable;
    tProd: TnxTable;
    tProdID: TAutoIncField;
    tProdCodigo: TStringField;
    tProdDescricao: TStringField;
    tProdUnid: TStringField;
    tProdPreco: TCurrencyField;
    tProdObs: TnxMemoField;
    tProdImagem: TGraphicField;
    tProdCategoria: TStringField;
    tProdFornecedor: TIntegerField;
    tProdSubCateg: TStringField;
    tProdEstoqueAtual: TFloatField;
    tProdCustoUnitario: TCurrencyField;
    tProdEstoqueACE: TFloatField;
    tProdEstoqueACS: TFloatField;
    tProdPodeAlterarPreco: TBooleanField;
    tProdNaoControlaEstoque: TBooleanField;
    tProdEstoqueMin: TFloatField;
    tProdEstoqueMax: TFloatField;
    tProdAbaixoMin: TBooleanField;
    tProdAbaixoMinDesde: TDateTimeField;
    tProdEstoqueRepor: TFloatField;
    tProdplus: TBooleanField;
    tProdplusURL: TnxMemoField;
    tProdplusCodParceiro: TStringField;
    tProdplusCodProduto: TStringField;
    tProdAtivo: TBooleanField;
    tProdFidelidade: TBooleanField;
    tProdFidPontos: TIntegerField;
    tEstID: TAutoIncField;
    tEstTran: TIntegerField;
    tEstProduto: TIntegerField;
    tEstQuant: TFloatField;
    tEstUnitario: TCurrencyField;
    tEstTotal: TCurrencyField;
    tEstCustoU: TCurrencyField;
    tEstItem: TWordField;
    tEstDesconto: TCurrencyField;
    tEstPago: TCurrencyField;
    tEstPagoPost: TCurrencyField;
    tEstDescPost: TCurrencyField;
    tEstDataHora: TDateTimeField;
    tEstEntrada: TBooleanField;
    tEstCancelado: TBooleanField;
    tEstEstoqueAnt: TFloatField;
    tEstCliente: TIntegerField;
    tEstCaixa: TIntegerField;
    tEstCategoria: TStringField;
    tEstNaoControlaEstoque: TBooleanField;
    tEstITran: TIntegerField;
    tEstTipoTran: TWordField;
    tEstSessao: TIntegerField;
    tEstplusID: TGuidField;
    tEstplusTran: TBooleanField;
    tEstFidResgate: TBooleanField;
    tEstFidPontos: TFloatField;
    tFor: TnxTable;
    tForID: TAutoIncField;
    tForNome: TStringField;
    tForFornecedor: TBooleanField;
    nxRSE: TnxRemoteServerEngine;
    tForObs: TnxMemoField;
    procedure Button1Click(Sender: TObject);
  private
    function Fornecedor(aNome, aObs: String): Integer;
    procedure AddEstoque;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form16: TForm16;

implementation

{$R *.dfm}


function CodStr(I: Integer): String;
begin
  Result := IntToStr(I);
  while length(result)<3 do
    result := '0'+result;
end;

function SoDig(S: String): String;
var i: integer;
begin
  result := '';
  for i := 1 to length(S) do
    if s[i] in ['0'..'9', ',', '.'] then
      result := result + s[i];
end;

function SoDig2(S: String): String;
var i: integer;
begin
  result := '';
  for i := 1 to length(S) do
    if s[i] in ['0'..'9'] then
      result := result + s[i];
end;

function ENumero(S: String; var J: Integer): Boolean;
begin
  try
    J := StrToInt(S);
    Result := True;
  except
    Result := False;
  end;
end;

function StrToCurrency(S: String): Currency;
var 
  Code, P : Integer;
  R : Double;
begin
  S := SoDig(S);
  P := Pos(',', S);
  if P>0 then S[P] := '.';
  Result := 0;
  if (Trim(S)>'') then begin
    Val(S, R, Code);
    if Code=0 then
      REsult := R;
  end;
end;

function LimpaRG(S: String): String;
var I: Integer;
begin
  Result := '';
  while (Length(S)>0) and (not (S[1] in ['0'..'9'])) do
    Delete(S, 1, 1);
  Result := Trim(S);  
end;

function MeuTrim(S: String): String;
var 
   I: Integer; 
begin
  Result := '';
  for I := 1 to Length(S) do 
    if Ord(S[i])=160 then
      Result := Result + ' ' else
      Result := Result + S[i];
end;

function DuasCasas(D: Extended): Extended;
var 
  I, C : Integer;
  S : String;
begin
  Str(D:10:10, S);
  if CurrencyDecimals>0 then 
    S := Copy(S, 1, Pos('.', S)+CurrencyDecimals) 
  else begin
    I := Pos('.', S);
    if I>0 then
      S := Copy(S, 1, I-1);
  end;
  Val(S, Result, I);
  
{  S := D;
  C := 1;
  DebugMsg('DuasCasas - D: '+FloatToStr(D));
  
  for I := 1 to CurrencyDecimals do C := C * 10;

  D := Int(D * C);
  Result := D / C;  

  DebugMsg('DuasCasas - Result: '+FloatToStr(Result));
  DebugMsg('Plano B: '+FloatToStr(Trunc(S*C)/C));}
end;

procedure TForm16.AddEstoque;
begin
    if tProdEstoqueAtual.Value > 0 then begin
      tEst.Append;
      tEstProduto.Value := tProdID.Value;
      tEstEntrada.Value := True;
      tEstTipoTran.Value := 6;
      tEstCaixa.Value := -1;
      tEstQuant.Value := tProdEstoqueAtual.Value;
      tEstDataHora.Value := Date;
      tEst.Post;
    end; 
end;

procedure TForm16.Button1Click(Sender: TObject);
var 
  SL: TStrings;
  I, J, Min, Cod: Integer;
  S, s2, s3, sDoc: String;
  Mon : Currency;
  DT: TDateTime;
  Qtd : Integer;

function FindFimAspas: Integer;
var qaspas: byte;
begin
  qaspas := 1;
  for Result := 1 to Length(S) do
    case S[result] of 
      '"' : begin
        Inc(qAspas);
        if qAspas=2 then qAspas := 0;
      end;

      ';' : if qAspas=0 then Exit
   end;
   if (Result = Length(S)) and (Pos(';', S)>0) then 
     Result := Pos(';', S);
end;

procedure AspasDuplasParaAspas(var P: Integer);
var z, qAspas: Integer;
begin
  for z := P-1 downto 1 do
  if (S[z]='"') and (S[z+1]='"') then begin
    Delete(S, z, 1);
    qAspas := 0;
    Dec(P);
  end;
end;

procedure RemoveUltimaAspas(var P: Integer);
var z: integer;
begin
  for z := P downto 1 do
  if (S[z]='"') then begin
    Delete(S, z, 1);
    Dec(P);
    Exit;
  end;
end;

{function ProxCampo: String;
var 
  P: Integer;
  C: Char;
  Aspas: Boolean;
begin
  if S='' then begin
    Result := '';
    Exit;
  end;

  S := Trim(S);
  
  if S[1]='"' then begin
    Delete(S, 1, 1);
    Aspas := True;
    P := FindFimAspas;
    RemoveUltimaAspas(P);
    AspasDuplasParaAspas(P);
  end else begin
    Aspas := False;
    C := ',';
    P := Pos(C, S);
  end;
  
  if P>0 then begin
    Result := Trim(Copy(S, 1, P-1));
    Delete(S, 1, P);
  end else begin
    Result := Trim(S);
    S := '';
  end;
  S := Trim(S);
  if (C='"') and (S>'') and (S[1]=',') then Delete(S, 1, 1);

  Result := Trim(MeuTrim(Result));
end; }


function ProxCampo: String;
var 
  P: Integer;
  C: Char;
  Aspas, AspasOn : Boolean;

function AspasDuplas: Boolean;
begin
  Result := Copy(S, P, 2)='""';
end;

function AspasSimples: Boolean;
begin
  Result := Copy(S, P, 1)='"';
end;

begin
  Result := '';
  if S='' then
    Result := '';

  C := ',';
  
  if S[1]='"' then begin
    Delete(S, 1, 1);
    Aspas := True;
  end else 
    Aspas := False;

  if S='' then Exit;
  
  P := 0;

  while P<Length(S) do begin
    Inc(P);

    if Aspas then begin
      if AspasDuplas then begin
        Delete(S, P, 1);
        if P=Length(S) then begin
          Result := S;
          S := '';
        end;
      end else
      if AspasSimples then begin
        Result := Copy(S, 1, P-1);
        Delete(S, 1, P);
        Break;
      end else
      if (P=Length(S)) then begin
        Result := S;
        S := '';
      end;
    end else begin
      if S[P]=C then begin
        Result := Copy(S, 1, P-1);
        Delete(S, 1, P-1);
        Break;
      end else 
      if P=Length(S) then begin
        Result := S;
        Break;
        S := '';
      end;
    end;
  end;

  Result := Trim(Result);
  
  P := Pos(C, S);
  if P>0 then Delete(S, 1, P);

  Result := Trim(MeuTrim(Result));
end;

procedure proxn(n: Integer);
begin
  while n>0 do begin
    ProxCampo;
    dec(n);
  end;
end;

procedure AddDescr(D: String);
begin
  if Trim(D)='' then Exit;
  tProdDescricao.Value := tProdDescricao.Value + ' ' + D;
end;

begin
  SL := TStringList.Create;
  SL.LoadFromFile('c:\nex\produtos.csv');
  PB.Max := SL.Count;
  PB.Position := 0;
  tProd.Open;
  tEst.Open;
  tFor.Open;
  tProd.DeleteRecords;
  tEst.DeleteRecords;
  tFor.DeleteRecords;
  tProd.SetAutoIncValue(0);
  ShortDateFormat := 'dd/mm/yyyy';
//  for J := 1 to 2 do 
  for I := 1 to SL.Count-1 do begin
    PB.Position := I + 1;
    Application.ProcessMessages;
    S := SL[I];   
    tProd.Append;
    tProdCodigo.Value := ProxCampo; 
    tProdDescricao.Value := ProxCampo;
    tProdCustoUnitario.Value := StrToCurrency(ProxCampo); ProxCampo;
    tProdPreco.Value := DuasCasas(tProdCustoUnitario.Value*2.2);
    tProdEstoqueAtual.Value := StrToIntDef(ProxCampo, 0);
    tProdCategoria.Value := ProxCampo;
    tProdUnid.Value := proxCampo;
    tProd.Post;
  end;
  AddEstoque;
end;

function TForm16.Fornecedor(aNome, aObs: String): Integer;
begin
  if Trim(aNome)='' then begin
    Result := 0;
    Exit;
  end;
  if not tFor.FindKey([True, aNome]) then begin
    tFor.Insert;
    tForFornecedor.Value := True;
    tForNome.Value := aNome;
    tForObs.Value := aObs;
    tFor.Post;
  end;
  Result := tForID.Value;
end;

end.