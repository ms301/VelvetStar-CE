unit GMA.Model.Event;

interface

type
{$SCOPEDENUMS ON}
  TgEventType = (Message = 1, Whatsup = 6);

  TgEvent = class
  private
    FID: Integer;
    FIconID: Integer;
    FUrl: string;
    FSortOrder: Integer;
    FText: string;
  public
    property ID: Integer read FID write FID;
    property IconID: Integer read FIconID write FIconID;
    property Url: string read FUrl write FUrl;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Text: string read FText write FText;
  end;

implementation

end.
