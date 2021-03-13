unit GMA.Model.Addons;

interface

uses
  System.Generics.Collections,
  System.SysUtils,
  System.JSON.Serializers,
  System.JSON.Converters, System.Generics.Defaults;

type
  TgAddon = class
  private
    [JsonName('ID')]
    FID: Integer;
    [JsonName('Text')]
    FText: string;
    [JsonName('IconID')]
    FIconID: Integer;
    [JsonName('ParentID')]
    FParentID: Integer;
    [JsonName('Type')]
    FType: Integer;
    [JsonName('Action')]
    FAction: string;
    [JsonName('Url')]
    FUrl: string;
    [JsonName('SortOrder')]
    FSortOrder: Integer;
    FParams: TArray<string>;
    [JsonName('Name')]
    FName: string;
  public
    property ID: Integer read FID write FID;
    /// <summary>
    /// ИД родителя
    /// </summary>
    property ParentID: Integer read FParentID write FParentID;
    property IconID: Integer read FIconID write FIconID;
    property &Type: Integer read FType write FType;
    property Action: string read FAction write FAction;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Text: string read FText write FText;
    property Url: string read FUrl write FUrl;
    property Params: TArray<string> read FParams write FParams;
    property Name: string read FName write FName;
  end;

  TgAddons = class
  private type
    TListAddonsConverter = class(TJsonListConverter<TgAddon>);
  private
    [JsonName('Version')]
    FVersion: string;
    [JsonName('Items')]
    [JsonConverter(TListAddonsConverter)]
    FAddons: TObjectList<TgAddon>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddOrSet(Addon: TgAddon);
    function Contains(Addon: TgAddon): Integer;
    property Addons: TObjectList<TgAddon> read FAddons write FAddons;
    property Version: string read FVersion write FVersion;
  end;

implementation

{ TgMyAddons }

procedure TgAddons.AddOrSet(Addon: TgAddon);
var
  LPos: Integer;
begin
  LPos := Contains(Addon);
  if LPos > -1 then
  begin
    FAddons.Delete(LPos);
    FAddons.Insert(LPos, Addon);
  end
  else
    FAddons.Add(Addon);
end;

function TgAddons.Contains(Addon: TgAddon): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Addons.Count - 1 do
    if Addons[I].ID = Addon.ID then
      Exit(I);
end;

constructor TgAddons.Create;
begin
  inherited Create();
  FAddons := TObjectList<TgAddon>.Create(TComparer<TgAddon>.Construct(
    function(const Left, Right: TgAddon): Integer
    begin
      if not Assigned(Right) then
        Result := 0
      else if not Assigned(Left) then
        Result := 0
      else
        Result := Left.SortOrder - Right.SortOrder;
    end));
  FVersion := '0 0';
end;

destructor TgAddons.Destroy;
begin
  FAddons.Free;
  inherited Destroy;
end;

end.
