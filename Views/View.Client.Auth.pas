unit View.Client.Auth;

interface

uses
{$REGION 'Galaxy'}
  Galaxy.AccountsViewer,
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
  FMX.Layouts, FMX.Edit;

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
    Label2: TLabel;
    Edit1: TEdit;
    procedure Button3Click(Sender: TObject);

  private
    { Private declarations }
    FAccounts: TgAccountViewerCustom;

    procedure SetupAccountsViewer(AAccounts: TgAccountViewerCustom);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }

  end;

implementation

{$R *.fmx}
{ TViewClientAuth }

constructor TViewClientAuth.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAccounts := TgAccountViewerCustom.Create(nil);
  SetupAccountsViewer(FAccounts);

end;

destructor TViewClientAuth.Destroy;
begin
  FreeAndNil(FAccounts);
  inherited Destroy;
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
  lRecoverDialog.SetContent(Edit1);
  lRecoverDialog.Show(
    procedure(AText: string)
    begin
      Label2.Text := AText + (lRecoverDialog.Content as TEdit).Text;
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
