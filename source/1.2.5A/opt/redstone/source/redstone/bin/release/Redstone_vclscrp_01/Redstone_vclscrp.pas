unit Redstone_vclscrp;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types,QButtons, QComCtrls,Libc
  ,RedStone_Public_Comp
  ,PClass_Command_RedStone
  ;

type
  TRedstone_vclscrp = class(TRedStone_Public_Comp)
    procedure DoClose;
   procedure createpagecontrol;
   procedure createts1; 
   procedure createts2;
   procedure createts3;
  procedure creatememo;
    procedure createspeedbutton;
    procedure createpanel1;
  procedure createpanel2;
  procedure createsplitter;
  procedure update_page(state:integer);
  procedure dopreview;
  procedure fontdlgclick(Sender: TObject);
  procedure fontFclick(Sender: TObject);
  //   procedure PCMBClick(Sender: TObject);
  //       procedure PCMBClick(Sender: TObject);
     procedure SpClick(Sender: TObject);
     procedure bbClick(Sender: TObject);
     procedure lbox3Click(Sender: TObject);
     procedure lbox4Click(Sender: TObject);
  procedure updateCFG(list:tstringlist;inisection,operation:string;lbox:tlistbox); 
 procedure updateCFGPanel(list:tstringlist;inisection,operation:string;lbox:tlistbox); 
procedure EDOnMouseEnter(Sender:TObject);
procedure cmbonselect(Sender:TObject);
procedure writeINFO;
procedure updatelbox4IMAGE;
procedure lbox3clickSendToLbox4;
procedure checkDUP(instr:string;Lbox:tlistbox);
procedure chkboxonchecked(Sender:TObject);
procedure bbupdown2click(Sender:TObject);
procedure bbupdownclick(Sender:TObject);
 procedure bbclicktoupdate;
  procedure iniCONFupdatefile(AINIFile:Tinifile);
  private
  selfFontDlgButton,bb1,bb2,bb3,bb4:tbutton;
  UserCallingDIR,
  UserCallingIniconf,
  UserCallingDataDIR,
  UserCallingINFODIR,
  UserCallingGetManageFile,
  UserCallingManageFile:string;
   lbox,lbox2,lbox3,lbox4:tlistbox;
  SaveDialog1:tsavedialog;
 OpenDialog1:tOpenDialog;
  pc:TPagecontrol;
  ts1,ts2,ts3:TTabsheet;
    F,fontF:tform;
  memo1:tmemo;
Bool:Boolean;
  FirstTime:boolean;
K:TPClass_Command_RedStone;
     p1:tpanel;
     p2:tpanel;
     p3,p4:tpanel;
     gb1,gb2:tgroupbox;
      sp:TSplitter;
        speedbutton:tspeedbutton;
           masterlist,keylist,IMGKeyList:tstringlist;
             ini:Tinifile;Kini:tinifile;
             AF:TForm;
             AAProc:string;
lbox3HasFocus:BOOLEAN;
lbox4HasFocus:BOOLEAN;
lb,lb1,lb2,lb3,lb4,lbblock:tlabel;
chkbox:tcheckbox;
restartxfg:BOOLEAN;
cmb:tcombobox;
ed:tedit;
img:timage;
bbIMG,bbup,bbdown,bbup2,bbdown2:tbutton;
  protected
iniTEMP1,iniTEMP2:TMemIniFile;
APassCallingHint:string;
  public
  
    constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
    destructor Destroy; override;
  published

  end;
const
 Iniconf:string='xfg.conf';  

implementation

constructor TRedstone_vclscrp.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList);
var   i,ii:integer;
l,l2:tstringlist;
tmpstr2,tmpstr:string; RP:TReplaceFlags;
begin
inherited;
APassCallingHint:=APassCallingCaptionHint;
restartxfg:=false;
AF:=APass_Form;
AAProc:=APass_ExeName;
Bool:=false;
lbox3HasFocus:=false;
lbox4HasFocus:=false;
UserCallingDIR:=ExtractFilePath(APass_ExeName);
UserCallingIniconf:=UserCallingDIR+Iniconf;
UserCallingDataDIR:=UserCallingDIR+'data/';

FirstTime:=true;
MasterList:=tstringlist.create;
KeyList:=tstringlist.create;
ImgKeyList:=tstringlist.create;
F:=nil; 
 application.handle:=nil;
 application.handle:=APass_Handle;
application.HintPause:=50;
application.HintHidePause:=90000;            
//  constructor Create(ACRS_Handle:QApplicationH;ACRS_Form:TForm;AExeName:String);//override;
  K:=TPClass_Command_RedStone.Create(application.Handle,APass_Form,application.exename);
  UserCallingINFODIR:=K.RS_MAINPATH+'info/';
 tmpstr:= APassCallingCaptionHint;
  if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties')then
  libc.system(pchar('cp '+k.RS_USER_RESOURCE_PATH+'/XFGVCLManageProperties'+' '
                       +UserCallingDataDIR+'xfg0001'+'ToBeDeleted'))else
  if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties')then
    libc.system(pchar('cp '+k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLManageProperties'+' '
                       +UserCallingDataDIR+'xfg0001'+'ToBeDeleted'));
Kini:=tinifile.create(UserCallingDataDIR+'xfg0001'+'ToBeDeleted');
tmpstr2:=Kini.readstring('XFGVCLManagePropertiesFile',tmpstr,'none');
UserCallingManageFile:=stringreplace(tmpstr2,'[HOME]','~',[rfReplaceAll, rfIgnoreCase]);
tmpstr2:='';
tmpstr2:=Kini.readstring('Getdefaultviewfile',tmpstr,'none');
UserCallingGetManageFile:=stringreplace(tmpstr2,'[HOME]','~',[rfReplaceAll, rfIgnoreCase]);

l:=tstringlist.create;
libc.system(pchar('cp '+UserCallingGetManageFile+' '
                       +UserCallingDataDIR+'xfg0001.do'));

iniTEMP1:=TMemIniFile.create(UserCallingDataDIR+'xfg0001.do');
if iniTEMP1.sectionexists('defaultviewfile')=true then
iniTEMP1.readsection('defaultviewfile',l)else
iniTEMP1.readsection(tmpstr,l);


libc.system(pchar('cp '+UserCallingManageFile+' '
                       +UserCallingDataDIR+'xfg0002.do'));
                       
iniTEMP2:=TMemIniFile.create(UserCallingDataDIR+'xfg0002.do');
if iniTEMP2.sectionexists('defaultviewfile')=true  then iniTEMP2.erasesection('defaultviewfile');
iniTEMP2.updatefile;
for i:=0 to l.count-1 do
begin
iniTEMP2.writestring('defaultviewfile',l[i],'1');
end;
iniTEMP2.updatefile;

libc.system(pchar('cp '+UserCallingDataDIR+'xfg0002.do'+' '
                       +UserCallingDataDIR+'xfg.do'));
                     
l.clear;



RP:=[rfIgnoreCase];
l.loadfromfile(UserCallingDataDIR+'xfg.do');

l2:=tstringlist.create;
for i:=0 to l.count-1 do
begin
tmpstr:=StringReplace(l.strings[i],'=', '#',RP);
l2.add(tmpstr);
end;
l2.savetofile(UserCallingDataDIR+'xfg.dod');
l.free;
l2.free;
iniTEMP1.free;
iniTEMP2.free;

ini:=tinifile.create(UserCallingDataDIR+'xfg.do');
//diskini:=tinifile.create(UserCallingIniconf);


try
   F := TForm.Create (application);
   try
   //f.position:=poscreencenter;
   f.width:=720;
   f.height:=480;
   f.top:=screen.height-(screen.height-20);
    f.Constraints.MinHeight := f.height;
 f.Constraints.MinWidth := f.width;
 f. Constraints.MaxWidth := f.width;
 f.Constraints.MaxHeight :=  f.Constraints.MinHeight;
   createpanel1;
   createsplitter;
   createpanel2;
   createspeedbutton;
   createpagecontrol;
   createts1;
 //  createts2;
   createts3;
   creatememo;
   
if  lowercase(Ini.Readstring ('Main', 'DEBUG', 'none'))='true' then
           begin
      memo1.lines.add(ExtractFilePath(APass_ExeName)); 
        memo1.lines.Add('1 RedStone_SysPath = '+k.RS_SysPath );
  memo1.lines.Add('2 CRS_MainPath = '+k.RS_MainPath);
  memo1.lines.Add('3 CRS_RecPath = '+k.RS_Calling_APPRecPath );
  memo1.lines.Add('4 CRS_CompRecName = '+k.RS_CompRecName );
  memo1.lines.Add('5 application.exename = '+application.exename );
  memo1.lines.Add('5.1 AProc = '+APass_ExeName );
  memo1.lines.Add('6 extractfilename(AExeName) = '+extractfilename(application.exename) );
  memo1.lines.Add('UserCallingDIR:=ExtractFilePath(APROC) = '+UserCallingDIR);
  memo1.lines.Add('UserCallingIniconf:=UserCallingDIR+Iniconf = '+UserCallingIniconf);
  memo1.lines.Add('UserCallingDataDIR:=UserCallingDIR+''''/data/'''' = '+UserCallingDataDIR);
    for ii:=0 to masterlist.count-1 do
   memo1.lines.add(masterlist.strings[ii]);
      end ;
         F.caption:='Redstone_vclscrp';
         //   update_page(0); 
          //   update_page(1); 
          //    dopreview;
      pc.ActivePage := ts1;


 
   F.Showmodal;
 
   finally
  
DoClose;
 

    end;   
  
  except
    on E: Exception do begin
      MessageDlg ('Error in Component: '+E.Message, mtError, [mbOK], 0);
      if ini.sectionexists('defaultviewfile')=true  then ini.erasesection('defaultviewfile');
      if ini <> nil then ini.free;
      if fileexists(UserCallingDataDIR+'xfg0001'+'ToBeDeleted')then
