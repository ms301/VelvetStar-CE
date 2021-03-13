unit GMA.Model.Message;

interface

type
  TgMessage = class
  private
    FID: string;
    FStyle: string;
    FText: string;
    FTime: TTime;
    FMy: Boolean;
    FAddressMe: Boolean;
    FServer: Boolean;
    FAdvertisement: Boolean;
    FUserID: Integer;
    FObjectID: Integer;
    FTargetUserID: Integer;
    FType: string;
    FHasTitle: Boolean;
    FTopic: Boolean;
  public
    constructor Create; overload;
    constructor Create(const AMessage: string); overload;
    class function CreateUserSleep(const ANick: string): TgMessage;
    class function CreateUserPart(const ANick: string): TgMessage;
    class function CreateUserJoin(const ANick: string): TgMessage;
    property ID: string read FID write FID;
    property Style: string read FStyle write FStyle;
    property Text: string read FText write FText;
    property Time: TTime read FTime write FTime;
    property My: Boolean read FMy write FMy;
    property AddressMe: Boolean read FAddressMe write FAddressMe;
    property Server: Boolean read FServer write FServer;
    property Advertisement: Boolean read FAdvertisement write FAdvertisement;
    property UserID: Integer read FUserID write FUserID;
    property ObjectID: Integer read FObjectID write FObjectID;
    property TargetUserID: Integer read FTargetUserID write FTargetUserID;
    property &Type: string read FType write FType;
    property HasTitle: Boolean read FHasTitle write FHasTitle;
    property Topic: Boolean read FTopic write FTopic;
  end;

implementation

uses
  System.SysUtils;
{ TgMessage }

constructor TgMessage.Create;
begin
  FTime := Now;
  FID := TimeToStr(FTime);
end;

constructor TgMessage.Create(const AMessage: string);
begin
  Self.Create;
  FText := AMessage;
end;

class function TgMessage.CreateUserJoin(const ANick: string): TgMessage;
begin
  Result := TgMessage.Create('Пользователь прилетел: ' + ANick);
end;

class function TgMessage.CreateUserPart(const ANick: string): TgMessage;
begin
  Result := TgMessage.Create('Пользователь уснул: ' + ANick);
end;

class function TgMessage.CreateUserSleep(const ANick: string): TgMessage;
begin
  Result := TgMessage.Create('Пользователь улетел: ' + ANick);
end;

end.
