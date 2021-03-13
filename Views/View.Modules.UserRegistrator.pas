unit View.Modules.UserRegistrator;

interface

uses
{$REGION 'ViewNavigator'}
  ViewNavigator,
  VN.Attributes,
{$ENDREGION}
{$REGION 'Galaxy'}
  Galaxy.Model.Account,
  Galaxy.Model.Accounts,
{$ENDREGION}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Effects, FMX.Objects, FMX.Edit,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox,
  System.Generics.Collections;

type

  [vnName('ViewModulesUserRegistrator')]
  [vnLifeCycle(TvnLifeCycle.OnShowHide)]
  TViewModulesUserRegistrator = class(TFrame)
    Label1: TLabel;
    Layout1: TLayout;
    Label2: TLabel;
    rctHeader: TRectangle;
    Label3: TLabel;
    Label4: TLabel;
    ShadowEffect1: TShadowEffect;
    rctBody: TRectangle;
    ShadowEffect2: TShadowEffect;
    FlowLayout1: TFlowLayout;
    lytHead: TLayout;
    lytNick: TLayout;
    Label5: TLabel;
    edtNick: TEdit;
    Label6: TLabel;
    edtHead: TEdit;
    lytBody: TLayout;
    edtBody: TEdit;
    Label7: TLabel;
    lytSex: TLayout;
    Layout6: TLayout;
    Switch1: TSwitch;
    Label8: TLabel;
    Label9: TLabel;
    btnRegister: TButton;
    Rectangle1: TRectangle;
    ShadowEffect3: TShadowEffect;
    Grid1: TGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    Layout2: TLayout;
    btnSavePersons: TButton;
    procedure btnRegisterClick(Sender: TObject);
    procedure btnSavePersonsClick(Sender: TObject);
    procedure FlowLayout1Resized(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
    procedure rctHeaderResized(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
  private
    { Private declarations }
    FUserList: TgAccounts;
  public
    { Public declarations }
    procedure UpdateData;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  Galaxy.Web,
  FluentUI.Helpers.TControl,
  GMA.Tools.NickGenerator;
{$R *.fmx}

constructor TViewModulesUserRegistrator.Create(AOwner: TComponent);
begin
  inherited;

  FUserList := TgAccounts.Create;
  UpdateData;
end;

destructor TViewModulesUserRegistrator.Destroy;
begin
  FUserList.Free;
  inherited;
end;

procedure TViewModulesUserRegistrator.btnRegisterClick(Sender: TObject);
var
  lNick: string;
  lHead, lBody: Integer;
  lIsMan: Boolean;
  lAccout: TgAccount;
begin
  lNick := edtNick.TextOrPromt;
  lHead := edtHead.TextOrPromt.ToInteger;
  lBody := edtBody.TextOrPromt.ToInteger;
  lIsMan := not Switch1.IsChecked;
  lAccout := TgWebRequest.RegUser(lNick, lHead, lBody, lIsMan);
  FUserList.Add(lAccout);
  UpdateData;
end;

procedure TViewModulesUserRegistrator.btnSavePersonsClick(Sender: TObject);
var
  LSaveDialog: TSaveDialog;
begin
  LSaveDialog := TSaveDialog.Create(nil);
  try
    LSaveDialog.FileName := 'Galaxy Account List';
    LSaveDialog.Filter := 'JSON|*.json';
    LSaveDialog.DefaultExt := '*.json';
    if LSaveDialog.Execute then
      FUserList.SaveToFile(LSaveDialog.FileName);
  finally
    LSaveDialog.Free;
  end;
end;

procedure TViewModulesUserRegistrator.FlowLayout1Resized(Sender: TObject);
begin
  rctBody.Height := FlowLayout1.RecomendHeightForParent;
end;

procedure TViewModulesUserRegistrator.FrameResize(Sender: TObject);
begin
  Self.Height := Self.RecomendHeight;
end;

procedure TViewModulesUserRegistrator.Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
begin
  case ACol of
    0:
      begin
        Value := FUserList[ARow].Nick;
      end;
    1:
      begin
        Value := FUserList[ARow].ID;
      end;
    2:
      begin
        Value := FUserList[ARow].Password;
      end;
  end;
end;

procedure TViewModulesUserRegistrator.rctHeaderResized(Sender: TObject);
begin
  rctHeader.Height := rctHeader.RecomendHeight;
end;

procedure TViewModulesUserRegistrator.Switch1Switch(Sender: TObject);
begin
  if Switch1.IsChecked then
    Label8.Text := 'Женский'
  else
    Label8.Text := 'Мужской';
end;

procedure TViewModulesUserRegistrator.UpdateData;
begin
  edtNick.TextPrompt := TgNickGenerator.OldNick(10).GenerateNick;
  Self.Height := Self.RecomendHeight;
  Grid1.RowCount := FUserList.Count;
end;

end.
