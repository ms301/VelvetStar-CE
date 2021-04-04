unit View.Log.Socket;

interface

uses
{$REGION 'ViewNavigator'}
  ViewNavigator,
  VN.Attributes,
{$ENDREGION}
  VS.Log,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox,
  FMX.Controls.Presentation, System.Generics.Collections;

type

  [vnName('ViewLogSocket')]
  [vnLifeCycle(TvnLifeCycle.OnCreateDestroy)]
  TViewLogSocket = class(TFrame)
    grpLogView: TGroupBox;
    Grid1: TGrid;
    TimeColumn1: TTimeColumn;
    StringColumn2: TStringColumn;
    StringColumn1: TStringColumn;
    procedure Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
    procedure Grid1Resized(Sender: TObject);
  private
    { Private declarations }
    procedure OnLog(AItem: TLogSocketItem);
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
    procedure UpdateLogSocket;
  end;

implementation

{$R *.fmx}
{ TViewLogSocket }

constructor TViewLogSocket.Create(AOwner: TComponent);
begin
  inherited;
  TgLog.OnLogSocketCallback := OnLog;
  UpdateLogSocket;
end;

destructor TViewLogSocket.Destroy;
begin
  TgLog.OnLogSocketCallback := nil;
  inherited;
end;

procedure TViewLogSocket.Grid1GetValue(Sender: TObject; const ACol, ARow: Integer; var Value: TValue);
begin
  case ACol of
    0:
      begin
        Value := TgLog.LogSocket[ARow].Time;
      end;
    1:
      begin
        Value := TgLog.LogSocket[ARow].Tag;
      end;
    2:
      begin
        Value := TgLog.LogSocket[ARow].Message;
      end;
  end;
end;

procedure TViewLogSocket.Grid1Resized(Sender: TObject);
begin
  StringColumn1.Width := Grid1.Size.Width - StringColumn2.Size.Width - TimeColumn1.Size.Width - 25;
end;

procedure TViewLogSocket.OnLog(AItem: TLogSocketItem);
begin
  UpdateLogSocket;
end;

procedure TViewLogSocket.UpdateLogSocket;
begin
  Grid1.RowCount := 0;
  Grid1.RowCount := TgLog.LogSocket.Count;
end;

end.
