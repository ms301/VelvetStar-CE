unit GMA.Core.Tools.NickGenerator;

interface

type
  IgNickGenerator = interface
    ['{8F82C1B1-531C-4D29-B2BE-937EDE0C94C3}']
    function GenerateNick: string;
  end;

  TgNickGenerator = class
  public
    class function OldNick(const ALength: Integer = 10): IgNickGenerator;
  end;

implementation

uses
  System.SysUtils;

type
  TgOldNickGenerator = class(TInterfacedObject, IgNickGenerator)
  private
    FLength: Integer;
  public
    constructor Create(const ALength: Integer = 10);
    function GenerateNick: string;
    property Length: Integer read FLength write FLength;
  end;
{ TgNickGenerator }

class function TgNickGenerator.OldNick(const ALength: Integer = 10): IgNickGenerator;
begin
  Result := TgOldNickGenerator.Create(ALength);
end;

{ TgOldNickGenerator }

constructor TgOldNickGenerator.Create(const ALength: Integer);
begin
  FLength := ALength;
end;

function TgOldNickGenerator.GenerateNick: string;
var
  I: Integer;
begin
  Result := 'g';
  for I := 1 to FLength - 1 do
    Result := Result + Random(9).ToString;
end;

end.
