unit View.Modules.UserRegistrator;

interface

uses
{$REGION 'ViewNavigator'}
  ViewNavigator,
  VN.Attributes,
{$ENDREGION}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Effects, FMX.Objects, FMX.Edit;

type

  [vnName('ViewModulesUserRegistrator')]
  [vnLifeCycle(TvnLifeCycle.OnShowHide)]
  TViewModulesUserRegistrator = class(TFrame)
    Label1: TLabel;
    Layout1: TLayout;
    Layout2: TLayout;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Label3: TLabel;
    Label4: TLabel;
    ShadowEffect1: TShadowEffect;
    Rectangle2: TRectangle;
    ShadowEffect2: TShadowEffect;
    VertScrollBox1: TVertScrollBox;
    GridPanelLayout1: TGridPanelLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Label5: TLabel;
    Edit1: TEdit;
    Label6: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label7: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
