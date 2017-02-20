program NexServ_Lan;

uses
  nxReplacementMemoryManager,
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  nxReplacementMove,
  Forms,
  SysUtils,
  nxseAllEngines,
  Registry,
  ncJob in '..\Comp\ncJob.pas',
  ncPrintMon in '..\Comp\ncPrintMon.pas',
  ncsFrmBackup in '..\ncsFrmBackup.pas' {FrmCopia},
  ncsFrmLogin in '..\ncsFrmLogin.pas' {FrmLogin},
  ncsFrmPri in 'ncsFrmPri.pas' {frmPri},
  ncAuxPassaporte in '..\Comp\ncAuxPassaporte.pas',
  ncClassesBase in '..\Comp\ncClassesBase.pas',
  ncMsgCom in '..\Comp\ncMsgCom.pas',
  ncServAtualizaLic in '..\Comp\ncServAtualizaLic.pas' {dmAtualizaLic: TDataModule},
  ncServBase in '..\Comp\ncServBase.pas',
  ncServBD in '..\Comp\ncServBD.pas' {dmServidorBD: TDataModule},
  ncTarifador in '..\Comp\ncTarifador.pas',
  ncTableDefs in '..\Comp\ncTableDefs.pas',
  ncTran in '..\Comp\ncTran.pas',
  ncDMServ in '..\Comp\ncDMServ.pas' {DM: TDataModule},
  ncPassaportes in '..\Comp\ncPassaportes.pas',
  ncSessao in '..\Comp\ncSessao.pas',
  ncCredTempo in '..\Comp\ncCredTempo.pas',
  ncImpressao in '..\Comp\ncImpressao.pas',
  ncDebito in '..\Comp\ncDebito.pas',
  ncDMCaixa in '..\Comp\ncDMCaixa.pas' {dmCaixa: TDataModule},
  ncErros in '..\Comp\ncErros.pas',
  ncDMEmail in '..\Comp\ncDMEmail.pas' {dmEmail: TDataModule},
  ncDMProcEmail in '..\Comp\ncDMProcEmail.pas' {dmProcEmail: TDataModule},
  ncListaEspera in '..\Comp\ncListaEspera.pas',
  ncLancExtra in '..\Comp\ncLancExtra.pas',
  ncDebTempo in '..\Comp\ncDebTempo.pas',
  ncImpCM in '..\Comp\ncImpCM.pas' {dmCM: TDataModule},
  ncVersoes in '..\Comp\ncVersoes.pas',
  WindowList in 'C:\comp\WindowList\WindowList.pas',
  ncFrmSuporteRem in '..\Comp\ncFrmSuporteRem.pas' {FrmSuporte},
  ncIPAddr in '..\Comp\ncIPAddr.pas',
  ncSyncLic in '..\Comp\ncSyncLic.pas',
  ncFrmProgress in '..\Comp\ncFrmProgress.pas' {FrmProg},
  uFrmCodLoja in '..\gs\uFrmCodLoja.pas' {FrmCodLoja},
  uWakeOnLan in 'C:\Utils\uWakeOnLan.pas',
  ncDMDBProc in '..\Comp\ncDMDBProc.pas' {dmDBProc: TDataModule},
  uObjPool in 'C:\Utils\uObjPool.pas',
  ncAppUrlLog in '..\Comp\ncAppUrlLog.pas',
  ncsRecalcPass in '..\Comp\ncsRecalcPass.pas' {dmRecalcPass: TDataModule},
  ncMovEst in '..\Comp\ncMovEst.pas',
  ncVersionInfo in '..\Comp\ncVersionInfo.pas',
  ncnxServerPlugin in '..\Comp\ncnxServerPlugin.pas',
  ncNetMsg in '..\Comp\ncNetMsg.pas',
  dmGateConnUnit in 'C:\Comp\Nexus\Portal\V3 Pro\Projects\Gateway\dmGateConnUnit.pas' {dmConn: TDataModule},
  rdServer in 'C:\Comp\Nexus\Portal\V3 Pro\Projects\Gateway\rdServer.pas' {rdServerModule: TDataModule},
  ncMsgCli in '..\Comp\ncMsgCli.pas',
  uRSAss in '..\..\GS\uRSAss.pas',
  Windows,
  Dialogs,
  ShellApi,
  madKernel,
  ElevationUtils in '..\..\Utils\ElevationUtils.pas',
  ncExeUnico in '..\..\Utils\ncExeUnico.pas',
  nxtwWinsockTransport in 'C:\Comp\NexusDB3\nxtwWinsockTransport.pas',
  nxptBasePooledTransport in 'C:\Comp\NexusDB3\nxptBasePooledTransport.pas',
  ncShellStart in '..\Comp\ncShellStart.pas',
  ncCommPlusIndy in '..\Comp\ncCommPlusIndy.pas',
  ncDMcommPlus in '..\Comp\ncDMcommPlus.pas' {dmCommPlus: TDataModule},
  ncFirewall in '..\Comp\ncFirewall.pas',
  CSCBase in '..\..\CSComm\CSCBase.pas',
  ClasseCS in '..\..\CSComm\ClasseCS.pas',
  CacheProp in '..\..\CSComm\CacheProp.pas',
  ncPRConsts in '..\..\PrintReview\ncPRConsts.pas',
  ncPrintDoc in '..\Comp\ncPrintDoc.pas',
  ncTipoImp in '..\Comp\ncTipoImp.pas',
  ncsPrintPDF in '..\ncsPrintPDF.pas',
  ncPrinterInfo8 in '..\Comp\ncPrinterInfo8.pas',
  ncsCallbackEvents in '..\ncsCallbackEvents.pas',
  ncEnvioCaixa in '..\Comp\ncEnvioCaixa.pas',
  uNxCompression in 'C:\nextarprodserver\uNxCompression.pas',
  ncFrmCriarConta in '..\Comp\ncFrmCriarConta.pas' {FrmCriarConta},
  ncaFrmCorrigeEmail in '..\..\Admin\ncaFrmCorrigeEmail.pas' {FrmCorrigeEmail},
  ncaFrmConfirmarReg in '..\..\Admin\ncaFrmConfirmarReg.pas' {FrmConfirmarReg},
  ncaFrmObrigado in '..\..\Admin\ncaFrmObrigado.pas' {FrmObrigado},
  ncsFrmCriarContaServ in '..\ncsFrmCriarContaServ.pas' {FrmCriarContaServ},
  uNexusDBUtils in 'C:\Utils\uNexusDBUtils.pas',
  ncEspecie in '..\Comp\ncEspecie.pas',
  uLogs in 'C:\Utils\uLogs.pas',
  uNexTransResourceStrings_PT in 'C:\FormMgr\translator\uNexTransResourceStrings_PT.pas',
  ncDebCredSaver in '..\Comp\ncDebCredSaver.pas',
  ncListaID in '..\Comp\ncListaID.pas',
  ncIDRecursos in '..\Comp\ncIDRecursos.pas',
  ncaK in '..\Comp\ncaK.pas',
  ncHash in '..\Comp\ncHash.pas',
  ncCommonProc in '..\Comp\ncCommonProc.pas',
  ncPrintException in '..\Comp\ncPrintException.pas',
  ncPrinterConstsAndTypes in '..\Comp\ncPrinterConstsAndTypes.pas',
  ncKiteApi_SyncNexWeb in '..\Comp\ncKiteApi_SyncNexWeb.pas',
  ncKiteApi in '..\Comp\ncKiteApi.pas',
  ncsDMBackup in '..\ncsDMBackup.pas' {dmBackup: TDataModule},
  ncPlusTeste in '..\Comp\ncPlusTeste.pas',
  ncFrmDownSup in '..\Comp\ncFrmDownSup.pas' {FrmDownSup},
  udmLogmein in '..\Comp\udmLogmein.pas' {dmLogmein: TDataModule},
  uNR_chaveseg in '..\..\gs\uNR_chaveseg.pas',
  ncDMProdClient in '..\ncDMProdClient.pas' {dmProdClient: TDataModule},
  ncChecarServidor in '..\ncChecarServidor.pas',
  ncDebug in '..\comp\ncDebug.pas',
  uLicEXECryptor in '..\..\gs\uLicEXECryptor.pas';

