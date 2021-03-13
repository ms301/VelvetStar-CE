unit GMA.Model.View;

interface

uses
  System.Generics.Collections,
  GMA.Model.ViewData.Image,
  GMA.Model.ViewData.Data,
  GMA.Model.ViewData.Animation;

type

  TgView = class
  private
    fID: string;
    FType: Integer;
    FImages: TObjectList<TViewDataImage>;
    FSortOrder: Integer;
    FDX: Integer;
    FDY: Integer;
    FAnimation: TgViewDataAnimation;
  protected
    procedure ParseType1(Data: TViewDataData);
    procedure ParseType2(Data: TViewDataData);
  public
    constructor Create(); overload;
    constructor Create(AData: TViewDataData); overload;
    constructor Create(ARaw: TArray<string>); overload;
    destructor Destroy; override;
    property ID: string read fID write fID;
    property &Type: Integer read FType write FType;
    property Images: TObjectList<TViewDataImage> read FImages write FImages;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property DX: Integer read FDX write FDX;
    property DY: Integer read FDY write FDY;
    property Animation: TgViewDataAnimation read FAnimation write FAnimation;
  end;

implementation

uses

  System.SysUtils;

{ TgViewData }

constructor TgView.Create(AData: TViewDataData);
begin
  Create;
  ID := AData.ID.ToString;
  &Type := AData.&Type;
  SortOrder := AData.SortOrder;
  if &Type = 1 then
    ParseType1(AData)
  else if &Type = 2 then
    ParseType2(AData)
  else
    raise Exception.Create('TgViewData.Create: Unknown type');
end;

constructor TgView.Create(ARaw: TArray<string>);
var
  LData: TViewDataData;
begin
  LData := TViewDataData.Create(ARaw);
  try
    Create(LData);
  finally
    LData.Free;
  end;
end;

constructor TgView.Create;
begin
  FAnimation := TgViewDataAnimation.Create;
  FImages := TObjectList<TViewDataImage>.Create();
  DX := 0;
  DY := 0;
  ID := '0';
  FType := 0;
  SortOrder := 0;
end;

destructor TgView.Destroy;
begin
  FreeAndNil(FImages);
  FreeAndNil(FAnimation);
  inherited;
end;

procedure TgView.ParseType1(Data: TViewDataData);
var
  I: Integer;
  LImg: TViewDataImage;
begin
  for I := 0 to High(Data.imgId) do
  begin
    LImg := TViewDataImage.Create(Data.imgId[I], -1, -1, 33);
    LImg.DX := 2 * Data.imgPos[I][0];
    LImg.DY := 2 * Data.imgPos[I][1];
    if High(Data.imgPos[I]) = 2 then
    begin
      LImg.Anchor := Data.imgPos[I][2];
    end;
    Images.Add(LImg);
  end;
end;

procedure TgView.ParseType2(Data: TViewDataData);
var
  I, J: Integer;
  img_url: string;
  img_type: string;
  LImg: TViewDataImage;
begin
  Animation.&Type := Data.animType;
  Animation.Times.AddRange(Data.Time);
  for I := 0 to High(Data.imgId) do
  begin
    img_url := Data.imgId[I];
    if img_url.Chars[0] = '-' then
    begin
      img_type := 'static';
      img_url := img_url.Substring(1);
    end
    else
      img_type := 'animated';
    LImg := TViewDataImage.Create(img_url, 0, 0, 33);
    LImg.DX := 2 * Data.imgPos[I][0];
    LImg.DY := 2 * Data.imgPos[I][1];
    if High(Data.imgPos[I]) = 2 then
    begin
      LImg.Anchor := Data.imgPos[I][2];
    end;
    if img_type = 'static' then
    begin
      Images.Add(LImg);
      Animation.Images.Add(nil);
    end
    else if img_type = 'animated' then
    begin
      Animation.Images.Add(LImg);
    end
    else
    begin
      raise Exception.Create('TgViewData.ParseType2: img_type=' + img_type);
    end;
    if Data.Seq.Count > 0 then
    begin
      Animation.Sequences.AddRange(Data.Seq);
    end
    else
    begin
      for J := 0 to Data.Time.Count - 1 do
      begin
        Animation.Sequences.Add(J);
      end;
    end;
  end;
end;

end.
