program Project4;

uses
  Vcl.Forms,
  Unit4 in 'Unit4.pas' {Form4},
  uMyBrowser in 'uMyBrowser.pas',
  Automation in 'Automation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.