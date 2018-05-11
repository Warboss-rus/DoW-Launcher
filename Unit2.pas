unit Unit2;

interface

uses
  Winapi.Windows, System.SysUtils, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons;
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
  TForm3 = class(TForm)
    LBSGA: TListBox;
    BBAdd1: TBitBtn;
    BBDelete1: TBitBtn;
    BBUp1: TBitBtn;
    BBDown1: TBitBtn;
    LBFolders: TListBox;
    BBAdd2: TBitBtn;
    BBDelete2: TBitBtn;
    BBUp2: TBitBtn;
    BBDown2: TBitBtn;
    LBMods: TListBox;
    BBAdd3: TBitBtn;
    BBDelete3: TBitBtn;
    BBUp3: TBitBtn;
    BBDown3: TBitBtn;
    BBExit: TBitBtn;
    BBSave: TBitBtn;
    EUIName: TEdit;
    Label1: TLabel;
    EDescription: TEdit;
    Label2: TLabel;
    CBPlayable: TCheckBox;
    CBDLLName: TComboBox;
    Label3: TLabel;
    EFolder: TEdit;
    Label4: TLabel;
    BBrowse: TButton;
    Label5: TLabel;
    EVersion: TEdit;
    GBSGA: TGroupBox;
    GBFolders: TGroupBox;
    GBMods: TGroupBox;
    BBReload: TBitBtn;
    procedure BBExitClick(Sender: TObject);
    procedure LoadModule(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BBDelete1Click(Sender: TObject);
    procedure BBDelete2Click(Sender: TObject);
    procedure BBDelete3Click(Sender: TObject);
    procedure BBUp1Click(Sender: TObject);
    procedure BBDown1Click(Sender: TObject);
    procedure BBUp2Click(Sender: TObject);
    procedure BBUp3Click(Sender: TObject);
    procedure BBDown2Click(Sender: TObject);
    procedure BBDown3Click(Sender: TObject);
    procedure BBSaveClick(Sender: TObject);
    procedure SelectModuleFolder(Sender: TObject; type1:String);
    procedure BBrowseClick(Sender: TObject);
    procedure BBAdd2Click(Sender: TObject);
    procedure BBAdd1Click(Sender: TObject);
    procedure BBAdd3Click(Sender: TObject);
    procedure EVersionKeyPress(Sender: TObject; var Key: Char);
    procedure BCancelClick(Sender: TObject);
    procedure F4Close(Sender: TObject; var Action: TCloseAction);
    procedure BSelClick(Sender: TObject);
    procedure SaveModule(Sender: TObject; filename: STRING);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  Form4: TForm;
  ListBox1:TListbox;
  Panel1:TPanel;
  bOK, bCancel:TButton;

implementation

{$R *.dfm}

uses Unit1;

procedure TForm3.BBAdd1Click(Sender: TObject);
begin
  SelectModuleFolder(Form3, 'SGA')
end;

procedure TForm3.BBAdd2Click(Sender: TObject);
begin
  SelectModuleFolder(Form3, 'Folder')
end;

procedure TForm3.BBAdd3Click(Sender: TObject);
begin
  SelectModuleFolder(Form3, 'Mod')
end;

procedure TForm3.BBDelete1Click(Sender: TObject);
begin
  LBSGA.Items.Delete(LBSGA.ItemIndex);
end;

procedure TForm3.BBDelete2Click(Sender: TObject);
begin
    LBFolders.Items.Delete(LBFolders.ItemIndex);
end;

procedure TForm3.SelectModuleFolder(Sender: TObject; type1:String);
var
  sr: TSearchRec;
begin
  Form4:=TForm.Create(nil);
  Form4.Parent:=nil;
  FOrm4.Height:=429;
  Form4.Width:=386;
  Form4.OnClose:=F4Close;
  if type1='ModFolder' then
    Form4.Caption:='Выберите основную папку мода';
  if type1='SGA' then
    Form4.Caption:='Выберите SGA для добавления в список';
  if type1='Folder' then
    Form4.Caption:='Выберите папку для добавления в список';
  if type1='Mod' then
    Form4.Caption:='Выберите мод для добавления в список';
  Form4.Show;
  ListBox1:=TListBox.Create(Form4);
  ListBox1.Parent:=Form4;
  ListBox1.Align:=alClient;
  Panel1:=TPanel.Create(Form4);
  Panel1.Parent:=Form4;
  Panel1.Height:=40;
  Panel1.Align:=alBottom;
  bOK:=TButton.Create(Panel1);
  bOK.Parent:=Panel1;
  bOK.Caption:='OK';
  bOK.Left:=192;
  bOK.Top:=6;
  bOK.OnClick:=bSelClick;
  bCancel:=TButton.Create(Panel1);
  bCancel.Parent:=Panel1;
  bCancel.Caption:='Отмена';
  bCancel.Left:=280;
  bCancel.Top:=6;
  bCancel.OnClick:=BCancelClick;
  if type1='ModFolder' then
    if FindFirst(Form1.Path.Caption + '*.*', faAnyFile, sr) = 0 then
      repeat
        if (sr.Attr and faDirectory) <> 0 then  // если найденный файл - папка
          if (sr.Name <> '.') and (sr.Name <> '..') then  // игнорировать служебные папки
            ListBox1.Items.Append(sr.Name);
      until FindNext(sr) <> 0;
  if type1='Folder' then
    if FindFirst(Form1.Path.Caption+EFolder.Text+'/' + '*.*', faAnyFile, sr) = 0 then
      repeat
        if (sr.Attr and faDirectory) <> 0 then  // если найденный файл - папка
          if (sr.Name <> '.') and (sr.Name <> '..') then  // игнорировать служебные папки
            ListBox1.Items.Append(sr.Name);
      until FindNext(sr) <> 0;
  if type1='SGA' then
    if FindFirst(Form1.Path.Caption+EFolder.Text+'/' + '*.sga', faAnyFile, sr) = 0 then
      repeat
        ListBox1.Items.Append(sr.Name);
      until FindNext(sr) <> 0;
  if type1='Mod' then
    if FindFirst(Form1.Path.Caption + '*.module', faAnyFile, sr) = 0 then
      repeat
        ListBox1.Items.Append(sr.Name);
      until FindNext(sr) <> 0;
end;

procedure TForm3.BSelClick(Sender: TObject);
begin
  if Form4.Caption='Выберите основную папку мода' then
    EFolder.Text:=ListBox1.Items[ListBox1.ItemIndex];
  if Form4.Caption='Выберите SGA для добавления в список' then
    LBSGA.Items.Append(copy(ListBox1.Items[ListBox1.ItemIndex],1,length(ListBox1.Items[ListBox1.ItemIndex])-4));
  if Form4.Caption='Выберите папку для добавления в список' then
    LBFolders.Items.Append(ListBox1.Items[ListBox1.ItemIndex]);
  if Form4.Caption='Выберите мод для добавления в список' then
    LBMods.Items.Append(copy(ListBox1.Items[ListBox1.ItemIndex],1,length(ListBox1.Items[ListBox1.ItemIndex])-7));
  Form4.Close;
end;

procedure TForm3.F4Close(Sender: TObject; var Action: TCloseAction);
begin
   Form4.Free;
end;

procedure TForm3.BCancelClick(Sender: TObject);
begin
   Form4.Close;
end;

procedure TForm3.BBDelete3Click(Sender: TObject);
begin
    LBMods.Items.Delete(LBMods.ItemIndex);
end;

procedure TForm3.BBDown1Click(Sender: TObject);
var i:integer;
begin
if LBSGA.ItemIndex<LBSGA.Items.Count-1 then
  begin
    i:=LBSGA.ItemIndex+1;
    LBSGA.Items.Move(LBSGA.ItemIndex,i);
    LBSGA.ItemIndex:=i
  end;
end;

procedure TForm3.BBDown2Click(Sender: TObject);
var i:integer;
begin
if LBFolders.ItemIndex<LBFolders.Items.Count-1 then
  begin
    i:=LBFolders.ItemIndex+1;
    LBFolders.Items.Move(LBFolders.ItemIndex,i);
    LBFolders.ItemIndex:=i
  end;
end;

procedure TForm3.BBDown3Click(Sender: TObject);
var i:integer;
begin
if LBMods.ItemIndex<LBMods.Items.Count-1 then
  begin
    i:=LBMods.ItemIndex+1;
    LBMods.Items.Move(LBMods.ItemIndex,i);
    LBMods.ItemIndex:=i
  end;
end;

procedure TForm3.BBExitClick(Sender: TObject);
begin
  Form3.Close
end;

procedure TForm3.BBrowseClick(Sender: TObject);
begin
  SelectModuleFolder(Form3, 'ModFolder');
end;

procedure TForm3.SaveModule(Sender: TObject; filename: String);
var
  F:TextFile;
  i:Integer;
begin
  AssignFile(F, filename);
  Rewrite(F);
  Writeln(F, '[global]');
  Writeln(F);
  Writeln(F, 'UIName = '+EUIName.Text);
  Writeln(F, 'Description = '+EDescription.Text);
  if CBPlayable.Checked then
    Writeln(F, 'Playable = 1')
  else
    Writeln(F, 'Playable = 0');
  Writeln(F, 'DllName = '+copy(CBDLLName.Items.Strings[CBDLLName.ItemIndex],1,length(CBDLLName.Items.Strings[CBDLLName.ItemIndex])-4));
  Writeln(F, 'ModFolder = '+EFolder.Text);
  Writeln(F, 'ModVersion = '+EVersion.Text);
  Writeln(F, 'TextureFE = Art/UI/Textures/Title_winter_assault.tga');
  Writeln(F, 'TextureIcon =');
  if LBFolders.Items.Count>0 then
    begin
      Writeln(F);
      for I := 0 to LBFolders.Items.Count-1 do
        Writeln(F, 'DataFolder.'+inttostr(i+1)+' = '+LBFolders.Items.Strings[i])
    end;
  if LBSGA.Items.Count>0 then
    begin
      Writeln(F);
      for I := 0 to LBSGA.Items.Count-1 do
        Writeln(F, 'ArchiveFile.'+inttostr(i+1)+' = '+LBSGA.Items.Strings[i])
    end;
   if LBMods.Items.Count>0 then
    begin
      Writeln(F);
      for I := 0 to LBMods.Items.Count-1 do
        Writeln(F, 'RequiredMod.'+inttostr(i+1)+' = '+LBMods.Items.Strings[i])
    end;
  CloseFile(F)
end;

procedure TForm3.BBSaveClick(Sender: TObject);
begin
  if Form1.N5.Checked then
    SaveModule(Form3, Form1.path.Caption+'DoWcombiner.module')
  else
    SaveModule(Form3, Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex]);
