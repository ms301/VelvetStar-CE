unit Unit7;

interface

uses
  GSA.Web,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.WebBrowser, FMX.Edit, FMX.Controls.Presentation,
  FMX.ScrollBox, FMX.Memo, FMX.TabControl;

type
  TForm7 = class(TForm)
    Edit1: TEdit;
    EditButton1: TEditButton;
    WebBrowser1: TWebBrowser;
    GroupBox1: TGroupBox;
    Layout1: TLayout;
    edAction: TEdit;
    Label1: TLabel;
    Layout2: TLayout;
    edMyId: TEdit;
    Label2: TLabel;
    Layout3: TLayout;
    edMyPassword: TEdit;
    Label3: TLabel;
    Layout4: TLayout;
    edCurrentUser: TEdit;
    Label4: TLabel;
    Button1: TButton;
    Layout5: TLayout;
    edServ: TEdit;
    Label5: TLabel;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditButton1Click(Sender: TObject);
  private
    { Private declarations }
    fGalaWeb: TgWebRequest;
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.fmx}

uses
  GMA.Model.Account,
  GSA.Web.InternetExplorerUpgrade,
  System.Net.HttpClient;

procedure TForm7.Button1Click(Sender: TObject);
begin
  Edit1.Text := TgWebRequest.BeginMakeUrl //
    .SetServer(edServ.Text) //
    .SetAction(edAction.Text) //
    .SetAccount(TgAccount.Create(edMyId.Text.ToInteger, edMyPassword.Text, 'unk')) //
    .SetCurrentUser(edCurrentUser.Text.ToInteger()) //
    .SetIsPage(True)//
    .Build;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  fGalaWeb := TgWebRequest.Create;
  TgUpgradeIEBrowser.SetPermissions;
end;

procedure TForm7.EditButton1Click(Sender: TObject);
var
  lResp: IHTTPResponse;
  lData: string;
begin
  if Edit1.Text.IsEmpty then
    Button1Click(Self);
  lResp := TgWebRequest.Request(Edit1.Text);
  lData := lResp.ContentAsString(TEncoding.UTF8);
  Memo1.Text := lData;
  WebBrowser1.LoadFromStrings(lData, Edit1.Text);
 // WebBrowser1.Navigate;

end;

end.
