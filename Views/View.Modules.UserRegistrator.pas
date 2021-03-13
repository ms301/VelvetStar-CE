﻿unit View.Modules.UserRegistrator;

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
    Rectangle1: TRectangle;
    ShadowEffect3: TShadowEffect;
    Grid1: TGrid;
    StringColumn1: TStringColumn;
    StringColumn2: TStringColumn;
    StringColumn3: TStringColumn;
    Layout2: TLayout;
    btnSavePersons: TButton;
    Layout3: TLayout;
    btnRegister: TButton;
    StringColumn4: TStringColumn;
    procedure btnRegisterClick(Sender: TObject);
    procedure btnSavePersonsClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
    procedure Grid1Resized(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
  private
    { Private declarations }
    FUserList: TgAccounts;
  public
    { Public declarations }
    procedure UpdateData;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AutoHeight;
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

procedure TViewModulesUserRegistrator.AutoHeight;
begin
  rctHeader.Height := rctHeader.RecomendHeight;
  FlowLayout1.Height := FlowLayout1.RecomendHeight;
  rctBody.Height := rctBody.RecomendHeight;
  Self.Height := Self.RecomendHeight;
end;

procedure TViewModulesUserRegistrator.btnRegisterClick(Sender: TObject);
var
  lNick: string;
  lHead, lBody: Integer;
  lIsMan: Boolean;
  lThread: TThread;
begin
  lNick := edtNick.TextOrPromt;
  lHead := edtHead.TextOrPromt.ToInteger;
  lBody := edtBody.TextOrPromt.ToInteger;
  lIsMan := not Switch1.IsChecked;
  lThread := TThread.CreateAnonymousThread(
    procedure
    var
      lAccout: TgAccount;
    begin
      lAccout := TgWebRequest.RegUser(lNick, lHead, lBody, lIsMan);
      TThread.Synchronize(nil,
        procedure
        begin
          FUserList.Add(lAccout);
          UpdateData;
        end);
    end);
  lThread.FreeOnTerminate := True;
  lThread.Start;
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

procedure TViewModulesUserRegistrator.FrameResize(Sender: TObject);
begin
  AutoHeight;
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

procedure TViewModulesUserRegistrator.Grid1Resized(Sender: TObject);
var
  lWidth: single;
begin
  lWidth := Grid1.Width / Grid1.ColumnCount;
  StringColumn1.Width := lWidth;
  StringColumn2.Width := lWidth;
  StringColumn3.Width := lWidth;
  StringColumn4.Width := lWidth;
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
  Grid1.RowCount := FUserList.Count;
end;

end.
