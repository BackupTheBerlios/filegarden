unit PClass_Command_RedStone;

interface

uses

  SysUtils,Types,Classes, Qt, Variants, QTypes, QControls, QForms,QButtons,QMenus,StrUtils,
  QDialogs, QStdCtrls,inifiles,XLIB, QFileCtrls,libc, DateUtils, QGraphics, QExtCtrls,QComCtrls
  ,PPClass_RedStone//, RS_IO
  ;
type

TFILERecord=record
 file_type:string;
 link_filename:string;
 group_ID:integer;
 owner_ID:integer;
 owner_name:string;
 owner_group_name:string;
 owner_R:Boolean;
 owner_W:Boolean;
 owner_X:Boolean;
 group_R:Boolean;
 group_W:Boolean;
 group_X:Boolean;
 others_R:Boolean;
 others_W:Boolean;
 others_X:Boolean;
 setUID:Boolean;
 setGID:Boolean;
 setSticky:Boolean;
 file_SIZE:integer;
 change_Time:string;
 modified_Time:string;
 access_Time:string;
 file_mode:integer;

end;
 
  TPClass_Command_RedStone = class(TPPClass_RedStone)
  private
     AF:TForm;
     AL,AL2:TLabel;
     sp:tBITBTN;
     APASS_CALLING_Form:TForm;
     EXIT_File_Operation:boolean;
     //VERBOSE:string;
   procedure AFOnShow(Sender: TObject);
   procedure AFOnClose(Sender: TObject;var Action: TCloseAction);
   procedure fileoperationCANCELclick(Sender: TObject); 
   procedure CRS_ACreateForm(LABELString:string);
   procedure CRS_AFreeForm;
   Procedure SelectDirClick(sender:TObject); 
   Procedure SelectFileClick(sender:TObject);
   Procedure SaveFileClick(sender:TObject);
   procedure OPDOnSelect(Sender: TObject; AFile: PFileInfo; Selected: Boolean);
  protected
    { Protected declarations }
  public
    
    constructor Create(APassCRS_Handle:QApplicationH;APassCRS_Form:TForm;APassCRS_ExeName:String);//override;
    destructor Destroy; override;
   Function CRS_DEBUGAppend(APASSSTRING,APASSFILENAME:STRING):Boolean;
   Function CRS_DEBUG(APASSSTRING,APASSFILENAME:STRING):Boolean;
   Function CRS_Append_DEBUG(APASSSTRING,APASSFILENAME:STRING):Boolean;
(*****************************************************************************************************)
   Function CRS_CheckEXEArgument(APASSINISTR,APASSString,APASSIndent:string):string;
   function CRS_showmessageFILEOperation(MSGType:integer;PASSFilename:string):integer;
  procedure CRS_ShellFilesTO(AMain,AMinor,AJob,APASSDestination:STRING;
                MODE:integer;AList:TStrings);
  procedure CRS_ShellFilesTOSingleFile(AMain,AMinor,AJob,APASSDestination:STRING;MODE:integer;
                  AList:TStrings);
  procedure CRS_ShellFilesTOSingleAPPLICATION(AMain,AMinor,AJob:STRING;MODE:integer;AList:TStrings);
  procedure CRS_ShellFilesTOCAT(AMain,AMinor,AJob,APASSDestination,APASSTempDir:STRING;
                MODE:integer;AList:TStrings;APASSMemoLines:TStrings);
(*****************************************************************************************************)
    function FindWindow(Display: PDisplay; Screen: Integer; Start: TWindow; Name: PChar): TWindow;  
    function CRS_TrimProc(AProc,AStart,AEnd:String):String;
    function CRS_GetProcName(AProc,AStart,AEnd:String):String;
    function CRS_GetSepCount(ATrimProc,ASep:String):integer;
    function CRS_GetProcList(AProc,AStart,AEnd,ASep:String;AList:TStringList):TStringList;
    function CRS_GetParamPos(AProc,AStart,AEnd,ASep,AParam:String):Integer;
    function CRS_GetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer):String;
    function CRS_SetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer;ASetStr:String):String;
    function CRS_GetParamValueList(AProc,AStart,AEnd,ASep:String;APos:Integer;AParamValueSep:String;AList:TStringList):TStringList;
(*****************************************************************************************************)
    function CRS_PrintFileDESC(APASSFILENAME:STRING):String;
    function CRS_PrintFileDETAIL(APASSFILENAME:STRING):String;
    function CRS_GETFileRecord(APASSFILENAME:STRING):TFILERecord;
(*****************************************************************************************************)
   Procedure CRS_SelectFiles(ApassTitle,DefaultDir,DefaultExt,DefaultName:string;APASSList:tstringlist);
    Function CRS_SaveFile(ApassTitle,DefaultDir,DefaultExt,DefaultName:string):string;
    Function CRS_SelectDir(ApassTitle,DefaultSTR:string):String;
    Function CRS_MakeFullPath(APASSDirNAME:STRING):string;
    Function CRS_ExtractFileExt(APASSFILENAME:STRING):String;
    Function CRS_ExtractFileName(APASSFILENAME:STRING):String;
    function CRS_WrapText(APASSTEXT:string;COL:integer):String;
    function CRS_GetGuid:String;
    function CRS_GetHumanReadBlockSizeStr(APASSBlockSize:extended):string;
(*****************************************************************************************************)
    Function CRS_CheckRunMessage(APASSEXE,APASSTitle,APASSDestDir:string):string;
    Function CRS_CheckBuiltinVariables(APASSSTR:string;WithBreakIfSpace:Boolean):string;    
    Function CRS_CheckIsLink(APASSSOURCE:String):Boolean;
   procedure CRS_CheckFileList(APASSList:TStringlist);
   procedure CRS_CheckFileListIndexOfName(APASSList:TStringlist;index:integer);
(*****************************************************************************************************)
   procedure RECURSESearchDir(APASSFolder: string; APASSFileMask: string; APASSLst: TStringlist);
   procedure NoRECURSESearchDir(APASSFolder: string; APASSFileMask: string; APASSLst: TStringlist);
(*****************************************************************************************************)
    function CRS_CopyFile(APASSSOURCEFileNAME,APASSDESTFileNAME:string  ;DupOwner,DupMode,DoSymLink:boolean):boolean;
    function CRS_MkDir(APASSSOURCEFileNAME,APASSDESTFileNAME:string  ):boolean;
    function CRS_RMDir(APASSFileNAME:string  ):boolean;
    function CRS_DeleteFile(APASSFileNAME:string ):boolean;
   Procedure CRS_FileCopyMoveR(Mode:integer;APASSSource:String;Destination:STRING;OUTLST:TStringlist);
   Procedure CRS_FileDeleteR(APASSSource:String);
(*****************************************************************************************************)
    function CRS_GetFileAsText(APASSFileNAME:string):string;
    function CRS_GetFilePInfo(APASSFileNAME:string):pfileinfo;
    function CRS_GetDirFileList(APASSFileNAME:string):String;
   Procedure CRS_GetDirFileListInfo(APASSFileNAME:string;APASSLst:tstringlist);
    function CRS_GetDirFileCount(APASSFileNAME:string):integer;
    function CRS_GetFileSize(APASSFileNAME:string):integer;
    function CRS_GetFileMode(APASSFileNAME:string):mode_t;
    function CRS_GetUserNameEntry:string;
    function CRS_GetGroupNameEntry:string;
    function CRS_GetGroupName(gid:gid_t): String;
    function CRS_GetUserName(uid:uid_t):String;
    function CRS_GetFileUID(APASSFileNAME:string):uid_t;
    function CRS_GetFileGID(APASSFileNAME:string):gid_t;
(*****************************************************************************************************)
   Procedure X_CRS_FileCopyMoveR(Mode:integer;APASSLst:TStrings;Destination:STRING;OUTLST:TStringlist);
   Procedure X_CRS_FileDeleteR(APASSLst:TStrings;Destination:STRING);
   procedure X_CRS_FileDeleteRSingle(APASSSource:String);
(*****************************************************************************************************)
    Function X_CRS_scriptdialog(const APASSsini:TMemIniFile;detachMode:boolean):string;
   Procedure X_CRS_scriptdialog_RunDetach(APASSexecStr:string);
    Function X_CRS_DoVCLMemoPageSearch(const APASSSearchStr:string;APASSMemo:tmemo;APASSCaseSensitive,APASSHighlightMatch,
                           APASSWholeWords,APASSRegularExpr,ForReplaceFunction: Boolean):Boolean;
    Function X_CRS_DoVCLMemoPageReplace(const APASSReplaceStr,APASSSearchStr:string;APASSMemo:tmemo;
                           APASSCaseSensitive,APASSWholeWords,APASSReplaceAll: Boolean):Boolean;
    Function CRS_DoListCustomCommand(APASSSTR,APASSHint,APASSListStr:string):string;  
   procedure CRS_FileNameAppend(APASSLeftRight,APASSAppendStr,APASSCurrentDir:string;APASSLst:tstringlist;
                           APASSINI:TMemIniFile;rstLST:TStringlist); 
    Function CRS_InputQuery(QTitle,QCaption,QDefaultStr:string;QMode:Boolean):string;  
    Function CRS_DialogQuery(QCaption:string):integer;             
 (*****************************************************************************************************)
   
  
   published
   property CRS_AF_DLG: TFORM read AF;
     end;
 

implementation
//uses RS_IO;
////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////// 
constructor TPClass_Command_RedStone.Create(APassCRS_Handle:QApplicationH;APassCRS_Form:TForm;
                                             APassCRS_ExeName:String);//override;
begin

inherited create(APassCRS_Handle,APassCRS_Form,APassCRS_ExeName);
AF:=nil;
APASS_CALLING_Form:=APassCRS_Form;
application.handle:=APassCRS_Handle;
EXIT_File_Operation:=false;
 TimeSeparator := ':';       
  ShortTimeFormat := 'hh:mm:ss'; 
DateSeparator := '-';
  ShortDateFormat := 'dd/mm/yyyy'; 
end;

destructor  TPClass_Command_RedStone.Destroy;
begin
EXIT_File_Operation:=true;
if af<>nil then crs_afreeform;
inherited destroy;
end;

{
 FindWindow Function

  Derived from an original C source by Brian Paul. Released
  to public domain.

  Kylix Translation: Matthias Thoma


  Input:  dpy   - the X display
          scr   - the X screen number
          start - where to start search, usually root window
          name  - the window name to search for
}

function TPClass_Command_RedStone.FindWindow(Display: PDisplay; Screen: Integer; 
                           Start: TWindow; Name: PChar): TWindow;
type
   AChildren = array[0..0] of Window;
   PChildren = ^AChildren;

var
 // stat: TStatus;
//  n: Integer;
//  num: Cardinal;
//  w: Window;
//  root: Window;
//  parent: Window;
//  Children: PChildren;
  Title: PChar;


begin
   if (XFetchName(Display, Start, @Title) = 1) then
   begin
      if (strcmp(Name, Title )=0) then
      begin
         XFree(Title);
         Result := Start;
         Exit;
      end;
      XFree(Title);
   end;
{
   stat := XQueryTree(Display, start, @root, @parent, @children, @num);

   if (stat = 1) then
   begin
     //  search each child window for a match: 
      for n := num-1 downto 0 do
      begin
         if (XFetchName(Display, start, @title )=1) then
         begin
            if (strcmp(name, title)=0) then
            begin
             // found it
               XFree(Title);
               Result := Start;
               Exit;
            end;
            XFree(Title);
         end;
      end;

     // search the descendents of each child for a match:

      for n := num-1 downto 0 do
      begin
         w := FindWindow(Display, Screen, Children^[n], Name);
         if (w <> 0) then
         begin
            XFree(Children);
            Result := w;
            Exit;
         end;
      end;

      if (children <> Nil) then
      begin
         XFree(Children);
      end;
   end;
}
   Result := 0;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_MakeFullPath(APASSDirNAME:STRING):string;
begin
result:=APASSDirNAME;
if directoryexists(trim(APASSDirNAME))then
begin
if not (AnsiEndsStr('/',APASSDirNAME)) then result:=APASSDirNAME+'/';
end;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetFileAsText(APASSFileNAME:string):string;
var lst:tstringlist;
begin
result:='';
lst:=tstringlist.create;
if fileexists(APASSFileNAME) then
begin
lst.loadfromfile(APASSFileNAME);
result:=lst.text;
end;
lst.free;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_FileNameAppend(APASSLeftRight,APASSAppendStr,APASSCurrentDir:string;
APASSLst:tstringlist;APASSINI:TMemIniFile;rstLST:TStringlist); 
var  outlst,l1:tstringlist;captionSTR,DIRstr,instr,instr1,Qstr,QstrTemp,tempstr:string;i,ii,Nth,CLONEint:integer;
LEFT,RIGHT,QuerryTRUE:Boolean;
begin
QuerryTRUE:=false;
LEFT:=false;
RIGHT:=false;
outlst:=tstringlist.create;
l1:=tstringlist.create;
(****************************************************************************)
if AnsiPos('%filenameappendclone',trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
APASSAppendStr, 'none'))))>0 then
begin
Qstr:='';  
if InputQuery('Cloning files ...','Number of copies of clones ...'+#13#10,Qstr)=true then
begin
QuerryTRUE:=true;
try
if (strtoint(Qstr)<1) or (StrToIntDef(Qstr, -1000)=-1000)then begin
MessageDlg ('Only accept digit number more then 0,please try again later'+#13#10
                 , mtConfirmation, [mbOK], 0, mbOK);
outlst.free;
l1.free;
exit;
end else
begin
Nth:=1;

for ii:=0 to APASSLst.count-1 do
begin
if (directoryexists(APASSLst[ii]))then continue;
captionSTR:=extractfilename(APASSLst[ii]);
if (AnsiPos('.',captionSTR)=0)then DIRstr:=APASSCurrentDir+'/'+captionSTR+'-CLONE' else
if (AnsiPos('.',captionSTR)<>0)then 
DIRstr:=APASSCurrentDir+'/'+stringreplace(captionSTR,CRS_extractfileext(captionSTR),'',[]);
if not directoryexists(DIRstr)then
mkdir(DIRstr);
repeat 
if StrToIntDef(AnsiLeftStr(captionSTR,1), -1000)>-1 then
system.delete(captionSTR,1,1);
until StrToIntDef(AnsiLeftStr(captionSTR,1), -1000)=-1000;

CLONEint:=strtoint(trim(Qstr));
QstrTemp:='';

if length(trim(Qstr))=1 then QstrTemp:='00'else
for i:=1 to length(trim(Qstr)) do
QstrTemp:=QstrTemp+'0';
instr1:=QstrTemp;
for i:=1 to CLONEint do
begin
system.delete(QstrTemp,(length(QstrTemp)-length(inttostr(i)))+1,length(QstrTemp));
instr:=DIRstr+'/'+QstrTemp+inttostr(i)+captionSTR;
CRS_CopyFile(APASSLst[ii],instr,false,false,false);
//Inc(Nth);
QstrTemp:=instr1;
end;

rstLST.add(DIRstr);
end;//for ii:=0 to APASSLst.count-1 do

//CRS_DEBUG(APASSLst.text,'/vvvvvvvvvvvvvv');
outlst.free;
l1.free;
exit;
end;
except
MessageDlg ('Error in cloning'+#13#10
                 , mtConfirmation, [mbOK], 0, mbOK);
outlst.free;
l1.free;
exit;
end;
end else
begin
outlst.free;
l1.free;
exit;
end;
end;
(****************************************************************************)
if AnsiPos('%filenameappendnumberlist',trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
APASSAppendStr, 'none'))))>0 then
begin

Qstr:='000';  
(*********************)
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
APASSAppendStr, 'none'))))='%filenameappendnumberlistleft%' then  
begin
LEFT:=true;
if InputQuery('Leftside numbering zeros ...','Please enter only multiple zeros'+#13#10+
'  eg. 000  equals to  001xxxx.txt 002xxxx.txt 003xxxx.txt ...  '+#13#10,Qstr)=true then
begin
QuerryTRUE:=true;
try
if (strtoint(Qstr)>0) or (StrToIntDef(Qstr, -1000)=-1000)then begin 
outlst.free;
l1.free;
exit;
end;
except
MessageDlg ('Only accept multiple of zeros ,please try again later'+#13#10
                 , mtConfirmation, [mbOK], 0, mbOK);
outlst.free;
l1.free;
exit;
end;
end else
begin
outlst.free;
l1.free;
exit;
end;
end;
(*********************)
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
APASSAppendStr, 'none'))))='%filenameappendnumberlistright%' then  
begin
RIGHT:=true;
if InputQuery('Rightside numbering zeros ...','Please enter only multiple zeros'+#13#10+
'  eg. 000  equals to  xxxx001.txt xxxx002.txt xxxx003.txt ...  '+#13#10,Qstr)=true then
begin
try
if (strtoint(Qstr)>0) or (StrToIntDef(Qstr, -1000)=-1000)then begin 
outlst.free;
l1.free;
exit;
end;
except
MessageDlg ('Only accept multiple of zeros ,please try again later'+#13#10
                 , mtConfirmation, [mbOK], 0, mbOK);
outlst.free;
l1.free;
exit;
end;
end else
begin
outlst.free;
l1.free;
exit;
end;
end;
(*********************)
if QuerryTRUE=true then
if MessageDlg ('Files found with same filename will be replaced  ...'+#13#10
                 , mtConfirmation, [mbOK,mbCancel], 0, mbOK)<>mrOK then
begin
outlst.free;
l1.free;
exit;
end;

Nth:=1;
for ii:=0 to APASSLst.count-1 do
begin
DIRstr:=extractfilepath(APASSLst[ii]);
captionSTR:=extractfilename(APASSLst[ii]);
QstrTemp:=Qstr;
system.delete(QstrTemp,(length(QstrTemp)-length(inttostr(Nth)))+1,length(QstrTemp));

if LEFT=true then
begin
repeat 
if StrToIntDef(AnsiLeftStr(captionSTR,1), -1000)>-1 then
system.delete(captionSTR,1,1);
until StrToIntDef(AnsiLeftStr(captionSTR,1), -1000)=-1000;
instr:=APASSCurrentDir+'/'+QstrTemp+inttostr(Nth)+captionSTR;
end;

if RIGHT=true then
begin
instr1:=CRS_extractfileext(captionSTR);
instr:=captionSTR;
system.delete(instr,AnsiPos(instr1,instr),length(instr1));
 
repeat
if StrToIntDef(AnsiRightStr(instr,1),-1000)>-1 then
system.delete(instr,length(instr),1);
until StrToIntDef(AnsiRightStr(instr,1),-1000)=-1000;

instr:=APASSCurrentDir+'/'+instr+QstrTemp+inttostr(Nth)+instr1;
end;
if DIRstr=APASSCurrentDir+'/' then
RenameFile(APASSLst[ii],instr)else
CRS_CopyFile(APASSLst[ii],instr,false,false,false);
rstLST.add(instr);
if Nth = APASSLst.count then break;
Inc(Nth);
end;//for ii:=0 to APASSLst.count-1 do

outlst.free;
l1.free;
exit;
end;//if AnsiPos('%filenameappendnumberlist',trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,

(****************************************************************************)
APASSINI.ReadSection (APASSLeftRight,l1);
QuerryTRUE:=false;
for ii:=0 to APASSLst.count-1 do
begin
DIRstr:=APASSCurrentDir+'/';
//DIRstr:=extractfilepath(APASSLst[ii]);
captionSTR:=extractfilename(APASSLst[ii]);
(****************************************************************************)
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
APASSAppendStr, 'none'))))='%filenameappendleftwithstrings%' then  
begin
if not QuerryTRUE then
begin
tempstr:=CRS_InputQuery('Append text from the start','Text to be appended from the starting left-side of filenames',
                              '',false);
QuerryTRUE:=true;
end;
instr:=DIRstr+tempstr+captionSTR;
end;
(****************************************************************************)
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
APASSAppendStr, 'none'))))='%filenameappendrightwithstrings%'then 
begin 
if not QuerryTRUE then
begin
tempstr:=CRS_InputQuery('Append text from the end','Text to be appended from the ending right-side of filenames',
                              '',false);
QuerryTRUE:=true;
end;

if AnsiPos('.',captionSTR)=0 then instr:=APASSLst[ii]+tempstr else
begin
if AnsiPos('.',Trim(tempstr))=1 then instr:=APASSLst[ii]+tempstr
else
instr:=DIRstr+StringReplace(captionSTR, CRS_extractfileext(captionSTR), 
tempstr+CRS_extractfileext(captionSTR),[]);
end;

end;
(****************************************************************************)
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
APASSAppendStr, 'none'))))='%filenameappendleft%' then  
begin
instr:=DIRstr+APASSAppendStr+captionSTR;
end;
(****************************************************************************)
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
APASSAppendStr, 'none'))))='%filenameappendright%'then 
begin 
if AnsiPos('.',captionSTR)=0 then instr:=APASSLst[ii]+APASSAppendStr else
begin
if AnsiPos('.',Trim(APASSAppendStr))=1 then instr:=APASSLst[ii]+APASSAppendStr
else
instr:=DIRstr+StringReplace(captionSTR, CRS_extractfileext(captionSTR), 
APASSAppendStr+CRS_extractfileext(captionSTR),[]);
end;
end;
(****************************************************************************)
if AnsiPos('%filenameappenddelete',(trim(AnsiLowercase(APASSINI.Readstring(APASSLeftRight,
APASSAppendStr, 'none')))))<>0
 then  
 begin
(****************************************************************************) 
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
     APASSAppendStr, 'none'))))='%filenameappenddeleteleftnochar%'
then 
begin
if not QuerryTRUE then
begin
tempstr:=CRS_InputQuery('Delete number of charaters from the start',
'Delete number of charaters from the starting left-side of filenames',
                              '',true);
QuerryTRUE:=true;
end;
instr:=captionSTR;
system.delete(instr,1,strtoint(tempstr));
instr:=DIRstr+instr;

end;
(****************************************************************************) 
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
     APASSAppendStr, 'none'))))='%filenameappenddeleterightnochar%'
then 
begin
if not QuerryTRUE then
begin
tempstr:=CRS_InputQuery('Delete number of charaters from the end',
'Delete number of charaters from the ending right-side of filenames',
                              '',true);
QuerryTRUE:=true;
end;
instr1:=CRS_extractfileext(captionSTR);
instr:=captionSTR;
system.delete(instr,AnsiPos(instr1,instr),length(instr1));

system.delete(instr,(length(instr)-strtoint(tempstr))+1,length(instr));

instr:=DIRstr+instr+instr1;

end;
(****************************************************************************) 

if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
     APASSAppendStr, 'none'))))='%filenameappenddeletefileextension%'
then 
begin
instr1:=captionSTR;
instr:=extractfileext(captionSTR);
system.delete(instr1,AnsiPos(instr,instr1),length(instr1));
instr:=DIRstr+instr1;

end;
(****************************************************************************)
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
     APASSAppendStr, 'none'))))='%filenameappenddeleteleft%'
then 
begin
for i:=0 to l1.count-1 do
begin 
if AnsiPos(l1[i],captionSTR)=1 then
begin
instr:=captionSTR;
system.delete(instr,1,length(l1[i]));
instr:=DIRstr+instr;
//break;
end;
end;
end;
(****************************************************************************)
if (trim(AnsiLowercase(APASSINI.Readstring (APASSLeftRight,
 APASSAppendStr, 'none'))))='%filenameappenddeleteright%'
then 
begin

instr1:=CRS_extractfileext(captionSTR);
instr:=captionSTR;

system.delete(instr,AnsiPos(instr1,instr),length(instr1));
for i:=0 to l1.count-1 do 
begin 
if RightStr(instr,length(l1[i]))=l1[i]
then
begin
if AnsiPos('.',Trim(l1[i]))=1 then instr1:='';
system.delete(instr,length(instr)-length(l1[i]),length(l1[i]));
//break;
end;
end;
instr:=DIRstr+instr+instr1;
end;
(****************************************************************************)
end;//if AnsiPos('%filenameappenddelete',(trim(AnsiLowercase(APASSINI.Readstring(APASSLeftRight,
(****************************************************************************************************)
//if DIRstr=APASSCurrentDir+'/' then
if DIRstr=extractfilepath(APASSLst[ii])then
RenameFile(APASSLst[ii],instr)else
CRS_CopyFile(APASSLst[ii],instr,false,false,false);
rstLST.add(instr);
end;

