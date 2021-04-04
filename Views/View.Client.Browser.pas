unit View.Client.Browser;

interface

uses
{$REGION 'ViewNavigator'}
  ViewNavigator,
  VN.Attributes,
{$ENDREGION}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.WebBrowser, FMX.Controls.Presentation;

type

  [vnName('ViewClient')]
  [vnLifeCycle(TvnLifeCycle.OnCreateDestroy)]
  TViewClient = class(TFrame)
    Edit1: TEdit;
    EditButton1: TEditButton;
    WebBrowser1: TWebBrowser;
    procedure EditButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

uses
  GSA.Web, GMA.Model.Account, System.Net.HttpClient;

procedure TViewClient.EditButton1Click(Sender: TObject);
var
  lResp: IHTTPResponse;
  lData: string;
begin
  lResp := TgWebRequest.Request(Edit1.Text, TgAccount.Create(59870843, 't63dxr35yo', 'g562071787'), 0, True);
  lData := lResp.ContentAsString(TEncoding.UTF8);
  Writeln(lData);
  WebBrowser1.LoadFromStrings(lData, Edit1.Text);
  WebBrowser1.Navigate;
end;

end.
