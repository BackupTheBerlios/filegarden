unit Unit1;

interface

uses
   QT,QTypes, QGraphics, QControls, QForms, QButtons, QFileCtrls,
  QDialogs, QStdCtrls, QExtCtrls,Libc, QComCtrls, QMenus,SysUtils, Types, Classes, Variants, 
   IniFiles, SyncObjs,StrUtils,
QClipbrd
  
 ,PClass_Command_RedStone
;
////
type
(******************************************************************************************************)
TRunMultiTask1 = class (TThread)
  private
  protected
  
    procedure runSYNC;
    procedure Execute; override;
     procedure cleanup;
 
   
constructor Create ;
  end;
(******************************************************************************************************)
TRunMultiTask2 = class (TThread)
  private
  protected
    TMAPASSLOCATION:string;
    procedure runSYNC;
    procedure Execute; override;
     procedure cleanup;
 
   
constructor Create(APASSLOCATION:string);
  end;
(******************************************************************************************************)
 TRunMultiTask = class (TThread)
  private
     
  protected
APASSStr:string;
APASSIOMemo:tmemo;
       IO: PIOFile;
     // pid:integer;
     procedure   BlastIO;
    procedure AddToList;
    procedure Execute; override;
  public
 constructor Create(COMMAND: string); 
  // constructor Create (COMMAND:string);AIO: PIOFile
//constructor Create (AIO: PIOFile);
  end;
  TForm1 = class(TForm)
    Button1: TBitBtn;
    Button2: TBitBtn;
    Button3: TBitBtn;
    Button4: TBitBtn;
    Button5: TBitBtn;
    Button6: TBitBtn;
    Panel1: TPanel;
    PanelTop,PanelMid,PanelCenter:TPanel;
  sp1:tsplitter;//
//OpenDialog1: TOpenDialog;
  SaveDialog1: TSaveDialog;
    xfgmemo,memo,REALTASKMemo: tmemo;
    Button7: TBitBtn;
    Button8: TBitBtn;
    Button9: TBitBtn;
    Button10: TBitBtn;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    MainMenu1: TMainMenu;
    xfgMemoPopup:tpopupmenu;
  //  File1: TMenuItem;
  //  Exit1: TMenuItem;
    FontDialog1: TFontDialog;
  //  FindDialog1: TFindDialog;
   // ReplaceDialog1: TReplaceDialog;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;    
    SpeedButton4: TSpeedButton;  
    AFsp : TBitBtn;   
        SpeedButton5: TSpeedButton;    
 pc:TPagecontrol;
 ts1:TTabsheet;
   procedure GetCustomCommandFrom_CRS(APASSexec,APASSHint:string);
  procedure  DoxfgMemoPopupitemsShow(Sender: TObject);
  procedure xfgMemoPopupclick(Sender: TObject);
 procedure DoxfgMemoPopup(Sender: TObject);
     procedure GetActiveMEMO;
    procedure createpagecontrol;
   procedure createts1; 
     procedure   PTEDOnReturnPressed(Sender: TObject);
     procedure MyTableClick(Sender: TObject);
        procedure MyTableCreateMenu(Sender: TObject;APASSmenuitem:Tmenuitem);
   procedure   MemoConfigurationControlsOnChange(Sender: TObject);
procedure   TabSheetOnShow(Sender: TObject);
   procedure PageControlChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
procedure Button2Click(Sender: TObject);
procedure Button3Click(Sender: TObject);
procedure Button4Click(Sender: TObject);
procedure Button5Click(Sender: TObject);
procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
procedure Button10Click(Sender: TObject);
procedure DoCustomCommandClick(Sender: TObject);
 procedure MenuItemOnHighlighted(Sender: TObject); 
  procedure ExecuteDocumentOnClick(Sender: TObject); 
  procedure FormDestroy(Sender: TObject); 
procedure FormCreate(Sender: TObject);
procedure AFOnShow(Sender: TObject);
procedure AFOnClose(Sender: TObject;var Action: TCloseAction);
    procedure Exit1Click(Sender: TObject);
    procedure ReloadMenuClick(Sender: TObject);
       procedure FormClose(Sender: TObject;var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
     procedure SpeedButton2Click(Sender: TObject);
     procedure SpeedButton3Click(Sender: TObject);
     procedure SpeedButton4Click(Sender: TObject);
     procedure SpeedButton5Click(Sender: TObject);
         procedure chkbox1OnClick(Sender: TObject);
      procedure showfilelist(FileName:String);
           procedure showfilelist2(FileNameList:TStrings);
           
 protected
  function WidgetFlags: Integer; override;
(******************************************************************************************************)         
private
 
    { Private declarations }
 runMULTITASKcommandinstr:string; 
 ThreadFree ,ThreadIOKILL:Boolean;
     MT1: TRunMultiTask;
    
   MT20:TRunMultiTask2;
   MT10:TRunMultiTask1;
       sameREALTASKmenuitem:tmenuitem;
       sameREALTASKmenuitemNoUpdate,DoReloadTask:Boolean;
       
         aaf:tform;
          Al,AL2:tlabel;
     //   IniFile: TMemIniFile;
       or2:Boolean;
     //   sr: TSearchRec;
        iniconf,sameREALTASK:string;
        ThreadIOKILLpcPage:TTabsheet;
        speedbutton:TSpeedButton;
         Menu, Item: TMenuItem;
   DEBUG,Achkbox1, EXIT_File_Operation:Boolean;
    procedure  xfgCreateMemoPopup;
   procedure RunAutoVCL(APASSIniFile:TMemIniFile;Section:string);
   procedure create_new_menu(APASSFromThisMenu:String;APASSParentMenuItem:TMenuItem) ;
    procedure update_merge_FileType_CONF;
   procedure AFspclick(Sender: TObject); 
  procedure runscript(const guidstr:string;Sender: TObject);
procedure checkout1(Sender: TObject);
  procedure checkout2(Sender: TObject); 
   
     procedure cleanup;
    procedure checkout(Sender: TObject); 
  
 //     procedure UserFilesExec(Sender: TObject);
 //     procedure UserFilesExecShell(Sender: TObject);
      procedure spclick(Sender: TObject);
    procedure AAFClick(Sender: TObject);
    procedure buttonvcl(Sender: TObject);
        procedure runMULTITASKcommand(CMD,AHint:string);
    procedure xfgcreatemenu;
    procedure freemenu;
    procedure UserFilesExecShell2FileCommander(AHint:String;AAList:TStringlist);
      procedure UserExecVCL(Sender: TObject);
                procedure UserFilesExecShell2(AHint:String;AList:TStringlist);
    procedure PageTo(AMain,AMinor:STRING);
      procedure FilesTO(AMain,AMinor:STRING;MODE:integer;AList:TStrings);
       procedure printHEADER(HEADERSTRING:String);
 procedure printDEBUG(PASSMemo:tmemo;PASSLst:TStrings);
procedure GoToShellFiles(Sender: TObject);

(******************************************************************************************************)
  public
    { Public declarations }
        Af:tform;
   AAF2:TForm; 

  filegardenUserCallingDIR:string;
  datadir:string;
  imagedir:string;
    Function DoCustomCommand(APASSControl:TObject;AParentHint,AHint:String):boolean;

       procedure CheckForm2Refresh;
      procedure runMULTITASKcommandCLICK(Sender: TObject);
procedure CheckStateAfterShellFile(Value:string);
  Function CheckEXEArgument(APASSString,APASSIndent:string):string;
    Function CheckError(APASSStrings:TStrings):Boolean;
   function showmessageFILEOperation(MSGType:integer;PASSFilename:string):integer;
procedure GoToGetProc(Sender: TObject);
       procedure UserExec(Sender: TObject);
   procedure ACreateForm;
    procedure AFreeForm;
  procedure ShellFilesTOSingleAPPLICATION(AMain,AMinor,AJob:STRING;MODE:integer;AList:TStrings);
 procedure APASSUserFilesExec(APASSsenderType,APASSsenderCommand:STRING;APASSLST:TSTRINGS);
     procedure  APASSUserExecVCL(APASSsenderCaption,APASSsenderVCLMethod:STRING;APASSLIST:TSTRINGS);
  procedure RUN_drawThumbnail_TASK(APASSLOCATION:string);
 // procedure RECURSESearchDir(APASSFolder: string; APASSFileNAME: string; APASSLst: TStrings);

  procedure  FileDelete(drawthumbnailMode:integer;APASSLst:TStrings);
 procedure FileCopyMove(Mode:integer;drawthumbnailMode:integer;APASSLst:TStrings);
     procedure DoOpen(Files:Tstrings);
 
       procedure ShellFilesTO(AMain,AMinor,AJob:STRING;MODE:integer;AList:TStrings);
    procedure ShellFilesTOSingleFile(AMain,AMinor,AJob:STRING;MODE:integer;AList:TStrings);
   procedure ShellFilesTOCAT(AMain,AMinor,AJob:STRING;MODE:integer;AList:TStrings);
procedure UserExecCommand(AMain,AMinor:string;sender:TObject);

 procedure checkTHREADupdateFORCONTROL;

property chkbox1: Boolean read Achkbox1;
property AF2: tform read AAF2;
property xfgimagedir:string read imagedir;
//
  end;
  
(******************************************************************************************************)
   const
    redstonedir:string='redstone';
  filegardenDIR:string='FileGarden';
  filegardenDATADIR:string='data';
  filegardenIMAGEDIR:string='image';
 filegardenCONF:string='xfg.conf';
var
 IniFile: TMemIniFile;  
//  IniFile: TMemIniFile ; 
  Form1: TForm1;
 
 MT_DRAW_Thumbnail_TASK_RUNNING:Boolean;
 MT_IMAGE_GET_INFO_TASK_RUNNING:Boolean;

  Critical1: TCriticalSection;
    K:  TPClass_Command_RedStone ;  
       bookletVCL:string;
 APASS_SAVED_directory_filemask:string;
 InfoListViewCurrentDir, ThumbnailCurrentPath,APASS_IMAGE_filemask:string;
  GimageEXTlist:TStringlist;
SystemBusy:Boolean;
implementation

{$R *.xfm}
uses Unit3,Unit2,unit4;
(******************************************************************************************************)
(******************************************************************************************************)
function TForm1.WidgetFlags: Integer; 
begin
  // To reduce flickering on LINUX
  Result := Inherited WidgetFlags or Integer(WidgetFlags_WRepaintNoErase) or Integer(WidgetFlags_WResizeNoErase);
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.Button7Click(Sender: TObject);
var lst:tstringlist;i:integer;str:string;
begin  

//SelectDirectory(const Caption: WideString; const Root: string; var Directory: string; ShowHidden: Boolean = False):

//procedure Insert(const Text: WideString; Select: Boolean = False); overload;
//procedure Insert(const Text: WideString; Column, Row: Integer; Select: Boolean = False); overload;
if xfgmemo.sellength=0 then begin 
str:=K.CRS_WrapText(xfgmemo.text,80);
xfgmemo.clear;
xfgmemo.Insert(str,false);
end;
if xfgmemo.sellength<>0 then begin 
str:=K.CRS_WrapText(xfgmemo.seltext,80);
if str<>'' then
begin
xfgmemo.seltext:='';
xfgmemo.Insert(str,true);
end;
end;
//(*************************************
lst:=tstringlist.create;
//lst.text:=k.CRS_GetgroupNameEntry;
//xfgmemo.lines.add((lst.text));
//lst.clear;
//lst.text:=k.CRS_GetUserNameEntry;
//xfgmemo.lines.add((lst.text));
for i:=0 to 10 do
lst.add((k.CRS_GetGuid));
xfgmemo.lines.add((lst.text));
lst.free;
//****************************************)
end;
 
(******************************************************************************************************)
(******************************************************************************************************)
  procedure  TForm1.CheckForm2Refresh;
  begin
  if form2.FocusedControl=form2.filelist then 
//form2.filelist.refresh;
begin
form2.filelistDoDoubleClick(form2.filelist.directory.location);
form2.filelist.directory.location:=form2.filelist.directory.location;
//form2.filelist.refresh;
end;
if form2.FocusedControl=form2.listview then 
form2.DoListViewFileInfo(form2.xfgcurrentdir);

end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.RunAutoVCL(APASSIniFile:TMemIniFile;Section:string);
var lst:tstringlist;i:integer;APASSMemo:tmemo;
begin
lst:=tstringlist.create;
APASSMemo:=xfgmemo;
if (APASSIniFile<>nil)and (k<>nil) then
begin

//APASSUserExecVCL(senderCaption,senderVCLMethod,xfgmemo.lines);
if APASSIniFile.SectionExists(Section) then
APASSIniFile.readsection(Section,lst)else exit;

for i:=0 to lst.count-1 do
begin
if (ansilowercase(APASSIniFile.readstring(trim(Section),trim(lst[i]),'none'))='%vclinternal%')or
   (ansilowercase(APASSIniFile.readstring(trim(Section),trim(lst[i]),'none'))='%vclexternal%')or
   (ansilowercase(APASSIniFile.readstring(trim(Section),trim(lst[i]),'none'))='vcl')or
   (ansilowercase(APASSIniFile.readstring(trim(Section),trim(lst[i]),'none'))='%dumptovcl%')
    then ;
APASSUserExecVCL(trim(lst[i]),trim(APASSIniFile.readstring(trim(Section),trim(lst[i]),'none')),
                     (APASSMemo as tmemo).lines);
end;

end;

lst.free;
end;
(******************************************************************************************************)
(******************************************************************************************************)

procedure TForm1.FormCreate(Sender: TObject);

var  sr: TSearchRec; 

begin
WidgetFlags;
DoReloadTask:=false;
xfgmemo:=nil;
AF:=nil;
 Critical1 := TCriticalSection.Create;
 sameREALTASKmenuitemNoUpdate:=false;
MT1 :=  nil;
 MT_IMAGE_GET_INFO_TASK_RUNNING:=false;
 MT_DRAW_Thumbnail_TASK_RUNNING:=false;

EXIT_File_Operation:=false;
MT20:=nil;
MT10:=nil;
GimageEXTlist:=nil;
GimageEXTlist:=tstringlist.create;
sameREALTASK:=' ';
ThreadIOKILL:=true;
 ThreadFree:=true;
//MT1.IO:=nil;
 TimeSeparator := '-';       
  ShortTimeFormat := 'hh:mm:ss'; 
DateSeparator := '-';
  ShortDateFormat := 'dd/mm/yyyy'; 
AAF2:=form2;
SystemBusy:=false;
AChkBox1:=false;
or2:=false;

 DEBUG:=false;
 k:=TPClass_Command_RedStone.Create(application.Handle,form1,application.exename);
 iniconf:=k.RS_AppConfigPath+'/'+k.RS_App_Configuration_Name+'.'+k.RS_App_Configuration_Extension;
datadir:= k.RS_APP_data_dir;
imagedir:=k.RS_APP_image_dir;
filegardenUserCallingDIR:=k.RS_Calling_APPPath+'/';
 
(**********************************************************************)
 if FindFirst(datadir+'/'+'*', faAnyFile, sr) = 0 then
    begin
      repeat
       if 

AnsiPos('tobedeleted',Ansilowercase(sr.name))<>0  then  deletefile(datadir+'/'+sr.name);
       if 

AnsiPos('tmp',Ansilowercase(sr.name))<>0  then  deletefile(datadir+'/'+sr.name);
      until FindNext(sr) <> 0;
        FindClose(sr);    
     end;
     
(**********************************************************************)
application.font.name:='helvetica';
if inifile<>nil then inifile.free;




if FileExists(iniconf) 
   then begin
k.crs_copyfile(iniconf,iniconf+'BACKUP',true,true,false);

IniFile := TMemIniFile.Create (iniconf);
if iniFile.sectionexists('IndependentComponentPanel')then
iniFile.erasesection('IndependentComponentPanel');
(************************************)
RunAutoVCL(inifile,'xfgRunVCLBeforeCreate');
(************************************)
update_merge_FileType_CONF;
//IniFile.UpdateFile;


if ansilowercase((IniFile.Readstring ('xfgMain', 'DEBUG', 'none')))='true' then DEBUG:=true;
or2:=false;
bookletVCL:=ansilowercase((IniFile.Readstring ('xfgPrintBooklet', 'menuvcl', 'none')));
sp1.enabled:=false;

panel3.Align:=altop;
 PanelTop:= TPanel.create(form1);
  with PanelTop as tpanel do
  begin
  parent:=form1;
    Left := 0;
   Top := 35;
   // Width := ;
    Height := 25;
    Align := altop;
 BorderStyle:=bsnone;
    BorderWidth := 0;
  TabOrder := 0;
end; 

createpagecontrol;
createts1; 
 xfgmemo.BorderStyle := bsRaisedPanel;

xfgCreateMenu;
xfgCreateMemoPopup;

  pc.ActivePage := ts1;
try

   aaF := TForm.Create (self);
//   form1.caption:=IniFile.ReadString ('xfgMain', 'splash', 'none');
   aaf.bitmap.loadfromfile(IniFile.ReadString ('xfgMain', 'splash', 'none'));
form1.caption:=IniFile.Readstring ('xfgMain', 'owner', 'none');//
         aaf.top:=100;//
        aaf.left:=100;
        aaf.height:=aaf.bitmap.height;
        aaf.width:=aaf.bitmap.width*2;
      //  aaf.BorderStyle:=(fbsNone);
          aaf.Color :=11306588;
//
    aaf.formstyle:=fsstayontop;
       aaf.onclick:=aafclick;
     if aaF.Showmodal=mrok then begin
     aaf.close;end;
  finally
     aaf.free;;
 //  aaf.show;
  end;
    
 //       Libc.system(pchar('sleep 0.5'));//
        
StatusBar1.visible:=false;
  

    Top := IniFile.ReadInteger ('xfgMain', 'Top', Top);
   Left := IniFile.ReadInteger ('xfgMain', 'Left', Left);
   Width := IniFile.ReadInteger ('xfgMain', 'Width', Width);
  form1.height:=560;
  form1.Constraints.MinHeight := form1.height;
  form1.Constraints.MinWidth := screen.width;
  form1. Constraints.MaxWidth := screen.width;
  form1.Constraints.MaxHeight := screen.Height;
  form1. Width := screen.width;
  form1.Height := form1.Constraints.MinHeight ;
 
CheckBox4:=TCheckBox.create(GroupBox1);
with CheckBox4 as TCheckBox do
begin
parent:=GroupBox1;
        Left := 8;
        Top := 88;
        
        Height := 30;
        Caption := 'Use recycle bin';
      //  TabOrder := 2;
        width:=140;
        enabled:=true;
end;
checkbox1.checked:=false;
checkbox2.checked:=false;
checkbox3.checked:=true;
if inifile.ReadBool('xfgMain','Always_Use_RecycleBin',true)=true then
CheckBox4.checked:=true else
CheckBox4.checked:=false;


//panel3.caption:='xfgSpeedButton';

(************************************)
RunAutoVCL(inifile,'xfgRunVCLAfterCreate');
(************************************)
end;//if FileExists(GetEnvironmentVariable('HOME')+'/'+redstonedir+'/'+filegardenDIR+'/'+filegardenCONF)=true 

if FileExists(GetEnvironmentVariable('HOME')+'/'+redstonedir+'/'+filegardenDIR+'/'+filegardenCONF)=false  
then begin

try
   MessageDlg ('Can''t find or corrupted xfg.conf'+#13#10+'FileGarden will now die.', mtInformation, [mbOK], 0);
 //  k.LoadCompVCL('install',Application.ExeName,nil);
Randomize;
//ram:=K.RS_mainpath+'ToBeDeleted'+inttostr(Random(9628));
// ram:=datadir+'/'+ExtractFileName(Application.ExeName)+inttostr(Random(9628));
//filecreate(ram);
//application.terminate;
// ss:=k.RS_SysPath+'Command_Redstone '+'install '
      //     +Application.ExeName+' -ns &';
Libc.system(pchar('filegarden-install &'));
 

finally
application.terminate;
 Critical1.Free;
  if aaf<>nil then aaf.Free;
   if k<>nil then k.Free;
  if inifile<>nil then inifile.free;
   if af<>nil then af.free;
  
end;//
end;


end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.GetActiveMEMO;
var
  I,index,Awrapvalue: Integer;  
  ACOMP: TControl;
  AAlign:TAlignment;
//  AWrapmode:TWrapMode;
//MemoConfigurationControlsOnChange
begin
  for index := PC.activepage.ControlCount - 1 downto 0 do
  begin
   
    ACOMP := pc.activepage.Controls[index];
    if  (ACOMP is TMEMO) then
    begin
     xfgmemo:=(ACOMP as tmemo);
 //  xfgmemo.name:='activememo';
end;//if PanelTop.Controls[I] is tcombobox then   
   
    end;  
    

     for I := PanelTop.ControlCount - 1 downto 0 do
 begin
if PanelTop.Controls[I] is tcombobox then
begin
  (PanelTop.Controls[I] as tcombobox).itemindex:=0;
  if trim(ansilowercase(PanelTop.Controls[I].name))='comboboxpoints'
  then (PanelTop.Controls[I] as tcombobox).text:=inttostr(xfgmemo.font.size);
  if trim(ansilowercase(PanelTop.Controls[I].name))='comboboxfonts'
  then begin (PanelTop.Controls[I] as tcombobox).text:=xfgmemo.font.name;
  end;
  if trim(ansilowercase(PanelTop.Controls[I].name))='comboboxcolumn'
  then begin
  //(PanelTop.Controls[I] as tcombobox).text:='none';
  //AWrapmode:=xfgmemo.wrapmode;
  //if xfgmemo.wordwrap=true then
  Awrapvalue:=xfgmemo.WrapAtValue;
  //if AWrapmode=wmColumn then
  if Awrapvalue<>-1 then
  (PanelTop.Controls[I] as tcombobox).text:=inttostr(Awrapvalue);
  //if AWrapmode=wmNone then
  //(PanelTop.Controls[I] as tcombobox).text:='none';
  //continue;
  end;
  if trim(ansilowercase(PanelTop.Controls[I].name))='comboboxalignment'
  then begin
  (PanelTop.Controls[I] as tcombobox).itemindex:=0;
  AAlign:=xfgmemo.Alignment;
  if AAlign=taLeftJustify then
  (PanelTop.Controls[I] as tcombobox).text:='Left';
  if AAlign=taRightJustify then
  (PanelTop.Controls[I] as tcombobox).text:='Right';
  if AAlign=taCenter then
  (PanelTop.Controls[I] as tcombobox).text:='Center';
   //continue;
  end;  
 end;//if PanelTop.Controls[I] is tcombobox then
  end;//for I := PanelTop.ControlCount - 1 downto 0 do   
  

end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.PageControlChange(Sender: TObject);
begin
    
GetActiveMEMO;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure  TForm1. TabSheetOnShow(Sender: TObject);   
begin
//GetActiveMEMO;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.createpagecontrol; 
begin
PanelCenter:= TPanel.create(form1);
  with PanelCenter as tpanel do
  begin
  parent:=form1;
    Left := 300;
   Top := 300;
    Width := 300;
    Height := 25;
    Align := alClient;
 BorderStyle:=bsnone;
    BorderWidth := 0;
  TabOrder := 0;
end; 
PanelMid:= TPanel.create(form1);
  with PanelMid as tpanel do
  begin
  parent:=PanelCenter;
    Left := 300;
   Top := 300;
    Width := 300;
    Height := 25;
    Align := altop;
 BorderStyle:=bsnone;
    BorderWidth := 0;
  TabOrder := 0;
end; 
pc:=tpagecontrol.create(form1) ;
 with pc do begin
 pc.parent:=PanelCenter;
  Left := 100;
    Top := 0;
    Width := 609;
    Height := 512;
    ActivePage := ts1;
    Align := alClient;
    TabHeight := 20;
    TabOrder := 1;
    TabWidth := 0;
    //style:=(tsRounded);
    MultiLine:=true;
    font.size:=11;
    font.name:='Helvetica';//'SANS';//'Helvetica';
    HotTrack:=true;
    showframe:=true;
OnChange:=PageControlChange;
      
 end;
 

 end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.createts1; 
var  I: Integer;  
//  ACOMP: TControl;
begin
 for I := PanelTop.ControlCount - 1 downto 0 do
if PanelTop.Controls[I] is tcombobox then
(PanelTop.Controls[I] as tcombobox).itemindex:=0;


 ts1:=TTabSheet.Create(pc);
  //    with ts1 as ttabsheet do
   //   begin
   ts1.PageControl := pc;
   ts1.caption:='  NewPage  ';  
   ts1.borderwidth:=2;
//ts1.OnShow:=TabSheetOnShow;
xfgmemo:= TMemo.create(form1);
with xfgmemo as tmemo do
begin
      parent:=ts1;
      Left := 2;
      Top := 2;
      Width := 610;
      Height := 428;
      Align := alClient;
      
      Color := clWhite;
      Font.Color := clblack;
      Font.Height := 12;
      BorderStyle := bsRaisedPanel;
      alignment:=taLeftJustify;
      wrapmode:=wmNone;
      WrapBreak :=wbWhitespace;
      wordWrap := false;
      
      
      fontdialog1.font:=font;
      Font.Pitch := fpVariable;
      Font.Style := [];
      //ParentFont := False;
      ScrollBars := ssBoth;
      TabOrder := 0;
      undolevels:=255;
      xfgmemo.popupmenu:=xfgmemopopup;
      Font.Name := 'adobe-courier';
      Font.size:=12;
end;
//end;

      



end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.MyTableClick(Sender: TObject);
var parentMenu:tmenu;ID:integer;
 ini:TMemIniFile;ss,Qstr,Qstr1,Dstr1,Dstr2:string;TempINI,Kini:TMemIniFile;
//mm:tmenuitem;
i:integer;
l:tstringlist;
begin
ini:=nil;
//popup.name:='popup';
//fileinfopopup.name:='fileinfopopup';
parentMenu:=(sender as tmenuitem).GetParentMenu;
ss:=stringreplace(inifile.readstring('xfgFileInputMenu','My Table','%xfgOnMyTable%'),
AnsiLowercase('%xfgOnMyTable%'),'',[rfReplaceAll, rfIgnoreCase]);
if fileexists(k.RS_USER_RESOURCE_PATH+'/'+ss) then
begin

ini:=TMemIniFile.create(k.RS_USER_RESOURCE_PATH+'/'+ss);
ss:=ini.readstring((sender as tmenuitem).parent.hint,(sender as tmenuitem).hint,'none');


//if parentMenu.name='popup' then
//begin

if AnsiLowercase((sender as tmenuitem).hint)='add new ...' then
begin
if AnsiLowercase((sender as tmenuitem).parent.hint)='my table' then
begin
Qstr:='';
Dstr1:='';
Dstr1:=ini.readstring('MenuDialog','Name','Enter New My Table Label ...');
Qstr:=K.CRS_InputQuery((sender as tmenuitem).hint,Dstr1,'',false);
if not (trim(Qstr)='') then
begin
ini.writestring('Menu',Qstr,'%CREATENEW%');
ID:=MessageDlg ('Is '+Qstr+' a favorite holder for disk files or folders'+#13#10+
'if you click No , '+Qstr+' will be a favorite holder for executable programs'+#13#10
,mtinformation, [mbYes,mbNo], 0);
if ID=mrYes then
begin
ini.writestring('MenuTypeIsItems',Qstr,'1');
ini.writestring('MenuImage',Qstr,ini.readstring('Main','QuickFolderImage','none'));
end
else
if ID=mrNo then
begin
ini.writestring('MenuTypeIsItems',Qstr,'0');
ini.writestring('MenuImage',Qstr,ini.readstring('Main','QuickExecImage','none'));
end;

   if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')else
  if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties');
libc.system(pchar('cp '+stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])+' '
                       +k.RS_APP_data_dir+'/'+'xfg0001.do'));
TempINI:=TMemIniFile.create(k.RS_APP_data_dir+'/'+'xfg0001.do');
TempINI.writestring((sender as tmenuitem).parent.hint+'Manage',Qstr,'1');
TempINI.writestring(Qstr+'Manage','','');
TempINI.DeleteKey(Qstr+'Manage','');
TempINI.updatefile;
libc.system(pchar('cp '+k.RS_APP_data_dir+'/'+'xfg0001.do'+' '
                       +stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])));

TempINI.free;
Kini.free;

