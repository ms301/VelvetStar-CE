program VelvetStarCE;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Host in 'Views\View.Host.pas' {ViewHost},
  View.Auth in 'Views\View.Auth.pas' {ViewClientAuth: TFrame},
  FluentUI.ColorPalettes in 'FluentUI\FluentUI.ColorPalettes.pas',
  FluentUI.Dialog in 'FluentUI\FluentUI.Dialog.pas',
  FluentUI.Core.TextTools in 'FluentUI\FluentUI.Core.TextTools.pas',
  View.Modules in 'Views\View.Modules.pas' {ViewModules: TFrame},
  View.Modules.UserRegistrator in 'Views\View.Modules.UserRegistrator.pas' {ViewModulesUserRegistrator: TFrame},
  View.About in 'Views\View.About.pas' {ViewAbout: TFrame},
  FluentUI.Helpers.TControl in 'FluentUI\FluentUI.Helpers.TControl.pas',
  View.Log in 'Views\View.Log.pas' {ViewLog: TFrame},
  View.Log.Socket in 'Views\View.Log.Socket.pas' {ViewLogSocket: TFrame},
  VS.Log in 'Source\VS.Log.pas',
  VS.Modules.RecoverLoader in 'Source\VS.Modules.RecoverLoader.pas',
  View.Client.Browser in 'Views\View.Client.Browser.pas' {ViewClient: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TViewHost, ViewHost);
  Application.Run;

end.
