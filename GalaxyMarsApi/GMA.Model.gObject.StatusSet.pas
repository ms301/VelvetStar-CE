unit GMA.Model.gObject.StatusSet;

interface

uses
  System.Generics.Collections;

type
  TgObjectStatusSet = class
  private
    FID: string;
    FSortOrder: Integer;
    FStatuses: TList<Integer>;
    FMenues: TList<Integer>;
    FType: Integer;
  public
    constructor Create();
    destructor Destroy; override;
    property ID: string read FID write FID;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Statuses: TList<Integer> read FStatuses write FStatuses;
    property Menues: TList<Integer> read FMenues write FMenues;
    property &Type: Integer read FType write FType;
  end;

implementation

{ TgObjectStatusSet }

destructor TgObjectStatusSet.Destroy;
begin
  FMenues.Free;
  FStatuses.Free;
  inherited;
end;

constructor TgObjectStatusSet.Create;
begin
  FStatuses := TList<Integer>.Create;
  FMenues := TList<Integer>.Create;
end;

end.
