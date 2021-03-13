unit GMA.Model.Emotion;

interface

type
  TgEmotion = class
  private
    fID: Integer;
    fIsDefault: Boolean;
    fText: string;
  public
    property ID: Integer read fID write fID;
    property IsDefault: Boolean read fIsDefault write fIsDefault;
    property Text: string read fText write fText;
  end;

implementation

end.
