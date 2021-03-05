unit View.Host;

interface

uses
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Layouts,
  FMX.Controls.Presentation,
  FMX.StdCtrls,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  ViewNavigator,
  FMX.Edit;

type
  TViewHost = class(TForm)
    lytContent: TLayout;
    Layout2: TLayout;
    FluentStyleBook: TStyleBook;
    StyleBook2: TStyleBook;
    ToolBar1: TToolBar;
    btnViewClientAuth: TSpeedButton;
    btnViewClientChat: TSpeedButton;
    btnViewModules: TSpeedButton;
    btnViewAbout: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DoButtonNavigateClicked(Sender: TObject);
  private
    { Private declarations }
    FViewManager: TViewNavigator;
    procedure RegisterViews(AViews: TArray<TvnControlClass>);

  public
    { Public declarations }
  end;

var
  ViewHost: TViewHost;

implementation

uses
  View.Auth,
  View.Modules,
  View.About;
{$R *.fmx}

procedure TViewHost.DoButtonNavigateClicked(Sender: TObject);
var
  lViewName: string;
begin
  lViewName := string((Sender as TSpeedButton).Name).Substring(3);
  FViewManager.Navigate(lViewName);
end;

procedure TViewHost.FormCreate(Sender: TObject);
begin

  FViewManager := TViewNavigator.Create;
  FViewManager.Parent := lytContent;
  RegisterViews([ //
    TViewClientAuth //
    , TViewModules //
    , TViewAbout //
    ]);

  DoButtonNavigateClicked(btnViewClientAuth);
  btnViewClientAuth.SetFocus;
end;

procedure TViewHost.FormDestroy(Sender: TObject);
begin
  FViewManager.Free;
end;

procedure TViewHost.RegisterViews(AViews: TArray<TvnControlClass>);
var
  i: Integer;
begin
  for i := Low(AViews) to High(AViews) do
    FViewManager.Store.AddView(AViews[i]);
end;

end.
