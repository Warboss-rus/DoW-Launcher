unit Unit5;

interface

uses
  Windows, SysUtils, Forms, StdCtrls, ShellAPI, registry, Vcl.Menus, Vcl.Dialogs,
  Vcl.Controls, Vcl.ExtCtrls, UITypes, System.Classes, Vcl.ComCtrls;
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
  TForm6 = class(TForm)
    CBLanguage: TComboBox;
    Label3: TLabel;
    CBUnlocker: TCheckBox;
    CBClose: TCheckBox;
    CBplayableonly: TCheckBox;
    CBDeleteCombiner: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BCloseSettings: TButton;
    procedure CBLanguageChange(Sender: TObject);
    procedure CBUnlockerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BCloseSettingsClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Exit(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses Unit1, Unit2, Unit4, Unit3;

procedure TForm6.BCloseSettingsClick(Sender: TObject);
begin
  Form6.Close;
end;

function GetSystemDefaultUILanguage: UINT; stdcall; external kernel32 name 'GetSystemDefaultUILanguage';
function GetSysLang: integer;
begin
  result :=Lo(GetSystemDefaultUILanguage);
end;

procedure TForm6.CBLanguageChange(Sender: TObject);
begin
  case CBLanguage.ItemIndex of
    0:begin
      LSSelectGame:='�������� ���� ��� �������';
      LSModuleEditor:=' - �������� �������';
      LSLocale := '�����������: ';
      LSModName := '���';
      LSMod := '���';
      LSSGA := 'SGA';
      LSInstalled := '����������';
      LSAction := '��������';
      LSYes := '��';
      LSNo := '���';
      LSEnable := '����������';
      LSDisable := '���������';
      LSError :=  '������';
      Form6.Caption:='���������';
      CBPLayAbleOnly.Caption:='�������� �������������';
      CBClose.Caption:='������� ���� ����� �������';
      CBUnlocker.Caption:='�������� unlocker';
      Label3.Caption:='����';
      CBDeleteCombiner.Caption:='������� ���������';
      Label1.Caption:='�����';
      Label2.Caption:='������';
      BCloseSettings.Caption:='�������';
      Form1.BBrowse.Caption:='�����';
      Form1.BRefresh.Caption:='�������� ������ �����';
      Form1.CBHighPoly.Caption:='������������������ ������';
      Form1.CBDev.Caption:='����� �������';
      Form1.�Bnomovies.Caption:='���������� �����������';
      Form1.BRun.Caption:='���������';
      Form1.G1.Caption:='������';
      Form1.N1.Caption:='������������� ������';
      Form1.Localini1.Caption:='��������� Local.ini';
      Form1.N11.Caption:='���� ���������';
      Form1.N2.Caption:='�����';
      Form1.N3.Caption:='���������';
      Form1.N4.Caption:='�������';
      Form1.N5.Caption:='���������';
      Form1.N6.Caption:='���������';
      Form1.N7.Caption:='� ���������';
      Form1.N9.Caption:='������� �����';
      Form3.Label1.Caption:='��� ����';
      Form3.Label2.Caption:='��������';
      Form3.Label3.Caption:='��� ����������';
      Form3.Label4.Caption:='����� ����';
      Form3.Label5.Caption:='������';
      Form3.CBPlayable.Caption:='����������� ���';
      Form3.BBrowse.Caption:='�������';
      Form3.GBSGA.Caption:='SGA ������';
      Form3.GBFolders.Caption:='�����';
      Form3.GBMods.Caption:='������������ ����';
      Form3.BBReload.Caption:='��������� �� �����';
      Form3.BBSave.Caption:='���������';
      Form3.BBExit.Caption:='�����';
      Form4.Caption := '��������� GiFR';
      Form4.GroupBox1.Caption := '�����������';
      Form4.ComboBox1.Text := '�������� ����';
      Form4.BInstallLocale.Caption := '����������';
      Form4.GroupBox2.Caption := '�������';
      Form4.ComboBox2.Text := '�������� �������';
      Form4.BInstallTaskbar.Caption := '����������';
      Form4.GroupBox3.Caption := '������������ ���� (coming soon)';
      Form4.BClose.Caption := '�������';
      Form5.Caption:='��������� Local.ini';
      Form5.Label1.Caption:='����������';
      Form5.CBFullScreen.Caption:='� ����';
      Form5.CBAntialias.Caption:='�����������';
      Form5.BSaveLocal.Caption:='���������';
    end;
    1:begin
      LSSelectGame:='Select Game to start';
      LSModuleEditor:=' - Module Editor';
      LSLocale := 'Locale: ';
      LSModName := 'Modname';
      LSMod := 'Module';
      LSSGA := 'SGA';
      LSInstalled := 'Installed';
      LSAction := 'Action';
      LSYes := 'Yes';
      LSNo := 'No';
      LSEnable := 'Enable';
      LSDisable := 'Disable';
      LSError :=  'Error';
      Form6.Caption:='Preferences';
      CBPLayAbleOnly.Caption:='Hide unplayable mods';
      CBClose.Caption:='Close launcher after the launch';
      CBUnlocker.Caption:='Hide unlocker';
      Label3.Caption:='Language';
      CBDeleteCombiner.Caption:='Remove combiner';
      Label1.Caption:='after';
      Label2.Caption:='secounds';
      BCloseSettings.Caption:='Close';
      Form1.BBrowse.Caption:='Browse';
      Form1.BRefresh.Caption:='Refresh the mod list';
      Form1.CBHighPoly.Caption:='High poly models';
      Form1.CBDev.Caption:='Developer''s mode';
      Form1.�Bnomovies.Caption:='Skip Intro movies';
      Form1.BRun.Caption:='Launch';
      Form1.G1.Caption:='Edit';
      Form1.N1.Caption:='Edit module';
      Form1.Localini1.Caption:='Local.ini Settings';
      Form1.N11.Caption:='Custom parametres';
      Form1.N2.Caption:='Exit';
      Form1.N3.Caption:='Program';
      Form1.N4.Caption:='Normal';
      Form1.N5.Caption:='Combiner';
      Form1.N6.Caption:='Preferences';
      Form1.N7.Caption:='About';
      Form1.N9.Caption:='Create shortcut';
      Form3.Label1.Caption:='UI Name';
      Form3.Label2.Caption:='Description';
      Form3.Label3.Caption:='DLL Name';
      Form3.Label4.Caption:='Mod Folder';
      Form3.Label5.Caption:='Version';
      Form3.CBPlayable.Caption:='Playable';
      Form3.BBrowse.Caption:='Browse';
      Form3.GBSGA.Caption:='SGA archives';
      Form3.GBFolders.Caption:='Folders';
      Form3.GBMods.Caption:='Required mods';
      Form3.BBReload.Caption:='Reload from file';
      Form3.BBSave.Caption:='Save';
      Form3.BBExit.Caption:='Close';
      Form4.Caption := 'GiFR Settings';
      Form4.GroupBox1.Caption := 'Localization';
      Form4.ComboBox1.Text := 'Select locale';
      Form4.BInstallLocale.Caption := 'Install';
      Form4.GroupBox2.Caption := 'Taskbar';
      Form4.ComboBox2.Text := 'Select taskbar';
      Form4.BInstallTaskbar.Caption := 'Install';
      Form4.GroupBox3.Caption := 'Connected mods (coming soon)';
      Form4.BClose.Caption := 'Close';
      Form5.Caption:='Local.ini Settings';
      Form5.Label1.Caption:='Resolution';
      Form5.CBFullScreen.Caption:='Windowed';
      Form5.CBAntialias.Caption:='Antialiasing';
      Form5.BSaveLocal.Caption:='Save';
    end
  end
end;

procedure TForm6.CBUnlockerClick(Sender: TObject);
var searchResult : TSearchRec;
i: integer;
game: string;
begin
game:=Form1.CBGame.Items.Strings[Form1.CBGame.ItemIndex];
Form1.CBGame.Items.Clear;
if FindFirst('Soulstorm.exe', faAnyFile, searchResult) = 0 then begin
   Form1.CBGame.Items.Add('Current - Soulstorm');
end;
if FindFirst('DarkCrusade.exe', faAnyFile, searchResult) = 0 then begin
   Form1.CBGame.Items.Add('Current - Dark Crusdade');
end;
if FindFirst('W40kWA.exe', faAnyFile, searchResult) = 0 then begin
   Form1.CBGame.Items.Add('Current - Winter Assault');
end;
if FindFirst('W40K.exe', faAnyFile, searchResult) = 0 then begin
   Form1.CBGame.Items.Add('Current - Dawn of War');
end;
if FindFirst('DOW2.exe', faAnyFile, searchResult) = 0 then begin
   Form1.CBGame.Items.Add('Current - Dawn of War 2');
end;
Reg.RootKey:=HKEY_LOCAL_MACHINE;
if Reg.OpenKeyReadOnly('SOFTWARE\THQ\Dawn of War - Soulstorm')= true then
  Form1.CBGame.Items.Add('Soulstorm');
Reg.CloseKey;
if Reg.OpenKeyReadOnly('SOFTWARE\THQ\Dawn Of War - Dark Crusade')= true then
  if (copy(Reg.Readstring('installlocation'),Length(Reg.Readstring('installlocation'))-8,8)<>'unlocker') or (CBUnlocker.Checked=false) then
     Form1.CBGame.Items.Add('Dark Crusade');
Reg.CloseKey;
if Reg.OpenKeyReadOnly('SOFTWARE\THQ\Dawn Of War')= true then
  if (copy(Reg.Readstring('installlocation'),Length(Reg.Readstring('installlocation'))-8,8)<>'unlocker') or (CBUnlocker.Checked=false) then
    Form1.CBGame.Items.Add('Dawn of War');
Reg.CloseKey;
if Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam\Apps\56400')= true then
  Form1.CBGame.Items.Add('Retribution (Steam)');
Reg.CloseKey;
if Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam\Apps\20570')= true then
  Form1.CBGame.Items.Add('Chaos Rising (Steam)');
Reg.CloseKey;
if Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam\Apps\15620')= true then
  Form1.CBGame.Items.Add('Dawn of War II (Steam)');
Reg.CloseKey;
Form1.CBGame.Items.Add('Custom');
if Form1.CBGame.Items.Count>0 then Form1.CBGame.ItemIndex:=0;
for i:=0 to Form1.CBGame.Items.Count-1 do
  if Form1.CBGame.Items.Strings[i]=game then
    Form1.CBGame.ItemIndex:=i;
Form1.CBGameChange(Form1);
end;

procedure TForm6.Edit1Exit(Sender: TObject);
begin
  if Edit1.Text='' then
    Edit1.Text:='0';
end;

procedure TForm6.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9',#8:;
    else key:=#0;
  end;
end;

procedure TForm6.FormCreate(Sender: TObject);
var searchResult : TSearchRec;
i:integer;
game, smod: string;
begin
Names:='Soulstorm.exe';
Reg:=TRegistry.create;
Reg.RootKey:=HKEY_CURRENT_USER;
if Reg.OpenKeyReadOnly('SOFTWARE\DoW Launcher')=true then begin
  Form1.Height:=Reg.ReadInteger('Height');
  Form1.Width:=Reg.ReadInteger('Width');
  CBLanguage.Itemindex:=Reg.ReadInteger('Language');
  CBPlayableonly.Checked:=Reg.ReadBool('show_playable_only');
  CBClose.Checked:=Reg.ReadBool('Close');
  CBUnlocker.Checked:=Reg.ReadBool('HideUnlocker');
  CBDeleteCombiner.Checked:=Reg.ReadBool('DeleteCombiner');
  Edit1.Text:=inttostr(Reg.ReadInteger('DeleteDelay'));
  Reg.OpenKeyReadOnly('SOFTWARE\DoW Launcher');
  Form1.N5.Checked:=Reg.ReadBool('Combiner');
  if Form1.N5.Checked then
     Form1.N5.OnClick(Form1);
  Form1.CBHighpoly.Checked:=Reg.ReadBool('highpoly');
  Form1.CBDev.Checked:=Reg.ReadBool('dev_mode');
  Form1.�Bnomovies.Checked:=Reg.ReadBool('nomovies');
  game:=Reg.ReadString('game');
  smod:= Reg.ReadString('mod');
  Form1.path.Caption:=Reg.ReadString('Custom');
  customparams:='';
  customparams:=Reg.ReadString('customparams');
end
else  //����������� �����
  if GetSystemDefaultUILanguage=1049 then
    CBLanguage.ItemIndex:=0
  else
    CBLanguage.ItemIndex:=1;
Reg.CloseKey;
CBLanguageChange(Form6);
CBUnlockerClick(Form6);
Form1.CBGame.ItemIndex:=0;
for i := 0 to Form1.CBGame.Items.Count-1 do
  if Form1.CBGame.Items.Strings[i]=game then
    Form1.CBGame.ItemIndex:=i;
Form1.CBGameChange(Form1);
Form1.ListBox1.ItemIndex:=0;
if not(smod='null') then
  for i := 0 to Form1.ListBox1.Items.Count-1 do
    if Form1.ListBox1.Items.Strings[i]=smod then
      Form1.ListBox1.ItemIndex:=i
end;

end.