ini.UpdateFile; 
form2.popup.items.clear;
form2.createpopup(form2.popup);
form2.filelist.popupmenu:=form2.popup;
form2.fileinfopopup.items.clear;
form2.createpopup(form2.fileinfopopup);
form2.Listview.popupmenu:=form2.fileinfopopup;
end; 
end else
if (ini.valueexists('Menu',(sender as tmenuitem).parent.hint))and 
(ini.readBool('MenuTypeIsItems',(sender as tmenuitem).parent.hint,false))then
begin
Qstr:='';
Dstr1:='';
Dstr1:=ini.readstring('SubMenuDialog','Name','Enter New Label ...');
Qstr:=K.CRS_InputQuery((sender as tmenuitem).hint,Dstr1+' for '+
(sender as tmenuitem).parent.hint,'',false);
if not (trim(Qstr)='') then
begin
ini.writestring((sender as tmenuitem).parent.hint,Qstr,'%CREATENEW%');
ini.writestring((sender as tmenuitem).parent.hint+'Image',Qstr,
ini.readstring('MenuImage',(sender as tmenuitem).parent.hint,'none'));
ini.UpdateFile; 

   if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')else
  if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties');
libc.system(pchar('cp '+stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])+' '
                       +k.RS_APP_data_dir+'/'+'xfg0001.do'));
TempINI:=TMemIniFile.create(k.RS_APP_data_dir+'/'+'xfg0001.do');
TempINI.writestring((sender as tmenuitem).parent.hint+'Manage',Qstr,'1');
TempINI.writestring(Qstr+'Manage','','');
TempINI.DeleteKey(Qstr+'Manage','');
TempINI.updatefile;
libc.system(pchar('cp '+k.RS_APP_data_dir+'/'+'xfg0001.do'+' '
                       +stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])));

TempINI.free;
Kini.free;

form2.popup.items.clear;
form2.createpopup(form2.popup);
form2.filelist.popupmenu:=form2.popup;
form2.fileinfopopup.items.clear;
form2.createpopup(form2.fileinfopopup);
form2.Listview.popupmenu:=form2.fileinfopopup;
end; 
end
else
if ini.valueexists('MenuTypeIsItems',(sender as tmenuitem).parent.hint)then
begin
if not (ini.readBool('MenuTypeIsItems',(sender as tmenuitem).parent.hint,false))
then
begin
Qstr:='';
Dstr1:='';
Dstr2:='';
Dstr1:=ini.readstring((sender as tmenuitem).hint+'Dialog','Name','Add new name ...');
Dstr2:=ini.readstring((sender as tmenuitem).hint+'Dialog','Command','Enter command to execute ...');
//   Function CRS_InputQuery(QTitle,QCaption,QDefaultStr:string;QMode:Boolean):string; 
Qstr:=K.CRS_InputQuery((sender as tmenuitem).hint,Dstr1,'',false);

if not (trim(Qstr)='') then
begin
ini.writestring((sender as tmenuitem).parent.hint,Qstr,'none');
Qstr1:='';
Qstr1:=trim(Qstr);
if (AnsiLowercase(Dstr2)='enter command to execute ...') then
begin
Qstr:='';
Qstr:=K.CRS_InputQuery((sender as tmenuitem).hint,Dstr2,'',false);
end;
if not (trim(Qstr)='') then
begin
ini.writestring((sender as tmenuitem).parent.hint,Qstr1,Qstr);
ini.writestring((sender as tmenuitem).parent.hint+'Image',Qstr1,
ini.readstring('MenuImage',(sender as tmenuitem).parent.hint,'none'));
ini.UpdateFile; 
(*
   if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')else
  if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties');
libc.system(pchar('cp '+stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])+' '
                       +k.RS_APP_data_dir+'/'+'xfg0001.do'));
TempINI:=TMemIniFile.create(k.RS_APP_data_dir+'/'+'xfg0001.do');
//TempINI.writestring((sender as tmenuitem).parent.hint+'Manage',Qstr,'1');
//TempINI.writestring(Qstr+'Manage','','');

TempINI.updatefile;
libc.system(pchar('cp '+k.RS_APP_data_dir+'/'+'xfg0001.do'+' '
                       +stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])));

TempINI.free;
Kini.free;
*)
form2.popup.items.clear;
form2.createpopup(form2.popup);
form2.filelist.popupmenu:=form2.popup;
form2.fileinfopopup.items.clear;
form2.createpopup(form2.fileinfopopup);
form2.Listview.popupmenu:=form2.fileinfopopup;
end else
begin
if ini<>nil then ini.free;
exit;
end;
end else
begin
if ini<>nil then ini.free;
exit;
end;

if ini<>nil then ini.free;
exit;
end;
end
else
begin

//popup.name:='popup';
//fileinfopopup.name:='fileinfopopup';
if form2.internallist.count=0 then 
begin
if parentMenu.name='popup' then
begin
ini.writestring((sender as tmenuitem).parent.hint+'Image',form2.filelist.directory.location,
ini.readstring('MenuImage',(sender as tmenuitem).parent.hint,ini.readstring('Main','DirItemImage','none')));
ini.writestring((sender as tmenuitem).parent.hint,form2.filelist.directory.location,form2.filelist.directory.location);
end
else if parentMenu.name='fileinfopopup' then
begin
ini.writestring((sender as tmenuitem).parent.hint+'Image',form2.cmb.text,
ini.readstring('MenuImage',(sender as tmenuitem).parent.hint,ini.readstring('Main','DirItemImage','none')));
ini.writestring((sender as tmenuitem).parent.hint,form2.cmb.text,form2.cmb.text);
end;
end
else
for i:=0 to form2.internallist.count-1 do
begin
ini.writestring((sender as tmenuitem).parent.hint,form2.internallist[i],form2.internallist[i]);
if directoryexists(form2.internallist[i])then
ini.writestring((sender as tmenuitem).parent.hint+'Image',form2.internallist[i],
ini.readstring('MenuImage',(sender as tmenuitem).parent.hint,ini.readstring('Main','DirItemImage','none')))
else
if fileexists(form2.internallist[i])then
ini.writestring((sender as tmenuitem).parent.hint+'Image',form2.internallist[i],
ini.readstring('MenuImage',(sender as tmenuitem).parent.hint,ini.readstring('Main','FileItemImage','none')))

end;
ini.UpdateFile;
form2.popup.items.clear;
form2.createpopup(form2.popup);
form2.filelist.popupmenu:=form2.popup;
form2.fileinfopopup.items.clear;
form2.createpopup(form2.fileinfopopup);
form2.Listview.popupmenu:=form2.fileinfopopup;
end;
end else
if AnsiLowercase((sender as tmenuitem).hint)=AnsiLowercase((sender as tmenuitem).parent.hint)+
'manage' then
begin
try
l:=tstringlist.create;
  if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')else
  if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties');
libc.system(pchar('cp '+stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])+' '
                       +k.RS_APP_data_dir+'/'+'xfg0001.do'));
TempINI:=TMemIniFile.create(k.RS_APP_data_dir+'/'+'xfg0001.do');

if INI.sectionexists('defaultviewfile')then INI.erasesection('defaultviewfile');
if TempINI.sectionexists('defaultviewfile')then TempINI.erasesection('defaultviewfile');
//stringreplace((sender as tmenuitem).hint,'Manage','',[rfReplaceAll, rfIgnoreCase])
//TempINI.readsection((sender as tmenuitem).hint,l);
INI.readsection(stringreplace((sender as tmenuitem).hint,'Manage','',[rfReplaceAll, rfIgnoreCase]),l);
for i:=0 to l.count-1 do
begin
TempINI.writestring('defaultviewfile',l[i],'1');
INI.writestring('defaultviewfile',l[i],'1');
end;
TempINI.updatefile;
INI.updatefile;
libc.system(pchar('cp '+k.RS_APP_data_dir+'/'+'xfg0001.do'+' '
                       +stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])));

TempINI.free;
Kini.free;
l.clear;
l.assign((xfgmemo).lines); 
ini.free;
k.LoadCompVCL('My TableManage',filegardenUserCallingDIR+extractfilename(application.exename),l);
finally
begin
ss:=stringreplace(inifile.readstring('xfgFileInputMenu','My Table','%xfgOnMyTable%'),
AnsiLowercase('%xfgOnMyTable%'),'',[rfReplaceAll, rfIgnoreCase]);
if fileexists(k.RS_USER_RESOURCE_PATH+'/'+ss) then
begin

ini:=TMemIniFile.create(k.RS_USER_RESOURCE_PATH+'/'+ss);
end;
l.free;
end;
end;
end else

begin
if ini.valueexists('MenuTypeIsItems',(sender as tmenuitem).parent.hint)then
begin
if  (ini.readBool('MenuTypeIsTerminal',(sender as tmenuitem).parent.hint,true)=true)and
(ini.readBool('MenuTypeIsItems',(sender as tmenuitem).parent.hint,false)=true)
then 
begin
libc.system (pchar('xterm -hold -e '+ ini.readstring((sender as tmenuitem).parent.hint,
(sender as tmenuitem).hint,'none')+' &'));
if ini<>nil then ini.free;
exit;
end else

if ini.readBool('MenuTypeIsItems',(sender as tmenuitem).parent.hint,false)=false
then 
begin

libc.system (pchar(ini.readstring((sender as tmenuitem).parent.hint,(sender as tmenuitem).hint,'none')+' &'));
if ini<>nil then ini.free;
exit;
end;
end
else 
begin


if directoryexists(ss) then 
begin
if parentMenu.name='popup' then
begin
form2.filelistDoDoubleClick(ss);
form2.filelist.directory.location:=ss;
end else
if parentMenu.name='fileinfopopup' then
begin
form2.DoListViewFileInfo(ss);
end;
end else
if fileexists(ss) then 
begin
if parentMenu.name='popup' then
begin
form2.filelist.directory.location:=ExtractFileDir(ss);
form2.filelist.FindItemByText(extractfilename(ss)).Selected:=true;
form2.filelist.EnsureItemVisible(form2.filelist.Selected);
end else
if parentMenu.name='fileinfopopup' then
begin
form2.DoListViewFileInfo(ExtractFileDir(ss));
form2.listview.FindCaption(0,ExtractFilename(ss) ,false, true, true).Selected:=true;
form2.listview.selected.MakeVisible;
end;
end;
end;
end;


end;

if ini<>nil then ini.free;

end;
(******************************************************************************************************)
(******************************************************************************************************)

procedure TForm1.MyTableCreateMenu(Sender: TObject;APASSmenuitem:Tmenuitem);
/////////////////////////////////////////////////////////////////////////////////////////////
function CreateMyTableSetup(AIni:TMemIniFile;APASSmenu:Tmenuitem):Boolean;
 var 
    i:integer;
    Aimgfile,ss:string;
    AAmm:TMenuItem;
//    TempINI:TMemIniFile;
begin

//ss:=AIni.readstring((sender as tmenuitem).parent.hint,(sender as tmenuitem).hint,'none');
//TempINI:=TMemIniFile.create(RS_Redstone_UserSysCompIni);
for i:=0 to 2 do
begin
  AAmm:=TMenuItem.create(APASSmenu);
   with AAmm as TMenuItem do
    begin
    if i=0 then ss:='Add new ...';
    if i=1 then ss:='Manage ...';
    if i=2 then ss:='-' ;
(*
[Main]
MenuImage=
Add new ...Image=
Manage ...Image=
FileItemImage=
DirItemImage=
*)
   Caption := ss;
   if i=1 then
   begin
   Hint := APASSmenu.hint+'Manage' ;
   end else
   
   Hint :=  ss;   
   
   Aimgfile:=AIni.readstring('Main',ss+'Image','none');
   if fileexists(Aimgfile)then
   bitmap.loadfromfile(Aimgfile);
         enabled:=true;
         visible:=true;     
       
  end;  
   APASSmenu.add(AAmm); 
   AAmm.onclick:=MyTableClick;
end;    

end;
/////////////////////////////////////////////////////////////////////////////////////////////
function MyTableCreateNew(AIni:TMemIniFile;APASSCreateNewMenuitem:Tmenuitem):Boolean;
 var 
    i:integer;
    Al:tstringlist;
    Aimgfile:string;
    Amm:TMenuItem;
    TempINI,Kini:TMemIniFile;
begin
Aimgfile:='';
Al:=nil;
Al:=tstringlist.create;
Aini.readsection(APASSCreateNewMenuitem.hint,Al);
CreateMyTableSetup(AIni,APASSCreateNewMenuitem);
for i:=0 to Al.count-1 do
begin 
  Amm:=TMenuItem.create(APASSCreateNewMenuitem);
   with Amm as TMenuItem do
    begin
 
  if AnsiPos('-seperator',AnsiLowercase(Al.strings[i]))>0 then 
   Caption := '-' else
      Caption := Al.strings[i];
   Hint := Al.strings[i];
    APASSCreateNewMenuitem.add(Amm);
     enabled:=true;
         visible:=true;
     
   if fileexists(Aini.readstring(Amm.parent.hint+'Image',Al.strings[i],'none'))then
    Aimgfile:=Aini.readstring(Amm.parent.hint+'Image',Al.strings[i],'none')else
    begin
   if directoryexists(Al.strings[i])then
   begin
   
     Aimgfile:=Aini.readstring('Main','DirItemImage','none');
 Aini.writestring(Amm.parent.hint+'Image',Al.strings[i],Aimgfile);
 Aini.updatefile;
     end else
    if fileexists(Al.strings[i])then
    begin
     Aimgfile:=Aini.readstring('Main','FileItemImage','none');
     Aini.writestring(Amm.parent.hint+'Image',Al.strings[i],Aimgfile);
     Aini.updatefile;
     end;
     end;
   if fileexists(Aimgfile)then
   bitmap.loadfromfile(Aimgfile);
    
     end;       
  
 if AnsiLowercase(Aini.readstring(APASSCreateNewMenuitem.hint,Al.strings[i],'none'))='%createnew%' then
 begin
   if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')else
  if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties')then
Kini:=TMemIniFile.create(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties');
libc.system(pchar('cp '+stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])+' '
                       +k.RS_APP_data_dir+'/'+'xfg0001.do'));
TempINI:=TMemIniFile.create(k.RS_APP_data_dir+'/'+'xfg0001.do');
TempINI.writestring(Amm.hint+'Manage',Al.strings[i],'1');
TempINI.updatefile;
libc.system(pchar('cp '+k.RS_APP_data_dir+'/'+'xfg0001.do'+' '
                       +stringreplace(Kini.readstring('Getdefaultviewfile',
'My TableManage','none'),'[HOME]','~',[rfReplaceAll, rfIgnoreCase])));

TempINI.free;
Kini.free;
 MyTableCreateNew(Aini,Amm);
 end else
 Amm.onclick:=MyTableClick;

end;
if Al<>nil then Al.free;

end;
/////////////////////////////////////////////////////////////////////////////////////////////

   var 
    i:integer;
    l:tstringlist;
 // mi:tmenuitem;
    ss:string;
  mm:TMenuItem;
  Aimgfile:string;
  ini:TMemIniFile;
begin
ini:=nil;
l:=nil;
//popup.name:='popup';
//fileinfopopup.name:='fileinfopopup';
//if trim(AnsiLowercase(inifile.Readstring ('xfgFileInputMenu', l.Strings[i], 'none')))='%xfgonmytable%' 
l:=tstringlist.create;
ss:=stringreplace(inifile.readstring('xfgFileInputMenu',APASSmenuitem.hint,'%xfgOnMyTable%'),
AnsiLowercase('%xfgOnMyTable%'),'',[rfReplaceAll, rfIgnoreCase]);
//xfgmemo.lines.add(k.RS_USER_RESOURCE_PATH+'/'+ss);
if ((sender as tpopupmenu).name='popup' )or ((sender as tpopupmenu).name='fileinfopopup' )then
begin
ss:=stringreplace(inifile.readstring('xfgFileInputMenu',APASSmenuitem.hint,'%xfgOnMyTable%'),
AnsiLowercase('%xfgOnMyTable%'),'',[rfReplaceAll, rfIgnoreCase]);
if fileexists(k.RS_USER_RESOURCE_PATH+'/'+ss) then
begin
//
ini:=TMemIniFile.create(k.RS_USER_RESOURCE_PATH+'/'+ss);
ini.readsection('Menu',l);
CreateMyTableSetup(ini,APASSmenuitem);
for i:=0 to l.count-1 do
begin 
  mm:=TMenuItem.create(APASSmenuitem);
   with mm as TMenuItem do
    begin
  if AnsiPos('-seperator',AnsiLowercase(l.strings[i]))>0 then 
   Caption := '-' else
      Caption := l.strings[i];
   Hint := l.strings[i];
      Aimgfile:=ini.readstring('MenuImage',l.strings[i],'none');
      if fileexists(Aimgfile)then
      bitmap.loadfromfile(Aimgfile);
         enabled:=true;
         visible:=true;
       
  end;       
 APASSmenuitem.add(mm);
 if AnsiLowercase(ini.readstring('Menu',l.strings[i],'none'))='%createnew%' then
 MyTableCreateNew(ini,mm);
 continue;
end;
end;

end;//if fileexists(RS_OnMyTablePath+'/'+ss) then

if l<>nil then l.free;
if ini<>nil then ini.free;
end;
(******************************************************************************************************)
(******************************************************************************************************)

procedure TForm1.ReloadMenuClick(Sender: TObject);
var i,ii:integer;
begin
// form2.show;
 sameREALTASKmenuitemNoUpdate:=false;
checkTHREADupdateFORCONTROL;
if sameREALTASKmenuitemNoUpdate=true then begin
 MessageDlg ('Reload configurations will now die because of '+#13#10+'" ' +
             sameREALTASK+' "', mtInformation, [mbOK], 0);
exit;end;

//freemenu;
DoReloadTask:=true;
if MessageDlg ('Reload configuration file'+#13#10+
             iniconf, mtWarning, [mbOK,mbNo], 0)=mrNo then exit;
try

 for I := PanelTop.ControlCount - 1 downto 0  do
 begin
 PanelTop.Controls[I].free;
  end;
 for I := PanelMid.ControlCount - 1 downto 0  do
  PanelMid.Controls[I].free;
    
 for I := form2.ComponentCount - 1 downto 0 do
  begin
  if (form2.Components[I] is TPanel) then
  if not(inifile.valueexists('IndependentComponentPanel',form2.Components[I].name))then
   begin
    for II := (form2.Components[I] as tpanel).ControlCount - 1 downto 0  do
 begin
 if ((form2.Components[I] as tpanel).Controls[II] is Tspeedbutton) then
     (form2.Components[I] as tpanel).Controls[II].free;
  end;




 //   if (form2.Components[I] is Tspeedbutton) then
 //   begin
 //   form2.Components[I].free;
 //   end;
    end;
  end; 
 application.processmessages;
// form2.hide;             
update_merge_FileType_CONF;
IniFile.UpdateFile;
form2.createimglist;     
    
xfgcreatemenu;   
 
xfgmemopopup.free;
xfgCreateMemoPopup;
form2.popup.items.clear;
form2.createpopup(form2.popup);
form2.filelist.popupmenu:=form2.popup;
form2.fileinfopopup.items.clear;
form2.createpopup(form2.fileinfopopup);
form2.Listview.popupmenu:=form2.fileinfopopup;
 
form2.createspeedbutton;

(*
//APASS_IMAGE_filemask:='';
imageEXTlist:=tstringlist.create;
inifile.readsection('xfgImageEXT',imageEXTlist);
for i:=0 to imageEXTlist.count-1 do
begin
APASS_IMAGE_filemask:=APASS_IMAGE_filemask+'*.'+imageEXTlist.strings[i]+';';
end;
imageEXTlist.free;
*)
// form2.show;
 
//(*
(form2.ListView).Color := stringtocolor(inifile.Readstring ('xfgMain', 'Filemanager_ListView_BGColor', 'none'));
//font.Color := 8940896;
(form2.ListView as tListView).Font.Color := stringtocolor(inifile.Readstring ('xfgMain', 'Filemanager_ListView_FGColor', 'none'));
 //  font.name:= 'Lucida';
(form2.ListView).font.name:= (inifile.Readstring ('xfgMain', 'Filemanager_ListView_FontName', 'none'));
//font.size:=11;
(form2.ListView).font.size:=strtoint(inifile.Readstring ('xfgMain', 'Filemanager_ListView_FontSize', 'none'));

(form2.filelist).Color := stringtocolor(inifile.Readstring ('xfgMain', 'Filemanager_IconView_BGColor', 'none'));
//font.Color := 8940896;
(form2.filelist).Font.Color := stringtocolor(inifile.Readstring ('xfgMain', 'Filemanager_IconView_FGColor', 'none'));
 //  font.name:= 'Lucida';
(form2.filelist).font.name:= (inifile.Readstring ('xfgMain', 'Filemanager_IconView_FontName', 'none'));
//font.size:=11;
(form2.filelist).font.size:=strtoint(inifile.Readstring ('xfgMain', 'Filemanager_IconView_FontSize', 'none'));
//*) 
//checkbox4.checked:=inifile.ReadBool('xfgMain','Always_Use_RecycleBin',true);
except
DoReloadTask:=false;

end;
DoReloadTask:=false;

end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.freemenu;
var i:integer;
begin
mainmenu1.items.clear;

 for I := form1.panel3.ControlCount - 1 downto 0 do
  begin
    if (form1.panel3.Controls[I] is Tspeedbutton) then
    begin
if (form1.panel3.Controls[I].name = 'SpeedButton1')then continue else
if (form1.panel3.Controls[I].name = 'SpeedButton2')then continue else
if (form1.panel3.Controls[I].name = 'SpeedButton3')then continue else
if (form1.panel3.Controls[I].name = 'SpeedButton4')then continue else
if (form1.panel3.Controls[I].name = 'SpeedButton5')then continue else
    form1.panel3.Controls[I].free;
    end;
  end;
 
(*********************************
  for I := ComponentCount - 1 downto 0 do
  begin
    c:= Components[I];
    if (c is Tspeedbutton) then
    begin
if (c.name = 'SpeedButton1')then continue;
if (c.name = 'SpeedButton2')then continue;
if (c.name = 'SpeedButton3')then continue;
if (c.name = 'SpeedButton4')then continue;
if (c.name = 'SpeedButton5')then continue;
    c.free;
    //   RemoveComponent(c);
     // DataModule2.InsertComponent(Temp);//
    end;
  end;
 ***************************) 
 

 //MessageDlg ('Reload Menu', mtInformation, [mbOK], 0);
//xfgcreatemenu;   
 
end;
(******************************************************************************************************)
(******************************************************************************************************)
 procedure TForm1.ExecuteDocumentOnClick(Sender: TObject);
 var FileTypeEXE,filestr,filestr1,orig,exec:string; lst:tstringlist;tempMM:tmenuitem;
 begin
 orig:=(Sender as tmenuitem).hint;
 
or2:=true;

 
if fileexists(extractfilepath((Sender as tmenuitem).hint)+'XFGMemoInsertCommand') then
begin
filestr:=k.CRS_extractfileext((Sender as tmenuitem).hint);
filestr1:=extractfilename((Sender as tmenuitem).hint);
system.delete(filestr1,AnsiPos(filestr,filestr1),length(filestr));
(Sender as tmenuitem).hint:=filestr1;
tempMM:=nil;
tempMM:=(Sender as TMenuItem);
repeat
tempMM:=tempMM.parent;
until tempMM.hint<>'More ...';

exec:=IniFile.Readstring (tempMM.hint, (Sender as TMenuItem).hint, 'none');

//xfgmemo.lines.add(exec);
//xfgmemo.lines.add(extractfilepath((Sender as tmenuitem).hint)+'XFGMemoInsertCommand');
//UserExec((Sender as tmenuitem));
GetCustomCommandFrom_CRS(exec,(Sender as tmenuitem).hint);
(Sender as tmenuitem).hint:=orig;
exit;
end ;
lst:=tstringlist.create;
try
screen.cursor:=crhourglass;
FileTypeEXE:=inifile.Readstring ('xfgFileTypeIconImage',
Copy(ansilowercase(K.CRS_extractfileExt((Sender as tmenuitem).hint)), 
2, length(ansilowercase(K.CRS_extractfileExt( (Sender as tmenuitem).hint)))-1),'none');
if FileTypeEXE='none' then 
FileTypeEXE:=inifile.Readstring ('xfgFileTypeIconImage',
Copy(ansilowercase(extractfileExt((Sender as tmenuitem).hint)), 
2, length(ansilowercase(extractfileExt( (Sender as tmenuitem).hint)))-1),'none');

lst.add((Sender as tmenuitem).hint);   
if directoryexists((Sender as tmenuitem).hint) then 
form1.ShellFilesTO('',inifile.Readstring ('xfgFileTypeExecution','%folder%','none'),'',1,lst)else
if FileTypeEXE='none' then 

begin                                       
doopen(lst);
end else

begin


if 

AnsiPos('!in',IniFile.Readstring ('xfgFileTypeExecution',FileTypeEXE, 'none')) > 0 then 
form1.ShellFilesTOCAT('',inifile.Readstring ('xfgFileTypeExecution',FileTypeEXE,'none'),'',1,lst);

if 

AnsiPos('$in',IniFile.Readstring ('xfgFileTypeExecution',FileTypeEXE, 'none')) > 0 then 
form1.ShellFilesTOSingleAPPLICATION('',IniFile.Readstring ('xfgFileTypeExecution',FileTypeEXE, 'none'),'',1,lst);

if 

AnsiPos('%in',IniFile.Readstring ('xfgFileTypeExecution',FileTypeEXE, 'none')) > 0 then 
form1.ShellFilesTO('',IniFile.Readstring ('xfgFileTypeExecution',FileTypeEXE, 'none'),'',1,lst);
end;
//pc.activepage.caption:='  '+(Sender as tmenuitem).caption+'  ';
finally
//if (sender as tmenuitem).parent.count>0 then (sender as tmenuitem).parent.clear;
lst.free;
(Sender as tmenuitem).hint:=orig;
screen.cursor:=crdefault;
end;

end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure Tform1.DoCustomCommandClick(Sender: TObject);
var  SystemStr,s1:string;
begin
try
screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
 or2:=true;
   if  (ansipos(ansiLowercase('%PROC%'),
    ansilowercase((trim((IniFile.Readstring ('WorkShellFile',(sender as tmenuitem ).parent.hint,
 'none'))))))<>0)then 
 begin
  s1:=(trim((StringReplace(IniFile.Readstring ('WorkShellFile',(sender as tmenuitem ).parent.hint,
 'none'),'%','=',[rfIgnoreCase,rfReplaceAll]))));
runscript(k.CRS_GetParamAtPos('[temp'+s1+']','[',']','=',3),Sender as tmenuitem);
if (sender as tmenuitem).parent.count>0 then (sender as tmenuitem ).parent.clear;
exit;
 end;
 
  if  (ansipos(ansiLowercase('%GetCustomCommand%'),
    ansilowercase((trim((IniFile.Readstring ('WorkShellFile',(sender as tmenuitem ).parent.hint,
 'none'))))))<>0)then
begin 
SystemStr:=IniFile.Readstring ('WorkShellFile',(sender as tmenuitem ).parent.hint,'none');
 SystemStr:=K.CRS_DoListCustomCommand(SystemStr,(sender as tmenuitem ).hint,xfgmemo.text);
libc.system(pchar(SystemStr));
if (sender as tmenuitem).parent.count>0 then (sender as tmenuitem ).parent.clear;
end;
finally
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
end;
end;

(******************************************************************************************************)
(******************************************************************************************************)
Function Tform1.DoCustomCommand(APASSControl:TObject;AParentHint,AHint:String):boolean;
var RStr:string;Item:TMenuItem;lst:tstringlist;i:integer;USECaptionImageName:boolean;
begin
result:=false;
USECaptionImageName:=false;
if APASSControl is tmenuitem then
begin
if (APASSControl as tmenuitem).count>0 then exit;
RStr:=K.CRS_DoListCustomCommand((trim(ansilowercase(inifile.Readstring (AParentHint,AHint, 'none')))),xfgmemo.text,AHint);
if Rstr<>'' then 
begin

