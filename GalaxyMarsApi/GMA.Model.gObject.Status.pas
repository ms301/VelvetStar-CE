unit GMA.Model.gObject.Status;

interface

uses
  System.Generics.Collections,
  GMA.Model.View;

type
  TgObjectStatus = class
  private
    FId: Integer;
    FViews: TObjectList<TgView>;
  public
    constructor Create;
    destructor Destroy; override;

    property Id: Integer read FId write FId;
    property Views: TObjectList<TgView> read FViews write FViews;
  end;

implementation

uses
  System.SysUtils;
{ TgObjectStatus }

constructor TgObjectStatus.Create;
begin
  FViews := TObjectList<TgView>.Create;
end;

destructor TgObjectStatus.Destroy;
begin
  FreeAndNil(FViews);
  inherited;
end;

end.
