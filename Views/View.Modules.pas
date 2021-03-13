unit View.Modules;

interface

uses
{$REGION 'ViewNavigator'}
  ViewNavigator,
  VN.Attributes,
{$ENDREGION}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Controls.Presentation;

type

  [vnName('ViewModules')]
  [vnLifeCycle(TvnLifeCycle.OnShowHide)]
  TViewModules = class(TFrame)
    ListBox1: TListBox;
    GroupBox1: TGroupBox;
    lbViewModulesUserRegistrator: TListBoxItem;
    ScrollBox1: TScrollBox;
    procedure DoModuleNavigateClicked(const Sender: TCustomListBox; const Item: TListBoxItem);
  private
    { Private declarations }
    FViewManager: TViewNavigator;
  public
    procedure RegisterViews(AViews: TArray<TvnControlClass>);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }

  end;

implementation

uses
  View.Modules.UserRegistrator;
{$R *.fmx}
{ TViewModules }

constructor TViewModules.Create(AOwner: TComponent);
begin
  inherited;
  FViewManager := TViewNavigator.Create;
  FViewManager.Parent := ScrollBox1;
  RegisterViews([ //
    TViewModulesUserRegistrator //
    // , TViewModules //
    ]);

  // DoButtonNavigateClicked(btnViewClientAuth);
  // btnViewClientAuth.SetFocus;
end;

destructor TViewModules.Destroy;
begin
  FViewManager.Free;
  inherited;
end;

procedure TViewModules.DoModuleNavigateClicked(const Sender: TCustomListBox; const Item: TListBoxItem);
var
  lViewName: string;
begin
  lViewName := string(Item.Name).Substring(2);
  FViewManager.Navigate(lViewName);
end;

procedure TViewModules.RegisterViews(AViews: TArray<TvnControlClass>);
var
  i: Integer;
begin
  for i := Low(AViews) to High(AViews) do
    FViewManager.Store.AddView(AViews[i]);
end;

end.
