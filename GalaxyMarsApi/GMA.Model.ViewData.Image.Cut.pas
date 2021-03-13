unit GMA.Model.ViewData.Image.Cut;

interface

type
  TgViewDataImageCut = class
  private
    fDx: Integer;
    fDy: Integer;
    fDh: Integer;
    fDw: Integer;
  public
    constructor Create(const ADx, ADy, ADh, ADw: Integer);
    property Dx: Integer read fDx write fDx;
    property Dy: Integer read fDy write fDy;
    property Dh: Integer read fDh write fDh;
    property Dw: Integer read fDw write fDw;
  end;

implementation

constructor TgViewDataImageCut.Create(const ADx, ADy, ADh, ADw: Integer);
begin
  inherited Create();
  fDx := ADx;
  fDy := ADy;
  fDh := ADh;
  fDw := ADw;
end;

end.
