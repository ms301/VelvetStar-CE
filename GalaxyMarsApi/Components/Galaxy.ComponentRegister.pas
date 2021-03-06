unit Galaxy.ComponentRegister;

interface

uses
  System.Classes;

resourcestring
  rsCategoryExtended = 'Galaxy: Extended Controls';

procedure Register;

implementation

uses
  Galaxy.AccountsViewer;

procedure Register;
begin
  RegisterComponents(rsCategoryExtended, [TgAccountViewer]);
end;

end.
