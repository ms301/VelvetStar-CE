unit VS.Log;

interface

uses
  System.Generics.Collections, System.SysUtils;

type
  TLogSocketItem = record
  private
    FTime: TDateTime;
    FTag: string;
    FMessage: string;
  public
    class function Create(const ATime: TDateTime; const ATag, AMessage: string): TLogSocketItem; static;
    property Time: TDateTime read FTime write FTime;
    property Tag: string read FTag write FTag;
    property Message: string read FMessage write FMessage;
  end;

  TgLog = class
  private
    class var FLogSocket: TList<TLogSocketItem>;
    class var FOnLogSocketCallback: TProc<TLogSocketItem>;
  public
    class constructor Create;
    class destructor Destroy;
    class procedure SocketMsg(const ATag, AMsg: string);
    class property LogSocket: TList<TLogSocketItem> read FLogSocket;
    class property OnLogSocketCallback: TProc<TLogSocketItem> read FOnLogSocketCallback write FOnLogSocketCallback;
  end;

implementation

class constructor TgLog.Create;
begin
  FLogSocket := TList<TLogSocketItem>.Create;
end;

class destructor TgLog.Destroy;
begin
  FLogSocket.Free;
end;

class procedure TgLog.SocketMsg(const ATag, AMsg: string);
begin
  FLogSocket.Add(TLogSocketItem.Create(Now, ATag, AMsg));
  if Assigned(FOnLogSocketCallback) then
    FOnLogSocketCallback(FLogSocket.Last);
end;

{ TLogItem }

class function TLogSocketItem.Create(const ATime: TDateTime; const ATag, AMessage: string): TLogSocketItem;
begin
  Result.FTime := ATime;
  Result.FTag := ATag;
  Result.FMessage := AMessage
end;

end.
