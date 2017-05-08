; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

; Na linha abaixo � definido o nome do programa
#define NexServDescr "Nex Servidor" 
#define NexServExe "NexServ.exe"

#define NexAdminDescr "Nex Admin" 
#define NexAdminExe "NexAdmin.exe"

[Setup]
AppName=Nex
AppVerName=Nex C364
AppPublisherURL=http://www.nextar.com
AppSupportURL=http://www.nextar.com
AppUpdatesURL=http://www.nextar.com
DefaultDirName=C:\nex
DefaultGroupName=Nex
OutputDir=c:\instaladores
DirExistsWarning=No
OutputBaseFilename=setup_nex_en_

[Types]
Name: "Servidor"; Description: "Server / Admin"
Name: "Admin";   Description: "Admin"

[Components]
Name: "Servidor"; Description: "Server / Admin"; Types: Servidor
Name: "Admin"; Description: "Server / Admin"; Types: Admin

[Tasks]
; NOTE: The following entry contains English phrases ("Create a desktop icon" and "Additional icons"). You are free to translate them into another language if required.
Name: desktopicon; Description: Create icon on &desktop; Components: Servidor; GroupDescription: �cones adicionais:
; NOTE: The following entry contains English phrases ("Create a Quick Launch icon" and "Additional icons"). You are free to translate them into another language if required.
; Name: "quicklaunchicon"; Description: "Create a &Quick Launch icon"; GroupDescription: "�cones adicionais:"; Flags: unchecked
Name: autostarticon; Description: Run NexServ automatically on Windows startup; Components: Servidor; GroupDescription: �cones adicionais:

[Files]
Source: "C:\Meus Programas\nex\NexServ.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: Servidor
Source: "C:\Meus Programas\nex\nexutils.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: Servidor Admin
Source: "C:\Meus Programas\nex\libeay32.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: Servidor Admin
Source: "C:\Meus Programas\nex\ssleay32.dll"; DestDir: "{app}"; Flags: ignoreversion; Components: Servidor Admin
Source: "C:\Meus Programas\nex\NexAdmin.exe"; DestDir: "{app}"; Flags: ignoreversion; Components: Servidor Admin
Source: "C:\Meus Programas\nex\newDoc.nx1"; DestDir: "{app}\db"; Flags: onlyifdoesntexist; Components: Servidor
Source: "C:\Meus Programas\nex\br_cest.nx1"; DestDir: "{app}\db"; Flags: onlyifdoesntexist; Components: Servidor
Source: "C:\Meus Programas\nex\ncm.nx1"; DestDir: "{app}\db"; Flags: onlyifdoesntexist; Components: Servidor
Source: "C:\Meus Programas\nex\CFOP.nx1"; DestDir: "{app}\db"; Flags: ignoreversion; Components: Servidor
Source: "C:\Meus Programas\nex\MunBr.nx1"; DestDir: "{app}\db"; Flags: ignoreversion; Components: Servidor
Source: "C:\Meus Programas\nex\capicom.dll"; DestDir: "{sys}"; Flags: onlyifdoesntexist regserver 32bit; Components: Servidor
Source: "C:\Meus Programas\NEX\SAT\drivers\*"; DestDir: "{app}\sat\drivers"; Flags: ignoreversion createallsubdirs recursesubdirs
Source: "C:\Meus Programas\NEX\nfe\icms_interestadual.ini"; DestDir: "{app}\nfe"; Flags: ignoreversion createallsubdirs recursesubdirs

[INI]
Filename: {app}\Nex.url; Section: InternetShortcut; Key: URL; String: http://nex.nextar.com.br/loja

[Icons]
Name: {group}\Nex Servidor; Filename: {app}\NexServ.exe; Components: Servidor; WorkingDir: {app}
Name: {group}\Nex Admin; Filename: {app}\NexAdmin.exe; Components: Servidor Admin; WorkingDir: {app}
Name: {group}\Desinstalar Nex; Filename: {uninstallexe}
Name: {userdesktop}\Nex-Servidor; Filename: {app}\NexServ.exe; Tasks: desktopicon; WorkingDir: {app}
Name: {userdesktop}\Nex-Admin; Filename: {app}\NexAdmin.exe; Tasks: desktopicon; WorkingDir: {app}
Name: {commonstartup}\Nex-Serv; Filename: {app}\NexServ.exe; Tasks: autostarticon; WorkingDir: {app}

[Registry]
Root: HKCU; Subkey: "Software\Nex"; Flags: uninsdeletekey; ValueType: dword; ValueName: "Installed"; ValueData: "20101";

[UninstallDelete]
Type: files; Name: {app}\Nex.url

[Languages]

[Dirs]
Name: "{app}\drivers\Bematech\"
Name: "{app}\drivers\Dimep\"
Name: "{app}\drivers\Elgin\"
Name: "{app}\drivers\Kryptus\"
Name: "{app}\drivers\Sweda\"
Name: "{app}\drivers\Tanca\"