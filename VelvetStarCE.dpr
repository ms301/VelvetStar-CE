program VelvetStarCE;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Host in 'Views\View.Host.pas' {ViewHost},
  View.Client.Auth in 'Views\View.Client.Auth.pas' {ViewClientAuth: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TViewHost, ViewHost);
  Application.Run;
end.
