unit View.Client.Auth;

interface

uses
{$REGION 'ViewNavigator'}
  ViewNavigator,
  VN.Attributes,
{$ENDREGION}
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects;

type

  [vnName('ViewClientAuth')]
  [vnLifeCycle(TvnLifeCycle.OnShowHide)]
  TViewClientAuth = class(TFrame)
    Button1: TButton;
    Rectangle1: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
