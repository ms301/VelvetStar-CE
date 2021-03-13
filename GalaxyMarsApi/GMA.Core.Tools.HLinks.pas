unit GMA.Core.Tools.HLinks;

interface

uses
  GMA.Model.HLink;

type
  THLinks = class
    class function Replace(AUrl: string; HLinks: TArray<TgHLink>; protocol: string): string; overload;
    class function Replace(AUrl: string; HLinks: TArray<TArray<string>>; protocol: string): string; overload;
  end;

implementation

uses
  System.SysUtils;
{ THLinks }

class function THLinks.Replace(AUrl: string; HLinks: TArray<TgHLink>; protocol: string): string;
var
  LHLink: TgHLink;
  url_protocol: string;
begin
  Result := AUrl;
  for LHLink in HLinks do
  begin
    Result := Result.Replace(LHLink.Key, LHLink.Value);
  end;
  if not protocol.IsEmpty then
  begin
    url_protocol := '';
    if Result.IndexOf(':') >= 0 then
      url_protocol := Result.substring(0, Result.IndexOf(':') - 1);
    Result := Result.substring(Result.IndexOf(':') + 3);
    if url_protocol <> protocol then
      Result := protocol + '://' + Result;
  end;
end;

class function THLinks.Replace(AUrl: string; HLinks: TArray<TArray<string>>; protocol: string): string;
var
  LHLink: TArray<string>;
  url_protocol: string;
begin
  Result := AUrl;
  for LHLink in HLinks do
  begin
    Result := Result.Replace(LHLink[0], LHLink[1]);
  end;
  if not protocol.IsEmpty then
  begin
    url_protocol := '';
    if Result.IndexOf(':') >= 0 then
      url_protocol := Result.substring(0, Result.IndexOf(':') - 1);
    Result := Result.substring(Result.IndexOf(':') + 3);
    if url_protocol <> protocol then
      Result := protocol + '://' + Result;
  end;

end;

end.