//CRS_DEBUG(rstLST.text,'/xxxxxxxxxxxxxxxxxx');
outlst.free;
l1.free;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_DEBUG(APASSSTRING,APASSFILENAME:STRING):Boolean;
var lst:tstringlist;
begin
lst:=tstringlist.create;
lst.add(APASSSTRING);
lst.savetofile(APASSFILENAME);
result:=true;
lst.free;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_DEBUGAppend(APASSSTRING,APASSFILENAME:STRING):Boolean;
var lst:tstringlist;
begin
lst:=tstringlist.create;
if fileexists(APASSFILENAME)then
lst.loadfromfile(APASSFILENAME);
lst.add(APASSSTRING);
lst.savetofile(APASSFILENAME);
result:=true;
lst.free;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_Append_DEBUG(APASSSTRING,APASSFILENAME:STRING):Boolean;
var lst:tstringlist;
begin
lst:=tstringlist.create;
if fileexists(APASSFILENAME) then
lst.loadfromfile(APASSFILENAME)else
lst.savetofile(APASSFILENAME);
lst.add(APASSSTRING);
lst.savetofile(APASSFILENAME);
result:=true;
lst.free;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.OPDOnSelect(Sender: TObject; AFile: PFileInfo; Selected: Boolean);
var sr :tsearchrec;
begin
if selected then
(Sender as topendialog).filename:=AFile.sr.name;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_ExtractFileExt(APASSFILENAME:STRING):String;
var FSTR:string;
begin

result:='';
if AnsiPos('/',APASSFILENAME)<>0 then
FSTR:=extractfilename(APASSFILENAME)else
FSTR:=APASSFILENAME;

if AnsiPos('.',FSTR)=0 then 
begin
//result:='';
exit;
end;

if AnsiPos('.',FSTR)=1 then
delete(FSTR,1,1);
//s2:=FSTR;
result:=ExtractFileExt(FSTR);
repeat
delete(FSTR,lastdelimiter('.',FSTR),length(FSTR));
result:=ExtractFileExt(FSTR)+result;
until AnsiPos('.',FSTR)=0;


end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_ExtractFileName(APASSFILENAME:STRING):String;
var FSTR:string;
begin

result:=APASSFILENAME;

// LastDelimiter('\',APASSFILENAME); 
 result:= Copy(APASSFILENAME, LastDelimiter('/',APASSFILENAME), length(APASSFILENAME));

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_SaveFile(ApassTitle,DefaultDir,DefaultExt,DefaultName:string):string;
var DefaultSTR,s1:string; OPD:tsavedialog;  
begin
result:='';
OPD:=tsavedialog.create(application);
try
if trim(DefaultExt)<>'' then
OPD.defaultext:=DefaultExt;
OPD.Filter := OPD.defaultext+'|*'+'|All files|*.*';
if directoryexists(DefaultDir)then
OPD.InitialDir:=DefaultDir else
OPD.InitialDir:='~' ;
OPD.title:=ApassTitle;
OPD.filename:=DefaultName;
OPD.options:= [ofShowHidden  , 
 ofViewDetail , ofViewIcon , ofOverwritePrompt,ofExtensionDifferent, ofPathMustExist,
ofViewList ];
with OPD as tsavedialog do
if execute then
begin
if filename =''then filename:='';
result:=filename;
end;
finally
OPD.free;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure TPClass_Command_RedStone.CRS_SelectFiles(ApassTitle,DefaultDir,DefaultExt,DefaultName:string;APASSList:tstringlist);
var DefaultSTR,s1:string; OPD:topendialog;  
begin

OPD:=topendialog.create(application);
try
if trim(DefaultExt)<>'' then
OPD.defaultext:=DefaultExt;
OPD.Filter := OPD.defaultext+'|*'+'|All files|*.*';
if directoryexists(DefaultDir)then
OPD.InitialDir:=DefaultDir else
OPD.InitialDir:='~' ;
OPD.title:=ApassTitle;
//OPD.filename:=DefaultName;
OPD.options:= [ofShowHidden  , 
 ofViewDetail , ofViewIcon , ofOverwritePrompt,ofExtensionDifferent, ofPathMustExist,ofAllowMultiSelect, 
ofViewList ];
with OPD as topendialog do
if execute then
begin
//if Files.count <>0 then filename:=DefaultName;
APASSList.text:=Files.text;
end;
finally
OPD.free;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure TPClass_Command_RedStone.SelectDirClick(sender:TObject);
var s:widestring; OPD:topendialog;  DefaultSTR:string;
begin
if (sender is tedit) then  
begin  
//if directoryexists((sender as tedit).text) then
//DefaultSTR:=trim((sender as tedit).text) else
DefaultSTR:='/';
//if DefaultSTR='' then DefaultSTR:=Getcurrentdir;
if SelectDirectory('Select Directory ...',DefaultSTR,s, true)
then (sender as tedit).text:=s;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure TPClass_Command_RedStone.SelectFileClick(sender:TObject);
var STR:string; OPD:topendialog;  i:integer;
begin

if (sender is tedit) then  
begin  

OPD:=topendialog.create(application);
try
OPD.Filter := 'All files|*.*'; 
OPD.InitialDir:=getcurrentdir;
OPD.title:='Select File ...';
OPD.options:= [ofShowHidden  , ofAllowMultiSelect , 
 ofViewDetail , ofViewIcon , ofPathMustExist,ofFileMustExist,
ofViewList ];

with OPD as topendialog do
if execute then
begin
if OPD.files.count>1 then 
begin
STR:='';
for i:=0 to OPD.files.count-1 do
STR:=STR+'"'+OPD.files[i]+'"'+' ';
(sender as tedit).text:=STR;
end else
(sender as tedit).text:=(filename);
end;
finally
OPD.free;
end;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure TPClass_Command_RedStone.SaveFileClick(sender:TObject);
var DefaultSTR,s1:string; OPD:tsavedialog;  
begin
if (sender is tedit) then  
begin  
DefaultSTR:=trim((sender as tedit).text);
OPD:=tsavedialog.create(application);
try
OPD.defaultext:=CRS_ExtractFileExt(DefaultSTR);
OPD.Filter := OPD.defaultext+'|*'+OPD.defaultext+'|All files|*.*';
OPD.InitialDir:=Getcurrentdir;
OPD.title:='Save File ...';
OPD.filename:=DefaultSTR;
OPD.options:= [ofShowHidden  , 
 ofViewDetail , ofViewIcon , ofOverwritePrompt,ofExtensionDifferent,
ofViewList ];

with OPD as tsavedialog do
if execute then
begin
OPD.defaultext:=CRS_ExtractFileExt(DefaultSTR);
if filename <>''then
begin
if ExtractFileExt(OPD.filename)=OPD.defaultext then
(sender as tedit).text:=(OPD.filename)else
begin
s1:=OPD.filename;
delete(s1,lastdelimiter('.',OPD.filename),length(ExtractFileExt(OPD.filename)));
(sender as tedit).text:=s1+OPD.defaultext;
end;
end;
if filename =''then
(sender as tedit).text:=DefaultSTR;
end;
finally
OPD.free;
end;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_WrapText(APASSTEXT:string;COL:integer):String;
var Awraptext,tempstr:string;
lst,lst1:tstringlist;i:integer;
begin
//function WrapText(const Line, BreakStr: string; nBreakChars: TSysCharSet; MaxCol: Integer):string;overload; 
//function WrapText(const Line, MaxCol: Integer = 45):string; overload;
//WrapText('The rain in Spain falls mainly on the plain.', #13#10, ['.',' ',#9,'-'], 42);
//CRS_WrapText(APASSTEXT:string;COL:integer):String;
// Delete(var S: string; Index, Count:Integer);
//delete(tempstr,AnsiPos(#13#10,tempstr),length(tempstr));
Awraptext:='';
lst:=tstringlist.create;
lst1:=tstringlist.create;
lst.text:=APASSTEXT;
for i:=0 to lst.count-1 do
begin
tempstr:='';
tempstr:=lst[i];
if length(tempstr)>COL then 
begin
tempstr:=WrapText(tempstr, #13#10, ['.',' ',#9,'-'], COL);
end;
lst1.Append(tempstr);
end;
result:=lst1.text;
lst.free;
lst1.free;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_SelectDir(ApassTitle,DefaultSTR:string):String;
var s:widestring;
begin
if trim(DefaultSTR)='' then
DefaultSTR:=getcurrentdir;
result:=DefaultSTR;
if SelectDirectory(ApassTitle,DefaultSTR,s, true)
then result:=s;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_DialogQuery(QCaption:string):integer;
begin
result:=  MessageDlg (QCaption+#13#10, mtConfirmation, [mbYes,mbNo,mbAbort], 0, mbYes);
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_InputQuery(QTitle,QCaption,QDefaultStr:string;QMode:Boolean):string;
var rstr:string;
begin 
rstr:=QDefaultStr;  
if InputQuery(QTitle,QCaption+#13#10,rstr)=true then
begin

if QMode=true then
if (StrToIntDef(rstr, -999999999)=-999999999)then 
begin
MessageDlg ('Only accept digit number,please try again later'+#13#10
                 , mtConfirmation, [mbOK], 0, mbOK);
Result:='';
exit;
end;
if length(rstr)=0 then 
begin
Result:='';
exit;
end;
Result:=rstr;   
end;


end; 
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_DoListCustomCommand(APASSSTR,APASSHint,APASSListStr:string):string; 
var GSTR,RStr,deviceStr,tempstr,Qstr,QstrTemp,Header,Footer,Body,str,scanhead,scanfoot:String;  
lst,templst:tstringlist;
i,max,Nth,CDDev,ii,index,MB,PosH,PosF,PosHStr,PosFStr:integer;templstFull,CanStrip:Boolean;
PosHStrEnd,PosFStrEnd:integer;sini:TMemIniFile;
begin
result:=APASSSTR;
RStr:=''; 
lst:=nil;
lst:=tstringlist.create;
(********************************************************************************************)
if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertFormat%'),AnsiLowercase(APASSSTR))>0
then 
begin
scanhead:='';
scanfoot:='';
Header:='';
Footer:='';
result:=Header+APASSListStr+Footer;
str:=stringreplace(APASSSTR,'%GetCustomCommand%XFGMemoInsertFormat%','',[rfReplaceAll,rfIgnoreCase]);
if not(fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+str))
and not(fileexists(RS_USER_RESOURCE_PATH+'/'+str))
then begin 
MessageDlg ('Can''t find format style file '+RS_SYSTEM_RESOURCE_PATH+'/'+str+#13#10+
              ' or '+RS_USER_RESOURCE_PATH+'/'+str+' , so abort ' +#13#10+#13#10
        , mtinformation, [mbOK], 0);
end else
begin
if fileexists(RS_USER_RESOURCE_PATH+'/'+str)then 
lst.loadfromfile(RS_USER_RESOURCE_PATH+'/'+str)else
if fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+str)then 
lst.loadfromfile(RS_SYSTEM_RESOURCE_PATH+'/'+str);
(**********************************************************************)
if AnsiPos('%PROC%',lst[0])<>0 then
begin
GSTR:=copy(lst[0],AnsiPos('%PROC%',lst[0])+6,length(lst[0]));
if not (fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR))and
not (fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR))
then  begin
MessageDlg ('Can''t load dialog script ... '+#13#10+
                   RS_SYSTEM_RESOURCE_PATH+'/'+GSTR+'or '+#13#10+
                   RS_USER_RESOURCE_PATH+'/'+GSTR+#13#10, 
                   mtInformation, [mbOK], 0);
lst.free;
exit;
end;


tempstr:=CRS_GetGuid;
if fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR) then
CRS_CopyFile(RS_USER_RESOURCE_PATH+'/'+GSTR,RS_APP_data_dir+'/'+tempstr+'ToBeDeleted',false,false,false)else
if fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR) then
CRS_CopyFile(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR,RS_APP_data_dir+'/'+tempstr+'ToBeDeleted',false,false,false);

sini:=nil;
sini:=TMemIniFile.create(RS_APP_data_dir+'/'+tempstr+'ToBeDeleted');
(******
[VALUE]
cmd=%Output type%
*******)
sini.writestring('VALUE','cmd',stringreplace(sini.readstring('VALUE','cmd','none'),
        '%XFGMemoInsertBody%',lst.text,[rfReplaceAll,rfIgnoreCase]));
//CRS_DEBUG(lst.text,'/11111111111');

if ansilowercase(trim(sini.readstring('INIT','FrameType','none')))='dialog'
then QstrTemp:=X_CRS_scriptdialog(sini,false);

if QstrTemp='' then  begin if sini<>nil then sini.free;lst.free;exit;end
else lst.text:=QstrTemp;
//CRS_DEBUG(QstrTemp,'/222222222222222222');
//CRS_DEBUG(lst.text,'/333333333333333333');
sini.free;
end;
(**********************************************************************)
//PosH,PosF,PosHStr,PosFStr:integer;   Header,Footer,Body
PosH:=AnsiPos('%XFGMemoBREAKStart%',lst.text);
PosHStrEnd:=PosH+length('%XFGMemoBREAKStart%')-1;
PosF:=AnsiPos('%XFGMemoBREAKEnd%',lst.text);
PosFStrEnd:=PosF+length('%XFGMemoBREAKEnd%')-1;
Header:=copy(lst.text,1,PosH-1);
Body:=copy(lst.text,PosHStrEnd+1,(PosF-1)-(PosHStrEnd+1));
Footer:=copy(lst.text,PosFStrEnd+1,length(lst.text));
(****************************************************************)
lst.clear;
lst.text:=Body;
for i:=0 to lst.count-1 do
begin
if AnsiPos('%PROC%',lst[i])<>0 then
begin
GSTR:=copy(lst[i],AnsiPos('%PROC%',lst[i])+6,length(lst[i]));
if not (fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR))and
not (fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR))
then  begin
MessageDlg ('Can''t load dialog script ... '+#13#10+
                   RS_SYSTEM_RESOURCE_PATH+'/'+GSTR+'or '+#13#10+
                   RS_USER_RESOURCE_PATH+'/'+GSTR+#13#10, 
                   mtInformation, [mbOK], 0);
lst.free;
exit;
end;


tempstr:=CRS_GetGuid;
if fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR) then
CRS_CopyFile(RS_USER_RESOURCE_PATH+'/'+GSTR,RS_APP_data_dir+'/'+tempstr+'ToBeDeleted',false,false,false)else
if fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR) then
CRS_CopyFile(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR,RS_APP_data_dir+'/'+tempstr+'ToBeDeleted',false,false,false);

sini:=nil;
sini:=TMemIniFile.create(RS_APP_data_dir+'/'+tempstr+'ToBeDeleted');
if ansilowercase(trim(sini.readstring('INIT','FrameType','none')))='dialog'
then QstrTemp:=X_CRS_scriptdialog(sini,false);

if QstrTemp='' then  begin if sini<>nil then sini.free;lst.free;exit;end
else 
begin 
QstrTemp:=stringreplace(QstrTemp,'%XFGMemoInsertNewLine%',#10,[rfReplaceAll,rfIgnoreCase]);
QstrTemp:=stringreplace(QstrTemp,'%XFGFormatScanInsertSpace%',' ',[rfReplaceAll,rfIgnoreCase]);
scanhead:=copy(QstrTemp,1,AnsiPos('%XFGMemoInsertBody%',QstrTemp)-1);
scanfoot:=copy(QstrTemp,AnsiPos('%XFGMemoInsertBody%',QstrTemp)+length('%XFGMemoInsertBody%'),length(QstrTemp));

end;
//CRS_DEBUG(QstrTemp,'/3333TeXFormat003');

sini.free;

end;
end;





(****************************************************************)
if (fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+str+'Scan'))
or (fileexists(RS_USER_RESOURCE_PATH+'/'+str+'Scan'))
then begin
lst.clear;
if fileexists(RS_USER_RESOURCE_PATH+'/'+str+'Scan')then 
lst.loadfromfile(RS_USER_RESOURCE_PATH+'/'+str+'Scan')else
if fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+str+'Scan')then 
lst.loadfromfile(RS_SYSTEM_RESOURCE_PATH+'/'+str+'Scan');
(****************************************************************)
deviceStr:=lst.text;
QSTR:='';
for i:=0 to lst.count-1 do
begin
if AnsiPos('%PROC%',lst[i])<>0 then
begin

GSTR:=copy(lst[i],AnsiPos('%PROC%',lst[i])+6,length(lst[i]));
if not (fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR))and
not (fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR))
then  begin
MessageDlg ('Can''t load dialog script ... '+#13#10+
                   RS_SYSTEM_RESOURCE_PATH+'/'+GSTR+'or '+#13#10+
                   RS_USER_RESOURCE_PATH+'/'+GSTR+#13#10, 
                   mtInformation, [mbOK], 0);
lst.free;
exit;
end;


tempstr:=CRS_GetGuid;
if fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR) then
CRS_CopyFile(RS_USER_RESOURCE_PATH+'/'+GSTR,RS_APP_data_dir+'/'+tempstr+'ToBeDeleted',false,false,false)else
if fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR) then
CRS_CopyFile(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR,RS_APP_data_dir+'/'+tempstr+'ToBeDeleted',false,false,false);

sini:=nil;
sini:=TMemIniFile.create(RS_APP_data_dir+'/'+tempstr+'ToBeDeleted');
(******
[VALUE]
cmd=%Output type%
*******)
sini.writestring('VALUE','cmd',stringreplace(sini.readstring('VALUE','cmd','none'),
       '%XFGMemoInsertBody%',deviceStr,[rfReplaceAll,rfIgnoreCase]));
//CRS_DEBUG(lst.text,'/11111111111');

if ansilowercase(trim(sini.readstring('INIT','FrameType','none')))='dialog'
then QstrTemp:=X_CRS_scriptdialog(sini,false);

