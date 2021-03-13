unit GMA.Core.Tools;

interface

uses
  System.Generics.Collections;

type
  TArray = class(System.Generics.Collections.TArray)
    class function Slice<T>(AData: TArray<T>; ABegin: Integer; AEnd: Integer): TArray<T>;
    class procedure Add<T>(AData: TArray<T>; AElement: T);
  end;

  TDonor = class
    class function AorB(A, B: Integer): Integer; overload;
  end;

  TJson = class
    class function Serialize<T>(Data: T): string;
    class function Deserialize<T>(Data: string): T;
    class procedure Save<T>(AData: T; AFileName: string);
    class function Load<T>(AFileName: string): T;
  end;

implementation

uses
  System.JSON.Serializers,
  System.IOUtils,
  System.SysUtils;

{ TArray }

class procedure TArray.Add<T>(AData: TArray<T>; AElement: T);
var
  lIndx: Integer;
begin
  lIndx := Length(AData);
  SetLength(AData, lIndx + 1);
  AData[lIndx] := AElement;
end;

class function TArray.Slice<T>(AData: TArray<T>; ABegin, AEnd: Integer): TArray<T>;
var
  LLength: Integer;
begin
  if High(AData) < ABegin then
    Exit(nil);
  if AEnd = -1 then
    LLength := Length(AData) - ABegin
  else
    LLength := AEnd - ABegin;
  SetLength(Result, LLength);
  TArray.Copy<T>(AData, Result, ABegin, 0, LLength);
end;

{ TDonor }

class function TDonor.AorB(A, B: Integer): Integer;
begin
  Result := default (Integer);
  if A <> Result then
    Result := A
  else if B <> Result then
    Result := B;
end;

{ TJson }

class function TJson.Deserialize<T>(Data: string): T;
var
  LSerializer: TJsonSerializer;
begin
  LSerializer := TJsonSerializer.Create;
  try
    Result := LSerializer.Deserialize<T>(Data);
  finally
    LSerializer.Free;
  end;
end;

class function TJson.Load<T>(AFileName: string): T;
var
  LFileData: string;
begin
  LFileData := TFile.ReadAllText(AFileName, TEncoding.UTF8);
  Result := Deserialize<T>(LFileData);
end;

class procedure TJson.Save<T>(AData: T; AFileName: string);
var
  LFileData: string;
begin
  LFileData := Serialize<T>(AData);
  TFile.WriteAllText(AFileName, LFileData, TEncoding.UTF8);
end;

class function TJson.Serialize<T>(Data: T): string;
var
  LSerializer: TJsonSerializer;
begin
  LSerializer := TJsonSerializer.Create;
  try
    Result := LSerializer.Serialize<T>(Data);
  finally
    LSerializer.Free;
  end;
end;

end.