end;

procedure TForm3.BBUp1Click(Sender: TObject);
var i:integer;
begin
  if LBSGA.ItemIndex>0 then
  begin
    i:=LBSGA.ItemIndex-1;
    LBSGA.Items.Move(LBSGA.ItemIndex,i);
    LBSGA.ItemIndex:=i
  end;
end;

procedure TForm3.BBUp2Click(Sender: TObject);
var i:integer;
begin
  if LBFolders.ItemIndex>0 then
  begin
    i:=LBFolders.ItemIndex-1;
    LBFolders.Items.Move(LBFolders.ItemIndex,i);
    LBFolders.ItemIndex:=i
  end;
end;

procedure TForm3.BBUp3Click(Sender: TObject);
var i:integer;
begin
  if LBMods.ItemIndex>0 then
  begin
    i:=LBMods.ItemIndex-1;
    LBMods.Items.Move(LBMods.ItemIndex,i);
    LBMods.ItemIndex:=i
  end;
end;

procedure TForm3.EVersionKeyPress(Sender: TObject; var Key: Char);
begin
  case key of
    '0'..'9','.':;
    else key:=#0;
  end;
end;

procedure TForm3.FormResize(Sender: TObject);
begin
  if Form3.Height<762 then
    begin
      Form3.Constraints.MaxWidth:=468;
      Form3.Constraints.MinWidth:=468;
      Form3.Width:=468
    end
  else
    begin
      Form3.Constraints.MaxWidth:=449;
      Form3.Constraints.MinWidth:=449;
      Form3.Width:=449
    end;
