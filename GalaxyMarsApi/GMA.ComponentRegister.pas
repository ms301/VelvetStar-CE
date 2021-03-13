unit GMA.ComponentRegister;

interface

uses
  System.Classes;

resourcestring
  rsCategoryExtended = 'Galaxy: Extended Controls';

procedure Register;

implementation

uses
  GMA.Component.AccountsViewer;

procedure Register;
begin
  RegisterComponents(rsCategoryExtended, [TgAccountViewer]);
end;

end.
