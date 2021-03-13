unit GMA.Model.MenuItem;

interface

uses
  System.JSON.Serializers;

type
  TgMenuItem = class
  private
    [JsonName('ID')]
    FID: Integer;
    [JsonName('ParentID')]
    FParentID: Integer;
    [JsonName('IconID')]
    FIconID: Integer;
    [JsonName('Type')]
    FType: Integer;
    [JsonName('Action')]
    FAction: string;
    [JsonName('mask')]
    FMask: Integer;
    [JsonName('SortOrder')]
    FSortOrder: Integer;
    [JsonName('Text')]
    FText: string;
    FParams: TArray<string>;
  public
    property ID: Integer read FID write FID;
    /// <summary>
    /// ИД родителя
    /// </summary>
    property ParentID: Integer read FParentID write FParentID;
    property IconID: Integer read FIconID write FIconID;
    property &Type: Integer read FType write FType;
    property Action: string read FAction write FAction;
    property SortOrder: Integer read FSortOrder write FSortOrder;
    property Title: string read FText write FText;
    property Mask: Integer read FMask write FMask;
    property Params: TArray<string> read FParams write FParams;
  end;

implementation

end.
