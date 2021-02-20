program VelvetStarCE;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Main in 'Views\View.Main.pas' {Form7};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
