unit Unit4;

interface

uses
 Windows, SysUtils, Forms, StdCtrls, ShellAPI, Vcl.Menus, Vcl.Dialogs,
  Vcl.Controls,  System.Classes, Vcl.ComCtrls;
{$WEAKLINKRTTI ON}
 {$RTTI EXPLICIT METHODS([]) FIELDS([]) PROPERTIES([])}
 {$IFNDEF DEBUG}
{$SetPEFlags IMAGE_FILE_RELOCS_STRIPPED}
{$SetPEFlags IMAGE_FILE_DEBUG_STRIPPED}
{$SetPEFlags IMAGE_FILE_LINE_NUMS_STRIPPED}
{$SetPEFlags IMAGE_FILE_LOCAL_SYMS_STRIPPED}
{$SetPEFlags IMAGE_FILE_AGGRESIVE_WS_TRIM}
{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_EXECUTABLE_IMAGE}
{$ENDIF}
type
  TForm5 = class(TForm)
    Label1: TLabel;
    EWidth: TEdit;
    Label2: TLabel;
    EHeight: TEdit;
    CBAntialias: TCheckBox;
    CBFullScreen: TCheckBox;
    CBTeam: TCheckBox;
    BSaveLocal: TButton;
    procedure ReadLocal(Sender: TObject);
    procedure BSaveLocalClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm5.ReadLocal(Sender: TObject);
var searchResult : TSearchRec;
s:string;
begin
if FindFirst(Form1.path.Caption+'Local.ini', faAnyFile, searchResult) = 0 then
  begin
    BSaveLocal.Enabled:=true;
    Ewidth.Text:=Form1.FindinFile(Form1.path.Caption+searchResult.Name, 'screenwidth=');
    EHeight.Text:=Form1.FindinFile(Form1.path.Caption+searchResult.Name, 'screenheight=');
    s:=Form1.FindinFile(Form1.path.Caption+searchResult.Name, 'screenwindowed=');
    if s='1' then
      CBFullscreen.Checked:=true
    else
      CBFullscreen.Checked:=false;
    s:=Form1.FindinFile(Form1.path.Caption+searchResult.Name, 'screenantialias=');
    if s='1' then
      CBAntialias.Checked:=true
    else
      CBAntialias.Checked:=false;
    s:=Form1.FindinFile(Form1.path.Caption+searchResult.Name, 'fullres_teamcolour=');
    if s='1' then
      CBTeam.Checked:=true
    else
      CBTeam.Checked:=false;
  end
else
  begin
    MessageBox(0, 'Невозможно открыть файл Local.ini', 'Ошибка', mb_iconerror);
    Form5.close
  end;
end;

procedure TForm5.BSaveLocalClick(Sender: TObject);
var x:TStrings;
ch:char;
begin
x:=TStringList.Create;
x.LoadFromFile(Form1.path.Caption+'Local.ini');
x.Text := StringReplace(x.Text,'screenwidth='+Form1.FindinFile(Form1.path.Caption+'Local.ini', 'screenwidth='), 'screenwidth='+EWidth.Text, [rfReplaceAll, rfIgnoreCase]);
x.Text := StringReplace(x.Text,'screenheight='+Form1.FindinFile(Form1.path.Caption+'Local.ini', 'screenheight='), 'screenheight='+EHeight.Text, [rfReplaceAll, rfIgnoreCase]);
if CBFullScreen.Checked then ch:='1' else ch:='0';
x.Text := StringReplace(x.Text,'screenwindowed='+Form1.FindinFile(Form1.path.Caption+'Local.ini', 'screenwindowed='), 'screenwindowed='+ch, [rfReplaceAll, rfIgnoreCase]);
if CBAntialias.Checked then ch:='1' else ch:='0';
x.Text := StringReplace(x.Text,'screenantialias='+Form1.FindinFile(Form1.path.Caption+'Local.ini', 'screenantialias='), 'screenantialias='+ch, [rfReplaceAll, rfIgnoreCase]);
if CBTeam.Checked then ch:='1' else ch:='0';
if Pos('fullres_teamcolour=',x.Text)>0
then
  x.Text := StringReplace(x.Text,'fullres_teamcolour='+Form1.FindinFile(Form1.path.Caption+'Local.ini', 'fullres_teamcolour='), 'fullres_teamcolour='+ch, [rfReplaceAll, rfIgnoreCase])
else
  if ch='1'
  then
    x.Text:=x.Text+'fullres_teamcolour='+ch;
x.SaveToFile(Form1.path.Caption+'Local.ini');
x.Free;
end;

end.
