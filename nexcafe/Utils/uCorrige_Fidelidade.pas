unit uCorrige_Fidelidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DB, nxdb, nxseAllEngines, nxsdServerEngine, nxsrServerEngine,
  nxllTransport, nxptBasePooledTransport, nxtwWinsockTransport, nxllComponent,
  Grids, DBGrids, ncClassesBase, nxreRemoteServerEngine;

type
  TForm16 = class(TForm)
    nxSession1: TnxSession;
    nxDB: TnxDatabase;
    tCli: TnxTable;
    nxTCP: TnxWinsockTransport;
    tCliID: TAutoIncField;
    tCliNome: TStringField;
    tCliEndereco: TStringField;
    tCliBairro: TStringField;
    tCliCidade: TStringField;
    tCliUF: TStringField;
    tCliCEP: TStringField;
    tCliSexo: TStringField;
    tCliCpf: TStringField;
    tCliRg: TStringField;
    tCliTelefone: TStringField;
    tCliMinutos: TFloatField;
    tCliMinutosUsados: TFloatField;
    tCliMinutosIniciais: TFloatField;
    tCliIsento: TBooleanField;
    tCliUsername: TStringField;
    tCliPai: TStringField;
    tCliMae: TStringField;
    tCliSenha: TStringField;
    tCliUltVisita: TDateTimeField;
    tCliDebito: TCurrencyField;
    tCliEscola: TStringField;
    tCliEscolaHI: TDateTimeField;
    tCliEscolaHF: TDateTimeField;
    tCliNickName: TStringField;
    tCliDataNasc: TDateTimeField;
    tCliCelular: TStringField;
    tCliTemDebito: TBooleanField;
    tCliLimiteDebito: TCurrencyField;
    tCliFoto: TGraphicField;
    tCliIncluidoEm: TDateTimeField;
    tCliAlteradoEm: TDateTimeField;
    tCliIncluidoPor: TStringField;
    tCliAlteradoPor: TStringField;
    tCliInativo: TBooleanField;
    tCliTipoAcessoPref: TIntegerField;
    tCliValorCred: TCurrencyField;
    PB: TProgressBar;
    Button1: TButton;
    tCliObs: TMemoField;
    tCliEmail: TMemoField;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    tFid: TnxTable;
    nxRemoteServerEngine1: TnxRemoteServerEngine;
    tCliFidPontos: TFloatField;
    tCliFidTotal: TFloatField;
    tCliFidResg: TFloatField;
    tFidID: TAutoIncField;
    tFidTran: TIntegerField;
    tFidCaixa: TIntegerField;
    tFidCliente: TIntegerField;
    tFidSessao: TIntegerField;
    tFidDataHora: TDateTimeField;
    tFidTipoTran: TWordField;
    tFidTipoItem: TWordField;
    tFidSubTipo: TWordField;
    tFidItemID: TIntegerField;
    tFidSubItemID: TIntegerField;
    tFidItemPos: TWordField;
    tFidTotal: TCurrencyField;
    tFidDesconto: TCurrencyField;
    tFidTotLiq: TCurrencyField;
    tFidDebito: TCurrencyField;
    tFidPago: TCurrencyField;
    tFidCancelado: TBooleanField;
    tFidFidFator: TSmallintField;
    tFidFidPontos: TFloatField;
    tFidFidMov: TBooleanField;
    tFidplusID: TGuidField;
    tFidplusTran: TBooleanField;
    tFidFidOpe: TWordField;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form16: TForm16;

implementation

{$R *.dfm}

function StrToCurrency(S: String): Currency;
var 
  Code, P : Integer;
  Res: Real;
begin
  P := Pos(',', S);
  if P>0 then S[P] := '.';
  Result := 0;
  if (Trim(S)>'') then begin
    Val(S, Res, Code);
    if Code=0 then
      REsult := Res;
  end;
end;

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
    if s[i] in ['0'..'9', '-'] then
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

procedure TForm16.Button1Click(Sender: TObject);
var 
  SL: TStrings;
  I, J, Min, Cod: Integer;
  S, s2, s3, sDoc: String;
  Mon : Currency;
  DT: TDateTime;
  Dif : Double;

function ProxCampo: String;
var 
  P: Integer;
  C: Char;
begin
  if S='' then begin
    Result := '';
    Exit;
  end;
  
  if S[1]='"' then begin
    Delete(S, 1, 1);
    C := '"';
  end else 
    C := ';';
  
  P := Pos(C, S);
  if P>0 then begin
    Result := Trim(Copy(S, 1, P-1));
    Delete(S, 1, P);
  end else begin
    Result := Trim(S);
    S := '';
  end;
  S := Trim(S);
  if (C='"') and (S>'') and (S[1]=';') then Delete(S, 1, 1);

  for P := Length(Result) downto 1 do 
    if Result[P]='"' then Delete(Result, P, 1);
  Result := Trim(MeuTrim(Result));
end;

procedure proxn(n: Integer);
begin
  while n>0 do begin
    ProxCampo;
    dec(n);
  end;
end;

begin
  tCli.Open;
  tFid.Open;
  PB.Max := tCli.RecordCount;
  PB.Position := 0;
  tCli.First;
  
  while not tCli.Eof do begin
    if (tCliFidTotal.Value>0.01) and ((TCliFidPontos.Value+tCliFidResg.Value) < tCliFidTotal.Value) then 
      begin
        Dif := tCliFidTotal.Value - (tCliFidPontos.Value - tCliFidResg.Value);
        tCli.Edit;
        tCliFidPontos.Value := tCliFidTotal.Value - tCliFidResg.Value;
        tCli.Post;
        tFid.Insert;
        tFidDataHora.Value := Now;
        tFidCaixa.Value := -1;
        tFidTran.Value := -1;
        tFidFidPontos.Value := Dif;
        tFidTipoTran.Value := trAjustaFid;
        tFidTipoItem.Value := itAjustaFid;
        tFidFidFator.Value := 1;
        tFidItemPos.Value := 1;
        tFidCancelado.Value := False;
        tFidCliente.Value := tCliID.Value;
        tFidFidMov.Value := true;
        tFid.Post;
      end;
    tCli.Next;  
    PB.Position := PB.Position + 1;
    Application.ProcessMessages;  
  end;
end;

procedure TForm16.FormCreate(Sender: TObject);
begin
  nxdb.aliasname := 'nexcafe';
end;

procedure TForm16.FormShow(Sender: TObject);
begin
  tCli.Open;
end;

end.