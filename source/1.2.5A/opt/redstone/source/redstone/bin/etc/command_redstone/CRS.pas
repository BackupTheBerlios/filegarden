unit CRS;
//
interface

uses
 SysUtils, Types, Classes, Variants, QTypes,
  PClass_Command_RedStone,StrUtils,
 QDialogs,
//QStdCtrls,
//QGraphics,
Libc,
 QControls,
 QForms, IniFiles;
type
  TForm1 = class(TForm)
   procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  procedure Run_X_CRS_ScriptDialog(const APASSProc,APASSExecStr,APASSOutDir:string;APASSLst:tstringlist;APASSText:string);
  private
    { Private declarations }
        K:TPClass_Command_RedStone;
      l:tstringlist;
    
  public
    { Public declarations }
 

  end;

var
  Form1: TForm1;

implementation

{$R *.xfm}

procedure TForm1.FormCreate(Sender: TObject);
var 
i:integer;ss,ss1:string;
begin
l:=nil;
K:=nil;
l:=tstringlist.create;  
try
if (AnsiPos('%PROC%',ParamStr(1))>0)then
begin
k:=TPClass_Command_RedStone.Create(application.Handle,form1,application.ExeName);

for i:=3 to ParamCount-1 do
begin
if ParamStr(i)='-ns' then continue;
if AnsiPos('-text=',ParamStr(i))>0 then begin ss:=k.CRS_GetFileAsText(ParamStr(i));continue;end;
if AnsiPos('-outdir=',ParamStr(i))>0 then begin ss1:=ParamStr(i);continue;end;
l.add(ParamStr(i));
end;
Run_X_CRS_ScriptDialog(ParamStr(1),ParamStr(2),ss1,l,ss);
application.terminate;
end;

if (ParamStr(2)<>'') or(pos('-',ParamStr(2))=0)then 
        k:=TPClass_Command_RedStone.Create(application.Handle,form1,ParamStr(2));
if (ParamStr(2)='')or (pos('-',ParamStr(2))>0)then 
        k:=TPClass_Command_RedStone.Create(application.Handle,form1,application.ExeName);
if (K.RS_Calling_APPPath='') then   begin
MessageDlg ('Error in Component: ', mtinformation, [mbOK], 0);
application.terminate; 
end else
   begin     

l.clear;
for i:=2 to ParamCount-1 do
begin
if ParamStr(i)='-ns' then continue;
l.add(ParamStr(i));
end;


if (ParamStr(2)<>'') and (pos('-',ParamStr(2))=0) then
          k.LoadCompVCL(ParamStr(1),(ParamStr(2)),l);
if (ParamStr(2)='')or (pos('-',ParamStr(2))>0) then 
          k.LoadCompVCL(ParamStr(1),application.ExeName,l);
end;
 except
    on E: Exception do begin
      MessageDlg ('Error in Component: '+E.Message, mtinformation, [mbOK], 0);
if l<>nil then l.free;
if k<>nil then k.free;    
form1.close;
   end;

     
        
end;


end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
if l<>nil then l.free;
if k<>nil then k.free;
application.terminate; 

end;
(******************************************************************************************************)
///////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm1.Run_X_CRS_ScriptDialog(const APASSProc,APASSExecStr,APASSOutDir:string;APASSLst:Tstringlist;
                 APASSText:string);
var sini:tinifile;str1,str2,retSTR,guidstr,datadir,ExecStr:string;StringsLST:tstringlist;
(******************************************************************************************************)
Procedure CheckStripListPath(const APASSsini:Tinifile;APASSLst:Tstrings;const checkINIT:boolean);
var idx,i:integer;templstidx:tstringlist;tempstr:string;
begin
APASSLst.clear;
(***************
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
*********************)

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
begin

ExecStr:=APASSExecStr;
datadir:=K.RS_APP_data_dir;
guidstr:=copy(trim(APASSProc),length('%PROC%')+1,length(trim(APASSProc)));