deletefile(UserCallingDataDIR+'xfg0001'+'ToBeDeleted');
if Kini<>nil then Kini.free;
if MasterList <> nil then MasterList.free;
if KeyList <> nil then KeyList.free;
if ImgKeyList <> nil then ImgKeyList.free;
if k <> nil then k.free;   
if F <> nil then F.Free;

if ExtractFileName(AAProc)='Command_Redstone' then if AF <> nil then AF.close;
  doclose;
        end;
        

  end;
 
end;

//////////////////////////////////////////////////////////////////////////////////////////////
  procedure TRedstone_vclscrp.iniCONFupdatefile(AINIFile:Tinifile);
  begin
  
AINIFile.updatefile;

end;
//////////////////////////////////////////////////////////////////////////////////////////////

  procedure TRedstone_vclscrp.DoClose;

begin
if fileexists(UserCallingDataDIR+'xfg0001'+'ToBeDeleted')then
deletefile(UserCallingDataDIR+'xfg0001'+'ToBeDeleted');
 if fileexists(UserCallingDataDIR+'xfg.do') then deletefile(UserCallingDataDIR+'xfg.do');
 if fileexists(UserCallingDataDIR+'xfg.dod') then deletefile(UserCallingDataDIR+'xfg.do');
 if fileexists(UserCallingDataDIR+'xfg0001.do') then deletefile(UserCallingDataDIR+'xfg0001.do');
 if fileexists(UserCallingDataDIR+'xfg0002.do') then deletefile(UserCallingDataDIR+'xfg0002.do');

if restartxfg=true then   MessageDlg ('Configuration changed.' +#13#10+
              'You need to restart by using the menu'+#13#10+
              '    --->   File  |  Reload configurations    ', mtWarning, [mbOK], 0);
if ini.sectionexists('defaultviewfile')=true  then ini.erasesection('defaultviewfile');
if ini <> nil then ini.free;
if Kini<>nil then Kini.free;
if MasterList <> nil then MasterList.free;
if KeyList <> nil then KeyList.free;
if ImgKeyList <> nil then ImgKeyList.free;
if k <> nil then k.free;   
if F <> nil then F.Free;

if ExtractFileName(AAProc)='Command_Redstone' then if AF <> nil then AF.close;
end;


 procedure TRedstone_vclscrp.update_page(state:integer);


 begin
 //
 //        function CRS_TrimProc(AProc,AStart,AEnd:String):String;
  //  function CRS_GetProcName(AProc,AStart,AEnd:String):String;
  //  function CRS_GetSepCount(ATrimProc,ASep:String):integer;
  //  function CRS_GetProcList(AProc,AStart,AEnd,ASep:String;AList:TStringList):TStringList;
 //   function CRS_GetParamPos(AProc,AStart,AEnd,ASep,AParam:String):Integer;
 //   function CRS_GetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer):String;
 //   function CRS_SetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer;ASetStr:String):String;
 //   function CRS_GetParamValueList(AProc,AStart,AEnd,ASep:String;APos:Integer;AParamValueSep:String;AList:TStringList):TStringList;
  
//enscript --nup=2  -MA4 --word-wrap --margins=50:50:36:36 --mark-wrapped-lines=arrow --output=%out %in
//IniFile.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none')); 
// Pos(Substr: string; S: string):
///////////////////////////////////////////////////////////////////////////////////////////////
if state=0 then
begin
pc. ActivePage := ts1;
end; //if state=0 then 
///////////////////////////////////////////////////////////////////////////////////////
if state=1 then 
begin 
pc. ActivePage := ts1;
end;//if state=1 then 

end;


  procedure TRedstone_vclscrp.dopreview;

 begin 

//Redstone_vclscrpTMP.jpg.1
// if FindFirst(UserCallingDataDIR+'Redstone_vclscrpTMP.jpg.0', faAnyFile, sr) =0 
//  then deletefile(UserCallingDataDIR+'Redstone_vclscrpTMP.jpg.0');
//  FindClose(sr);
// if FindFirst(UserCallingDataDIR+'*', faAnyFile, sr) = 0 then
//    begin
//      repeat
    //  if (sr.Attr and faDirectory) =0 then
     //   begin
       
//       if pos('Redstone_vclscrpTMP',sr.name)<>0  then
      //  if sr.name='Redstone_vclscrpTMP.jpg.0' then 
//        begin 
//      deletefile(UserCallingDataDIR+sr.name);
//        memo1.lines.add('Deleting   '+sr.name+ '   in TRedstone_vclscrp.dopreview');
//        end;
      //  end;
//      until FindNext(sr) <> 0;
//        FindClose(sr);    end;

    pc.ActivePage := ts1;
    



end;

procedure TRedstone_vclscrp.createpagecontrol; 
begin
pc:=tpagecontrol.create(application) ;
 with pc do begin
 pc.parent:=p2;
  Left := 100;
    Top := 0;
    Width := 609;
    Height := 512;
    ActivePage := ts1;
    Align := alClient;
    TabHeight := 25;
    TabOrder := 1;
    TabWidth := 120;
  
       ActivePage := ts1;
 end;
 end;
 
 
procedure TRedstone_vclscrp.bbupdownclick(Sender:TObject); 

begin
exit;
end;

procedure TRedstone_vclscrp.bbupdown2click(Sender:TObject);
var i,ii:integer;
begin
lbox4HasFocus:=true;
lbox3HasFocus:=false;
with sender as tbutton do 
begin
 lb4.show;
 ed.show;
lbblock.show;
  bbimg.show;
// lbox3clickSendToLbox4;
writeINFO; 
  if lowercase(ed.text)='%builtin%' then begin ed.enabled:=false;exit;end;

if lowercase(caption)='up' then
begin
ii:=lbox4.itemindex;
i:=ii-1;
if ii=0 then exit;
if lowercase(Ini.ReadString (lbox3.items.Strings[lbox3.ItemIndex], lbox4.items.Strings[lbox4.ItemIndex-1], 'none'))
   ='%builtin%' then exit;  
//lbox3.Selected[lbox3.itemindex-1];
lbox4.items.Move(ii, i);
lbox4.Selected[i]:=true;
lbox4.SetFocus;
//masterlist.Move(ii, i);
keylist.Move(ii, i);
imgkeylist.Move(ii, i);
bbclicktoupdate;

end;
if lowercase(caption)='down' then
begin
ii:=lbox4.itemindex;
i:=ii+1;
if ii=lbox4.items.count-1 then exit;
if (lowercase(Ini.ReadString (lbox3.items.Strings[lbox3.ItemIndex+1], lbox4.items.Strings[lbox4.ItemIndex+1], 'none'))
   ='%builtin%')then exit;  
//lbox3.Selected[lbox3.itemindex-1];
lbox4.items.Move(ii, i);
lbox4.Selected[i]:=true;
lbox4.SetFocus;
//masterlist.Move(ii, i);
keylist.Move(ii, i);
imgkeylist.Move(ii, i);
bbclicktoupdate;
end;
end;

end;


procedure TRedstone_vclscrp.createts1; 
var
l1,l2: TStringList;
//Menu, Item: TMenuItem;
 sbint,Position, i,mi: Integer;///
 BitMap1,BitMap2 : TBitMap;
 //   MainMenu1: TMainMenu;
 //   File1: TMenuItem;
  //  Exit1: TMenuItem;
begin
 ts1:=TTabSheet.Create(application);
      with ts1 as ttabsheet do
      begin
   PageControl := pc;
   caption:='Common';  
p3:=tpanel.create(application);
p3.parent:=ts1;

with p3 as tpanel do
begin
//
  Left := 188;
    Top := 0;
    Align := alClient;
 //   BorderWidth := 1;
 BevelOuter := bvNone; 
 //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 

gb1:=tgroupbox.create(nil);
with gb1 as tgroupbox do
begin
parent:=p3;
left:=5;
top:=8;
height:=300;
width:=590;
Caption := 'Application item layout';
//align:=altop;
end;
lbox3:=tlistbox.create(nil);
with lbox3 as tlistbox do 
begin
parent:=gb1;
top:=20;
left:=10;
width:=200;
height:=gb1.height-50;
//align:=alleft;
MultiSelect := False;
ShowHint := True;
hint:='The main application item type';
onclick:=lbox3click;
selected[0]:=true;
end;
    bbup:=tbutton.create(application);
with bbup as tbutton do
begin
parent:=gb1;
height:=18;
ShowHint := True;
hint:='Move item up one row';
top:=lbox3.height+20;
left:=10;
width:=lbox3.width div 2;
onclick:=bbupdownclick;
Color := 16755370;
// Color := clwhite;
 font.name:='sans';
 font.color:= clwhite;
 Cursor := crHandPoint;
 font.style:=[fsbold];
 caption:='Up';

    end;

bbdown:=tbutton.create(application);
with bbdown as tbutton do
begin
parent:=gb1;
height:=18;
ShowHint := True;
hint:='Move item down one row';
top:=lbox3.height+20;
left:=bbup.left+bbup.width;;
width:=bbup.width;
onclick:=bbupdownclick;
 Color := bbup.color;;
 font.name:='sans';
 font.color:=bbup.font.color; 
 Cursor := crHandPoint;
 font.style:=[fsbold];
 caption:='Down';

  end;
lbox4:=tlistbox.create(nil);
with lbox4 as tlistbox do 
begin
parent:=gb1;
//left:=160;
left:=lbox3.left+lbox3.width;
top:=20;
width:=264;
height:=gb1.height-50;
//height:=30;
//align:=alright;
MultiSelect := False;
ShowHint := True;
hint:='Application items';
onclick:=lbox4click;

end;
    bbup2:=tbutton.create(application);
with bbup2 as tbutton do
begin
parent:=gb1;
height:=18;
ShowHint := True;
hint:='Move item up one row';
top:=lbox4.height+20;
left:=lbox4.left;
width:=lbox4.width div 2;
onclick:=bbupdown2click;
 Color := bbup.color;
 font.name:='sans';
 font.color:=bbup.font.color; 
 Cursor := crHandPoint;
