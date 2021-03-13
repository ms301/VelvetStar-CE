program VelvetStarCE;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Host in 'Views\View.Host.pas' {ViewHost},
  View.Auth in 'Views\View.Auth.pas' {ViewClientAuth: TFrame},
  FluentUI.ColorPalettes in 'FluentUI\FluentUI.ColorPalettes.pas',
  Galaxy.AccountsViewer in 'GalaxyMarsApi\Components\Galaxy.AccountsViewer.pas',
  Galaxy.Model.Account in 'GalaxyMarsApi\Model\Galaxy.Model.Account.pas',
  FluentUI.Dialog in 'FluentUI\FluentUI.Dialog.pas',
  FluentUI.Core.TextTools in 'FluentUI\FluentUI.Core.TextTools.pas',
  View.Modules in 'Views\View.Modules.pas' {ViewModules: TFrame},
  View.Modules.UserRegistrator in 'Views\View.Modules.UserRegistrator.pas' {ViewModulesUserRegistrator: TFrame},
  View.About in 'Views\View.About.pas' {ViewAbout: TFrame},
  Galaxy.Web in 'GalaxySunApi\Galaxy.Web.pas',
  SunApi.WebRequest.Base in 'GalaxySunApi\SunApi.WebRequest.Base.pas',
  FluentUI.Helpers.TControl in 'FluentUI\FluentUI.Helpers.TControl.pas',
  Galaxy.Model.Accounts in 'GalaxyMarsApi\Model\Galaxy.Model.Accounts.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TViewHost, ViewHost);
  Application.Run;

end.