lst:=tstringlist.create;
try
lst.text:=RStr;
if fileexists(extractfilepath(lst[0])+'XFGMemoInsertCommand') then USECaptionImageName:=true;
for i:=0 to lst.count-1 do
begin
if extractfilename(lst[i])='XFGMemoInsertCommand'then continue;
Item := TMenuItem.Create ((APASSControl as tmenuitem));
Item.Caption := lst[i];
Item.hint:= lst[i];
Item.enabled:=true;
Item.visible:=true;
(APASSControl as tmenuitem).add(Item as tmenuitem);
item.onclick:=DoCustomCommandClick;
try
if USECaptionImageName=true then
item.bitmap.LoadFromFile(Item.hint)
else
item.bitmap.LoadFromFile(IniFile.ReadString(AParentHint+'Image',
AHint, 'none')); 
except
;
end;
end;
finally
result:=true;
lst.free;
end;
end;
end;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.MenuItemOnHighlighted(Sender: TObject); 
var dirstr:string;FirstSet,LastCount:boolean;
mi,MoreItem:tmenuitem;lst,lst2,lst3:tstringlist;i,MICount:integer;
(******************************************************************************************************)
function MenuItemOnHighlightedCREATENEW(Const APASSMenuitem:tmenuitem;Const APASSLst:tstringlist):boolean;
var mm:tmenuitem;i:integer;str:string;USECaptionImageName:boolean;
begin
mm:=nil;
MoreItem:=nil;
USECaptionImageName:=false;
if fileexists(extractfilepath(APASSLst[0])+'XFGMemoInsertCommand') then USECaptionImageName:=true;

for i:=0 to APASSLst.count-1 do
begin
if (extractfilename(APASSLst[i])='.')or
(extractfilename(APASSLst[i])='..')or
(directoryexists(APASSLst[i]+'/'))then continue;
if extractfilename(APASSLst[i])='XFGMemoInsertCommand'then continue;
if 

AnsiPos('.',trim(extractfilename(APASSLst[i])))=1 then 
str:=Copy(trim(extractfilename(APASSLst[i])),2,length(APASSLst[i]))
else str:=trim(extractfilename(APASSLst[i]));

if inifile.readstring('xfgFileTypeIconImage',copy(K.CRS_Extractfileext(str),2,length(str)),'none')
='none' then
begin
 if inifile.readstring('xfgFileTypeIconImage',copy(Extractfileext(str),2,length(str)),'none')
   <>'none' then  
 delete(str,length(str)-length(Extractfileext(str))+1,length(str));
end else
delete(str,length(str)-length(K.CRS_Extractfileext(str))+1,length(str));

mm := TMenuItem.Create (APASSMenuitem);
with mm as tmenuitem do
begin
Caption := str;
hint := APASSLst[i];
OnClick:=ExecuteDocumentOnClick;
(APASSMenuitem).add(mm);
try
if USECaptionImageName=true then
bitmap.LoadFromFile(hint)
except
;
end;
end;
end;//for i:=0 to APASSLst.count-1 do
if lastcount=false then
begin
 MoreItem:= TMenuItem.Create ((APASSMenuitem));
 MoreItem.Caption := 'More ...';
 MoreItem.hint := 'More ...';
 if (sender as tmenuitem).bitmap<>nil then
 MoreItem.bitmap:=(sender as tmenuitem).bitmap;
 (APASSMenuitem).add(MoreItem);
 end;
result:=true;
end;
(******************************************************************************************************)
begin
//if   (sender as tmenuitem).count>0 then exit;
mi:=nil;
MoreItem:=nil;
if (AnsiPos(ansilowercase('%DoListCustomCommand%'),
ansilowercase(trim(IniFile.ReadString ((sender as tmenuitem).parent.hint, (sender as tmenuitem).hint, 'none'))))>0)
   then  
   begin
 
 DoCustomCommand(sender as tmenuitem,(sender as tmenuitem ).parent.hint,(sender as tmenuitem ).hint);
exit;
end;
//if (sender as tmenuitem).count>0 then (sender as tmenuitem).clear;
if (sender as tmenuitem).count>0 then exit;
if (AnsiPos(ansilowercase('%ExpandDirForDocumentation%'),
ansilowercase(trim(IniFile.ReadString ((sender as tmenuitem).parent.hint, (sender as tmenuitem).hint, 
'none'))))>0)
   then  
   begin 

   LastCount:=false;
   FirstSet:=true;
   lst:=tstringlist.create;
   lst2:=tstringlist.create;
   lst3:=tstringlist.create;
   try
// screen.cursor:=crhourglass;

   inifile.readsection('xfgDocumentationEXT',lst);
   for i:=0 to lst.count-1 do
   begin
   lst2.clear;
   inifile.readsection(lst[i],lst2);
   lst3.addstrings(lst2);
   end;
//dirstr:=trim(IniFile.ReadString ((sender as tmenuitem).parent.hint, (sender as tmenuitem).hint, 'none'));
dirstr:=K.CRS_GetParamAtPos('{'+trim(IniFile.ReadString ((sender as tmenuitem).parent.hint, 
(sender as tmenuitem).hint, 'none'))+'}','{','}','%',3);
if LastDelimiter('/',dirstr)<>length(dirstr) then dirstr:=dirstr+'/';

lst.clear;
lst2.clear;
K.NoRECURSESearchDir(dirstr,'*',lst);
MICount:=1;

for i:=0 to lst.count-1 do
begin
if (extractfilename(lst[i])='.')or
(extractfilename(lst[i])='..')then continue;
if fileexists(lst[i])then 
begin

lst2.add((lst[i]));
INC(MICount);

if (MICount=50)or(i=lst.count-1)  then 
 begin 
 //xfgmemo.lines.add(lst2.text);
 if i=lst.count-1 then LastCount:=true;
 MICount:=1;
 if FirstSet=false then 
 begin
 
 
 MenuItemOnHighlightedCREATENEW((MoreItem as tmenuitem),lst2);
 end;
 if FirstSet=true then 
 begin

 MenuItemOnHighlightedCREATENEW((sender as tmenuitem),lst2);
 FirstSet:=false;
 end;
 lst2.clear;
 end;
 
//end;//if lst3.indexof(instr)>-1 then 
end;
end;
//if LastCount<>true then MenuItemOnHighlightedCREATENEW((sender as tmenuitem),lst2);
finally
//screen.cursor:=crDefault;
 lst.free;
 lst2.free;
 lst3.free;
 end;
end;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure  TForm1.xfgMemoPopupclick(Sender: TObject);
var str:string;
begin
str:=AnsiLowercase((sender as tmenuitem).hint);
if str='undo' then xfgmemo.undo else
if str='redo' then xfgmemo.redo else
if str='cut' then xfgmemo.CutToClipboard else
if str='paste' then xfgmemo.pastefromClipboard else
if str='copy' then xfgmemo.copytoClipboard else
if str='select all' then xfgmemo.selectall else
GetCustomCommandFrom_CRS(IniFile.Readstring ('xfgMemoMenu',(sender as tmenuitem ).hint, 'none'),
(sender as tmenuitem ).hint);

//GoToShellFiles(Sender as tmenuitem);
//UserExec(sender as tmenuitem);
//DoCustomCommandClick(sender as tmenuitem);
//ExecuteDocumentOnClick(sender as tmenuitem);
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure   TForm1.DoxfgMemoPopupitemsShow(Sender: TObject);
var hastext:boolean;  mm:tmenuitem;
begin
mm:=sender as tmenuitem;
//mm.enabled:=true;
if  Clipboard.astext='' then hastext:=false else hastext:=true;

if inifile.valueexists('xfgMemoMenuHasSelection',mm.hint)then
mm.enabled:=xfgmemo.HasSelection;

if inifile.valueexists('xfgMemoMenuNoSelection',mm.hint)then
//if xfgmemo.HasSelection then mm.enabled:=false;
mm.enabled:=not xfgmemo.HasSelection;

if inifile.valueexists('xfgMemoMenuHasLineText',mm.hint)then
if xfgmemo.lines[xfgmemo.CaretPos.line]<>''then
mm.enabled:=true else mm.enabled:=false;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure  TForm1.DoxfgMemoPopup(Sender: TObject);
var hastext:boolean; 
begin
if  Clipboard.astext='' then hastext:=false else hastext:=true;
xfgMemoPopup.items.find('undo').enabled:=xfgmemo.canundo;
xfgMemoPopup.items.find('redo').enabled:=xfgmemo.canredo;
xfgMemoPopup.items.find('copy').enabled:=xfgmemo.HasSelection;
xfgMemoPopup.items.find('cut').enabled:=xfgmemo.HasSelection;
xfgMemoPopup.items.find('paste').enabled:=hastext;

end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure  TForm1.xfgCreateMemoPopup;
   var 
    i:integer;
    l:tstringlist;
  mi:tmenuitem;
    imgfile:string;
begin
xfgmemo.popupmenu:=nil;
xfgMemoPopup:=tpopupmenu.create(form1);
xfgMemoPopup.AutoPopup := true;
xfgMemoPopup.Alignment := (paLeft);

xfgMemoPopup.OnPopup:= DoxfgMemoPopup;
 

l:=tstringlist.create;
try

 inifile.readsection('xfgMemoMenu',l);

for i:=0 to l.count-1 do
begin
mi:=TMenuItem.create(xfgMemoPopup);
 with mi as TMenuItem do
 begin
 

(******************************************************)
if AnsiPos('-seperator',AnsiLowercase(l.strings[i]))>0 then 
begin
   Caption := '-';
   hint:='-';
   enabled:=true;
   visible:=true;
   xfgMemoPopup.items.add(mi);
   continue;
end;
if trim(ansilowercase(inifile.Readstring ('xfgMemoMenu', l.Strings[i], 'none')))='%createnew%' then
begin
Caption := l.strings[i];
Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgMemoMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
   enabled:=true;
   visible:=true;
 
xfgMemoPopup.items.add(mi);
create_new_menu(l.strings[i],mi) ;
continue;
end;
   Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgMemoMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
   enabled:=true;
   visible:=true;
   OnClick := xfgMemoPopupclick;
   xfgMemoPopup.items.add(mi);
end; //with mi as TMenuItem do           
end;//for i:=0 to l.count-1 do
finally
l.free;
xfgmemo.popupmenu:=xfgMemoPopup;
end;
end;
(******************************************************************************************************)
(******************************************************************************************************)
    
procedure TForm1.xfgcreatemenu;
var 
l1,l2: TStringList;
sbint,Position,mi,i,sizei:integer;
 BitMap1,BitMap2 : TBitMap;
 tempstr:string;combobox:tcombobox;LBC:tlabel;PTED:tedit;PTchk:tcheckbox;
begin


BitMap1 := TBitMap.Create;
BitMap2 := TBitMap.Create;

