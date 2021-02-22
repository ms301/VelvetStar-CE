program VelvetStarCE;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Host in 'Views\View.Host.pas' {ViewHost},
  View.Client.Auth in 'Views\View.Client.Auth.pas' {ViewClientAuth: TFrame},
  FluentUI.ColorPalettes in 'FluentUI\FluentUI.ColorPalettes.pas',
  Galaxy.AccountsViewer in 'Sources\Components\Galaxy.AccountsViewer.pas',
  Galaxy.Model.Account in 'Sources\Model\Galaxy.Model.Account.pas',
  FluentUI.Dialog in 'FluentUI\FluentUI.Dialog.pas',
  FluentUI.Core.TextTools in 'FluentUI\FluentUI.Core.TextTools.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TViewHost, ViewHost);
  Application.Run;

end.
