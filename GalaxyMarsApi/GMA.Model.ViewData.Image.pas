unit GMA.Model.ViewData.Image;

interface

uses
  GMA.Model.ViewData.Image.Cut,
  FMX.Graphics;

type
  TgViewDataImageCut = GMA.Model.ViewData.Image.Cut.TgViewDataImageCut;

  TViewDataImage = class
  private
    FUrl: string;
    FDX: Integer;
    FDY: Integer;
    FAnchor: Integer;
    FImage: TBitmap;
    FCut: TgViewDataImageCut;
    FpixelRatio: Integer;
  public
    constructor Create(const AUrl: string; const ADX: Integer = 0; const ADY: Integer = 0; const AAnchor: Integer = 0;
      AImage: string = '');
    destructor Destroy; override;
    property Url: string read FUrl write FUrl;
    property DX: Integer read FDX write FDX;
    property DY: Integer read FDY write FDY;
    property Anchor: Integer read FAnchor write FAnchor;
    property Image: TBitmap read FImage write FImage;
    property Cut: TgViewDataImageCut read FCut write FCut;
    property PixelRatio: Integer read FpixelRatio write FpixelRatio;
  end;

implementation

uses
  System.SysUtils;

{ TViewDataImage }

constructor TViewDataImage.Create(const AUrl: string; const ADX: Integer = 0; const ADY: Integer = 0;
  const AAnchor: Integer = 0; AImage: string = '');
begin
  FImage := TBitmap.Create;
  FUrl := AUrl;
  FDX := ADX;
  FDY := ADY;
  FAnchor := AAnchor;
  if FileExists(AImage) then
    FImage.LoadFromFile(AImage);
end;

destructor TViewDataImage.Destroy;
begin
  if Assigned(FCut) then
    FreeAndNil(FCut);
  FImage.Free;
  inherited;
end;

end.
