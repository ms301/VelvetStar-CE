unit View.Host;

interface

uses
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,

  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  ViewNavigator, FMX.Layouts;

type
  TViewHost = class(TForm)
    lytContent: TLayout;
    Layout2: TLayout;
    StyleBook1: TStyleBook;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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
  View.Client.Auth;
{$R *.fmx}

procedure TViewHost.FormCreate(Sender: TObject);
begin
  FViewManager := TViewNavigator.Create;
  FViewManager.Parent := lytContent;
  RegisterViews([TViewClientAuth]);
  FViewManager.Navigate('ViewClientAuth');
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
