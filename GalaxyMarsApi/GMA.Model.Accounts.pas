unit GMA.Model.Accounts;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Json.Serializers,
  GMA.Model.Account;

type
  TgAccounts = class(TList<TgAccount>)
  private
    FSerializer: TJsonSerializer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveToFile(const AFilename: string);
    procedure LoadFromFile(const AFilename: string);
  end;

implementation

uses
  System.Json.Types,
  System.IOUtils;

constructor TgAccounts.Create;
begin
  inherited Create;
  FSerializer := TJsonSerializer.Create;
  FSerializer.Formatting := TJsonFormatting.Indented;
end;

destructor TgAccounts.Destroy;
begin
  FSerializer.Free;
  inherited Destroy;
end;

{ TgAcccountList }

procedure TgAccounts.LoadFromFile(const AFilename: string);
var
  LFile: string;
begin
  LFile := TFile.ReadAllText(AFilename, TEncoding.UTF8);
  Self.AddRange(FSerializer.Deserialize < TArray < TgAccount >> (LFile));
end;

procedure TgAccounts.SaveToFile(const AFilename: string);
var
  LFile: string;
begin
  LFile := FSerializer.Serialize < TArray < TgAccount >> (Self.ToArray);
  TFile.WriteAllText(AFilename, LFile, TEncoding.UTF8);
end;

end.