{$R *.res}
{$R uacserv.res}


function RunAsAdmin(hWnd: HWND; filename: string; Parameters: string): Boolean;
{
    See Step 3: Redesign for UAC Compatibility (UAC)
    http://msdn.microsoft.com/en-us/library/bb756922.aspx
}
var
    sei: TShellExecuteInfo;
begin
    if SameText(ParamStr(1), 'afterinst') then
      Parameters := Parameters + ' afterinst';
    ZeroMemory(@sei, SizeOf(sei));
    sei.cbSize := SizeOf(TShellExecuteInfo);
    sei.Wnd := hwnd;
    sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
    sei.lpVerb := PChar('runas');
    sei.lpFile := PChar(Filename); // PAnsiChar;
    if parameters <> '' then
        sei.lpParameters := PChar(parameters); // PAnsiChar;
    sei.nShow := SW_SHOWNORMAL; //Integer;

    Result := ShellExecuteEx(@sei);
end;

procedure TermThreads;
var 
  Tick: Cardinal;
  T: IThreads;
begin
  T := CurrentProcess.Threads;
  Tick := GetTickCount+2000;
  while (GetTickCount<Tick) and (T.ItemCount>1) do begin
    Sleep(5);
    T.RefreshItems;
  end;
  T.RefreshItems;
  if T.ItemCount>0 then 
    CurrentProcess.Terminate;
end;

function JaAbriu: Boolean;
var H: HWND;
begin
  H := FindWindow('TncServBaseClassName', nil);
  if H<>0 then begin
    PostMessage(H, wm_abreserv, 0, 0);
    Result := True;
  end else
    Result := False;
end;

begin
  if JaAbriu then Exit;
  
  Application.Initialize;

  
  if (not SameText('NOELEV', ParamStr(1))) and (IsUACEnabled) and (not IsElevated) then begin 
    if (ParamStr(1)='ELEV') then begin
      ShowMessage('O NexServ s� pode ser executado com usu�rio que tenha direito de Administrador no Windows.');
      Exit;
    end else
      RunAsAdmin(0, ParamStr(0), 'ELEV');
  end else begin    
    InitExeUnico;
    {$IFDEF LAN}
    Application.Title := 'NexCaf� - Servidor';
    {$ENDIF}

    {$IFDEF LOJA}
    Application.Title := 'NEX - Servidor';
    {$ENDIF}
    NomeArqDebug := 'DebugNexServ.txt';
    if ExeJaExiste then
      ShowMessage('J� existe um servidor NexCaf� sendo executado!')
    else begin
//      ExtractEmailDlls;
      Application.Title := 'Servidor NexCaf�';
  Application.CreateForm(TfrmPri, frmPri);
  Application.CreateForm(TdmBackup, dmBackup);
  Application.CreateForm(TFrmDownSup, FrmDownSup);
  Application.CreateForm(TdmLogmein, dmLogmein);
  Application.CreateForm(TdmProdClient, dmProdClient);
  Application.Run;
    end;
  end;
end.