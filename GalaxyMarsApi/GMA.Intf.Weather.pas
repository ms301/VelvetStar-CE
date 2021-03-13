unit GMA.Intf.Weather;

interface

uses
  System.Types;

type
{$SCOPEDENUMS ON}
  TgWatherType = (Empty, Snow, Light, Rain, Fog, Unknown);
  TgWatherTypes = set of TgWatherType;
{$SCOPEDENUMS OFF}

  IgWather = interface
    ['{51DFF772-CBCF-4461-9C39-2A10B6F2D833}']
    procedure Setup(AClipRect: TRectF);
    procedure Update;
    procedure Remove;
  end;

implementation

end.
