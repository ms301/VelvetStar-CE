unit GMA.Model.Teleport;

interface

uses
  System.Generics.Collections;

type
  TgTeleport = class
  private
    FType: Integer;
    FColors: TArray<string>;
  public
    constructor Create;
    destructor Destroy; override;
    property &Type: Integer read FType write FType;
    property Colors: TArray<string> read FColors write FColors;
  end;

implementation

{ TgTeleport }

constructor TgTeleport.Create;
begin
  // FColors := TList<string>.Create;
end;

destructor TgTeleport.Destroy;
begin
  // FColors.Free;
  inherited;
end;

end.
