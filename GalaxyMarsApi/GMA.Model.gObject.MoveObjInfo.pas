unit GMA.Model.gObject.MoveObjInfo;

interface

uses
  GMA.Model.gObject.PositionInfo,
  System.Types;

type
  TgMoveObjInfo = class(TgObjPositionInfo)
  private
    FOldCoord: TPointF;
    FTime: Integer;
  public
    property Id;
    property Coord;
    property OldCoord: TPointF read FOldCoord write FOldCoord;
    property Time: Integer read FTime write FTime;
  end;

implementation

end.
