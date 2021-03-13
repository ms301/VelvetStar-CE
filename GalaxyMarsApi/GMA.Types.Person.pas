unit GMA.Types.Person;

interface

uses
  GMA.Model.Teleport,
  GMA.Model.View,
  GMA.Model.ViewData.Image,
  System.Generics.Collections,

  System.Generics.Defaults;

type
  TgPersonCrown = class
  private
    FDy: Integer;
    FimgUrl: string;
  public
    property Dy: Integer read FDy write FDy;
    property imgUrl: string read FimgUrl write FimgUrl;
  end;

  TgPersonMask = class
  private
    FAura: Boolean;
    FSuit: Boolean;
    FCrown: Boolean;
    FOperator: Boolean;
    FAward: Boolean;
    FEmotion: Boolean;
    FShit: Boolean;
  public
    constructor Create;
  public
    property Aura: Boolean read FAura write FAura;
    property Suit: Boolean read FSuit write FSuit;
    property Crown: Boolean read FCrown write FCrown;
    property &Operator: Boolean read FOperator write FOperator;
    property Award: Boolean read FAward write FAward;
    property Emotion: Boolean read FEmotion write FEmotion;
    property Shit: Boolean read FShit write FShit;
  end;

  TgPerson = class(TInterfacedObject)
  private
    fViewsIsSorted: Boolean;
    FID: Integer;
    FNick: string;
    FClan: string;
    FIsOwner: Boolean;
    FIsOperator: Boolean;
    FAward: Boolean;
    FCoordX: Integer;
    FCoordY: Integer;
    FViews: TObjectList<TgView>;
    FCrown: TgPersonCrown;
    FStar: TgPersonCrown;
    FRating: Integer;
    FAvatars: TArray<string>;
    FStatusID: Integer;
    FObjectType: Integer;
    FMask: TgPersonMask;
    FGender: Integer;
    FTeleport: TgTeleport;
  protected
    function GetComparer: IComparer<TgView>;
  public
    __ParamsCount: Integer;
    procedure AddView(const AName: string; AView: TgView);
    function TryFindView(const AName: string; var AView: TgView; var AIndex: Integer): Boolean;
    procedure RemoveView(const AName: string);
    function ToViewsArray: TArray<TgView>;
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// ID пользователя в чате
    /// </summary>
    property ID: Integer read FID write FID;
    /// <summary>
    /// Ник пользователя в чате
    /// </summary>
    property Nick: string read FNick write FNick;
    /// <summary>
    /// Клан пользователя в чате
    /// </summary>
    property Clan: string read FClan write FClan;
    property Crown: TgPersonCrown read FCrown;
    property Star: TgPersonCrown read FStar;
    property Avatars: TArray<string> read FAvatars write FAvatars;

    property StatusID: Integer read FStatusID write FStatusID;
    property objectType: Integer read FObjectType write FObjectType;
    property Mask: TgPersonMask read FMask write FMask;
    /// <summary>
    /// Персонаж - владелец планеты
    /// </summary>
    property IsOwner: Boolean read FIsOwner write FIsOwner;
    /// <summary>
    /// Персонаж - смотритель планеты
    /// </summary>
    property IsOperator: Boolean read FIsOperator write FIsOperator;
    /// <summary>
    /// Авторитет персонажа
    /// </summary>
    property Rating: Integer read FRating write FRating;
    /// <summary>
    /// Неизвестно.  Всегда False?
    /// </summary>
    property Award: Boolean read FAward write FAward;
    /// <summary>
    /// Положение перса на планете по оси Х
    /// </summary>
    property CoordX: Integer read FCoordX write FCoordX;
    /// <summary>
    /// Положение перса на планете по оси Y
    /// </summary>
    property CoordY: Integer read FCoordY write FCoordY;
    property Views: TObjectList<TgView> read FViews write FViews;
    // additionalView: null,
    // emotion: null,
    // __paramsCount: 0
    property Gender: Integer read FGender write FGender;
    property Teleport: TgTeleport read FTeleport write FTeleport;
  end;

  (*
    353 1 = Украина :Kharkov Утихомирил 13467292 -6 hb/417_ 0 -73 33 0 w/4862_2_ 0 0 33 0 w/2811_2_ 0 0 33 0 w/4314_2_ 0 0 33 0 w/b_0_2_0_ 0 0 33 0 @ 107 46 117 51 247286 - венбукет 20590602 -2 8983 0 0 33 0 @ 84 48 94 53 247224 СБУ Marsaram 22446067 -9 p/51_ 40 0 33 0 w/1288_0_ 0 0 33 0 hb/232_ 0 -62 33 0 w/5314_0_ 0 0 33 0 w/431_0_ 0 0 33 0 w/2331_0_ 0 0 33 0 w/b_0_0_0_ 0 0 33 0 w/4648_0_ 0 0 33 0 @ 111 52 121 57 250874

 *)
implementation

uses
  System.Math,
  System.SysUtils;

procedure TgPerson.AddView(const AName: string; AView: TgView);
var
  lView: TgView;
  lIndex: Integer;
begin
  AView.ID := AName;
  if TryFindView(AName, lView, lIndex) then
    FViews.Delete(lIndex);
  FViews.Add(AView);
  fViewsIsSorted := False;
end;

constructor TgPerson.Create;
begin
  inherited Create;
  FID := -1;
  FClan := '';
  FIsOwner := False;
  FIsOperator := False;
  FAward := False;
  FCoordX := -1;
  FCoordY := -1;

  FViews := TObjectList<TgView>.Create(GetComparer);
  FCrown := TgPersonCrown.Create;
  FStar := TgPersonCrown.Create;
  FMask := TgPersonMask.Create;
end;

destructor TgPerson.Destroy;
begin
  FreeAndNil(FStar);
  FreeAndNil(FViews);
  FreeAndNil(FCrown);
  FreeAndNil(FMask);
  inherited Destroy;
end;

function TgPerson.GetComparer: IComparer<TgView>;
begin
  Result := TComparer<TgView>.Construct(
    function(const Left, Right: TgView): Integer
    begin
      Result := Sign(Right.SortOrder - Left.SortOrder);
    end);
end;

procedure TgPerson.RemoveView(const AName: string);
var
  lView: TgView;
  lIndex: Integer;
begin
  if TryFindView(AName, lView, lIndex) then
  begin
    FViews.Delete(lIndex);
    fViewsIsSorted := False;
  end;
end;

function TgPerson.ToViewsArray: TArray<TgView>;
begin
  if not fViewsIsSorted then
  begin
    FViews.Sort(GetComparer);
    fViewsIsSorted := True;
  end;
  Result := FViews.ToArray;
end;

function TgPerson.TryFindView(const AName: string; var AView: TgView; var AIndex: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FViews.Count - 1 do
    if SameStr(FViews[i].ID, AName) then
    begin
      Result := True;
      AIndex := i;
      AView := FViews[i];
      Break;
    end;
end;

{ TgPersonMask }

constructor TgPersonMask.Create;
begin
  FAura := True;
  FSuit := True;
  FCrown := True;
  FOperator := True;
  FAward := True;
  FEmotion := True;
  FShit := True;
end;

end.
