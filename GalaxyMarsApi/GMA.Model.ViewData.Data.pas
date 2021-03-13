unit GMA.Model.ViewData.Data;

interface

uses
  System.JSON.Converters,
  System.JSON.Serializers,
  System.Generics.Collections;

type
  TViewDataData = class
  private type
    TListTArrayIntegerConverter = class(TJsonListConverter < TArray < Integer >> );
    TListIntegerConverter = class(TJsonListConverter<Integer>);
  private
    [JsonName('id')]
    FID: Integer;
    [JsonName('sortOrder')]
    FSortOrder: Integer;
    [JsonName('type')]
    FType: Integer;
    FimgId: TArray<string>; // arr of str
    [JsonName('imgId')]
    // [JsonConverter(TListIntegerConverter)]
    FimgIdInt: TArray<Integer>;
    [JsonName('imgPos')]
    [JsonConverter(TListTArrayIntegerConverter)]
    FimgPos: TList<TArray<Integer>>;
    [JsonName('animType')]
    FanimType: Integer;
    [JsonName('time')]
    [JsonConverter(TListIntegerConverter)]
    FTime: TList<Integer>;
    [JsonName('seq')]
    [JsonConverter(TListIntegerConverter)]
    Fseq: TList<Integer>;
  public
    constructor Create; overload;
    constructor Create(ARaw: TArray<string>); overload;
    destructor Destroy; override;
    procedure IntToStr;
    property ID: Integer read FID write FID;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property &Type: Integer read FType write FType;
    property imgId: TArray<string> read FimgId write FimgId;
    property imgPos: TList < TArray < Integer >> read FimgPos write FimgPos;
    property animType: Integer read FanimType write FanimType;
    property Time: TList<Integer> read FTime write FTime;
    property Seq: TList<Integer> read Fseq write Fseq;
  end;

implementation

uses
  GMA.Core.Tools,
  System.SysUtils;
{ TViewDataData }

constructor TViewDataData.Create(ARaw: TArray<string>);
var
  j: Integer;
  img_count: Integer;
  imgs: TArray<string>;
  times: TArray<string>;
  sequence: TArray<string>;
  I: Integer;
begin
  Create;
  FID := ARaw[0].ToInteger;
  FSortOrder := ARaw[High(ARaw)].ToInteger;
  ARaw := Copy(ARaw, 1, High(ARaw) - 1);
  FType := ARaw[0].ToInteger;
  ARaw := TArray.Slice<string>(ARaw, 1, -1);
  if FType = 1 then
  begin
    j := 0;
    while j < Length(ARaw) do
    begin
      TArray.Add<string>(imgId, ARaw[j]);
      imgPos.Add([ARaw[j + 1].ToInteger, ARaw[j + 2].ToInteger, ARaw[j + 3].ToInteger]);
      Inc(j, 4);
    end;
  end
  else if FType = 2 then
  begin
    img_count := ARaw[1].ToInteger;
    imgs := TArray.Slice<string>(ARaw, 2, 2 + img_count * 4);
    animType := ARaw[0].ToInteger;
    times := ARaw[2 + img_count * 4].split([',']);
    for I := Low(times) to High(times) do
      FTime.Add(times[I].ToInteger);
    j := 0;
    while j < Length(imgs) do
    begin
      TArray.Add<string>(FimgId, imgs[j]);
      FimgPos.Add([imgs[j + 1].ToInteger, imgs[j + 2].ToInteger, imgs[j + 3].ToInteger]);
      Inc(j, 4);
    end;
    sequence := ARaw[2 + img_count * 4 + 1].split([',']);
    for I := Low(sequence) to High(sequence) do
      Seq.Add(sequence[I].ToInteger);
  end
  else
  begin
    raise Exception.Create('TgParseViewData.ParseViewData: Unsupported Type');
  end;
end;

constructor TViewDataData.Create;
begin
  // FimgId := TList<string>.Create;
  FTime := TList<Integer>.Create;
  Fseq := TList<Integer>.Create;
  FimgPos := TList < TArray < Integer >>.Create;
end;

destructor TViewDataData.Destroy;
begin
  // FimgId.Free;
  FTime.Free;
  Fseq.Free;
  FimgPos.Free;
  inherited;
end;

procedure TViewDataData.IntToStr;
var
  I: Integer;
begin
  for I := Low(FimgIdInt) to High(FimgIdInt) do
    TArray.Add<string>(FimgId, FimgIdInt[I].ToString);
end;

end.
