unit View.Auth;

interface

uses
{$REGION 'Galaxy'}
  GMA.Component.AccountsViewer,
{$ENDREGION}
{$REGION 'ViewNavigator'}
  ViewNavigator,
  VN.Attributes,
{$ENDREGION}
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Generics.Collections,

  FluentUI.Dialog,

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.Layouts, FMX.Edit, GSA.Client.Socket;

type

  [vnName('ViewClientAuth')]
  [vnLifeCycle(TvnLifeCycle.OnShowHide)]
  TViewClientAuth = class(TFrame)
    Image1: TImage;
    Layout3: TLayout;
    Button2: TButton;
    Layout4: TLayout;
    Button3: TButton;
    hsbAccounts: THorzScrollBox;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
    FAccounts: TgAccountViewerCustom;
    FRecoverEdt: TEdit;

  var
    lCli: IGalaxyClientSocket;
    procedure SetupAccountsViewer(AAccounts: TgAccountViewerCustom);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }

  end;

implementation

uses
  GMA.Model.Account;

{$R *.fmx}
{ TViewClientAuth }

constructor TViewClientAuth.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAccounts := TgAccountViewerCustom.Create(nil);
  SetupAccountsViewer(FAccounts);
  FRecoverEdt := TEdit.Create(Self);
end;

destructor TViewClientAuth.Destroy;
begin
  FreeAndNil(FAccounts);
  inherited Destroy;
end;

procedure TViewClientAuth.Button2Click(Sender: TObject);
begin
  lCli := TGalaxyClientSockeBuilder.Android;
  lCli.Account := TgAccount.Create(59841643, 'g3hggyh1bd', 'g562071787');
  lCli.Start;
end;

procedure TViewClientAuth.Button3Click(Sender: TObject);
var
  lRecoverDialog: IFluentDialogUserContent;
begin
  lRecoverDialog := TFluentDialogUserContent.Create(Self);
  lRecoverDialog.Title := 'Восстановление персонажа';
  lRecoverDialog.SubTitle := 'Введите код восстановления персонажа';
  lRecoverDialog.PrimatyButtonText := 'Готово';
  lRecoverDialog.DefaultButtonText := 'Отмена';
  lRecoverDialog.Height := 200;
  lRecoverDialog.SetContent(FRecoverEdt);
  lRecoverDialog.Show(
    procedure(AText: string)
    begin

    end);
end;

procedure TViewClientAuth.SetupAccountsViewer(AAccounts: TgAccountViewerCustom);
begin
  AAccounts.BeginUpdate;
  try
    AAccounts.Align := TAlignLayout.Client;
    AAccounts.Parent := hsbAccounts;
  finally
    AAccounts.EndUpdate;
  end;
end;

end.
