unit Unit3;

interface

uses
  Windows, SysUtils, Forms, StdCtrls, ShellAPI, Vcl.Menus, Vcl.Dialogs,
  Vcl.Controls,  System.Classes, Vcl.ComCtrls, System.Zip, Vcl.Grids, Buttons;
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
  TForm4 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    BInstallLocale: TButton;
    GroupBox2: TGroupBox;
    ComboBox2: TComboBox;
    BInstallTaskbar: TButton;
    GroupBox3: TGroupBox;
    BClose: TButton;
    ScrollBar1: TScrollBar;
    BEnableAll: TButton;
    BDisableAll: TButton;
    BDownload: TButton;
    StringGrid1: TStringGrid;
    procedure FindFileAddToCB(FileMask: string; CB: TComboBox);
    procedure BCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BInstallLocaleClick(Sender: TObject);
    procedure BInstallTaskbarClick(Sender: TObject);
    procedure BDownloadClick(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure TryLoadModDB;
    function FindFile(FileMask: string):boolean;
    procedure ButtonCreate (j:integer; action: INTEGER; Sender: Tobject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;
  LSLocale, LSModName, LSMod, LSSGA, LSInstalled, LSAction, LSYes, LSNo, LSEnable, LSDisable, LSError: STRING;

implementation

{$R *.dfm}
uses Unit1;

var
  additivepath: STRING;
  locale, site: STRING;
  i: INTEGER;

procedure TForm4.BCloseClick(Sender: TObject);
begin
  Form4.Close;
end;

procedure TForm4.FindFileAddToCB(FileMask: string; CB: TComboBox);
var SearchRec:TSearchRec;
begin
 if FindFirst(FileMask, faAnyFile, SearchRec)=0 then
 repeat
   if (SearchRec.name='.') or (SearchRec.name='..') then continue;
   if (SearchRec.Attr and faDirectory)=0 then
     CB.Items.Add(SearchRec.name);
 until FindNext(SearchRec)<>0;
 FindClose(SearchRec);
end;

procedure ExtractZip(zipFile, extractpath: STRING);
VAR
  fzip: TZipFile;
BEGIN
  fzip := TZipFile.Create();
  try
    fzip.ExtractZipFile(zipFile, extractpath);
  finally
    fzip.Free();
  end;
END;

procedure ClearDirectory(path: String; DeleteDir: BOOLEAN);
var
  sr: TSearchRec;
begin
  if FindFirst(path + '\*.*', faAnyFile, sr) = 0 then
  begin
    repeat
      if sr.Attr and faDirectory = 0 then
        begin
          DeleteFile(path + '\' + sr.name);
        end
      else
        begin
          if pos('.', sr.name) <= 0 then
            ClearDirectory(path + '\' + sr.name, true);
        end;
    until
      FindNext(sr) <> 0;
  end;
  FindClose(sr);
  if DeleteDir then
    RemoveDirectory(PChar(path));
end;

procedure TForm4.BDownloadClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PWCHAR(site), nil, nil, Sw_Show);
end;

procedure TForm4.BInstallLocaleClick(Sender: TObject);
begin
  ClearDirectory(Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded\Locale\' + Locale + '\', false);
  ExtractZip(additivepath + 'Locale\'+ ComboBox1.Items.Strings[ComboBox1.ItemIndex], Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded\Locale\' + Locale + '\');
end;

procedure TForm4.BInstallTaskbarClick(Sender: TObject);
begin
  ClearDirectory(Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded\TaskBar\', true);
  ExtractZip(additivepath + 'Taskbar\' + ComboBox2.Items.Strings[ComboBox2.ItemIndex], Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded');
end;

function TForm4.FindFile(FileMask: string):boolean;
var SearchRec:TSearchRec;
begin
findFile:=false;
 if FindFirst(FileMask, faAnyFile, SearchRec)=0 then repeat
   if (SearchRec.name='.') or (SearchRec.name='..') then continue;
   if (SearchRec.Attr and faDirectory)=0 then
   findFile:=true;
 until FindNext(SearchRec)<>0;
 FindClose(SearchRec);
end;

procedure TForm4.ButtonCreate (j:integer; action: INTEGER; Sender: Tobject);
var TB:TSpeedButton;
Rect:TRect;
begin
  TB:=TSpeedButton.Create(self);
  TB.Parent:=StringGrid1;
  StringGrid1.Objects[4,j]:=TB;
  TB.BoundsRect:=StringGrid1.CellRect(4,j);
  TB.Name:='Button'+inttostr(j);
  case action of
    0:begin
       TB.Caption := LSEnable;
    end;
    1:begin
      TB.Caption := LSDisable;
    end;
  end;
end;

procedure TForm4.TryLoadModDB;
var
  F:TextFile;
  Name, Module, SGA: String;
  ModInstalled, SGAInstalled: Boolean;
  Ch: CHAR;
  J: INTEGER;
begin
  StringGrid1.Cells[0,0] := LSModName;
  StringGrid1.Cells[1,0] := LSMod;
  StringGrid1.Cells[2,0] := LSSGA;
  StringGrid1.Cells[3,0] :=  LSInstalled;
  StringGrid1.Cells[4,0] := LSAction;
  I := 0;
  AssignFile(F, additivepath+'GiFRmods.db');
  try
    Reset(F);
  except
    Exit;
  end;
  try
    READLN(F, site);
    BDownload.Enabled := TRUE;
    StringGrid1.Enabled := TRUE;
    WHILE NOT EOF(F)
    DO
      BEGIN
        Name := '';
        Ch := #0;
        WHILE NOT (EOLN(F) OR (Ch = ' '))
        DO
          BEGIN
            READ(F, Ch);
            Name := Name + Ch
          END;
        Module := '';
        Ch := #0;
        WHILE NOT (EOLN(F) OR (Ch = ' '))
        DO
          BEGIN
            READ(F, Ch);
            Module := Module + Ch
          END;
        SGA := '';
        Ch := #0;
        WHILE NOT (EOLN(F) OR (Ch = ' '))
        DO
          BEGIN
            READ(F, Ch);
            SGA := SGA + Ch
          END;
        IF StringGrid1.RowCount > 2 THEN
          StringGrid1.RowCount := StringGrid1.RowCount + 1;
        I := I + 1;
        StringGrid1.Cells[0, I] := Name;
        if FindFile(Form1.Path.Caption + Module) then
          StringGrid1.Cells[1, I] := LSYes
        ELSE
          StringGrid1.Cells[1, I] := LSNo;
        if FindFile(Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded\' + SGA) then
          StringGrid1.Cells[2, I] := LSYes
        ELSE
          StringGrid1.Cells[2, I] := LSNo;
        J := 1;
        ModInstalled := FALSE;
        Name := Form1.FindinFile(Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded.module', 'RequiredMod.1 = ');
        WHILE (Name <> '')
        DO
          BEGIN
            J := J + 1;
            IF Name = copy(Module, 0, length(Module)-7)
            THEN
              ModInstalled := TRUE;
            Name := '';
            Name := Form1.FindinFile(Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded.module', 'RequiredMod.' + inttostr(j) + ' = ');
          END;
        J := 1;
        SGAInstalled := FALSE;
        Name := Form1.FindinFile(Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded.module', 'ArchiveFile.1 = ');
        WHILE (Name <> '')
        DO
          BEGIN
            J := J + 1;
            IF Name = copy(SGA, 0, length(SGA)-4)
            THEN
              ModInstalled := TRUE;
            J := J + 1;
            Name := '';
            Name := Form1.FindinFile(Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded.module', 'ArchiveFile.' + inttostr(j) + ' = ');
          END;
        IF (ModInstalled AND SGAInstalled AND (StringGrid1.Cells[1, I] = LSYes) AND (StringGrid1.Cells[2, I] = LSYes)) THEN
          StringGrid1.Cells[3, I] := LSYes
        ELSE
          IF NOT (ModInstalled OR SGAInstalled) then
            StringGrid1.Cells[3, I] := LSNO
          ELSE
            StringGrid1.Cells[3, I] := LSError;
        IF (StringGrid1.Cells[1, I] = LSYes) AND (StringGrid1.Cells[2, I] = LSYes) AND NOT (ModInstalled OR SGAInstalled) then
          ButtonCreate(I, 0, Form4);
        IF ((StringGrid1.Cells[3, I] = LSYes) OR (StringGrid1.Cells[3, I] = LSError)) then
          ButtonCreate(I, 1, Form4);
      END
  except
    SHOWMESSAGE('Неверная структура файла GiFRmods.db');
  end;
  CLOSEFILE(F);
  IF I>0 THEN
    BEGIN
      BEnableAll.Enabled := TRUE;
      BDisableAll.Enabled := TRUE;
    END;
  if I>4 then
    ScrollBar1.Enabled := TRUE;
  //меняем максимум скроллбара
END;

procedure TForm4.FormActivate(Sender: TObject);
begin
  additivepath := Form1.Path.Caption + 'Galaxy_in_Fire_Reloaded\Misc\';
  locale := Form1.FindInFile(Form1.path.Caption + 'regions.ini', 'lang = ');
  Label1.Caption := LSLocale + locale;
  ComboBox1.Items.Clear;
  FindFileAddToCB(additivepath + 'Locale\*.zip', ComboBox1);
  IF ComboBox1.Items.Count > 0 THEN
    ComboBox1.ItemIndex := 0;
  ComboBox2.Items.Clear;
  FindFileAddToCB(additivepath + 'Taskbar\*.zip', ComboBox2);
  IF ComboBox2.Items.Count > 0 THEN
    ComboBox2.ItemIndex := 0;
  TryLoadModDB;
end;

procedure TForm4.ScrollBar1Change(Sender: TObject);
var j,x:integer;
s:string;
begin
  StringGrid1.TopRow:=ScrollBar1.Position;
  for j:=0 to i do
    begin
      S:='Button'+inttostr(j);
      for x :=0 to ComponentCount-1 do
         if (Components[x] is TSpeedButton) and (Components[x].Name=s) then
           (Components[x] as TSpeedButton).BoundsRect:=StringGrid1.CellRect(4,j);
    end;
end;

end.
