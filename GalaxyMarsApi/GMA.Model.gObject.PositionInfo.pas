unit GMA.Model.gObject.PositionInfo;

interface

uses
  System.Types;

type
  TgObjPositionInfo = class
  private
    FId: Integer;
    FCoord: TPointF;
  public
    property Id: Integer read FId write FId;
    property Coord: TPointF read FCoord write FCoord;
  end;

implementation

end.
