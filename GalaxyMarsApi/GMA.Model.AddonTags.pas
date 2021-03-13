unit GMA.Model.AddonTags;

interface

uses
  System.Generics.Collections,
  System.JSON.Converters,
  System.JSON.Serializers;

type
  TgAddonTag = class
  private
    [JsonName('ID')]
    FID: Integer;
    [JsonName('Color')]
    FColor: string;
    [JsonName('Text')]
    FText: string;
  public
    constructor Create(AID: Integer; AColor, AText: string);
    property ID: Integer read FID write FID;
    property Color: string read FColor write FColor;
    property Text: string read FText write FText;
  end;

  TgAddonTags = class
  private type
    TListAddonTagsConverter = class(TJsonListConverter<TgAddonTag>);
  private
    [JsonName('Items')]
    [JsonConverter(TListAddonTagsConverter)]
    FItems: TObjectList<TgAddonTag>;
  public
    function Contains(AID: Integer): Integer; overload;
    function Contains(Addon: TgAddonTag): Integer; overload;
    procedure RemoveByID(AID: Integer);
    procedure RemoveByPosition(APos: Integer);
    procedure AddOrSet(Addon: TgAddonTag);
    constructor Create;
    destructor Destroy; override;
    property Items: TObjectList<TgAddonTag> read FItems write FItems;
  end;

implementation

{ TgAddonTag }

constructor TgAddonTag.Create(AID: Integer; AColor, AText: string);
begin
  FID := AID;
  FColor := AColor;
  FText := AText;
end;

{ TgAddonTags }

function TgAddonTags.Contains(AID: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do
    if FItems[I].ID = AID then
      Exit(I);
end;

function TgAddonTags.Contains(Addon: TgAddonTag): Integer;
begin
  Result := Contains(Addon.ID);
end;

constructor TgAddonTags.Create;
begin
  FItems := TObjectList<TgAddonTag>.Create;
end;

destructor TgAddonTags.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TgAddonTags.RemoveByID(AID: Integer);
begin
  RemoveByPosition(Contains(AID));
end;

procedure TgAddonTags.RemoveByPosition(APos: Integer);
begin
  Items.Delete(APos);
end;

procedure TgAddonTags.AddOrSet(Addon: TgAddonTag);
var
  LPos: Integer;
begin
  LPos := Contains(Addon);
  if LPos > -1 then
  begin
    FItems.Delete(LPos);
    FItems.Insert(LPos, Addon);
  end
  else
    FItems.Add(Addon);
end;

end.