button1.font.color:=15527148;
button2.font.color:=15527148;
button3.font.color:=15527148;
button4.font.color:=15527148;
button5.font.color:=15527148;
button6.font.color:=15527148;
button7.font.color:=15527148;
button8.font.color:=15527148;
button9.font.color:=15527148;
button10.font.color:=15527148;
button1.Font.Style := [fsbold];
button2.Font.Style := [fsbold];
button3.Font.Style := [fsbold];
button4.Font.Style := [fsbold];
button5.Font.Style := [fsbold];
button6.Font.Style := [fsbold];
button7.Font.Style := [fsbold];
button8.Font.Style := [fsbold];
button9.Font.Style := [fsbold];
button10.Font.Style := [fsbold];

   
  try
 if fileexists(IniFile.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none'))then
   BitMap1.loadfromfile(IniFile.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none'));
button1.bitmap:=BitMap1;
    button2.bitmap:=BitMap1;   // Canvas.Draw(12,12,BitMap1);
button3.bitmap:=BitMap1;
button4.bitmap:=BitMap1;
button5.bitmap:=BitMap1;
button6.bitmap:=BitMap1;
button7.bitmap:=BitMap1;
button8.bitmap:=BitMap1;
button9.bitmap:=BitMap1;
button10.bitmap:=BitMap1;
//
 button8.onclick:=UserExecVCL;   
 button9.onclick:=buttonvcl;                       
 if fileexists(IniFile.ReadString ('xfgMainMenuImage', 'xfgMainMenu', 'none'))then
    BitMap2.loadfromfile(IniFile.ReadString ('xfgMainMenuImage', 'xfgMainMenu', 'none'));
mainmenu1.bitmap:=BitMap2;

  finally
  begin
    BitMap1.Free;BitMap2.Free;end;  end;
if fileexists(IniFile.Readstring ('xfgMainButtonImage', 'button1', 'none'))then
button1.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button1', 'none'));
if fileexists(IniFile.Readstring ('xfgMainButtonImage','button2', 'none'))then
button2.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button2', 'none'));
if fileexists(IniFile.Readstring ('xfgMainButtonImage','button3', 'none'))then
button3.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button3', 'none'));
if fileexists(IniFile.Readstring ('xfgMainButtonImage','button4', 'none'))then
button4.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button4', 'none'));
if fileexists(IniFile.Readstring ('xfgMainButtonImage','button5', 'none'))then
button5.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button5', 'none'));
if fileexists(IniFile.Readstring ('xfgMainButtonImage','button6', 'none'))then
button6.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button6', 'none'));
if fileexists(IniFile.Readstring ('xfgMainButtonImage','button7', 'none'))then
button7.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button7', 'none'));
if fileexists(IniFile.Readstring ('xfgMainButtonImage','button8', 'none'))then
button8.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button8', 'none'));
if fileexists(IniFile.Readstring ('xfgMainButtonImage','button9', 'none'))then
button9.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button9', 'none'));
if fileexists(IniFile.Readstring ('xfgMainButtonImage','button10', 'none'))then
button10.Glyph.LoadFromFile(IniFile.Readstring ('xfgMainButtonImage', 'button10', 'none'));
   
freemenu;

 
     menu := TMenuItem.Create (application);
         Menu.Caption :=' File';
       Position := MainMenu1.Items.count-1;
  MainMenu1.Items.Insert (Position + 1, Menu);
  
  item := TMenuItem.Create (application);

             item.Caption := 'Reload configurations';
      if fileexists(IniFile.ReadString ('xfgMainButtonImage','Reload configurations', 'none'))then
          item.bitmap.LoadFromFile(IniFile.ReadString ('xfgMainButtonImage','Reload configurations', 'none'));
        item.OnClick := ReloadMenuClick;
  Menu.Insert (Menu.Count, Item);
  
 
    item := TMenuItem.Create (application);
             item.Caption := 'Exit';
        item.OnClick := Exit1Click;
  Menu.Insert (Menu.Count, Item);
  
l1 := TStringList.Create;
l2 := TStringList.Create;
 IniFile.ReadSection('xfgMainMenu',l1);
  for mi := 0 to l1.Count - 1 do 
begin

 // create the new Menu menu
  Menu := TMenuItem.Create (application);
  Menu.Caption := l1.Strings[mi];
  Menu.hint := l1.Strings[mi];
//  Menu.OnClick := SizeClick;
  Position := MainMenu1.Items.count-1;
  MainMenu1.Items.Insert (Position + 1, Menu);
 
  IniFile.ReadSection(l1.Strings[mi],l2);
     for i := 0 to l2.Count - 1 do 
   begin
   

     Item := TMenuItem.Create (application);
     if 

AnsiPos('---seperator',ansilowercase(l2.Strings[i]))>0 then Item.Caption:='-' else
     Item.Caption := l2.Strings[i];
     Item.hint:= l2.Strings[i];
     try
          if fileexists(IniFile.ReadString (l1.Strings[mi]+'Image',l2.Strings[i], 'none'))then

   item.bitmap.LoadFromFile(IniFile.ReadString (l1.Strings[mi]+'Image',l2.Strings[i], 'none'));
     except
    on E: Exception do
    begin
    ;
    end;
     end;
     
if (AnsiPos(ansilowercase('%ExpandDirForDocumentation%'),ansilowercase(trim(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none'))))>0)
   then  begin Item.OnHighlighted:= MenuItemOnHighlighted;  Menu.Insert (Menu.Count, Item);continue;end; 

if (AnsiPos(ansilowercase('%DoListCustomCommand%'),ansilowercase(trim(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none'))))>0)
   then  begin Item.OnHighlighted:= MenuItemOnHighlighted;  Menu.Insert (Menu.Count, Item);continue;end; 

if (AnsiPos('%proc%',ansilowercase(trim(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none'))))>0)
   then  begin Item.OnClick := GoToGetProc;  Menu.Insert (Menu.Count, Item);continue;end; 
   
if (ansipos(ansiLowercase('%proc%'),
ansiLowercase(IniFile.ReadString ('WorkShellFile',l2.Strings[i],'none')))<>0)
then begin Item.OnClick := GoToGetProc;  Menu.Insert (Menu.Count, Item);continue;end;  

 if trim(ansilowercase(inifile.Readstring (l1.Strings[mi], l2.Strings[i], 'none')))='%createnew%' 
then begin create_new_menu(l2.Strings[i],Item) ;Menu.Insert (Menu.Count, Item);continue;end;


if (

AnsiPos('%vclinternal%',(trim(ansilowercase(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none')))))>0)or
(AnsiPos('%vclexternal%',(trim(ansilowercase(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none')))))>0)or
(AnsiPos('%dumptovcl%',(trim(ansilowercase(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none')))))>0)or
(trim(ansilowercase(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none')))='vcl')or
(trim(ansilowercase(IniFile.ReadString ('xfgMainMenu', l1.Strings[mi], 'none')))='vcl')
    then begin Item.OnClick := UserExecVCL  ; Menu.Insert (Menu.Count, Item);continue;end; 
  


  
if 

AnsiPos('%realtask%',(trim(ansilowercase(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none')))))>0 
  then begin
         if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'))then

      item.bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));  

  
 Item.OnClick := runMULTITASKcommandCLICK;
Menu.Insert (Menu.Count, Item);

 
continue;
end; 
       

(*********************************************
if (trim(ansilowercase(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none')))='shell')or
(trim(ansilowercase(IniFile.ReadString ('xfgMainMenu', l1.Strings[mi], 'none')))='shell')
 //  then  Item.OnClick := UserExec;
    then  Item.OnClick := GoToShellFiles;
if (trim(ansilowercase(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none')))='file')or
(trim(ansilowercase(IniFile.ReadString ('xfgMainMenu', l1.Strings[mi], 'none')))='file')
 //  then    Item.OnClick :=UserFilesExec; 
    then    Item.OnClick :=GoToShellFiles; 

if (trim(ansilowercase(IniFile.ReadString (l1.Strings[mi], l2.Strings[i], 'none')))='shellfile')or
(trim(ansilowercase(IniFile.ReadString ('xfgMainMenu', l1.Strings[mi], 'none')))='shellfile')
//   then    Item.OnClick :=UserFilesExecShell;
 then    Item.OnClick :=GoToShellFiles;
*************************************************)

Item.OnClick :=GoToShellFiles;
    Menu.Insert (Menu.Count, Item);


   end;
l2.clear;
end; 



sbint:=176;
IniFile.ReadSection('xfgSpeedButton',l1);
  for mi := 0 to l1.Count - 1 do 
begin
if (trim(ansilowercase(l1.Strings[mi]))='xfgopen') or
(trim(ansilowercase(l1.Strings[mi]))='xfgsave') or
(trim(ansilowercase(l1.Strings[mi]))='xfgsaveas') or
(trim(ansilowercase(l1.Strings[mi]))='xfgfont') or
(trim(ansilowercase(l1.Strings[mi]))='xfgclear') 

             then continue;

speedbutton:=TSpeedButton.Create (panel3);
speedbutton.parent:=panel3;
sbint:=sbint+32+10;
 speedbutton.left:=sbint;
      speedbutton.Top := 1;
      speedbutton.Width := 32;
      speedbutton.Height := 32;
    speedbutton.Hint :=l1.Strings[mi];
    //  speedbutton.caption:=IniFile.Readstring ('xfgSpeedButton', l1.Strings[mi], 'none');
      speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
  if fileexists(IniFile.Readstring ('xfgSpeedButtonImage', l1.Strings[mi], 'none'))then

      SpeedButton.Glyph.LoadFromFile(IniFile.Readstring ('xfgSpeedButtonImage', l1.Strings[mi], 'none'));

      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
  
if (trim(ansilowercase(IniFile.ReadString ('xfgSpeedButton', speedbutton.hint, 'none')))='shell')
   then  speedbutton.OnClick := GoToShellFiles else
if (trim(ansilowercase(IniFile.ReadString ('xfgSpeedButton', speedbutton.hint, 'none')))='file')
   then    speedbutton.OnClick :=GoToShellFiles else
if (trim(ansilowercase(IniFile.ReadString ('xfgSpeedButton', speedbutton.hint, 'none')))='shellfile')
   then    speedbutton.OnClick :=GoToShellFiles else
        
 if (

AnsiPos('%vclinternal%',(trim(ansilowercase(IniFile.ReadString ('xfgSpeedButton', speedbutton.hint, 'none')))))>0)or
(AnsiPos('%vclexternal%',(trim(ansilowercase(IniFile.ReadString ('xfgSpeedButton', speedbutton.hint, 'none')))))>0)or
(AnsiPos('%dumptovcl%',(trim(ansilowercase(IniFile.ReadString ('xfgSpeedButton', speedbutton.hint, 'none')))))>0)or
(trim(ansilowercase(IniFile.ReadString ('xfgSpeedButton', speedbutton.hint, 'none')))='vcl')



    then speedbutton.OnClick := UserExecVCL else
    
 speedbutton.OnClick := spclick;
 
speedbutton.visible:=true;
end;

l1.clear;
sbint:=3;
IniFile.ReadSection('xfgMemoSpeedButton',l1);
  for mi := 0 to l1.Count - 1 do 
begin
speedbutton:=TSpeedButton.Create (PanelTop);
speedbutton.parent:=PanelTop;
speedbutton.left:=sbint;
//sbint:=sbint+PanelTop.height+10;
speedbutton.font.size:=10;
 speedbutton.Width := PanelTop.height*3;
 speedbutton.layout:=blGlyphLeft;
      speedbutton.Height := PanelTop.height-3;
 speedbutton.Hint :=trim(l1.Strings[mi]);
speedbutton.caption :=trim(l1.Strings[mi]);
 sbint:=sbint+speedbutton.Width+1;

      speedbutton.Top := 1;
     
      speedbutton.Flat := true;
   
  if fileexists(IniFile.Readstring ('xfgMemoSpeedButtonImage', l1.Strings[mi], 'none'))then

      SpeedButton.Glyph.LoadFromFile(IniFile.Readstring ('xfgMemoSpeedButtonImage', l1.Strings[mi], 'none'));

      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
 if (trim(ansilowercase(IniFile.ReadString ('xfgMemoSpeedButton', speedbutton.hint, 'none')))='none')
   then  speedbutton.OnClick := GoToShellFiles else 
if (trim(ansilowercase(IniFile.ReadString ('xfgMemoSpeedButton', speedbutton.hint, 'none')))='shell')
   then  speedbutton.OnClick := GoToShellFiles else
if (trim(ansilowercase(IniFile.ReadString ('xfgMemoSpeedButton', speedbutton.hint, 'none')))='file')
   then    speedbutton.OnClick :=GoToShellFiles else
if (trim(ansilowercase(IniFile.ReadString ('xfgMemoSpeedButton', speedbutton.hint, 'none')))='shellfile')
   then    speedbutton.OnClick :=GoToShellFiles else
        
 if (

AnsiPos('%vclinternal%',(trim(ansilowercase(IniFile.ReadString ('xfgMemoSpeedButton', speedbutton.hint, 'none')))))>0)or
(AnsiPos('%vclexternal%',(trim(ansilowercase(IniFile.ReadString ('xfgMemoSpeedButton', speedbutton.hint, 'none')))))>0)or
(AnsiPos('%dumptovcl%',(trim(ansilowercase(IniFile.ReadString ('xfgMemoSpeedButton', speedbutton.hint, 'none')))))>0)or
(trim(ansilowercase(IniFile.ReadString ('xfgMemoSpeedButton', speedbutton.hint, 'none')))='vcl')
then speedbutton.OnClick := UserExecVCL else
    
 speedbutton.OnClick := spclick;
 
speedbutton.visible:=true;
end;
l1.clear;
sbint:=sbint+3;
IniFile.ReadSection('xfgMemoCombo',l1);
  for mi := 0 to l1.Count - 1 do 
begin
LBC:=tlabel.create(PanelTop);
LBC.parent:=PanelTop;
LBC.font.size:=10;
LBC.width:=50;
LBC.top:=6;
LBC.color:=15717834;
LBC.alignment:=tacenter;
LBC.layout:=tlCenter;
LBC.autosize:=true;
LBC.height:=PanelTop.height-5;
LBC.left:=sbint;
LBC.caption:=l1.Strings[mi];
combobox:=tcombobox.create(PanelTop);
combobox.parent:=PanelTop;
combobox.hint:=l1.Strings[mi];
combobox.name:='combobox'+l1.Strings[mi];
combobox.top:=1;
combobox.height:=PanelTop.height-10;
combobox.font.size:=10;
combobox.left:=sbint+LBC.width+5;
combobox.width:=50;
combobox.showhint:=true;
combobox.DropDownCount:=25;
combobox.OnChange:=MemoConfigurationControlsOnChange;
if trim(ansilowercase(k.CRS_GetParamAtPos('['+(trim(ansilowercase(IniFile.ReadString ('xfgMemoCombo', l1.Strings[mi], 'none'))))+']','[',']','=',1)))='false' then
combobox.Style:=csDropDownList;

if 

AnsiPos('%screenfonts%',trim(ansilowercase(IniFile.readstring('xfgMemoCombo',l1.Strings[mi],'none'))))>0 then
begin
combobox.Items:=screen.fonts;
combobox.ItemIndex := 0;
combobox.width:=120;
sbint:=sbint+combobox.width+LBC.width+10;
combobox.hint:=combobox.Items[combobox.itemindex];
continue;
end;
if 

AnsiPos('%fontssize%',trim(ansilowercase(IniFile.readstring('xfgMemoCombo',l1.Strings[mi],'none'))))>0 then
begin
for sizei:=1 to 50 do 
combobox.items.add(inttostr(sizei+sizei));
combobox.text := inttostr(FontDialog1.font.size);
combobox.hint:=combobox.Items[combobox.itemindex];
continue;
end;
tempstr:=k.CRS_GetParamAtPos('['+trim(IniFile.readstring('xfgMemoCombo',l1.Strings[mi],'none'))+']','[',']','=',2);
combobox.items.Delimiter:='|';
combobox.items.DelimitedText:=tempstr;
combobox.ItemIndex := 0;
sbint:=sbint+combobox.width+LBC.width+10;
combobox.hint:=combobox.Items[combobox.itemindex];
end;

l1.clear;
sbint:=sbint+(combobox.width+LBC.width+10);
IniFile.ReadSection('xfgMemoEditTop',l1);
  for mi := 0 to l1.Count - 1 do 
begin
LBC:=tlabel.create(PanelTop);
LBC.parent:=PanelTop;
LBC.font.size:=10;
LBC.width:=PanelTop.height*2+10+120+2;
LBC.top:=PanelTop.height-3;
LBC.color:=11118814;
LBC.alignment:=tacenter;
LBC.layout:=tlCenter;
LBC.autosize:=false;
LBC.height:=PanelTop.height-LBC.top-1;
LBC.left:=sbint+1;
LBC.caption:='';
PTED:=tedit.create(PanelTop);
PTED.parent:=PanelTop;
PTED.font.size:=10;
PTED.width:=120;
PTED.top:=1;
PTED.height:=PanelTop.height-6;
PTED.left:=sbint;
PTED.hint:=l1.Strings[mi];
PTED.name:=ansilowercase('pted'+l1.Strings[mi]);
PTED.text:='';
PTED.OnReturnPressed:=PTEDOnReturnPressed;
speedbutton:=TSpeedButton.Create (PanelTop);
speedbutton.parent:=PanelTop;
speedbutton.name:=ansilowercase('ptedsp'+l1.Strings[mi]);
speedbutton.left:=PTED.left+PTED.Width+2;
//sbint:=sbint+PanelTop.height+15;
speedbutton.font.size:=10;
speedbutton.Width := PanelTop.height*2+10;
speedbutton.layout:=blGlyphLeft;
speedbutton.Height := PanelTop.height-5;
speedbutton.Hint :=trim(l1.Strings[mi]);
speedbutton.ParentShowHint := False;
speedbutton.ShowHint := True;
speedbutton.Spacing := 5;
speedbutton.caption:=speedbutton.Hint;
speedbutton.Top := 1;
speedbutton.Flat := True;
if fileexists(IniFile.Readstring ('xfgMemoEditTopImage', l1.Strings[mi], 'none'))then
SpeedButton.Glyph.LoadFromFile(IniFile.Readstring ('xfgMemoEditTopImage', l1.Strings[mi], 'none'));
speedbutton.OnClick := spclick;
if ansilowercase(trim(speedbutton.caption))='replace'then
LBC.color:=10215130;

sbint:=(sbint+PTED.Width+2)+PanelTop.height*2+10+5;
end;



sbint:=0;
IniFile.ReadSection('xfgMemoEditMid',l1);
  for mi := 0 to l1.Count - 1 do 
begin
LBC:=tlabel.create(PanelMid);
LBC.parent:=PanelMid;
LBC.font.size:=10;
LBC.width:=PanelMid.height*2+10+120+2+60;
LBC.top:=PanelMid.height-3;
LBC.color:=11118814;
LBC.alignment:=tacenter;
LBC.layout:=tlCenter;
LBC.autosize:=false;
LBC.height:=PanelMid.height-LBC.top-1;
LBC.left:=sbint+1;
LBC.caption:='';
PTED:=tedit.create(PanelMid);
PTED.parent:=PanelMid;
PTED.font.size:=10;
PTED.width:=120;
PTED.top:=1;
PTED.height:=PanelMid.height-6;
PTED.left:=sbint;
PTED.hint:=l1.Strings[mi];
PTED.name:=ansilowercase('pted'+l1.Strings[mi]);
PTED.text:='';
PTED.OnReturnPressed:=PTEDOnReturnPressed;
speedbutton:=TSpeedButton.Create (PanelMid);
speedbutton.parent:=PanelMid;
speedbutton.name:=ansilowercase('ptedsp'+l1.Strings[mi]);
speedbutton.left:=PTED.left+PTED.Width+2;
//sbint:=sbint+PanelTop.height+15;
speedbutton.font.size:=10;
speedbutton.Width := PanelMid.height*2+10;
speedbutton.layout:=blGlyphLeft;
speedbutton.Height := PanelMid.height-5;
speedbutton.Hint :=trim(l1.Strings[mi]);
speedbutton.ParentShowHint := False;
speedbutton.ShowHint := True;
speedbutton.Spacing := 5;
speedbutton.caption:=speedbutton.Hint;
speedbutton.Top := 1;
speedbutton.Flat := True;
if fileexists(IniFile.Readstring ('xfgMemoEditMidImage', l1.Strings[mi], 'none'))then
SpeedButton.Glyph.LoadFromFile(IniFile.Readstring ('xfgMemoEditMidImage', l1.Strings[mi], 'none'));
speedbutton.OnClick := spclick;
if ansilowercase(trim(speedbutton.caption))='replace'then
begin
LBC.color:=15445447;
PTchk:=tcheckbox.create(PanelMid);
PTchk.parent:=PanelMid;
PTchk.left:=speedbutton.left+speedbutton.Width+10;
PTchk.top:=4;
PTchk.checked:=false;
PTchk.font.size:=10;
PTchk.width:=80;
PTchk.height:=15;
PTchk.caption:='replace all';
PTchk.name:='ptchkreplaceALL';
LBC.width:=PanelTop.height*2+207;
end;
if ansilowercase(trim(speedbutton.caption))='search'then
begin
PTchk:=tcheckbox.create(PanelMid);
PTchk.parent:=PanelMid;
PTchk.top:=4;
PTchk.height:=15;
PTchk.width:=80;
PTchk.font.size:=10;
PTchk.left:=speedbutton.left+speedbutton.Width+10;
PTchk.checked:=false;
PTchk.name:='ptchksearchWORD';
PTchk.caption:='whole word';
PTchk:=tcheckbox.create(PanelMid);
PTchk.parent:=PanelMid;
PTchk.top:=4;
PTchk.height:=15;
PTchk.font.size:=10;
PTchk.left:=speedbutton.left+speedbutton.Width+90+5;
PTchk.checked:=true;
PTchk.width:=80;
PTchk.name:='ptchksearchCASE';
PTchk.caption:='ignore case';
LBC.width:=PanelTop.height*2+300;
end;
sbint:=(sbint+PTED.Width+2)+PanelMid.height*2+195;
end;


//SpeedButton1.Glyph.LoadFromFile('MYBITMAP.BMP');
  if fileexists(IniFile.Readstring ('xfgSpeedButtonImage','xfgopen', 'none'))then
SpeedButton1.Glyph.LoadFromFile(IniFile.ReadString ('xfgSpeedButtonImage', 'xfgopen', 'none'));
  if fileexists(IniFile.Readstring ('xfgSpeedButtonImage', 'xfgsaveas', 'none'))then
SpeedButton2.Glyph.LoadFromFile(IniFile.ReadString ('xfgSpeedButtonImage', 'xfgsaveas', 'none'));
  if fileexists(IniFile.Readstring ('xfgSpeedButtonImage', 'xfgsave', 'none'))then
SpeedButton3.Glyph.LoadFromFile(IniFile.ReadString ('xfgSpeedButtonImage', 'xfgsave', 'none'));

SpeedButton4.Glyph.LoadFromFile(IniFile.ReadString ('xfgSpeedButtonImage', 'xfgfont', 'none'));
  if fileexists(IniFile.Readstring ('xfgSpeedButtonImage', 'xfgclear', 'none'))then
SpeedButton5.Glyph.LoadFromFile(IniFile.ReadString ('xfgSpeedButtonImage', 'xfgclear', 'none'));

l1.free;
 l2.free;

end;

(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.MemoConfigurationControlsOnChange(Sender: TObject);
var APASSMemo:tmemo;
begin
if DoReloadTask=true then exit;
APASSMemo:=xfgmemo as tmemo;
if sender is tcombobox then
begin
with  sender as tcombobox do
begin
hint:=Items[itemindex];
if trim(ansilowercase(name))='comboboxcolumn' then 
begin
if (trim(ansilowercase(text))<>'none')and
(trim(ansilowercase(text))<>'')
//or(isdigit(strtoint(trim(ansilowercase(text))))<>0)  
then 
begin
//Button7.click;
//(***************
(APASSMemo as tmemo).WordWrap:=true;
(APASSMemo as tmemo).WrapBreak:=wbWhitespace;
(APASSMemo as tmemo).WrapMode:=wmColumn;
try
(APASSMemo as tmemo).WrapAtValue:=strtoint(text);
except
;
end;
//**********)
end;
if trim(ansilowercase(text))='none' then 
begin
(APASSMemo as tmemo).WordWrap:=false;
(APASSMemo as tmemo).WrapMode:=wmNone;
(APASSMemo as tmemo).WrapBreak:=wbWhitespace;
end;
end;//if trim(ansilowercase(name))='comboboxcolumn' then 
if trim(ansilowercase(name))='comboboxalignment' then 
begin
if trim(ansilowercase(text))='left' then (APASSMemo as tmemo).alignment:=taLeftJustify;
if trim(ansilowercase(text))='center' then (APASSMemo as tmemo).alignment:=taCenter;
if trim(ansilowercase(text))='right' then (APASSMemo as tmemo).alignment:=taRightJustify;
end;
if trim(ansilowercase(name))='comboboxfonts' then 
begin
(APASSMemo as tmemo).font.name:=text;
//(APASSMemo as tmemo).lines.add(text);
end;
if trim(ansilowercase(name))='comboboxpoints' then 
(APASSMemo as tmemo).font.size:=strtoint(text);
end;
end;//if sender is tcombobox then

if sender is tedit then
begin

end;//if sender is tedit then

fontdialog1.font:=xfgmemo.font;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.update_merge_FileType_CONF;
VAR l1,l2:tstringlist;i,ii:integer;tempstr,tempstr2,tempstr3:string;
begin
l1:=tstringlist.create;
l2:=tstringlist.create;
(*
if IniFile.SectionExists('xfgFileTypeIcon') then
    IniFile.EraseSection('xfgFileTypeIcon');
if IniFile.SectionExists('xfgFileTypeIconImage') then
    IniFile.EraseSection('xfgFileTypeIconImage');
if IniFile.SectionExists('xfgFileTypeIconBuiltin') then
    IniFile.EraseSection('xfgFileTypeIconBuiltin');
*)
//IniFile.UpdateFile;
(**********
IniFile.WriteString('xfgFileTypeIconBuiltin', '%folder%', '1');
IniFile.WriteString('xfgFileTypeIconBuiltin','%linkfolder%', '2');
IniFile.WriteString('xfgFileTypeIconBuiltin','%file%', '3');
IniFile.WriteString('xfgFileTypeIconBuiltin','%linkfile%', '4');
IniFile.WriteString('xfgFileTypeIconBuiltin','%executables%', '5');
IniFile.WriteString('xfgFileTypeIconBuiltin','%linkexecutables%', '6');
IniFile.WriteString('xfgFileTypeIconBuiltin','%character%', '7');
IniFile.WriteString('xfgFileTypeIconBuiltin','%linkcharacter%', '8');
IniFile.WriteString('xfgFileTypeIconBuiltin','%fifo%', '9');
IniFile.WriteString('xfgFileTypeIconBuiltin','%linkfifo%', '10');
IniFile.WriteString('xfgFileTypeIconBuiltin','%block%', '11');
IniFile.WriteString('xfgFileTypeIconBuiltin','%linkblock%', '12');
IniFile.WriteString('xfgFileTypeIconBuiltin','%socket%', '13');
IniFile.WriteString('xfgFileTypeIconBuiltin','%linksocket%', '14');
******)

IniFile.ReadSection ('xfgFileTypeNormalIconImage',l1);
for i:=0 to l1.count-1 do
begin 
tempstr2:=l1[i];
IniFile.WriteString('xfgFileTypeIconBuiltin', trim(ansilowercase(tempstr2)),inttostr(i*2+1));
//IniFile.WriteString('xfgFileTypeIcon', trim(ansilowercase(l1[i])),'none' );
IniFile.WriteString('xfgFileTypeIconImage' ,
                    trim(ansilowercase(tempstr2)),
                    IniFile.ReadString('xfgFileTypeNormalIconImage',tempstr2,'none' ) );
if (IniFile.valueexists('xfgFileTypeLinkIconImage',trim(ansilowercase(tempstr2))))
and (fileexists(IniFile.ReadString('xfgFileTypeLinkIconImage',tempstr2,'none' ) ) )then
 begin
 tempstr:=copy(trim(ansilowercase(tempstr2)) ,2 ,length(trim(ansilowercase(tempstr2)))-1 );
IniFile.WriteString('xfgFileTypeIconBuiltin', '%link'+tempstr,inttostr(i*2+2)); 
IniFile.WriteString('xfgFileTypeIconImage' ,
                     '%link'+tempstr,
                    IniFile.ReadString('xfgFileTypeLinkIconImage',tempstr2,'none' ) );

end else
begin
 tempstr:=copy(trim(ansilowercase(tempstr2)) ,2 ,length(trim(ansilowercase(tempstr2)))-1 );
IniFile.WriteString('xfgFileTypeIconBuiltin', '%link'+tempstr,inttostr(i*2+2)); 
IniFile.WriteString('xfgFileTypeIconImage' ,
                     '%link'+tempstr,
                    IniFile.ReadString('xfgFileTypeIconImage','%linkfile%','none' ) );
IniFile.WriteString('xfgFileTypeLinkIconImage' ,
                     trim(ansilowercase(tempstr2)),
                    IniFile.ReadString('xfgFileTypeIconImage','%linkfile%','none' ) );

end;

end;
l1.clear;

IniFile.ReadSection ('xfgFileTypeMerge',l1);
for i:=0 to l1.count-1 do
begin
tempstr2:=l1[i];
IniFile.ReadSection(tempstr2,l2);
for ii:=0 to l2.count-1 do
begin
tempstr3:=l2[ii];
tempstr:=IniFile.ReadString(tempstr2+'Image', tempstr3, 'none');
IniFile.WriteString('xfgFileTypeIconImage', trim(ansilowercase(tempstr3)),tempstr );
end;//for ii:=0 to l2.count-1 do

end;//for i:=0 to l1.count-1 do

l1.free;
l2.free;
//IniFile.UpdateFile;
APASS_IMAGE_filemask:='';
GimageEXTlist.clear; 
inifile.readsection('xfgImageEXT',GimageEXTlist);
for i:=0 to GimageEXTlist.count-1 do
begin
APASS_IMAGE_filemask:=APASS_IMAGE_filemask+'*.'+GimageEXTlist[i]+';';
end;

end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure Tform1.runscript(const guidstr:string;Sender: TObject);
var sini:TMemIniFile;str1,retSTR:string;StringsLST:tstringlist;APASSMemo:tmemo;
(******************************************************************************************************)
Procedure CheckStripListPath(const APASSsini:TMemIniFile;APASSLst:Tstrings;const checkINIT:boolean;
          Sender: TObject);
var idx,i:integer;templstidx:tstringlist;tempstr:string;
begin
APASSLst.clear;

if((Sender as tmenuitem).GetParentMenu=MainMenu1)then
begin
APASSLst.clear;
for i:=0 to (APASSMemo as tmemo).lines.count-1 do
APASSLst.add((APASSMemo as tmemo).lines[i]);
end else
begin
APASSLst.clear;
for i:=0 to form2.internallist.count-1 do
APASSLst.add(form2.internallist.strings[i]);
end;


if checkINIT then
if (APASSsini.readBool('INIT','StripPathFromInputFileNames',false)=true)then
begin
templstidx:=tstringlist.create;

for idx :=0 to APASSLst.count-1 do
begin

tempstr:=(extractfilename(APASSLst[idx]));

if directoryexists(APASSLst[idx]) then
begin
tempstr:=APASSLst[idx];
if LastDelimiter('/', tempstr)=length( tempstr) then 
Delete(tempstr,length( tempstr),1);
Delete(tempstr,1,LastDelimiter('/', tempstr));
//Delete(tempstr,1,1);
//tempstr:='./'+tempstr;
end;
templstidx.add(tempstr);
end;

APASSLst.clear;
for idx :=0 to templstidx.count-1 do
APASSLst.add(templstidx[idx]);

templstidx.free;

end;

end;
(******************************************************************************************************)
Procedure CheckAfterState(const APASSsini:TMemIniFile);
begin
if ansilowercase(trim(APASSsini.readstring('INIT','REFRESH','none')))='commander'then CheckForm2Refresh;
if ansilowercase(trim(APASSsini.readstring('INIT','ShowAfter','none')))='editor'then form1.show;
if ansilowercase(trim(APASSsini.readstring('INIT','ShowAfter','none')))='commander'then form2.show;
end;
(******************************************************************************************************)
begin
if not (fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/'+guidstr))and
not (fileexists(k.RS_USER_RESOURCE_PATH+'/'+guidstr))
then  begin
MessageDlg ('Can''t load dialog script ... '+#13#10+
                   k.RS_SYSTEM_RESOURCE_PATH+'/'+guidstr+'or '+#13#10+
                   k.RS_USER_RESOURCE_PATH+'/'+guidstr+#13#10, 
                   mtInformation, [mbOK], 0);
exit;
end;

if fileexists(datadir+'/'+guidstr+'ToBeDeleted') then
deletefile(datadir+'/'+guidstr+'ToBeDeleted');

if fileexists(k.RS_USER_RESOURCE_PATH+'/'+guidstr) then
k.CRS_CopyFile(k.RS_USER_RESOURCE_PATH+'/'+guidstr,datadir+'/'+guidstr+'ToBeDeleted',false,false,false)else
if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/'+guidstr) then
k.CRS_CopyFile(k.RS_SYSTEM_RESOURCE_PATH+'/'+guidstr,datadir+'/'+guidstr+'ToBeDeleted',false,false,false);

APASSMemo:=xfgmemo;
sini:=nil;
StringsLST:=nil;
StringsLST:=tstringlist.create;
sini:=TMemIniFile.create(datadir+'/'+guidstr+'ToBeDeleted');


if ansilowercase(trim(sini.readstring('INIT','FrameType','none')))='dialog'
then retSTR:=K.X_CRS_scriptdialog(sini,false);

if retSTR='' then  begin if sini<>nil then sini.free;exit;end;


CheckStripListPath(sini,StringsLST,true,Sender as tmenuitem);
(******************************************************************************************************)

if 

AnsiPos('%in',retSTR) > 0 then 
begin
 if ((Sender as tmenuitem).GetParentMenu=MainMenu1)then
if CheckError((APASSMemo as tmemo).lines)=true then begin if sini<>nil then sini.free;exit;end;

 try
form1.Cursor:= crHourGlass;    
 or2:=true;
 //form2.show;
// form1.ACreateForm;
 chdir(getcurrentdir);
 //xfgmemo.lines.add(retSTR);
form1.ShellFilesTO((sender as tmenuitem ).hint,retSTR,'',3,StringsLST);
finally
//form1.afreeform;
CheckAfterState(sini);
form1.Cursor:= crDefault;    
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
end;
exit;
end;
(******************************************************************************************************)
if 

AnsiPos('!in',retSTR) > 0 then 
begin
 if ((Sender as tmenuitem).GetParentMenu=MainMenu1)then
if CheckError((APASSMemo as tmemo).lines)=true then begin if sini<>nil then sini.free;exit;end;

 try
 form1.Cursor:= crHourGlass;    
 or2:=true;
  form1.show;
//  form1.ACreateForm;
 chdir(getcurrentdir);
form1.ShellFilesTOCAT((sender as tmenuitem ).hint,retSTR,'',3,StringsLST);
finally
//form1.afreeform;
form1.Cursor:= crDefault;    
CheckAfterState(sini);
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
end;
exit;
end;
(***********************************************************************************************)
if 

AnsiPos('&in',retSTR) > 0 then 
begin 
try
 form1.Cursor:= crHourGlass;    
or2:=true;
//form1.ACreateForm;
chdir(getcurrentdir);
form1.ShellFilesTOSingleFile((sender as tmenuitem ).hint,retSTR,'',3,StringsLST);
finally
//form1.afreeform;
CheckAfterState(sini);
 form1.Cursor:= crDefault;    
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
end;
exit;
end;
(***********************************************************************************************)
if 

AnsiPos('$in',retSTR) > 0 then 
begin
 if ((Sender as tmenuitem).GetParentMenu=MainMenu1)then
if CheckError((APASSMemo as tmemo).lines)=true then begin if sini<>nil then sini.free;exit;end;

try
form1.Cursor:= crHourGlass;    
or2:=true;
//form1.ACreateForm;
form1.ShellFilesTOSingleAPPLICATION((sender as tmenuitem ).hint,retSTR,'',3,StringsLST);
finally
//form1.afreeform;
CheckAfterState(sini);
form1.Cursor:= crDefault;    
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
end;
exit;
end;
(******************************************************************************************************)

if 

AnsiPos('%realtask%',retSTR) > 0 then 
begin
 if ((Sender as tmenuitem).GetParentMenu=MainMenu1)then
if CheckError((APASSMemo as tmemo).lines)=true then begin if sini<>nil then sini.free;exit;end;

or2:=true;
if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'))then
(Sender as tmenuitem).bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));  
runMULTITASKcommand(runMULTITASKcommandinstr,'');
sameREALTASKmenuitem:=(sender as tmenuitem);
sameREALTASK:=runMULTITASKcommandinstr;  
CheckAfterState(sini);
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
exit;
end;

(******************************************************************************************************)
if  (ansipos(ansiLowercase('%GetCustomCommand%'),ansiLowercase(retSTR))) > 0 then 
begin
try
form1.Cursor:= crHourGlass;   
retSTR:=K.CRS_DoListCustomCommand(retSTR,(sender as tmenuitem ).hint,xfgmemo.text);
if AnsiPos(AnsiLowercase('%RunMessage%'),AnsiLowercase(retSTR))<>0 then
begin
if AnsiEndsstr('&',trim(retSTR))then system.delete(retSTR,length(trim(retSTR)),1);
retSTR:=StringReplace(trim(retSTR),AnsiLowercase('%RunMessage%'),'',[rfReplaceAll, rfIgnoreCase]);
str1:=k.CRS_GetGuid+'ToBeDeleted';
K.crs_debug('#!/bin/bash'+#13#10+retSTR+#13#10+
'echo '+#13#10+'echo '+#13#10+'echo '+#13#10+'echo End OF Command : '+#13#10+'echo command = '+
(Sender as tmenuitem).hint+#13#10+
'echo time started = '+timetostr(now),datadir+'/'+str1);
chmod(pchar(datadir+'/'+str1), S_IRUSR or  S_IWUSR or  S_IXUSR);
retSTR:='xterm -title "'+(Sender as tmenuitem).hint+'" -hold -e sh "'+datadir+'/'+str1+'" &';
end;
screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
libc.system(pchar(retSTR));
finally
if (AnsiPos(ansilowercase('%DoListCustomCommand%'),
ansilowercase(trim(IniFile.ReadString ((sender as tmenuitem).parent.hint, (sender as tmenuitem).hint, 'none'))))>0)
then if (sender as tmenuitem).parent.count>0 then (sender as tmenuitem).parent.clear;
CheckAfterState(sini);
form1.Cursor:= crDefault;   
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
end;
exit;
end;
(******************************************************************************************************)

if (AnsiPos('%in',retSTR)=0)and
(AnsiPos('&in',retSTR)= 0) and
(AnsiPos('!in',retSTR)= 0) and
(AnsiPos('%realtask%',retSTR) = 0)and
(AnsiPos('$in',retSTR)= 0) and
(AnsiPos('%vclinternal%',retSTR)= 0) and
(AnsiPos('%dumptovcl%',retSTR)= 0) and
(AnsiPos('%vclexternal%',retSTR)= 0)
then
begin
try
form1.Cursor:= crHourGlass;   
//(xfgmemo).Lines.Add(retSTR);
if AnsiPos(AnsiLowercase('%RunMessage%'),AnsiLowercase(retSTR))<>0 then
begin
if AnsiEndsstr('&',trim(retSTR))then system.delete(retSTR,length(trim(retSTR)),1);
retSTR:=StringReplace(trim(retSTR),AnsiLowercase('%RunMessage%'),'',[rfReplaceAll, rfIgnoreCase]);
str1:=k.CRS_GetGuid+'ToBeDeleted';
K.crs_debug('#!/bin/bash'+#13#10+retSTR+#13#10+
'echo '+#13#10+'echo '+#13#10+'echo '+#13#10+'echo End OF Command : '+#13#10+'echo command = '+
(Sender as tmenuitem).hint+#13#10+'echo time started = '+timetostr(now),datadir+'/'+str1);
chmod(pchar(datadir+'/'+str1), S_IRUSR or  S_IWUSR or  S_IXUSR);
retSTR:='xterm -title "'+(Sender as tmenuitem).hint+'" -hold -e sh "'+datadir+'/'+str1+'" &';
end;
//screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
if Libc.system(pchar(retSTR) )= -1 then
(xfgmemo).Lines.Add('Can''t run '+retSTR)
 else
 if inifile.ValueExists ('xfgFilelistRefresh',(sender as tmenuitem ).hint) then CheckForm2Refresh;
finally
//if fileexists(datadir+'/'+str1)then deletefile(datadir+'/'+str1);
CheckAfterState(sini);
form1.Cursor:= crDefault;   
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
end;
exit;
end;
(******************************************************************************************************)

end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure Tform1.CheckStateAfterShellFile(Value:string);
begin
if inifile.ValueExists ('xfgFilelistRefresh',Value) then CheckForm2Refresh;
if inifile.ValueExists ('xfgMainBringToFront',Value) then form1.show;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure  Tform1.GoToGetProc(Sender: TObject);
var cp,s1,s2:string;
begin
//          $temp%PROC%{F0979C49-AAF8-D811-98FC-0080C8F89650}$
cp:=(sender as tmenuitem ).hint;

 s2:=(sender as tmenuitem ).parent.hint;
 if inifile.valueexists('xfgFileInputMenu', cp)then s2 :='xfgFileInputMenu';
 if IniFile.Readstring (s2,cp, 'none')='%WorkShellFile%'then s2 :='WorkShellFile';
 
 s1:=(trim((StringReplace(IniFile.Readstring (s2,cp, 'none'),'%','=',[rfIgnoreCase,rfReplaceAll]))));
//s1:=k.CRS_GetParamAtPos('$temp'+s1+'$','$','$','%',3);
//xfgmemo.lines.add(IniFile.Readstring (s2,cp, 'none'));
runscript(k.CRS_GetParamAtPos('[temp'+s1+']','[',']','=',3),Sender as tmenuitem);
end;

(******************************************************************************************************)
(******************************************************************************************************)
procedure Tform1.GoToShellFiles(Sender: TObject);
var cp,s1,s2,strk:string;APASSLST,outlst:TStringlist;APASSMemo:tmemo;
begin

APASSMemo:=xfgmemo;
(****************************************************************************************************)
if AnsiPos('%filenameappend',(trim(AnsiLowercase(inifile.Readstring ((sender as tmenuitem ).parent.hint,
(Sender as tmenuitem).hint, 'none')))))<>0 then
begin
APASSLST:=nil;
if (APASSMemo as tmemo).lines.Count=0 then begin
  MessageDlg ('ERROR loading files ' + #13#10+
        'Nothing to be done', mtInformation, [mbOK], 0);exit;end;
 
if CheckError((APASSMemo as tmemo).lines)=true then exit;
APASSLST:=TStringlist.create;

APASSLST.assign((APASSMemo as tmemo).lines);
K.CRS_CheckFileList(APASSLST);  

if APASSLST.count=0 then
begin
MessageDlg ('Can''t find valid existing file , so abort'+#13#10
                  , mtConfirmation, [mbOK], 0, mbOK);
APASSLST.free;
exit;
end;
outlst:=tstringlist.create;
try
K.CRS_FileNameAppend((sender as tmenuitem ).parent.hint,(Sender as tmenuitem).hint,GetCurrentDir,
APASSLST,inifile,outlst);
//filelist.refresh;
form1.showfilelist2(outlst);
finally
outlst.free;
if APASSLST <> nil then APASSLST.free;
end;
exit;
end;
(****************************************************************************************************)
if APASSLST <> nil then APASSLST.free;
APASSLST:=nil;
APASSLST:=TStringlist.create;
or2:=true;
cp:=(sender as tmenuitem ).hint;
if (sender as tmenuitem ).GetParentMenu=xfgmemopopup then
begin
if (sender as tmenuitem ).parent.hint=cp  then
s2:='xfgMemoMenu' else s2:=(sender as tmenuitem ).parent.hint;
end else
 s2:=(sender as tmenuitem ).parent.hint;
 s1:=(trim(inifile.Readstring (s2,cp, 'none')));

if lowercase(s1)='%menuviewwith%' then 
begin 
s1:=trim((inifile.Readstring ('MenuViewWith',cp, 'none')));
s2:='MenuViewWith';
end else
 if (lowercase(s1)='%workshellfile%')then
begin 
s1:=trim((inifile.Readstring ('WorkShellFile',cp, 'none')));
s2:='WorkShellFile';
end ;

if (

AnsiPos('%in',s1)=0)and
(

AnsiPos('&in',s1)= 0) and
(

AnsiPos('!in',s1)= 0) and
(

AnsiPos('%realtask%',s1) = 0)and
(

AnsiPos('$in',s1)= 0) and
(AnsiPos('%vclinternal%',s1)= 0) and
(AnsiPos('%dumptovcl%',s1)= 0) and
(AnsiPos('%vclexternal%',s1)= 0)
then
begin

UserExec(sender as tmenuitem);
if inifile.ValueExists ('xfgFilelistRefresh',cp) then CheckForm2Refresh;
if APASSLST<>nil then APASSLST.free;
exit;
end;
(***********************************************************************************************)
if 

AnsiPos('%realtask%',trim(ansilowercase(IniFile.Readstring (s2,cp, 'none')))) > 0 then 
begin
try

if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'))then
(Sender as tmenuitem).bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));  

form1.runMULTITASKcommandCLICK(sender as tmenuitem);
finally
CheckStateAfterShellFile(cp);
if APASSLST<>nil then APASSLST.free;

end;
exit;
end;
//fileinfopopup.hint:='xfgFileInputMenu';

(***********************************************************************************************)

 if  (ansipos(ansiLowercase('%DoListCustomCommand%'),
    ansilowercase((trim((inifile.Readstring ((sender as tmenuitem ).parent.parent.hint,
    (sender as tmenuitem ).parent.hint, 'none'))))))<>0)then
begin
APASSLST.clear;
APASSLST.add(trim((sender as tmenuitem ).hint));
end else
begin
APASSLST.clear;
APASSLST.text:=((APASSMemo as tmemo).text);
if (CheckError(APASSLST)=true) or (APASSLST.count=0)
then 
begin 
if APASSLST<>nil then APASSLST.free;
exit;
end;
end;

(***********************************************************************************************)
if 

AnsiPos('!in',IniFile.Readstring (s2,cp, 'none')) > 0 then 
begin
try
form1.show;
chdir(getcurrentdir);
if s2='MenuViewWith' then
form1.ShellFilesTOCAT('',s1,'',1,APASSLST)
else
form1.ShellFilesTOCAT(cp,s1,'',1,APASSLST);
finally
if APASSLST<>nil then APASSLST.free;
CheckStateAfterShellFile(cp);
end;
exit;
end;
(***********************************************************************************************)
if 

AnsiPos('%in',IniFile.Readstring (s2,cp, 'none')) > 0 then 
begin
 try
 form2.show;


 
chdir(getcurrentdir);
if s2='MenuViewWith' then
form1.ShellFilesTO('',s1,'',1,APASSLST)
else
form1.ShellFilesTO(cp,s1,'',1,APASSLST);
finally
CheckStateAfterShellFile(cp);
if APASSLST<>nil then APASSLST.free;
end;

exit;
end;
(***********************************************************************************************)
if 

AnsiPos('&in',IniFile.Readstring (s2,cp, 'none')) > 0 then 
begin 
try
form2.show;
chdir(getcurrentdir);
strK:='{'+StringReplace(IniFile.Readstring (s2,cp, 'none'),'&out','@',[rfIgnoreCase])+'}';
strK:=K.CRS_GetParamAtPos(strK,'{','}','@',2);
if 

AnsiPos(' ',strk)>0 then 
strk:=copy(strk,1,

AnsiPos(' ',strk)-1);
if s2='MenuViewWith' then
form1.ShellFilesTOSingleFile('',s1,'',1,APASSLST)
else
form1.ShellFilesTOSingleFile(cp,s1,'',1,APASSLST);

finally

if APASSLST<>nil then APASSLST.free;
CheckStateAfterShellFile(cp);
end;
exit;
end;
(***********************************************************************************************)
if 

AnsiPos('$in',IniFile.Readstring (s2,cp, 'none')) > 0 then 
begin
try

if s2='MenuViewWith' then 
form1.ShellFilesTOSingleAPPLICATION('',s1,'',1,APASSLST)
else
form1.ShellFilesTOSingleAPPLICATION(cp,s1,'',1,APASSLST);
finally
if APASSLST<>nil then APASSLST.free;
CheckStateAfterShellFile(cp);
end;
exit;
end;
(***********************************************************************************************)



if APASSLST<>nil then APASSLST.free;


end;

(******************************************************************************************************)
(******************************************************************************************************)
procedure Tform1.create_new_menu(APASSFromThisMenu:String;APASSParentMenuItem:TMenuItem) ;
var i:integer;imgfile:string;l:tstringlist;mm:TMenuItem;
begin
l:=tstringlist.create;
//create_new_menu(l2.Strings[i],Item)

 inifile.readsection(APASSFromThisMenu,l);
for i:=0 to l.count-1 do
begin

  mm:=TMenuItem.create(APASSParentMenuItem);
   with mm as TMenuItem do
    begin
    Hint := l.strings[i];
  if AnsiPos('---seperator',ansilowercase(l.strings[i]))>0 then 
   Caption := '-' else
      Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring(APASSFromThisMenu+'Image',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
         
if (AnsiPos(ansilowercase('%DoListCustomCommand%'),ansilowercase(trim(IniFile.ReadString (APASSFromThisMenu,
 l.Strings[i], 'none'))))>0)
   then  begin    onshow:=DoxfgMemoPopupitemsShow;
   OnHighlighted:= MenuItemOnHighlighted;  APASSParentMenuItem.add(mm);continue;end; 

         
if (

AnsiPos(ansilowercase('%ExpandDirForDocumentation%'),
ansilowercase(trim(IniFile.ReadString (APASSFromThisMenu, l.Strings[i], 'none'))))>0)
   then  begin OnHighlighted:= MenuItemOnHighlighted;  APASSParentMenuItem.add(mm);continue;end; 
 
   if (trim(ansilowercase(inifile.Readstring (APASSFromThisMenu, l.Strings[i], 'none')))='%createnew%' )
    then begin    if GetParentMenu=xfgMemoPopup then  onshow:=DoxfgMemoPopupitemsShow;
    create_new_menu(l.Strings[i],mm) ; APASSParentMenuItem.add(mm);continue;end;
    
  
 // xfgmemo.lines.add(IniFile.ReadString ('WorkShellFile',l.Strings[i],'none'));     

if (AnsiPos('%proc%',ansilowercase(trim(IniFile.ReadString (APASSFromThisMenu, l.Strings[i], 'none'))))>0)
   then  begin    onshow:=DoxfgMemoPopupitemsShow;
   OnClick := GoToGetProc; APASSParentMenuItem.add(mm);continue;end;
   
 if (ansipos('%proc%',ansiLowercase(IniFile.ReadString ('WorkShellFile',l.Strings[i],'none')))>0)
then  begin    onshow:=DoxfgMemoPopupitemsShow;
OnClick := GoToGetProc; APASSParentMenuItem.add(mm);continue;end;

if (trim(ansilowercase(IniFile.ReadString (APASSFromThisMenu, l.Strings[i], 'none')))='%workshellfile%')
   then   begin  
   if 

AnsiPos('%realtask%',(trim(ansilowercase(IniFile.ReadString ('WorkShellFile',l.Strings[i], 'none')))))>0 
   then if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'))then
   bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));   
   OnClick :=GoToShellFiles;  
   onshow:=DoxfgMemoPopupitemsShow;
    APASSParentMenuItem.add(mm);
   continue;     
   end;  
   
if AnsiPos('%realtask%',(trim(ansilowercase(IniFile.ReadString (APASSFromThisMenu,l.Strings[i], 'none')))))>0 
  then begin
     onshow:=DoxfgMemoPopupitemsShow;
   if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'))then
   bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));  
   OnClick := runMULTITASKcommandCLICK;  
   APASSParentMenuItem.add(mm);
   continue;    
   end;    
       
 if (AnsiPos('%vclinternal%',(trim(ansilowercase(IniFile.ReadString (APASSFromThisMenu, l.strings[i], 'none')))))>0)or
 (AnsiPos('%vclexternal%',(trim(ansilowercase(IniFile.ReadString (APASSFromThisMenu, l.strings[i], 'none')))))>0)or
(trim(ansilowercase(IniFile.ReadString (APASSFromThisMenu, l.strings[i], 'none')))='vcl')or
(AnsiPos('%dumptovcl%',(trim(ansilowercase(IniFile.ReadString (APASSFromThisMenu, l.strings[i], 'none')))))>0)


   then 
   begin  
      onshow:=DoxfgMemoPopupitemsShow;
   OnClick := form1.UserExecVCL ;
    APASSParentMenuItem.add(mm);
   continue;     
   end;  
   
      onshow:=DoxfgMemoPopupitemsShow;
  OnClick :=GoToShellFiles;   
     APASSParentMenuItem.add(mm);

   end;
 
end;

l.free;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.FormDestroy(Sender: TObject);

begin
if af<>nil then af.Free;
if aaf<>nil then aaf.Free;
if IniFile<>nil then IniFile.Free; 
if Critical1 <> nil then Critical1.Free; 
if k<>nil then k.Free;  
 if form4.TT<>nil then 
form4.TT.free;

end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.checkTHREADupdateFORCONTROL;
begin
 sameREALTASKmenuitemNoUpdate:=false;
if ThreadIOKILL=false then 
 begin
if MessageDlg ('Do you want to kill the command '+#13#10+'" ' +
             sameREALTASK+' "', mtInformation, [mbYes,mbNo], 0)=mrNo
then  begin sameREALTASKmenuitemNoUpdate:=true; exit ;end;
cleanup;
//MT1.terminate;
//if MT1.terminated=true then
//MT1.free;
//MT1:=nil;
 ThreadIOKILL:=true;
// ThreadIOKILL:=true;
 end;
  if ThreadFree=false then 
  begin 
  MT1.free;
    ThreadIOKILL:=true;
   ThreadFree:=true;
end;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
  var
 sr: TSearchRec; 
begin

 if FindFirst(datadir+'/'+'*', faAnyFile, sr) = 0 then
    begin
      repeat
       if 

AnsiPos('ToBeDeleted',sr.name)<>0  then  deletefile(datadir+'/'+sr.name);
       if 

AnsiPos('TMP',sr.name)<>0  then  deletefile(datadir+'/'+sr.name);
      until FindNext(sr) <> 0;
        FindClose(sr);    
     end;
(******************************************************************************************************)
aaf:=nil;
   aaf := TForm.Create (self);
    al:=tlabel.create(aaf);
         al.parent:=aaf;
          al.Font.Style :=[];
          al.Caption:='  Killing FileGarden , please wait  ...      ';   
         aaf.top:=form1.top+100;
        aaf.left:=form1.left+200;
        aaf.height:=150;
        aaf.width:=420;
        aaf.BorderStyle:=(fbsnone);
          aaf.Color :=11306588;
             aaf.Show; 
    al.Top :=32;
    al.Width:=aaf.width;
        al.Color :=11306588;
    al.Font.Color :=clbackground;
    al.Font.size :=24;
    al.Font.Name :='courior';
  al.Font.Style :=[fsBold];

    
EXIT_File_Operation:=true;
application.processmessages;

if (K.CRS_AF_DLG as tform)<>nil
then (K.CRS_AF_DLG as tform).close;

sameREALTASKmenuitemNoUpdate:=false;
if ThreadIOKILL=false then
begin 
cleanup;
 ThreadIOKILL:=true;
 end;
  if ThreadFree=false then 
  begin 
  MT1.free;
    ThreadIOKILL:=true;
   ThreadFree:=true;
end;
 
 if MT_DRAW_Thumbnail_TASK_RUNNING=true then 
MT20.terminate;
MT_DRAW_Thumbnail_TASK_RUNNING:=false;
if MT_IMAGE_GET_INFO_TASK_RUNNING=true then
MT10.terminate;
MT_IMAGE_GET_INFO_TASK_RUNNING:=false;


//AFreeform;

aaf.free;
(************************************)
RunAutoVCL(inifile,'xfgRunVCLBeforeDestroy');
(************************************) 
inifile.updatefile;


GimageEXTlist.free;


end;
(******************************************************************************************************)
(******************************************************************************************************)

constructor TRunMultiTask1.Create;
begin
inherited create(false);
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TRunMultiTask1.runSYNC;
var TEMPbmp:tbitmap;Temp: TControl;i,APASSINDEX:integer;
begin

//(**********************************************************************************************
 MT_IMAGE_GET_INFO_TASK_RUNNING:=true; 
   TEMPbmp:=tbitmap.create;
  for I := 0 to form3.thumbPanel.ControlCount - 1 do
  begin
   application.processmessages; 
  if MT_IMAGE_GET_INFO_TASK_RUNNING=false then break;
 
    Temp := form3.thumbPanel.Controls[I]; 
    if (temp is TIMAGE)  then
    begin
        if 

AnsiPos('broken image file',ansilowercase((temp as timage).hint)) >0 then continue;
         if 

AnsiPos('broken image file',ansilowercase((temp as timage).hint)) =0 then
          begin
        APASSINDEX:=iconthumblistDATAINFO.IndexOfName(k.CRS_GetParamAtPos('{'+StringReplace((temp as timage).hint,#13#10,'=',[rfIgnoreCase])+'}','{','}','=',1));
          If APASSINDEX=-1 then continue;
          If APASSINDEX>-1 then
          TEMPbmp.FreePixmap;
          TEMPbmp.loadfromfile(k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[APASSINDEX]+'}','{','}','=',2));
          if MT_IMAGE_GET_INFO_TASK_RUNNING=false then break;

         (temp as timage).hint:=k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[APASSINDEX]+'}','{','}','=',1)+#13#10+
                 '    width : '+(inttostr(TEMPbmp.width))+' pixels'+#13#10+
                     '   height : '+(inttostr(TEMPbmp.height))+' pixels'; 
          end; 
    end; 
  end;
  
TEMPbmp.free;
MT_IMAGE_GET_INFO_TASK_RUNNING:=false;
//***************************************************************************************************)
end;

//////////////////////////////////////////////////////////////////////////////////
procedure TRunMultiTask1.Execute;
begin
MT_IMAGE_GET_INFO_TASK_RUNNING:=true;
Synchronize (Form3.IMAGEcaculateINFO); 
//Synchronize (runSYNC); 

end;


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TRunMultiTask1.cleanup;
begin
;
end;  

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

constructor TRunMultiTask2.Create(APASSLOCATION:string);
begin
TMAPASSLOCATION:='';
TMAPASSLOCATION:=APASSLOCATION;

inherited create(false);
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TRunMultiTask2.runSYNC;

begin
//Critical1.Enter;   
Form3.drawthumbnail(TMAPASSLOCATION);
//Critical1.leave;   
end;
//////////////////////////////////////////////////////////////////////////////////
procedure TRunMultiTask2.Execute;

begin

//freeonterminate:=true;
  Synchronize (runSYNC); 
   // RECURSESearchDir2((TAPASSFolder));
 
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TRunMultiTask2.cleanup;
begin
;
end;  


//////////////////////////////////////////////////////////////////////////////////

constructor TRunMultiTask.Create(COMMAND: string);
//constructor TRunMultiTask.Create(AIO: PIOFile);
begin

APASSIOMemo:=form1.REALTASKMemo;
  //   BufferSize:= 5;
APASSStr:=''; 
IO:=nil;
//pid := fork;


IO:=popen(pchar(COMMAND),'r');


//IO:=(AIO);
// if Assigned(IO) then
inherited create(false);
end;

procedure TRunMultiTask.AddToList;
var start:integer;
begin
 
 start:= (APASSIOMemo as tmemo).GetTextLen;  
(APASSIOMemo as tmemo).lines.add(APASSStr); 
(APASSIOMemo as tmemo).SelStart:=start+1;
//memo.update; 
 // end;
 

end;


procedure TRunMultiTask.Execute;
begin
onterminate:=form1.checkout;

 if assigned(io) then
BlastIO;
 
end;


procedure TRunMultiTask.BlastIO;
var 
//MIO:PIOFile;
 PASSBuffer:array [0..1]of char;
  IOtempstr,IOstr: string;       

begin

repeat

if terminated then begin break;

end; 
 IOtempstr:=fgets(@PASSBuffer,sizeof(PASSBuffer),io);

 IOstr:=IOstr+IOtempstr;
   if (

AnsiPos(#10,IOstr) > 0)then
      begin

        APASSStr := copy(IOstr,1,

AnsiPos(#10,IOstr)-1);
        
         Synchronize (AddToList); 
       IOstr := ''; 
 
end;

//until IOtempstr='';
until FEOF(io)<>0;
end;

procedure TForm1.cleanup;
begin

//if (terminated=false) then terminate;

// wait(nil); 
// FreeMem(Line,BufferSize);
   //  echo $(dcc -B *.dpk 2> /text) >> /text
 libc.system(pchar('killall '+K.CRS_GetParamAtPos('{'+(runMULTITASKcommandinstr)+'}','{','}',' ',1)));
 MT1.terminate;
 //MT1.free;
 if form1.DEBUG=true then  form1.REALTASKMemo.lines.add('   cleanup-->'+runMULTITASKcommandinstr);

end;  
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.checkout(Sender: TObject);
begin
  
  libc.pclose(MT1.IO);
  wait(nil);
 
 

  ThreadIOKILL:=true;
  ThreadFree:=false ;
 

  if form1.DEBUG=true then 
 form1.REALTASKMemo.lines.add('  checkout--->'+sameREALTASKmenuitem.caption);

 sameREALTASKmenuitem.bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));
 
end;  
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.runMULTITASKcommand(CMD,AHint:string);
//var APASSIO:PIOFile;

begin

if ThreadIOKILL=false then 
 begin

 if trim(K.CRS_GetParamAtPos('{'+CMD+'}','{','}','%',3)) <>sameREALTASK then
 begin
if MessageDlg ('Killing running command then try again ?'+#13#10, mtInformation, [mbOK,mbcancel], 0)=mrcancel
then exit ;

end;
 if trim(K.CRS_GetParamAtPos('{'+CMD+'}','{','}','%',3)) =sameREALTASK then
if MessageDlg ('This will kill the command '+#13#10+'" ' +CMD+' "', mtInformation, [mbOK,mbcancel], 0)=mrcancel
 // libc.system(pchar('killall sh'));
then exit ;
cleanup;
//MT1.terminate;
//if MT1.terminated=true then
//MT1.free;
//MT1:=nil;

 exit;
 end;
//CMD:=CheckEXEArgument(CMD,AHint,check); 
if AHint<>'' then
CMD:=CheckEXEArgument(CMD,AHint);

if  CMD='' then 
begin
if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none')) then
sameREALTASKmenuitem.bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));
exit;
end;

CMD:=trim(K.CRS_GetParamAtPos('{'+CMD+'}','{','}','%',3)) ;

if ThreadIOKILL=true then 
 begin
// if ThreadFree=false then MT1.free;
 // MT1:=nil;
  runMULTITASKcommandinstr:=CMD;
    ThreadIOKILL:=false;
   ThreadFree:=false;

chdir(getcurrentdir);
  REALTASKMemo:=xfgmemo as tmemo;
  //  xfgIO := popen(pchar(runMULTITASKcommandinstr+'&'),'r'); 
  //if (

if (AnsiPos('@',pc.activepage.caption)>0) and (ThreadIOKILL=false)  then
  pc.Pages[pc.ActivePageIndex].caption:='  @'+AHint+'  ';
  ThreadIOKILLpcPage:=pc.Pages[pc.ActivePageIndex];
 
  //MT1 := nil;
 MT1 := TRunMultiTask.Create (runMULTITASKcommandinstr+' 2>&1');

//APASSIO:=popen(pchar(runMULTITASKcommandinstr+'&'),'r');
//
//grep da * 1>&2
 //MT1 := TRunMultiTask.Create ('echo $('+runMULTITASKcommandinstr+' 2> /xxxx) >> /xxxx');
// MT1 := TRunMultiTask.Create (runMULTITASKcommandinstr+' 2>&1');
 //MT1 := TRunMultiTask.Create ('dcpk 2>&1');
// MT1.IO:=popen(pchar(runMULTITASKcommandinstr+'&'),'r');
 // form1.caption:=runMULTITASKcommandinstr;

//MT1.policy:=SCHED_OTHER;
//MT1.priority:=0;
//MT1.memo := xfgmemo;
// MT1.Resume;
 //tail -f --retry -n 1 /var/log/messages

 end;


end;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.runMULTITASKcommandCLICK(Sender: TObject);
var runMULTITASKcommandinstr:string;
begin



{    if ThreadIOKILL=false then 
      try
(sender as tmenuitem).bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));
 
 
    except
    on E: Exception do
    begin
    ;
    end;end;
}  
//runMULTITASKcommandinstr:=(sender as tmenuitem).hint;
runMULTITASKcommandinstr:=(trim(IniFile.ReadString ( (sender as tmenuitem).parent.hint, (sender as tmenuitem).hint , 'none')));
if ansilowercase(trim(runMULTITASKcommandinstr))='%workshellfile%' 
then runMULTITASKcommandinstr:=inifile.Readstring ('WorkShellFile',(sender as tmenuitem).hint, 'none');

if runMULTITASKcommandinstr='' then exit;


if ThreadIOKILL=true then 
  try 
  if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskpleasekill', 'none')) then
(sender as tmenuitem).bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskpleasekill', 'none'));
sameREALTASKmenuitem:=(sender as tmenuitem);
     except
    on E: Exception do
    begin
    ;
    end;end;
    
CheckStateAfterShellFile((sender as tmenuitem).hint); 
//runMULTITASKcommandinstr:=trim(K.CRS_GetParamAtPos('{'+runMULTITASKcommandinstr+'}','{','}','%',3)) ;
runMULTITASKcommand(runMULTITASKcommandinstr,(sender as tmenuitem).hint);
sameREALTASK:=runMULTITASKcommandinstr;  

end;


//////////////////////////////////////////////////////////////////////////////////////////////////    

////////////////////////////////////////////////////////////////////////////////////////////////
  procedure TForm1.showfilelist2(FileNameList:TStrings);
  var instr,instrpath:string;
i:integer;
showall:Boolean;
item:ticonviewitem;
LVitem:TListitem;
begin



if (FileNameList.count=0 )or(FileNameList.strings[0]='') then begin exit;end;
if  

AnsiPos('/',FileNameList.strings[0])<>0 then
begin
instrpath:=extractfilepath(FileNameList.strings[0]);

//if form2.xfgcurrentdir<>instrpath then exit;
end;
//form2.filelist.directory.location:=instrpath;
showall:=false;
if (form2.FocusedControl=form2.filelist)then
begin
checkform2refresh;
form2.filelist.directory.filemask:='*';
end;
if (form2.FocusedControl=form2.listview)then
begin
form2.listview.refresh;
form2.listview.items.clear;
form2.DoListViewFileInfo(form2.xfgcurrentdir);
end;

try
for i:=0 to FileNameList.count-1 do
begin

if 

AnsiPos('/',FileNameList.strings[i])<>0 then
instr:=copy(FileNameList.strings[i],length(instrpath)+1,length(FileNameList.strings[i])-length(instrpath))
else instr:=FileNameList.strings[i];
if (form2.FocusedControl=form2.filelist)then
begin
if showall=false then 
if 

AnsiPos('.',instr)=1 then begin
form2.filelist.directory.filetype:=[ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];
showall:=true;end;  
item:=form2.filelist.FindItemByText(instr);
if item=nil then continue;
item.Selected:=true;
form2.filelist.EnsureItemVisible(item);
end;//if (form2.FocusedControl=form2.filelist)then

if (form2.FocusedControl=form2.listview)then
begin
//LVitem:TListitem;
LVitem:=form2.listview.FindCaption(0,instr, false, true, true);
if LVitem=nil then continue;
LVitem.selected:=true;
form2.listview.selected.MakeVisible;
end;//if (form2.FocusedControl=form2.listview)then



end;
except

;

end;
form2.show;

end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.showfilelist(FileName:String);
var instr:string;
index:integer;
showall:Boolean;
begin

if FileName=''then exit;

showall:=false;
if  

AnsiPos('/',FileName)<>0 then
begin
instr:=extractfilepath(FileName);

//if form2.xfgcurrentdir<>instr then exit;
end;
//form2.filelist.directory.location:=instr;
if (form2.FocusedControl=form2.filelist)then checkform2refresh;
if (form2.FocusedControl=form2.listview)then 
begin
form2.listview.refresh;
form2.listview.items.clear;
form2.DoListViewFileInfo(form2.xfgcurrentdir);
end;
try
if (form2.FocusedControl=form2.filelist)then 
begin
if showall=false then 
if 

AnsiPos('.',instr)=1 then begin
form2.filelist.directory.filetype:=[ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];
showall:=true;end;  
if 

AnsiPos('/',FileName)<>0 then
index:=form2.filelist.directory.indexof(copy(FileName,length(instr)+1,length(FileName)-length(instr)))
else
index:=form2.filelist.directory.indexof(FileName);
if index=-1 then exit;
form2.filelist.Selected:=form2.filelist.items[index];
form2.filelist.EnsureItemVisible(form2.filelist.Selected);
end;//if (form2.FocusedControl=form2.filelist)then 
if (form2.FocusedControl=form2.listview)then 
begin
//if lastdelimiter('/',FileName)=length(FileName)
if 

AnsiPos('/',FileName)<>0
then FileName:=extractfilename(FileName);
if form2.listview.FindCaption(0,FileName, false, true, true)=nil then exit;
form2.listview.selected:=form2.listview.FindCaption(0,FileName, false, true, true);
form2.listview.selected.MakeVisible;
end;
except
//form2.filelist.directory.filemask:='*';

end;


form2.show;

end;
/////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TForm1.AFreeForm;
begin

if af<>nil then
begin
af.free;
af:=nil;
end;
EXIT_File_Operation:=false;
end;
/////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.AAFClick(Sender: TObject);
begin
aaf.close;
end;
/////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
 ////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm1.AFspclick(Sender: TObject); 
begin
EXIT_File_Operation:=true;
application.processmessages;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure  TForm1.AFOnShow(Sender: TObject);
begin
application.processmessages;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm1.AFOnClose(Sender: TObject;var Action: TCloseAction);
begin
EXIT_File_Operation:=true;
application.processmessages;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm1.ACreateForm;
begin 

AF:=nil;
al:=nil;
al2:=nil;
aF := TForm.Create (form1);
af.parent:=form1;
af.top:=form1.top+100;
af.left:=form1.left+200;
af.height:=150;
af.width:=420;
af.BorderStyle:=(fbssingle);
af.Color :=11306588;
af.autoscroll:=false;
af.onshow:=AFOnShow;
af.onclose:=AFOnclose;

AFsp:=tBITBTN.create(af);
AFsp.parent:=af;
AFsp.color:=11306588;
AFsp.top:=af.height-50;
AFsp.left:=af.width-90;
AFsp.height:=40;
AFsp.width:=80;

al:=tlabel.create(af);
al2:=tlabel.create(af);  
al2.autosize:=true;
al.parent:=af;
al2.parent:=af;
al.Top :=28;
al.Font.Style :=[];
al.Caption:='  Working on files , please wait ...      '; 
aF.Show; 
al.Top :=32;
al.Width:=af.width-30;
al.Color :=11306588;
al.Font.Color :=clbackground;
al.Font.size :=24;
al.Font.Name :='courior';
al.Font.Style :=[fsBold];



al2.Top :=AFsp.top-32;
al2.Font.Color :=clbackground;
al2.Font.Name :='courior';
al2.Font.Style :=[fsBold];
al2.Color :=11306588;
al2.Width:=af.width-30;;
al2.Font.size :=13;
AFsp.Font.Color:=clbackground;
AFsp.Font.Style:= [FSBOLD];
AFsp.Font.Height:= 13;
AFsp.caption:='CANCEL';
AFsp.Font.Name:= 'sans';
AFsp.OnClick := AFspclick; 


AFsp.enabled:=true;
AFsp.visible:=true;  


  EXIT_File_Operation:=false;
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.PageTo(AMain,AMinor:STRING);
var
  exec2,exec3,exec,mime:string;APASSMemo:tmemo;
begin
try  

APASSMemo:=xfgmemo;
mime:= IniFile.Readstring ('xfgMIME', AMinor, 'none');
if mime='ps' then
(APASSMemo as tmemo).Lines.SaveToFile(datadir+'/redstone.org001');
if mime='pdf' then 
begin
//ss:='cp '+datadir+'/redstone.org001.ps'
//              +' '+datadir+'/redstone.org001';

//Libc.system(pchar(ss));
k.crs_copyfile(datadir+'/redstone.org001.ps',datadir+'/redstone.org001',true,true,false);

end;///////////////////////
  exec:= IniFile.Readstring (AMain, AMinor, 'none');
  exec2:=StringReplace(exec,'%in','"'+datadir+'/redstone.org001'+'" ',[rfIgnoreCase]);
  exec3:=StringReplace(exec2,'%out','"'+datadir+'/redstone.org001.'+mime+'"',[rfIgnoreCase]);

Libc.system(pchar(exec3));
except
;
end;


end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.FilesTO(AMain,AMinor:STRING;MODE:integer;AList:TStrings);

var
StrLst,outLst: TStringList;
 I: Integer;
 ID,ID2: Integer;
 exec2,exec3,exec,mime,instr,instrPath,path:string;
OK,IGNOREALL:boolean;
begin

IGNOREALL:=false ;
OK:=false ;
if (checkbox1.checked=true) or (form2.Dor2=1) then or2:=true ;
mime:= IniFile.Readstring ('xfgMIME', AMinor, 'none');
exec:= IniFile.Readstring (AMain, AMinor, 'none');

//exec:=CheckEXEArgument(exec,AMinor);
exec:=CheckEXEArgument(exec,AMinor);
if  exec='' then exit;

StrLst := TStringList.Create;
outLst:= TStringList.Create;

  if or2=true then begin
  

  
for i:=0 to AList.count-1 do
StrLst.add(AList[i]);
//StrLst.assign(AList);
K.CRS_CheckFileList(StrLst); 

if StrLst.count=0 then exit;

//instrPath:=form2.filelist.directory.location;
instrPath:=form2.xfgcurrentdir;
path:=extractfilepath(StrLst.strings[0]);
 outlst.clear;
   for I := 0 to StrLst.Count - 1 do 
    begin
    

   application.processmessages; 
 

if EXIT_File_Operation=true then break;

  exec2:=StringReplace(exec,'%in','"'+StrLst.Strings[i]+'"',[rfIgnoreCase]);
instr:=copy(StrLst.strings[i],length(path)+1,(length(StrLst.strings[i])-
length(path))-length(k.CRS_extractfileext(StrLst.strings[i])));

  exec3:=StringReplace(exec2,'%out','"'+instrPath+instr+'.'+mime+'"',[rfIgnoreCase]);
  if OK<>true then 
 if (mode =1)  or (mode =3) then // mode=0 ==> non-destructiive ,  mode=1 ==> destructive 
  begin  
  
if IGNOREALL=false then      
 if fileexists(instrPath+instr+'.'+mime) then begin

//if af<>nil then   af.top:=600-af.height;
    
ID:= showmessageFILEOperation(1,instrPath+instr+'.'+mime);
if ID=mrNO then continue;

if ID=mrIGNORE then 
 begin 
  ID2:= showmessageFILEOperation(2,'');
  
  if ID2=mrOK then IGNOREALL:=true;
  if ID2=mrNo  then continue;
  if ID2=mrAbort then break;
  
 end;
// if af<>nil then af.top:=round((600-af.height)div 2);

 
  end;
 
  end;

 //******************************* 
  if af <>nil then AL2.caption:='     '+extractfilename(StrLst.Strings[i]);
 //*******************************

if Libc.system(pchar(exec3)) = -1 then ;
  outlst.add(instrPath+instr+'.'+mime);

if checkbox3.checked=false then
begin
printHEADER(' Done files -->"'+mime+'" file format ----------> '+instrPath+instr+'.'+mime);

end;

 exec3:='';  

end;

end;

if checkbox3.checked=false then or2:=false;
if outlst.count>0 then
showfilelist2(outlst);
StrLst.Free;
outLst.Free;


end;
//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
 procedure TForm1.ShellFilesTOSingleAPPLICATION(AMain,AMinor,AJob:STRING;MODE:integer;AList:TStrings);
begin
if (checkbox1.checked=true) or (form2.Dor2=1) then or2:=true;
  if or2=true then begin

if mode <>3 then
AMinor:=CheckEXEArgument(AMinor,AMain);

if AMinor='' then exit;
//if AMain<>'' then 
//pc.activepage.caption:='  '+AMain+'  ';
//screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
K.CRS_ShellFilesTOSingleAPPLICATION(AMain,AMinor,AJob,MODE,AList);
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
end;

if checkbox3.checked=false then or2:=false;

 end;
//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
 procedure TForm1.ShellFilesTOSingleFile(AMain,AMinor,AJob:STRING;MODE:integer;AList:TStrings);
var
SingleFile:string;
begin
if (checkbox1.checked=true) or (form2.Dor2=1) then or2:=true ;
  if or2=true then begin

if mode <> 3 then
AMinor:=CheckEXEArgument(AMinor,AMain);
if AMinor='' then exit;
//screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true)then
//pc.activepage.caption:='  '+AMain+'  ';

K.CRS_ShellFilesTOSingleFile(AMain,AMinor,AJob,form2.xfgcurrentdir,MODE,AList);



if checkbox3.checked=false then or2:=false;

if  AList.count>0 then
begin
SingleFile:=alist[0];
if (fileexists(SingleFile))or
(directoryexists(SingleFile)) then
showfilelist(SingleFile);
end;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
(****************
if checkbox3.checked=false then
begin
printHEADER(' Done openning files -->'+' with '+exec3);
end;
************)
end;
 end;
 
//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

procedure TForm1.ShellFilesTO(AMain,AMinor,AJob:STRING;MODE:integer;AList:TStrings);
begin
if( checkbox1.checked=true) or (form2.Dor2=1) then or2:=true ;
  if or2=true then begin
  
if mode <>3 then
AMinor:=CheckEXEArgument(AMinor,AMain);
if AMinor='' then exit;
//screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
if (AnsiPos('@',pc.activepage.caption)<1)or (ThreadIOKill=true) then
//if AMain<>'' then 
//pc.activepage.caption:='  '+AMain+'  ';
k.CRS_ShellFilesTO(AMain,AMinor,AJob,form2.xfgcurrentdir,MODE,AList);



end;
if checkbox3.checked=false then or2:=false;
if AList.count>0 then
showfilelist2(AList);
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
(****************
if checkbox3.checked=false then
begin
printHEADER(' Done openning files -->'+' with '+exec3);
end;
************)

end;

//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

procedure TForm1.ShellFilesTOCAT(AMain,AMinor,AJob:STRING;MODE:integer;AList:TStrings);
var caretstart: Integer;APASSMemo:tmemo;

begin

if( checkbox1.checked=true) or (form2.Dor2=1) then or2:=true ;
  if or2=true then begin
APASSMemo:=xfgmemo;  
if mode <>3 then
AMinor:=CheckEXEArgument(AMinor,AMain);

if AMinor='' then exit;
form1.show;
//screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
  if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
//pc.activepage.caption:='  '+AMain+'  ';
caretstart:=(APASSMemo as tmemo).GetTextLen-length((APASSMemo as tmemo).lines[(APASSMemo as tmemo).lines.count-1]);

k.CRS_ShellFilesTOCAT(AMain,AMinor,AJob,form2.xfgcurrentdir,datadir,MODE,AList,
                          (APASSMemo as tmemo).lines);
(APASSMemo as tmemo).SelStart:=caretstart;
(*************************
if checkbox3.checked=false then
begin
printHEADER(' Done file -->'+strK+' with '+exec3);
end;
**********)



if checkbox3.checked=false then or2:=false;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
end;
end;


//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
procedure TForm1.buttonvcl(Sender: TObject); 
var ss:string;l1:tstringlist;APASSMemo:tmemo;
begin
//iniconf
ss:=((sender as TBitBtn).caption);


try
APASSMemo:=xfgmemo;
l1:=TStringList.create;
l1.assign((APASSMemo as tmemo).lines); 
if l1.count=0 then l1.add('No stringlist available');


if (IniFile.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then begin
printDEBUG((APASSMemo as tmemo),l1);
end;


if inifile <> nil then inifile.free;
inifile:=nil;
// Libc.system(pchar('cp '+iniconf
 //                       +' '+iniconf+'BACKUP'));     
k.crs_copyfile(iniconf,iniconf+'BACKUP',true,true,false);

k.LoadCompVCL(ss,filegardenUserCallingDIR+extractfilename(application.exename),l1);
//k.LoadCompVCL(ansilowercase((sender as tbutton).caption),Application.ExeName,l1);

//k.LoadCompVCL('pagesetup',Application.ExeName,nil);
//if l1.count=1 then k.LoadCompVCL('pagesetup',Application.ExeName,nil);
//ss:=k.RedStone_SysPath+'Command_Redstone '+'pagesetup'+' '
//           +Application.ExeName+' '+(ExtractFilePath (Application.ExeName)+'xfg.confBACKUP')+'&';
//Libc.system(pchar(ss));


finally
if inifile=nil then IniFile := TMemIniFile.Create (iniconf);
l1.free;
form2.show;
end;
//
end;

//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
procedure TForm1.UserExecVCL(Sender: TObject);
var
senderCaption,senderVCLMethod:string;APASSMemo:tmemo;
strs:TSTRINGList;i:integer;
begin
strs:=nil;
strs:=TSTRINGList.create;
APASSMemo:=xfgmemo as tmemo;

//if (APASSMemo).SelText='' then strs.text:=((APASSMemo).lines.text) else
//if (APASSMemo).SelText<>'' then strs.text:=(APASSMemo).SelText;

if sender is tmenuitem then
begin
if AnsiPos(AnsiLowercase('%DumpToVCL%'),
AnsiLowercase(IniFile.ReadString((sender as tmenuitem).parent.hint,(sender as tmenuitem).hint,'none')))<>0 then
begin
APASSUserExecVCL((sender as tmenuitem).hint,'%DumpToVCL%',(APASSMemo as tmemo).lines);
end else
begin
senderCaption:=(sender as tmenuitem).hint;
senderVCLMethod:=IniFile.ReadString((sender as tmenuitem).parent.hint,senderCaption,'none');
end;
end;
if sender is tspeedbutton then
begin
if AnsiPos(AnsiLowercase('%DumpToVCL%'),
AnsiLowercase(IniFile.ReadString((sender as tspeedbutton).parent.hint,(sender as tspeedbutton).hint,'none')))<>0 then
begin
APASSUserExecVCL((sender as tspeedbutton).hint,'%DumpToVCL%',(APASSMemo as tmemo).lines);
end else
begin
senderCaption:=(sender as tspeedbutton).hint;
senderVCLMethod:=IniFile.ReadString('xfgSpeedButton',senderCaption,'none');
end;
end;
if sender is TBitBtn then
begin
if AnsiPos(AnsiLowercase('%DumpToVCL%'),
AnsiLowercase(IniFile.ReadString((sender as TBitBtn).parent.hint,(sender as TBitBtn).hint,'none')))<>0 then
begin
APASSUserExecVCL((sender as TBitBtn).hint,'%DumpToVCL%',(APASSMemo as tmemo).lines);
end else
begin
senderCaption:=(sender as TBitBtn).caption;
senderVCLMethod:=IniFile.ReadString('xfgMainButton',senderCaption,'none');
end;
end;

APASSUserExecVCL(senderCaption,senderVCLMethod,(APASSMemo as tmemo).lines);




if strs<>nil then strs.free;
end;

//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

procedure TForm1.APASSUserExecVCL(APASSsenderCaption,APASSsenderVCLMethod:STRING;APASSLIST:TSTRINGS);
var ram,ss:string;TEMPSTRLST:TSTRINGLIST;i:integer;l1:tstringlist;
s,backupstr:string;lst:tstringlist;
posI:integer;tempini:tinifile;
ii,iii,iiii:integer;temp:Tcomponent;  ff:tform;tempControl:Tcontrol;tempP:tpanel;
begin

tempini:=nil;
s:=K.CRS_getguid;
if not fileexists(k.RS_USER_RESOURCE_PATH+'/'+'XFGVCLOptionPanel')then
if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel')then
libc.system(pchar('cp '+k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel'+' '
                       +k.RS_USER_RESOURCE_PATH+'/'+'XFGVCLOptionPanel'));
                       
if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLOptionPanel')then
begin



tempini:=tinifile.create(k.RS_USER_RESOURCE_PATH+'/'+'XFGVCLOptionPanel');


if (tempini.ValueExists('SingleInstance',APASSsenderCaption))then
begin




if fileexists(tempini.Readstring('SingleInstanceLock',APASSsenderCaption,'') )then
begin

lst:=tstringlist.create;
tempini.readsection(APASSsenderCaption+'ShowPanel',lst);
//Mail ImplantShowPanel
//////////////////////////////////////////////
for  I := 0 to Screen.FormCount-1 do
begin
if  trim(lowercase(Screen.Forms[I].caption ))='redstone commander' then 
 begin
   ff:=  Screen.Forms[I];
   for ii := ff.ComponentCount - 1 downto 0 do
    begin
     temp := ff.Components[ii]; 
     


      if (temp is TPanel) then 
     begin
     for iii := (temp as TPanel).ControlCount - 1 downto 0 do
     begin
     
     if ((temp as TPanel).Controls[iii] is TPanel)then
     begin
     
     for iiii:=0 to lst.count-1 do
     begin
     if ((temp as TPanel).Controls[iii].name=lst[iiii])then 
     begin
   (temp as TPanel).Controls[iii].bringtofront;
     end;
     end;
     
     end;
     (*
     if ((temp as TPanel).Controls[iii] is TPanel)and 
     ((temp as TPanel).Controls[iii].name='MailPanelFolder')then 
     begin
  (temp as TPanel).Controls[iii].bringtofront;
     end    ;
     *)

      end    ;
       end    ;
       



       end    ;//for ii := ff.ComponentCount - 1 downto 0 do
        end    ;//if  trim(lowercase(Screen.Forms[I].caption ))='redstone commander' then 
         end;//for  I := 0 to Screen.FormCount-1 do
//////////////////////////////////////////////
lst.free;
lst:=nil;


form2.fileOperationSBUpdate(false);
//xfgmemo.lines.add('SingleInstanceLock');
if tempini <> Nil then tempini.free;
end  
else//if fileexists(tempini.Readstring('SingleInstanceLock',APASSsenderCaption,'') )then
begin
s:=k.CRS_GetGuid;
s:=datadir+'/'+s+'-'+APASSsenderCaption+'ToBeDeleted';
k.CRS_DEBUG(APASSsenderCaption,s);
tempini.writestring('SingleInstanceLock',APASSsenderCaption,s);
//tempini.rename(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel',false);
tempini.updatefile;
  if tempini <> Nil then      tempini.free;tempini:=nil;
  form2.fileOperationSBUpdate(false);
end;






end ;//tempini.ValueExists('SingleInstance',APASSsenderCaption)then 



end;


s:='';
l1:=tstringlist.create;
posI:=AnsiPos(bookletVCL,'&');
delete(bookletVCL,posI,1);
if ansilowercase(APASSsenderCaption)=ansilowercase(bookletVCL) then
begin
if form2.xfgcurrentdir=form1.DATADIR+'/.thrash bin/' then begin  
 MessageDlg ('Can''t work on trash bin directory '  +#13#10+
        'Please choose another destination directory ', mtInformation, [mbOK], 0);exit;end;

checkTHREADupdateFORCONTROL;

Inifile.writestring ('xfgPrintBooklet', 'pagetopostcript2booklet', 'true');
 
CheckForm2Refresh;
s:=form2.xfgcurrentdir;


backupstr:='';
if fileexists(form2.xfgcurrentdir+'xfgBooklet.ps')=true then 
begin
backupstr:='xfgBooklet_BACKUP'+'_'+DateToStr(date)+'_'+TimeToStr(time)+'.ps';
backupstr:=stringreplace(backupstr,' ','',[rfIgnoreCase]);
MessageDlg ('The file  " xfgBooklet.ps " in : ' +form2.xfgcurrentdir+#13#10+
                                             'will be backup to " '+backupstr+' "'+#13#10+
                                            ' if you overwrite it with a new file'+#13#10
 , mtInformation, [mbOK], 0);
 
// form2.filelist.RenameFile(  form2.filelist.FindItemByText('xfgBooklet.ps'),backupstr);
RenameFile( form2.xfgcurrentdir  +'xfgBooklet.ps',form2.xfgcurrentdir+backupstr);

//libc.system(pchar('touch '+'"'+s+'xfgBooklet.ps'+'"'));
k.crs_copyfile(s+'xfgBooklet.ps',s+'xfgBooklet.ps',true,true,false);
//l1.savetofile(s+'xfgBooklet.ps');
CheckForm2Refresh;
end;
if not fileexists(s+'xfgBooklet.ps') then
//libc.system(pchar('touch '+'"'+s+'xfgBooklet.ps'+'"'));
k.crs_copyfile(s+'xfgBooklet.ps',s+'xfgBooklet.ps',true,true,false);
//l1.savetofile(s+'xfgBooklet.ps');
CheckForm2Refresh;
l1.free;

end;



if trim(ansilowercase(APASSsenderVCLMethod))='%vclexternal%'
then
try
//if APASSLIST.count=0 then APASSLIST.add('No stringlist available');
Randomize;
 ram:=datadir+'/'+'ToBeDeleted'+inttostr(Random(9628));
if (IniFile.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then begin
printDEBUG(xfgmemo,APASSLIST);
xfgmemo.lines.Add('11 component calling = k.RedStone_SysPath+''Command_Redstone ''+'+
                '(Sender as TMenuItem).Caption+'' ''+filegardenUserCallingDIR+extractfilename(application.exename)+'' ''+ram+''&''  --->  '+#13#10+
                '                       (Sender as Tcontrol).Caption = '+APASSsenderCaption+#13#10+
                '                       filegardenUserCallingDIR+extractfilename(application.exename) = '+
                               filegardenUserCallingDIR+extractfilename(application.exename)+#13#10+
                '                       ram = '+ram);
end;

if inifile<>nil then inifile.free;
inifile:=nil;
// Libc.system(pchar('cp '+iniconf+' '+iniconf+'BACKUP'));     
k.crs_copyfile(iniconf,iniconf+'BACKUP',true,true,false);     

 APASSLIST.savetofile(ram);
ss:=k.RS_SysPath+'Command_Redstone '+'"'+APASSsenderCaption+'"'+' '
          +filegardenUserCallingDIR+extractfilename(application.exename)+' '+ram+' -ns &';
Libc.system(pchar(ss));
finally
if inifile=nil then IniFile := TMemIniFile.Create (iniconf);
//if fileexists(ram) then DeleteFile(ram);
end;





if (trim(ansilowercase(APASSsenderVCLMethod))='%vclinternal%')or
(trim(ansilowercase(APASSsenderVCLMethod))='%dumptovcl%')

then
//try
try

TEMPSTRLST:=tstringlist.create;
for i:=0 to APASSLIST.count-1 do
TEMPSTRLST.add(APASSLIST[i]);

//if APASSLIST.count=1 then APASSLIST.add('No stringlist available');

if (IniFile.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then begin
printDEBUG(xfgmemo,APASSLIST);
        
xfgmemo.lines.Add('10 component calling = k.LoadCompVCL(''pagesetup'',filegardenUserCallingDIR+extractfilename(application.exename),nil)  --->  '+
                 'filegardenUserCallingDIR+extractfilename(application.exename) = '+filegardenUserCallingDIR+extractfilename(application.exename));
end;


if inifile<>nil then inifile.free;
inifile:=nil;
// Libc.system(pchar('cp '+iniconf+' '+iniconf+'BACKUP'));  
k.crs_copyfile(iniconf,iniconf+'BACKUP',true,true,false); 
       
if  ansilowercase(APASSsenderCaption)=ansilowercase(bookletVCL)then 
APASSsenderCaption:='Page setup';

if (trim(ansilowercase(APASSsenderVCLMethod))='%dumptovcl%')then
begin
(*****************************************************************************)
if tempini<>nil then tempini.free;
tempini:=nil;
if not fileexists(k.RS_USER_RESOURCE_PATH+'/'+'XFGVCLOptionPanel')then
if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel')then
libc.system(pchar('cp '+k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel'+' '
                       +k.RS_USER_RESOURCE_PATH+'/'+'XFGVCLOptionPanel'));
                       
if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLOptionPanel')then
tempini:=tinifile.create(k.RS_USER_RESOURCE_PATH+'/'+'XFGVCLOptionPanel');

if tempini.valueexists('DumpToVCL',APASSsenderCaption)then
s:=tempini.readstring('DumpToVCL',APASSsenderCaption,'');
tempini.clear;

tempini:=tinifile.create(stringreplace(s,'[HOME]',GetEnvironmentVariable('HOME'),[rfignorecase,rfreplaceall]));
s:=tempini.readstring('Main','ComponentCallingName','');
tempini.free;
tempini:=nil;
k.LoadCompVCL(s,filegardenUserCallingDIR+extractfilename(application.exename),TEMPSTRLST);

(*****************************************************************************)
end else
k.LoadCompVCL(APASSsenderCaption,filegardenUserCallingDIR+extractfilename(application.exename),TEMPSTRLST);
//xfgmemo.lines.add(APASSsenderCaption+'              SingleInstanceLock XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
finally
if inifile=nil then IniFile := TMemIniFile.Create (iniconf);
TEMPSTRLST.free;

if APASSsenderCaption='Page setup'then
begin
if fileexists(form2.xfgcurrentdir+'xfgBooklet.ps') then
begin
CheckForm2Refresh;
form2.filelist.Selected:= form2.filelist.items[form2.filelist.directory.indexof('xfgBooklet.ps')];
form2.filelist.EnsureItemVisible(form2.filelist.Selected);
end else
begin
if (backupstr<>'')and(fileexists(backupstr)) 
then
 form2.filelist.RenameFile(  form2.filelist.FindItemByText(backupstr),'xfgBooklet.ps');
end;
end;//if APASSsenderCaption='Page setup'then



end;

if AnsiLowercase(APASSsenderVCLMethod)=AnsiLowercase('%DumpToVCL%') then
begin
try
if l1<> nil then l1.free;

if lst<> nil then lst.free;

if tempini<> nil then tempini.free;

lst:=nil;
l1:=nil;
tempini:=nil;

lst:=tstringlist.create;
l1:=tstringlist.create;

s:=K.CRS_getguid;
if not fileexists(k.RS_USER_RESOURCE_PATH+'/'+'XFGVCLOptionPanel')then
if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel')then
libc.system(pchar('cp '+k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel'+' '
                       +k.RS_USER_RESOURCE_PATH+'/'+'XFGVCLOptionPanel'));
                       
if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLOptionPanel')then
tempini:=tinifile.create(k.RS_USER_RESOURCE_PATH+'/'+'XFGVCLOptionPanel');

if tempini.valueexists('DumpToVCL',APASSsenderCaption)then
s:=tempini.readstring('DumpToVCL',APASSsenderCaption,'');

tempini.free;

tempini:=tinifile.create(stringreplace(s,'[HOME]',GetEnvironmentVariable('HOME'),[rfignorecase,rfreplaceall]));

//[DumpToVCL]
//As New Text Email=ComposememoView
//As Email Attachment=LBoxAttach 
s:=tempini.readstring('DumpToVCL',APASSsenderCaption,'');
ss:=tempini.readstring('DumpToVCLControlParent',s,'');
if trim(s)<>'' then
begin


backupstr:='';
if tempini.valueexists('DumpToVCLNeedExpandFilelist',APASSsenderCaption)then
begin
for i:=0 to APASSLIST.count-1 do
begin
l1.clear;
if fileexists(APASSLIST[i])then
l1.loadfromfile(APASSLIST[i]);
backupstr:=backupstr+(l1.text)+#13#10;
end ;
lst.text:=backupstr;
end else
if tempini.valueexists('DumpToVCLNeedFileExists',APASSsenderCaption)then
begin
for i:=0 to APASSLIST.count-1 do
begin
if fileexists(APASSLIST[i])then
lst.add(APASSLIST[i]);
end ;
end else
lst.text:=(APASSLIST.text);


for  I := 0 to Screen.FormCount-1 do
begin
if  trim(lowercase(Screen.Forms[I].caption ))='redstone commander' then 
 begin
   ff:=  Screen.Forms[I];
   ff.show;
   for ii := ff.ComponentCount - 1 downto 0 do
    begin
     temp := ff.Components[ii]; 
     


      if (temp is TPanel) then 
     begin
     for iii := (temp as TPanel).ControlCount - 1 downto 0 do
     begin
     //tempControl:=(temp as TPanel).Controls[iii];
     if ((temp as TPanel).Controls[iii].name=ss)then
     begin
     
     tempP:=((temp as TPanel).Controls[iii] as tpanel);
     (tempP as tpanel).bringtofront;
       for iiii := tempP.ComponentCount - 1 downto 0 do
     begin
if (tempP as tpanel).Components[iiii].name=s then
begin

     if ((tempP as tpanel).Components[iiii] is tmemo) then
     begin
     //     for posI:=0 to lst.count-1 do
     ((tempP as tpanel).Components[iiii]as tmemo).lines.add(lst.text);
     end else
     if ((tempP as tpanel).Components[iiii] is tlistbox) then
     begin
     for posI:=0 to lst.count-1 do
     ((tempP as tpanel).Components[iiii]as tlistbox).items.add(lst[posI]);
     end else
      if ((tempP as tpanel).Components[iiii] is tedit) then
      begin
     ((tempP as tpanel).Components[iiii]as tedit).text:=lst.text ;
     
     end else
      if ((tempP as tpanel).Components[iiii] is TTextBrowser) then
     ((tempP as tpanel).Components[iiii]as TTextBrowser).text:=lst.text;
     

      if (((tempP as tpanel).Components[iiii]as tcontrol).parent) is ttabsheet then
     ((((((tempP as tpanel).Components[iiii]as tcontrol).parent) as ttabsheet).parent)as tpagecontrol).activepage:=(((tempP as tpanel).Components[iiii]as tcontrol).parent) as ttabsheet;
      if (((tempP as tpanel).Components[iiii]as tcontrol).parent) is tpanel then
     ((((tempP as tpanel).Components[iiii]as tcontrol).parent) as tpanel).bringtofront;

     
     exit;
    
end;
  end;
     
     end;

      end    ;
       end    ;
       



       end    ;//for ii := ff.ComponentCount - 1 downto 0 do
        end    ;//if  trim(lowercase(Screen.Forms[I].caption ))='redstone commander' then 
         end;//for  I := 0 to Screen.FormCount-1 do
//////////////////////////////////////////////




end;
if tempini<>nil then tempini.free;
if lst<>nil then lst.free;
if l1<>nil then l1.free;

except
MessageDlg ('Error in component' +#13#10, mtInformation, [mbOK], 0);
if tempini<>nil then tempini.free;
if lst<>nil then lst.free;
if l1<>nil then l1.free;
exit;
end;
end;



end;

//0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
(***********************************************
procedure tform1.UserFilesExec(Sender: TObject);
var
i:integer;
s1,s2,cp:string;
TEMPSTRLST:tstringlist;
begin
if form2.filelist.directory.location=form1.DATADIR+'/.thrash bin/' then begin  
 MessageDlg ('Can''t work on trash bin directory '  +#13#10+
        'Please choose another destination directory ', mtInformation, [mbOK], 0);exit;end;
        
if CheckError=true then exit;

if sender is tmenuitem then
begin
cp:=(Sender as TMenuItem).hint;
 s1:=IniFile.Readstring ((Sender as TMenuItem).parent.hint, (Sender as TMenuItem).hint, 'none');
 s2:='xfgMainButton';
 
end;
if sender is tspeedbutton then
begin
cp:=(Sender as tspeedbutton).hint;
 s1:=IniFile.Readstring ('xfgSpeedButton', (Sender as tspeedbutton).hint, 'none');
 s2:='xfgSpeedButton';
 
end;
//   with Sender as TMenuItem do
//begin
// s1:=IniFile.Readstring (parent.caption, Caption, 'none');
try
 form2.show;
  Acreateform;
  TEMPSTRLST:=tstringlist.create;
TEMPSTRLST.assign(xfgmemo.lines);
//K.CRS_CheckFileList(TEMPSTRLST); 
 // FilesTO(s2,s1,0,TEMPSTRLST);
 APASSUserFilesExec(cp,s1,TEMPSTRLST);
  afreeform;
   except
    on E: Exception do
    begin
      MessageDlg ('Error in Component: ' +
        E.Message, mtInformation, [mbOK], 0);
        TEMPSTRLST.free;
        afreeform;
    end;
end;

if TEMPSTRLST<>nil then TEMPSTRLST.free;
if af<>nil then afreeform;

end;
***********************************************)
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure tform1.APASSUserFilesExec(APASSsenderType,APASSsenderCommand:STRING;APASSLST:TSTRINGS);
begin
  FilesTO(APASSsenderType,APASSsenderCommand,0,APASSLST);


end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
(***************************************************************************
procedure tform1.UserFilesExecShell(Sender: TObject);
var
TEMPSTRLST:tstringlist;

 i:integer;
s1,s2,cp:string;
begin
 if form2.filelist.directory.location=form1.DATADIR+'/.thrash bin/' then begin  
 MessageDlg ('Can''t work on trash bin directory '  +#13#10+
        'Please choose another destination directory ', mtInformation, [mbOK], 0);exit;end;

if CheckError=true then exit;
if sender is tmenuitem then
begin
cp:=(Sender as TMenuItem).hint;
 s1:=IniFile.Readstring ((Sender as TMenuItem).parent.hint, (Sender as TMenuItem).hint, 'none');
 s2:='xfgMainButton';
 
end;
if sender is tspeedbutton then
begin
cp:=(Sender as tspeedbutton).hint;
 s1:=IniFile.Readstring ('xfgSpeedButton', (Sender as tspeedbutton).hint, 'none');
 s2:='xfgSpeedButton';
 
end;


try 
 form2.show;
acreateform;
TEMPSTRLST:=tstringlist.create;
TEMPSTRLST.assign(xfgmemo.lines);
//K.CRS_CheckFileList(TEMPSTRLST);
 if 
AnsiPos(
AnsiPos('%in',s1) > 0 then
ShellFilesTO(cp,s1,'',1,TEMPSTRLST)
 else if 
AnsiPos(
AnsiPos('&in',s1) > 0 then ShellFilesTOSingleFile(cp,s1,'',1,TEMPSTRLST);

Afreeform;

   except
    on E: Exception do
    begin
      MessageDlg ('Error in Component: ' +
        E.Message, mtInformation, [mbOK], 0);
        TEMPSTRLST.free;
        Afreeform;
    end;
  end;

if TEMPSTRLST<>nil then TEMPSTRLST.free;
if af<>nil then afreeform;

end;
***************************************************************************)
(******************************************************************************************************)
(******************************************************************************************************)
procedure TForm1.PTEDOnReturnPressed(Sender: TObject);
var i:integer;
begin
if (sender as tedit).name='ptedsearch'
then 
 for i := PanelMid.ControlCount - 1 downto 0 do
  if PanelMid.Controls[i].name='ptedspsearch'then 
  begin
  if (PanelMid.Controls[i]) is tspeedbutton then
(PanelMid.Controls[i] as tspeedbutton).click;
exit;
end;
end;
(******************************************************************************************************)
(******************************************************************************************************)
procedure tform1.spclick(Sender: TObject);
var APASSMemo:tmemo;tabindex:integer;APASSWholeWords,APASSCaseSensitive,APASSReplaceAll,SearchRSLT:boolean;
ASearchSTR,AReplaceSTR:string;aalst:tstringlist;
begin
  with (Sender as TSpeedButton) do
  begin
 if trim(ansilowercase(hint))='xfg' then 
 begin
 form2.rowup(form1);
 exit;
 end;
 
if trim(ansilowercase((sender as tspeedbutton).hint))='replace'
then 
begin 
APASSMemo:=xfgmemo;

 for tabindex := PanelMid.ControlCount - 1 downto 0 do
 begin
  if (PanelMid.Controls[tabindex]) is tcheckbox then
  if ansilowercase(trim(PanelMid.Controls[tabindex].name))='ptchkreplaceall'then
  APASSReplaceAll:= ((PanelMid.Controls[tabindex]) as tcheckbox).checked;
  if PanelMid.Controls[tabindex].name='ptedreplace'
  then AReplaceSTR:=(PanelMid.Controls[tabindex] as tedit).text;
   if PanelMid.Controls[tabindex].name='ptedsearch'
  then ASearchSTR:=(PanelMid.Controls[tabindex] as tedit).text;
    if (PanelMid.Controls[tabindex]) is tcheckbox then
  begin
  if ansilowercase(trim(PanelMid.Controls[tabindex].name))='ptchksearchword'then
  APASSWholeWords:= ((PanelMid.Controls[tabindex]) as tcheckbox).checked;
  if ansilowercase(trim(PanelMid.Controls[tabindex].name))='ptchksearchcase'then
  APASSCaseSensitive:= not ((PanelMid.Controls[tabindex]) as tcheckbox).checked;
  end;
 end;
SearchRSLT:=K.X_CRS_DoVCLMemoPageReplace(AReplaceSTR,ASearchSTR,
APASSMemo as tmemo,APASSCaseSensitive,APASSWholeWords,APASSReplaceAll);
        

exit;
end;



if trim(ansilowercase((sender as tspeedbutton).hint))='search'
then 
begin 

APASSMemo:=xfgmemo;

 for tabindex := PanelMid.ControlCount - 1 downto 0 do
 begin
  if (PanelMid.Controls[tabindex]) is tcheckbox then
  begin
  if ansilowercase(trim(PanelMid.Controls[tabindex].name))='ptchksearchword'then
  APASSWholeWords:= ((PanelMid.Controls[tabindex]) as tcheckbox).checked;
  if ansilowercase(trim(PanelMid.Controls[tabindex].name))='ptchksearchcase'then
  APASSCaseSensitive:= not ((PanelMid.Controls[tabindex]) as tcheckbox).checked;
  end;
  if PanelMid.Controls[tabindex].name='ptedsearch'
  then 
  begin
 
   if (PanelMid.Controls[tabindex]) is tedit then
 SearchRSLT:= K.X_CRS_DoVCLMemoPageSearch((PanelMid.Controls[tabindex] as tedit).text,
         APASSMemo as tmemo,APASSCaseSensitive,true,APASSWholeWords,true,false);
       //
 end;        
  end;
//TPClass_Command_RedStone.X_CRS_DoVCLMemoPageSearch
//(const APASSSearchStr:string;APASSMemo:tmemo;APASSCaseSensitive,APASSHighlightMatch,
 //   APASSWholeWords,APASSRegularExpr: Boolean);
   exit;
end; 
if trim(ansilowercase((sender as tspeedbutton).hint))='close all'
then 
begin 
if pc.pagecount=1 then exit;
for tabindex:=pc.pagecount-1 downto 0 do
begin
if (tabindex<>pc.ActivePageIndex)then
begin
if (pc.Pages[tabindex]=ThreadIOKILLpcPage) and (ThreadIOKILL=false)  then 
 begin
 checkTHREADupdateFORCONTROL;
 if sameREALTASKmenuitemNoUpdate=true then exit ;
 end;
 pc.Pages[tabindex].free;
end;

end;
xfgmemo.popupmenu:=xfgMemoPopup;
exit ;
end;
if trim(ansilowercase((sender as tspeedbutton).hint))='close page'
then 
begin 
tabindex:=0;
if pc.pagecount=1 then exit;
 if (pc.Pages[pc.ActivePageIndex]=ThreadIOKILLpcPage) and (ThreadIOKILL=false)  then 
 begin
 checkTHREADupdateFORCONTROL;
 if sameREALTASKmenuitemNoUpdate=true then exit ;
 end;
//if pc.FindNextPage( pc.Pages[pc.ActivePageIndex], true, false)<>nil
if pc.ActivePageIndex=pc.pagecount-1 
then tabindex:=pc.ActivePageIndex-1 else
tabindex:=pc.ActivePageIndex;
 pc.Pages[pc.ActivePageIndex].free;
pc.ActivePage:=pc.Pages[tabindex];
pc.ActivePage:=pc.ActivePage;
GetActiveMEMO;
exit;
end;
if trim(ansilowercase((sender as tspeedbutton).hint))='new page'
then 
begin 
createts1;
pc.activepage:=pc.pages[pc.pagecount-1];  

exit;
end; 


APASSMemo:=xfgmemo;
aalst:=tstringlist.create;
aalst.text:=(xfgmemo).text;
UserFilesExecShell2((Sender as TSpeedButton).hint,aalst);
aalst.free;
end;   

end;
//////////////////////////////////////////////////////////////////////////////////
procedure tform1.UserFilesExecShell2FileCommander(AHint:String;AAList:TStringlist);

begin

if AAList.count =0 then exit;

 try
 


if checkbox1.checked=false then exit; 

(*******************************************************************************)
if ansilowercase(AHint)='create symlink to file commander' then
begin
 if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
pc.activepage.caption:='  '+AHint+'  ';
form1.FileCopyMove(3,2,AAList);

end;
(*******************************************************************************)
if ansilowercase(AHint)='copy to file commander' then
begin
  if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
pc.activepage.caption:='  '+AHint+'  ';
form1.FileCopyMove(1,2,AAList);
end;
(*******************************************************************************)
if ansilowercase(AHint)='move to file commander' then
begin
  if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
pc.activepage.caption:='  '+AHint+'  ';
form1.FileCopyMove(2,2,AAList);
end;
(*******************************************************************************)
 if ansilowercase(AHint)='delete files in filelist' then
begin
  if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
pc.activepage.caption:='  '+AHint+'  ';
form1.FileDelete(2,AAList);
end;
(*******************************************************************************)

   except
    on E: Exception do
    begin
      MessageDlg ('Error in file operation : ' +
        E.Message, mtInformation, [mbOK], 0);
     
  end;
  end; 
 

 
end;
//////////////////////////////////////////////////////////////////////////////////
procedure tform1.UserFilesExecShell2(AHint:String;AList:TStringlist);
var

TEMPSTRLST:tstringlist;
s1,s2,cp:string;

begin


 cp:=AHint;
if CheckError(AList)=true then exit;

 if ansilowercase(AHint)='create symlink to file commander'
 then begin UserFilesExecShell2FileCommander(AHint,AList);exit;end;
 if ansilowercase(AHint)='copy to file commander'
 then begin UserFilesExecShell2FileCommander(AHint,AList);exit;end;
if ansilowercase(AHint)='move to file commander'
 then begin UserFilesExecShell2FileCommander(AHint,AList);exit;end;
 if ansilowercase(AHint)='delete files in filelist'
 then begin UserFilesExecShell2FileCommander(AHint,AList);exit;end;


TEMPSTRLST:=tstringlist.create;
TEMPSTRLST.assign(AList);
//K.CRS_CheckFileList(TEMPSTRLST);
try
//screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
s1:=IniFile.Readstring ('xfgSpeedButton',AHint, 'none');

if ansilowercase(s1)='%menuviewwith%'then
begin

s2:= IniFile.Readstring ('MenuViewWith',AHint, 'none');
if 

AnsiPos('%in',s2) > 0 then
ShellFilesTO('',s2,'',0,TEMPSTRLST)
else if 

AnsiPos('&in',s2) > 0 then 
ShellFilesTOSingleFile(cp,s2,'',0,TEMPSTRLST)
else if 

AnsiPos('$in',s2) > 0 then 
ShellFilesTOSingleAPPLICATION('',s2,'',0,TEMPSTRLST);
end;

if ansilowercase(s1)<>'%menuviewwith%'then
begin
if 

AnsiPos('%in',s1) > 0 then
ShellFilesTO('',s1,'',0,TEMPSTRLST)
else if 

AnsiPos('&in',s1) > 0 then 
ShellFilesTOSingleFile(cp,s1,'',0,TEMPSTRLST)
else if 

AnsiPos('$in',s1) > 0 then 
ShellFilesTOSingleAPPLICATION('',s1,'',0,TEMPSTRLST);
end;
finally
TEMPSTRLST.free;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
end;
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
Function TForm1.CheckEXEArgument(APASSString,APASSIndent:string):string;
VAR IniFileStr:STRING;
begin
result:=APASSString;
if APASSIndent='' then exit;
IniFileStr:=IniFile.Readstring ('QInputDLG',APASSIndent, 'none');
result:=K.CRS_CheckEXEArgument(IniFileStr,APASSString,APASSIndent);
//result:=IniFileStr;
//xfgmemo.lines.add(result);
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.GetCustomCommandFrom_CRS(APASSexec,APASSHint:string);
var str,cap:string;PosH,len,i:integer;Lst:tstringlist;FileDirSet:boolean;LVitem:TListitem;
begin
LVitem:=nil;


if APASSexec='%WorkShellFile%'then
APASSexec:=IniFile.Readstring ('WorkShellFile',APASSHint,'none');


if APASSexec='%DumpToVCL%'then 
begin
APASSUserExecVCL(APASSHint,'%DumpToVCL%',(xfgmemo as tmemo).lines);
exit;
end;

if AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemo'),AnsiLowercase(APASSexec))>0
then 
begin

screen.cursor:=crhourglass;
try
//screen.cursor:=crDefault;
if xfgmemo.SelText='' then xfgmemo.Selectall;
str:=K.CRS_DoListCustomCommand(APASSexec,APASSHint,xfgmemo.SelText);
xfgmemo.SelText:=str;
////screen.cursor:=crhourglass;
finally
screen.cursor:=crDefault;
end;
exit;
end;

if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtCursor%'),AnsiLowercase(APASSexec))>0
then 
begin
screen.cursor:=crhourglass;
try
str:=K.CRS_DoListCustomCommand(APASSexec,APASSHint,'');
if xfgmemo.sellength<>0 then xfgmemo.selstart:=xfgmemo.selstart+length(xfgmemo.seltext);
xfgmemo.insert(str,true);
finally
screen.cursor:=crDefault;
end;
exit;
end;


if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtLine%'),AnsiLowercase(APASSexec))>0
then 
begin
FileDirSet:=false;

try
if xfgmemo.hasselection then
str:=K.CRS_DoListCustomCommand(APASSexec,APASSHint,xfgmemo.SelText)
else
begin
PosH:=1;
len:=0;
cap:='';
cap:=xfgmemo.lines[xfgmemo.CaretPos.line];
if xfgmemo.CaretPos.line>0 then
begin
repeat
len:=len+length(xfgmemo.lines[PosH-1])+1;
Inc(PosH);
until PosH=xfgmemo.CaretPos.line+1;
end;
//xfgmemo.selstart:=len;
//xfgmemo.sellength:=length(cap)+1;
str:=K.CRS_DoListCustomCommand(APASSexec,APASSHint,cap);
end;


if str='' then exit;
Lst:=tstringlist.create;
Lst.text:=str;
//if Lst.count > 1 then str:=Lst[Lst.count-1];
for i:=Lst.count-1 downto 0  do
begin
screen.cursor:=crhourglass;
if AnsiPos(AnsiLowercase('%XFGMemoInsertExecuteThisCommandToFileManager%'),AnsiLowercase(Lst[i]))>0 then  
begin
cap:=trim(stringreplace(Lst[i],('%XFGMemoInsertExecuteThisCommandToFileManager%'),'',[rfReplaceAll,rfIgnoreCase]));
if extractfilepath(trim(cap))='' then cap:=getcurrentdir+'/'+trim(cap);
if not(fileexists(cap)) and  not(directoryexists(cap))then 
begin
screen.cursor:=crdefault;
  MessageDlg ('Can''t locate file : '+cap+' '+#13#10+#13#10
        , mtInformation, [mbOK], 0);
        
continue;
end;
form2.show;
//K.crs_debug((cap),'/xx');

if form2.FocusedControl=(form2.ListView)then 
begin
if not FileDirSet then
begin
form2.DoListViewFileInfo(trim(extractfilepath(cap)));
FileDirSet:=true;
end;
//if trim(extractfilepath(cap))<>form2.cmb.text then continue;

try 
if fileexists(trim((cap)))then
begin
//LVitem:TListitem;
LVitem:=form2.listview.FindCaption(0,extractfilename(trim(cap)), false, true, true);
if LVitem=nil then continue;
LVitem.selected:=true;
form2.listview.selected.MakeVisible;
 end;  
except
begin
if Lst<>nil then Lst.free;
exit;
end;
end;
form2.internallist.clear;
form2.internallist.add(trim((cap)));

end else
begin

if not FileDirSet then
begin
if AnsiPos('.',extractfilename(cap))=1 then
begin
form2.filelist.directory.filetype:=[ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];
form2.filelist.directory.filemask:='*';

end;
form2.filelist.directory.location:=trim(extractfilepath(cap));
checkform2refresh;

FileDirSet:=true;
end;
if trim(extractfilepath(cap))<>form2.filelist.directory.location then continue;

try
if fileexists(trim((cap)))then
begin
  form2.filelist.Selected:=form2.filelist.items[form2.filelist.directory.indexof(trim(extractfilename(cap)))];
   form2.filelist.EnsureItemVisible(form2.filelist.Selected);

   end;
except
begin
if Lst<>nil then Lst.free;
exit;
end;
end; 
form2.internallist.clear;
form2.internallist.add(trim((cap)));
end;

end else

if AnsiPos(AnsiLowercase('%XFGMemoInsertExecuteThisCommandToEditor%'),AnsiLowercase(Lst[i]))>0 then  
begin

if trim(Lst[i])='' then continue;
cap:=trim(stringreplace(Lst[i],'%XFGMemoInsertExecuteThisCommandToEditor%','',[rfReplaceAll,rfIgnoreCase]));
if (directoryexists(cap))or (not fileexists(cap))then 
begin
screen.cursor:=crDefault;
MessageDlg ('File not exists.' +#13#10+#13#10
        , mtinformation, [mbOK], 0);
continue;
end;
createts1;pc.activepage:=pc.pages[pc.pagecount-1];  
if (fileexists(cap)) then 
begin
xfgmemo.lines.loadfromfile(cap);
pc.activepage.caption:=cap;
end;
end;

end;
finally
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
end;
if Lst<>nil then Lst.free;
exit;
end;

if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsert%'),AnsiLowercase(APASSexec))>0
then 
begin
//if xfgmemo.SelText='';
try
screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
str:=K.CRS_DoListCustomCommand(APASSexec,APASSHint,'');
xfgmemo.insert(str,true);
finally
screen.cursor:=crDefault;
end;
exit;
end;

if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertFormat%'),AnsiLowercase(APASSexec))>0
then 
begin
screen.cursor:=crhourglass;
try
if xfgmemo.hasselection=true then
str:=K.CRS_DoListCustomCommand(APASSexec,APASSHint,xfgmemo.selText)else
begin
xfgmemo.selectall;
str:=K.CRS_DoListCustomCommand(APASSexec,APASSHint,xfgmemo.Text);
end;

if k.crs_extractfileext(pc.activepage.caption)<>'' then
cap:=copy(pc.activepage.caption,1,AnsiPos(K.crs_extractfileext(pc.activepage.caption),pc.activepage.caption)-1)
else cap:=pc.activepage.caption;

xfgmemo.seltext:='';
//xfgmemo.insert(str,false);
xfgmemo.insert(stringreplace(str,'%XFGMemoInsertFormatHeading%',cap,[rfReplaceAll,rfIgnoreCase]),false);
//xfgmemo.seltext:=stringreplace(str,'%XFGMemoInsertFormatHeading%',cap,[rfReplaceAll,rfIgnoreCase]);;

if inifile.valueexists('xfgMemoMenuUpdateTabCaption',APASSHint) then
 if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
pc.activepage.caption:=' '+trim(cap)+
trim(inifile.readstring('xfgMemoMenuUpdateTabCaption',APASSHint,'.txt'))+' ';

finally
screen.cursor:=crDefault;
end;
exit;

end;

end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.UserExec(Sender: TObject);
var exec,str:string;
begin

if sender is tmenuitem then
begin

 exec:=IniFile.Readstring ((Sender as TMenuItem).parent.hint, (Sender as TMenuItem).hint, 'none');
 if trim(ansilowercase(exec))='%workshellfile%' then
exec:=IniFile.Readstring ('WorkShellFile', (Sender as TMenuItem).hint, 'none');

if (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemo'),AnsiLowercase(exec))>0)
or (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemo'),AnsiLowercase(exec))>0)
then 
begin
GetCustomCommandFrom_CRS(exec,(Sender as TMenuItem).hint);
exit;
end;



if AnsiPos(AnsiLowercase('%JustExecuteThisAndDoNothingPlease%'),AnsiLowercase(exec))>0 then 
begin

str:=K.CRS_DoListCustomCommand(exec,(Sender as TMenuItem).hint,xfgmemo.text);

if str<>'' then exec:=str;
if exec='' then exit;
if Libc.system(pchar(K.CRS_GetParamAtPos('{'+exec+'}','{','}','%',3)+' &') )= -1 then
  begin
    (xfgmemo).Lines.Add('Can''t run '+exec);
  end;
  exit;
end;

UserExecCommand((Sender as TMenuItem).hint,exec,Sender as TMenuItem);


end;
if sender is tspeedbutton then
begin
 exec:=IniFile.Readstring ('xfgSpeedButton', (Sender as tspeedbutton).hint, 'none');
 UserExecCommand((Sender as tspeedbutton).hint,exec,(Sender as tspeedbutton));

if exec='' then exit;
end;



end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.UserExecCommand(AMain,AMinor:string;sender:TObject);
var
caretstart:integer;
MStr:TMEMORYSTREAM;
exec,instr,GUIDStr1,GUIDStr2:string;
APASSMemo:tmemo;

begin
exec:=AMinor;
checkbox1.checked:=false;
MStr:= TMEMORYSTREAM.Create;

GUIDStr1:=K.CRS_GetGuid;
GUIDStr2:=K.CRS_GetGuid;

//exec:=CheckEXEArgument(exec,AMain);
exec:=CheckEXEArgument(exec,AMain);
if  exec='' then exit;
APASSMemo:=xfgmemo;
////screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
if 

AnsiPos('%PipeLn%',exec)>0 then
begin
(APASSMemo as tmemo).lines.savetofile(datadir+'/'+GUIDStr2);
exec:=trim(stringreplace(exec,'%PipeLn%',' ',[rfIgnoreCase]));
if Libc.system(pchar('cat '+datadir+'/'+GUIDStr2+' | '+exec+' | cat -v > '+datadir+'/'+GUIDStr1)) = -1 then
  begin
    (APASSMemo as tmemo).Lines.Add('Can''t run '+exec);
  end;
  
end else

if 

AnsiPos('%CatLn%',exec)>0 then
begin
(APASSMemo as tmemo).lines.savetofile(datadir+'/'+GUIDStr2);
exec:=trim(stringreplace(exec,'%CatLn%',' ',[rfIgnoreCase]));
if Libc.system(pchar('cat '+datadir+'/'+GUIDStr2+' > '+exec+' | cat -v > '+datadir+'/'+GUIDStr1)) = -1 then
  begin
    (APASSMemo as tmemo).Lines.Add('Can''t run '+exec);
  end;
end else

if Libc.system(pchar(exec+' | cat -v > '+datadir+'/'+GUIDStr1)) = -1 then
  begin
    (APASSMemo as tmemo).Lines.Add('Can''t run '+exec);
  end;


if checkbox2.checked=true  // print header
   then begin
  printHEADER(' run command : '+exec);
end;

////screen.cursor:=crhourglass;
//screen.cursor:=crDefault;


try
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
MStr.LoadFromFile(datadir+'/'+GUIDStr1);
caretstart:=(APASSMemo as tmemo).GetTextLen-
length((APASSMemo as tmemo).lines.strings[(APASSMemo as tmemo).lines.count-1]);


     SetLength(instr, MStr.Size);
//STRsize:=STRsize+MStr.Size;
   //  if length(instr)> 419200 then acreateform;
   //  if STRsize > 419200 then acreateform; 
 MStr.Read(Pointer(instr)^, MStr.Size);

finally
if MStr.Size<>0 then
begin
(APASSMemo as tmemo).lines.append(instr);
 (APASSMemo as tmemo).SelStart:=caretstart;
 MStr.free;
if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
pc.activepage.caption:='  '+AMain+'  ';
end;//if MStr.Size<>0 then
 if fileexists(datadir+'/'+GUIDStr1) then
 deletefile(datadir+'/'+GUIDStr1);
 if fileexists(datadir+'/'+GUIDStr2) then
 deletefile(datadir+'/'+GUIDStr2);
// //screen.cursor:=crhourglass;
screen.cursor:=crDefault;
 end;

end;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Button1Click(Sender: TObject);

begin
  //  xfgmemo.Lines.LoadFromFile(OpenDialog1.FileName);
  //  FileName := OpenDialog1.FileName;
 //   StatusBar1.Panels[0].Text := FileName;
 // if OpenDialog1.Files.Count=1 then 
//form2.listview.bringtofront;
form2.filelist.bringtofront;
form2.show;

{
 if OpenDialog1.Execute then
  begin
//  acreateform;
DoOpen(OpenDialog1.Files);

 end;
} 
//  afreeform;
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.doopen(Files: TSTRINGS); 
var
 ii,caretstart,memP:integer;
 MStr:TMEMORYSTREAM;
APASSMemo:tmemo;
Pinfo:PFileInfo;
// MStr:TFilestream;
 instr,tempinstr:string;STRsize:int64 ;
begin
xfgmemo.popupmenu:=xfgMemoPopup;
if AF<>nil then
begin
MessageDlg ('System busy , so abort ' +#13#10+#13#10
        , mtinformation, [mbOK], 0);
        
exit;
end;
  
 EXIT_File_Operation:=false;
APASSMemo:=xfgmemo;
if form2.FocusedControl=form2.memo then
begin
screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
(APASSMemo as tmemo).lines.add(form2.memo.text);
or2:=true;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
exit;
end;

    if  checkbox1.checked=false // file list mode off
     then 
       begin 
   STRsize:=0;  
   af:=NIL;
 MStr := nil;
 instr:='';
tempinstr:='';
MStr:=TMEMORYSTREAM.create;
try
//screen.Cursor:= crHourGlass; 
for ii := 0 to Files.Count - 1 do
begin
 if EXIT_File_Operation=true then break;  
 EXIT_File_Operation:=false;
 application.processmessages;
Pinfo:=K.CRS_GetFilePInfo(Files.Strings[ii]);
if S_IsSOCK(Pinfo.stat.st_mode)
then 
begin
MessageDlg (Files.Strings[ii]+#13#10+#13#10+
'is a SOCKET file , so can''t open it '
, mtConfirmation, [mbOK], 0, mbOK);
continue;
end;
if S_IsFifo(Pinfo.stat.st_mode)and (Pinfo.stat.st_mode and (S_IFDIR)=0)
then 
begin
MessageDlg (Files.Strings[ii]+#13#10+#13#10+
'is a FIFO stream , so can''t open it '
, mtConfirmation, [mbOK], 0, mbOK);
continue;
end;
if S_IsCHR(Pinfo.stat.st_mode)and (Pinfo.stat.st_mode and (S_IFDIR)=0)
then 
begin
MessageDlg (Files.Strings[ii]+#13#10+#13#10+
'is a CHARACTER device , so can''t open it '
, mtConfirmation, [mbOK], 0, mbOK);
continue;
end;
if S_IsBLK(Pinfo.stat.st_mode)
then 
begin
MessageDlg (Files.Strings[ii]+#13#10+#13#10+
'is a BLOCK device , so can''t open it '
, mtConfirmation, [mbOK], 0, mbOK);
continue;
end;
if directoryexists(Files.Strings[ii])
then 
begin
MessageDlg (Files.Strings[ii]+#13#10+#13#10+
'is a directory , so can''t open it '
, mtConfirmation, [mbOK], 0, mbOK);
continue;
end;


if  checkbox2.checked=true then printHEADER(' run command : Open file -->  '+Files.Strings[ii]);

try
screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
while EXIT_File_Operation=false do
begin
MStr.loadfromfile(Files[ii]);
caretstart:=(APASSMemo as tmemo).GetTextLen-length((APASSMemo as tmemo).lines.strings[(APASSMemo as tmemo).lines.count-1]);
//SetLength(instr, MStr.Size);
SetLength(tempinstr, 1);
if MStr.Size > 419200 then acreateform; 
//******************************* 
  if AF <> nil then begin screen.Cursor:= crDefault;AL2.caption:='     '+extractfilename(Files[ii]);end;
 //*******************************
MStr.position:=0;
for memP:=1 to  MStr.Size do
begin
 if EXIT_File_Operation=true then break;  
SetLength(tempinstr, 1);
application.processmessages;
MStr.Read(Pointer(tempinstr)^, 1);
instr:=instr+tempinstr;
end;
(APASSMemo as tmemo).lines.append(instr);

 if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
pc.activepage.caption:='  '+Files[ii]+'  ';
EXIT_File_Operation:=true;
end;
finally

MStr.clear;
(APASSMemo as tmemo).SelStart:=caretstart;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
end;

or2:=false;

end;// for ii := 0 to Files.Count - 1 do
finally
EXIT_File_Operation:=false;
//screen.Cursor:= crDefault;    
if af<>nil then  afreeform; 
MStr.free;
end;
end // if  checkbox1.checked=false  
    

else // file list mode on
     if  checkbox1.checked=true then begin
   //  xfgmemo.lines.clear;
      if  checkbox2.checked=true  // print header
   then begin
    printHEADER(' run command : Writing file listing -->  ');
end;

try
screen.cursor:=crhourglass;
for ii := 0 to Files.Count - 1 do
begin
(APASSMemo as tmemo).insert( Files.Strings[ii]+#13#10,false);
//if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then ;
//   pc.activepage.caption:='  '+Files[ii]+'  ';

end;
finally
screen.cursor:=crDefault;
end;
or2:=true;




end;


end;


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.Button2Click(Sender: TObject);
var 
  MSTR: TMemoryStream;
   instr,memostr,Filterstr:string;
   APASSMemo:tmemo;
begin
APASSMemo:=xfgmemo;
if (APASSMemo as tmemo).lines.Count=0 then begin
if  MessageDlg ('Nothing to be done' +#13#10+
        'Creating blank file ?', mtwarning, [mbOK,mbcancel], 0)=mrcancel 
then exit;
end
else
checkTHREADupdateFORCONTROL;

 instr:='';
MSTR := nil;
//form2.filelist.refresh;
//Filterstr = 'postscript|*.ps|adobe|*.pdf|text|*.txt|all file|*'
Filterstr := SaveDialog1.Filter;
SaveDialog1.Filter:= 'all file|*';
SaveDialog1.InitialDir :=form2.xfgcurrentdir; 
SaveDialog1.FileName := trim(pc.activepage.caption);
SaveDialog1.filterindex:=1;
   
if SaveDialog1.Execute then
  begin 
   try
  MSTR := TMemoryStream.Create;
//MSTR.loadfromfile(SaveDialog1.FileName);
//xfgmemo.selectall;
 memostr:=(APASSMemo as tmemo).text;
 
     SetLength(instr, Length(memostr));
   
    instr:=memostr;
   
  MSTR.Write(Pointer(instr)^, Length(instr));
   MSTR.savetofile(SaveDialog1.FileName);
//  ext:=ansilowercase(extractfileext(SaveDialog1.FileName));
// if (ext<>'.ps') or (ext<>'.pdf') then
 //  dosave('');
//  if (ext='.ps') or (ext='.pdf') then
//   dosave(copy(ext,2,length(ext)-1));

// xfgmemo.Lines.SaveToFile(SaveDialog1.FileName);
showfilelist(SaveDialog1.FileName);
pc.activepage.caption:='  '+SaveDialog1.FileName+'  ';
   except
      MSTR.Free;
      SaveDialog1.Filter:= Filterstr;
      raise;
    end; // try
    MSTR.Free;
////
 end;
SaveDialog1.Filter:= Filterstr;
 
 //   StatusBar1.Panels[0].Text := FileName; 
end;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Button3Click(Sender: TObject);
var 
ss:string;APASSMemo:tmemo;
begin
APASSMemo:=xfgmemo;
//PageTo(AMain,AMinor:STRING);
//if checkbox1.checked=false then or2:=0;
if (APASSMemo as tmemo).lines.Count=0 then begin
if  MessageDlg ('Nothing to be done' +#13#10+
        'Creating blank Postscript file ?', mtwarning, [mbOK,mbcancel],0)=mrcancel 
then exit;

end;
checkTHREADupdateFORCONTROL;
 try 
  form2.show;
 Acreateform;
  screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
pageto('xfgMainButton','pagetopostcript');
Afreeform;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
   except
    on E: Exception do
    begin
 //   //screen.cursor:=crhourglass;
screen.cursor:=crDefault;
      MessageDlg ('Error in Component: ' +
        E.Message, mtInformation, [mbOK], 0);
 Afreeform;
    end;
  end;
/////////////////////////////////////////
 //SaveDialog1.InitialDir := '~';
  //form2.filelist.refresh;
 SaveDialog1.InitialDir := form2.xfgcurrentdir; 
 SaveDialog1.filterindex:=1;
 ss:=trim(pc.activepage.caption);
 if AnsiPos('.',extractfilename(ss)) =1 then
delete(ss,length(extractfilepath(ss))+1,1);
delete(ss,AnsiPos(K.CRS_ExtractFileExt(ss),ss),length(K.CRS_ExtractFileExt(ss)));
 SaveDialog1.FileName :=ss+'.ps';


if SaveDialog1.Execute then
  begin 
// if (ansilowercase(extractfileext(SaveDialog1.FileName))='.ps') or
//   (ansilowercase(extractfileext(SaveDialog1.FileName))='.pdf') then
//   dosave(copy(extractfileext(SaveDialog1.FileName),2,length(extractfileext(SaveDialog1.FileName))-1));
//dosave('ps');
//ss:='cp '+datadir+'/redstone.org001.ps'+' '+SaveDialog1.FileName;
//Libc.system(pchar(ss));
//SaveDialog1.FileName :=SaveDialog1.FileName;

k.crs_copyfile(datadir+'/redstone.org001.ps',SaveDialog1.FileName,true,true,false);
//pc.activepage.caption:='  '+SaveDialog1.FileName+'  ';
showfilelist(SaveDialog1.FileName);

//(APASSMemo as tmemo).refresh;
 end;
 
 //   StatusBar1.Panels[0].Text := FileName; 

///////////////////////////////////////
 or2:=false;

end;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Button4Click(Sender: TObject);
 var 
ss:string;   APASSMemo:tmemo;              
begin
APASSMemo:=xfgmemo;
if (APASSMemo as tmemo).lines.Count=0 then begin
if  MessageDlg ('Nothing to be done' +#13#10+
        'Creating blank PDF file ?', mtwarning, [mbOK,mbcancel], 0)=mrcancel 
then exit;
end
else
checkTHREADupdateFORCONTROL;   
if checkbox1.checked=false then or2:=false;
try
screen.cursor:=crhourglass;
///screen.cursor:=crDefault;
 form2.show;
Acreateform;
   
pageto('xfgMainButton','pagetopostcript'); 
//xfgmemo.Lines.clear;
//xfgmemo.Lines.loadfromFile('/tmp/redstone.org001.ps');
pageto('xfgMainButton','pagetopdf'); 

Afreeform;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
   except
    on E: Exception do
    begin
  //  //screen.cursor:=crhourglass;
screen.cursor:=crDefault;
      MessageDlg ('Error in Component: ' +

         E.Message, mtInformation, [mbOK], 0);
  Afreeform;
    end;
  end;
/////////////////////////////////////////
// SaveDialog1.InitialDir := '~';
// form2.filelist.refresh;

 
//SaveDialog1.FileName := SaveDialog1.FileName+SaveDialog1.defaultext ;
   
 SaveDialog1.InitialDir := form2.xfgcurrentdir; 
 ss:=trim(pc.activepage.caption);
 if AnsiPos('.',extractfilename(ss)) =1 then
delete(ss,length(extractfilepath(ss))+1,1);
delete(ss,AnsiPos(K.CRS_ExtractFileExt(ss),ss),length(K.CRS_ExtractFileExt(ss)));
SaveDialog1.FileName :=ss+'.pdf';;


SaveDialog1.filterindex:=2;
if SaveDialog1.Execute then
  begin 

 // if (ansilowercase(extractfileext(SaveDialog1.FileName))='.ps') or
 //  (ansilowercase(extractfileext(SaveDialog1.FileName))='.pdf') then
 //  dosave(copy(extractfileext(SaveDialog1.FileName),2,length(extractfileext(SaveDialog1.FileName))-1));
//dosave('pdf');
//ss:='cp '+datadir+'/redstone.org001.pdf'+' '+SaveDialog1.FileName;
//Libc.system(pchar(ss));

k.crs_copyfile(datadir+'/redstone.org001.pdf',SaveDialog1.FileName,true,true,false);
//pc.activepage.caption:='  '+SaveDialog1.FileName+'  ';
showfilelist(SaveDialog1.FileName);

 end;
 
 
 //SaveDialog1.filterindex:=4;
 
 //   StatusBar1.Panels[0].Text := FileName; 
//dosave('ps');
///////////////////////////////////////
 or2:=false;

//

end;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Button5Click(Sender: TObject);
var TEMPSTRLST:tstringlist;APASSMemo:tmemo;
 begin
 if form2.xfgcurrentdir=form1.DATADIR+'/.thrash bin/' then begin  
 MessageDlg ('Can''t work on trash bin directory '  +#13#10+
        'Please choose another destination directory ', mtInformation, [mbOK], 0);exit;end;
APASSMemo:=xfgmemo;
if (APASSMemo as tmemo).lines.Count=0 then begin
  MessageDlg ('ERROR loading files ' + #13#10+
        'Nothing to be done', mtInformation, [mbOK], 0);exit;end;
 
if CheckError((APASSMemo as tmemo).lines)=true then exit;
if checkbox1.checked=true then or2:=true;
if checkbox1.checked=false then or2:=false;
try
screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
 form2.show;
Acreateform;
//TEMPSTRLST:tstringlist;
TEMPSTRLST:=nil;
TEMPSTRLST:=tstringlist.create;
TEMPSTRLST.clear;
TEMPSTRLST.assign((APASSMemo as tmemo).lines);
//K.CRS_CheckFileList(TEMPSTRLST);
//if TEMPSTRLST<>nil then TEMPSTRLST.free;
//if af<>nil then afreeform;

filesto('xfgMainButton','pagetopostcript',1,TEMPSTRLST); 
Afreeform;
////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
   except
    on E: Exception do
    begin
  //  //screen.cursor:=crhourglass;
screen.cursor:=crDefault;
      MessageDlg ('Error in Component: ' +
        E.Message, mtInformation, [mbOK], 0);
 Afreeform;
 TEMPSTRLST.free;
    end;
  end;
if TEMPSTRLST<>nil then TEMPSTRLST.free;
if af<>nil then afreeform;
if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
//pc.activepage.caption:='  '+(Sender as tbutton).caption+'  ';
end;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Button6Click(Sender: TObject);
var
ID,ID2: Integer; IGNOREALL:boolean; APASSMemo:tmemo;
StrLst,StrLst2: TStringList;TEMPSTRLST:tstringlist;
 I: Integer;
 execps2,execps3,execps,execpdf3,execpdf2,execpdf,instr,instrPath,path: string;
mime:string;OK:boolean;
begin
APASSMemo:=xfgmemo;
if form2.xfgcurrentdir=form1.DATADIR+'/.thrash bin/' then begin  
 MessageDlg ('Can''t work on trash bin directory '  +#13#10+
        'Please choose another destination directory ', mtInformation, [mbOK], 0);exit;end;

OK:=false ;
IGNOREALL:=false ;  
if (APASSMemo as tmemo).lines.Count=0 then begin
  MessageDlg ('ERROR loading files '  +#13#10+
        'Nothing to be done', mtInformation, [mbOK], 0);exit;end;
  
application.processmessages;
if CheckError((APASSMemo as tmemo).lines)=true then exit;
if checkbox1.checked=true then or2:=true else or2:=false;
  try
screen.cursor:=crhourglass;
//screen.cursor:=crDefault;
  if or2=true then begin
 form2.show;
Acreateform;
 
//TEMPSTRLST:tstringlist;
TEMPSTRLST:=tstringlist.create;
TEMPSTRLST.assign((APASSMemo as tmemo).lines);
//K.CRS_CheckFileList(TEMPSTRLST);
//if TEMPSTRLST<>nil then TEMPSTRLST.free;
//if af<>nil then afreeform;

mime:= IniFile.Readstring ('xfgMIME', 'pagetopdf', 'none');
execps:= IniFile.Readstring ('xfgMainButton', 'pagetopostcript', 'none');
execpdf:= IniFile.Readstring ('xfgMainButton', 'pagetopdf', 'none');
StrLst := TStringList.Create;
StrLst2:= TStringList.Create;

//StrLst.assign(xfgmemo.Lines); 

//outstr: TStringList;  
for i:=0 to TEMPSTRLST.count-1 do
StrLst.add(TEMPSTRLST[i]);
K.CRS_CheckFileList(StrLst);

CheckForm2Refresh;
instrPath:=form2.xfgcurrentdir;
path:=extractfilepath(StrLst.strings[0]);
   for I := 0 to StrLst.Count - 1 do 
    begin

application.processmessages;
if EXIT_File_Operation=true then break;

    execps2:='';
    execpdf2:='';
   execps2:=StringReplace(execps,'%in','"'+StrLst.Strings[i]+'"',[rfIgnoreCase]);
  execps3:=StringReplace(execps2,'%out','"'+datadir+'/redstone.org002.ps'+'"',[rfIgnoreCase]);
  
    instr:=copy(StrLst.strings[i],length(path)+1,(length(StrLst.strings[i])-length(path))-
length(k.CRS_ExtractFileExt(StrLst.strings[i])));
   execpdf2:=StringReplace(execpdf,'%in','"'+datadir+'/redstone.org002.ps'+'"',[rfIgnoreCase]);
  execpdf3:=StringReplace(execpdf2,'%out','"'+instrPath+instr+'.'+mime+'"',[rfIgnoreCase]); 
 if OK<>true then 

 
 // ID,ID2: Integer; IGNOREALL:boolean; 
//IGNOREALL:=false ;
if IGNOREALL=false then      
 if fileexists(instrPath+instr+'.'+mime) then begin
 
   //afreeform;
  //  af.sendtoback;
// if af<>nil then   af.top:=600-af.height;
screen.cursor:=crDefault;
ID:= showmessageFILEOperation(1,instrPath+instr+'.'+mime);
  if ID=mrNO then continue;

if ID=mrIGNORE then 
 begin 
  ID2:=showmessageFILEOperation(2,'');
  if ID2=mrOK then IGNOREALL:=true;
  if ID2=mrNo  then continue;
  if ID2=mrAbort then break;
  
 end;
// if af<>nil then af.top:=round((600-af.height)div 2);
 //af.bringtofront;
  end;

 
    //******************************* 
  if af<> nil then AL2.caption:='     '+extractfilename(StrLst.Strings[i]);
 //*******************************
try 
screen.cursor:=crhourglass;
Libc.system(pchar(execps3));
Libc.system(pchar(execpdf3));
StrLst2.add(instrPath+instr+'.'+mime);
except
screen.cursor:=crDefault;
continue;
end;

//
//Libc.system(pchar(execpdf+StrLst.Strings[i]+'.'+mime+' /tmp/redstone.org002.ps'));
         
if checkbox3.checked=false then
begin
   printHEADER(' Converting files to PDF ----------> '+instrPath+instr+'.'+mime+'.'+mime);
end;  

end;


//showfilelist2(StrLst2);


end;

////screen.cursor:=crhourglass;
screen.cursor:=crDefault;
   except
    on E: Exception do
    begin
  //  //screen.cursor:=crhourglass;
screen.cursor:=crDefault;
      MessageDlg ('Error in Component: ' +
        E.Message, mtInformation, [mbOK], 0);
 Afreeform;
    end;
  end;

if checkbox3.checked=false then or2:=false;
Afreeform;
showfilelist2(StrLst2);
  if (AnsiPos('@',pc.activepage.caption)<1) or (ThreadIOKill=true) then
//pc.activepage.caption:='  '+(Sender as tbutton).caption+'  ';
StrLst.Free;
StrLst2.Free;
TEMPSTRLST.free;

end;
//////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.Button10Click(Sender: TObject);
var APASSMemo:tmemo;
begin
APASSMemo:=xfgmemo;
(APASSMemo as tmemo).lines.clear;
PC.activepage.caption:='  NewPage  ';
or2:=false;
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////


procedure TForm1.Exit1Click(Sender: TObject);
begin
close;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin

button1.click;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
// save as
button2.click;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var APASSMemo:tmemo;
begin
// save

APASSMemo:=xfgmemo;
if fileexists(trim(PC.activepage.caption))then
(APASSMemo as tmemo).lines.savetofile(trim(PC.activepage.caption))
else
button2.click;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
var APASSMemo:tmemo;i:integer;
begin
APASSMemo:=xfgmemo;

if fontdialog1.execute then
begin
(APASSMemo as tmemo).font:=fontdialog1.font;
for i:=paneltop.controlcount-1 downto 0 do
begin
if paneltop.controls[i]is tcombobox then
begin
if trim(ansilowercase(paneltop.controls[i].name))='comboboxfonts' then 
(paneltop.controls[i] as tcombobox).text:=(APASSMemo as tmemo).font.name;
if trim(ansilowercase(paneltop.controls[i].name))='comboboxpoints' then 
(paneltop.controls[i] as tcombobox).text:=inttostr((APASSMemo as tmemo).font.size);
end;
end;
end;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
Button10.Click;
end;

procedure TForm1.chkbox1OnClick(Sender: TObject);

begin
if checkbox1.checked=true then
begin
AChkBox1:=true ;


form2.filemodeSP.Glyph.FreePixmap;
form2.filemodeSP.Glyph.LoadFromFile(form1.xfgimagedir+'/folder_blue_open.png');
form2.filemodeSP.hint:='File list mode enabled';

form3.spp.Glyph.FreePixmap;
form3.spp.Glyph.LoadFromFile(form1.xfgimagedir+'/folder_blue_open.png');
form3.spp.hint:='File list mode enabled';

end else 
if checkbox1.checked=false then
begin
AChkBox1:=false;
form2.filemodeSP.Glyph.FreePixmap;
form2.filemodeSP.Glyph.LoadFromFile(form1.xfgimagedir+'/folder_blue.png');
form2.filemodeSP.hint:='Editor mode enabled';
form3.spp.Glyph.FreePixmap;
form3.spp.Glyph.LoadFromFile(form1.xfgimagedir+'/folder_blue.png');
form3.spp.hint:='Editor mode enabled';
end;
end;

Function TForm1.CheckError(APASSStrings:TStrings):Boolean;
var
HASFILE:BOOLEAN;
i:integer;
begin
if form2.Dor2=1 then begin result:=false;exit;end;
result:=false;

if (checkbox1.checked=false) or (APASSStrings.Count=0)then 
begin
if checkbox3.checked=false then 
begin
xfgmemo.Lines.Add( ' ');
xfgmemo.Lines.Add( ' ');
xfgmemo.Lines.Add( '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ');
xfgmemo.Lines.Add('ERROR loading files : unknown is not a file ');
xfgmemo.Lines.Add( 'Please use "Select files ..." to select multiple files ');
xfgmemo.Lines.Add( '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! ');
end;
MessageDlg ('ERROR loading files : ' +
'Wrong filename found . Are you sure this is a file list or an updated file list?', mtInformation, [mbOK], 0);
result:=true;
exit;
end;

 HASFILE:=false;
    for I := 0 to APASSStrings.Count - 1 do 
    begin
if (trim(APASSStrings.Strings[i]))='' then continue;
 if  (

AnsiPos('/',APASSStrings.Strings[i])=0)then 
 if not fileexists(getcurrentdir+trim(APASSStrings.Strings[i])) then continue;
 if not fileexists(trim(APASSStrings.Strings[i])) then continue;  
 if fileexists(trim(APASSStrings.Strings[i]))then HASFILE:=true;
 result:=false;
 break;
 exit;
 end;
 
 if HASFILE=false then
 begin
     MessageDlg ('ERROR loading files : ' +
        'Wrong filename found . Are you sure this is a file list or an updated file list?', mtInformation, [mbOK], 0);
       // findclose(sr);
     result:=true;
 end;
     
end;

//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

procedure TForm1.printDEBUG(PASSMemo:tmemo;PASSLst:TStrings);
begin
if PASSLst.count=1 then PASSMemo.lines.Add(' No stringlist pass to vcl') else
PASSMemo.lines.Add('l1.count = '+inttostr(PASSLst.count));
  PASSMemo.lines.Add(' 1 RedStone_SysPath = '+k.RS_SysPath );
  PASSMemo.lines.Add(' 2 CRS_MainPath = '+k.RS_getrecvalue(extractfilename(application.exename),'main_path') );
  PASSMemo.lines.Add(' 3 CRS_RecPath = '+k.RS_AppConfigPath );
  PASSMemo.lines.Add(' 4 CRS_CompRecName = '+k.RS_CompRecName );
  PASSMemo.lines.Add(' 5 application.exename = '+application.exename );
  PASSMemo.lines.Add('5.1 filegardenUserCallingDIR = '+filegardenUserCallingDIR );
  PASSMemo.lines.Add(' 6 extractfilename(AExeName) = '+extractfilename(application.exename) );
  
end;

//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
function tForm1.showmessageFILEOperation(MSGType:integer;PASSFilename:string):integer;

begin

if MSGType=1 then
result:= MessageDlg ('    '+PASSFilename+' already exists'+#13#10+
                 '    Continue with destructive file operation ?'+#13#10+#13#10+
               '    note : From the file manager , you can double click on another'+#13#10+
               '             directory which does not contain the same filename to '+#13#10+
               '             perform a non-destructive file operation', mtConfirmation, [mbYes,mbNo,mbIGNORE], 0, mbYes);


if MSGType=2 then

result:=MessageDlg ('This will overwrite all existing file '+#13#10+
                    'without your confirmation ? '
                  , mtConfirmation, [mbOK,mbNo,mbAbort], 0, mbYes);


end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TForm1.printHEADER(HEADERSTRING:String);
begin
xfgmemo.Lines.Add( ' ');
xfgmemo.Lines.Add( ' ');
xfgmemo.Lines.Add( ' ');
xfgmemo.Lines.Add( '['+DateToStr(Date)+']'+' ['+ TimeToStr(Time)+']'+
           HEADERSTRING);
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
 procedure  TForm1.FileCopyMove(Mode:integer;drawthumbnailMode:integer;APASSLst:TStrings);
 var outlst,SORTlst,TEMPLST:tstringlist;i:integer;
 lst,showlst:tstringlist;str,TEMPstr:string;
 OK:boolean;
 ID,ID2: Integer; IGNOREALL:boolean; 
 begin
  { CRS_FileCopyMove(Mode:integer;APASSLst:TStrings;Destination:STRING)  }
  { drawthumbnailMode = 1 0r 2 :  1:= drawthumbnail  2:= do not drawthumbnail }
  { mode  = 1 Or 2 Or 3 :    1:= copy  2:= move  3:=symlink }
if not directoryexists(form2.xfgcurrentdir) then SystemBusy:=false;
if SystemBusy=true
then 
begin
MessageDlg ('System busy ... , so abort.'  +#13#10, mtInformation, [mbOK], 0);
exit;
end;

 

if form2.xfgcurrentdir=form1.DATADIR+'/.thrash bin/' then begin  
 MessageDlg ('Can''t work on trash bin directory '  +#13#10+
        'Please choose another destination directory ', mtInformation, [mbOK], 0);exit;end;



 

if mode=3 then // symlinks
begin
OK:=false ;
IGNOREALL:=false ;
showlst:=tstringlist.create;
lst:=tstringlist.create;
lst.text:=APASSLst.text;
k.crs_checkfilelist(lst);


ID:=  MessageDlg ('Do you really want to create symbolic links of files : '+#13#10+#13#10+
                  lst.text+#13#10+
                  ' to '+form2.xfgcurrentdir, mtConfirmation, [mbYes,mbNo], 0, mbYes);
if ID=mrNo then begin lst.free;showlst.free;exit;end;   
if ID=mrYes then
begin
SystemBusy:=true;
 Acreateform;
 try
for i:=0 to lst.count-1 do
begin
application.processmessages;
//if extractfilepath(trim(lst[i]))=form2.filelist.directory.location then continue;
if EXIT_File_Operation=true then break;
str:=trim(lst[i]);
 if LastDelimiter('/',str)=length(str) then 
    delete(str,length(str),1);
    
 str:= RightStr(str,length(str)-LastDelimiter('/', str ));
TEMPstr:=form2.xfgcurrentdir+str;
 if OK<>true then 

if IGNOREALL=false then     
if  (access(pchar(TEMPstr), R_OK)=0)
and (k.CRS_CheckIsLink(TEMPstr)) then begin
// if (fileexists(form2.filelist.directory.location+str))or
 //(directoryexists(form2.filelist.directory.location+str)) then begin

ID:=showmessageFILEOperation(1,form2.xfgcurrentdir+str);
  if ID=mrNO then continue;
if ID=mrYes then begin  K.crs_deletefile(form2.xfgcurrentdir+str);end;
if ID=mrIGNORE then 
 begin 
  ID2:=showmessageFILEOperation(2,'');
  if ID2=mrOK then IGNOREALL:=true;
  if ID2=mrNo  then continue;
  if ID2=mrAbort then break;

  end;

end;
if IGNOREALL=true then  
begin
if (fileexists(form2.xfgcurrentdir+str))
and (k.CRS_CheckIsLink(form2.xfgcurrentdir+str)) then 
   k.crs_deletefile(form2.xfgcurrentdir+str);
if   (directoryexists(form2.xfgcurrentdir+str)) 
and (k.CRS_CheckIsLink(form2.xfgcurrentdir+str))
then    K.crs_rmdir(form2.xfgcurrentdir+str);
end;
 //******************************* 
  if af<> nil then AL2.caption:='     '+lst[i];
 //******************************* 

k.crs_copyfile(lst[i],form2.xfgcurrentdir+str,true,true,true);
showlst.add(str);
end;
finally
SystemBusy:=false;
afreeform;
end;
end;
if showlst.count<>0 then
showfilelist2(showlst);
lst.free;
showlst.free;

exit;
end;




SystemBusy:=true;

SORTlst:=tstringlist.create;
outlst:=tstringlist.create; 
TEMPLST:=tstringlist.create; 
try
if drawthumbnailMode=2 then
begin
for i:=0 to APASSLst.count-1 do
begin
if APASSLst[i]=form2.xfgcurrentdir then continue;
SORTlst.add(APASSLst[i]);
end;
K.CRS_CheckFileList(SORTlst); 
end;

if drawthumbnailMode=1 then
begin
SORTlst.assign(APASSLst);
end;




K.X_CRS_FileCopyMoveR(Mode,SORTlst,form2.xfgcurrentdir,outlst);

if outlst.count<>0 then
begin

if drawthumbnailMode=1 then
begin
if SORTlst.count>-1 then
if ThumbnailCurrentPath=extractfilepath(SORTlst[0])then 
RUN_drawThumbnail_TASK(ThumbnailCurrentPath);

end;
end;
finally
if outlst.count<>0 then
begin
TEMPLST.assign(outlst);
form1.showfilelist2(TEMPLST);
if form2.xfgcurrentdir=InfoListViewCurrentDir then 
form2.filelist.refresh
else
form2.DoListViewFileInfo(InfoListViewCurrentDir );
//form1.CheckForm2Refresh;

end;
SORTlst.free;
outlst.free;
TEMPLST.free;
SystemBusy:=false;
end;
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure  TForm1.FileDelete(drawthumbnailMode:integer;APASSLst:TStrings);
var i,mrKind:integer;
begin

if SystemBusy=true
then 
begin
MessageDlg ('System busy ... , so abort.'  +#13#10, mtInformation, [mbOK], 0);
exit;
end;


SystemBusy:=true;


try
 {drawthumbnailMode = 1 0r 2 :  1:= drawthumbnail  2:= do not drawthumbnail }
// if form2.filelist.directory.location<>form1.DATADIR+'/.thrash bin/'then
if CheckBox4.checked=true then
 K.X_CRS_FileDeleteR(APASSLst,form1.DATADIR+'/.thrash bin/')else
 begin
MRKInd:= MessageDlg ('Are you sure you want to delete ' +#13#10+#13#10+
    APASSLst.text, mtConfirmation, [mbYes,mbNo], 0, mbYes);
if MRKInd    <>mrNo then
begin
     
 for i:=0 to APASSLst.count-1 do
 begin
 application.processmessages;
 K.CRS_FileDeleteR(APASSLst[i]);
 
 end;
 
 if drawthumbnailMode=1 then
begin
if ThumbnailCurrentPath=form2.xfgcurrentdir then 
RUN_drawThumbnail_TASK(form2.xfgcurrentdir);
end;

if drawthumbnailMode<>1 then
begin
CheckForm2Refresh;
end;
end;
 end;
// if form2.filelist.directory.location=form1.DATADIR+'/.thrash bin/'then
// K.CRS_FileDelete(APASSLst,'');
 


finally
SystemBusy:=false;
end;
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

  procedure TForm1.RUN_drawThumbnail_TASK(APASSLOCATION:string);
 
  begin
  (**************************************************
   APASS_SAVED_directory_filemask:='';
 APASS_SAVED_directory_filemask:=form2.filelist.directory.filemask;

 if form2.filelist.directory.filemask <> ansilowercase(APASS_IMAGE_filemask) then
 begin
 
form2.filelist.directory.filemask:=ansilowercase(APASS_IMAGE_filemask);
end;
******************************************)
(*************************************************************************)
if MT_IMAGE_GET_INFO_TASK_RUNNING=true then
MT10.terminate;

MT_IMAGE_GET_INFO_TASK_RUNNING:=false; 
(**************************************************************************)
if MT_DRAW_Thumbnail_TASK_RUNNING=true then 
MT20.terminate;
MT_DRAW_Thumbnail_TASK_RUNNING:=false;

(****************************************************************************)

MT20 := TRunMultiTask2.Create(APASSLOCATION) ;
//MT20.policy:=SCHED_OTHER;
//MT20.priority:=0;
MT20.onterminate:=checkout2;
MT_DRAW_Thumbnail_TASK_RUNNING:=true;

// MT200.Resume;
(****************************************************************************)

 
 

end;
/////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm1.checkout1(Sender: TObject);
begin
if MT_IMAGE_GET_INFO_TASK_RUNNING=true then
MT10.terminate;
//MT10.free;
MT_IMAGE_GET_INFO_TASK_RUNNING:=false; 

end;  
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
procedure TForm1.checkout2(Sender: TObject);
begin

if MT_DRAW_Thumbnail_TASK_RUNNING=true then 
MT20.terminate;
MT_DRAW_Thumbnail_TASK_RUNNING:=false;
(*************************************************************************
 if ansilowercase(APASS_SAVED_directory_filemask) <> ansilowercase(APASS_IMAGE_filemask) then
 begin
 form2.filelist.directory.filemask:=ansilowercase(APASS_SAVED_directory_filemask);
 end;
 ********************************************************************)
 
spViewthumbnail.enabled:=true;;


if MT_IMAGE_GET_INFO_TASK_RUNNING=true then
MT10.terminate;
MT_IMAGE_GET_INFO_TASK_RUNNING:=false; 



MT10 := TRunMultiTask1.Create ;
//MT10.policy:=SCHED_OTHER;
//MT10.priority:=0;
MT10.onterminate:=checkout1;
MT_IMAGE_GET_INFO_TASK_RUNNING:=true;
// MT20.Resume;

(**************************************************************************)
end;  

end.
