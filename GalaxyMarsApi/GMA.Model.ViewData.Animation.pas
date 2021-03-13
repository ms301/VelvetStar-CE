unit GMA.Model.ViewData.Animation;

interface

uses
  GMA.Model.ViewData.Image,
  System.Generics.Collections;

type
  TgViewDataAnimation = class
  private
    FType: Integer;
    FTimes: TList<Integer>;
    FImages: TObjectList<TViewDataImage>;
    FSequences: TList<Integer>;
    FAllowed: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property &Type: Integer read FType write FType;
    property Times: TList<Integer> read FTimes write FTimes;
    property Images: TObjectList<TViewDataImage> read FImages write FImages;
    property Sequences: TList<Integer> read FSequences write FSequences;
    property Allowed: Boolean read FAllowed write FAllowed;
  end;

implementation

{ TgViewDataAnimation }

constructor TgViewDataAnimation.Create;
begin
  FTimes := TList<Integer>.Create;
  FImages := TObjectList<TViewDataImage>.Create;
  FSequences := TList<Integer>.Create;
  FAllowed := True;
end;

destructor TgViewDataAnimation.Destroy;
begin
  FTimes.Free;
  FImages.Free;
  FSequences.Free;
  inherited;
end;

end.
