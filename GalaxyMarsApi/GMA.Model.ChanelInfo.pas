unit GMA.Model.ChanelInfo;

interface

type
  TgChannelInfo = record
  public
    Name: string;
    Capacity: Integer;
    IsOpened: Boolean;
    FlyDelay: Integer;
    class function Create(AName: string; ACapacity: Integer; AIsOpened: Boolean): TgChannelInfo; static;
  end;

implementation

{ TPlanetInfo }

class function TgChannelInfo.Create(AName: string; ACapacity: Integer; AIsOpened: Boolean): TgChannelInfo;
begin
  Result.Name := AName;
  Result.Capacity := ACapacity;
  Result.IsOpened := AIsOpened;
  Result.FlyDelay := -1;
end;

end.
