unit View.Log;

interface

uses
{$REGION 'ViewNavigator'}
  ViewNavigator,
  VN.Attributes,
{$ENDREGION}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts;

type

  [vnName('ViewLogs')]
  [vnLifeCycle(TvnLifeCycle.OnShowHide)]
  TViewLog = class(TFrame)
    Layout1: TLayout;
    Label1: TLabel;
    Label2: TLabel;
    ToolBar1: TToolBar;
    btnViewLogSocket: TSpeedButton;
    btnViewClientChat: TSpeedButton;
    btnViewModules: TSpeedButton;
    btnViewAbout: TSpeedButton;
    btnViewLogs: TSpeedButton;
    lytContent: TLayout;
    procedure DoButtonNavigateClicked(Sender: TObject);
  private
    { Private declarations }
    FViewManager: TViewNavigator;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RegisterViews(AViews: TArray<TvnControlClass>);
    { Public declarations }

  end;

implementation

{$R *.fmx}

uses
  View.Log.Socket;

{ TViewLog }

constructor TViewLog.Create(AOwner: TComponent);
begin
  inherited;
  FViewManager := TViewNavigator.Create;
  FViewManager.Parent := lytContent;
  RegisterViews([ //
    TViewLogSocket //
// , TViewModules //
// , TViewLog //
// , TViewAbout //
    ]);

  DoButtonNavigateClicked(btnViewLogSocket);
  btnViewLogSocket.SetFocus;
end;

destructor TViewLog.Destroy;
begin
  FViewManager.Free;
  inherited;
end;

procedure TViewLog.DoButtonNavigateClicked(Sender: TObject);
var
  lViewName: string;
begin
  lViewName := string((Sender as TSpeedButton).Name).Substring(3);
  FViewManager.Navigate(lViewName);
end;

procedure TViewLog.RegisterViews(AViews: TArray<TvnControlClass>);
var
  i: Integer;
begin
  for i := Low(AViews) to High(AViews) do
    FViewManager.Store.AddView(AViews[i]);
end;

end.