if not (fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/'+guidstr))and
not (fileexists(k.RS_USER_RESOURCE_PATH+'/'+guidstr))
then  begin
MessageDlg ('Can''t load dialog script ... '+#13#10+
                   k.RS_SYSTEM_RESOURCE_PATH+'/'+guidstr+'or '+#13#10+
                   k.RS_USER_RESOURCE_PATH+'/'+guidstr+#13#10, 
                   mtInformation, [mbOK], 0);
                   
exit;
end;



if fileexists(k.RS_USER_RESOURCE_PATH+'/'+guidstr) then
k.CRS_CopyFile(k.RS_USER_RESOURCE_PATH+'/'+guidstr,datadir+'/'+guidstr+'ToBeDeleted',false,false,false)else
if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/'+guidstr) then
k.CRS_CopyFile(k.RS_SYSTEM_RESOURCE_PATH+'/'+guidstr,datadir+'/'+guidstr+'ToBeDeleted',false,false,false);

//APASSMemo:=xfgmemo;
sini:=nil;
StringsLST:=nil;
StringsLST:=tstringlist.create;
StringsLST.text:=APASSLst.text;
sini:=tinifile.create(datadir+'/'+guidstr+'ToBeDeleted');


if ansilowercase(trim(sini.readstring('INIT','FrameType','none')))='dialog'
then retSTR:=K.X_CRS_scriptdialog(sini,false);

if retSTR='' then  begin if sini<>nil then sini.free;exit;end;


CheckStripListPath(sini,StringsLST,true);
(******************************************************************************************************)

if 

AnsiPos('%in',retSTR) > 0 then 
begin

 try
screen.Cursor:= crHourGlass;    
 chdir(getcurrentdir);
k.CRS_ShellFilesTO(APASSExecStr,retSTR,'',APASSOutDir,3,StringsLST);
finally
screen.Cursor:= crDefault;    
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
end;
exit;
end;
(******************************************************************************************************)
if 

AnsiPos('!in',retSTR) > 0 then 
begin
(******
 try
 screen.Cursor:= crHourGlass;   
 chdir(getcurrentdir);
k.CRS_ShellFilesTOCAT('',APASSExecStr,retSTR,'',datadir,3,StringsLST,APASSText);
finally
screen.Cursor:= crDefault;    
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
end;
*****)
MessageDlg ('Unsupported mode : " !in "  or  " !out "', mtinformation, [mbOK], 0);
exit;
end;
(***********************************************************************************************)
if 

AnsiPos('&in',retSTR) > 0 then 
begin 
try
 screen.Cursor:= crHourGlass;    
chdir(getcurrentdir);
k.CRS_ShellFilesTOSingleFile(APASSExecStr,retSTR,'',APASSOutDir,3,StringsLST);
finally
 screen.Cursor:= crDefault;    
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
end;
exit;
end;
(***********************************************************************************************)
if 

AnsiPos('$in',retSTR) > 0 then 
begin

try
screen.Cursor:= crHourGlass;    
k.CRS_ShellFilesTOSingleAPPLICATION(APASSExecStr,retSTR,'',3,StringsLST);
finally
screen.Cursor:= crDefault;    
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
end;
exit;
end;
(******************************************************************************************************)
if  (ansipos(ansiLowercase('%GetCustomCommand%'),ansiLowercase(retSTR))) > 0 then 
begin
try
screen.Cursor:= crHourGlass;   
retSTR:=K.CRS_DoListCustomCommand(retSTR,APASSExecStr,APASSText);
if AnsiPos(AnsiLowercase('%RunMessage%'),AnsiLowercase(retSTR))<>0 then
begin
if AnsiEndsstr('&',trim(retSTR))then system.delete(retSTR,length(trim(retSTR)),1);
retSTR:=StringReplace(trim(retSTR),AnsiLowercase('%RunMessage%'),'',[rfReplaceAll, rfIgnoreCase]);
str1:=k.CRS_GetGuid+'ToBeDeleted';
K.crs_debug('#!/bin/bash'+#13#10+retSTR,datadir+'/'+str1);
chmod(pchar(datadir+'/'+str1), S_IRUSR or  S_IWUSR or  S_IXUSR);
retSTR:='xterm -title "'+APASSExecStr+'" -hold -e sh "'+datadir+'/'+str1+'" &';
end;
libc.system(pchar(retSTR));
finally
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
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
(AnsiPos('%vclexternal%',retSTR)= 0)
then
begin
try
screen.Cursor:= crHourGlass;   
if AnsiPos(AnsiLowercase('%RunMessage%'),AnsiLowercase(retSTR))<>0 then
begin
if AnsiEndsstr('&',trim(retSTR))then system.delete(retSTR,length(trim(retSTR)),1);
retSTR:=StringReplace(trim(retSTR),AnsiLowercase('%RunMessage%'),'',[rfReplaceAll, rfIgnoreCase]);
str1:=k.CRS_GetGuid+'ToBeDeleted';
K.crs_debug('#!/bin/bash'+#13#10+retSTR,datadir+'/'+str1);
chmod(pchar(datadir+'/'+str1), S_IRUSR or  S_IWUSR or  S_IXUSR);
retSTR:='xterm -title "'+APASSExecStr+'" -hold -e sh "'+datadir+'/'+str1+'" &';
end;
if Libc.system(pchar(retSTR) )= -1 then
MessageDlg ('Error in Component: ', mtinformation, [mbOK], 0)
 else
finally

screen.Cursor:= crDefault;   
if sini<>nil then sini.free;
if StringsLST<>nil then StringsLST.free;
end;
exit;
end;
(******************************************************************************************************)

end;

end.
 