if QstrTemp='' then  begin if sini<>nil then sini.free;lst.free;exit;end
else 
begin
QstrTemp:=stringreplace(QstrTemp,'%XFGMemoInsertNewLine%',#10,[rfReplaceAll,rfIgnoreCase]);
QstrTemp:=stringreplace(QstrTemp,'%XFGFormatScanInsertSpace%',' ',[rfReplaceAll,rfIgnoreCase]);
deviceStr:=QstrTemp;
end;
//CRS_DEBUG(QstrTemp,'/222222222222222222');
//CRS_DEBUG(QstrTemp,'/333scan');
sini.free;
end;
end;


lst.text:=deviceStr;

(****************************************************************)
templst:=tstringlist.create;
templst.text:=APASSListStr;

try
if lst.count<>0 then 
begin

APASSListStr:='';
CanStrip:=false;

for i:=0 to templst.count-1 do
begin
Body:=templst[i];

for mb:=0 to lst.count-1 do
begin

str:=lst.names[MB];
if str='' then continue;
deviceStr:=lst.values[str];

if AnsiLowercase(str)='%xfgformatscanaddtohead%'then
scanhead:=scanhead+deviceStr+#10 else
if AnsiLowercase(str)='%xfgformatscanaddtofoot%'then
scanfoot:=scanfoot+deviceStr+#10 else
if AnsiLowercase(str)='%xfgformatscanstripemptylinespace%' then
CanStrip:=true else
if AnsiLowercase(str)='%xfgformatscaninsertright%' then
Body:=Body+deviceStr else
if AnsiLowercase(str)='%xfgformatscaninsertleft%' then
Body:=deviceStr+Body else
if AnsiLowercase(str)='%xfgformatscandoublespace%' then
Body:=Body+#10 else
Body:=stringreplace(Body,str,deviceStr,[rfReplaceAll,rfIgnoreCase]);

end;//for mb:=0 to lst.count-1 do

if CanStrip=true then
APASSListStr:=APASSListStr+Body else
APASSListStr:=APASSListStr+Body+#10;

end;//for i:=0 to templst.count-1 do

end;//if lst.count<>0 then 



finally
templst.free;
end;

end;
if trim(scanhead)<>'' then scanhead:=Trim(scanhead)+#10;
if trim(scanfoot)<>'' then scanfoot:=#10+Trim(scanfoot)+#10;

result:=(Header)+scanhead+trim(APASSListStr)+scanfoot+(Footer);
end;
end;
(*********************************************
if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertHTMLFormat'),AnsiLowercase(APASSSTR))>0then 
begin
result:=
'<!DOCTYPE doctype PUBLIC "-//w3c//dtd html 4.0 transitional//en">'+#13#10+
'<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">'+#13#10+
'<HTML>'+#13#10+
'<HEAD>'+#13#10+
'<TITLE>%XFGMemoHeading%</TITLE>'+#13#10+
'</HEAD>'+#13#10+
'<BODY font size=12 bgcolor="white" text="black" link="#0000FF" vlink="#840084" alink="#0000FF">'+#13#10+
'<PRE>'+#13#10+' '+#13#10+
'<H1>%XFGMemoHeading%</H1>'+#13#10+
'<HR>'+#13#10+
'%XFGMemoBREAKStart%'+#13#10+
//APASSListStr+#13#10+
'%XFGMemoBREAKEnd%'+#13#10+
'<HR>'+#13#10+
'</PRE>'+#13#10+
'</BODY>'+#13#10+
'</HTML>'+#13#10;
end;
////////////////////////////////////////////////////////////////////////////////////////////////
if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertSGMLFormat'),AnsiLowercase(APASSSTR))>0then 
begin
result:=
'<!doctype linuxdoc system>'+#13#10+
'<article>'+#13#10+
'<title>%XFGMemoHeading%'+#13#10+
'<author>David S.Lawyer'+#13#10+  
'<verb>'+#13#10+
'<sect> %XFGMemoHeading%'+#13#10+
'%XFGMemoBREAKStart%'+#13#10+
'%XFGMemoBREAKEnd%'+#13#10+
'</verb>'+#13#10+
'</article>'+#13#10;
end;
////////////////////////////////////////////////////////////////////////////////////////////////
if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertTeXFormat'),AnsiLowercase(APASSSTR))>0then 
begin
end;

**********************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtLine%'),AnsiLowercase(APASSSTR))>0 )
or (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtCursor%'),AnsiLowercase(APASSSTR))>0)
then 
begin
result:=APASSListStr;
if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtLine%GetFile%'),AnsiLowercase(APASSSTR))>0 then 
begin
GSTR:=stringreplace(APASSSTR,'%GetCustomCommand%XFGMemoInsertAtLine%GetFile%','',[rfReplaceAll,rfIgnoreCase]);
if (not(fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR))
and not(fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR)))
then begin 
MessageDlg ('Can''t find format style file '+RS_SYSTEM_RESOURCE_PATH+'/'+GSTR+#10+
              ' or '+RS_USER_RESOURCE_PATH+'/'+GSTR+' , so abort ' +#10+#10
        , mtinformation, [mbOK], 0);
end else
begin
if fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR)then 
lst.loadfromfile(RS_USER_RESOURCE_PATH+'/'+GSTR)else
if fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR)then 
lst.loadfromfile(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR);
result:=(stringreplace(lst.text,'%XFGMemoInsertWithLine%',APASSListStr,
[rfReplaceAll,rfIgnoreCase]));
end;
end else
if (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtLine%GetValue%'),AnsiLowercase(APASSSTR))>0 )
or (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtCursor%GetValue%'),AnsiLowercase(APASSSTR))>0)
or((AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtLine%GetReplaceValue%'),AnsiLowercase(APASSSTR))>0 ))
then 
begin
if  (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtLine%GetValue%'),AnsiLowercase(APASSSTR))>0 )
then GSTR:=stringreplace(APASSSTR,'%GetCustomCommand%XFGMemoInsertAtLine%GetValue%','',[rfReplaceAll,rfIgnoreCase])
else
if (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtCursor%GetValue%'),AnsiLowercase(APASSSTR))>0)
then GSTR:=stringreplace(APASSSTR,'%GetCustomCommand%XFGMemoInsertAtCursor%GetValue%','',[rfReplaceAll,rfIgnoreCase])
else GSTR:=stringreplace(APASSSTR,'%GetCustomCommand%XFGMemoInsertAtLine%GetReplaceValue%','',[rfReplaceAll,rfIgnoreCase]);

if (not(fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR))
and not(fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR)))
then begin 
MessageDlg ('Can''t find format style file '+RS_SYSTEM_RESOURCE_PATH+'/'+GSTR+#10+
              ' or '+RS_USER_RESOURCE_PATH+'/'+GSTR+' , so abort ' +#10+#10
        , mtinformation, [mbOK], 0);
end else
begin
if  (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtLine%GetValue%'),AnsiLowercase(APASSSTR))>0 )
or (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtCursor%GetValue%'),AnsiLowercase(APASSSTR))>0 )
then
begin
if fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR)then 
lst.loadfromfile(RS_USER_RESOURCE_PATH+'/'+GSTR)else
if fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR)then 
lst.loadfromfile(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR);

//if trim(APASSListStr)<>'' then 
RStr:=(stringreplace(lst.values[APASSHint],'%XFGMemoInsertNewLine%',#10,
[rfReplaceAll,rfIgnoreCase]));
RStr:=stringreplace(RStr,'%XFGMemoInsertSpace%',' ',[rfReplaceAll,rfIgnoreCase]);

//else
//RStr:=(stringreplace(lst.values[APASSHint],'%XFGMemoInsertNewLine%','',
//[rfReplaceAll,rfIgnoreCase]));

(********************************************************************************************)
//%XFGMemoInsertExecuteThisCommand%%XFGMemoInsertWithNoMultiLine%
//crs_debug(lst.values[APASSHint],'/xxxxxxxxxxxx');
if AnsiPos(AnsiLowercase('%XFGMemoInsertExecuteThisCommand'),AnsiLowercase(lst.values[APASSHint]))>0
then 
begin
CanStrip:=false;
result:='';
GSTR:='';
str:='';
GSTR:=stringreplace((lst.values[APASSHint]),'%XFGMemoInsertExecuteThisCommand%','',[rfReplaceAll,rfIgnoreCase]);

templst:=tstringlist.create;
//lst.clear;
templst.text:=(APASSListStr);
for i:=0 to templst.count-1 do
begin

//crs_debug(GSTR+'   '+templst[i],'/xxxxxxxxxxxx');
if GSTR='' then
begin
str:=timetostr(now);
Libc.system(pchar('xterm -title "'+APASSHint+'" -hold -e "'+trim(templst[i])+
';echo ;echo ;echo ;echo End OF Command : ;echo command = '+trim(templst[i])+';echo time started = '+
str+'" &')) ;end else
begin
if AnsiPos(AnsiLowercase('%XFGMemoInsertExecuteThisCommand'),AnsiLowercase(GSTR))>0
then result:=result+trim(GSTR+templst[i])+#13#10;

if AnsiPos(AnsiLowercase('%XFGMemoInsertExecuteThisCommandMultiple%'),AnsiLowercase(GSTR))>0 then 
begin
str:=stringreplace(GSTR,'%XFGMemoInsertExecuteThisCommandMultiple%',templst[i],[rfReplaceAll,rfIgnoreCase]);
str:=stringreplace(str,'%XFGMemoInsertExecuteThisCommandGetInteger%',inttostr(i*20),[rfReplaceAll,rfIgnoreCase]);
Libc.system(pchar(trim(str+' &'))) ;
continue;
end else
begin
CanStrip:=true;
str:=str+templst[i]+' ';
end;
end;
end;

if CanStrip then
begin
GSTR:='';
GSTR:=stringreplace((lst.values[APASSHint]),'%XFGMemoInsertExecuteThisCommand%',str,[rfReplaceAll,rfIgnoreCase]);
Libc.system(pchar(trim(GSTR+' &'))) ;
end;
lst.clear;
if lst<>nil then lst.free;
if templst<>nil then templst.free;
exit;
end;
(********************************************************************************************)

if  (AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsertAtCursor%GetValue%'),AnsiLowercase(APASSSTR))>0 )
then
begin
result:=RStr;
end else
begin
if AnsiPos(AnsiLowercase('%XFGMemoInsertWithLine%'),AnsiLowercase(RStr))<>0 then
begin
if APASSListStr='' then
result:=stringreplace(RStr,'%XFGMemoInsertWithLine%','',[rfReplaceAll,rfIgnoreCase]) else
begin
lst.clear;
lst.text:=APASSListStr;
GSTR:='';
for i:=0 to lst.count-1 do
if lst[i]=''then begin if i<>lst.count-1 then GSTR:=(GSTR+#10) else GSTR:=GSTR;end else
begin
if i<>lst.count-1 then GSTR:=GSTR+stringreplace(RStr,'%XFGMemoInsertWithLine%',lst[i],
                                                     [rfReplaceAll,rfIgnoreCase])+#10 else
GSTR:=GSTR+stringreplace(RStr,'%XFGMemoInsertWithLine%',lst[i],[rfReplaceAll,rfIgnoreCase]);
end;
result:=trimright(GSTR);
end;
end else
if AnsiPos(AnsiLowercase('%XFGMemoInsertWithNoMultiLine%'),AnsiLowercase(RStr))<>0 then
begin
result:=trimright(stringreplace(RStr,'%XFGMemoInsertWithNoMultiLine%',(APASSListStr),
                 [rfReplaceAll,rfIgnoreCase]));
end else
if AnsiPos(AnsiLowercase('%XFGMemoInsertWithLineAppendLeft@'),AnsiLowercase(RStr))<>0 then
begin // %XFGMemoInsertWithLineAppendLef t@\item %
MB:=1;
i:=AnsiPos(AnsiLowercase('%XFGMemoInsertWithLineAppendLeft@'),AnsiLowercase(RStr));
repeat
Inc(i);
Inc(MB);
until copy(RStr,i,1)='%';
Qstr:=copy(RStr,AnsiPos(AnsiLowercase('%XFGMemoInsertWithLineAppendLeft@'),AnsiLowercase(RStr))+length('%XFGMemoInsertWithLineAppendLeft@'),
MB-length('%XFGMemoInsertWithLineAppendLeft@')-1);
//QstrTemp:=;
//crs_debug(Qstr,'/mmmmmmmmmmm');
if APASSListStr='' then
result:=stringreplace(RStr,'%XFGMemoInsertWithLineAppendLeft@','',[rfReplaceAll,rfIgnoreCase]) else
begin
lst.clear;
lst.text:=APASSListStr;
GSTR:='';
for i:=0 to lst.count-1 do
if lst[i]=''then begin if i<>lst.count-1 then GSTR:=(GSTR+#10) else GSTR:=GSTR;end else
begin
if i<>lst.count-1 then GSTR:=GSTR+Qstr+lst[i]+#10 else
GSTR:=GSTR+Qstr+lst[i];
end;
result:=trimright(stringreplace(RStr,'%XFGMemoInsertWithLineAppendLeft@'+Qstr+'%',GSTR,
[rfReplaceAll,rfIgnoreCase]));
end;

end else
if AnsiPos(AnsiLowercase('%XFGMemoInsertWithLineAppendRight@'),AnsiLowercase(RStr))<>0 then
begin
MB:=1;
i:=AnsiPos(AnsiLowercase('%XFGMemoInsertWithLineAppendRight@'),AnsiLowercase(RStr));
repeat
Inc(i);
Inc(MB);
until (copy(RStr,i,1)='%');

Qstr:=copy(RStr,AnsiPos(AnsiLowercase('%XFGMemoInsertWithLineAppendRight@'),
AnsiLowercase(RStr))+length('%XFGMemoInsertWithLineAppendRight@'),
MB-length('%XFGMemoInsertWithLineAppendRight@')-1);
//QstrTemp:=;
//crs_debug(Qstr,'/mmmmmmmmmmm');
if APASSListStr='' then
result:=stringreplace(RStr,'%XFGMemoInsertWithLineAppendRight@','',[rfReplaceAll,rfIgnoreCase]) else
begin
lst.clear;
lst.text:=APASSListStr;
GSTR:='';
for i:=0 to lst.count-1 do
if lst[i]=''then begin if i<>lst.count-1 then GSTR:=(GSTR+#10) else GSTR:=GSTR;end else
begin
if i<>lst.count-1 then GSTR:=GSTR+lst[i]+Qstr+#10 else
GSTR:=GSTR+lst[i]+Qstr;
end;
result:=trimright(stringreplace(RStr,'%XFGMemoInsertWithLineAppendRight@'+Qstr+'%',GSTR,
[rfReplaceAll,rfIgnoreCase]));
end;

end ;
end;
end;
end;
end;
end;
(********************************************************************************************)
if AnsiPos(AnsiLowercase('%GetCustomCommand%XFGMemoInsert%'),AnsiLowercase(APASSSTR))>0 then 
begin
GSTR:=CRS_GetGuid;
libc.system(pchar(stringreplace(APASSSTR,'%GetCustomCommand%XFGMemoInsert%','',
                                    [rfReplaceAll,rfIgnoreCase])+
' > '+RS_APP_data_dir+'/'+GSTR+'ToBeDeleted'));
if fileexists(RS_APP_data_dir+'/'+GSTR+'ToBeDeleted')then
begin
lst.loadfromfile(RS_APP_data_dir+'/'+GSTR+'ToBeDeleted');
deletefile(RS_APP_data_dir+'/'+GSTR+'ToBeDeleted');
result:=lst.text;
end else
result:='';
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoLineNumbering'),AnsiLowercase(APASSSTR))>0)
then
begin
tempstr:=CRS_InputQuery('Insert lines numbering','Character to insert between lines number and text'+#13#10+
                        'The default is two spaces','  ',false);
MB:=CRS_DialogQuery('Include empty lines ?');
if tempstr='' then tempstr:='  ';
if mb=mrAbort then result:=APASSListStr else
begin
lst.text:=APASSListStr;

QstrTemp:=inttostr(lst.count);
Qstr:='';

for i:=1 to length(QstrTemp)do
Qstr:=Qstr+' ';
QstrTemp:=Qstr;
APASSListStr:='';
//Nth:=1;
for i:=0 to lst.count-1 do
begin
str:=lst[i];
QstrTemp:=Qstr;
if (trim(str)='')and (MB=mrNo)then
begin
APASSListStr:=APASSListStr+(#10);
continue;
end;
system.delete(QstrTemp,(length(QstrTemp)-length(inttostr(i+1)))+1,length(QstrTemp));
//if i<9 then APASSListStr:=APASSListStr+(' '+inttostr(Nth)+tempstr+lst[i]+#13#10)else
APASSListStr:=APASSListStr+(QstrTemp+inttostr(i+1)+tempstr+str+#10);
//Inc(Nth);
end;
end;
result:=APASSListStr;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoColumniseAtDelimiter'),AnsiLowercase(APASSSTR))>0)
then
begin
tempstr:=CRS_InputQuery('Columnise at delimiter','Columnise at delimiter strings of ','',false);
if tempstr='' then result:=APASSListStr else
result:=stringreplace(APASSListStr,tempstr,#10,[rfReplaceAll]);
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoColumniseRow'),AnsiLowercase(APASSSTR))>0)
or  (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoColumniseColum'),AnsiLowercase(APASSSTR))>0)

then
begin
templstFull:=false;
lst.clear;
lst.text:=APASSListStr;
tempstr:='';
if  (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoColumniseColum'),AnsiLowercase(APASSSTR))>0)then
tempstr:=CRS_InputQuery('Columnise text','Columnise to Nth of colum : ','2',true)else
//if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoColumniseRow'),AnsiLowercase(APASSSTR))>0)then
tempstr:=CRS_InputQuery('Columnise text','Columnise at row number : ','5',true);
if tempstr='' then result:=APASSListStr else
if strtoint(tempstr)>lst.count then result:=APASSListStr else
begin
ii:=strtoint(tempstr);
if  (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoColumniseColum'),AnsiLowercase(APASSSTR))>0)then
MB:=strtoint(FormatFloat('0',lst.count/ii))else
//if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoColumniseRow'),AnsiLowercase(APASSSTR))>0)then
MB:=ii;
Nth:=1;
templst:=tstringlist.create;

repeat

if templst.count>=MB then templstFull:=true;
max:=0;
for ii:=1 to MB do
begin
if templstFull<>true then
begin
if length(trim(lst[ii-Nth]))>max then
max:=length(trim(lst[ii-Nth]));
end else
//if templstFull=true then
begin
if length(trim(templst[ii-1]))>max then
max:=length(trim(templst[ii-1]));
end;
end;

for i:=1 to MB do
begin
GSTR:='';


if  templstFull=false then 
begin
if length(trim(lst[Nth-1]))<>max then
begin
ii:=max-length(trim(lst[Nth-1]));
for index:=1 to ii do
GSTR:=GSTR+' ';
end;
templst.add(trim(lst[Nth-1])+GSTR);
end
else 
begin
if length(trim(templst[i-1]))<>max then
begin
ii:=max-length(trim(templst[i-1]));
for index:=1 to ii do
GSTR:=GSTR+' ';
end;
templst[i-1]:=trim(templst[i-1])+GSTR+'    '+trim(lst[Nth-1]);
end;

if Nth=lst.count then break;
Inc(Nth);

end;

until Nth=lst.count;
//rstr:=templst.text;
//crs_debug(templst.text,'/xxxxxxxxxxxxxx');
result:=templst.text;
//crs_debug(result,'/xxxxx');
templst.free;
end;
end;

(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoStripEmptyLine'),AnsiLowercase(APASSSTR))>0)then
begin
lst.clear;
lst.text:=APASSListStr;
GSTR:='';
PosH:=lst.count-1;
for i:=0 to lst.count-1 do
begin
str:=lst[i];
if trim(str)<>'' then
begin
if i<>PosH then
GSTR:=GSTR+str+#10 else
GSTR:=GSTR+str; 
end;
end;
result:=(GSTR);
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoAddLineSpacing'),AnsiLowercase(APASSSTR))>0)then
begin
//tempstr:=CRS_InputQuery('Columnise text','Columnise at row number : ','',true);
tempstr:=CRS_InputQuery('Add line spacing','Number of spacing between lines','1',true);
if tempstr='' then result:=APASSListStr else
begin
GSTR:=#10;
for i:=1 to strtoint(tempstr) do
GSTR:=GSTR+#10;
lst.clear;
Qstr:='';
lst.text:=APASSListStr;
for i:=0 to lst.count-1 do
Qstr:=Qstr+lst[i]+GSTR;
//rstr:=stringreplace(APASSListStr,APASSListStr,Qstr,[rfReplaceAll]);
result:=(Qstr);
end;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoDecolumnise'),AnsiLowercase(APASSSTR))>0)then
begin
//tempstr:=CRS_InputQuery('Columnise text','Columnise at row number : ','',true);
tempstr:=CRS_InputQuery('Strip colum','Delimited text of colums ',' ',false);
if tempstr='' then result:=APASSListStr else
begin
rstr:=stringreplace(APASSListStr,tempstr,#10,[rfReplaceAll]);
result:=rstr;
end;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoTrimControlNewLine'),AnsiLowercase(APASSSTR))>0)then
begin
lst.text:=APASSListStr;
APASSListStr:='';
for i:=0 to lst.count-1 do
APASSListStr:=APASSListStr+lst[i];
result:=APASSListStr;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoStripRightSpace'),AnsiLowercase(APASSSTR))>0)then
begin
lst.text:=APASSListStr;
APASSListStr:='';
for i:=0 to lst.count-1 do
if i=lst.count-1 then APASSListStr:=APASSListStr+trimright(lst[i])else
APASSListStr:=APASSListStr+trimright(lst[i])+#10;
result:=APASSListStr;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoDeleteLeftStrings'),AnsiLowercase(APASSSTR))>0)then
begin
result:=APASSListStr;
tempstr:=CRS_InputQuery('Delete number of characters from the start',
           'Number of characters to be deleted from the starting left-side ',
                              '',true);
if (tempstr='')or (strtoint(tempstr)<1) then result:=APASSListStr else
begin
lst.text:=APASSListStr;
APASSListStr:='';
for i:=0 to lst.count-1 do
begin
GSTR:=trim(lst[i]);
delete(GSTR,1,strtoint(tempstr));
APASSListStr:=APASSListStr+GSTR+#10;
end;
result:=APASSListStr;
end;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoDeleteRightStrings'),AnsiLowercase(APASSSTR))>0)then
begin
result:=APASSListStr;
tempstr:=CRS_InputQuery('Delete number of characters from the end',
               'Number of characters to be deleted from the ending right-side ',
                              '',true);
if (tempstr='')or (strtoint(tempstr)<1) then result:=APASSListStr else
begin
lst.text:=APASSListStr;
APASSListStr:='';
for i:=0 to lst.count-1 do
begin
GSTR:=trim(lst[i]);
delete(GSTR,(length(GSTR)-strtoint(tempstr))+1,length(GSTR));
APASSListStr:=APASSListStr+GSTR+#10;
end;
result:=APASSListStr;
end;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoFromStartStrDeleteLeftStrings'),AnsiLowercase(APASSSTR))>0)then
begin
result:=APASSListStr;
tempstr:=CRS_InputQuery('Delete left-side characters from the first ocurrence of words',
           'Start from First ocurrence of words ...',
                              '',false);
if (tempstr='')then result:=APASSListStr else
begin
lst.text:=APASSListStr;
APASSListStr:='';
for i:=0 to lst.count-1 do
begin
GSTR:=trim(lst[i]);
delete(GSTR,1,AnsiPos(tempstr,GSTR)-1);
APASSListStr:=APASSListStr+GSTR+#10;
end;
result:=APASSListStr;
end;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoFromStartStrDeleteRightStrings'),AnsiLowercase(APASSSTR))>0)then
begin
result:=APASSListStr;
tempstr:=CRS_InputQuery('Delete right-side characters from the first ocurrence of words',
           'Start from First ocurrence of words ...',
                              '',false);
if (tempstr='')then result:=APASSListStr else
begin
lst.text:=APASSListStr;
APASSListStr:='';
for i:=0 to lst.count-1 do
begin
GSTR:=trim(lst[i]);
delete(GSTR,(AnsiPos(tempstr,GSTR)+length(tempstr)),length(GSTR));
APASSListStr:=APASSListStr+GSTR+#10;
end;
result:=APASSListStr;
end;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoAppendLeftWith'),AnsiLowercase(APASSSTR))>0)then
begin
result:=APASSListStr;
tempstr:=CRS_InputQuery('Append text from the start','Text to be appended from the starting left-side ',
                              '',false);
if tempstr='' then result:=APASSListStr else
begin
lst.text:=APASSListStr;
APASSListStr:='';
for i:=0 to lst.count-1 do
APASSListStr:=APASSListStr+tempstr+trim(lst[i])+#10;
result:=APASSListStr;
end;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoAppendRightWith'),AnsiLowercase(APASSSTR))>0)then
begin
result:=APASSListStr;
tempstr:=CRS_InputQuery('Append text at the end','Text to be appended at the ending right-side ',
                              '',false);
if tempstr='' then result:=APASSListStr else
begin
lst.text:=APASSListStr;
APASSListStr:='';
for i:=0 to lst.count-1 do
APASSListStr:=APASSListStr+trim(lst[i])+tempstr+#10;
result:=APASSListStr;
end;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoAlignLeft'),AnsiLowercase(APASSSTR))>0)then
begin
lst.text:=APASSListStr;
APASSListStr:='';
PosH:=lst.count-1;
for i:=0 to lst.count-1 do
if i=PosH then APASSListStr:=APASSListStr+trim(lst[i])else
APASSListStr:=APASSListStr+trim(lst[i])+#10;
result:=APASSListStr;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoStripSpace'),AnsiLowercase(APASSSTR))>0)then
begin
CanStrip:=true;
result:=APASSListStr;
lst.text:=APASSListStr;
if lst.count>200 then 
begin
if MessageDlg ('Are you sure you want to strip all spaces from text which'+#13#10+
            'contains more than 200 lines ?'+#10
                 , mtConfirmation, [mbYes,mbNo], 0, mbNo)=mrYes 
then CanStrip:=true else CanStrip:=false;
end;
if CanStrip=true then
begin
GSTR:='';
APASSListStr:='';
PosH:=lst.count-1;
for i:=0 to lst.count-1 do
begin
GSTR:=lst[i];
repeat
delete(GSTR,AnsiPos(' ',GSTR),1);
until AnsiPos(' ',GSTR)=0;
if i<>PosH then GSTR:=GSTR+#10;
APASSListStr:=APASSListStr+GSTR;
end;
end;
result:=APASSListStr;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%DoXFGMemoWrap'),AnsiLowercase(APASSSTR))>0)
then
begin
tempstr:=CRS_InputQuery('Wrap text','Wrap at colum number : ','80',true);
if tempstr='' then result:=APASSListStr else
result:=CRS_WrapText(APASSListStr,strtoint(tempstr));
end;
(********************************************************************************************)
//      cat "%GetCustomCommand%GetApassList2File" >>  %Output filename part%.tex
if (AnsiPos(AnsiLowercase('%GetCustomCommand%GetApassList2File'),AnsiLowercase(APASSSTR))>0)then
begin
result:='';
GSTR:=CRS_GetGuid;
CRS_DEBUG(APASSListStr,getcurrentdir+'/'+GSTR);
APASSSTR:=StringReplace(APASSSTR,'%GetCustomCommand%GetApassList2File',getcurrentdir+'/'+GSTR,[rfReplaceAll, rfIgnoreCase]);
result:=APASSSTR;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%GetGuids'),AnsiLowercase(APASSSTR))>0)then
begin
result:='';
GSTR:=CRS_GetGuid;
APASSSTR:=StringReplace(APASSSTR,'%GetCustomCommand%GetGuids',GSTR,[rfReplaceAll, rfIgnoreCase]);
result:=APASSSTR;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%GetCurrentDir'),AnsiLowercase(APASSSTR))>0)then
begin
result:='';
APASSSTR:=StringReplace(APASSSTR,'%GetCustomCommand%GetCurrentDir',GetCurrentDir+'/',[rfReplaceAll, rfIgnoreCase]);
result:=APASSSTR;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%GetUserDataDir'),AnsiLowercase(APASSSTR))>0)then
begin
result:='';
APASSSTR:=StringReplace(APASSSTR,'%GetCustomCommand%GetUserDataDir',RS_APP_data_dir+'/',[rfReplaceAll, rfIgnoreCase]);
result:=APASSSTR;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%GetResourceFile@'),AnsiLowercase(APASSSTR))>0)then
begin
MB:=1;
i:=AnsiPos(AnsiLowercase('%GetCustomCommand%GetResourceFile@'),AnsiLowercase(APASSSTR));
repeat

Inc(i);
Inc(MB);
until (copy(APASSSTR,i,1)=' ')or (copy(APASSSTR,i,1)='"')or (i-1=length(APASSSTR));

GSTR:= trim(copy(APASSSTR,AnsiPos(AnsiLowercase('%GetCustomCommand%GetResourceFile@'),AnsiLowercase(APASSSTR))+length('%GetCustomCommand%GetResourceFile@'),
MB-length('%GetCustomCommand%GetResourceFile@')-1));

if (not(fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR))
and not(fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR)))
then begin 
MessageDlg ('Can''t find Resource file '+RS_SYSTEM_RESOURCE_PATH+'/'+GSTR+#10+
              ' or '+RS_USER_RESOURCE_PATH+'/'+GSTR+' , so abort ' +#10+#10
        , mtinformation, [mbOK], 0);
end else
begin
lst.clear;
if fileexists(RS_USER_RESOURCE_PATH+'/'+GSTR)then 
lst.loadfromfile(RS_USER_RESOURCE_PATH+'/'+GSTR)else
if fileexists(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR)then 
lst.loadfromfile(RS_SYSTEM_RESOURCE_PATH+'/'+GSTR);
APASSSTR:=StringReplace(APASSSTR,'%GetCustomCommand%GetResourceFile@','',[rfReplaceAll, rfIgnoreCase]);
APASSSTR:=StringReplace(APASSSTR,GSTR,lst.text,[rfReplaceAll, rfIgnoreCase]);
end;
result:=APASSSTR;
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%GetCustomCommand%GetCaption'),AnsiLowercase(APASSSTR))>0)then
begin
APASSSTR:=StringReplace(APASSSTR,'%GetCustomCommand%GetCaption',APASSHint,[rfReplaceAll, rfIgnoreCase]);
result:=APASSSTR;
end;
(********************************************************************************************)
if  (AnsiPos(AnsiLowercase('%GetCustomCommand%EjectAllCD'),AnsiLowercase(APASSSTR))>0)then
begin
for i:=1 to 4 do
begin
if i=1 then
libc.system (pchar('eject /dev/cdrom'+';')) else
libc.system (pchar('eject /dev/cdrom'+inttostr(i-1)+';'));
end;
for i:=1 to 8 do
libc.system (pchar('eject /dev/scd'+inttostr(i-1)+';'));
end;
(********************************************************************************************)
if  (AnsiPos(AnsiLowercase('%GetCustomCommand%CloseAllCD'),AnsiLowercase(APASSSTR))>0)then
begin
for i:=1 to 4 do
begin
if i=1 then
libc.system (pchar('eject -t /dev/cdrom'+';')) else
libc.system (pchar('eject -t /dev/cdrom'+inttostr(i-1)+';'));
end;
for i:=1 to 8 do
libc.system (pchar('eject -t /dev/scd'+inttostr(i-1)+';'));
end;
(********************************************************************************************)
if (AnsiPos(AnsiLowercase('%DoListCustomCommand%GetCDTrack'),AnsiLowercase(APASSSTR))>0)or
 (AnsiPos(AnsiLowercase('%GetCustomCommand%GetPlayCDROM'),AnsiLowercase(APASSSTR))>0)then
begin
result:='';
GSTR:=CRS_GetGuid;
CDDev:=0;

for i:=1 to 4 do
begin
if i=1 then
begin
//libc.system (pchar('eject -t /dev/cdrom'));
libc.system (pchar('cdda2wav -D /dev/cdrom -JgH -v toc 2> '+RS_APP_data_dir+'/'+GSTR+'ToBeDeleted;'));end 
else begin
libc.system (pchar('cdda2wav -D /dev/cdrom'+inttostr(i-1)+' -JgH -v toc 2> '+RS_APP_data_dir+'/'+GSTR+'ToBeDeleted;'));
//libc.system (pchar('eject -t /dev/cdrom'+inttostr(i-1)));
end;
lst.clear;
lst.loadfromfile(RS_APP_data_dir+'/'+GSTR+'ToBeDeleted'); 
//if lst.indexof('cooked: Read TOC : No medium found')<0 then
if AnsiPos('No medium found',lst.text)=0 then
begin
CDDev:=i;
if CDDev=1 then
deviceStr:='/dev/cdrom'else
deviceStr:='/dev/cdrom'+inttostr(CDDev-1);
break;
end;
end;
if CDDev=0 then 
begin
for i:=1 to 8 do
begin
//libc.system (pchar('eject -t /dev/scd'+inttostr(i-1)));
libc.system (pchar('cdda2wav -D /dev/scd'+inttostr(i-1)+' -JgH -v toc 2> '+RS_APP_data_dir+'/'+GSTR+'ToBeDeleted'));
lst.clear;
lst.loadfromfile(RS_APP_data_dir+'/'+GSTR+'ToBeDeleted'); 
//if lst.indexof('cooked: Read TOC : No medium found')<0 then
if AnsiPos('No medium found',lst.text)=0 then
begin
CDDev:=i-1;
deviceStr:='/dev/scd'+inttostr(CDDev);
break;
end;
end;
end;
if CDDev<>0 then
begin
if (AnsiPos(AnsiLowercase('%GetCustomCommand%GetPlayCDROM'),AnsiLowercase(APASSSTR))>0)then
begin
result:=stringreplace(APASSSTR,'%GetCustomCommand%GetPlayCDROM',deviceStr,[rfReplaceAll, rfIgnoreCase]);
//exit;
end;
//setenv('CDDA_DEVICE','/dev/cdrom', 1)else
//setenv('CDDA_DEVICE','/dev/cdrom'+inttostr(CDDev-1), 1);
if (AnsiPos(AnsiLowercase('%DoListCustomCommand%GetCDTrack'),AnsiLowercase(APASSSTR))<>0)then 
begin
libc.system (pchar('cdplay -c '+deviceStr+' -n table > '+RS_APP_data_dir+'/'+GSTR+'ToBeDeleted'));

if fileexists(RS_APP_data_dir+'/'+GSTR+'ToBeDeleted') then
begin
lst.clear;
lst.loadfromfile(RS_APP_data_dir+'/'+GSTR+'ToBeDeleted');
try
for i:=5 to lst.count-1 do
begin  
if lst[i]='' then continue;
if AnsiPos('*',trim(lst[i]))=1 then
result:=result+ copy(trim(trim(StringReplace(lst[i],'*',' ',[]))),1,ansipos(' ',
trim(StringReplace(lst[i],'*',' ',[rfReplaceAll, rfIgnoreCase])))-1)+#13#10
else
result:=result+copy(trim(lst[i]),1,ansipos(' ',trim(lst[i]))-1)+#13#10;
end;
finally
if fileexists(RS_APP_data_dir+'/'+GSTR+'ToBeDeleted') then
deletefile(RS_APP_data_dir+'/'+GSTR+'ToBeDeleted');
end;
end;//if fileexists(RS_APP_data_dir+'/'+GSTR) then
end;//if (AnsiPos(AnsiLowercase('%DoListCustomCommand%GetCDTrack'),AnsiLowercase(APASSSTR))<>0)then 
end;//if CDDev=0 then exit else
end;//if AnsiPos(AnsiLowercase('GetCDTrack'),AnsiLowercase(APASSSTR))>0 then

if lst<>nil then lst.free;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_CheckBuiltinVariables(APASSSTR:string;WithBreakIfSpace:Boolean):string;    
var vSTR:string;vPOS:integer;
begin
result:=APASSSTR;
vPOS:=AnsiPos(AnsiLowercase('%GETCURRENTDIR%'),AnsiLowercase(APASSSTR));
if vPOS>0 then
begin
delete(APASSSTR,vPOS,length('%GETCURRENTDIR%'));
insert(getcurrentdir+'/',APASSSTR,vPOS);
result:=APASSSTR;
end;
if (AnsiPos(AnsiLowercase('%GetCustomCommand%'),AnsiLowercase(APASSSTR))>0)then
result:=CRS_DoListCustomCommand(APASSSTR,'','');
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.X_CRS_scriptdialog(const APASSsini:TMemIniFile;detachMode:boolean):string;
var lst,lst2,FinalLst:tstringlist;i,topINT,LBDwidth,LBDleft,dlgFinalHeight,UpdateFinalHeightINT,finalINT:integer;
    LBD,LBD1:tlabel;
    edD:tedit;cmbD:tcombobox;DLG:Tform;tempstr,tempstr1,insertSTR,VARtempstr:string;chkD:tcheckbox;
    bD:tbutton;PD,PDBOTTOM,PDTOP:tpanel;imgD:timage;gbD,gbD1,gbD2:tgroupbox;
    DoNotUpdateFinalHeight:boolean;AControl:TControl;sp:tspeedbutton;
    
(******************************************************************************************************)
Function checkActualValue(APASSsini:TMemIniFile;APASSString:string):string;
begin
//result:=APASSString;
result:=APASSString;
if APASSsini.valueexists('ActualValue',APASSString)
then result:=APASSsini.readstring('ActualValue',APASSString,APASSString);
end;

begin
UpdateFinalHeightINT:=0;
DoNotUpdateFinalHeight:=false;
result:='';
lst:=tstringlist.create;
lst2:=tstringlist.create;
FinalLst:=tstringlist.create;
topINT:=25;
APASSsini.readsection('CREATE',lst);
DLG:=tform.create(application);
try
DLG.caption:=APASSsini.readstring('INIT','FrameCaption','XFG Custom Dialog');
//dlg.position:=poscreencenter;
DLG.width:=APASSsini.readinteger('INIT','FrameWidth',400);
LBDwidth:=APASSsini.readinteger('INIT','LabelWidth',100);
LBDleft:=20;


PDTOP:=tpanel.create(DLG);
PDTOP.parent:=DLG;
PDTOP.height:=55;
PDTOP.align:=altop;
PDTOP.borderstyle:=bsnone;

PDBOTTOM:=tpanel.create(DLG);
PDBOTTOM.parent:=DLG;
PDBOTTOM.height:=40;
PDBOTTOM.align:=albottom;
PDBOTTOM.borderstyle:=bsnone;

PD:=tpanel.create(DLG);
PD.parent:=DLG;
PD.align:=alclient;
PD.borderstyle:=bsnone;

imgD:=timage.create(PDTOP);
imgD.parent:=PDTOP;
imgD.height:=48;
imgD.width:=48;
imgD.top:=5;
imgD.left:=PDTOP.width-imgD.height-15;
//imgD.Canvas.Brush.color :=LBD1.color;   
//imgD.Canvas.FillRect(Rect(0,0,imgD.height,imgD.width));
imgD.visible:=true;
imgD.autosize:=false;
try
if fileexists(APASSsini.readstring('INIT','LabelImage','LabelImage')) then
imgD.picture.loadfromfile(APASSsini.readstring('INIT','LabelImage','none'));
except
;
end;
LBD1:=tlabel.create(PDTOP);
LBD1.parent:=PDTOP;
LBD1.top:=5;
LBD1.height:=40;
LBD1.left:=10;
LBD1.width:=PDTOP.width-20-48-20;
LBD1.autosize:=false;
LBD1.alignment:=taleftjustify;
 LBD1.WordWrap:=true;
 
LBD1.layout:=tlCenter;
//LBD1.font.style:= [fsBold];
//LBD1.font.color:= clwhite;//clblack;
LBD1.font.color:= clblack;
//LBD1.color:=16755370;//43775;
LBD1.color:=43775;
LBD1.font.size:=14;
//LBD1.font.style:=[fsbold];
LBD1.visible:=true;
LBD1.caption:=' '+trimright(APASSsini.readstring('INIT','FrameLabel','XFG Custom Dialog : '));

gbD1:=tgroupbox.create(PD);
gbD1.parent:=PD;
gbD1.top:=3;
gbD1.left:=3;
gbD1.caption:='';
gbD1.borderstyle:=bsRaisedPanel;
gbD1.width:=DLG.width-5;
gbD2:=tgroupbox.create(PD);
gbD2.parent:=PD;
gbD2.top:=3;
gbD2.left:=DLG.width;
gbD2.caption:='';
gbD2.borderstyle:=bsRaisedPanel;
gbD2.width:=gbD1.width;
gbD:=gbD1;


for i:=0 to lst.count-1 do
begin
tempstr:=CRS_CheckBuiltinVariables(((AnsiLowercase(trim(APASSsini.readstring('CREATE',lst[i],'none'))))),true);


if DoNotUpdateFinalHeight<>true then
if topINT+PDBOTTOM.height+PDtop.height+55 < (GetScreen.height-50) then
dlgFinalHeight:=topINT+PDBOTTOM.height+PDtop.height+55;

if (topINT+PDBOTTOM.height+PDtop.height+55) > (GetScreen.height-50) then
begin
DoNotUpdateFinalHeight:=true;
DLG.width:=DLG.width*2;
topINT:=25;
UpdateFinalHeightINT:=i;
gbD:=gbD2;
end;

LBD:=tlabel.create(gbD);
LBD.parent:=gbD;
if (i>0) then
topINT:=25*((i-UpdateFinalHeightINT)+1);

LBD.top:=topINT;
LBD.autosize:=true;
LBD.left:=LBDleft-5;
LBD.width:=LBDwidth;
LBD.alignment:=taLeftJustify;
LBD.visible:=true;
LBD.caption:=lst[i];
if APASSsini.valueexists('AlertLabel',LBD.caption)then
LBD.color:=14799562;

if AnsiPos('=',trim(tempstr))=length(tempstr)then tempstr:=tempstr+'none';
(******************************************************************************************************)
if AnsiLowercase(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',1)))='edit' then
if AnsiLowercase(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',2)))='%diropenedit%' then
begin
edD:=tedit.create(gbD);
edD.parent:=gbD;
edD.name:='edb'+inttostr(i);
lst2.add('edb'+inttostr(i));
edD.top:=LBD.top-8;
edD.left:=LBDwidth+LBDleft+5;
edD.width:=GBD.width-(LBDwidth+LBDleft+20);
edD.visible:=true;
edD.showhint:=true;
edD.hint:='Please double click here';
edD.text:=(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',3)));
if not directoryexists(edD.text) then
edD.text:='/';
edD.OnDblClick:=SelectDirClick;
continue;
end;
(******************************************************************************************************)
if AnsiLowercase(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',1)))='edit' then
if AnsiLowercase(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',2)))='%fileopenedit%' then
begin
edD:=tedit.create(gbD);
edD.parent:=gbD;
edD.name:='edb'+inttostr(i);
lst2.add('edb'+inttostr(i));
edD.top:=LBD.top-8;
edD.left:=LBDwidth+LBDleft+5;
edD.width:=GBD.width-(LBDwidth+LBDleft+20);
edD.visible:=true;
edD.showhint:=true;
edD.hint:='Please double click here';
edD.text:='';
edD.OnDblClick:=SelectFileClick;
continue;
end;
(******************************************************************************************************)
if AnsiLowercase(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',1)))='edit' then
if AnsiLowercase(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',2)))='%filesaveedit%' then
begin
edD:=tedit.create(gbD);
edD.parent:=gbD;
edD.readonly:=true;
edD.name:='edb'+inttostr(i);
lst2.add('edb'+inttostr(i));
edD.top:=LBD.top-8;
edD.left:=LBDwidth+LBDleft+5;
edD.width:=GBD.width-(LBDwidth+LBDleft+20);
edD.visible:=true;
edD.showhint:=true;
edD.hint:='Please double click here';
edD.text:=(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',3)));
edD.OnDblClick:=SaveFileClick;
(*
sp:=tspeedbutton.create(gbD);
sp.parent:=(gbD);
sp.Hint :='Save dialog ...';
sp.ShowHint := True;
sp.caption:=edD.text;
sp.Top := LBD.top-8;
sp.left:=(LBDwidth+LBDleft+5)+(GBD.width-(LBDwidth+LBDleft+20)-25)+3;
sp.width:=25;
sp.height:=25;
sp.Flat := True;
if fileexists(RS_APP_image_dir+'/folder-21.png')then
try
sp.Glyph.LoadFromFile(RS_APP_image_dir+'/folder-21.png');
except
;
end;
sp.OnClick := SaveFileClick;
*)
continue;
end;
(******************************************************************************************************)
if AnsiLowercase(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',1)))='edit' then
begin
edD:=tedit.create(gbD);
edD.parent:=gbD;
edD.name:='edb'+inttostr(i);
lst2.add('edb'+inttostr(i));
edD.top:=LBD.top-8;
edD.left:=LBDwidth+LBDleft+5;
edD.width:=GBD.width-(LBDwidth+LBDleft+20);
edD.visible:=true;
edD.showhint:=true;
tempstr:=CRS_GetParamAtPos('['+trim(APASSsini.readstring('CREATE',lst[i],'none'))+']','[',']','=',2);
if tempstr='none' then tempstr:='';
edD.text:=tempstr;
if APASSsini.valueexists('Hint',LBD.caption)then
begin
tempstr:=APASSsini.readstring('Hint',LBD.caption,'none');
tempstr:=stringreplace(tempstr,'#13#10',#13#10,[rfReplaceAll]);
edD.hint:=tempstr;
end;
continue;
end;
(******************************************************************************************************)
if AnsiLowercase(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',1)))='combo' then
begin

cmbD:=tcombobox.create(gbD);
cmbD.parent:=gbD;
cmbD.name:='cmbD'+inttostr(i);
lst2.add('cmbD'+inttostr(i));
cmbD.top:=LBD.top-8;
cmbD.left:=LBDwidth+LBDleft+5;
cmbD.width:=GBD.width-(LBDwidth+LBDleft+20);
cmbD.DropDownCount:=25;
cmbD.showhint:=true;
if trim(AnsiLowercase(CRS_GetParamAtPos('['+tempstr+']','[',']','=',2)))='false' then
cmbD.Style:=csDropDownList;
//   combo=dfsfs|dsada|vvvv|csa|vdsfs|vfdsfs

tempstr1:=CRS_GetParamAtPos('['+trim(APASSsini.readstring('CREATE',lst[i],'none'))+']','[',']','=',3);
//xfgmemo.lines.add(tempstr1);
cmbD.items.Delimiter:='|';
cmbD.items.DelimitedText:=tempstr1;
if APASSsini.valueexists('DefaultValue',LBD.caption)then
cmbD.ItemIndex := cmbD.items.indexof(APASSsini.readstring('DefaultValue',LBD.caption,'none'))else
cmbD.ItemIndex := 0;
if APASSsini.valueexists('Hint',LBD.caption)then
begin
tempstr:=APASSsini.readstring('Hint',LBD.caption,'none');
tempstr:=stringreplace(tempstr,'#13#10',#13#10,[rfReplaceAll]);
cmbD.hint:=tempstr;
end;


continue;
end;
(******************************************************************************************************)
if AnsiLowercase(trim(CRS_GetParamAtPos('['+tempstr+']','[',']','=',1)))='checkbox' then
begin

chkD:=tcheckbox.create(gbD);
chkD.parent:=gbD;
chkD.name:='chkD'+inttostr(i);
lst2.add('chkD'+inttostr(i));
chkD.top:=LBD.top-8;
chkD.showhint:=true;
chkD.left:=LBDwidth+LBDleft+5;
(****************    chkD is on left side     *********************)
//chkD.width:=GBD.width-(LBDwidth+LBDleft+20);
chkD.width:=15;
if trim(AnsiLowercase(CRS_GetParamAtPos('['+tempstr+']','[',']','=',2)))='false' then
chkD.checked:=false else chkD.checked:=true;
//   combo=dfsfs|dsada|vvvv|csa|vdsfs|vfdsfs

tempstr1:=CRS_GetParamAtPos('['+tempstr+']','[',']','=',3);
//xfgmemo.lines.add(tempstr1);
chkD.caption:='';
if APASSsini.valueexists('Hint',LBD.caption)then
begin
tempstr:=APASSsini.readstring('Hint',LBD.caption,'none');
tempstr:=stringreplace(tempstr,'#13#10',#13#10,[rfReplaceAll]);
chkD.hint:=tempstr;
end;


continue;
end;
(******************************************************************************************************)

end;
bD:=tbutton.create(PDBOTTOM);
bd.parent:=PDBOTTOM;
//bd.top:=topINT+45;
bd.top:=8;
bd.left:=PDBOTTOM.width-100;
bd.width:=80;
bd.caption:='Cancel';
bd.ModalResult:=mrCancel; 
//PD.height:=topINT+80;
bD:=tbutton.create(PDBOTTOM);
bd.parent:=PDBOTTOM;
//bd.top:=topINT+45;
bd.top:=8;
bd.left:=PDBOTTOM.width-185;
bd.width:=80;
bd.caption:='OK';
bd.ModalResult:=mrOK; 
//PD.height:=topINT+80;
// DLG.Constraints.MinHeight := topINT+PDBOTTOM.height+PDtop.height+55;
DLG.Constraints.MinHeight := dlgFinalHeight+15;
  DLG.Constraints.MinWidth := DLG.width;
 DLG. Constraints.MaxWidth := DLG.width;
 DLG.Constraints.MaxHeight :=  DLG.Constraints.MinHeight;
 
 imgD.left:=PDTOP.width-imgD.height-15;
LBD1.width:=PDTOP.width-20-48-20;
gbD1.height:= DLG.Constraints.MaxHeight-PDBOTTOM.height-PDtop.height+5;
gbD2.height:= gbD1.height;
 
(******************************************************************************************************)
//dlg.position:=poscreencenter;
dlg.top:=(getscreen.height-(gbD1.height+PDBOTTOM.height+PDtop.height)) div 2;
dlg.left:=(getscreen.width-dlg.width) div 2;
dlg.showmodal;
tempstr:='';
if dlg.ModalResult=mrOK then 
begin
tempstr:=trim(APASSsini.readstring('VALUE','cmd','none'));
if AnsiPos('%GetCustomCommand%GetResourceFile@',tempstr)>0 then
tempstr:=CRS_DoListCustomCommand(tempstr,'','');
for i:=0 to lst.count-1 do
begin

VARtempstr:=CRS_CheckBuiltinVariables(((trim(APASSsini.readstring('CREATE',lst[i],'none')))),true);

AControl:=nil;

if AnsiLowercase(trim(CRS_GetParamAtPos('['+
AnsiLowercase(VARtempstr)+']','[',']','=',1)))='combo' then
begin
if GBD1.FindChildControl(lst2[i])<>nil then AControl:=GBD1.FindChildControl(lst2[i]);
if GBD2.FindChildControl(lst2[i])<>nil then AControl:=GBD2.FindChildControl(lst2[i]);
if AControl=nil then continue;
if checkActualValue(APASSsini,trim((AControl as tcombobox).text))='%none%' then
begin
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%','',[rfReplaceAll]);
FinalLst.add('%'+trim(lst[i])+'%'+'=%none%');
continue;
end
else
if (pos('%insert-here%',checkActualValue(APASSsini,trim((AControl as tcombobox).text)))>0) and
(trim((AControl as tcombobox).text)<>'')then
begin
insertSTR:=StringReplace(checkActualValue(APASSsini,trim((AControl as tcombobox).text)),'%insert-here%',(AControl as tcombobox).text,[rfReplaceAll]);
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%',insertSTR,[rfReplaceAll]);
FinalLst.add('%'+trim(lst[i])+'%'+'='+insertSTR);
continue;
end
else
if (pos('%insert-here%',checkActualValue(APASSsini,trim(lst[i])))>0) and
(trim((AControl as tcombobox).text)<>'')then
begin
insertSTR:=StringReplace(checkActualValue(APASSsini,trim(lst[i])),'%insert-here%',
(AControl as tcombobox).text,[rfReplaceAll]);
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%',insertSTR,[rfReplaceAll]);
FinalLst.add('%'+trim(lst[i])+'%'+'='+insertSTR);
continue;
end
else
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%',
checkActualValue(APASSsini,trim((AControl as tcombobox).text)),[rfReplaceAll]);
FinalLst.add('%'+trim(lst[i])+'%'+'='+checkActualValue(APASSsini,trim((AControl as tcombobox).text)));
continue;
end;
if AnsiLowercase(trim(CRS_GetParamAtPos('['+
AnsiLowercase(VARtempstr)+']','[',']','=',1)))='edit' then
begin
if GBD1.FindChildControl(lst2[i])<>nil then AControl:=GBD1.FindChildControl(lst2[i]);
if GBD2.FindChildControl(lst2[i])<>nil then AControl:=GBD2.FindChildControl(lst2[i]);
if AControl=nil then continue;
if checkActualValue(APASSsini,trim((AControl as tedit).text))='%none%' then
begin
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%','',[rfReplaceAll]);
FinalLst.add('%'+trim(lst[i])+'%'+'=%none%');
continue;
end
else
if (pos('%insert-here%',checkActualValue(APASSsini,trim((AControl as tedit).text)))>0) and
(trim((AControl as tedit).text)<>'')then
begin
insertSTR:=StringReplace(checkActualValue(APASSsini,trim((AControl as tedit).text)),'%insert-here%',
(AControl as tedit).text,[rfReplaceAll]);
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%',insertSTR,[rfReplaceAll]);
FinalLst.add('%'+trim(lst[i])+'%'+'='+insertSTR);
continue;
end
else
if (pos('%insert-here%',checkActualValue(APASSsini,trim(lst[i])))>0) and
(trim((AControl as tedit).text)<>'')then
begin
insertSTR:=StringReplace(checkActualValue(APASSsini,trim(lst[i])),'%insert-here%',
(AControl as tedit).text,[rfReplaceAll]);
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%',insertSTR,[rfReplaceAll]);
FinalLst.add('%'+trim(lst[i])+'%'+'='+insertSTR);
continue;
end
else
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%',
trim((AControl as tedit).text),[rfReplaceAll]);
FinalLst.add('%'+trim(lst[i])+'%'+'='+trim((AControl as tedit).text));
continue;
end;
if AnsiLowercase(trim(CRS_GetParamAtPos('['+
AnsiLowercase(VARtempstr)+']','[',']','=',1)))='checkbox' then
begin
if GBD1.FindChildControl(lst2[i])<>nil then AControl:=GBD1.FindChildControl(lst2[i]);
if GBD2.FindChildControl(lst2[i])<>nil then AControl:=GBD2.FindChildControl(lst2[i]);
if AControl=nil then continue;
if (AControl as tcheckbox).checked=true then
begin

if APASSsini.valueexists('ActualValue',trim(CRS_GetParamAtPos('['+VARtempstr+']','[',']','=',3)))then
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%',
APASSsini.readstring('ActualValue',trim(CRS_GetParamAtPos('['+VARtempstr+']','[',']','=',3)),'none'),[rfReplaceAll])
 else
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%',
trim(CRS_GetParamAtPos('['+VARtempstr+']','[',']','=',3)),[rfReplaceAll]);

FinalLst.add('%'+trim(lst[i])+'%'+'='+trim(CRS_GetParamAtPos('['+VARtempstr+']','[',']','=',3)));

if AnsiPos(AnsiLowercase('%StripPathFromInputFileNames%'),
trim(CRS_GetParamAtPos('['+AnsiLowercase(VARtempstr)+']','[',']','=',3)))>0 then
APASSsini.writeBool('INIT','StripPathFromInputFileNames',true);
end
else
begin
tempstr:=StringReplace(tempstr,'%'+trim(lst[i])+'%','',[rfReplaceAll]);
FinalLst.add('%'+trim(lst[i])+'%'+'='+'');

continue;
end;
end;

end;

end;



finally
for finalINT:=0 to 3 do
begin
for i:=0 to FinalLst.count -1 do
begin
if AnsiPos(FinalLst.names[i],tempstr)>0 then
begin
if FinalLst.values[FinalLst.names[i]]='%none%' then
tempstr:=StringReplace(tempstr,FinalLst.names[i],'',[rfReplaceAll])else
tempstr:=StringReplace(tempstr,FinalLst.names[i],FinalLst.values[FinalLst.names[i]],[rfReplaceAll]);
end;
end;
end;
//FinalLst.add(tempstr);
//FinalLst.savetofile('/ccccccccccccccccccccccccccccccccccccccccccccc');
dlg.free;
lst.free;
lst2.free;
FinalLst.free;
if detachMode=false then
result:=tempstr else
X_CRS_scriptdialog_RunDetach(tempstr);
end;
(******************************************************************************************************)

result:=tempstr;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure TPClass_Command_RedStone.X_CRS_scriptdialog_RunDetach(APASSexecStr:string);
begin

;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.X_CRS_DoVCLMemoPageSearch
(const APASSSearchStr:string;APASSMemo:tmemo;APASSCaseSensitive,APASSHighlightMatch,
    APASSWholeWords,APASSRegularExpr,ForReplaceFunction: Boolean):Boolean;
var OMEMO:Tmemo;
//CaseSensitive,HighlightMatch,WholeWords,RegularExpr:Boolean;
mrrslt:integer;
begin
OMEMO:=(APASSMemo as tmemo);
result:=false;
if OMEMO.lines.count=0 then exit;
if APASSSearchStr='' then exit;
//CaseSensitive:=APASSCaseSensitive;
//HighlightMatch:=APASSHighlightMatch;
//WholeWords:=APASSWholeWords;
//RegularExpr:=APASSRegularExpr;
result:=OMEMO.Search(APASSSearchStr,APASSCaseSensitive,APASSHighlightMatch,APASSWholeWords,APASSRegularExpr,
OMEMO.CaretPos.line,OMEMO.CaretPos.col);
if (result=false)and not(ForReplaceFunction) then
mrrslt:=MessageDlg ('Done searching and end of file reached ,'+#13#10+
                    'go to first line and search again ? '+#13#10
                  , mtConfirmation, [mbOK,mbNo], 0, mbOK);
if mrrslt=mrOK then    
begin  
OMEMO.selstart:=0;            
result:=X_CRS_DoVCLMemoPageSearch(APASSSearchStr,APASSMemo,APASSCaseSensitive,APASSHighlightMatch,
    APASSWholeWords,APASSRegularExpr,ForReplaceFunction);end;
if mrrslt=mrNo then  
exit;     
end;

//(const Text: WideString; CaseSensitive, HighlightMatch, WholeWords, RegularExpr: Boolean; 
//StartLine: Integer = 0; StartCol: Integer = 0):
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.X_CRS_DoVCLMemoPageReplace
(const APASSReplaceStr,APASSSearchStr:string;APASSMemo:tmemo;
APASSCaseSensitive,APASSWholeWords,APASSReplaceAll: Boolean):Boolean;
var OMEMO:Tmemo;
AAPASSReplaceAll,BREAKOUT: Boolean;mrrslt:integer;
begin
result:=false;
OMEMO:=(APASSMemo as tmemo);
if OMEMO.lines.count=0 then exit;
if (APASSReplaceStr='')or (APASSSearchStr='') then exit;
AAPASSReplaceAll:=APASSReplaceAll;
if AAPASSReplaceAll=false then
begin
if OMEMO.sellength>0 then
OMEMO.seltext:=APASSReplaceStr;
if (OMEMO.sellength=0) or ( CompareStr(OMEMO.seltext,APASSReplaceStr)=0) then
begin
if APASSReplaceAll then
result:=X_CRS_DoVCLMemoPageSearch(APASSSearchStr,OMEMO,APASSCaseSensitive,false,APASSWholeWords,true,true);
if not(APASSReplaceAll) then
result:=X_CRS_DoVCLMemoPageSearch(APASSSearchStr,OMEMO,APASSCaseSensitive,true,APASSWholeWords,true,true);
end;

end;//if AAPASSReplaceAll=false then
BREAKOUT:=false;
if AAPASSReplaceAll=true then
begin

repeat
result:=X_CRS_DoVCLMemoPageSearch(APASSSearchStr,OMEMO,APASSCaseSensitive,true,APASSWholeWords,true,true);
if result=false then BREAKOUT:=true;
//if (result=true) then OMEMO.seltext:=APASSReplaceStr;
if (result=true) then begin OMEMO.seltext:='';OMEMO.insert(APASSReplaceStr,false);end;
until BREAKOUT=true;

end;
if result=false then 
mrrslt:=MessageDlg ('Done searching and end of file reached ,'+#13#10+
                    'go to first line and search again ? '+#13#10
                  , mtConfirmation, [mbOK,mbNo], 0, mbOK);
if mrrslt=mrOK then    
begin  
OMEMO.selstart:=1;            
result:=X_CRS_DoVCLMemoPageReplace
(APASSReplaceStr,APASSSearchStr,APASSMemo,
APASSCaseSensitive,APASSWholeWords,APASSReplaceAll)end;
if mrrslt=mrNo then  exit;     

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_CheckEXEArgument(APASSINISTR,APASSString,APASSIndent:string):string;
var tempstr,strk,strkResult,currdirstr:string;
begin
currdirstr:='Currnet working directory : '+getcurrentdir+#13#10;
result:=APASSString;
if APASSIndent='' then 
begin
exit;
end;
tempstr:=AnsiLowercase(APASSString);
if AnsiPos('%qinputdlg%',tempstr)>0 then
begin
strkResult:=APASSIndent;
//tempstr:=APASSINI.Readstring ('InputDLG',APASSIndent, 'none');
tempstr:=APASSINISTR;
if (tempstr<>'none')and(tempstr<>'')and (AnsiPos('|',tempstr)<>0)then
begin
strk:=CRS_GetParamAtPos('{'+tempstr+'}','{','}','|',1);
strkResult:=CRS_GetParamAtPos('{'+tempstr+'}','{','}','|',2) ;
end;
if (AnsiPos('|',tempstr)=0)then 
begin
//strk:=APASSINI.Readstring ('InputDLG',APASSIndent, 'none');
strk:=APASSINISTR;
strkResult:='';
end;
if InputQuery('Command input',currdirstr+#13#10+strk,strkResult)=true then
begin
result:=stringreplace(AnsiLowercase(APASSString),'%qinputdlg%',trim(strkResult),[]);


end 
else
result:='';
end;
 



end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_showmessageFILEOperation(MSGType:integer;PASSFilename:string):integer;
var mr:integer;
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
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_CheckRunMessage(APASSEXE,APASSTitle,APASSDestDir:string):string;
var tempstr,tempstr1,dirstr:string;
begin
result:=APASSEXE;
tempstr1:=APASSEXE;

if AnsiPos(AnsiLowercase('%RunMessage%'),AnsiLowercase(tempstr1))<>0 then
begin
if not AnsiEndsstr(trim(APASSDestDir),'/') then 
dirstr:=trim(APASSDestDir)+'/';
if AnsiEndsstr('&',trim(tempstr1))then system.delete(tempstr1,length(trim(tempstr1)),1);
tempstr1:=StringReplace(trim(tempstr1),AnsiLowercase('%RunMessage%'),'',[rfReplaceAll, rfIgnoreCase]);
tempstr:=CRS_GetGuid+'ToBeDeleted';
crs_debug('#!/bin/bash'+#13#10+tempstr1+#13#10+
'echo '+#13#10+'echo '+#13#10+'echo '+#13#10+'echo End OF Command : '+#13#10+'echo command = '+
tempstr1+#13#10+'echo time started = '+timetostr(now),dirstr+tempstr);
chmod(pchar(dirstr+tempstr), S_IRUSR or  S_IWUSR or  S_IXUSR);
tempstr1:='xterm -title "'+APASSTitle+'" -hold -e sh" '+dirstr+tempstr+'" &';
result:=tempstr1;
end;


end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_ShellFilesTO(AMain,AMinor,AJob,APASSDestination:STRING;
                MODE:integer;AList:TStrings);

var
StrLst: TStringList;
 I: Integer;
 OK:boolean;exec2,exec3,exec,strK ,instr,instrPath,path,tempstr1,tempstr:string;
 ID,ID2,tempint: Integer; IGNOREALL:boolean; 
begin

//crs_debug(AMinor,'/xxxxxxxxxxxxxxxxxxxxxxxxxx');
 exec:= AMinor;
 if exec='' then exit;
 (*
 if AList=nil then
 instr:=CRS_DoListCustomCommand(exec,AMain,'')else
instr:=CRS_DoListCustomCommand(exec,AMain,AList.text);
if instr<>'' then exec:=instr;
crs_debug(instr,'/mmmmmmmmmmmmmm');
*)


OK:=false ;
IGNOREALL:=false ;
StrLst := TStringList.Create;


for i:=0 to AList.count-1 do
StrLst.add(AList[i]);
CRS_CheckFileList(StrLst);

AList.clear;

if StrLst.count=0 then 
begin
MessageDlg ('ERROR loading files : ' +
'Wrong filename found . Are you sure this is a file list or an updated file list?', 
mtInformation, [mbOK], 0);

exit;
end;
//for i:=0 to StrLst.count-1 do
//if (directoryexists(extractfilepath(StrLst.strings[i])))
//then begin path:=extractfilepath(StrLst.strings[i]);break;end;


 instrPath:=APASSDestination;
path:=extractfilepath(StrLst.strings[0]);

if  (AF <> nil) and (EXIT_File_Operation=false)then
begin
MessageDlg ('System busy , so abort'+#13#10
                  , mtConfirmation, [mbOK], 0, mbOK);

exit;
end;

crs_acreateform('  Working on files , please wait ...      ');  
try

   for I := 0 to StrLst.Count - 1 do 
    begin

application.processmessages;
if EXIT_File_Operation=true then break;

if AnsiPos('%CRSGetFileName%%in',exec)<>0 then 
exec:=StringReplace(exec,'%CRSGetFileName%%in',extractfilename(StrLst.Strings[i]),[rfReplaceall]);

if AnsiPos('*',StrLst.Strings[i])>0 then
exec2:=StringReplace(exec,'%in',StrLst.Strings[i],[rfReplaceall])
else
  exec2:=StringReplace(exec,'%in','"'+StrLst.Strings[i]+'"',[rfReplaceall]);
  exec3:=exec2;
 
  if AnsiPos('%out',exec2)>0 then
  begin
  
   //  /usr/bin/convert %in -resize 32x32 %out
   
  strK:='{'+StringReplace(exec2,'%out','@',[rfReplaceAll])+'}';
  strK:=Copy(trim(strK),2,length(trim(strK))-2);
  {/usr/bin/convert "/root/gdict-48.png" -resize 16x16 @new.BMP}
  tempstr:=(Copy(strK,AnsiPos('@',strK)+1,1));
 if (tempstr=' ')or(tempstr='')or(AnsiEndsStr('@',trim(strK)))or(AnsiEndsStr('}',trim(strK)))  then
 begin
 instr:=extractfilename(StrLst.strings[i]);
 strK:=instrPath+instr;
 end
// if Copy(strK,AnsiPos('@',strK)+1,1)<>' ' then
else 
begin
 instr:=copy(StrLst.strings[i],length(path)+1,(length(StrLst.strings[i])-length(path))-
length(crs_extractfileext(StrLst.strings[i])));
tempstr:='';
tempint:=AnsiPos('@',trim(strK));//Copy(S; Index, Count: Integer)
repeat
Inc(tempint);
tempstr1:=Copy(strK,tempint,1);
tempstr:=tempstr+tempstr1;
until (tempstr1=' ')or(tempstr1='') ;
strK:=instrPath+instr+tempstr;
if (AnsiEndsStr('}',trim(strK))) or(AnsiEndsStr('&',trim(strK)))then delete(strK,length(trim(strK)),1);

end;
exec3:=StringReplace(exec2,'%out','"'+instrPath+instr+'"',[rfReplaceAll]);


 end;
 

ID:= mrOK;
 if OK<>true then 
 if (mode =1) or (mode =3) then // mode=0 ==> non-destructiive ,  mode=1 ==> destructive 
  begin  
  if IGNOREALL=false then
   if fileexists(strK) then begin
ID:= CRS_showmessageFILEOperation(1,strK);
 if ID=mrNO then continue;
if ID=mrIGNORE then 
 begin 
  ID2:=CRS_showmessageFILEOperation(2,'');
  if ID2=mrOK then IGNOREALL:=true;
  if ID2=mrNo  then continue;
  if ID2=mrAbort then exit;
   end;
  end;
  end;


 //******************************* 
  if AF <> nil then AL2.caption:='     '+extractfilename(StrLst.Strings[i]);
 //*******************************
 
 
 //crs_debug(exec3,'/mmmmmmmmmmmmmm');
exec3:=CRS_CheckRunMessage(CRS_DoListCustomCommand(exec3,AMain,'')+AJob,AMain,RS_APP_data_dir);

 if Libc.system(pchar(exec3)) = -1 then
 begin
 AList.delete(AList.indexof(strK));
end else
 AList.add(strK);
exec3:='';
tempstr:='';   


end;
finally
StrLst.Free;
if AF<>nil then CRS_AFREEFORM;
end;

end;
(***********************
  if AnsiPos('@',strK)>0 then
begin
if AnsiPos('@',trim(strK))<>length(trim(strK))-1 then 
begin
tempstr:='';
tempint:=AnsiPos('@',trim(strK));//Copy(S; Index, Count: Integer)
repeat
Inc(tempint);
tempstr1:=Copy(strK,tempint,1);
tempstr:=tempstr+tempstr1;
until tempstr1=' ';
strK:=CRS_GetParamAtPos(strK,'{','}','@',2); 
end else
if AnsiPos('@',trim(strK))=length(trim(strK))-1 then 
begin
strK:=StrLst.Strings[i];
exec3:=StringReplace(exec2,'%out','"'+StrLst.Strings[i]+'"',[rfIgnoreCase,rfReplaceAll]); 

end;
end
else if AnsiPos('@',strK)=0 then
strK:=StrLst.Strings[i];
 
if strK<>StrLst.Strings[i]then
begin

if AnsiPos('/',strK)=1 then 
begin
exec3:=StringReplace(exec2,' %out',' ',[rfIgnoreCase,rfReplaceAll]); 
end;
if AnsiPos('/',strK)<>1 then 
begin
instr:=copy(StrLst.strings[i],length(path)+1,(length(StrLst.strings[i])-length(path))-
length(extractfileext(StrLst.strings[i])));
exec3:=StringReplace(exec2,'%out','"'+instrPath+instr+'"',[rfIgnoreCase,rfReplaceAll]);
strK:='{'+StringReplace(exec2,'%out','@'+instrPath+instr,[rfIgnoreCase,rfReplaceAll])+'}';
strK:=CRS_GetParamAtPos(strK,'{','}','@',2) ;
end;

end;//if strK<>StrLst.Strings[i]then

***************)
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_ShellFilesTOSingleFile(AMain,AMinor,AJob,APASSDestination:STRING;
MODE:integer;AList:TStrings);
var
StrLst: TStringList;
 I: Integer;
 exec2,exec3,exec4,exec,strK ,instr,instrPath,path:string;
 OK:boolean; ID,ID2: Integer; IGNOREALL:boolean; 
begin
exec:= AMinor;

if exec='' then exit;
 if AList=nil then
 instr:=CRS_DoListCustomCommand(exec,AMain,'')else
instr:=CRS_DoListCustomCommand(exec,AMain,AList.text);
if instr<>'' then exec:=instr;

IGNOREALL:=false ;
OK:=false ;
StrLst := TStringList.Create;


for i:=0 to AList.count-1 do
StrLst.add(AList[i]);
CRS_CheckFileList(StrLst); 
AList.clear;
if StrLst.count=0 then 
begin
MessageDlg ('ERROR loading files : ' +
'Wrong filename found . Are you sure this is a file list or an updated file list?', 
mtInformation, [mbOK], 0);
exit;
end;

exec2:='';

instrPath:=APASSDestination;
path:=extractfilepath(StrLst.strings[0]);

if  (AF <> nil) and (EXIT_File_Operation=false)then
begin
MessageDlg ('System busy , so abort'+#13#10
                  , mtConfirmation, [mbOK], 0, mbOK);

exit;
end;

crs_acreateform('  Working on files , please wait ...      ');  
try

   for I := 0 to StrLst.Count - 1 do 
    begin
 application.processmessages;   
if EXIT_File_Operation=true then break;

if AnsiPos('%CRSGetFileName%&in',exec2)<>0 then 
exec2:=StringReplace(exec2,'%CRSGetFileName%&in',extractfilename(StrLst.Strings[i]),[rfReplaceall]);

if AnsiPos('*',StrLst.Strings[i])>0 then
exec2:=exec2+' '+StrLst.Strings[i]
else
exec2:=exec2+' '+'"'+StrLst.Strings[i]+'"';
 //******************************* 
  if af <>nil then  AL2.caption:='     '+extractfilename(StrLst.Strings[i]);
 //*******************************
end;


  exec3:=StringReplace(exec,'&in',exec2,[rfIgnoreCase,rfReplaceall]);
  
  strK:='{'+StringReplace(exec,'&out','@',[rfIgnoreCase,rfReplaceall])+'}';
strK:=CRS_GetParamAtPos(strK,'{','}','@',2);
if AnsiPos('/',strK)=1 then 
begin
instrPath:='';
exec4:=StringReplace(exec3,' &out',' ',[rfIgnoreCase,rfReplaceall]); 
end;
if AnsiPos('/',strK)<>1 then 
begin
exec4:=StringReplace(exec3,'&out','"'+instrPath+'"',[rfIgnoreCase,rfReplaceall]); 
end;
 
if AnsiPos(' ',strk)>0 then 
strk:=copy(strk,1,AnsiPos(' ',strk)-1);

 

 if OK<>true then 
 if (mode =1)  or (mode =3) then // mode=0 ==> non-destructiive ,  mode=1 ==> destructive 
  begin  
if IGNOREALL=false then      
 if fileexists(instrPath+strk) then begin
ID:=CRS_showmessageFILEOperation(1,instrPath+strk);
if (ID=mrNO) or(ID=mrIGNORE) then exit;
  end;
  end;

//CRS_DEBUG(exec4+AJob,'/xx1111');  
exec4:=CRS_CheckRunMessage(exec4+AJob,AMain,RS_APP_data_dir);
 if Libc.system(pchar(exec4)) = -1 then ;
 AList.add(instrPath+strK); 


finally
StrLst.Free;
if AF<>nil then CRS_AFREEFORM;
end;

 end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
 procedure TPClass_Command_RedStone.CRS_ShellFilesTOSingleAPPLICATION(AMain,AMinor,AJob:STRING;
 MODE:integer;AList:TStrings);
var
StrLst: TStringList;
 I: Integer;
 instr,exec2,exec3,exec:string;
 
begin

exec:= AMinor;

if exec='' then exit;
 if AList=nil then
 instr:=CRS_DoListCustomCommand(exec,AMain,'')else
instr:=CRS_DoListCustomCommand(exec,AMain,AList.text);
if instr<>'' then exec:=instr;
//CRS_DEBUG(instr,'/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
StrLst := TStringList.Create;


for i:=0 to AList.count-1 do
StrLst.add(AList[i]);
CRS_CheckFileList(StrLst); 
//CRS_DEBUG(StrLst.text,'/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
if StrLst.count=0 then 
begin
MessageDlg ('ERROR loading files : ' +
'Wrong filename found . Are you sure this is a file list or an updated file list?', 
mtInformation, [mbOK], 0);
exit;
end;
exec2:='';

if  (AF <> nil) and (EXIT_File_Operation=false)then
begin
MessageDlg ('System busy , so abort'+#13#10
                  , mtConfirmation, [mbOK], 0, mbOK);

exit;
end;

crs_acreateform('  Working on files , please wait ...      ');  
try
   for I := 0 to StrLst.Count - 1 do 
    begin
application.processmessages;    
if EXIT_File_Operation=true then break;

if AnsiPos('%CRSGetFileName%$in',exec2)<>0 then 
exec2:=StringReplace(exec2,'%CRSGetFileName%$in',extractfilename(StrLst.Strings[i]),[rfReplaceall]);

if AnsiPos('*',StrLst.Strings[i])>0 then
exec2:=exec2+' '+StrLst.Strings[i]
else
exec2:=exec2+' '+'"'+StrLst.Strings[i]+'"';
 //******************************* 
  if af <>nil then  AL2.caption:='     '+extractfilename(StrLst.Strings[i]);
 //*******************************
end;


  exec3:=StringReplace(exec,'$in',exec2,[rfIgnoreCase]);


exec3:=CRS_CheckRunMessage(exec3+AJob,AMain,RS_APP_data_dir);
 if Libc.system(pchar(exec3)) = -1 then ;
 

finally
StrLst.Free;
if AF<>nil then CRS_AFREEFORM;
end;

end;
 
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_ShellFilesTOCAT(AMain,AMinor,AJob,APASSDestination,
                APASSTempDir:STRING;
                MODE:integer;AList:TStrings;APASSMemoLines:TStrings);
var
StrLst: TStringList;
MStr:TMEMORYSTREAM;
 I: Integer;
 OK:boolean;exec2,exec3,exec,strK ,instr,instrPath,path,dataPATH,GUIDStr1:string;
 ID,ID2: Integer; IGNOREALL:boolean; 
begin






if APASSMemoLines=nil then
begin
MessageDlg ('No memo control for text output , so abort '+#13#10+#13#10
             , mtConfirmation, [mbOK], 0, mbOK);
exit;
end;     

exec:= AMinor;

if exec='' then exit;
instr:=CRS_DoListCustomCommand(exec,AMain,APASSMemoLines.text);
if instr<>'' then exec:=instr;

dataPATH:=trim(APASSTempDir);
if lastdelimiter('/',dataPATH)=length(dataPATH)then
delete(dataPATH,length(dataPATH),1);
if not directoryexists(dataPATH) then 
begin
MessageDlg ('No temporary directory specified , so abort '+#13#10+#13#10
             , mtConfirmation, [mbOK], 0, mbOK);
exit;
end;                  

OK:=false ;
IGNOREALL:=false ;
MStr := TMEMORYSTREAM.Create;
StrLst := TStringList.Create;

for i:=0 to AList.count-1 do
StrLst.add(AList[i]);
CRS_CheckFileList(StrLst);

if StrLst.count=0 then 
begin
MessageDlg ('Can''t find valid existing file , so abort'+#13#10
                  , mtConfirmation, [mbOK], 0, mbOK);

exit;
end;

 instrPath:=APASSDestination;
path:=extractfilepath(StrLst.strings[0]);

if  (AF <> nil) and (EXIT_File_Operation=false)then
begin
MessageDlg ('System busy , so abort'+#13#10
                  , mtConfirmation, [mbOK], 0, mbOK);

exit;
end;

crs_acreateform('  Working on files , please wait ...      ');  
try
   for I := 0 to StrLst.Count - 1 do 
    begin

application.processmessages;
if EXIT_File_Operation=true then break;

if AnsiPos('%CRSGetFileName%!in',exec)<>0 then 
exec:=StringReplace(exec,'%CRSGetFileName%!in',extractfilename(StrLst.Strings[i]),[rfReplaceall]);

if AnsiPos('*',StrLst.Strings[i])>0 then
exec2:=StringReplace(exec,'!in',StrLst.Strings[i],[rfIgnoreCase,rfReplaceall])
else
exec2:=StringReplace(exec,'!in','"'+StrLst.Strings[i]+'"',[rfIgnoreCase,rfReplaceall]);

exec3:=exec2;
  if AnsiPos('!out',exec2)>0 then
  begin
 
      instr:=copy(StrLst.strings[i],length(path)+1,length(StrLst.strings[i])-length(path));

  exec3:=StringReplace(exec2,'!out','"'+instrPath+instr+'"',[rfIgnoreCase,rfReplaceall]);
  

 
  strK:='{'+StringReplace(exec2,'!out','@'+instrPath+instr,[rfIgnoreCase,rfReplaceall])+'}';
  
if AnsiPos('@',strK)>0 then
begin
strK:=CRS_GetParamAtPos(strK,'{','}','@',2) ;
end
else if AnsiPos('@',strK)=0 then
strK:=StrLst.Strings[i];
// outlst.add(strK);
 end;
 if OK<>true then 
 if mode =1 then // mode=0 ==> non-destructiive ,  mode=1 ==> destructive 
  begin  

if IGNOREALL=false then
   if fileexists(strK) then begin
   
ID:= CRS_showmessageFILEOperation(1,strK);
 if ID=mrNO then continue;

if ID=mrIGNORE then 
 begin 
  ID2:= CRS_showmessageFILEOperation(2,'');
  if ID2=mrOK then IGNOREALL:=true;
  if ID2=mrNo  then continue;
  if ID2=mrAbort then exit;
  
 end;
  end;
  end;

if af <> nil then AL2.caption:='     '+extractfilename(StrLst.Strings[i]);
GUIDStr1:=CRS_GetGuid;
if Libc.system(pchar(exec3+AJob+' | cat -v > '+dataPATH+'/'+GUIDStr1)) = -1 then
  begin
   ;
  end else
  begin
 // instr:='';
  if fileexists(dataPATH+'/'+GUIDStr1) then 
MStr.LoadFromFile(dataPATH+'/'+GUIDStr1);
//caretstart:=APASSMemoLines.GetTextLen-length(APASSMemoLines[APASSMemoLines.count-1]);
SetLength(instr, MStr.Size);
MStr.Read(Pointer(instr)^, MStr.Size);
APASSMemoLines.append(instr);
//AMemo.SelStart:=caretstart;

exec3:='';
if fileexists(dataPATH+'/'+GUIDStr1) then 
deletefile(dataPATH+'/'+GUIDStr1);
end;//if Libc.system(pchar(exec3+AJob+' > '+datadir+'/redstone.org001')) = -1 then   

end;


finally
if AF<>nil then CRS_AFREEFORM;
MStr.free;
StrLst.Free;
end;

end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_TrimProc(AProc,AStart,AEnd:String):String;
var i,ii:integer;
begin
//create_frame{vrs;default;300;200;default}  //x;xx;sss#aa|ss|qq|a;xx;x
i:=AnsiPos(AStart,AProc);
ii:=AnsiPos(AEnd,AProc);
result:=trim(copy(AProc,i+1,(ii-1)-i ));
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_GetProcName(AProc,AStart,AEnd:String):String;
var i:integer;
begin
//create_frame{vrs;default;300;200;default}  //x;xx;sss#aa|ss|qq|a;xx;x
i:=AnsiPos(AStart,AProc);
result:=trim(copy(AProc,1,i-1 ));
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_GetSepCount(ATrimProc,ASep:String):integer;
var i,ii,iii:integer;
begin
//create_frame{vrs;default;300;200;default}  //x;xx;sss#aa|ss|qq|a;xx;x
iii:=0;
i:=length(ATrimProc);
for ii:=1 to i do
begin
if copy(ATrimProc,ii,1)=ASep then
iii:=iii+1;
end;
result:=iii+1;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_GetProcList(AProc,AStart,AEnd,ASep:String;AList:TStringList):TStringList;
var i,ii,c,x:integer;
    s:string;
    l:tstringlist;
begin
//create_frame{vrs;default;300;200;default}  //x;xx;sss#aa|ss|qq|a;xx;x
if( AStart <> '' )and (AEnd <> '' )then begin
i:=AnsiPos(AStart,AProc);
ii:=AnsiPos(AEnd,AProc);
s:=trim(copy(AProc,i+1,(ii-1)-i ));  end;
////end internal
if( AStart = '' )and (AEnd = '' )then begin
s:=trim(AProc);
end;
////end internal
l:=tstringlist.create;
//vrs;default;300;200;default
c:=0;
ii:=0;
for x:=1 to length(s) do
begin
if x=length(s) then begin l.add(trim(copy(s,ii+1,length(s)))) ;  break;end;
if copy(s,x,1)=ASep then begin
c:=c+1;
if c = 1 then l.add(trim(copy(s,1,x-1))) ;
if c <> 1 then l.add(trim(copy(s,ii+1,x-1-ii))) ;
ii:=x;
end;
end;//for x:=1 to length(s) do
AList.assign(l);
result:=AList;
l.free;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_GetParamPos(AProc,AStart,AEnd,ASep,AParam:String):Integer;
var

    l:TStringlist;
begin
//create_frame{vrs;default;300;200;default}  //x;xx;sss#aa|ss|qq|a;xx;x
l:=TStringlist.create;
l:=CRS_GetProcList(AProc,AStart,AEnd,ASep,l);

result:=l.IndexOf(AParam)+1;

l.free;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_GetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer):String;
var    l:TStringlist;
begin
//create_frame{vrs;default;300;200;default}  //x;xx;sss#aa|ss|qq|a;xx;x
l:=TStringlist.create;
l:=CRS_GetProcList(AProc,AStart,AEnd,ASep,l);
result:=l.strings[APos-1];
l.free;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_SetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer;ASetStr:String):string;
var    l:TStringlist;
s:string;
i:integer;
begin
//create_frame{vrs;default;300;200;default}  //x;xx;sss#aa|ss|qq|a;xx;x
l:=TStringlist.create;
l:=CRS_GetProcList(AProc,AStart,AEnd,ASep,l);
l[APos-1]:=ASetStr;
s:=CRS_GetProcName( AProc,AStart,AEnd)+AStart;
for i:=0 to l.count-1 do
begin
if i<>l.count-1 then
s:=s+l[i]+ ASep;
if i=l.count-1 then
s:=s+l[i]+ AEnd;
end;
result:=s;
l.free;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_GetParamValueList(AProc,AStart,AEnd,ASep:String;APos:Integer;AParamValueSep:String;AList:TStringList):TStringList;
var
   s:string;
    l:TStringlist;
begin
// create_frame{vrs;default;300;200;default}  //x;xx;sss#aa|ss|qq|a;xx;x
l:=TStringlist.create;
l:=CRS_GetProcList(AProc,AStart,AEnd,ASep,l);
s:=l.strings[APos-1];
l.Clear;
l:=CRS_GetProcList(s,'','',AParamValueSep,l);
AList.assign(l);
result:=AList;
l.free;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_GETFileRecord(APASSFILENAME:STRING):TFILERecord;
var
  i:integer;
  TEMPLst:tstringlist;
  FILERecord:TFILERecord;
  Pinfo:pfileinfo;
  SR:tSearchRec;
  linestr:string;
begin
result:=FILERecord;
linestr:='';
Pinfo:=nil;
TEMPLst:=tstringlist.create;
try
if FindFirst(APASSFILENAME, faAnyFile or faReadOnly Or faHidden Or faSysFile Or faDirectory, SR) = 0 
then  Pinfo:=AllocFileInfo(SR);
finally
FindClose(SR);
end;

 
if Pinfo=nil then exit;


if (Pinfo.stat.st_mode and  (S_IFSOCK))<>0 then linestr :=(' is it a socket');
if ((Pinfo.stat.st_mode and (S_IfREG))<>0) then linestr :=(' is it a regular file');   
if ((Pinfo.stat.st_mode and (S_IfDIR))<>0) then  linestr :=(' is it a directory');
if (Pinfo.stat.st_mode and  (S_IfCHR))<>0 then linestr :=(' is it a character device');
if (Pinfo.stat.st_mode and  (S_IFIFO))<>0 then linestr :=(' is it a fifo');

if ((Pinfo.sr.attr and (faSysFile)))<>0 then 				
begin
if (Pinfo.stat.st_mode and (S_IfREG)<>0) and (Pinfo.LinkTarget<>'')then linestr :=(' is it a symbolic link to a regular file'+
           ' ---> '+Pinfo.LinkTarget);
if (Pinfo.stat.st_mode and (S_IfDIR)<>0) and (Pinfo.LinkTarget<>'') then linestr :=(' is it a symbolic link to a directory'+
           ' ---> '+Pinfo.LinkTarget);
if Pinfo.LinkTarget='' then linestr :=(' is it a special file');  
end;

(******************************)
FILERecord.file_type:=linestr;
FILERecord.link_filename:=Pinfo.LinkTarget;
(******************************) 
FILERecord.file_mode:=0;

 if (Pinfo.stat.st_mode and (S_ISUID))<>0 
        then begin FILERecord.setUID:=true;FILERecord.file_mode:=FILERecord.file_mode+4000; end else FILERecord.setUID:=false;// 04000
 if (Pinfo.stat.st_mode and S_ISGID)<>0 
        then begin FILERecord.setGID:=true;FILERecord.file_mode:=FILERecord.file_mode+2000; end  else FILERecord.setGID:=false;// 02000
 if (Pinfo.stat.st_mode and S_ISVTX)<>0 
        then begin FILERecord.setSticky:=true;FILERecord.file_mode:=FILERecord.file_mode+1000;  end  else FILERecord.setSticky:=false;// 01000
 if (Pinfo.stat.st_mode and S_IRUSR)<>0 
        then begin FILERecord.owner_R:=true;FILERecord.file_mode:=FILERecord.file_mode+400;  end  else FILERecord.owner_R:=false;// 00400
 if (Pinfo.stat.st_mode and S_IWUSR)<>0 
        then begin FILERecord.owner_W:=true;FILERecord.file_mode:=FILERecord.file_mode+200;  end  else FILERecord.owner_W:=false;// 00200
 if (Pinfo.stat.st_mode and S_IXUSR)<>0 
        then begin FILERecord.owner_X:=true;FILERecord.file_mode:=FILERecord.file_mode+100;  end  else FILERecord.owner_X:=false;// 00100
 if (Pinfo.stat.st_mode and S_IRGRP)<>0 
        then begin FILERecord.group_R:=true;FILERecord.file_mode:=FILERecord.file_mode+40;  end  else FILERecord.group_R:=false;// 00040
 if (Pinfo.stat.st_mode and (S_IWGRP))<>0 
        then begin FILERecord.group_W:=true;FILERecord.file_mode:=FILERecord.file_mode+20;  end  else FILERecord.group_W:=false;// 00020
 if (Pinfo.stat.st_mode and S_IXGRP)<>0 
        then begin FILERecord.group_X:=true;FILERecord.file_mode:=FILERecord.file_mode+10;  end  else FILERecord.group_X:=false;// 00010
 if (Pinfo.stat.st_mode and S_IROTH)<>0 
        then begin FILERecord.others_R:=true;FILERecord.file_mode:=FILERecord.file_mode+4;  end  else FILERecord.others_R:=false;// 00004
 if (Pinfo.stat.st_mode and S_IWOTH)<>0 
        then begin FILERecord.others_W:=true;FILERecord.file_mode:=FILERecord.file_mode+2;  end  else FILERecord.others_W:=false;// 00002
 if (Pinfo.stat.st_mode and S_IXOTH)<>0 
        then begin FILERecord.others_X:=true;FILERecord.file_mode:=FILERecord.file_mode+1;  end  else FILERecord.others_X:=false;// 00001
        

TEMPLst.loadfromfile('/etc/passwd');
for i:=0 to TEMPLst.count-1 do
begin
 if CRS_GetParamAtPos('{'+TEMPLst.strings[i]+'xxxx}','{','}',':',3)=inttostr(Pinfo.stat.st_uid) then 
   begin
     FILERecord.owner_name:=CRS_GetParamAtPos('{'+TEMPLst.strings[i]+'xxxx}','{','}',':',1);
     TEMPLst.clear;
     break;
   end;
end;
TEMPLst.loadfromfile('/etc/group');
for i:=0 to TEMPLst.count-1 do
begin
 if CRS_GetParamAtPos('{'+TEMPLst.strings[i]+'xxxx}','{','}',':',3)=inttostr(Pinfo.stat.st_gid) then 
   begin
     FILERecord.owner_group_name:=CRS_GetParamAtPos('{'+TEMPLst.strings[i]+'xxxx}','{','}',':',1);
     TEMPLst.clear;
     break;
   end;
end;
TEMPLst.free;

FILERecord.group_ID:=Pinfo.stat.st_gid;
FILERecord.owner_ID:=Pinfo.stat.st_uid;
FILERecord.file_SIZE:=Pinfo.stat.st_size;
FILERecord.change_Time:=DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_ctime)),8));
FILERecord.access_Time:=DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_atime)),8));
FILERecord.modified_Time:=DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_mtime)),8));

result:=FILERecord;

end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_PrintFileDESC(APASSFILENAME:STRING):String;
var 
  Pinfo:pfileinfo;
  linestr:string;
  SR:tSearchRec;
begin
result:='';
linestr:='';
Pinfo:=nil;

try
if FindFirst(APASSFILENAME, faAnyFile or faReadOnly Or faHidden Or faSysFile Or faDirectory, SR) = 0 
then  Pinfo:=AllocFileInfo(SR);
finally
FindClose(SR);
end;

if Pinfo=nil then exit;

if (Pinfo.stat.st_mode and  (S_IFSOCK))<>0 then linestr :=(' is it a socket');
if ((Pinfo.stat.st_mode and (S_IfREG))<>0) then linestr :=(' is it a regular file');   
if ((Pinfo.stat.st_mode and (S_IfDIR))<>0) then  linestr :=(' is it a directory');
if (Pinfo.stat.st_mode and  (S_IfCHR))<>0 then linestr :=(' is it a character device');
if (Pinfo.stat.st_mode and  (S_IFIFO))<>0 then linestr :=(' is it a fifo');

if ((Pinfo.sr.attr and (faSysFile)))<>0 then 				
begin
if (Pinfo.stat.st_mode and (S_IfREG)<>0) and (Pinfo.LinkTarget<>'')then 
             linestr :=(' is it a symbolic link to a regular file'+' ---> '+Pinfo.LinkTarget);
if (Pinfo.stat.st_mode and (S_IfDIR)<>0) and (Pinfo.LinkTarget<>'') then 
             linestr :=(' is it a symbolic link to a directory'+' ---> '+Pinfo.LinkTarget);
if Pinfo.LinkTarget='' then linestr :=(' is it a special file');  
end;

result:=linestr;

end;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

function TPClass_Command_RedStone.CRS_PrintFileDETAIL(APASSFILENAME:STRING):String;
var 
  i:integer;
  Pinfo:pfileinfo;
  linestr:string;
  SR:tSearchRec;
  TEMPLst:tstringlist;
begin

result:='';
linestr :='';
Pinfo:=nil;
TEMPLst:=tstringlist.create;

try
if FindFirst(APASSFILENAME,  faAnyFile or faReadOnly Or faHidden Or faSysFile Or faDirectory, SR) = 0 
then  Pinfo:=AllocFileInfo(SR);
finally
FindClose(SR);
end;

if Pinfo=nil then exit;


TEMPLst.loadfromfile('/etc/passwd');
for i:=0 to TEMPLst.count-1 do
begin
 if CRS_GetParamAtPos('{'+TEMPLst.strings[i]+'xxxx}','{','}',':',3)=inttostr(Pinfo.stat.st_uid) then 
   begin
     linestr :=linestr+('owner    --->  '+ 
                  CRS_GetParamAtPos('{'+TEMPLst.strings[i]+'xxxx}','{','}',':',1) +#13#10);
     TEMPLst.clear;
     break;
   end;
end;

TEMPLst.clear;
TEMPLst.loadfromfile('/etc/group');
for i:=0 to TEMPLst.count-1 do
begin
 if CRS_GetParamAtPos('{'+TEMPLst.strings[i]+'xxxx}','{','}',':',3)=inttostr(Pinfo.stat.st_gid) then 
   begin
     linestr :=linestr+('group of owner    --->  '+ 
               CRS_GetParamAtPos('{'+TEMPLst.strings[i]+'xxxx}','{','}',':',1) +#13#10);
     TEMPLst.clear;
     break;
   end;
end;
TEMPLst.free;



linestr :=linestr+('user ID of owner    --->  '+ inttostr(Pinfo.stat.st_uid) +#13#10);
linestr :=linestr+('group ID of owner    --->  '+ inttostr(Pinfo.stat.st_gid) +#13#10);

linestr :=linestr+('time of last access        --->  '+ 
                  DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_atime)),8))+#13#10);
linestr :=linestr+('time of last modification  --->  '+ 
                  DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_mtime)),8))+#13#10);
linestr :=linestr+('time of last change        --->  '+ 
                  DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_ctime)),8))+#13#10);

linestr :=linestr+('total size, in bytes    --->  '+ inttostr(Pinfo.stat.st_size)+' bytes' +#13#10);

 if (Pinfo.stat.st_mode and (S_ISUID))<>0 then linestr :=linestr+('is set UID bit'+#13#10);
 if (Pinfo.stat.st_mode and S_ISGID)<>0 then linestr :=linestr+(  'is set GID bit'+#13#10);
 if (Pinfo.stat.st_mode and S_ISVTX)<>0 then linestr :=linestr+(  'is sticky bit'+#13#10);
 if (Pinfo.stat.st_mode and S_IRUSR)<>0 then linestr :=linestr+(  'owner has read permission'+#13#10);
 if (Pinfo.stat.st_mode and S_IWUSR)<>0 then linestr :=linestr+(  'owner has write permission'+#13#10);
 if (Pinfo.stat.st_mode and S_IXUSR)<>0 then linestr :=linestr+(  'owner has execute permission'+#13#10);
 if (Pinfo.stat.st_mode and S_IRGRP)<>0 then linestr :=linestr+(  'group has read permission'+#13#10);
 if (Pinfo.stat.st_mode and (S_IWGRP))<>0 then linestr :=linestr+('group has write permission'+#13#10);
 if (Pinfo.stat.st_mode and S_IXGRP)<>0 then linestr :=linestr+(  'group has execute permission'+#13#10);
 if (Pinfo.stat.st_mode and S_IROTH)<>0 then linestr :=linestr+(  'others have read permission'+#13#10);
 if (Pinfo.stat.st_mode and S_IWOTH)<>0 then linestr :=linestr+(  'others have write permisson'+#13#10);
 if (Pinfo.stat.st_mode and S_IXOTH)<>0 then linestr :=linestr+(  'others have execute permission'+#13#10);
 
//memo1.lines.add('device = stat.st_dev    --->  '+ inttostr(pf.stat.st_dev));
linestr :=linestr+('device    --->  '+ inttostr(Pinfo.stat.st_dev)+#13#10);
linestr :=linestr+( 'inode    --->  '+inttostr(Pinfo.stat.st_ino)+#13#10);
linestr :=linestr+( 'protection    --->  '+inttostr(Pinfo.stat.st_mode)+#13#10);
linestr :=linestr+('number of hard links    --->  '+ inttostr(Pinfo.stat.st_nlink)+#13#10);
linestr :=linestr+('device type (if inode device)    --->  '+ inttostr(Pinfo.stat.st_rdev) +#13#10);
linestr :=linestr+('blocksize for filesystem I/O    --->  '+ inttostr(Pinfo.stat.st_blksize) +#13#10);
linestr :=linestr+('number of blocks allocated    --->  '+  inttostr(Pinfo.stat.st_blocks)+#13#10);
linestr :=linestr+('stat.__pad1    --->  '+  inttostr(Pinfo.stat.__pad1) +#13#10);
linestr :=linestr+('stat.__pad2    --->  '+  inttostr(Pinfo.stat.__pad2) +#13#10);




//linestr :=linestr+('time created               --->  '+ 
//    DatetimetoStr(FileDateToDateTime(FileAge(APASSFILENAME)))+#13#10);

//DateTime:= IncHour(UnixToDateTime(FileAge(APASSFILENAME)),8);
// linestr :=linestr+('TIME using DateTimetoStr(DateTime)       ---->  '+DateTimetoStr(DateTime)+#13#10);


result:=linestr;

 { The following flags are defined for the st_mode field

 S_IFMT	 0170000 bitmask for the file type bitfields
 S_IFSOCK	 0140000 socket
 S_IFLNK	 0120000 symbolic link
 S_IFREG	 0100000 regular file
 S_IFBLK	 0060000 block device
 S_IFDIR	 0040000 directory
 S_IFCHR	 0020000 character device
 S_IFIFO	 0010000 fifo
 S_ISUID	 0004000 set UID bit
 S_ISGID	 0002000 set GID bit (see below)
 S_ISVTX	 0001000 sticky bit (see below)
 S_IRWXU	 00700	 mask for file owner permissions
 
 S_IRUSR	 00400	 owner has read permission
 S_IWUSR	 00200	 owner has write permission
 S_IXUSR	 00100	 owner has execute permission
 S_IRWXG	 00070	 mask for group permissions
 
 S_IRGRP	 00040	 group has read permission
 S_IWGRP	 00020	 group has write permission
 S_IXGRP	 00010	 group has execute permission
 S_IRWXO	 00007	 mask for permissions for others (not in group)
 
 S_IROTH	 00004	 others have read permission
 S_IWOTH	 00002	 others have write permisson
 S_IXOTH	 00001	 others have execute permission

 The set GID bit (S_ISGID) has several special uses: For a directory it
 indicates that	BSD semantics is to be used for that directory: files
 created there inherit their group ID from the directory, not from the
 effective gid of the creating process, and directories created there
 will also get the S_ISGID bit set. For a file that does not have the
 group execution	 bit (S_IXGRP) set, it indicates mandatory file/record
 locking.

 The sticky bit (S_ISVTX) on a directory means that a	file in that
 directory can be renamed or deleted only by the owner of the file, by
 the owner of the directory, and by root.
 The following POSIX macros are defined to check the file type:

	 S_ISREG(m) is it a regular file?

	 S_ISDIR(m) directory?

	 S_ISCHR(m) character device?

	 S_ISBLK(m) block device?

	 S_ISFIFO(m) fifo?

	 S_ISLNK(m) symbolic link? (Not in POSIX.1-1996.)

	 S_ISSOCK(m) socket? (Not in POSIX.1-1996.)


}



end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetGuid:String;
var GD:TGUID;GDStr,GDResult:string;HRS: HResult;
begin
result:='';
GDResult:='';
HRS:=CreateGUID(GD);
GDResult:=guidtostring(GD);
delete(GDResult,1,1);
delete(GDResult,length(GDResult),1);
result:=GDResult;
//l.savetofile('/'+GDStr);

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Function TPClass_Command_RedStone.CRS_CheckIsLink(APASSSOURCE:String):Boolean;
var Pinfo:PFileInfo;
begin
result:=false;
(*
if (not fileexists(APASSSOURCE)) or (not directoryexists(APASSSOURCE)) then
begin
exit;
end;
*)
Pinfo:=CRS_GetFilePInfo(APASSSOURCE);
//if Pinfo.linktarget<>'' then
if (Pinfo.sr.Attr and faSymLink <> 0)
//or (fileexists(APASSSOURCE))
then 
result:=true;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_CheckFileList(APASSList:TStringLIST);
var SORTlst,SORTlst2:TStrings;i:integer;tempstr:string;WithDup,IGNORE:Boolean;

function AskDupdlgbox:boolean;
begin
result:=false;
if MessageDlg ('Duplicate filename entry found , '+#13#10+
            'treat filelist with duplicate filename entries ?'+#13#10+#13#10
                  , mtConfirmation, [mbOK,mbNO], 0, mbOK)=mrOK then result:=true;

end;

 begin

WithDup:=true;
IGNORE:=false;

SORTlst:=TStringLIST.create;
SORTlst.assign(APASSList);
APASSList.clear;
//APASSList.Sorted:=true;
//APASSList.CaseSensitive:=true;
 //APASSList.Duplicates:=dupIgnore;
 
for i:=0 to SORTlst.count-1 do 
begin
if ((trim(SORTlst[i]))='')or
(AnsiPos('*',SORTlst[i])>0)
 then continue;
tempstr:='';
tempstr:=trim(SORTlst[i]);


if not IsDelimiter('/',tempstr,1)then 
begin


if CRS_CheckIsLink(getcurrentdir+'/'+tempstr)then
begin
if IGNORE<>true then
//if LstCheckDup(APASSList,tempstr,i)=true then
if APASSList.indexof(tempstr)>-1 then
begin
if AskDupdlgbox=false then WithDup:=false;
IGNORE:=true;
 end;                 
if (APASSList.indexof(tempstr)<0)or(WithDup=true)then
//APASSList.add(getcurrentdir+'/'+tempstr);
APASSList.add(tempstr);
continue;
end;
(****************************************)
if (directoryexists(getcurrentdir+'/'+tempstr))or(fileexists(getcurrentdir+'/'+tempstr)) then
begin
if IGNORE<>true then
//if LstCheckDup(APASSList,tempstr,i)=true then
if APASSList.indexof(tempstr)>-1 then
begin
if AskDupdlgbox=false then begin WithDup:=false;end;
IGNORE:=true;
 end;                 
if (APASSList.indexof(tempstr)<0)or(WithDup=true)then

//APASSList.add(getcurrentdir+'/'+tempstr);
APASSList.add(tempstr);
continue;
end; 

continue;
(****************************************)

end;
if  (AnsiPos('/',tempstr)=1)then 
begin
(********************************************)

if CRS_CheckIsLink(tempstr)then
begin
if IGNORE<>true then
//if LstCheckDup(APASSList,tempstr,i)=true then
if APASSList.indexof(tempstr)>-1 then
begin
if AskDupdlgbox=false then WithDup:=false;
IGNORE:=true;
 end;                      
if (APASSList.indexof(tempstr)<0)or(WithDup=true)then

APASSList.add(tempstr);
continue;
end;
(********************************************)
if (directoryexists(tempstr))or(fileexists(tempstr)) then
begin
if IGNORE<>true then
//if LstCheckDup(APASSList,tempstr,i)=true then
if APASSList.indexof(tempstr)>-1 then
begin
if AskDupdlgbox=false then WithDup:=false;
IGNORE:=true;
end;                        
if (APASSList.indexof(tempstr)<0)or(WithDup=true)then
APASSList.add(tempstr);
continue;
end;

continue;
end;
end;
//SORTlst.clear;
//SORTlst.add(getcurrentdir);
SORTlst.free;
//CRS_DEBUG(APASSList.text,'/xx11112222');  
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_CheckFileListIndexOfName(APASSList:TStringlist;index:integer);
var SORTlst,SORTlst2:TStrings;i:integer;tempstr:string;
 begin


SORTlst2:=TStringLIST.create; 
SORTlst:=TStringLIST.create;
 SORTlst.assign(APASSList);
  SORTlst2.assign(APASSList);
 APASSList.clear;
APASSList.Sorted:=true;
APASSList.CaseSensitive:=true;
 APASSList.Duplicates:=dupIgnore;
 
for i:=0 to SORTlst.count-1 do 
begin

tempstr:=CRS_GetParamAtPos('{'+SORTlst[i]+'}','{','}','=',index);

if (trim(tempstr))='' then continue;
if  (AnsiPos('/',tempstr)=0)or (AnsiPos('/',tempstr)>1)then 
begin
if CRS_CheckIsLink(getcurrentdir+'/'+tempstr)then
begin

APASSList.add(stringreplace(SORTlst[i],tempstr,getcurrentdir+'/'+tempstr,[]));
continue;
end;
//if (directoryexists(getcurrentdir+'/'+tempstr))or(fileexists(getcurrentdir+'/'+tempstr)) then
if (access(pchar(getcurrentdir+'/'+tempstr),F_OK)<>-1) then
begin

APASSList.add(stringreplace(SORTlst[i],tempstr,getcurrentdir+'/'+tempstr,[]));

continue;
end ;
if (access(pchar(getcurrentdir+'/'+tempstr),F_OK)=-1) then
begin
try
deletefile(CRS_GetParamAtPos('{'+SORTlst[i]+'}','{','}','=',index+1));
//APASSList.add(stringreplace(SORTlst[i],tempstr,getcurrentdir+'/'+tempstr,[]));
except
;
end;

continue;
end ;
continue; 
end;

if  (AnsiPos('/',tempstr)=1)then 
begin
if CRS_CheckIsLink(tempstr)then
begin
APASSList.add(SORTlst[i]);
continue;
end;
//if (directoryexists(tempstr))or(fileexists(tempstr)) then
if (access(pchar(tempstr),F_OK)<>-1) then
begin
APASSList.add(SORTlst[i]);

continue;
end;
if (access(pchar(tempstr),F_OK)=-1) then
begin
try
deletefile(CRS_GetParamAtPos('{'+SORTlst[i]+'}','{','}','=',index+1));
//APASSList.add(stringreplace(SORTlst[i],tempstr,getcurrentdir+'/'+tempstr,[]));
except
;
end;

continue;
end ;
continue; 
end;
end;
SORTlst.free;
SORTlst2.free;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_AFreeForm;
begin
if af<>nil then
begin
af.free;
af:=nil;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_ACreateForm(LABELString:string);

begin 
if AF<>nil then CRS_AFreeForm;
AF:=nil;
al:=nil;
al2:=nil;
aF := TForm.Create (APASS_CALLING_Form);
af.parent:=APASS_CALLING_Form;
af.top:=APASS_CALLING_Form.top+100;
af.left:=APASS_CALLING_Form.left+200;
af.height:=150;
af.width:=420;
af.BorderStyle:=(fbssingle);
af.Color :=11306588;
af.autoscroll:=false;
af.onshow:=AFOnShow;
af.onclose:=AFOnclose;

sp:=tBITBTN.create(af);
sp.parent:=af;
sp.color:=11306588;
sp.top:=af.height-50;
sp.left:=af.width-90;
sp.height:=40;
sp.width:=80;
sp.Font.Color:=clbackground;
sp.Font.Style:= [FSBOLD];
sp.Font.Height:= 13;
SP.caption:='CANCEL';
sp.Font.Name:= 'sans';
sp.OnClick := fileoperationCANCELclick; 
 
sp.enabled:=true;
sp.visible:=true;  



 al:=tlabel.create(af);
al2:=tlabel.create(af);  
al2.autosize:=true;
al.parent:=af;
al2.parent:=af;
al.Top :=28;
al.Font.Style :=[];
al.Caption:=LABELString;   
aF.Show; 

al.Top :=32;
al.Width:=af.width-30;
al.Color :=11306588;
al.Font.Color :=clbackground;
al.Font.size :=24;
al.Font.Name :='courior';
al.Font.Style :=[fsBold];

al2.Top :=sp.top-32;
al2.Font.Color :=clbackground;
al2.Font.Name :='courior';
al2.Font.Style :=[fsBold];
al2.Color :=11306588;
al2.Width:=af.width-30;;
al2.Font.size :=13;
EXIT_File_Operation:=false;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure  TPClass_Command_RedStone.AFOnShow(Sender: TObject);
begin
application.processmessages;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.AFOnClose(Sender: TObject;var Action: TCloseAction);
begin
EXIT_File_Operation:=true;
application.processmessages;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.fileoperationCANCELclick(Sender: TObject); 
begin
EXIT_File_Operation:=true;

application.processmessages;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.RECURSESearchDir(APASSFolder: string; 
                                        APASSFileMask: string; APASSLst: TStringlist);


  procedure RECURSESearchDir2(APASSFolder: string);
  var
    SearchRec: TSearchRec;
  begin
    if FindFirst(APASSFolder + APASSFileMask, faReadOnly Or faHidden Or faArchive 
        Or faSysFile Or fasymlink, SearchRec) = 0 then
      try
        repeat
       // application.processmessages;
          APASSLst.Add(APASSFolder + SearchRec.Name);
        until FindNext(SearchRec) <> 0;
      finally
        FindClose(SearchRec);
      end;
  //  if FindFirst(APASSFolder + '*', faReadOnly Or faHidden Or faSysFile
   if FindFirst(APASSFolder + APASSFileMask, faReadOnly Or faHidden Or faSysFile
       Or faArchive   Or faDirectory Or fasymlink, SearchRec) = 0 then
      try
        repeat
          if ((SearchRec.Attr and faDirectory) <> 0)
              and (SearchRec.Name <> '.')
              and (SearchRec.Name <> '..') then    
                 begin       
               APASSLst.Add(APASSFolder + SearchRec.Name);
               if SearchRec.attr and fasymlink <>0 then continue;
            RECURSESearchDir2(APASSFolder + SearchRec.Name + '/');
           
            end;
        until FindNext(SearchRec) <> 0;
      finally
        FindClose(SearchRec);
      end;
  end;

  begin
 
      if LastDelimiter('/',APASSFolder)<>length(APASSFolder) then APASSFolder:=APASSFolder+'/';

  APASSLst.Add(copy(APASSFolder,1,length(APASSFolder)-1));
    RECURSESearchDir2((APASSFolder));
    

  end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.NoRECURSESearchDir(APASSFolder: string; 
                                        APASSFileMask: string; APASSLst: TStringlist);
                                        
 var   SearchRec: TSearchRec;
  begin
  APASSLst.clear;
   if LastDelimiter('/',APASSFolder)<>length(APASSFolder) then APASSFolder:=APASSFolder+'/';
 // APASSLst.Add(copy(APASSFolder,1,length(APASSFolder)-1));
  
    if FindFirst(APASSFolder + APASSFileMask, faReadOnly Or faHidden  Or faDirectory
        Or faSysFile Or faAnyFile Or fasymlink, SearchRec) = 0 then
//   if FindFirst(APASSFolder + APASSFileMask, faAnyFile, SearchRec) = 0 then
      try
        repeat
          if (SearchRec.Name <> '.') or
              (SearchRec.Name <> '..') then
          APASSLst.Add(APASSFolder + SearchRec.Name);
        until FindNext(SearchRec) <> 0;
      finally
        FindClose(SearchRec);
      end;
 

  end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetGroupNameEntry:string;
var
  AList:tstringlist;
   Group: PGroup;
   i,passwdCount:integer;
   STR:string;
begin
STR:='';
AList:= tstringlist.create;  
AList.loadfromfile('/etc/group');
passwdCount:=AList.count;
AList.free;
setgrent;
try
for i:=0 to passwdCount-1 do
begin
Group:=getgrent;
if Assigned(Group) then
STR:=STR+Group.gr_name+#13#10;
end;
finally
result:=str;
endgrent;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetUserNameEntry:string;
var
STR:string;
  AList:tstringlist;
  Passwd: PPasswordRecord;
   i,passwdCount:integer;
begin
STR:='';
AList:= tstringlist.create;  
AList.loadfromfile('/etc/passwd');
passwdCount:=AList.count;
AList.free;
setpwent;
try
for i:=0 to passwdCount-1 do
begin
Passwd:=getpwent;
 if Assigned(Passwd) then
 STR:=STR+(Passwd^.pw_name)+#13#10; 
end;
finally
result:=str;
endpwent;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetUserName(uid:uid_t):String;
var
  Passwd: PPasswordRecord;
begin
  Result := '';
  Passwd := getpwuid(uid);
  if Assigned(Passwd) then
    Result := Passwd^.pw_name;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetGroupName(gid:gid_t):String;
var
  Group: PGroup;
begin
  Result := '';
  Group := getgrgid(gid);
  if Assigned(Group) then
    Result := Group^.gr_name;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetHumanReadBlockSizeStr(APASSBlockSize:extended):string;
begin
result:=formatfloat('###,###,###,###,###,##0',(APASSBlockSize))+' bytes';//trunc
if APASSBlockSize>1024 then begin
if (APASSBlockSize>1024*1024) then begin
result:=formatfloat('#,###0.00',(APASSBlockSize / (1024*1024)))+' MB';
end else 
begin
result:=formatfloat('#,###0.00',(APASSBlockSize / 1024))+' KB';
end;end;
       
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
Procedure TPClass_Command_RedStone.CRS_GetDirFileListInfo(APASSFileNAME:string;APASSLst:tstringlist);
var DSTR,FSTR,LNKSTR,Pathstr,tempFileSTR:string;Pinfo:Pfileinfo;
i,fint,sint:integer;stat:_stat;
RSTFilelst:tstringlist;SearchRec: TSearchRec;


function PermissionString(Mode:mode_t): string;
  function TestBit(Bit: Cardinal): Char;
  begin
    Result := '-';
    if Mode and Bit = Bit then
      case Bit of
        S_IRUSR, S_IRGRP, S_IROTH:
          Result := 'r';
        S_IWUSR, S_IWGRP, S_IWOTH:
          Result := 'w';
        S_IXUSR, S_IXGRP, S_IXOTH:
          Result := 'x';
      end;
  end;
begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '!!!!';
    Exit;
  end
  else begin
    Result := Result + TestBit(S_IRUSR)+ 
                       TestBit(S_IWUSR)+ 
                       TestBit(S_IXUSR)+ 
                       TestBit(S_IRGRP)+ 
                       TestBit(S_IWGRP)+ 
                       TestBit(S_IXGRP)+ 
                       TestBit(S_IROTH)+ 
                       TestBit(S_IWOTH)+ 
                       TestBit(S_IXOTH);
    (*
    Result := Result + TestBit(S_IWUSR);
    Result := Result + TestBit(S_IXUSR);

    Result := Result + TestBit(S_IRGRP);
    Result := Result + TestBit(S_IWGRP);
    Result := Result + TestBit(S_IXGRP);

    Result := Result + TestBit(S_IROTH);
    Result := Result + TestBit(S_IWOTH);
    Result := Result + TestBit(S_IXOTH);
    *)
  end;
end;
function GetFileType(Mode:mode_t): string;
  function TestBit(Bit: Cardinal): String;
  begin
    Result := '';
    if Mode and Bit = Bit then
      case Bit of
        S_IFSOCK:
       	  Result := 'S' ;//socket
        S_IFLNK:	 
          Result := 'L'  ;//symbolic link
        S_IFREG:	 
          Result := 'F'  ;//regular file
        S_IFBLK:	 
          Result := 'B'  ;//block device
        S_IFDIR:	 
          Result := '[DIR]'  ;//directory
        S_IFCHR:	 
          Result := 'C'  ;//character device
        S_IFIFO:	 
          Result := 'I'  ;//fifo

      end;
  end;
begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '!!!!';
    Exit;
  end
  else begin
     Result := Result+TestBit(S_IFDIR)+
                      TestBit(S_IFCHR)+
                      TestBit(S_IFIFO)+
                      TestBit(S_IFLNK)+
                      TestBit(S_IFREG);
     (*
     Result := Result+TestBit(S_IFCHR);
     Result := Result+TestBit(S_IFIFO);
     Result := Result+TestBit(S_IFLNK);
     Result := Result+TestBit(S_IFREG);
     *)
    if TestBit(S_IFSOCK)<>'' then Result := 'S';
    if TestBit(S_IFBLK)<>'' then Result := 'B';
  end;
end;
function PermissionMASK(Mode:mode_t): string;
var tempINT:integer;
  function TestBit(Bit: Cardinal): integer;
  begin
    Result := 0;
    if Mode and Bit = Bit then
      case Bit of
        S_IFSOCK:
       	  Result := 0140000 ;//socket
        S_IFLNK:	 
          Result := 0120000 ;//symbolic link
        S_IFREG:	 
          Result := 0100000 ;//regular file
        S_IFBLK:	 
          Result := 0060000 ;//block device
        S_IFDIR:	 
          Result := 0040000 ;//directory
        S_IFCHR:	 
          Result := 0020000 ;//character device
        S_IFIFO:	 
          Result := 0010000 ;//fifo
        S_IRUSR:
          Result := 400; 
        S_IRGRP:
          Result := 40;  
        S_IROTH:
          Result := 4; 
        S_IWUSR:
          Result := 200;  
        S_IWGRP:
          Result := 20;  
        S_IWOTH:
          Result := 2; 
        S_IXUSR:
          Result := 100;  
        S_IXGRP:
          Result := 10;  
        S_IXOTH:
          Result := 1;
        S_ISUID:
          Result := 4000;
        S_ISGID:
          Result := 2000; 
        S_ISVTX:
          Result := 1000;  
      end;
  end;
begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '!!!!';
    Exit;
  end
  else begin
  tempINT:=0;
    tempINT := tempINT + TestBit(S_IFSOCK)+ 
                         TestBit(S_IFLNK)+ 
                         TestBit(S_IFREG)+ 
                         TestBit(S_IFBLK)+ 
                         TestBit(S_IFDIR)+ 
                         TestBit(S_IFCHR)+ 
                         TestBit(S_IFIFO)+ 
                         TestBit(S_IRUSR)+ 
                         TestBit(S_IWUSR)+ 
                         TestBit(S_IXUSR)+ 
                         TestBit(S_IRGRP)+ 
                         TestBit(S_IWGRP)+ 
                         TestBit(S_IXGRP)+ 
                         TestBit(S_IROTH)+ 
                         TestBit(S_IWOTH)+ 
                         TestBit(S_IXOTH)+ 
                         TestBit(S_ISUID)+ 
                         TestBit(S_ISGID)+ 
                         TestBit(S_ISVTX);
    (*
    tempINT := tempINT + TestBit(S_IFLNK);
    tempINT := tempINT + TestBit(S_IFREG);
    tempINT := tempINT + TestBit(S_IFBLK);
    tempINT := tempINT + TestBit(S_IFDIR);
    tempINT := tempINT + TestBit(S_IFCHR);
    tempINT := tempINT + TestBit(S_IFIFO);
     
    tempINT := tempINT + TestBit(S_IRUSR);
    tempINT := tempINT + TestBit(S_IWUSR);
    tempINT := tempINT + TestBit(S_IXUSR);

    tempINT := tempINT + TestBit(S_IRGRP);
    tempINT := tempINT + TestBit(S_IWGRP);
    tempINT := tempINT + TestBit(S_IXGRP);

    tempINT := tempINT + TestBit(S_IROTH);
    tempINT := tempINT + TestBit(S_IWOTH);
    tempINT := tempINT + TestBit(S_IXOTH);
    tempINT := tempINT + TestBit(S_ISUID);
    tempINT := tempINT + TestBit(S_ISGID);
    tempINT := tempINT + TestBit(S_ISVTX);
    *)
 
  result:=inttostr(tempINT);
  end;
end;
begin
FSTR:='';
DSTR:='';
LNKSTR:='';
if not directoryexists(APASSFileNAME)then exit;
RSTFilelst:=tstringlist.create;
APASSLst.sorted:=true;
RSTFilelst.sorted:=true;
try
////////////////////////////////////////////////////////////////
 
//templst.delete(templst.indexof(pathstr+'.'));
//templst.delete(templst.indexof(pathstr+'..'));

   if LastDelimiter('/',APASSFileNAME)<>length(APASSFileNAME) then APASSFileNAME:=APASSFileNAME+'/';
   pathstr:=(APASSFileNAME);
 //   if FindFirst(APASSFileNAME + '*', faReadOnly Or faHidden  Or faDirectory
 //       Or faSysFile Or faAnyFile Or fasymlink, SearchRec) = 0 then
    if FindFirst(APASSFileNAME + '*', 
        faAnyFile Or faDirectory , SearchRec) = 0 then
      try
        repeat
          if (SearchRec.Name ='.') or
              (SearchRec.Name = '..') then continue
              else
             
              begin
             
       //APASSLst.Add(APASSFileNAME + SearchRec.Name);
     //  tempFileSTR:=(APASSFileNAME + SearchRec.Name);
      // if (tempFileSTR='') or (tempFileSTR=pathstr+'.')or
           //   (tempFileSTR=pathstr+'..')then continue;
LNKSTR:='';
//Pinfo:=nil;
//Pinfo:=CRS_GetFilePInfo(tempFileSTR);
Pinfo:=AllocFileInfo(SearchRec);
stat:=Pinfo.stat;
if (SearchRec.Attr and faSymLink <> 0) then 
if (access(pchar(Pinfo.linktarget),R_OK)<>-1)then LNKSTR:=Pinfo.linktarget 
else LNKSTR:='Broken file link'; 
if (SearchRec.Attr and faDirectory <> 0) then 

APASSLst.add(      SearchRec.Name+'='+
            '"'+GetFileType(stat.st_mode)+'"'+'='+
            '"'+LNKSTR+'"'+'='+
          //  '"'+inttostr(Pinfo.sr.size)+'"'+'='+
            '"'+CRS_GetHumanReadBlockSizeStr(SearchRec.size)+'"'+'='+
            '"'+inttostr(stat.st_blksize)+'"'+'='+
            '"'+PermissionMASK(stat.st_mode)+'"'+'='+
            '"'+PermissionString(stat.st_mode)+'"'+'='+
            '"'+CRS_GetUserName(stat.st_uid)+'"'+'='+
            '"'+CRS_GetGroupName(stat.st_gid)+'"'+'='+
            //(*
            '"'+DatetimetoStr(FileDateToDateTime(stat.st_mtime))+'"'+'='+
            '"'+DatetimetoStr(FileDateToDateTime(stat.st_atime))+'"'+'='+
            '"'+DatetimetoStr(FileDateToDateTime(stat.st_ctime))+'"'
            //*)
            (*
            '"'+DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_mtime)),8))+'"'+'='+
            '"'+DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_atime)),8))+'"'+'='+
            '"'+DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_ctime)),8))+'"'+#13#10
            *)
)
else

//templstRET.add(templst[i]+'='+
RSTFilelst.add(     SearchRec.Name+'='+
            '"'+GetFileType(stat.st_mode)+'"'+'='+
            '"'+LNKSTR+'"'+'='+
            '"'+CRS_GetHumanReadBlockSizeStr(SearchRec.size)+'"'+'='+
            //'"'+inttostr(Pinfo.sr.size)+'"'+'='+
            '"'+inttostr(stat.st_blksize)+'"'+'='+
            '"'+PermissionMASK(stat.st_mode)+'"'+'='+
            '"'+PermissionString(stat.st_mode)+'"'+'='+
            '"'+CRS_GetUserName(stat.st_uid)+'"'+'='+
            '"'+CRS_GetGroupName(stat.st_gid)+'"'+'='+
            //(*
            '"'+DatetimetoStr(FileDateToDateTime(stat.st_mtime))+'"'+'='+
            '"'+DatetimetoStr(FileDateToDateTime(stat.st_atime))+'"'+'='+
            '"'+DatetimetoStr(FileDateToDateTime(stat.st_ctime))+'"'
            //*)
            (*
            '"'+DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_mtime)),8))+'"'+'='+
            '"'+DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_atime)),8))+'"'+'='+
            '"'+DatetimetoStr(IncHour((UnixToDateTime(Pinfo.stat.st_ctime)),8))+'"'+#13#10;
            *)
            
);
              end;
        until FindNext(SearchRec) <> 0;
      finally
        FindClose(SearchRec);
      end;
 
//////////////////////////////////////////////////////////////////
//NoRECURSESearchDir(APASSFileNAME,'*',templst);


//templst.delete(templst.count-1);

APASSLst.sorted:=false;
//RSTFilelst.sorted:=false;

for i:=0 to RSTFilelst.count-1 do
APASSLst.add(RSTFilelst[i]);
//APASSLst.insert(0,Pathstr+'.=');
//APASSLst.insert(1,Pathstr+'..=');
APASSLst.insert(0,'.=');
APASSLst.insert(1,'..=');


if RSTFilelst<>nil then RSTFilelst.free;

except
if RSTFilelst<>nil then RSTFilelst.free;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetDirFileList(APASSFileNAME:string):string;
var templst:tstringlist;DSTR,FSTR,Pathstr:string;Pinfo:Pfileinfo;
i:integer;
begin
result:='';
FSTR:='';
DSTR:='';
templst:=tstringlist.create;
if not directoryexists(APASSFileNAME)then exit;
NoRECURSESearchDir(APASSFileNAME,'*',templst);

templst.delete(templst.count-1);
Pathstr:=extractfilepath(templst[0]);
for i:=0 to templst.count-1 do
begin
if (extractfilename(templst[i])='.')or (extractfilename(templst[i])='..')then continue;
Pinfo:=CRS_GetFilePInfo(templst[i]);
if (Pinfo.sr.Attr and faDirectory <> 0) then 
DSTR:=DSTR+templst[i]+#13#10 else
FSTR:=FSTR+templst[i]+#13#10;
end;
templst.clear;
templst.text:=DSTR;
templst.sort;

templst.insert(0,Pathstr+'.');
templst.insert(1,Pathstr+'..');

DSTR:=templst.text;
templst.clear;
templst.text:=FSTR;
templst.sort;
FSTR:=templst.text;

result:=DSTR+FSTR;
templst.free;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetDirFileCount(APASSFileNAME:string):integer;
var templst:tstringlist;
begin
result:=0;
templst:=tstringlist.create;
NoRECURSESearchDir(APASSFileNAME,'*',templst);
result:=templst.count-1;
templst.free;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetFilePInfo(APASSFileNAME:string):pfileinfo;
 var
    SearchRec: TSearchRec;Pinfo:pfileinfo;
begin

try
 if FindFirst(APASSFileNAME, faReadOnly Or faHidden or faAnyfile 
        Or faSysFile Or faDirectory Or fasymlink, SearchRec) = 0 then
//        Pinfo:=AllocFileInfo(SearchRec);
//if Assigned(Pinfo) then
//result:=Pinfo;
result:=AllocFileInfo(SearchRec);
finally
  FindClose(SearchRec);
      end; 
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetFileSize(APASSFileNAME:string):integer;
 var
    SearchRec: TSearchRec;
begin
try
 if FindFirst(APASSFileNAME, faReadOnly Or faHidden
        Or faSysFile  Or faDirectory Or fasymlink, SearchRec) = 0 then
result:=SearchRec.size;
finally
  FindClose(SearchRec);
      end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetFileGID(APASSFileNAME:string):gid_t;
 var
    SearchRec: TSearchRec;Pinfo:pfileinfo;
begin
//Pinfo:=nil;
try
 if FindFirst(APASSFileNAME, faReadOnly Or faHidden
        Or faSysFile Or faDirectory Or fasymlink, SearchRec) = 0 then
        Pinfo:=AllocFileInfo(SearchRec);
if Assigned(Pinfo) then
result:=Pinfo.stat.st_gid;
 finally
  FindClose(SearchRec);
      end; 
end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetFileUID(APASSFileNAME:string):uid_t;
 var
    SearchRec: TSearchRec;Pinfo:pfileinfo;
begin
//Pinfo:=nil;
try
 if FindFirst(APASSFileNAME, faReadOnly Or faHidden
        Or faSysFile Or faDirectory, SearchRec) = 0 then
        Pinfo:=AllocFileInfo(SearchRec);
if Assigned(Pinfo) then
result:=Pinfo.stat.st_uid;
finally
  FindClose(SearchRec);
      end; 
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_GetFileMode(APASSFileNAME:string):mode_t;
 var
    SearchRec: TSearchRec;
begin
try
 if FindFirst(APASSFileNAME, faReadOnly Or faHidden
        Or faSysFile Or faDirectory Or fasymlink, SearchRec) = 0 then
result:=SearchRec.mode;
finally
  FindClose(SearchRec);
      end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_DeleteFile(APASSFileNAME:string ):boolean;
//var  Pinfo:pfileinfo;
//linestr:string;lst:tstringlist;

begin

result:=false;
//unlink(pchar(APASSFileNAME));
try
if (access(pchar(APASSFileNAME),F_OK)=0) then
begin
if remove(pchar(APASSFileNAME))<>-1
 then result:=true;
 end else
// if (access(pchar(APASSFileNAME),F_OK)=-1) then
begin
unlink(pchar(APASSFileNAME));
result:=true;
end;

except
exit;
end;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_RMDir(APASSFileNAME:string ):boolean;
var  Pinfo:pfileinfo;
begin
result:=false;
try

if (access(pchar(APASSFileNAME),R_OK)<>-1) then
begin
if remove(pchar(APASSFileNAME))<>-1 then
result:=true;
end else
 if (access(pchar(APASSFileNAME),F_OK)=-1) then
begin
unlink(pchar(APASSFileNAME));
result:=true;
end;
except
result:=false;
exit;
end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_CopyFile(APASSSOURCEFileNAME,APASSDESTFileNAME:string ;
                       DupOwner,DupMode,DoSymLink:boolean):boolean;
var SOURCESTREAM:TMEMORYSTREAM;Pinfo:pfileinfo;
//Amode:mode_t;Auid:uid_t;Agid:gid_t;
begin
result:=false;

SOURCESTREAM:=nil;
if extractfilepath(APASSSOURCEFileNAME)=RS_APP_data_dir+'/.thrash bin/' then
 //if fileexists(APASSDESTFileNAME)then 
 if (access(pchar(APASSDESTFileNAME),R_OK)<>-1) then
begin
result:=true;
exit;
end;

Pinfo:=CRS_GetFilePInfo(APASSSOURCEFileNAME);

(***************************************************************************************)
if DoSymLink=true
then begin
if (access(pchar(APASSSOURCEFileNAME),R_OK)=0)
and (access(pchar(extractfilepath(APASSDESTFileNAME)),R_OK)=0)
then
begin
if symlink(pchar(APASSSOURCEFileNAME), pchar(APASSDESTFileNAME))<>-1 then
result:=true;
end;
exit;
end;
(***************************************************************************************)
try


if (Pinfo.sr.Attr and faSymLink <> 0) then 
begin
//if (access(pchar(Pinfo.linktarget),R_OK)<>-1)
//and (access(pchar(extractfilepath(APASSDESTFileNAME)),R_OK)<>-1)then
//begin
if symlink(pchar(Pinfo.linktarget), pchar(APASSDESTFileNAME))<>-1 then
result:=true;
//end;
exit;
end;
if (Pinfo.sr.Attr and faSysFile <> 0) then 
begin
//if (access(pchar(APASSSOURCEFileNAME),R_OK)<>-1)
//and (access(pchar(extractfilepath(APASSDESTFileNAME)),R_OK)<>-1)then
//begin
if __rename(pchar(APASSSOURCEFileNAME), pchar(APASSDESTFileNAME))<>-1 then
result:=true;
//end;
exit;
end;
SOURCESTREAM:=TMEMORYSTREAM.create;
if fileexists(APASSSOURCEFileNAME)then
begin
//Amode:=CRS_GetFileMode(APASSSOURCEFileNAME);
//Auid:=CRS_GetFileUID(APASSSOURCEFileNAME);
//Agid:=CRS_GetFileGID(APASSSOURCEFileNAME);
SOURCESTREAM.loadfromfile(APASSSOURCEFileNAME);
SOURCESTREAM.savetofile(APASSDESTFileNAME);
if fileexists(APASSDESTFileNAME)then 
begin
if DupMode=true then
if chmod(pchar(APASSDESTFileNAME),CRS_GetFileMode(APASSSOURCEFileNAME))<>-1
 then result:=true;
if DupOwner=true then
if getuid=0 then
begin
if chown(pchar(APASSDESTFileNAME),CRS_GetFileUID(APASSSOURCEFileNAME),CRS_GetFileGID(APASSSOURCEFileNAME ))<>-1
 then result:=true;
end;
if getuid<>0 then 
begin
if chown(pchar(APASSDESTFileNAME),getuid,getgid)<>-1
 then result:=true;
end;
end else 
if fileexists(APASSSOURCEFileNAME)then
if APASSSOURCEFileNAME=APASSDESTFileNAME then
SOURCESTREAM.savetofile(APASSDESTFileNAME);
end;
except
SOURCESTREAM.free;
result:=false;
exit;
end;
if SOURCESTREAM<>nil then SOURCESTREAM.free;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
function TPClass_Command_RedStone.CRS_MkDir(APASSSOURCEFileNAME,APASSDESTFileNAME :string ):boolean;
var Pinfo:pfileinfo;
begin
result:=false;

if extractfilepath(APASSSOURCEFileNAME)=RS_APP_data_dir+'/.thrash bin/' then
 if directoryexists(APASSDESTFileNAME)then 
begin
result:=true;
exit;
end;

try
Pinfo:=CRS_GetFilePInfo(APASSSOURCEFileNAME);
if (Pinfo.sr.Attr and faSymLink <> 0) then 
begin
//if (access(pchar(Pinfo.linktarget),R_OK)<>-1) 
//and (access(pchar(copy(APASSDESTFileNAME,1,LastDelimiter('/',APASSDESTFileNAME))),R_OK)<>-1)then
//begin
if symlink(pchar(Pinfo.linktarget), pchar(APASSDESTFileNAME))<>-1
 then result:=true;
//end;
exit;
end;
if not directoryexists(APASSDESTFileNAME)then 
{$I-}
mkdir(pchar(APASSDESTFileNAME));
{$I+}
 if IOResult <> 0
 then ;

if  APASSSOURCEFileNAME=APASSDESTFileNAME then
exit;




//mknod(pchar(APASSDESTFileNAME),040000,0);
//chown(pchar(APASSDESTFileNAME), uid_t owner, gid_t group);

if directoryexists(APASSDESTFileNAME)then 
begin
if chmod(pchar(APASSDESTFileNAME),CRS_GetFileMode(APASSSOURCEFileNAME))<>-1
 then result:=true;
if getuid=0 then
begin
if chown(pchar(APASSDESTFileNAME),CRS_GetFileUID(APASSSOURCEFileNAME),CRS_GetFileGID(APASSSOURCEFileNAME) )<>-1
 then result:=true;
end;
if getuid<>0 then
begin
if chown(pchar(APASSDESTFileNAME),getuid,getgid )<>-1
 then result:=true;
end;
end ;
except
result:=false;
exit;
end;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_FileCopyMoveR(Mode:integer;APASSSource:String;
                                                    Destination:STRING;OUTLST:TStringlist);
var 
    ii:integer;
    TEMPLST,TEMPDirLST:Tstringlist;
    s1:string;
begin
 { mode  = 1 Or 2   :    1:= copy  2:= move  }
 





 if LastDelimiter('/',Destination)=length(Destination) then 
    delete(Destination,length(Destination),1);
 if LastDelimiter('/',APASSSource)=length(APASSSource) then     
    delete(APASSSource,length(APASSSource),1);
if not directoryexists(APASSSource)then
begin
(***************************************
if CRS_CheckIsLink(APASSSource)then
begin
CRS_CopyFile(APASSSource,
            stringreplace(APASSSource,ExtractFileDir(APASSSource),Destination,[]),true,true,false);
if OUTLST<>nil then OUTLST.add(stringreplace(APASSSource,ExtractFileDir(APASSSource),Destination,[]) ); 
if mode=2 then crs_deletefile(APASSSource);
exit;
end;
****************************************)
CRS_CopyFile(APASSSource,
            stringreplace(APASSSource,ExtractFileDir(APASSSource),Destination,[]),true,true,false);
 
if OUTLST<>nil then OUTLST.add(stringreplace(APASSSource,ExtractFileDir(APASSSource),Destination,[]) ); 
           
if mode=2 then crs_deletefile(APASSSource);
end;

if directoryexists(APASSSource)then
begin
(********************************
if CRS_CheckIsLink(APASSSource)then
begin
CRS_MkDir(APASSSource,stringreplace(APASSSource,ExtractFileDir(APASSSource),Destination,[]));
if OUTLST<>nil then OUTLST.add(APASSSource); 
if mode=2 then crs_rmdir(APASSSource);
exit;
end;
********************************)
TEMPLST:=Tstringlist.create;
TEMPDirLST:=TStringlist.create;

TEMPDirLST.add(APASSSource );
if OUTLST<>nil then OUTLST.add(APASSSource); 
RECURSESearchDir(APASSSource+'/', '*',TEMPLST);
s1:=ExtractFileDir(TEMPLST.strings[0]);
for ii:=0 to TEMPLST.count-1 do
begin
if directoryexists(TEMPLST.strings[ii])then 
CRS_MkDir(TEMPLST.strings[ii],stringreplace(TEMPLST.strings[ii],s1,Destination,[]));
if not directoryexists(TEMPLST.strings[ii])then 
//link(pchar(TEMPLST.strings[ii] ),pchar(stringreplace(TEMPLST[ii],s1,Destination,[]) ) );
CRS_CopyFile(TEMPLST.strings[ii] ,stringreplace(TEMPLST[ii],s1,Destination,[]),true,true,false);
    

end;

TEMPLST.clear;
end;



if mode=2 then 
begin
for ii:=TEMPDirLST.count-1 downto 0 do
crs_rmdir(TEMPDirLST[ii]);
end;

TEMPLST.free;
TEMPDirLST.free;
end;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.CRS_FileDeleteR(APASSSource:String);
var 
   ii:integer;
    TEMPLST:Tstringlist;

begin

 if LastDelimiter('/',APASSSource)=length(APASSSource) then     
    delete(APASSSource,length(APASSSource),1);
    
if CRS_CheckIsLink(APASSSource)then
begin
if not directoryexists(APASSSource)then crs_deletefile(APASSSource);
if directoryexists(APASSSource)then crs_rmdir(APASSSource);

exit;
end;


if not directoryexists(APASSSource)then
begin
 crs_deletefile(APASSSource);

end;

if directoryexists(APASSSource)then
begin
TEMPLST:=Tstringlist.create;
RECURSESearchDir(APASSSource+'/', '*',TEMPLST);
for ii:=TEMPLST.count-1  downto 0 do
begin
if not directoryexists(TEMPLST.strings[ii])then crs_deletefile(TEMPLST.strings[ii]);
if directoryexists(TEMPLST.strings[ii])then crs_rmdir(TEMPLST.strings[ii]);

end;

TEMPLST.free;
end;




end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TPClass_Command_RedStone.X_CRS_FileCopyMoveR(Mode:integer;APASSLst:TStrings;
                                                    Destination:STRING;OUTLST:TStringlist);
var i,ii,ID,ID2:integer;IGNOREALL:boolean;TEMPLST,TEMPDirLST:Tstringlist;
 s1,s2,s3:string;instr2,instr1,instr:string;
begin

 { mode  = 1 Or 2   :    1:= copy  2:= move  }
 


IGNOREALL:=false; 
TEMPLST:=Tstringlist.create;
TEMPDirLST:=TStringlist.create;

for i:=0 to APASSLst.count-1 do
begin 

if fileexists(APASSLst.strings[i]) then begin
if APASSLst.strings[i]=RS_APP_data_dir+'/.thrash bin'+'/.thrashlog' then continue;
instr1:=instr1+APASSLst.strings[i]+#13#10;
instr:=instr+APASSLst.strings[i]+' ';
end;
end;

if( mode=1)then instr2:='Are you sure you want to copy ';
if( mode=2)then instr2:='Are you sure you want to move ';
        
if Destination<>RS_APP_data_dir+'/.thrash bin'+'/'then
ID:=  MessageDlg (instr2 +#13#10+#13#10+
    instr1+#13#10+
    ' to '+Destination, mtConfirmation, [mbYes,mbNo], 0, mbYes);
    
if Destination=RS_APP_data_dir+'/.thrash bin'+'/'then  ID:=mrYes;



if ID=mrYes then
begin
//if (Destination=RS_APP_data_dir+'/.thrash bin'+'/') then
//begin
crs_acreateform('  Working on files , please wait ...      ');  
//end;

 if LastDelimiter('/',Destination)=length(Destination) then 
    delete(Destination,length(Destination),1);

for i:=0 to APASSLst.count-1 do
begin 

if EXIT_File_Operation=true then 
begin
mode:=1;
 break;
 end;
if APASSLst.strings[i]=RS_APP_data_dir+'/.thrash bin'+'/.thrashlog' then continue;
if extractfilepath(APASSLst.strings[i])=Destination+'/' then continue;
//s3:=copy(APASSLst.strings[i],1,LastDelimiter('/',APASSLst.strings[i])-1);
//s2:=stringreplace(APASSLst.strings[i],s3,Destination,[]) ;
if IGNOREALL=false then       
if fileexists(Destination+'/'+extractfilename(APASSLst.strings[i])) 
or directoryexists(stringreplace(APASSLst.strings[i],extractfilepath(APASSLst.strings[i]),Destination+'/',[]) ) 
then begin
//if af<>nil then (af).top:=600-(af).height;
if Destination<>RS_APP_data_dir+'/.thrash bin' then
ID:=  MessageDlg ('File '+extractfilename(APASSLst.strings[i])+' '+
                  'already exists in '+Destination+#13#10+
                  'Are you sure you want to overwrite ? '
                  , mtConfirmation, [mbYes,mbNo,mbIGNORE], 0, mbYes);
if ID=mrNO then continue;
if ID=mrIGNORE then 
 begin 
  ID2:= MessageDlg ('This will overwrite all existsing file '+#13#10+
                    'without your confirmation ? '
                  , mtConfirmation, [mbOK,mbNo,mbAbort], 0, mbYes);
  if ID2=mrOK then IGNOREALL:=true;
  if ID2=mrNo  then continue;
  if ID2=mrAbort then break;
  
 end;
//if af<>nil then af.top:=round((600-af.height)div 2);
end;
(*********************************************************************************)

if not directoryexists(APASSLst.strings[i]) then
begin
//******************************* 
  if af <>nil then AL2.caption:='     '+extractfilename(APASSLst.strings[i]);
 //*******************************
application.processmessages;
if OUTLST<>nil then 
OUTLST.add(stringreplace(APASSLst.strings[i],extractfilepath(APASSLst.strings[i]),Destination+'/',[]) ); 

if not directoryexists(stringreplace(APASSLst.strings[i],extractfilepath(APASSLst.strings[i]),Destination+'/',[]) )
 then crs_deletefile(stringreplace(APASSLst.strings[i],extractfilepath(APASSLst.strings[i]),Destination+'/',[]));
(*************************************
if CRS_CheckIsLink(APASSLst.strings[i])then
begin
if not directoryexists(stringreplace(APASSLst.strings[i],extractfilepath(APASSLst.strings[i]),Destination+'/',[]))
 then crs_deletefile(stringreplace(APASSLst.strings[i],extractfilepath(APASSLst.strings[i]),Destination+'/',[]));
CRS_CopyFile(APASSLst.strings[i],
 stringreplace(APASSLst.strings[i],extractfilepath(APASSLst.strings[i]),Destination+'/',[]),
 true,true,false);
 if mode=2 then crs_deletefile(APASSLst.strings[i]);
 continue;
end;
******************************************)

CRS_CopyFile(APASSLst.strings[i],
 stringreplace(APASSLst.strings[i],extractfilepath(APASSLst.strings[i]),Destination+'/',[]),
 true,true,false);
          
if mode=2 then crs_deletefile(APASSLst.strings[i]);
end;


if directoryexists(APASSLst.strings[i])then
begin

s1:=extractfilepath(APASSLst.strings[i]);
if OUTLST<>nil then OUTLST.add(stringreplace(APASSLst.strings[i],s1,Destination+'/',[])); 

(********** DO NOT remove existing directory !!!!!!! **************)

(********************************************************
if CRS_CheckIsLink(APASSLst.strings[i])then
begin

if directoryexists( stringreplace(APASSLst.strings[i],s1,Destination+'/',[]))then 
crs_rmdir(stringreplace(APASSLst.strings[i],s1,Destination+'/',[]));

//if not directoryexists( stringreplace(APASSLst.strings[i],s1,Destination+'/',[]))then 
CRS_MkDir(APASSLst.strings[i],stringreplace(APASSLst.strings[i],s1,Destination+'/',[]));
if mode=2 then crs_rmdir(APASSLst.strings[i]);
continue;
end;
***********************************************************************)

RECURSESearchDir(APASSLst.strings[i]+'/', '*',TEMPLST);
for ii:=0 to TEMPLST.count-1 do
begin
if EXIT_File_Operation=true then 
begin
mode:=1;
 break;
 end;
 (********** DO NOT remove existing directory !!!!!!! **************)
(*
if directoryexists( stringreplace(TEMPLST.strings[ii],s1,Destination+'/',[]))then 
    X_CRS_FileDeleteRSingle(stringreplace(TEMPLST.strings[ii],s1,Destination+'/',[]));
*)
if directoryexists(TEMPLST.strings[ii])then
begin
//******************************* 
  if af <>nil then AL2.caption:='     '+(TEMPLST.strings[ii]);
 //*******************************
application.processmessages;

TEMPDirLST.add(TEMPLST.strings[ii]);

CRS_MkDir(TEMPLST.strings[ii],stringreplace(TEMPLST.strings[ii],s1,Destination+'/',[]));
continue;
end;
          
if not directoryexists(stringreplace(TEMPLST.strings[ii],s1,Destination+'/',[]) )then 
    crs_deletefile(stringreplace(TEMPLST.strings[ii],s1,Destination+'/',[]));
if not directoryexists(TEMPLST.strings[ii])then 
begin
//******************************* 
  if af <>nil then AL2.caption:='     '+extractfilename(TEMPLST.strings[ii]);
 //*******************************
application.processmessages;
if  mode=2 then 
if AnsiPos(TEMPLST.strings[ii],stringreplace(TEMPLST.strings[ii],s1,Destination+'/',[]))>0
then 
begin
 MessageDlg ('Can''t copy file onto itself , so abort '+#13#10+#13#10
                  , mtConfirmation, [mbOK], 0, mbOK);
TEMPLST.free;
TEMPDirLST.free;
exit
end;
CRS_CopyFile(TEMPLST.strings[ii],stringreplace(TEMPLST.strings[ii],s1,Destination+'/',[]),
                       true,true,false);

end;
end;

TEMPLST.clear;
end;

end;//for i:=0 to APASSLst.count-1 do

end;

if EXIT_File_Operation=true then mode:=1;

if mode=2 then 
begin
if TEMPDirLST.count<>-1 then
for ii:=TEMPDirLST.count-1 downto 0 do
try
if EXIT_File_Operation=true then break;
if TEMPDirLST.strings[ii]=Destination+'/' then continue;
if directoryexists(TEMPDirLST.strings[ii]) then
X_CRS_FileDeleteRSingle(TEMPDirLST.strings[ii]);

except
TEMPLST.free;
TEMPDirLST.free;
exit;
end;
end;//if  MessageDlg (instr2 +#13#10+#13#10+



TEMPLST.free;
TEMPDirLST.free;
if af<>nil then crs_afreeform;

end;

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
 

Procedure TPClass_Command_RedStone.X_CRS_FileDeleteR(APASSLst:TStrings;Destination:STRING);
 var 
 instr:string;
 i,ii,mrKind:integer;
 outlst,SORTlst,TEMPLST:tstringlist;Pinfo:pfileinfo;
begin
instr:='';
SORTlst:=tstringlist.create;
outlst:=tstringlist.create; 
TEMPLST:=tstringlist.create; 
for i:=0 to APASSLst.count-1 do
begin
SORTlst.add(APASSLst.strings[i]);

end;
CRS_CheckFileList(SORTlst); 
if SORTlst.count=0 then 
begin
outlst.free;
SORTlst.free;
TEMPLST.free;
exit;
end;
for i:=0 to SORTlst.count-1 do 
begin
if SORTlst.strings[i]=RS_APP_data_dir+'/.thrash bin'+'/.thrashlog' then continue;

instr:=instr+SORTlst.strings[i]+#13#10;
end;
if Destination<>'' then
mrKind:=  MessageDlg ('Are you sure you want to delete ' +#13#10+#13#10+
    instr, mtConfirmation, [mbYes,mbNo], 0, mbYes);
     if mrKind  =mrNo then exit;
     
if mrKind  =mrYes then
begin
//CRS_ACreateForm('  Working on files , please wait ...      ');
if not directoryexists(RS_APP_data_dir+'/.thrash bin') then
forcedirectories(RS_APP_data_dir+'/.thrash bin');
if not fileexists(RS_APP_data_dir+'/.thrash bin'+'/.thrashlog') then
 outlst.savetofile(RS_APP_data_dir+'/.thrash bin'+'/.thrashlog');
outlst.loadfromfile(RS_APP_data_dir+'/.thrash bin'+'/.thrashlog');

if Destination<>'' then
X_CRS_FileCopyMoveR(1,SORTlst,RS_APP_data_dir+'/.thrash bin'+'/',nil);

for i:=0 to SORTlst.count-1 do
begin 
if EXIT_File_Operation=true then break;
if SORTlst.strings[i]=RS_APP_data_dir+'/.thrash bin'+'/.thrashlog' then continue;
if SORTlst.strings[i]='..' then continue;
if SORTlst.strings[i]='.' then continue;

if extractfilepath(SORTlst.strings[i])=RS_APP_data_dir+'/.thrash bin'+' ' then continue;

for ii:=0 to outlst.count-1 do
begin
if EXIT_File_Operation=true then break;
if CRS_GetParamAtPos('{'+outlst.strings[ii]+'}','{','}','=',1)=extractfilename(SORTlst.strings[i])then
      outlst.delete(ii);
break;
end;


if not directoryexists(SORTlst.strings[i])then
begin
outlst.add(extractfilename(SORTlst.strings[i])+
           '='+SORTlst.strings[i]);
crs_deletefile(SORTlst.strings[i] );
end;

if directoryexists(SORTlst.strings[i])then
begin
outlst.add(extractfilename(SORTlst.strings[i])+
           '='+SORTlst.strings[i]);
           

if CRS_CheckIsLink(SORTlst.strings[i])then
begin
crs_rmdir(SORTlst.strings[i]);
continue;
end;

RECURSESearchDir(SORTlst.strings[i]+'/', '*',TEMPLST);

for ii:=TEMPLST.count-1 downto 0 do
begin
if EXIT_File_Operation=true then break;
if directoryexists(TEMPLST.strings[ii])then begin 
crs_rmdir(TEMPLST.strings[ii]);

end;
if not directoryexists(TEMPLST.strings[ii])then 
begin
crs_deletefile(TEMPLST.strings[ii]);

end;
end;

TEMPLST.clear;
end;
end;
end;
outlst.savetofile(RS_APP_data_dir+'/.thrash bin'+'/.thrashlog');
outlst.free;
SORTlst.free;
TEMPLST.free;
//if AF<>nil then CRS_AFreeForm;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TPClass_Command_RedStone.X_CRS_FileDeleteRSingle(APASSSource:String);
var 
   ii:integer;
    TEMPLST:Tstringlist;
 
begin

if CRS_CheckIsLink(APASSSource)then
begin
if not directoryexists(APASSSource)then crs_deletefile(APASSSource);
if directoryexists(APASSSource)then crs_rmdir(APASSSource);
exit;
end;

TEMPLST:=Tstringlist.create;

 if LastDelimiter('/',APASSSource)=length(APASSSource) then     
    delete(APASSSource,length(APASSSource),1);
if not directoryexists(APASSSource)then
begin
 crs_deletefile(APASSSource);

end;

if directoryexists(APASSSource)then
begin

RECURSESearchDir(APASSSource+'/', '*',TEMPLST);
for ii:=TEMPLST.count-1  downto 0 do
begin

if not directoryexists(TEMPLST.strings[ii])then crs_deletefile(TEMPLST.strings[ii]);
if directoryexists(TEMPLST.strings[ii])then crs_rmdir(TEMPLST.strings[ii]);

end;

TEMPLST.clear;
end;


TEMPLST.free;

end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////



end.
 