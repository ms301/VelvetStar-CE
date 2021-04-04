unit VS.Modules.RecoverLoader;

interface

uses
  GMA.Model.Account,
  GSA.Client.Socket, System.SysUtils;

type
  IvsRecoverLoader = interface
    ['{081F9F1A-0B07-4433-9374-09D557ADF703}']
  end;

  TvsRecoverLoader = class(TInterfacedObject, IvsRecoverLoader)
  private
    FClient: IGalaxyClientSocket;
  public
    constructor Create(AAccount: TgAccount; AOnAccountReadyCallback: TProc<TgAccount>; AOnErrorCallback: TProc<string>);
  end;

implementation

uses
  GSA.Web, VS.Log;

constructor TvsRecoverLoader.Create(AAccount: TgAccount; AOnAccountReadyCallback: TProc<TgAccount>;
  AOnErrorCallback: TProc<string>);
begin
  FClient := TGalaxyClientSockeBuilder.Android;
  FClient.Account := AAccount;
  FClient.OnLogSocketMsg := procedure(ATime: TDateTime; ATag: string; AMsg: string)
    begin
      TgLog.SocketMsg(ATag, AMsg);
    end;
  FClient.ParserGroup.ParserLifeCycle.OnLoginCallback := procedure()
    begin
      TgWebRequest.RequestRecover(AAccount);
    end;
  FClient.ParserGroup.ParserMessages.OnShowDialogCallback := procedure(AValue: string; AVal: Boolean)
    begin
      raise Exception.Create(AValue);
    end;
  FClient.Start;
end;

end.
