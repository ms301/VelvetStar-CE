unit Galaxy.Model.Account;

interface

uses
  System.JSON.Serializers,
  System.JSON.Converters,
  System.Generics.Collections;

type
  TgAccount = record
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
    class function Create(const AID: Integer; const APassword, ANick: string): TgAccount; overload; static;
    class function Create(const ARecover: string): TgAccount; overload; static;
    class function Create(const AID: Integer; const APassword, ANick, ARecover: string): TgAccount; overload; static;
    function CanConnectByIdPass: Boolean;
    function CanConnectByRecover: Boolean;
    function CanConnectAny: Boolean;
    function IsEmpty: Boolean;
    function GetIdAsString: string;
    function GetPassAsString: string;
    class function Empty: TgAccount; static;

    procedure RemoveSignin;
    property Nick: string read FNick write FNick;
    property ID: Integer read FID write FID;
    property Password: string read FPassword write FPassword;
    property Recover: string read FRecover write FRecover;
    property Avatar: string read FAvatar write FAvatar;
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

class function TgAccount.Create(const AID: Integer; const APassword, ANick, ARecover: string): TgAccount;
begin
  Result.FID := AID;
  Result.FPassword := APassword;
  Result.FNick := ANick;
  Result.FRecover := ARecover;
end;

procedure TgAccount.RemoveSignin;
begin
  Password := string.Empty;
end;

class function TgAccount.Create(const AID: Integer; const APassword, ANick: string): TgAccount;
begin
  Result := TgAccount.Create(AID, APassword, ANick, '');
end;

class function TgAccount.Create(const ARecover: string): TgAccount;
begin
  Result := TgAccount.Create(0, '', '', ARecover);;
end;

class function TgAccount.Empty: TgAccount;
begin
  Result := TgAccount.Create(0, string.Empty, string.Empty, string.Empty);
end;

function TgAccount.GetIdAsString: string;
begin
  if FID > 0 then
    Result := FID.ToString
  else
    Result := 'NaN';
end;

function TgAccount.GetPassAsString: string;
begin
  if FPassword.IsEmpty then
    Result := 'null'
  else
    Result := FPassword;
end;

function TgAccount.IsEmpty: Boolean;
begin
  Result := not CanConnectAny;
end;

end.
