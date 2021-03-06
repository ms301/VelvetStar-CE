unit Galaxy.Model.Account;

interface

uses
  System.JSON.Serializers,
  System.JSON.Converters,
  System.Generics.Collections;

type
  TgAccount = class
  private
    [JsonName('Nick')]
    FNick: string;
    [JsonName('ID')]
    FID: Integer;
    [JsonName('Password')]
    FPassword: string;
    [JsonName('Recover')]
    FRecover: string;
    [JsonName('Avatar')]
    FAvatar: string;
  public
    constructor Create(const AID: Integer; const APassword, ANick: string); overload;
    constructor Create(const ARecover: string); overload;
    constructor Create(const AID: Integer; const APassword, ANick, ARecover: string); overload;
    function CanConnectByIdPass: Boolean;
    function CanConnectByRecover: Boolean;
    function CanConnectAny: Boolean;
    procedure RemoveSignin;
    property Nick: string read FNick write FNick;
    property ID: Integer read FID write FID;
    property Password: string read FPassword write FPassword;
    property Recover: string read FRecover write FRecover;
    property Avatar: string read FAvatar write FAvatar;
  end;

  TgAccounts = class
  private type
    TListMyAddonsConverter = class(TJsonListConverter<TgAccount>);
  private
    [JsonName('CurrentID')]
    FCurrentID: Integer;
    [JsonName('Items')]
    [JsonConverter(TListMyAddonsConverter)]
    FItems: TObjectList<TgAccount>;
  protected
  public
    function Current: TgAccount;
    constructor Create;
    destructor Destroy; override;
    procedure AddOrSet(Account: TgAccount);
    function Contains(Account: TgAccount): Integer;
    property Items: TObjectList<TgAccount> read FItems;
    property CurrentID: Integer read FCurrentID write FCurrentID;
  end;

implementation

uses
  System.SysUtils,
  System.UITypes;

{ TgAccount }

function TgAccount.CanConnectAny: Boolean;
begin
  Result := CanConnectByIdPass or CanConnectByRecover;
end;

function TgAccount.CanConnectByIdPass: Boolean;
begin
  Result := not(Nick.IsEmpty or (ID <= 0) or Password.IsEmpty);
end;

function TgAccount.CanConnectByRecover: Boolean;
begin
  Result := not Recover.IsEmpty;
end;

constructor TgAccount.Create(const AID: Integer; const APassword, ANick, ARecover: string);
begin
  FID := AID;
  FPassword := APassword;
  FNick := ANick;
  FRecover := ARecover;
end;

procedure TgAccount.RemoveSignin;
begin
  Password := string.Empty;
end;

constructor TgAccount.Create(const AID: Integer; const APassword, ANick: string);
begin
  Create(AID, APassword, ANick, '');
end;

constructor TgAccount.Create(const ARecover: string);
begin
  Create(0, '', '', ARecover);;
end;

{ TgAccounts }

procedure TgAccounts.AddOrSet(Account: TgAccount);
var
  LPos: Integer;
begin
  LPos := Contains(Account);
  if LPos > -1 then
    FItems[LPos] := Account
  else
    FItems.Add(Account);
end;

function TgAccounts.Contains(Account: TgAccount): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do
    if FItems[I].ID = Account.ID then
      Exit(I);
end;

constructor TgAccounts.Create;
begin
  inherited Create();
  FItems := TObjectList<TgAccount>.Create;
  FCurrentID := -1;
end;

function TgAccounts.Current: TgAccount;
begin
  Result := FItems[FCurrentID];
end;

destructor TgAccounts.Destroy;
begin
  FItems.Free;
  inherited;
end;

end.