font.style:=[fsbold];
 caption:='Up';

    end;

bbdown2:=tbutton.create(application);
with bbdown2 as tbutton do
begin
parent:=gb1;
height:=18;
ShowHint := True;
hint:='Move item down one row';
top:=lbox4.height+20;
left:=bbup2.left+bbup2.width;;
width:=bbup2.width;
onclick:=bbupdown2click;
 Color := bbup.color;
 font.name:='sans';
 font.color:=bbup.font.color; 
 Cursor := crHandPoint;
font.style:=[fsbold];
 caption:='Down';

  end;
bb1:=tbutton.create(application);
with bb1 as tbutton do
begin
parent:=gb1;
height:=30;
ShowHint := True;
hint:='Click to add new item';
top:=20;
left:=480;
width:=100;
//align:=albottom;
//selfFontDlgButton.ModalResult:=mrOK;
onclick:=bbclick;
 Color := 16755370;
 font.name:='sans';
 font.color:=clBackground; 
 Cursor := crHandPoint;
 font.style:=[fsbold];
 caption:='Add new ...';
 BitMap1 := TBitMap.Create;
  try
    BitMap1.loadfromfile(Ini.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none'));
   bitmap:=BitMap1;
 finally
    BitMap1.Free;
    end;
            if ini.readBool('Main','ParentAddNew',false) =false then
bb1.enabled:=false;
    end;
bb2:=tbutton.create(application);
with bb2 as tbutton do
begin
parent:=gb1;
height:=30;
ShowHint := True;
hint:='Click to delete item';
top:=bb1.top+bb1.height+3;
left:=480;
width:=100;
//align:=albottom;
//selfFontDlgButton.ModalResult:=mrOK;
onclick:=bbclick;
 Color := 16755370;
 font.name:='sans';
 font.color:=clBackground; 
 Cursor := crHandPoint;
 font.style:=[fsbold];
 caption:='Delete';
 
 BitMap1 := TBitMap.Create;
  try
    BitMap1.loadfromfile(Ini.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none'));
   bitmap:=BitMap1;
 finally
    BitMap1.Free;
    end;
     if ini.readBool('Main','ParentDelete',false) =false then
bb2.enabled:=false;
    end;
    bb3:=tbutton.create(application);
with bb3 as tbutton do
begin
parent:=gb1;
height:=30;
ShowHint := True;
hint:='Click to rename application item caption or hints';
top:=bb2.top+bb2.height+3;
left:=480;
width:=100;
onclick:=bbclick;
 Color := 16755370;
 font.name:='sans';
 font.color:=clBackground; 
 Cursor := crHandPoint;
 font.style:=[fsbold];
 caption:='Rename';
 BitMap1 := TBitMap.Create;
  try
    BitMap1.loadfromfile(Ini.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none'));
   bitmap:=BitMap1;
 finally
    BitMap1.Free;
         if ini.readBool('Main','ParentRename',false) =false then
bb3.enabled:=false;
    end;
chkbox:=tcheckbox.create(application); 
with chkbox as tcheckbox do
begin
parent:=gb1;
//height:=30;
//ShowHint := True;
//hint:='Click here to update your new command argument'+#13#10+
 //     'to the configuration file in memory without writing'+#13#10+
 //     'to disk';
     
top:=(((bb2.top+bb2.height-5)*2)-30)+2;
left:=480;
width:=100;
caption:='Show hints';
//onclick:=bbclick;
// Color := 16755370;
 font.name:='sans';
// font.color:=clBackground; 
 Cursor := crHandPoint;
 checked:=true;
 onclick:=chkboxonchecked;
 end;
bb4:=tbutton.create(application);  
with bb4 as tbutton do
begin
parent:=gb1;
height:=30;
ShowHint := True;
hint:='Click here to update your new command argument'+#13#10+
      'to the configuration file in memory without writing'+#13#10+
      'to disk';
     
top:=((bb2.top+bb2.height-5)*2)+2;
left:=480;
width:=100;
onclick:=bbclick;
 Color := 16755370;
 font.name:='sans';
 font.color:=clBackground; 
 Cursor := crHandPoint;
 font.style:=[fsbold];
 caption:='Update';
 BitMap1 := TBitMap.Create;
  try
    BitMap1.loadfromfile(Ini.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none'));
   bitmap:=BitMap1;
 finally
    BitMap1.Free;
    end;
 end;
 end;
l1 := TStringList.Create;
l2 := TStringList.Create;
  ini.ReadSection('defaultviewfile',l1);
//l1.insert(0,'File');
//masterlist.add('File');

  for mi := 0 to l1.Count - 1 do 
begin 
if l1.Strings[mi]<>'File' then 
masterlist.add('{'+l1.Strings[mi]+'#'+ini.ReadString('defaultviewfile',l1.Strings[mi],'none')+'}');
 lbox3.items.add(l1.Strings[mi]);        
   end;
lbox3.selected[0]:=true;
end; 
   ini.ReadSection(l1.Strings[0],l2);
     for i := 0 to l2.Count - 1 do 
   begin
   
lbox4.items.add(l2.Strings[i]);
end;
gb2:=tgroupbox.create(nil);
with gb2 as tgroupbox do
begin
parent:=p3;
left:=5;
top:=gb1.top+gb1.height+3;
height:=210;
width:=590;
Caption := 'Application item options';
//align:=altop;
end;
lb :=tlabel.create(nil);
with lb as tlabel do
begin
//name:='lb1';
   parent:=gb2;
//   visible:=false;
   Left := 10;
 //  Caption := 'Main menu type for   : ';
  Caption := 'App item type  : ';
   Top := 30;
   Width := 140;
   Height := 15;
 //  Alignment := taLeft;
   AutoSize := false;
    WordWrap :=true;
 //  Layout := tlLeft;
//   caption:='';
 //  update;
end;
lb1 :=tlabel.create(nil);
with lb1 as tlabel do
begin
//name:='lb1';
   parent:=gb2;
//   visible:=false;
   Left := 150;
   Top := 30;
   Width := 100;
   Height := 15;
   WordWrap :=true;
   Alignment := taCenter;
  AutoSize := false;
 //  Layout := tlCenter;
   caption:='';
   color:=16755370;
 //  update;
end;
cmb :=tcombobox.create(nil);
with cmb as tcombobox do
begin
   parent:=gb2;
  Left := 260;
  Top := 25;
  Width := 113;
  Height := 23;
  Cursor := crHandPoint;
  Style := csDropDownList;
  ItemHeight := 17;
  Items.add( 'none');  
  Items.add( 'vcl');  
  Items.add( 'shell');
  Items.add( 'shellfile');  
  ItemIndex := 0;
 // text:=intstr;
 OnSelect :=cmbonselect;
 enabled:=false;
end;

lb3 :=tlabel.create(nil);
with lb3 as tlabel do
begin
//name:='lb1';
   parent:=gb2;
//   visible:=false;
   Left := 10;
   Top := 60;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
 //  AutoSize := true;
   Layout := tlCenter;
   caption:='App item argument  :';
 //  update;
end;
ed:=tedit.create(nil);
with ed as tedit do
begin
 parent:=gb2;
 Left := 150;
 Top :=55;
 Width := 430;
 Height := 25;
 //font.name:='Courier';
 font.size:=12;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
hint:='ssssssssssssssssss';
OnMouseEnter:=EDOnMouseEnter;

end; 
lb4 :=tlabel.create(nil);
with lb4 as tlabel do
begin
//name:='lb1';
   parent:=gb2;
//   visible:=false;
   Left := 10;
   Top := 90;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
 //  AutoSize := true;
   Layout := tlCenter;
   caption:='App item image  :';
 //  update;
end;
  img:=timage.create(nil);
   with img as timage do
   begin
  
       parent:=gb2;
      Width :=48;//193
        //    Height := 116*index;//177
          Height := 48;//177
        
            Left := 150;
          Top := 85;
          
       Center := True;
           Stretch := false;
           Transparent := false;
       autosize:=false;
       ControlStyle:=[csOpaque];  

     
            end;
            
    bbimg:=tbutton.create(application);
with bbimg as tbutton do
begin
parent:=gb2;
height:=25;
ShowHint := True;
hint:='Click to change application item image';
top:=85;
left:=210;
width:=100;
onclick:=bbclick;
 Color := 16755370;
 font.name:='sans';
 font.color:=clBackground; 
 Cursor := crHandPoint;
 font.style:=[fsbold];
 caption:='Change';
 BitMap1 := TBitMap.Create;
  try
    BitMap1.loadfromfile(Ini.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none'));
    bitmap:=BitMap1;
 finally
    BitMap1.Free;
    end;

lb2 :=tlabel.create(nil);
with lb2 as tlabel do
begin
//name:='lb1';
   parent:=gb2;

   Left := 10;
   Top := 130;
   Width := gb2.width-20;
   Height :=120;
 //  Alignment := taCenter;
 AutoSize := false;
 wordwrap:=true;
  // Layout := tlCenter;
   caption:='';
  // color:=clwhite;
  font.color:=clgray;
 //  update;
end;

lbblock:=tlabel.create(nil);
with lbblock as tlabel do
begin
//name:='lb1';
   parent:=gb2;
//   visible:=false;
   Left := 150;
   Top := 85;
   Width := 25;
   Height := 25;
  Alignment := taCenter;
//   color:=clblack;
 AutoSize := false;
 Layout := tlCenter;
   caption:='';
 //  update;
end;
    end;
l1.clear;
 l2.clear;
end;//  tpanel create
l1.free;
 l2.free;
  lb3.hide;
 lb4.hide;
 ed.hide;
 lbblock.show;
 img.hide;
 bbimg.hide;
 lbox3clickSendToLbox4;
writeINFO;
end;
procedure TRedstone_vclscrp.chkboxonchecked(Sender:TObject);
begin
with chkbox as tcheckbox do
begin
if checked=true then application.showhint:=true;
if checked=false then application.showhint:=false;

end;
end;
procedure TRedstone_vclscrp.cmbonselect(Sender:TObject);
var instr,minstr:string;
mm,mmm:integer;
begin

if trim(lbox3.items.Strings[lbox3.ItemIndex])<>'File' then begin
   mm:=lbox3.ItemIndex+1;
mmm:=lbox3.ItemIndex;
instr:=cmb.text;
minstr:=k.CRS_SetParamAtPos(masterlist.strings[mmm],'{','}','#',2,instr);
 masterlist.insert(mm,minstr);
 masterlist.delete(mmm); 
 end;
//  updateCFG(masterlist,'defaultviewfile','rename',lbox3);  
 lbox3.selected[mmm]:=true;
 updateCFG(masterlist,'defaultviewfile','rename',lbox3); 
 
 if lbox4.items.count<>0 then
begin
    if trim(lbox4.items.Strings[lbox4.ItemIndex])<>'-222222222222222222222222222255544444332' then 
begin
 mm:=lbox4.ItemIndex+1;
mmm:=lbox4.ItemIndex;
// lbox4.items.insert(lbox4.ItemIndex+1,instr);
// lbox4.items.delete(lbox4.ItemIndex);
instr:=ed.text;
minstr:=k.CRS_SetParamAtPos(keylist.strings[mmm],'{','}','#',2,instr);
 keylist.insert(mm,minstr);
 keylist.delete(mmm);
 

  mm:=lbox4.ItemIndex+1;
mmm:=lbox4.ItemIndex;
 instr:=Ini.ReadString(lbox3.items.Strings[lbox3.ItemIndex]+'Image',lbox4.items.Strings[mmm],'none');
if instr <>'' then minstr:=k.CRS_SetParamAtPos(imgkeylist.strings[mmm],'{','}','#',2,instr);
//if instr ='' then 
if pos('#}',imgkeylist.Strings[mmm])<>0 then 
begin
minstr:=k.CRS_GetParamAtPos(imgkeylist.strings[mmm],'{','}','#',1);
minstr:='{'+minstr+'#none}'
end;
 imgkeylist.insert(mm,minstr);
 imgkeylist.delete(mmm);
 
// end;// if trim(lbox4.items.Strings[lbox4.ItemIndex])='-' then 

 updateCFG(keylist,lbox3.items.Strings[lbox3.ItemIndex],'rename',lbox4); 
 updateCFG(imgkeylist,lbox3.items.Strings[lbox3.ItemIndex]+'Image','rename',lbox4); 
 updateCFGPanel(nil,'defaultviewfile','',lbox3);
end;
end;//if lbox4.count<>0 then

writeINFO;
end;


procedure TRedstone_vclscrp.updatelbox4IMAGE;
var instr:string;
begin

//if lbox3HasFocus=true then lbox3click(lbox3);;
if lbox4.items.count=0 then 
begin
img.picture.loadfromfile(UserCallingDIR+'image/'+'button.xpm');
exit;
end;
//if lbox4HasFocus=true then 
if lbox4.items.count>0 then 
begin

instr:=ini.ReadString (lb1.Caption+'Image',lbox4.items.Strings[lbox4.itemindex], '');
//f.caption:=intstr;
if fileexists(instr)=false then img.picture.loadfromfile(UserCallingDIR+'image/'+'button.xpm');
try
if fileexists(instr) then 
begin 

img.picture.loadfromfile(instr);

end;
 except
    on E: Exception do begin
  
      MessageDlg ('Error in loading image :'+instr+#13#10+E.Message, mtError, [mbOK], 0);
 
        end;
        end;
end;//if lbox4HasFocus=true then 
end;

procedure TRedstone_vclscrp.lbox3click(Sender: TObject);
 begin
 if ini.readBool('Main','ParentDelete',false) =false then
bb2.enabled:=false;
 if ini.readBool('Main','ParentRename',false) =false then
bb3.enabled:=false;
 if ini.readBool('Main','ParentAddNew',false) =false then
bb1.enabled:=false;
 if ini.readString('Main','DeleteAlwaysOn','none') =APassCallingHint then
bb2.enabled:=true;
 if ini.readString('Main','RenameAlwaysOn','none') =APassCallingHint then
bb3.enabled:=true;
 if ini.readString('Main','AddNewAlwaysOn','none') =APassCallingHint then
bb1.enabled:=true;
 img.hide;
 cmb.enabled:=true;;
 if lowercase(ed.text)='%builtin%' then ed.enabled:=false else 
ed.enabled:=true;
if lbox3.itemindex=-1 then exit;
lbox4.itemindex:=-1;
 lb3.hide;
 lb4.hide;
 ed.hide;
 lbblock.show;
 bbimg.hide;
 lbox3clickSendToLbox4;
writeINFO;
 end;
 
 procedure TRedstone_vclscrp.lbox3clickSendToLbox4;
var ll:tstringlist;str1,str2:string;
i:integer;
 begin
 lbox4HasFocus:=false;
 lbox3HasFocus:=true;
 lbox4.clear;

 keylist.clear;
 Imgkeylist.clear;
  ll:=tstringlist.create;
with lbox3 as tlistbox do
 begin

// ini.ReadString (items.Strings[ItemIndex]+'Image',l2.Strings[i], 'none')


 
  ini.ReadSection(items.Strings[ItemIndex],ll);
     for i := 0 to ll.Count - 1 do 
   begin
   
lbox4.items.add(ll.Strings[i]);
end;
for i:=0 to lbox4.items.count-1 do
begin
str1:= ini.ReadString (items.Strings[ItemIndex],lbox4.items.Strings[i], 'none');
if str1='' then str2:=lbox4.items.Strings[i]+'#none';
if str1<>'' then str2:=lbox4.items.Strings[i]+'#'+str1;
keylist.add('{'+str2+'}');
str1:= ini.ReadString (items.Strings[ItemIndex]+'Image',lbox4.items.Strings[i], 'none');
if str1='' then str2:=lbox4.items.Strings[i]+'#none';
if str1<>'' then str2:=lbox4.items.Strings[i]+'#'+str1;
Imgkeylist.add('{'+str2+'}');
end;
end;
if lbox4.items.count <> 0 then 
begin
lbox4.selected[0]:=true;

end;

updateCFGPanel(nil,'defaultviewfile','',lbox3);
ll.free;

// lbox4HasFocus:=false;
// lbox3HasFocus:=false;
   cmb.enabled:=false;
end;

 procedure TRedstone_vclscrp.lbox4click(Sender: TObject);
var intstr:string;
begin
if lbox4.items.count=0 then exit;
// if ini.readBool('Main','ParentDelete','false') =false then
bb2.enabled:=true;

bb3.enabled:=true;

bb1.enabled:=true;
img.show;
updateCFGPanel(nil,'defaultviewfile','',lbox3);
  cmb.enabled:=true;
   if lowercase(ed.text)='%builtin%' then ed.enabled:=false else 
ed.enabled:=true;
writeINFO;
cmb.text:=intstr;
if lowercase(ini.ReadString ('defaultviewfile',lbox3.items.Strings[lbox3.ItemIndex], 'none')) <> 'vcl' then
begin
intstr:=ini.ReadString (lbox3.items.Strings[lbox3.ItemIndex],lbox4.items.Strings[lbox4.ItemIndex], 'none');
if (lowercase(intstr)='internal')or (lowercase(intstr)='external')then
begin
  lb3.hide;
 lb4.show;
 ed.hide;
 lbblock.hide;
 bbimg.show;
lb1.Caption:='Override';
cmb.text:='vcl';
cmb.enabled:=false;
lb2.caption:='Values : vcl '+#13#10+
             '    Key : internal = Plugin component called by this application and owns by this application'+#13#10+ 
             '    Key : external = Plugin component called by external program and owns by the external program.'+#13#10+ 
             'To indicate that this menuitem points to a plugin component.'+#13#10+
             'note : This is an override of the parent function.';
 updateCFGPanel(nil,lbox3.items.Strings[lbox3.ItemIndex],'',lbox4);
exit;
end; 
end;
lbox3HasFocus:=false;
lbox4HasFocus:=true;
if  lbox4.items.count>0 then begin
cmb.enabled:=true;
  lb3.show;
 lb4.show;
 ed.show;
 lbblock.hide;
 bbimg.show;
 end;
 updateCFGPanel(nil,lbox3.items.Strings[lbox3.ItemIndex],'',lbox4);
 lbox4.SetFocus;


cmb.enabled:=false;
end;

procedure TRedstone_vclscrp.checkDUP(instr:string;Lbox:tlistbox);
var 
i:integer;
begin
bool:=false;

for i:=0 to lbox.items.count-1 do
begin

if comparestr(instr,lbox.items.strings[i])=0
then  
begin MessageDlg ('Duplicate menu names.' +#13#10+
        'Please give a new name.', mtError, [mbOK], 0);
bool:=true;
exit;
end;
end;

end;

procedure TRedstone_vclscrp.EDOnMouseEnter(Sender:TObject);
begin
// intstr1:=k.CRS_GetParamAtPos(keylist.strings[lbox4.itemindex],'{','}','#',1);
// intstr2:=k.CRS_GetParamAtPos(keylist.strings[lbox4.itemindex],'{','}','#',2);
//intstr:=ini.ReadString (lb1.Caption,lbox4.items.Strings[lbox4.itemindex], 'none');
//intstr:=intstr1+intstr2;
//ed.text:=intstr;
ed.hint:=ed.text;
end;


procedure TRedstone_vclscrp.updateCFGPanel(list:tstringlist;inisection,operation:string;lbox:tlistbox); 
var intstr:string;

begin

 lb1.Caption := lbox3.items.Strings[lbox3.itemindex];

if lbox=lbox3 then 
begin  
 //updateCFGPanel(nil,lbox3.items.Strings[lbox3.ItemIndex],'',lbox4);

intstr:=ini.ReadString (inisection,lbox.items.Strings[lbox.itemindex], 'none');

// lb.Caption := 'Main menu type for ';

 cmb.itemindex:=0;
 if lbox3.items.Strings[lbox3.itemindex]<>'File' then 

 cmb.text:=intstr ;
 
if lbox4.items.count>0 then 
begin
// intstr1:=k.CRS_GetParamAtPos(keylist.strings[lbox4.itemindex],'{','}','#',1);
// intstr2:=k.CRS_GetParamAtPos(keylist.strings[lbox4.itemindex],'{','}','#',2);
intstr:=ini.ReadString (lb1.Caption,lbox4.items.Strings[lbox4.itemindex], 'none');
//intstr:=intstr1+intstr2;
ed.text:=intstr;

end;

 if lbox4.items.count=0 then 
 begin
 ed.text:=' ';

end;
 updatelbox4IMAGE;
ed.selstart:=1;
lbox3.SetFocus;
end;

if lbox=lbox4 then 
begin
 if lbox4.items.count>0 then 
 begin
// intstr1:=k.CRS_GetParamAtPos(keylist.strings[lbox4.itemindex],'{','}','#',1);
// intstr2:=k.CRS_GetParamAtPos(keylist.strings[lbox4.itemindex],'{','}','#',2);
intstr:=ini.ReadString (lb1.Caption,lbox4.items.Strings[lbox4.itemindex], 'none');
//intstr:=intstr1+intstr2;
ed.text:=intstr;
end;

 if lbox4.items.count=0 then 
 begin
 ed.text:=' ';

end;
 updatelbox4IMAGE;
ed.selstart:=1;
lbox4.SetFocus;
end;
end;
 procedure TRedstone_vclscrp.updateCFG(list:tstringlist;inisection,operation:string;lbox:tlistbox); 
  var mm:integer;
  inistr1,inistr2:string;
begin

 ini.erasesection(inisection);
 for mm:=0 to list.count-1 do
begin

 if lbox =lbox3 then 
 begin 
 if list.strings[mm]<>'File' then begin
 inistr1:=k.CRS_GetParamAtPos(list.strings[mm],'{','}','#',1);
 inistr2:=k.CRS_GetParamAtPos(list.strings[mm],'{','}','#',2);
 ini.writestring(inisection,inistr1,inistr2);
 end;
 lbox3.SetFocus;
 end;//if lbox =lbox3 then



 if lbox =lbox4 then 
 begin 
  inistr1:=k.CRS_GetParamAtPos(list.strings[mm],'{','}','#',1);
 inistr2:=k.CRS_GetParamAtPos(list.strings[mm],'{','}','#',2);
  ini.writestring(inisection,inistr1,inistr2);
  lbox4.SetFocus;
end;//if lbox =lbox4 then
 
end;//for mm:=0 to list.count-1 do 

 iniCONFupdatefile(ini);
 
end;


procedure TRedstone_vclscrp.bbclicktoupdate;
var instr,minstr,inistr1,inistr2:string;mm,mmm:integer;
begin
 
 instr:='';
 minstr:='';
 inistr1:='';
 inistr2:='';
if (lbox4HasFocus=false)and(lbox3HasFocus=false) then begin
  MessageDlg ('You must actively select an item.' +#13#10+
              'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;     
 lbox3clickSendToLbox4  ;
exit;
end; 
if lbox3HasFocus=true then begin
if trim(lbox3.items.Strings[lbox3.ItemIndex])='File' then 
begin
  MessageDlg ('This is a system buildin File menu.' +#13#10+
        'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;  
  lbox3clickSendToLbox4  ;     
  
exit;
end; 
if trim(lbox3.items.Strings[lbox3.ItemIndex])<>'File' then begin
   mm:=lbox3.ItemIndex+1;
mmm:=lbox3.ItemIndex;
instr:=cmb.text;
minstr:=k.CRS_SetParamAtPos(masterlist.strings[mmm],'{','}','#',2,instr);
 masterlist.insert(mm,minstr);
 masterlist.delete(mmm); 
 end;
  updateCFG(masterlist,'defaultviewfile','rename',lbox3); 

  updateCFG(keylist,lbox3.items.Strings[lbox3.ItemIndex],'rename',lbox4);  
  updateCFG(imgkeylist,lbox3.items.Strings[lbox3.ItemIndex]+'Image','rename',lbox4);  
 
 lbox3.selected[mmm]:=true;
updateCFGPanel(nil,'defaultviewfile','',lbox3);
lbox3.SetFocus;
end;//if lbox3HasFocus=true then begin

if lbox4HasFocus=true then begin
if lbox4.items.count=0 then begin
  MessageDlg ('You must actively select an item.' +#13#10+
              'No operation is allowed. ', mtError, [mbOK], 0);
              

 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;     
 lbox3clickSendToLbox4  ;
exit;
end; 

if trim(lowercase(ed.text))='%createnew%' then
begin
checkDUP(ed.text,lbox3);
if bool=true then exit;
//lbox3.items.add(lbox4.items.Strings[lbox4.ItemIndex]);

lbox3.update;
end;

 if trim(lbox4.items.Strings[lbox4.ItemIndex])='-5555555555555555555555433333%%%%%%%$#@@' then begin
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;     
 lbox3clickSendToLbox4  ;
exit;
end; 



    if trim(lbox4.items.Strings[lbox4.ItemIndex])<>'-222222222222255555555555555555555555555433333%%%%%%%$#@@@' then 
begin
   mm:=lbox3.ItemIndex+1;
mmm:=lbox3.ItemIndex;
instr:=cmb.text;
minstr:=k.CRS_SetParamAtPos(masterlist.strings[mmm],'{','}','#',2,instr);
 masterlist.insert(mm,minstr);
 masterlist.delete(mmm); 
  
 mm:=lbox4.ItemIndex+1;
mmm:=lbox4.ItemIndex;
// lbox4.items.insert(lbox4.ItemIndex+1,instr);
// lbox4.items.delete(lbox4.ItemIndex);
instr:=ed.text;
minstr:=k.CRS_SetParamAtPos(keylist.strings[mmm],'{','}','#',2,instr);
 keylist.insert(mm,minstr);
 keylist.delete(mmm);
 

  mm:=lbox4.ItemIndex+1;
mmm:=lbox4.ItemIndex;
 instr:=Ini.ReadString(lbox3.items.Strings[lbox3.ItemIndex]+'Image',lbox4.items.Strings[mmm],'none');
if instr <>'' then minstr:=k.CRS_SetParamAtPos(imgkeylist.strings[mmm],'{','}','#',2,instr);
//if instr ='' then 
if pos('#}',imgkeylist.Strings[mmm])<>0 then 
begin
minstr:=k.CRS_GetParamAtPos(imgkeylist.strings[mmm],'{','}','#',1);
minstr:='{'+minstr+'#none}'
end;
 imgkeylist.insert(mm,minstr);
 imgkeylist.delete(mmm);
 
 end;// if trim(lbox4.items.Strings[lbox4.ItemIndex])='-' then 
 updateCFG(masterlist,'defaultviewfile','rename',lbox3); 
 updateCFG(keylist,lbox3.items.Strings[lbox3.ItemIndex],'rename',lbox4); 
 updateCFG(imgkeylist,lbox3.items.Strings[lbox3.ItemIndex]+'Image','rename',lbox4); 
//masterlist.savetofile('/masterlist');
//keylist.savetofile('/keylist');
//imgkeylist.savetofile('/imgkeylist');

 lbox4.selected[mmm]:=true;
  updateCFGPanel(nil,lbox3.items.Strings[lbox3.ItemIndex],'',lbox4);
//  lbox3clickSendToLbox4;

// if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;
lbox4.SetFocus;
end;//if lbox4HasFocus=true then begin  
end;

 procedure TRedstone_vclscrp.bbclick(Sender: TObject);
var instr,minstr,inistr1,inistr2:string;mm,mmm:integer;
 begin
 mm:=0;
 mmm:=0;
 instr:='';
 minstr:='';
 inistr1:='';
 inistr2:='';
with (sender as tbutton) do
 begin
  if lowercase(caption)='update' then 
begin 

 bbclicktoupdate;
end;
if (lbox3HasFocus=true)  and (lowercase(caption)<>'update') and not (lbox4.items.count=0)then 
begin    MessageDlg ('No operation is allowed for items on this listbox' +#13#10+
        'Please choose items from the right side  listbox', mtError, [mbOK], 0);
exit;
 end;
 
////////////////////////////////////////////////////////////////////////////////////////
 if lowercase(caption)='change' then 
begin 
if (lbox4HasFocus=false) and (lbox3HasFocus=false)then begin
  MessageDlg ('You must actively select an item.' +#13#10+
              'No operation is allowed. ', mtError, [mbOK], 0);
 
 lbox4HasFocus:=true;
 //if lbox3HasFocus=true then lbox3HasFocus:=false;       
  lbox3clickSendToLbox4  ;
exit;
end; 

if (lbox4HasFocus=true) or (lbox3HasFocus=true) then begin
if(trim(lbox4.items.Strings[lbox4.ItemIndex])='-') then 
begin
  MessageDlg ('This is a menu item seperator.' +#13#10+
        'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;     
  lbox3clickSendToLbox4  ;  
exit;
end; 



if lbox4HasFocus=true then 
begin
if  lbox4.items.count=0 then begin
  MessageDlg ('You must actively select an item.' +#13#10+
              'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;     
 lbox3clickSendToLbox4  ;
exit;
end; 

  opendialog1:=topendialog.create(f);
  with opendialog1 as topendialog do
  begin
    DefaultExt := '*';
 //   Filter := '|all file|*';
//    FilterIndex := 0;
    Options := [ofShowHidden,  ofPathMustExist, ofFileMustExist, ofEnableSizing, ofViewList];
    filename:='*';
     mm:=lbox4.ItemIndex+1;
mmm:=lbox4.ItemIndex;
   if Execute then
  begin
 
  img.picture.loadfromfile(OpenDialog1.Filename);
  img.repaint;
  instr:= OpenDialog1.Filename;
    if trim(lbox4.items.Strings[lbox4.ItemIndex])<>'-5555555555555555555555433333%%%%%%%$#@@' then 
begin
 

// lbox4.items.insert(lbox4.ItemIndex+1,instr);
// lbox4.items.delete(lbox4.ItemIndex);

minstr:=k.CRS_SetParamAtPos(imgkeylist.strings[mmm],'{','}','#',2,instr);
 imgkeylist.insert(mm,minstr);
 imgkeylist.delete(mmm);
 
 
 
 end;// if trim(lbox4.items.Strings[lbox4.ItemIndex])='-' then 

  updateCFG(imgkeylist,lbox3.items.Strings[lbox3.ItemIndex]+'Image','rename',lbox4); 

   free;
  end;//if Execute then

lbox4.selected[mmm]:=true;


// if lbox4HasFocus=true then lbox4HasFocus:=false;

  end;//with opendialog1 as topendialog do
  end;
  lbox4.SetFocus;
lbox4HasFocus:=true;
end;//if lbox4HasFocus=true then begin  
end;
////////////////////////////////////////////////////////////////////////////////////////

if (lowercase(ed.text)='%builtin%') and
(lowercase(caption)<>'add new ...')then 
begin
  MessageDlg ('This is a system buildin item.' +#13#10+
        'No operation is allowed. ', mtError, [mbOK], 0);
         
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false; 
  lbox3clickSendToLbox4  ;      
exit;
end; 
//////////////////////////////////////////////////////////////////////////////////////// /
////////////////////////////////////////////////////////////////////////////////////////
if lowercase(caption)='add new ...' then 
begin 
if (lbox4HasFocus=false)and(lbox3HasFocus=false) and not (lbox4.items.count=0)then begin
  MessageDlg ('You must actively select an item.' +#13#10+
              'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;    
  lbox3clickSendToLbox4  ;   
exit;
end; 
 //   function CRS_GetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer):String;
 //   function CRS_SetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer;ASetStr:String):String;
if (lbox4HasFocus=false)and(lbox3HasFocus=true) and (lbox4.items.count=0)then 
begin
instr := 'New item'; 
if InputQuery('Add new item', 'New item name', instr)=true then
begin 

if trim(instr) <>'-' then
checkDUP(instr,lbox4);
if trim(instr) ='-' then bool:=false;
if bool=true then exit;

mm:=0;
//mmm:=lbox4.ItemIndex;
 lbox4.items.add(instr);
minstr:='{'+instr+'#none'+'}';
 keylist.add(minstr);

updateCFG(keylist,lbox3.items.Strings[lbox3.ItemIndex],'addnew',lbox4); 
updateCFG(imgkeylist,lbox3.items.Strings[lbox3.ItemIndex]+'Image','rename',lbox4);  
updateCFG(masterlist,'defaultviewfile','rename',lbox3); 

lbox3clickSendToLbox4;
 lbox4.selected[0]:=true;
  updateCFGPanel(nil,lbox4.items.Strings[lbox4.ItemIndex],'',lbox4);
  end;
 end;
if (lbox4HasFocus=true) then begin
if trim(lbox3.items.Strings[lbox3.ItemIndex])='File' then 
begin
  MessageDlg ('This is a system buildin File menu.' +#13#10+
        'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;   
  lbox3clickSendToLbox4  ;    
exit;
end; 



 instr := 'New item'; 
if InputQuery('Add new item', 'New item name', instr)=true then
begin 

if trim(instr) <>'-' then
checkDUP(instr,lbox4);
if trim(instr) ='-' then bool:=false;
if bool=true then exit;


if lbox4.items.count>0 then
begin
mm:=lbox4.ItemIndex+1;
mmm:=lbox4.ItemIndex;
 lbox4.items.insert(mm,instr);
minstr:='{'+instr+'#none'+'}';
 keylist.insert(mm,minstr);
 end;
if lbox4.items.count=0 then
begin
mm:=0;
//mmm:=lbox4.ItemIndex;
 lbox4.items.add(instr);
minstr:='{'+instr+'#none'+'}';
 keylist.add(minstr);
 end;
updateCFG(keylist,lbox3.items.Strings[lbox3.ItemIndex],'addnew',lbox4); 
updateCFG(imgkeylist,lbox3.items.Strings[lbox3.ItemIndex]+'Image','rename',lbox4);  
updateCFG(masterlist,'defaultviewfile','rename',lbox3); 

lbox3clickSendToLbox4;
 lbox4.selected[mm]:=true;

  updateCFGPanel(nil,lbox4.items.Strings[lbox4.ItemIndex],'',lbox4);

end;//if InputQuery('Add new menu item', 'New menu name', instr)=true then
lbox4.SetFocus;
lbox4HasFocus:=true;
 bbclicktoupdate;
end;//if lbox4HasFocus=true then begin

end;//if lowercase(caption)='add new ...' then 



if lowercase(caption)='rename' then 
begin 


if (lbox4HasFocus=false)and(lbox3HasFocus=false) then begin
  MessageDlg ('You must actively select an item.' +#13#10+
              'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false; 
  lbox3clickSendToLbox4  ;      
exit;
end; 
if trim(lbox3.items.Strings[lbox3.ItemIndex])='File' then 
begin
  MessageDlg ('This is a system buildin File menu.' +#13#10+
        'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;   
  lbox3clickSendToLbox4  ;    
exit;
end; 
//////   function CRS_GetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer):String;
 //   function CRS_SetParamAtPos(AProc,AStart,AEnd,ASep:String;APos:Integer;ASetStr:String):String;

if lbox3HasFocus=true then begin
if lbox3.itemindex=-1 then exit;
//lbox3.selected[lbox3.itemindex]:=true;

 instr := lbox3.items.Strings[lbox3.ItemIndex]; 
if InputQuery('Rename menu', 'New menu name', instr)=true then
begin 
if trim(instr) <>'-' then
checkDUP(instr,lbox3);
if trim(instr) ='-' then bool:=false;
if bool=true then exit;
// instr:= InputBox('Rename menu item', 'New name', lbox3.items.Strings[lbox3.ItemIndex]);
//  ini.writestring('defaultviewfile',instr,'none');
mm:=lbox3.ItemIndex+1;
mmm:=lbox3.ItemIndex;
ini.EraseSection(lbox3.items.Strings[mmm]+'Image');
ini.DeleteKey('defaultviewfile', lbox3.items.Strings[mmm]);
ini.EraseSection(lbox3.items.Strings[mmm]);

iniCONFupdatefile(ini);

 lbox3.items.insert(mm,instr);
 lbox3.items.delete(mmm);
 minstr:=k.CRS_SetParamAtPos(masterlist.strings[mmm],'{','}','#',1,instr);
 masterlist.insert(mm,minstr);
 masterlist.delete(mmm);


 lbox3.selected[mmm]:=true;
 
updateCFG(keylist,lbox3.items.Strings[lbox3.ItemIndex],'rename',lbox4);  
updateCFG(imgkeylist,lbox3.items.Strings[lbox3.ItemIndex]+'Image','rename',lbox4);  
updateCFG(masterlist,'defaultviewfile','rename',lbox3); 
updateCFGPanel(nil,'defaultviewfile','',lbox3);
end;//if InputQuery('Rename menu', 'New menu name', instr)=true then
//?????????????????????????????????????????????????????????????????????? 
// ini.erasesection('defaultviewfile');
// for mm:=0 to masterlist.count-1 do
// begin
//  if masterlist.strings[mm]<>'File' then begin
// inistr1:=k.CRS_GetParamAtPos(masterlist.strings[mm],'{','}','#',1);
// inistr2:=k.CRS_GetParamAtPos(masterlist.strings[mm],'{','}','#',2);
// ini.writestring('defaultviewfile',inistr1,inistr2);
// iniCONFupdatefile(ini);end;
// end;
//?????????????????????????????????????????????????????????????????????? 
// if lbox4.itemindex=-1 then exit;
lbox3.SetFocus;
lbox3HasFocus:=true;

// if lbox4HasFocus=true then lbox4HasFocus:=false;
// if lbox3HasFocus=true then lbox3HasFocus:=false;
end;

if lbox4HasFocus=true then begin

if lbox4.itemindex=-1 then exit;
//lbox3.selected[lbox3.itemindex]:=true;

if trim(lbox4.items.Strings[lbox4.ItemIndex])='-' then 
begin
  MessageDlg ('This is a menu item seperator.' +#13#10+
        'Only operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false;     
      lbox3clickSendToLbox4  ;    
exit;
end;
 

if trim(lbox4.items.Strings[lbox4.ItemIndex])<>'-@@@@@@@@@@@@@@@###########%$%%%%%%%%%%%%^^^^^^^^^^^^%$' then 
begin
instr:= lbox4.items.Strings[lbox4.ItemIndex];
if InputQuery('Rename menu', 'New menu name', instr)=true then
// instr:= InputBox('Rename menu item', 'New name', lbox4.items.Strings[lbox4.ItemIndex]);
if trim(instr) <>'-' then
 checkDUP(instr,lbox4);
 if trim(instr) ='-' then bool:=false;
if bool=true then exit;
 mm:=lbox4.ItemIndex+1;
mmm:=lbox4.ItemIndex;
ini.DeleteKey(lbox3.items.Strings[lbox3.ItemIndex], lbox4.items.Strings[lbox4.ItemIndex]);
//ini.EraseSection(lbox3.items.Strings[lbox3.ItemIndex]);
//ini.EraseSection(lbox3.items.Strings[lbox3.ItemIndex]+'Image');
 lbox4.items.insert(lbox4.ItemIndex+1,instr);
 lbox4.items.delete(lbox4.ItemIndex);

minstr:=k.CRS_SetParamAtPos(keylist.strings[mmm],'{','}','#',1,instr);
 keylist.insert(mm,minstr);
 keylist.delete(mmm);
minstr:=k.CRS_SetParamAtPos(imgkeylist.strings[mmm],'{','}','#',1,instr);
  imgkeylist.insert(mm,minstr);
 imgkeylist.delete(mmm);

 
 end;// if trim(lbox4.items.Strings[lbox4.ItemIndex])='-' then 
updateCFG(keylist,lbox3.items.Strings[lbox3.ItemIndex],'rename',lbox4); 
updateCFG(imgkeylist,lbox3.items.Strings[lbox3.ItemIndex]+'Image','rename',lbox4); 
updateCFG(masterlist,'defaultviewfile','rename',lbox3); 

//????????????????????????????????????????????????????????????
// ini.erasesection(lbox3.items.Strings[lbox3.ItemIndex]);
// for mm:=0 to keylist.count-1 do
// begin
//if trim(keylist.Strings[mm])<>'{-#}' then 
//begin
//  inistr1:=k.CRS_GetParamAtPos(keylist.strings[mm],'{','}','#',1);
// inistr2:=k.CRS_GetParamAtPos(keylist.strings[mm],'{','}','#',2);
// end;
//if trim(keylist.Strings[mm])='{-#}' then 
//begin
//  inistr1:='-';
// inistr2:='none';
// end;
 
// ini.writestring(lbox3.items.Strings[lbox3.ItemIndex],inistr1,inistr2);

 //end;
// end;//for mm:=0 to keylist.count-1 do 
 


// iniCONFupdatefile(ini);
//????????????????????????????????????????????????????????????
//if lbox4.itemindex=-1 then exit;
lbox4.selected[mmm]:=true;
//updatelbox4IMAGE;

lbox4.SetFocus;
lbox4HasFocus:=true;
// if lbox4HasFocus=true then lbox4HasFocus:=false;
// if lbox3HasFocus=true then lbox3HasFocus:=false;
 
end;// if lbox4HasFocus=true then begin


end;//  if lowercase(caption)='rename' then 
////////////////////////////////////////////////////////////////////////////////////////

if lowercase(caption)='delete' then 
begin 
if (lbox4HasFocus=false)and(lbox3HasFocus=false) then begin
  MessageDlg ('You must actively select an item.' +#13#10+
              'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false; 
   lbox3clickSendToLbox4  ;          
exit;
end; 
if lbox3HasFocus=true then begin
if lbox3.itemindex=-1 then exit;
//lbox3.selected[lbox3.itemindex]:=true;

if trim(lbox3.items.Strings[lbox3.ItemIndex])='File' then 
begin
  MessageDlg ('This is a system buildin File menu.' +#13#10+
        'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false; 
   lbox3clickSendToLbox4  ;          
exit;
end; 
mmm:=lbox3.itemindex;

masterlist.delete(lbox3.itemindex);
ini.DeleteKey('defaultviewfile', lbox3.items.Strings[lbox3.ItemIndex]);
ini.DeleteKey('Menu', lbox3.items.Strings[lbox3.ItemIndex]);
ini.DeleteKey('MenuImage', lbox3.items.Strings[lbox3.ItemIndex]);
ini.EraseSection(lbox3.items.Strings[lbox3.ItemIndex]);
ini.EraseSection(lbox3.items.Strings[lbox3.ItemIndex]+'Image');

lbox3.items.delete(lbox3.itemindex);
lbox4.clear;

 iniCONFupdatefile(ini);
//if lbox4.itemindex=-1 then exit;
 if mmm > lbox3.items.count-1  then lbox3.selected[mmm-1]:=true;
 if (mmm < lbox3.items.count-1) or (mmm = lbox3.items.count-1)  then lbox3.selected[mmm]:=true;
lbox3clicksendtolbox4;
lbox3.SetFocus;
lbox3HasFocus:=true;
end;
 if lbox4HasFocus=true then begin
 if trim(lbox3.items.Strings[lbox3.ItemIndex])='File' then 
begin
  MessageDlg ('This is a system buildin File menu.' +#13#10+
        'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false; 
   lbox3clickSendToLbox4  ;          
exit;
end; 
 
 if lbox4.itemindex=-1  then 
begin
  MessageDlg ('You must actively select an item.' +#13#10+
              'No operation is allowed. ', mtError, [mbOK], 0);
 
 if lbox4HasFocus=true then lbox4HasFocus:=false;
 if lbox3HasFocus=true then lbox3HasFocus:=false; 
   lbox3clickSendToLbox4  ;          
exit;
end; 
//lbox3.selected[lbox3.itemindex]:=true;
mmm:=lbox4.ItemIndex;
keylist.delete(mmm);
imgkeylist.delete(mmm);
 ini.DeleteKey(lbox3.items.Strings[lbox3.ItemIndex], lbox4.items.Strings[lbox4.ItemIndex]);
 ini.DeleteKey(lbox3.items.Strings[lbox3.ItemIndex]+'Image', lbox4.items.Strings[lbox4.ItemIndex]);

lbox4.items.delete(mmm);

 iniCONFupdatefile(ini);
 if mmm > lbox4.items.count-1  then lbox4.selected[mmm-1]:=true;
 if (mmm < lbox4.items.count-1) or (mmm = lbox4.items.count-1)  then lbox4.selected[mmm]:=true;
 lbox4.SetFocus;
lbox4HasFocus:=true;
end;
//if lbox4.itemindex=-1 then exit;

updatelbox4IMAGE;
 updateCFGPanel(nil,lbox3.items.Strings[lbox3.ItemIndex],'',lbox4);
// if lbox4HasFocus=true then lbox4HasFocus:=false;
// if lbox3HasFocus=true then lbox3HasFocus:=false;
end;
////////////////////////////////////////////////////////////////////////////////////////


end;
 end;//
 
procedure TRedstone_vclscrp.createts2; 
begin
 ts2:=TTabSheet.Create(nil);
      with ts2 do
      begin
        parent:=pc;
      PageControl := pc;
    caption:='Advance';  
    
p4:=tpanel.create(nil);
p4.parent:=ts2;
with p4 as tpanel do
begin
//
  Left := 0;
    Top := 0;
    Align := alClient;
  //  BorderWidth := 1;

 BevelOuter := bvNone;  
end;

end;

end;
//
 procedure   TRedstone_vclscrp.fontFclick(Sender: TObject);
 begin
 fontf.modalresult:=mrOK;
 end;
  procedure   TRedstone_vclscrp.fontdlgclick(Sender: TObject);
var  
BitMap1:tbitmap;

  begin
   try
fontF:=tform.create(application);
try
fontF.parent:=F;
fontF.width:=300;
fontF.height:=300;
fontf.top:=50;
fontf.left:=100;
fontF.caption:='Choose font';
selfFontDlgButton:=tbutton.create(application);
selfFontDlgButton.parent:=fontF;
selfFontDlgButton.height:=30;
selfFontDlgButton.ShowHint := True;
selfFontDlgButton.hint:='Click to apply';
selfFontDlgButton.align:=albottom;
//selfFontDlgButton.ModalResult:=mrOK;
selfFontDlgButton.onclick:=bbclick;
 selfFontDlgButton.Color := 16755370;
 selfFontDlgButton.font.name:='sans';
 selfFontDlgButton.font.color:=clBackground; 
 selfFontDlgButton.Cursor := crHandPoint;
 selfFontDlgButton.font.style:=[fsbold];
 selfFontDlgButton.caption:='Apply';
 BitMap1 := TBitMap.Create;
  try
    BitMap1.loadfromfile(Ini.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none'));
   selfFontDlgButton.bitmap:=BitMap1;
 finally
    BitMap1.Free;
    end;
lbox2:=tlistbox.create(application);
lbox2.parent:=fontF;
lbox2.top:=0;
lbox2.width:=100;
lbox2.align:=alright;
 lbox2.MultiSelect := False;
 lbox2.ShowHint := True;
lbox2.hint:='Choose font size';
lbox:=tlistbox.create(application);
lbox.parent:=fontF;
lbox.top:=0;
//lbox.width:=200;
lbox.align:=alclient;
 lbox.MultiSelect := False;
  lbox.ShowHint := True;
lbox.hint:='Choose font face';

 if   FontF.ShowModal=mrOK then
 begin
//
 end;   
finally
    fontF.free;
    fontF:=nil;
end
  except
    on E: Exception do begin
      MessageDlg ('Error in Component: ' +
        E.Message, mtError, [mbOK], 0);
   fontF.free;
    fontF:=nil;
        end;
 end;

  
   
end;  
procedure TRedstone_vclscrp.createts3; 
begin
 ts3:=TTabSheet.Create(nil);
      with ts3 do
      begin
 
   parent:=pc;
        PageControl := pc;
     //   TabVisible := (PageIndex mod 2 = 0);
      Caption := 'Memo';
     //   IntToStr(PageIndex) + '  TabIndex: ' +
    //      IntToStr(TabIndex);  
    //      color:= 15059399+(i*100);
        //  onshow:=tabshow; 
 //       parentfont:=false;
       //   BorderWidth:=5;
//OnHide:=tabhide;   
      end;
end;
 



procedure TRedstone_vclscrp.creatememo;
begin
   memo1:=tmemo.create(nil);
     memo1.parent:=ts3;
    with memo1 as tmemo do
    begin
      Left := 0;
      Top := 0;
    //  Width := 610;
    //  Height := 428;
      Align := alClient;
        
      Color := clWhite;
      Font.Color := clBlack;
      Font.size:= 12;
   //   Font.Name := 'courier';
      Font.Pitch := fpVariable;
      Font.Style := [];
      ParentFont := False;
      ScrollBars := ssBoth;
   //   TabOrder := 0;
      WordWrap := False;
      readonly:=false;
       BorderStyle := bsRaisedPanel;
  //    OnMouseEnter = Memo1MouseEnter
    end;
     
end;

procedure TRedstone_vclscrp.createspeedbutton;
var  mi,sbint:integer;
l1:tstringlist;
debug,test:string;
begin


debug:= ini.Readstring ('Main', 'DEBUG', 'none');
l1:=tstringlist.create;
ini.ReadSection('xfgOptionsSidePanel',l1); 
   sbint:=10;
 for mi := 0 to l1.Count - 1 do 
begin
  test:=l1.Strings[mi];
     if (trim(lowercase(test))='update preview')or
     (trim(lowercase(test))='backup')
      then
     begin
     continue;
  if debug='false' then continue else if debug='true' then ;
  end;
 
speedbutton:=TSpeedButton.Create (nil);
speedbutton.parent:=p1;
 speedbutton.left:=8;
 speedbutton.font.style:=[fsbold];
 speedbutton.font.color:=clwhite;
  speedbutton.font.name:='sans';
      speedbutton.Top := sbint;
      speedbutton.Width := 95;
      speedbutton.Height := 70;
        if trim(lowercase(test))='apply settings' 
        then speedbutton.Hint :='Write the updated configuration file to disk' else
    speedbutton.Hint :=l1.Strings[mi];
   
    speedbutton.caption:=l1.Strings[mi];
       speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
     if fileexists(ini.Readstring ('xfgOptionsSidePanel', l1.Strings[mi], 'none'))=true then
      SpeedButton.Glyph.LoadFromFile(ini.Readstring ('xfgOptionsSidePanel', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
    speedbutton.OnClick := spclick;
speedbutton.visible:=true;
sbint:=sbint+70+10;
 
end;
l1.clear;
l1.free;

end;


 procedure TRedstone_vclscrp.SpClick(Sender: TObject);
var i,ii:integer;
l,l2,l3:tstringlist;ss:string;
 begin
 with (sender as tspeedbutton) do
 begin
 if lowercase(caption)='close' then begin
if ini.sectionexists('defaultviewfile')=true  then ini.erasesection('defaultviewfile');
ini.updatefile;      
              f.close;
              end;
if lowercase(caption)='memo' then pc. ActivePage := ts3;
if lowercase(caption)='save memo' then 
begin 

  pc.ActivePage := ts3;
   SaveDialog1:=tsavedialog.create(application);
 SaveDialog1.InitialDir := '~';
  if SaveDialog1.Execute then
   Memo1.Lines.SaveToFile(SaveDialog1.FileName);

SaveDialog1.free;

end;


if lowercase(caption)='update preview' then 
begin 

iniCONFupdatefile(ini);
memo1.lines.clear;
if (Ini.Readstring ('Main', 'DEBUG', 'none'))='true' then begin
l:=tstringlist.create;

l.assign(masterlist);
for i:=0 to l.count-1 do
begin
memo1.lines.add(l.strings[i]);
end;
l.assign(keylist);
for i:=0 to l.count-1 do
begin
memo1.lines.add(l.strings[i]);
end;
l.assign(imgkeylist);
for i:=0 to l.count-1 do
begin
memo1.lines.add(l.strings[i]);
end;
l.free;
end;
end;

if lowercase(caption)='apply settings' then 
begin 
iniCONFupdatefile(ini);
l:=tstringlist.create;
l2:=tstringlist.create;
l3:=tstringlist.create;


if (Ini.Readstring ('Main', 'DEBUG', 'none'))='true' then 
memo1.lines.loadfromfile(UserCallingDataDIR+'xfg.do');
  SaveDialog1:=tsavedialog.create(application);
   SaveDialog1.Options := [ofShowHidden, ofOverwritePrompt, ofExtensionDifferent, ofPathMustExist, ofViewList];
   SaveDialog1.Title := 'Save configuration to disk';
 SaveDialog1.InitialDir := extractfilepath(UserCallingManageFile);
 SaveDialog1.filename := (UserCallingManageFile);
 if  (SaveDialog1.Execute) then 
  begin

ini.updatefile;
 l.loadfromfile(UserCallingDataDIR+'xfg.do');
 l.SaveToFile(SaveDialog1.filename);
 restartxfg:=true;
 
 //UserCallingDIR:=ExtractFilePath(APROC);
//UserCallingIniconf:=UserCallingDIR+Iniconf;
//UserCallingDataDIR:=UserCallingDIR+'data/';

l.clear;
ini.readsection('defaultviewfile',l);
libc.system(pchar('cp '+UserCallingGetManageFile+' '
                       +UserCallingDataDIR+'xfg0002.do'));
                       
iniTEMP2:=TMemIniFile.create(UserCallingDataDIR+'xfg0002.do');
if iniTEMP2.sectionexists('defaultviewfile')=true  then iniTEMP2.erasesection('defaultviewfile');
//if iniTEMP2.sectionexists(APassCallingHint)=true  then iniTEMP2.erasesection(APassCallingHint);
(*
memo1.lines.add(' ');
memo1.lines.add(' ');
memo1.lines.add('L');
memo1.lines.text:=memo1.lines.text+#13#10+l.text;
*)
iniTEMP2.updatefile;
for i:=0 to l.count-1 do
begin
iniTEMP2.writestring(l[i]+'Manage',l[i],'1');

l2.clear;
//if iniTEMP2.sectionexists(l[i]+'Manage') then iniTEMP2.erasesection(l[i]+'Manage');
ini.readsection(l[i],l2);
(*
memo1.lines.add(' ');
memo1.lines.add(' ');
memo1.lines.add('l2');
memo1.lines.text:=memo1.lines.text+#13#10+l2.text;
*)
for ii:=0 to l2.count-1 do
iniTEMP2.writestring(l[i]+'Manage',l2[ii],'1');
iniTEMP2.writestring('defaultviewfile',l[i],'1');
end;
iniTEMP2.updatefile;
l3.clear;


for i:=0 to l.count-1 do
begin
l2.clear;
iniTEMP2.readsection(l[i]+'Manage',l2);
//(*
memo1.lines.add(' ');
memo1.lines.add(' ');
memo1.lines.add('l2');
memo1.lines.text:=memo1.lines.text+#13#10+l2.text;
//*)
for ii:=0 to l2.count-1 do
begin
if  (not (ini.ValueExists (trim(l[i]),l2[ii])))and  (trim(l[i])<>trim(l2[ii])) 
  
then
begin

if iniTEMP2.sectionexists(trim(l2[ii])+'Manage') then
iniTEMP2.erasesection(trim(l2[ii])+'Manage');
l3.add(l[i]+'='+l2[ii]);
end;
end;
end;
//l3.savetofile('/xxxxxxxxxxxxxxx');
//(*
memo1.lines.add(' ');
memo1.lines.add(' ');
memo1.lines.add('l3');
memo1.lines.text:=memo1.lines.text+#13#10+l3.text;
//*)
iniTEMP2.updatefile;
ini.updatefile;
for i :=0 to l3.count-1 do
begin
if iniTEMP2.valueexists(trim(l3.names[i]+'Manage'),l3.values[l3.names[i]]) then
iniTEMP2.deletekey(trim(l3.names[i]+'Manage'),l3.values[l3.names[i]]);
if iniTEMP2.sectionexists(l3.values[l3.names[i]]+'Manage') then
iniTEMP2.erasesection(trim(l3.names[i]+'Manage'));
// Quick Folder=cccc
ini.erasesection(l3.values[l3.names[i]]);
ini.erasesection(l3.values[l3.names[i]]+'Image');
//memo1.lines.add(l3.values[l3.names[i]]);
//memo1.lines.add(l3.values[l3.names[i]]+'Image');

end;
iniTEMP2.updatefile;
ini.updatefile;
iniTEMP2.free;

libc.system(pchar('cp '+UserCallingDataDIR+'xfg0002.do'+' '
                       +UserCallingGetManageFile));
                       
l.clear;
ss:=SaveDialog1.filename;
//memo1.lines.add(ss+'  '+SaveDialog1.filename);
l.loadfromfile(UserCallingDataDIR+'xfg.do');
l.SaveToFile(ss);
               

  end;//if SaveDialog1.Execute then 
SaveDialog1.free;
l.clear;

l.free;
l2.free;
l3.free;
end;

end;
 end;//
 

procedure TRedstone_vclscrp.createpanel1;
begin
p1:=tpanel.create(nil);
p1.parent:=f;
with p1 as tpanel do
begin
  Left := 0;
    Top := 0;
    Width := 110;
  //  Height := 375;
    Align := alLeft;
     Color := 16755370; 
    
  //  BevelInner := bvRaised;
    BorderWidth := 1;
 //   BorderStyle := bsSingle;
 //   Caption := 'Panel1';
   Constraints.MinWidth := 100;
  //  TabOrder := 0;
end;

end;

procedure TRedstone_vclscrp.createpanel2;
begin
p2:=tpanel.create(nil);
p2.parent:=f;
with p2 as tpanel do
begin
//
  Left := 188;
    Top := 0;
  //  Width := 355;
  //  Height := 375;
    Align := alClient;
  //     BevelInner := bvRaised;
    BorderWidth := 1;
 //   BorderStyle := bsSingle;
 //   Caption := 'Panel2';
    Constraints.MinWidth := 30;
  //  TabOrder := 1;
  
end;

end;

procedure TRedstone_vclscrp.createsplitter;
begin
sp:=tsplitter.create(nil);
sp.parent:=f;
with sp as tsplitter do
begin
//
  Left := 185;
    Top := 0;
  //  Height := 375;
 //   Beveled := True;
    Color := clsilver;
    width:=3;
 //  autosnap:=true;
//beveled:=false;
//resizestyle:=rsnone;
 //   Color := clsilver;
   
cursor:=crArrow;
end;

end;

procedure TRedstone_vclscrp.writeINFO;
var fileSTR:tstringlist;
begin

fileSTR:=tstringlist.create;
if fileexists(UserCallingINFODIR+'/'+lb1.caption) then 
fileSTR.loadfromfile(UserCallingINFODIR+'/'+lb1.caption)else begin lb2.caption:='';fileSTR.free;exit;end;
lb2.caption:=fileSTR.gettext;
fileSTR.free;
end;
destructor TRedstone_vclscrp.Destroy;

begin
inherited;

end;



initialization
registerclass(TRedstone_vclscrp);
finalization

unregisterclass(TRedstone_vclscrp);
end.
