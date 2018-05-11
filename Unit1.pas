unit Unit1;

interface

uses
  Windows, SysUtils, Forms, StdCtrls, ShellAPI, registry, Vcl.Menus, Vcl.Dialogs,
  Vcl.Controls, Vcl.ExtCtrls, UITypes, System.Classes, ComObj, ShlObj, ActiveX;

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
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Panel1: TPanel;
    ÑBnomovies: TCheckBox;
    BRun: TButton;
    CBdev: TCheckBox;
    BRefresh: TButton;
    OpenDialog1: TOpenDialog;
    BBrowse: TButton;
    Path: TLabel;
    CBGame: TComboBox;
    CBHighPoly: TCheckBox;
    MainMenu1: TMainMenu;
    G1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    Localini1: TMenuItem;
    N9: TMenuItem;
    procedure BRunClick(Sender: TObject);
    procedure BRefreshClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BBrowseClick(Sender: TObject);
    procedure CBGameChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateCombineModule(Sender: TObject);
    procedure BEditModuleClick(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    Function FindinFile(source:string;text:string):string;
    procedure N2Click(Sender: TObject);
    procedure Localini1Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure N9Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Reg:Tregistry;
  names, customparams: STRING;
  LBNames:TStringList;
  LSModuleEditor, LSSelectGame: string;

implementation
{$R *.dfm}

uses Unit2, Unit4, Unit3, Unit5;

var
  pth:array[0..100] of string;
  Param,paths:string;
  CombinerEdit: BOOLEAN;

Function TForm1.FindinFile(source:string;text:string):string;
var list: TStrings;
  i,p:integer;
  str1:string;
begin
  list:= TStringList.Create;
  list.LoadFromFile(source);
  for I := 0 to List.Count - 1 do begin
    str1:= list.Strings[i];
    while Length(str1)<>0 do
      begin
        p:= Pos(text, str1);
        if p<> 0 then
          begin
            result:=copy(str1,length(text)+p,length(str1));
            Delete(str1,1,Length(str1));
          end
        else Break
      end
   end
end;

procedure TForm1.BBrowseClick(Sender: TObject);
var i:integer;
begin
if OpenDialog1.Execute then begin
  Path.Caption:=OpenDialog1.FileName;
  i:=length(OpenDialog1.FileName);
  while (OpenDialog1.FileName[i] <> '\') and (i > 0) do
    i := i - 1;
  names:=copy(OpenDialog1.FileName, i + 1, Length(OpenDialog1.FileName) - i);
  Path.Caption := Copy(OpenDialog1.FileName, 1, i);
end;
BrefreshClick(Form1);
end;

procedure TForm1.BEditModuleClick(Sender: TObject);
begin
if N5.Checked then
  begin
    CombinerEdit := TRUE;
    CreateCombineModule(Form1);
    Form3.Show;
    Form3.Caption := 'Combiner - ' +LSModuleEditor;
  end
else
  if (ListBox1.ItemIndex>=0)
  then
    if LBNames.Strings[ListBox1.ItemIndex]='Galaxy_in_Fire_Reloaded.module' then
      Form4.Show
    else
      begin
        Form3.Show;
        Form3.Caption:=LBNames.Strings[ListBox1.ItemIndex]+LSModuleEditor;
        Form3.LoadModule(Form1)
      end;
end;

procedure TForm1.BRefreshClick(Sender: TObject);
var
  searchResult : TSearchRec;
  temp:integer;
begin
  temp:=ListBox1.ItemIndex;
  Listbox1.Items.Clear;
  LBNames:= TStringList.Create;
  LBNames.Clear;
  if FindFirst(path.Caption+'*.module', faAnyFile, searchResult) = 0 then
  begin
    repeat
      if not((Form6.CBplayableonly.Checked) and (FindinFile(path.Caption+searchResult.Name,'Playable = ')='0')) then
      begin
        LBNames.Append(searchResult.Name);
        if FindinFile(path.Caption+searchResult.Name,'UIName = ')[1]<>'$' then
          ListBox1.Items.Add(FindinFile(path.Caption+searchResult.Name,'UIName = '))
        else
          ListBox1.Items.Add(copy(searchResult.Name,1,length(searchResult.Name)-7));
      end;
    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
  end;
  ListBox1.ItemIndex:=temp;
end;

procedure TForm1.CreateCombineModule(Sender: TObject);
var
  i: Integer;
  searchResult : TSearchRec;
begin
  Form3.EUIName.Text := 'Combiner';
  Form3.EDescription.Text := 'Temprotary module created by DoW Launcher';
  Form3.CBPlayable.Checked := TRUE;
  if FindFirst(Form1.path.Caption+'*.dll', faAnyFile, searchResult) = 0 then
  repeat
    Form3.CBDLLName.Items.Append(searchResult.Name);
  until FindNext(searchResult) <> 0;
  for I := 0 to Form3.CBDllName.Items.Count-1 do
    if copy(Form3.CBDllName.Items.Strings[i],1,length(Form3.CBDllName.Items.Strings[i])-4)='WXPMod'
    then
      Form3.CBDllName.ItemIndex:=i;
  Form3.EFolder.Text := 'W40k';
  Form3.EVersion.Text := '1.0';
  Form3.LBSGA.Items.Clear;
  Form3.LBFolders.Items.Clear;
  Form3.LBMods.Clear;
  for i:=0 to ListBox1.Items.Count-1 do
    if (ListBox1.Selected[i]=true) AND (LBNames.Strings[i]<>'DXP2') AND (LBNames.Strings[i]<>'W40k') then
       Form3.LBMods.Items.Add(copy(LBNames.Strings[i],0,length(LBNames.Strings[i])-7));
  if (CBGame.Items.Strings[CBGame.ItemIndex]='Current - Soulstorm') or (CBGame.Items.Strings[CBGame.ItemIndex]='Current - Dark Crusdade') or
    (CBGame.Items.Strings[CBGame.ItemIndex]='Soulstorm') or (CBGame.Items.Strings[CBGame.ItemIndex]='Dark Crusade')then
      Form3.LBMods.Items.Add('DXP2');
  if (CBGame.Items.Strings[CBGame.ItemIndex]='Current - Winter Assault') then
    Form3.LBMods.Items.Add('WXP');
  Form3.LBMods.Items.Add('W40k');
end;

procedure TForm1.BRunClick(Sender: TObject);
begin
if CBGame.ItemIndex<0 then MessageDLG(LSSelectGame,mtError,[mbOK],0) else begin
Param:='';
if CBdev.Checked then
  Param:=param+' -dev';
if ÑBnomovies.Checked then
  Param:=param+' -nomovies';
if CBHighpoly.Checked then
  if not((CBGame.Items.Strings[CBGame.ItemIndex]='Retribution (Steam)') or (CBGame.Items.Strings[CBGame.ItemIndex]='Chaos Rising (Steam)') or (CBGame.Items.Strings[CBGame.ItemIndex]='Dawn of War II (Steam)')) then
  Param:=param+' -forcehighpoly';
if N11.Checked then
  Param:=Param+' '+customparams;
if N5.Checked=true
then
  Begin
    if not CombinerEdit then
      CreateCombineModule(Form1);
    Form3.SaveModule(Form1, path.Caption+'DoWcombiner.module');
    Param:=param+' -modname DoWcombiner';
  End
else
  if ListBox1.ItemIndex>=0 then
    begin
      Param:=param+' -modname '+LBnames.Strings[Listbox1.ItemIndex];
      delete(param,length(param)-6,7);
    end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Retribution (Steam)') or (CBGame.Items.Strings[CBGame.ItemIndex]='Chaos Rising (Steam)') or (CBGame.Items.Strings[CBGame.ItemIndex]='Dawn of War II (Steam)')then
  begin
    Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam');
    Reg.Readstring('InstallPath');
    if CBGame.Items.Strings[CBGame.ItemIndex]='Retribution (Steam)' then Param:=' -applaunch 56400'+Param;
    if CBGame.Items.Strings[CBGame.ItemIndex]='Chaos Rising (Steam)' then Param:=' -applaunch 20570'+Param;
    if CBGame.Items.Strings[CBGame.ItemIndex]='Dawn of War II (Steam)' then Param:=' -applaunch 15620'+Param;
    ShellExecute(0, 'open', pchar(Reg.Readstring('InstallPath')+'\Steam.exe'), pchar(Param), nil, SW_SHOW);
  end
else
  begin
    SetCurrentDirectory(pchar(path.Caption));
    ShellExecute(0, 'open', pchar(Path.Caption+names), pchar(Param), nil, SW_SHOW);
  end;
if (ListBox1.MultiSelect=true) AND (Form6.CBDeleteCombiner.Checked) then
  begin
    Sleep(strtoint(Form6.Edit1.Text)*1000);
    deletefile(path.Caption+'DoWcombiner.module');
  end;
if Form6.CBClose.Checked then form1.Close;
end;
end;

procedure TForm1.CBGameChange(Sender: TObject);
begin
BBrowse.Visible:=false;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Current - Soulstorm') then begin
  names:='Soulstorm.exe';
  Path.Caption:='';
  Localini1.Enabled:=true;
  N1.Enabled:=true;
  N5.Enabled:=true;
  CBHighPoly.Enabled:=true;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Current - Dark Crusdade') then begin
  names:='DarkCrusade.exe';
  Path.Caption:='';
  Localini1.Enabled:=true;
  N1.Enabled:=true;
  N5.Enabled:=true;
  CBHighPoly.Enabled:=true;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Current - Winter Assault') then begin
  names:='W40kWA.exe';
  Path.Caption:='';
  Localini1.Enabled:=true;
  N1.Enabled:=true;
  N5.Enabled:=true;
  CBHighPoly.Enabled:=true;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Current - Dawn of War') then begin
  names:='W40K.exe';
  Path.Caption:='';
  Localini1.Enabled:=true;
  N1.Enabled:=true;
  N5.Enabled:=true;
  CBHighPoly.Enabled:=true;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Current - Dawn of War 2') then begin
  names:='DOW2.exe';
  Path.Caption:='';
  Localini1.Enabled:=false;
  N1.Enabled:=false;
  N4.Checked:=true;
  N5.Enabled:=false;
  CBHighPoly.Enabled:=false;
end;
Reg.RootKey:=HKEY_LOCAL_MACHINE;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Soulstorm') then begin
  Reg.OpenKey('SOFTWARE\THQ\Dawn of War - Soulstorm',false);
  path.Caption:=Reg.Readstring('installlocation');
  if Path.Caption[length(path.Caption)]<>'\' then Path.Caption:=Path.Caption+'\';
  names:='Soulstorm.exe';
  Reg.CloseKey;
  Localini1.Enabled:=true;
  N1.Enabled:=true;
  N5.Enabled:=true;
  CBHighPoly.Enabled:=true;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Dark Crusade') then begin
  Reg.OpenKey('SOFTWARE\THQ\Dawn Of War - Dark Crusade',false);
  path.Caption:=Reg.Readstring('installlocation');
  if Path.Caption[length(path.Caption)]<>'\' then Path.Caption:=Path.Caption+'\';
  names:='DarkCrusade.exe';
  Reg.CloseKey;
  Localini1.Enabled:=true;
  N1.Enabled:=true;
  N5.Enabled:=true;
  CBHighPoly.Enabled:=true;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Dawn of War') then begin
  Reg.OpenKeyReadOnly('SOFTWARE\THQ\Dawn of War');
  path.Caption:=Reg.Readstring('installlocation');
  if Path.Caption[length(path.Caption)]<>'\' then Path.Caption:=Path.Caption+'\';
  names:='W40k.exe';
  Reg.CloseKey;
  Localini1.Enabled:=true;
  N1.Enabled:=true;
  CBHighPoly.Enabled:=true;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Retribution (Steam)') then begin
  Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam');
  path.Caption:=Reg.Readstring('InstallPath')+'\steamapps\common\dawn of war ii - retribution\';
  names:='DOW2.exe';
  Reg.CloseKey;
  Localini1.Enabled:=false;
  N1.Enabled:=false;
  N4.Checked:=true;
  N5.Enabled:=false;
  CBHighPoly.Enabled:=false;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Chaos Rising (Steam)') then begin
  Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam');
  path.Caption:=Reg.Readstring('InstallPath')+'\steamapps\common\dow2\';
  names:='DOW2.exe';
  Reg.CloseKey;
  Localini1.Enabled:=false;
  N1.Enabled:=false;
  N4.Checked:=true;
  N5.Enabled:=false;
  CBHighPoly.Enabled:=false;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Dawn of War II (Steam)') then begin
  Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam');
  path.Caption:=Reg.Readstring('InstallPath')+'\steamapps\common\dow2\';
  names:='DOW2.exe';
  Reg.CloseKey;
  Localini1.Enabled:=false;
  N1.Enabled:=false;
  N4.Checked:=true;
  N5.Enabled:=false;
  CBHighPoly.Enabled:=false;
end;
if (CBGame.Items.Strings[CBGame.ItemIndex]='Custom') then begin
  Bbrowse.Visible:=true;
  path.Caption:='';
  N5.Enabled:=true;
  N1.Enabled:=true;
  Localini1.Enabled:=true;
  CBHighPoly.Enabled:=true;
end;
BRefreshCLick(Form1);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
BRefreshClick(Form1);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Reg:=TRegistry.create;
Reg.RootKey:=HKEY_CURRENT_USER;
Reg.OpenKey('SOFTWARE\DoW Launcher',true);
Reg.WriteInteger('Height', Form1.Height);
Reg.WriteInteger('Width', Form1.Width);
Reg.WriteInteger('Language', Form6.CBLanguage.ItemIndex);
Reg.WriteBool('show_playable_only',Form6.CBPlayableonly.Checked);
Reg.WriteBool('Close',Form6.CBClose.Checked);
Reg.WriteBool('HideUnlocker',Form6.CBUnlocker.Checked);
Reg.WriteBool('DeleteCombiner',Form6.CBDeleteCombiner.Checked);
Reg.WriteInteger('DeleteDelay', strtoint(Form6.Edit1.Text));
Reg.WriteBool('nomovies',ÑBnomovies.Checked);
Reg.WriteBool('Combiner',N5.Checked);
Reg.WriteBool('dev_mode',CBDev.Checked);
Reg.WriteBool('nomovies',ÑBnomovies.Checked);
Reg.WriteBool('highpoly',CBHighpoly.Checked);
Reg.WriteString('game',CBGame.Items.Strings[CBGame.ItemIndex]);
if (CBGame.Items.Strings[CBGame.ItemIndex]='Custom') then
  Reg.WriteString('Custom',path.Caption)
  else Reg.WriteString('Custom','');
if (N5.Checked=false) and (ListBox1.ItemIndex>=0) then
  Reg.WriteString('mod',ListBox1.Items.Strings[ListBox1.ItemIndex])
else
  Reg.WriteString('mod', 'null');
Reg.WriteString('customparams', customparams);
Reg.CloseKey;
Reg.Free;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  if N5.Checked=false then
    BRunClick(Form1)
end;

procedure TForm1.Localini1Click(Sender: TObject);
begin
  Form5.Show;
  Form5.ReadLocal(Form5)
end;

procedure TForm1.N11Click(Sender: TObject);
begin
  if N11.Checked then
    customparams:=inputbox('Ââåäèòå ïàðàìåòðû','',customparams);
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Form1.Close
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  ListBox1.MultiSelect:=false;
  CombinerEdit := FALSE;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  ListBox1.MultiSelect:=true
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  Form6.Show;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  MessageBox(0, 'DoW Launcher v0.5 by Warboss-rus', 'About', MB_OK)
end;

procedure TForm1.N9Click(Sender: TObject);
var
  IObject : IUnknown;
  ISLink : IShellLink;
  IPFile : IPersistFile;
  PIDL : PItemIDList;
  InFolder : array[0..MAX_PATH] of Char;
  TargetName : String;
  LinkName : WideString;
  Param: String;
begin
  Param := '';
  if (CBGame.Items.Strings[CBGame.ItemIndex]='Retribution (Steam)') or (CBGame.Items.Strings[CBGame.ItemIndex]='Chaos Rising (Steam)') or (CBGame.Items.Strings[CBGame.ItemIndex]='Dawn of War II (Steam)') then
    begin
      Reg.OpenKeyReadOnly('SOFTWARE\Valve\Steam');
      Reg.Readstring('InstallPath');
      if CBGame.Items.Strings[CBGame.ItemIndex]='Retribution (Steam)' then Param:=' -applaunch 56400'+Param;
      if CBGame.Items.Strings[CBGame.ItemIndex]='Chaos Rising (Steam)' then Param:=' -applaunch 20570'+Param;
      if CBGame.Items.Strings[CBGame.ItemIndex]='Dawn of War II (Steam)' then Param:=' -applaunch 15620'+Param;
      TargetName := Reg.Readstring('InstallPath')+'\Steam.exe';
    end
  else
    if (copy(CBGame.Items.Strings[CBGame.ItemIndex], 0, 7) ='Current') then
      TargetName:= ExtractFileDir(ParamStr(0))+'\'+names
    else
    TargetName := Path.Caption+names;
  if CBdev.Checked then
    Param:=param+' -dev';
  if ÑBnomovies.Checked then
    Param:=param+' -nomovies';
  if CBHighpoly.Checked then
    if not((CBGame.Items.Strings[CBGame.ItemIndex]='Retribution (Steam)') or (CBGame.Items.Strings[CBGame.ItemIndex]='Chaos Rising (Steam)') or (CBGame.Items.Strings[CBGame.ItemIndex]='Dawn of War II (Steam)')) then
    Param:=param+' -forcehighpoly';
  if N11.Checked then
    Param:=Param+' '+customparams;
  if N5.Checked=true
  then
    Begin
      if not CombinerEdit then
        CreateCombineModule(Form1);
      Form3.SaveModule(Form1, path.Caption+'DoWcombiner.module');
      Param:=param+' -modname DoWcombiner';
    End
  else
    if ListBox1.ItemIndex>=0 then
      begin
        Param:=param+' -modname '+LBnames.Strings[Listbox1.ItemIndex];
        delete(param,length(param)-6,7);
      end;
  IObject := CreateComObject(CLSID_ShellLink);
  ISLink := IObject as IShellLink;
  IPFile := IObject as IPersistFile;
  with ISLink do
    begin
      SetPath(pChar(TargetName));
      SetWorkingDirectory(pChar(ExtractFilePath(TargetName)));
      SetArguments(PChar(Param));
    end;
  SHGetSpecialFolderLocation(0, CSIDL_DESKTOPDIRECTORY, PIDL) ;
  SHGetPathFromIDList(PIDL, InFolder);
  LinkName := WideCharToString(InFolder) + '\' + inputbox('Enter name of the shortcut', 'Type shortcut name in a field below without extension', CBGame.Items.Strings[CBGame.ItemIndex]) + '.lnk';
  ShowMessage('Shortcut '+LinkName+' successfully created');
  IPFile.Save(PWChar(LinkName), false);
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) then
    BRun.OnClick(Form1);
  if (Key = VK_ESCAPE) then
    N2.OnClick(Form1);
end;

end.
