unit GMA.Model.Gradient;

interface

uses
  System.Generics.Collections;

type
  TgGradientItem = record
  public
    Start: string;
    &End: string;
    Height: Integer;
    class function Create(const AStart, AEnd: string; const AHeight: Integer): TgGradientItem; static;
  end;

  TgGradient = class(TList<TgGradientItem>)
  public
    function TotalHeight: Integer;
  end;

implementation

{ TgGradient }

class function TgGradientItem.Create(const AStart, AEnd: string; const AHeight: Integer): TgGradientItem;
begin
  Result.Start := AStart;
  Result.&End := AEnd;
  Result.Height := AHeight;
end;

{ TgGradient }

function TgGradient.TotalHeight: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    Inc(Result, Items[I].Height);
end;

end.
