program GalaBrowser;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit7 in 'Unit7.pas' {Form7},
  GSA.Web.InternetExplorerUpgrade in 'GalaxySunApi\GSA.Web.InternetExplorerUpgrade.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
