unit GMA.Model.ActionItem;

interface

type
  TgActionItem = class
  private
    FID: Integer;
    FText: string;
    FIsAnimated: Boolean;
  public
    property ID: Integer read FID write FID;
    property Text: string read FText write FText;
    property IsAnimated: Boolean read FIsAnimated write FIsAnimated;
  end;

implementation

end.