end;

procedure TForm3.LoadModule(Sender: TObject);
var temp:string;
  i:integer;
  searchResult : TSearchRec;
begin
  LBSGA.Clear;
  LBFolders.Clear;
  LBMods.Clear;
  if FindFirst(Form1.path.Caption+'*.dll', faAnyFile, searchResult) = 0 then
  repeat
    CBDLLName.Items.Append(searchResult.Name);
  until FindNext(searchResult) <> 0;
  EUIName.Text:=Form1.FindinFile(Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex],'UIName = ');
  EDescription.Text:=Form1.FindinFile(Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex],'Description = ');
  EFolder.Text:=Form1.FindinFile(Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex],'ModFolder = ');
  temp:=Form1.FindinFile(Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex],'Playable = ');
  if temp='1' then
     CBPlayable.Checked:=true
  else
     CBPlayable.Checked:=false;
  temp:=Form1.FindinFile(Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex],'DllName = ');
  for I := 0 to CBDllName.Items.Count-1 do
    if copy(CBDllName.Items.Strings[i],1,length(CBDllName.Items.Strings[i])-4)=temp
    then
      CBDllName.ItemIndex:=i;
  EVersion.Text:=Form1.FindinFile(Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex],'ModVersion = ');
  i:=0;
  repeat
    i:=i+1;
    temp:='';
    temp:=Form1.FindinFile(Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex],'DataFolder.'+inttostr(i)+' = ');
    if temp<>'' then
      LBFolders.Items.Append(temp)
  until temp='';
  i:=0;
  repeat
    i:=i+1;
    temp:='';
    temp:=Form1.FindinFile(Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex],'ArchiveFile.'+inttostr(i)+' = ');
    if temp<>'' then
      LBSGA.Items.Append(temp)
  until temp='';
  i:=0;
  repeat
    i:=i+1;
    temp:='';
    temp:=Form1.FindinFile(Form1.path.Caption+LBNames.Strings[Form1.ListBox1.ItemIndex],'RequiredMod.'+inttostr(i)+' = ');
    if temp<>'' then
      LBMods.Items.Append(temp)
  until temp=''
end;

end.
