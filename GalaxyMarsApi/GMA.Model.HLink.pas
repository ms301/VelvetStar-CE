unit GMA.Model.HLink;

interface

type
  TgHLink = record
  public
    Key: string;
    Value: string;
    class function Create(const AKey, AValue: string): TgHLink; static;
  end;

implementation

{ TgHLink }

class function TgHLink.Create(const AKey, AValue: string): TgHLink;
begin
  Result.Key := AKey;
  Result.Value := AValue;
end;

end.
