unit GMA.Component.AccountsViewer;

interface

uses
  GMA.Model.Account,
  FMX.Types,
  System.Generics.Collections, System.Classes, FMX.Controls, System.Types,
  System.UITypes, System.SysUtils, FMX.Graphics;

type
  TgAccountViewerCustom = class(TControl)
  private
    FItems: TList<TgAccount>;
    FItemWidth: Single;
    FOnClick: TProc<TgAccount>;
    FOnDelete: TProc<TgAccount>;
    FCurrentMousePoint: TPointF;
    FFlashedItem: Integer;
  protected
    function CalcRectBorder(const AIndex: Integer): TRectF;
    function CalcRectNick(const AIndex: Integer): TRectF;
    procedure DrawItemBorder(const AIndex: Integer);
    procedure DrawItemNick(const AIndex: Integer);
    function CalcRectClose(const AIndex: Integer): TRectF;
    procedure DrawClose(const AIndex: Integer);
    function CalcRectAvatar(const AIndex: Integer): TRectF;
    procedure DrawAvatar(const AIndex: Integer);
    procedure Paint; override;
    procedure DrawItem(const AIndex: Integer);
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure DoOnClick(AAccount: TgAccount);
    procedure DoOnDelete(AAccount: TgAccount);
    procedure MousePosition(X, Y: Single);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Items: TList<TgAccount> read FItems;
    property ItemWidth: Single read FItemWidth write FItemWidth;
    property OnClick: TProc<TgAccount> read FOnClick write FOnClick;
    property OnDelete: TProc<TgAccount> read FOnDelete write FOnDelete;
  end;

  TgAccountViewer = class(TgAccountViewerCustom)
  published
    property PopupMenu;
    property OnDelete;
    property OnClick;
    property ItemWidth;
    property Items;
    property Align;
  end;

implementation

{ TgAccountViewer }

constructor TgAccountViewerCustom.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TList<TgAccount>.Create;
  FItemWidth := 100;
  if csDesigning in ComponentState then
    FItems.Add(TgAccount.Create(9999999, 'qwerty1234', 'RareMax', 'MySuperPassword'));
end;

destructor TgAccountViewerCustom.Destroy;
begin
  FItems.Free;
  inherited Destroy;
end;

procedure TgAccountViewerCustom.DoOnClick(AAccount: TgAccount);
begin
  if Assigned(OnClick) then
    OnClick(AAccount);
end;

procedure TgAccountViewerCustom.DoOnDelete(AAccount: TgAccount);
begin
  if Assigned(OnDelete) then
    OnDelete(AAccount);
end;

procedure TgAccountViewerCustom.DrawItem(const AIndex: Integer);
begin
  DrawItemBorder(AIndex);
  DrawItemNick(AIndex);
  DrawAvatar(AIndex);
  if CalcRectBorder(AIndex).Contains(FCurrentMousePoint) then
    DrawClose(AIndex);
end;

procedure TgAccountViewerCustom.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  I: Integer;
  FMousePos: TPointF;
begin
  inherited;
  FMousePos := TPointF.Create(X, Y);
  for I := 0 to FItems.Count - 1 do
  begin
    if not CalcRectBorder(I).Contains(FMousePos) then
      Continue;
    if CalcRectClose(I).Contains(FMousePos) then
      DoOnDelete(FItems[I])
    else
      DoOnClick(FItems[I]);
  end;
end;

procedure TgAccountViewerCustom.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;
  MousePosition(X, Y);
end;

procedure TgAccountViewerCustom.Paint;
var
  I: Integer;
begin
  inherited Paint;
  Canvas.Stroke.Color := TAlphaColorRec.Bisque;
  Canvas.DrawRect(ClipRect, 0, 0, [], 1);
  for I := 0 to FItems.Count - 1 do
    DrawItem(I);
end;

{ TgAccountItemViewInfo }

function TgAccountViewerCustom.CalcRectAvatar(const AIndex: Integer): TRectF;
begin
  Result := CalcRectBorder(AIndex);
  Result.Width := 64;
  Result.Height := 64;
  Result.Offset(CalcRectBorder(AIndex).Width / 2 - Result.Width / 2, 4);
  // Result.Left := Result.Width / 2 - Result.Offset(0, Result.Height / 3);
end;

function TgAccountViewerCustom.CalcRectBorder(const AIndex: Integer): TRectF;
begin
  Result := ClipRect;
  Result.Width := ItemWidth;
  Result := Padding.PaddingRect(Result);
  Result.Offset((Result.Width + 5) * AIndex, 0);
end;

function TgAccountViewerCustom.CalcRectClose(const AIndex: Integer): TRectF;
var
  LBordRec: TRectF;
begin
  LBordRec := CalcRectBorder(AIndex);
  Result := TRectF.Create(LBordRec.TopLeft, 32, 32);
  Result.Offset(LBordRec.Width - 32 - 2, -2);
end;

function TgAccountViewerCustom.CalcRectNick(const AIndex: Integer): TRectF;
begin
  Result := CalcRectBorder(AIndex);
  Result.Top := Result.Bottom - Result.Height / 3;
end;

procedure TgAccountViewerCustom.DrawAvatar(const AIndex: Integer);
var
  LBorder: TRectF;
begin
  if not FileExists(FItems[AIndex].Avatar) then
    Exit;
  LBorder := CalcRectAvatar(AIndex);
  Canvas.Fill.Kind := TBrushKind.Bitmap;
  Canvas.Fill.Bitmap.WrapMode := TWrapMode.TileStretch;
  Canvas.Fill.Bitmap.Bitmap.LoadFromFile(FItems[AIndex].Avatar);
  Canvas.FillEllipse(LBorder, 1);
end;

procedure TgAccountViewerCustom.DrawItemBorder(const AIndex: Integer);
var
  LBorder: TRectF;
begin
  { Рисуем фон }
  LBorder := CalcRectBorder(AIndex);
  Canvas.Fill.Color := $0F000000;
  Canvas.FillRect(LBorder, 4, 4, [TCorner.TopLeft .. TCorner.BottomRight], 1);
end;

procedure TgAccountViewerCustom.DrawItemNick(const AIndex: Integer);
var
  LNickRect: TRectF;
begin
  { Рисуем ник }
  LNickRect := CalcRectNick(AIndex);
  Canvas.Fill.Color := $DE000000;
  Canvas.Font.Size := 14;
  Canvas.Font.Family := 'Roboto';
  Canvas.FillText(LNickRect, Items[AIndex].Nick, False, 1, [], TTextAlign.Center);
end;

procedure TgAccountViewerCustom.DrawClose(const AIndex: Integer);
var
  LCloseRect: TRectF;
begin
  { Рисуем ник }
  LCloseRect := CalcRectClose(AIndex);
  Canvas.Fill.Color := $8A000000;
  Canvas.Font.Size := 14;
  Canvas.Font.Family := 'Arial';
  Canvas.FillRect(LCloseRect, 2, 2, [], 0.1);
  Canvas.FillText(LCloseRect, 'x', False, 1, [], TTextAlign.Center);
end;

procedure TgAccountViewerCustom.MousePosition(X, Y: Single);
var
  I: Integer;
begin
  FCurrentMousePoint := TPointF.Create(X, Y);
  for I := 0 to Items.Count - 1 do
    if CalcRectBorder(I).Contains(FCurrentMousePoint) then
    begin
      if FFlashedItem <> I then
        Repaint;
      FFlashedItem := I;
    end
    else if I = FFlashedItem then
    begin
      FFlashedItem := -1;
      Repaint;
    end;
end;

end.
