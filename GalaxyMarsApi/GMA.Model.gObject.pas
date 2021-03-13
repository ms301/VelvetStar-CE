unit GMA.Model.gObject;

interface

uses
  GMA.Model.MenuItem,
  GMA.Model.gObject.Status,
  GMA.Model.gObject.StatusSet,
  GMA.Model.View,
  System.Generics.Collections,
  System.JSON.Converters,
  System.JSON.Serializers,
  System.Classes;

type
  TgObjectTemplate = class
  private type
    TListMenuItemsConverter = class(TJsonListConverter<TgMenuItem>);
    TListStatusConverter = class(TJsonListConverter<TgObjectStatus>);
    TListStatusSetConverter = class(TJsonListConverter<TgObjectStatusSet>);
  private
    [JsonName('Name')]
    FName: string;
    [JsonConverter(TListMenuItemsConverter)]
    [JsonName('Menues')]
    FMenues: TObjectList<TgMenuItem>;
    [JsonConverter(TListStatusConverter)]
    [JsonName('Statuses')]
    FStatuses: TObjectList<TgObjectStatus>;
    [JsonConverter(TListStatusSetConverter)]
    [JsonName('StatusSets')]
    FStatusSets: TObjectList<TgObjectStatusSet>;
    [JsonName('Type')]
    FType: Integer;
    [JsonName('Version')]
    FVersion: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddStatus(AID: Integer; AView: TgView);
    property &Type: Integer read FType write FType;
    property Version: string read FVersion write FVersion;
    property Menues: TObjectList<TgMenuItem> read FMenues;
    property StatusSets: TObjectList<TgObjectStatusSet> read FStatusSets;
    property Statuses: TObjectList<TgObjectStatus> read FStatuses;
    property Name: string read FName write FName;
  end;

  TgObjectInfo = class(TPersistent)
  private
    FID: Integer;
    FOwnerID: Integer;
    FCoordX: Single;
    FCoordY: Single;
    FStatusSetId: TArray<string>;
    FType: Integer;
    FVersion: string;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public

    constructor Create;
    destructor Destroy; override;
    property &Type: Integer read FType write FType;
    property ID: Integer read FID write FID;
    property OwnerID: Integer read FOwnerID write FOwnerID;
    property CoordX: Single read FCoordX write FCoordX;
    property CoordY: Single read FCoordY write FCoordY;
    property StatusSetId: TArray<string> read FStatusSetId write FStatusSetId;
    property Version: string read FVersion write FVersion;
  end;

  TgObject = class
  private
    FTemplate: TgObjectTemplate;
    FInfo: TgObjectInfo;
  public
    constructor Create(ATemplate: TgObjectTemplate);
    destructor Destroy; override;
    property Info: TgObjectInfo read FInfo write FInfo;
    property Template: TgObjectTemplate read FTemplate write FTemplate;
  end;

implementation

uses
  System.SysUtils;

{ TgObjectTemplate }
procedure TgObjectTemplate.AddStatus(AID: Integer; AView: TgView);
var
  LIndx: Integer;
  i: Integer;
begin
  LIndx := -1;
  if FStatuses.Count > 0 then
  begin
    for i := 0 to FStatuses.Count - 1 do
      if FStatuses[i].ID = AID then
      begin
        LIndx := i;
        Break;
      end;
  end;
  if LIndx > -1 then
    FStatuses[LIndx].Views.Add(AView)
  else
  begin
    FStatuses.Add(TgObjectStatus.Create);
    FStatuses.Last.ID := AID;
    FStatuses.Last.Views.Add(AView);
  end;
end;

constructor TgObjectTemplate.Create;
begin
  inherited Create();
  FMenues := TObjectList<TgMenuItem>.Create;
  FStatuses := TObjectList<TgObjectStatus>.Create;
  FStatusSets := TObjectList<TgObjectStatusSet>.Create;
end;

destructor TgObjectTemplate.Destroy;
begin
  FreeAndNil(FMenues);
  FreeAndNil(FStatuses);
  FreeAndNil(FStatusSets);
  inherited;
end;

{ TgObjectInfo }

procedure TgObjectInfo.AssignTo(Dest: TPersistent);
var
  lDest: TgObjectInfo;
begin
  if Dest is TgObjectInfo then
  begin
    lDest := Dest as TgObjectInfo;
    lDest.ID := ID;
    lDest.&Type := &Type;
    lDest.OwnerID := OwnerID;
    lDest.CoordX := CoordX;
    lDest.CoordY := CoordY;
    lDest.StatusSetId := StatusSetId;
    lDest.Version := Version;
  end
  else
    inherited;
end;

constructor TgObjectInfo.Create;
begin
  inherited Create();

end;

destructor TgObjectInfo.Destroy;
begin

  inherited Destroy;
end;

{ TgObject }

constructor TgObject.Create(ATemplate: TgObjectTemplate);
begin
  FInfo := TgObjectInfo.Create;
  FTemplate := ATemplate;
end;

destructor TgObject.Destroy;
begin
  FInfo.Free;
  inherited;
end;

end.
