unit Redstone_pagesetup;

interface

uses
  Qt, QFileCtrls,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types,QButtons, QComCtrls,Libc
  ,RedStone_Public_Comp
  ,PClass_Command_RedStone
  ;

type
  TRedstone_pagesetup = class(TRedStone_Public_Comp)
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
  procedure headertextBBclick(Sender: TObject);
  procedure fontdlgclick(Sender: TObject);
  procedure fontFclick(Sender: TObject);
  //   procedure PCMBClick(Sender: TObject);
  //       procedure PCMBClick(Sender: TObject);
     procedure SpClick(Sender: TObject);
  private
  UserCallingDIR,UserCallingIniconf,UserCallingDataDIR,UserCallingImageDIR,xfgmainTitle:string;
   lbox,lbox2:tlistbox;
  SaveDialog1:tsavedialog;
  HAVE_SAVE_BOOK:boolean;
  previewEXE,papersize,orientation,sides:string;
  pc:TPagecontrol;
  ts1,ts2,ts3:TTabsheet;
    F,fontF:tform;
  memo1:tmemo;
  edit1:tedit;
  gb1,gb2,gb3,gb4,gb5,gb6,gb7,gb8,gb9,gb10,gb11,
  gb12,gb13,gb14,gb15:tgroupbox;
  bookletcmb2,bookletcmb1,bookletcmb3,bookletcmb4,bookletcmb5,cmb1,cmb2,cmb3,cmb4,cmb5,cmb6,cmb7,cmb8,cmb9,cmb10,
  cmb11,cmb12,cmb13,cmb14,cmb15,cmb16,cmb17,cmb18,cmb19,cmb20,cmb21,cmb22,cmb23,cmb24,cmb25,cmb26:tcombobox;
   ckb1,ckb2,ckb3,ckb4,ckb5,ckb6,ckb7,ckb8,ckb9,ckb10,
  ckb11,ckb12:tcheckbox;
    img1,img2,img3,img4,img5,img6,img7,img8:timage;
    lbbooklet1,lbbooklet2,lbbooklet3,lbbooklet4,lbbooklet5:tlabel;
  lb1,lb2,lb3,lb4,lb5,lb6,lb7,lb8,lb9,lb10,lb11,lb12,lb13,lb14,lb15,lb16
  ,lb17,lb18,lb19,lb20,lb21,lb22,lb23,lb24,lb25,lb26,lb27,lb28,lb29,lb30,lb31,lb32,
     lb33,lb34,lb35,lb36,lb37,lb38,lb39,lb40:tlabel;
  sb1,sb2,sb3,sb4:tspeedbutton;
  bb1,bb2,bb3,bb4,bb5,bb6,bb7,bb8,bb9,bb10,bb11,bb12,bb13,bb14,bb15,bb16,bb17,bb18,bb19,bb20,bb21,bb22:tbutton;
  FirstTime,ToBooklet,Detach,ToPS:boolean;
K:TPClass_Command_RedStone;
     p1:tpanel;
     p2:tpanel;
     p3,p4:tpanel;
      sp:TSplitter;
        speedbutton:tspeedbutton;
           FPassStringList, l1,l2:tstringlist;
             ini:Tinifile;
AF:TForm;
  protected

 form2filelist:tfileiconview;
 filelistcheck:tcheckbox;
  ff,fff:tform;
  public
  DEBUG:boolean;
  
    constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
    destructor Destroy; override;
  published

  end;
const
 Iniconf:string='xfg.conf';  

implementation
destructor TRedstone_pagesetup.Destroy;

begin

inherited;



end;

constructor TRedstone_pagesetup.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); 
var  temp:tcomponent;i:integer;
begin
inherited;

DEBUG:=false;
Detach:=false;
HAVE_SAVE_BOOK:=false;
FPassStringList:=nil;
k:=nil;
ini:=nil;
l1:=nil;
l2:=nil;
 application.handle:=nil;
 application.handle:=APass_Handle;
  AF:=APass_Form;
  application.HintPause:=50;
application.HintHidePause:=90000;     

 K:=TPClass_Command_RedStone.Create(application.Handle,APass_Form,application.exename);
//UserCallingDIR:=ExtractFilePath(APass_ExeName);
//UserCallingIniconf:=UserCallingDIR+Iniconf;
//UserCallingDataDIR:=UserCallingDIR+'data/';

//UserCallingDIR:=ExtractFilePath(APass_ExeName);
//UserCallingIniconf:=UserCallingDIR+Iniconf;
//UserCallingDataDIR:=UserCallingDIR+'data/';
//UserCallingDIR:=K.RS_Calling_APPPath+'/';
UserCallingIniconf:=K.RS_AppConfigPath+'/'+K.RS_App_Configuration_Name+'.'+K.RS_App_Configuration_Extension; 
UserCallingDataDIR:=k.RS_APP_data_dir+'/';
UserCallingImageDIR:=k.RS_APP_image_dir+'/';


FirstTime:=true;
ToBooklet:=false;
ToPS:=false;

//application.handle:=APass_Handle;
 previewEXE:='';  
//  constructor Create(ACRS_Handle:QApplicationH;ACRS_Form:TForm;AExeName:String);//override;
 FPassStringList:=tstringlist.create;
FPassStringList.assign(APassStringList); 
l1:=tstringlist.create;
l2:=tstringlist.create;
//ini:=tinifile.create(ExtractFilePath(Application.ExeName) + 'xfg.conf');
ini:=tinifile.create(UserCallingIniconf);

xfgmainTitle:=lowercase(Ini.Readstring ('xfgMain', 'owner', 'none'));
if lowercase(Ini.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then DEBUG:=true;
   if  lowercase(Ini.Readstring ('xfgPrintBooklet', 'pagetopostcript2booklet', 'none'))='true' then 
   ToBooklet:=true;
  // if (APassStringList.count>0)and(APassStringList<>nil)  then


Ini.writestring ('xfgPrintBooklet', 'pagetopostcript2booklet', 'false');


 Ini.ReadSection('xfgOptionsSidePanel',l1); 


 try
     F := TForm.Create (application);
    try
   
//f.parent:=AF;

 // f.position:=poscreencenter;
   f.width:=720;
    f.height:=515;
    f.top:=screen.height-(screen.height-20);
f.left:=50;
       f.Constraints.MinHeight := f.height;
 f.Constraints.MinWidth := f.width;
 f. Constraints.MaxWidth := f.width;
 f.Constraints.MaxHeight :=  f.Constraints.MinHeight;
     for i:=0 to APassStringList.count-1 do
 begin
 if lowercase(trim(APassStringList[i]))='-book' then ToBooklet:=true;
 if lowercase(trim(APassStringList[i]))='-detach' then Detach:=true;
 if lowercase(trim(APassStringList[i]))='-ps' then ToPS:=true;
 
 end;

       createpanel1;
       
        createsplitter;
          createpanel2;
          
          createpagecontrol;
             
          createts1;

 createspeedbutton;
          createts2;
          createts3;
          creatememo;
         


          if lowercase(extractfilename(APass_ExeName))='command_redstone' then    
begin

   
 if Detach=true then 
 begin
 K.crs_checkfilelist(APassStringList);
 //FPassStringList:=tstringlist.create;
 FPassStringList.clear;
FPassStringList.assign(APassStringList);
memo1.text:=FPassStringList.text;
if FPassStringList.count=0 then
begin
 MessageDlg ('Files input error  '+#13#10+#13#10, mtInformation, [mbOK], 0);
//DoClose;

application.terminate;
end;
end;
end;//if lowercase(extractfilename(APass_ExeName))='command_redstone' then     
   ///////////////////////////////////////////////////////////////////
  
           if  lowercase(Ini.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then
           begin
     memo1.lines.Add(K.CRS_Print_Properties2Str);      end ;
     

/////////////////////////////////////////////////////////////////
 fff:=nil;
 
 if Detach=false then 
begin

  for  I := 0 to Screen.FormCount-1 do begin
 if  lowercase(Screen.Forms[I].caption )='redstone commander' then ff:=  Screen.Forms[I];
 if  lowercase(Screen.Forms[I].caption )=xfgmainTitle then fff:=  Screen.Forms[I];
 end;
 
 for I := ff.ComponentCount - 1 downto 0 do
  begin
    temp := ff.Components[I]; 
    if (temp is Tfileiconview) then begin
   form2filelist:=temp as Tfileiconview;break;
    end; end;
   
 temp:=nil;  
 for I := fff.ComponentCount - 1 downto 0 do
  begin
    temp := fff.Components[I];
  if (temp is Tcheckbox) then begin 
    if lowercase((temp as tcheckbox).caption)='files list' then
    filelistcheck:=temp as tcheckbox;break;
end;  end;
//f.caption:=ff.caption+'      '+inttostr(form2filelist.items.count);
end;//if lowercase(ExtractFileName(application.exename))<>'command_redstone' then
///////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////
   F.caption:='Redstone_pagesetup';
            update_page(0); 
             update_page(1); 
              dopreview;
      pc.ActivePage := ts1;

   F.ShowModal;
   
   finally
   
 DoClose;
//if f<>nil then f.close;
    end;   
  
  except
    on E: Exception do begin
      MessageDlg ('Error in Component: '+E.Message, mtInformation, [mbOK], 0);
   
 

  doclose;
//f.close;
        end;
        

  end;
 
end;


  procedure TRedstone_pagesetup.DoClose;
  var
 sr: TSearchRec; 
begin
//if ToBooklet=true then ini.writestring('xfgPrintBooklet','pagetopostcript2booklet','false');
//
     //   memo1.lines.savetofile(ExtractFilePath(Application.ExeName) + 'xfg.conf');
 if FindFirst(UserCallingDataDIR+'*', faAnyFile, sr) = 0 then
    begin
      repeat
      
        if sr.name='Redstone_pagesetup0000.jpg' then deletefile(UserCallingDataDIR+sr.name);
       
      until FindNext(sr) <> 0;
        FindClose(sr);    
     end;
///////////////////////////////////////////////////////////////////////////////////
if detach=false then
if HAVE_SAVE_BOOK=true then ff.show;
if FPassStringList<>nil then FPassStringList.free;
if k<>nil then k.free;
if ini<>nil then ini.free;
if l1<>nil then l1.free;
if l2<>nil then l2.free;
 
 
end;

  procedure TRedstone_pagesetup.headertextBBclick(Sender: TObject);
begin

if (sender as tbutton)=bb2 then 
begin
edit1.text:=edit1.text+StringReplace(bb2.caption,'=','@@@',[rfIgnoreCase]) ;
//edit1.seltext:=StringReplace(bb2.caption,'=','@@@',[rfIgnoreCase]) ;
end
else

with sender as tbutton do
begin
edit1.text:=edit1.text+caption;
//edit1.seltext:=caption;

end;
edit1.SelStart:= length(edit1.text);
edit1.setfocus;
end;


 procedure TRedstone_pagesetup.update_page(state:integer);
 var 
ss,ss1,ss2,ss3,fss:string;
i,m:integer;
 ii:integer;
sssa:string;
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



//enscript
//--ul-style=filled
//--ul-position=+40+60
//--ul-gray=.8
//--ul-font=sans200
//--ul-angle=45
//--underlay='this
//is
//redstonr
//org
//computer'
//--highlight-bars=2
//--line-numbers1
//--nup=1
//-MA4
//--header='current
//working
//directory=%d
//current
//time=%C
//current
//date=%D
//$n
//%W
//Page
//$%
//of
//$='
//--word-wrap
//--margins=50:50:36:36
//--mark-wrapped-lines=arrow
//--output=%out
//%in


//
//enscript --ul-style=filled --ul-position=+40+60 --ul-gray=.8 --ul-font=sans200 
//         --ul-angle=45 --underlay='this is redstonr org computer' --highlight-bars=2 
//         --line-numbers=1 --nup=1 -MA4 
//         --header='current working directory=%d current time=%C current date=%D $n %W Page $% of $=' 
//         --word-wrap --margins=50:50:36:36 --mark-wrapped-lines=arrow --output=%out %in

// Pos(Substr: string; S: string):




///////////////////////////////////////////////////////////////////////////////////////////////
if state=0 then
begin
//l1.clear;

ss:='';
ss:=  ini.ReadString ('xfgMainButton', 'pagetopostcript', ''); 
ss:='{'+ss+'}';
k.CRS_GetProcList(ss,'{','}',' ',l1);
//memo1.lines.clear;
//  memo1.visible:=true;

 if  lowercase(Ini.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then
 begin
 memo1.lines.add('  ');
 memo1.lines.add('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
 memo1.lines.add('  ');
  memo1.lines.add('update_page(0)');
   memo1.lines.add('  ');
 for i:=0 to l1.count -1 do
 memo1.lines.add(l1.Strings[i]);

end;

for i:=0 to l1.count-1 do
begin
m:=0;
//ss1:='';
ss1:='{'+(l1.Strings[i])+'}';



if  Pos('--underlay',ss1)<>0 then                    //--underlay='..........................'
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
if Pos('''',Copy(ss,  2, length(ss)))<>0 
then cmb17.text:=Copy(ss,  2, length(ss)-2) else
begin
m:=i;
repeat 
m:=m+1;
ss:=ss+' '+l1.Strings[m];

until Pos('''',l1.Strings[m])<>0;
cmb17.text:=Copy(ss,  2, length(ss)-2);

end;
//F.caption:=Copy(ss,  2, length(ss)-2);
end;



if  Pos('--header',ss1)<>0 then                        //--header='..........................'
begin
ss1:=StringReplace(ss1,'$=','$@@@',[rfIgnoreCase]) ;
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
if Pos('''',Copy(ss,  2, length(ss)))<>0 
then edit1.text:=Copy(ss,  2, length(ss)-2) else
begin
m:=i;
repeat 
m:=m+1;

ss:=ss+' '+l1.Strings[m];

until Pos('''',l1.Strings[m])<>0;
edit1.text:=Copy(ss,  2, length(ss)-2);

end;
//lb12.caption:=Copy(ss,  2, length(ss)-2);
end;



if  Pos('--nup',ss1)<>0 then                           //--nup=1
cmb5.text:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);

if  Pos('--margins',ss1)<>0 then                       //--margins=left:right:top:bottom
begin
ss:='{'+k.CRS_GetParamAtPos(ss1,'{','}','=',2)+'}';

cmb6.text:=k.CRS_GetParamAtPos(ss,'{','}',':',1);
cmb7.text:=k.CRS_GetParamAtPos(ss,'{','}',':',2);
cmb8.text:=k.CRS_GetParamAtPos(ss,'{','}',':',3);
cmb9.text:=k.CRS_GetParamAtPos(ss,'{','}',':',4);
end;

if  Pos('--borders',ss1)<>0 then 
begin
//ss:='{'+k.CRS_GetParamAtPos(ss1,'{','}','=',2)+'}';

cmb10.text:='Yes'; 
end;
if  Pos('--columns',ss1)<>0 then                        //--columns=1
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb3.text:=ss;
end;

if  Pos('--pages',ss1)<>0 then                          //--pages=pages
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb11.text:=ss;
end;

if  Pos('--no-header',ss1)<>0 then                        //--no-header
begin 
//ss:='{'+k.CRS_GetParamAtPos(ss1,'{','}','=',2)+'}';
cmb12.text:='No';l2.add('--no-header');
end;

if  Pos('--landscape',ss1)<>0 then //                     //--landscape
begin
//ss:='{'+k.CRS_GetParamAtPos(ss1,'{','}','=',2)+'}';
cmb2.text:='Landscape' ;
end;

if  Pos('--portrait',ss1)<>0 then                        // --portrait
begin 
//ss:='{'+k.CRS_GetParamAtPos(ss1,'{','}','=',2)+'}';
cmb2.text:='Portrait';
end;

if  Pos('--media',ss1)<>0 then                             // --media=A4
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb1.text:=ss;
end;

if  Pos('--file-align',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb13.text:=ss;
end;

if  Pos('--word-wrap',ss1)<>0 then                             //file-align
begin
cmb14.text:='Yes';
end;

if  Pos('--mark-wrapped-lines',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb15.text:=ss;
end;

if  Pos('--ul-style',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb18.text:=ss;
end;
if  Pos('--ul-position',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb19.text:=ss;
end;
if  Pos('--ul-gray',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb20.text:=ss;

end;
if  Pos('--ul-angle',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb21.text:=ss;

end;

if  Pos('--highlight-bars',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb22.text:=ss;

end;
if  Pos('--highlight-bar-gray',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
cmb23.text:=ss;
end;
if  Pos('--ul-font',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
lb37.caption:=ss;
fss:='{'+ss+'}';
//lb37.font.name:=k.CRS_GetParamAtPos(fss,'{','}','@',1);
//lb37.font.size:=strtoint(k.CRS_GetParamAtPos(fss,'{','}','@',2));
end;
if  Pos('--font',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
lb11.caption:=ss;
fss:='{'+ss+'}';
//lb11.font.name:=k.CRS_GetParamAtPos(fss,'{','}','@',1);
//lb11.font.size:=strtoint(k.CRS_GetParamAtPos(fss,'{','}','@',2));
end;
if  Pos('--header-font',ss1)<>0 then                             //file-align
begin
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
lb12.caption:=ss;
fss:='{'+ss+'}';
//lb12.font.name:=k.CRS_GetParamAtPos(fss,'{','}','@',1);
//lb12.font.size:=strtoint(k.CRS_GetParamAtPos(fss,'{','}','@',2));
end;

//l2.add('--font='+lb11.caption));
//l2.add('--ul-font'+lb37.caption));
//l2.add('--header-font='+lb12.caption));
//--font=name
//--header-font=name
//--ul-font
// sb3=lb37  underlay  // sb2=lb12  header  // sb1=lb11  textend;
end;
end; //if state=0 then 
///////////////////////////////////////////////////////////////////////////////////////


if state=1 then 
begin 
sides:='';
orientation:='';
papersize:='';
l2.clear;
l2.add('--font='+lb11.caption);
l2.add('--ul-font='+lb37.caption);
l2.add('--header-font='+lb12.caption);
l2.add('--columns='+cmb3.text);
l2.add('--media='+cmb1.text);

if cmb14.text='Yes' then begin 
l2.add('--word-wrap');
l2.add('--mark-wrapped-lines='+cmb15.text);
end;

if Pos('$@@@',edit1.text)<>0 then 
l2.add('--header='+''''+StringReplace(edit1.text,'$@@@','$=',[rfIgnoreCase])+'''')else
l2.add('--header='+''''+edit1.text+'''');

l2.add('--nup='+cmb5.text);
l2.add('--margins='+cmb6.text+':'+cmb7.text+':'+cmb8.text+':'+cmb9.text);
l2.add('--file-align='+cmb13.text);
if cmb10.text='Yes' then l2.add('--borders');
if cmb11.text<>'All pages' then 
  l2.add('--pages='+lowercase(Copy(cmb11.text,  0, length(cmb11.text)-length(' pages'))));
if cmb12.text='No' then l2.add('--no-header');
if cmb2.text='Landscape' then l2.add('--landscape');
if cmb2.text='Portrait' then l2.add('--portrait');
l2.add('--underlay='+''''+cmb17.text+'''');
l2.add('--ul-style='+cmb18.text);
l2.add('--ul-position='+cmb19.text);
l2.add('--ul-gray='+cmb20.text);
l2.add('--ul-angle='+cmb21.text);
l2.add('--highlight-bars='+cmb22.text);
l2.add('--highlight-bar-gray='+cmb23.text);

//--font=name
//--header-font=name
//--ul-font
// sb3=lb37  underlay  // sb2=lb12  header  // sb1=lb11  text
sssa:='enscript ';
for ii:=0 to l2.count-1 do 
begin
ss1:='{'+(l2.Strings[ii])+'}';

if  (Pos('--file-align',l2.Strings[ii])<>0) then                             // --media=A4
begin
//if strtoint(k.CRS_GetParamAtPos(ss1,'{','}','=',2)) <> 1 then
//sides:='sides';
end;
if  (Pos('--landscape',l2.Strings[ii])<>0) then                             // --media=A4
begin
orientation:='landscape';
end;
if  (Pos('--portrait',l2.Strings[ii])<>0)then                             // --media=A4
begin
orientation:='portrait';
end;
if  Pos('--media',l2.Strings[ii])<>0 then                             // --media=A4
begin
papersize:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
end;
if  (Pos('--nup=',l2.Strings[ii])<>0) then                             // --media=A4
begin
if ((k.CRS_GetParamAtPos(ss1,'{','}','=',2)) = '2')
or ((k.CRS_GetParamAtPos(ss1,'{','}','=',2)) = '8')
or ((k.CRS_GetParamAtPos(ss1,'{','}','=',2)) = '12')
or ((k.CRS_GetParamAtPos(ss1,'{','}','=',2)) = '32')
then 
sides:='sides';
end;
sssa:=sssa+l2.Strings[ii]+' ';
end;



//sssa:=sssa+' --file-align=1 ';
previewEXE:=sssa;
sssa:=sssa+' --output=%out %in';
ini.writestring ('xfgMainButton', 'pagetopostcript', sssa); 
ini.UpdateFile;

 if  lowercase(Ini.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then
 begin
 memo1.lines.add('  ');
 memo1.lines.add('++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
 memo1.lines.add('  ');
  memo1.lines.add('update_page(1)');
   memo1.lines.add('  ');
 for i:=0 to l2.count -1 do
 memo1.lines.add(l2.Strings[i]);
//memo1.lines.assign(l2);
memo1.lines.add(' --output=%out %in');
memo1.lines.add('Strings to write : '+sssa);
end;



pc. ActivePage := ts1;
end;

end;





  procedure TRedstone_pagesetup.dopreview;
  var index,w,h,iii:integer; 
  ss:pchar;                       //  ExtractFilePath(Application.ExeName                           dopreview  ********************

 begin 

//Redstone_pagesetup0000.jpg.1
// if FindFirst(UserCallingDataDIR+'Redstone_pagesetup0000.jpg.0', faAnyFile, sr) =0 
//  then deletefile(UserCallingDataDIR+'Redstone_pagesetup0000.jpg.0');
//  FindClose(sr);
// if FindFirst(UserCallingDataDIR+'*', faAnyFile, sr) = 0 then
//    begin
//      repeat
    //  if (sr.Attr and faDirectory) =0 then
     //   begin
       
//       if pos('Redstone_pagesetupTMP',sr.name)<>0  then
      //  if sr.name='Redstone_pagesetup0000.jpg.0' then 
//        begin 
//      deletefile(UserCallingDataDIR+sr.name);
//        memo1.lines.add('Deleting   '+sr.name+ '   in TRedstone_pagesetup.dopreview');
//        end;
      //  end;
//      until FindNext(sr) <> 0;
//        FindClose(sr);    end;
        
/////////////////////////////////////////////////////
if fileexists(UserCallingDataDIR+'Redstone_pagesetup0000.jpg')<>true then
firsttime:=false;
if firsttime=true then  
begin
try
img1.picture.loadfromfile(UserCallingDataDIR+'Redstone_pagesetup0000.jpg'); 
except
;
end;
firsttime:=false;
end
else
begin 
 
 iii:=0;
ss:=pchar(previewEXE+' --output='+UserCallingDataDIR+'Redstone_pagesetup0000.ps '
                   +UserCallingimageDIR+'Redstone_pagesetup.txt');

  
//memo1.lines.add('previewEXE'+' '+ss);orientation
Libc.system(ss);

if  ( papersize='A3')   then begin w:=164; h:=232;end;
if (papersize='A4')  then begin w:=164; h:=232;end;
if (papersize='A5') then begin w:=116; h:=165;end;
if papersize='Letter' then  begin w:=164; h:=214;end;
if papersize='Legal' then  begin w:=164; h:=273;end;



        
if (orientation='landscape') and not (sides='sides')then 
begin
ss:=pchar('/usr/bin/convert -page '+papersize+' '+UserCallingDataDIR+
                'Redstone_pagesetup0000.ps  -resize '+inttostr(w)+'x'+inttostr(h)+
                 ' -rotate 90 '+UserCallingDataDIR+'Redstone_pagesetup0000.jpg');
end;


if (orientation='portrait')then 
begin
ss:=pchar('/usr/bin/convert -page '+papersize+' '+UserCallingDataDIR+
                    'Redstone_pagesetup0000.ps  -resize '+inttostr(w)+'x'+inttostr(h)
                     +' '+UserCallingDataDIR+'Redstone_pagesetup0000.jpg');
end;

if (sides='sides')and not (orientation='landscape') then 
begin
ss:=pchar('/usr/bin/convert -page '+papersize+' '+UserCallingDataDIR+
                 'Redstone_pagesetup0000.ps  -resize '+inttostr(w)+'x'+inttostr(h)+
                 ' -rotate 90 '+UserCallingDataDIR+'Redstone_pagesetup0000.jpg');
end;

if ((sides='sides')and (orientation='landscape'))then 
begin
ss:=pchar('/usr/bin/convert -page '+papersize+' '+UserCallingDataDIR+
                    'Redstone_pagesetup0000.ps  -resize '+inttostr(w)+'x'+inttostr(h)+
                     ' -rotate 180 '+' '+UserCallingDataDIR+'Redstone_pagesetup0000.jpg');
end;


Libc.system(ss);
     with img1 as timage do
   begin
   repaint;
  if fileexists(UserCallingDataDIR+'Redstone_pagesetup0000.jpg.0') = true then
    begin
        iii:=1;
        end;
       
        
if iii=1 then   begin 
RenameFile(UserCallingDataDIR+'Redstone_pagesetup0000.jpg.0', UserCallingDataDIR+'Redstone_pagesetup0000.jpg');
memo1.lines.add('Renaming   '+UserCallingDataDIR+'Redstone_pagesetup0000.jpg.0'+ '   in TRedstone_pagesetup.dopreview');
try  
picture.loadfromfile(UserCallingDataDIR+'Redstone_pagesetup0000.jpg');
except
;
end;
  end;
 if iii=0 then   
 try    
 picture.loadfromfile(UserCallingDataDIR+'Redstone_pagesetup0000.jpg'); 
 except
;
end;     
 
    end;






end;
iii:=0;
    pc.ActivePage := ts1;
    



end;

procedure TRedstone_pagesetup.createpagecontrol; 
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
 
procedure TRedstone_pagesetup.createts1; 

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
 
//////////////////////////////////////////////////////////
 gb1:=tgroupbox.create(application);
with gb1 as tgroupbox  do
begin
parent:=p3;
 
 Left := 8;
          Top := 8;
          Width := 380+8;
          Height := 403;
          Caption := 'Page size';
          

   img1:=timage.create(nil);
   with img1 as timage do
   begin
  
       parent:=gb1;
      Width :=280;//193
        //    Height := 116*index;//177
          Height := 280;//177
        
            Left := (gb1.width div 2)-(width div 2);
          Top := 5;
          
         Center := True;
           Stretch := false;
           Transparent := false;
       
        
            end;
  cmb1:=tcombobox.create(nil);           
 with cmb1 as tcombobox do
 begin
     parent:=gb1;
            Left := 75;
            Top := 272;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'A3');
          Items.add( 'A4');
        Items.add( 'A5');
        Items.add( 'Letter');
         Items.add( 'Legal');
            ItemIndex := 0;
         
        //    Text := 'A3';
       end;
            
   //   Caption := 'Orientation';
          
 cmb2:=tcombobox.create(nil);           
 with cmb2 as tcombobox do
 begin
     parent:=gb1;
            Left :=75;
            Top := 304;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'Portrait');  
            
         Items.add( 'Landscape');
       
      ItemIndex := 0;
         
    
       end;
       
if (tobooklet=true) then 
begin      

  bookletcmb1:=tcombobox.create(nil);           
 with bookletcmb1 as tcombobox do
 begin
     parent:=gb1;
            Left := 75;
            Top := 336;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'A3');
          Items.add( 'A4');
        Items.add( 'A5');
        Items.add( 'B5');
        Items.add( 'tabloid');
        Items.add( 'statement');
        Items.add( 'executive');
        Items.add( 'Letter');
        Items.add( 'Legal');
        Items.add( 'folio');
        Items.add( 'quarto');
        Items.add( '10x14');
         
            ItemIndex := 1;
         
        //    Text := 'A3';
       end;
            
      //  Caption := 'Column';
bookletcmb2:=tcombobox.create(nil);           
 with bookletcmb2 as tcombobox do
 begin
     parent:=gb1;
            Left := 75;
            Top := 368;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'row-major');  
            
         Items.add( 'column-major');
  
     ItemIndex := 0;
         
    
       end;
bookletcmb5:=tcombobox.create(nil);           
 with bookletcmb5 as tcombobox do
 begin
     parent:=gb1;
            Left := 262;
            Top := 336;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
          Style := csDropDownList;
            ItemHeight := 17;
       Items.add( '2');
       Items.add( '4');
      
       Items.add( '8');
   
    Items.add( '16');
        Items.add( '32');
           Items.add( '64');
     ItemIndex := 0;
         
    
       end;       
 lbbooklet1:=tlabel.create(nil);
   with lbbooklet1 as tlabel  do
   begin    
   parent:=gb1;
            Left := 5;
            Top := 345;
            Width := 65;
            Height := 15;
            color:=43775;
           
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Book size';
            Layout := tlCenter;
          end;
 lbbooklet2:=tlabel.create(nil);
   with lbbooklet2 as tlabel  do
   begin    
   parent:=gb1;
            Left := 5;
            Top := 377;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            color:=43775;
           
            Caption := 'Book layout';
            Layout := tlCenter;
          end;         
lbbooklet5:=tlabel.create(nil);
   with lbbooklet5 as tlabel  do
   begin    
   parent:=gb1;
            Left := 193;
            Top := 345;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            color:=43775;
           
            Caption := 'Book N-up';
            Layout := tlCenter;
          end;         

      
end;
  //       Caption := 'N-up';
          
cmb3:=tcombobox.create(nil);           
 with cmb3 as tcombobox do
 begin
     parent:=gb1;
            Left := 262;
            Top := 272;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
            Items.add( '1');  
            
         Items.add( '2');
        Items.add( '3');
       Items.add( '4');
        Items.add( '5');
       Items.add( '6');
       Items.add( '7');
       Items.add( '8');
       Items.add( '9');
       Items.add( '10');
                   Items.add( '11');  
            
         Items.add( '12');
        Items.add( '13');
       Items.add( '14');
        Items.add( '15');
       Items.add( '16');
       Items.add( '17');
       Items.add( '18');
       Items.add( '19');
       Items.add( '20');
     ItemIndex := 0;
         
    
       end;
       

  //       Caption := 'N-up';
          
 cmb5:=tcombobox.create(gb1);           
 with cmb5 as tcombobox do
 begin
     parent:=gb1;
            Left := 262;
            Top := 304;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
            Items.add( '1');  
       Items.add( '2');
       Items.add( '4');
      
       Items.add( '8');
   
    Items.add( '16');
        Items.add( '32');
           Items.add( '64');
     ItemIndex := 0;
         
    
       end;
       

       
        lb13:=tlabel.create(nil);
   with lb13 as tlabel  do
   begin    
   parent:=gb1;
            Left := 5;
            Top := 281;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Paper size';
            Layout := tlCenter;
          end;
lb14:=tlabel.create(nil);
   with lb14 as tlabel  do
   begin    
   parent:=gb1;
            Left := 5;
            Top := 313;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Orientation';
            Layout := tlCenter;
          end;
          

  lb15:=tlabel.create(nil);
   with lb15 as tlabel  do
   begin    
   parent:=gb1;
            Left := 193;
            Top := 281;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Column';
            Layout := tlCenter;
          end;
lb16:=tlabel.create(nil);
   with lb16 as tlabel  do
   begin    
   parent:=gb1;
            Left :=193;
            Top := 313;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'N-up';
            Layout := tlCenter;
          end;
          

end;//with gb1 as tgroupbox  do


//////////////////////////////////////////////////////////////
 gb3:=tgroupbox.create(application);
with gb3 as tgroupbox  do
begin
parent:=p3;
 Left := 400;
          Top := 8;
          Width := 193;
          Height := 403;
              Caption := 'Page format';
  cmb6:=tcombobox.create(gb6);           
 with cmb6 as tcombobox do
 begin
      //       Left := 8;
      //      Top := 144;
       //     Width := 177;
       //     Height := 23;
 
     parent:=gb3;
            Left := 75;
            Top := 16;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( '10');  
       Items.add( '20');
       Items.add( '30');
       Items.add( '40');
       Items.add( '50');
        Items.add( '60');
       Items.add( '70');
       Items.add( '80');
       Items.add( '90');
       Items.add( '100');
  
     ItemIndex := 0;
         
    
       end;
       

 cmb7:=tcombobox.create(nil);           
 with cmb7 as tcombobox do
 begin
     parent:=gb3;
            Left := 75;
            Top := 48;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( '10');  
       Items.add( '20');
       Items.add( '30');
       Items.add( '40');
       Items.add( '50');
        Items.add( '60');
       Items.add( '70');
       Items.add( '80');
       Items.add( '90');
       Items.add( '100');
  
     ItemIndex := 0;
       end;
       


 cmb8:=tcombobox.create(nil);           
 with cmb8 as tcombobox do
 begin
     parent:=gb3;
            Left := 75;
            Top := 80;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( '10');  
       Items.add( '20');
       Items.add( '30');
       Items.add( '40');
       Items.add( '50');
        Items.add( '60');
       Items.add( '70');
       Items.add( '80');
       Items.add( '90');
       Items.add( '100');
  
     ItemIndex := 0;
       end;
 cmb9:=tcombobox.create(nil);           
 with cmb9 as tcombobox do
 begin
     parent:=gb3;
            
            Left := 75;
            Top :=112;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( '10');  
       Items.add( '20');
       Items.add( '30');
       Items.add( '40');
       Items.add( '50');
        Items.add( '60');
       Items.add( '70');
       Items.add( '80');
       Items.add( '90');
       Items.add( '100');
  
     ItemIndex := 0;
       end;
 cmb10:=tcombobox.create(nil);           
 with cmb10 as tcombobox do
 begin
     parent:=gb3;
            Left := 75;
            Top :=144;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'No');  
       Items.add( 'Yes');
       ItemIndex := 0;
       end;
       

    cmb11:=tcombobox.create(nil);           
 with cmb11 as tcombobox do
 begin
     parent:=gb3;
            Left := 75;
            Top := 176;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
              Items.add( 'All pages');
       Items.add( 'Odd pages');
       Items.add( 'Even pages');
     
     ItemIndex := 0;
         
    
       end;
       
 cmb12:=tcombobox.create(nil);           
 with cmb12 as tcombobox do
 begin
     parent:=gb3;
            Left := 75;
            Top := 208;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
               Items.add( 'Yes');
            Items.add( 'No');  
    
 
  
     ItemIndex := 0;
       end;
       


 cmb13:=tcombobox.create(nil);           
 with cmb13 as tcombobox do
 begin
     parent:=gb3;
            Left :=75;
            Top := 240;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( '1');  
       Items.add( '2');
    
     ItemIndex := 0;                                            //file-align
       end;
 cmb14:=tcombobox.create(nil);           
 with cmb14 as tcombobox do
 begin
     parent:=gb3;
            Left :=75;
            Top :=272;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
           Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'No');  
       Items.add( 'Yes');
    
  
     ItemIndex := 0;
       end;
 cmb15:=tcombobox.create(nil);           
 with cmb15 as tcombobox do
 begin
     parent:=gb3;
            Left :=75;
            Top :=304;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'none');  
       Items.add( 'plus');
       Items.add( 'box');
       Items.add( 'arrow');
       ItemIndex := 0;
       end;
       

if (tobooklet=true) then 
begin  
         
  bookletcmb3:=tcombobox.create(nil);           
 with bookletcmb3 as tcombobox do
 begin
     parent:=gb3;
            Left := 75;
            Top := 336;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
         //   Style := csDropDownList;
            ItemHeight := 17;
                  Items.add( '0');  
            Items.add( '10');  
       Items.add( '20');
       Items.add( '30');
       Items.add( '40');
       Items.add( '50');
        Items.add( '60');
       Items.add( '70');
       Items.add( '80');
       Items.add( '90');
       Items.add( '100');
     ItemIndex := 0;
         
    
       end;
       bookletcmb4:=tcombobox.create(nil);           
 with bookletcmb4 as tcombobox do
 begin
     parent:=gb3;
            Left := 75;
            Top := 368;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
         //   Style := csDropDownList;
            ItemHeight := 17;
   
             Items.add( '0');  
            Items.add( '1');  
            
         Items.add( '2');
        Items.add( '3');
       Items.add( '4');
        Items.add( '5');
       Items.add( '6');
       Items.add( '7');
       Items.add( '8');
       Items.add( '9');
       Items.add( '10');
                   Items.add( '11');  
            
         Items.add( '12');
        Items.add( '13');
       Items.add( '14');
        Items.add( '15');
       Items.add( '16');
       Items.add( '17');
       Items.add( '18');
       Items.add( '19');
       Items.add( '20');
     ItemIndex := 0;
         
       end;  
       
lbbooklet3:=tlabel.create(nil);
   with lbbooklet3 as tlabel  do
   begin    
   parent:=gb3;
            Left := 6;
            Top := 345;
            Width := 70;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            color:=43775;
           
            Caption := 'Book margin';
            Layout := tlCenter;
          end;         
lbbooklet4:=tlabel.create(nil);
   with lbbooklet4 as tlabel  do
   begin    
   parent:=gb3;
            Left := 6;
            Top := 377;
            Width := 70;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            color:=43775;
           
            Caption := 'Draw border';
            Layout := tlCenter;
          end;         
 
       
end;            
  lb1:=tlabel.create(nil);
   with lb1 as tlabel  do
   begin    
   parent:=gb3;
            Left := 6;
            Top := 24;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Left';
            Layout := tlCenter;
          end;
lb2:=tlabel.create(nil);
   with lb2 as tlabel  do
   begin    
   parent:=gb3;
            Left := 6;
            Top := 56;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Right';
            Layout := tlCenter;
          end;

lb3:=tlabel.create(nil);
   with lb3 as tlabel  do
   begin    
   parent:=gb3;
            Left := 6;
            Top := 88;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Top';
            Layout := tlCenter;
          end;
lb4:=tlabel.create(nil);
   with lb4 as tlabel  do
   begin    
   parent:=gb3;
            Left := 6;
            Top := 120;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Bottom';
            Layout := tlCenter;
          end;
          
lb5:=tlabel.create(nil);
   with lb5 as tlabel  do
   begin    
   parent:=gb3;
            Left := 6;
            Top := 152;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Print border';
            Layout := tlCenter;
          end;
          
        


lb6:=tlabel.create(nil);
   with lb6 as tlabel  do
   begin    
   parent:=gb3;
            Left :=6;
            Top := 185;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'Page order';
            Layout := tlCenter;
          end;
lb7:=tlabel.create(nil);
   with lb7 as tlabel  do
   begin    
   parent:=gb3;
            Left :=6;
            Top :=217;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'Print header';
            Layout := tlCenter;
          end;

lb8:=tlabel.create(nil);
   with lb8 as tlabel  do
   begin    
   parent:=gb3;
            Left :=8;
            Top := 249;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Face sides';
            Layout := tlCenter; 
 
          end;
lb9:=tlabel.create(nil);
   with lb9 as tlabel  do
   begin    
   parent:=gb3;
            Left :=6;
            Top := 281;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'word-wrap';
            Layout := tlCenter;
          end;
          
lb10:=tlabel.create(nil);
   with lb10 as tlabel  do
   begin    
   parent:=gb3;
            Left :=6;
            Top := 313;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'wrap icon';
            Layout := tlCenter;
          end;
          

end;//with gb3 as tgroupbox  do

//////88888 gb6:=tgroupbox.create(nil);888888888888888888888888888888888888888888888888888888

 gb7:=tgroupbox.create(nil);
 with gb7 do
 begin
 parent:=p3;
   Left := 8;
     Left := 8;
          Top := 416;
          Width := 577+8;
          Height := 57;
       {   Top := 360-6;
          Width := 577+8;
          Height := 57;
          }
          Caption := 'Text font';
       
        //  TabOrder := 5;

   
     sb1:=TSpeedButton.create(nil);
     with sb1 do
     begin
      parent:=gb7;
            Left := 16;
            Top := 16;
            Width := 161;
            Height := 33;
            name:='sb1';
            Caption := 'Choose font';
       //     Glyph.Data = {
           Margin := 7;
            Spacing := 12;
           
                   try
            Glyph.loadfromfile(UserCallingImageDIR+'fonts.png');
            except
            ;
            end;
   onclick:=fontdlgclick;
          end;
          
   lb11:=tlabel.create(nil);       
      with lb11 do
      begin
        parent:=gb7;
            Left := 192;
            Top := 22;
            Width := 377;
            Height := 33;
            AutoSize :=True;
            Caption := 'Text font';
            Masked := True;
            Transparent := True;
            Layout := tlCenter;
          end;

end;//////88888 gb7:=tgroupbox.create(nil);888888888888888888888888888888888888888888888888888888


       
end;
   end;
        
end;










   //   TabVisible := (PageIndex mod 2 = 0);
    //    Caption := 'PageIndex: ' +
     //   IntToStr(PageIndex) + '  TabIndex: ' +
    //      IntToStr(TabIndex);  
    //      color:= 15059399+(i*100);
        //  onshow:=tabshow; 
 //       parentfont:=false;
       //   BorderWidth:=5;
//OnHide:=tabhide;   
  

 
procedure TRedstone_pagesetup.createts2; 
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


 gb9:=tgroupbox.create(nil);
with gb9 as tgroupbox  do
begin
parent:=p4;
 Left := 8;
          Top := 8;
          Width := 193;
          Height := 340;
              Caption := 'Underlay text';
  cmb17:=tcombobox.create(nil);           
 with cmb17 as tcombobox do
 begin
      //       Left := 8;
      //      Top := 144;
       //     Width := 177;
       //     Height := 23;
 
     parent:=gb9;
            Left := 75;
            Top := 16;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
         Items.add( 'Important');  
       Items.add( 'Confidential');
                 Items.add( 'DONE');  
                     Items.add( 'Banned');
                   Items.add( 'Who are you');  
                     Items.add( 'I love you');  
                       Items.add( 'Every good man must die for your country');  
   

     ItemIndex := 0;
         
    
       end;
       

 cmb18:=tcombobox.create(nil);           
 with cmb18 as tcombobox do
 begin
     parent:=gb9;
            Left := 75;
            Top := 48;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
           Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'filled');  
     Items.add( 'outline');   
  
     ItemIndex := 0;
       end;
       


 cmb19:=tcombobox.create(nil);           
 with cmb19 as tcombobox do
 begin
     parent:=gb9;
            Left := 75;
            Top := 80;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( '+40+60');  
       Items.add( '+20+30');
      
     ItemIndex := 0;
       end;
 cmb20:=tcombobox.create(nil);           
 with cmb20 as tcombobox do
 begin
     parent:=gb9;
            
            Left := 75;
            Top :=112;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
          Style := csDropDownList;
            ItemHeight := 17;
             Items.add( '.1');  
            Items.add( '.2');
              Items.add( '.3');  
       Items.add( '.4');
         Items.add( '.5');  
       Items.add( '.6');
         Items.add( '.7');  
            Items.add( '.8');  
              Items.add( '.9');  
       Items.add( '1');
     
  
     ItemIndex := 0;
       end;
 cmb21:=tcombobox.create(nil);           
 with cmb21 as tcombobox do
 begin
     parent:=gb9;
            Left := 75;
            Top :=144;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
            Items.add( '10');  
       Items.add( '20');
                 Items.add( '30');
       Items.add( '40');
       Items.add( '50');
            Items.add( '60');  
       Items.add( '70');
               Items.add( '80');
       Items.add( '90');
    
     
       ItemIndex := 0;
       end;
       

    cmb22:=tcombobox.create(nil);           
 with cmb22 as tcombobox do
 begin
     parent:=gb9;
            Left := 75;
            Top := 176;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
                  Items.add( '1');
              Items.add( '2');
                   Items.add( '3');
       Items.add( '4');
                  Items.add( '5');
        Items.add( '6');
                   Items.add( '7');
         Items.add( '8');
                   Items.add( '9');
       Items.add( '10');
     
     ItemIndex := 0;
         
    
       end;
       
 cmb23:=tcombobox.create(nil);           
 with cmb23 as tcombobox do
 begin
     parent:=gb9;
            Left := 75;
            Top := 208;
            Width := 113;
            Height := 23;
            Cursor := crHandPoint;
            Style := csDropDownList;
            ItemHeight := 17;
              Items.add( '.1');  
            Items.add( '.2');
              Items.add( '.3');  
       Items.add( '.4');
         Items.add( '.5');  
       Items.add( '.6');
         Items.add( '.7');  
            Items.add( '.8');  
              Items.add( '.9');  
       Items.add( '1');
 
     ItemIndex := 0;
       end;
       


            
  lb13:=tlabel.create(nil);
   with lb13 as tlabel  do
   begin    
   parent:=gb9;
            Left := 6;
            Top := 24;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Text';
            Layout := tlCenter;
          end;
lb13:=tlabel.create(nil);
   with lb13 as tlabel  do
   begin    
   parent:=gb9;
            Left := 6;
            Top := 56;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Style';
            Layout := tlCenter;
          end;

lb14:=tlabel.create(nil);
   with lb14 as tlabel  do
   begin    
   parent:=gb9;
            Left := 6;
            Top := 88;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Position';
            Layout := tlCenter;
          end;
lb15:=tlabel.create(nil);
   with lb15 as tlabel  do
   begin    
   parent:=gb9;
            Left := 6;
            Top := 120;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Gray';
            Layout := tlCenter;
          end;
          
lb16:=tlabel.create(nil);
   with lb16 as tlabel  do
   begin    
   parent:=gb9;
            Left := 6;
            Top := 152;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := False;
            Caption := 'Angle';
            Layout := tlCenter;
          end;
          
        


lb17:=tlabel.create(nil);
   with lb17 as tlabel  do
   begin    
   parent:=gb9;
            Left :=6;
            Top := 185;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'Bars height';
            Layout := tlCenter;
          end;
lb18:=tlabel.create(nil);
   with lb18 as tlabel  do
   begin    
   parent:=gb9;
            Left :=6;
            Top :=217;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'Bars gray';
            Layout := tlCenter;
          end;



end;//with gb9 as tgroupbox  do



 gb10:=tgroupbox.create(nil);
with gb10 as tgroupbox  do
begin
parent:=p4;
 Left := gb9.width+6;
          Top := 8;
          Width := 393;
          Height := 340;
          Caption := 'Header text';
bb1:=Tbutton.create(nil);
with bb1 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := 16;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '$%';
            color:=clbutton;
            font.color:=clblack;          
          end;
  lb19:=tlabel.create(nil);
   with lb19 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top := 16;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current page number';
            Layout := tlCenter;
          end;
bb2:=Tbutton.create(nil);
with bb2 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb1.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '$=';
            color:=clbutton;
            font.color:=clblack;          
          end;
lb20:=tlabel.create(nil);
   with lb20 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top := lb19.top+15;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize :=  true;
            Caption := 'number of pages in the current file';
            Layout := tlCenter;
          end;
bb3:=Tbutton.create(nil);
with bb3 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb2.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%C';
            color:=clbutton;
            font.color:=clblack;          
          end;
lb21:=tlabel.create(nil);
   with lb21 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top := lb20.top+15;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current time in ''''hh:mm:ss'''' format';
            Layout := tlCenter;
          end;
bb4:=Tbutton.create(nil);
with bb4 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb3.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%d';
            color:=clbutton;
            font.color:=clblack;          
          end;
lb22:=tlabel.create(nil);
   with lb22 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top := lb21.top+15;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current working directory';
            Layout := tlCenter;
          end;
bb5:=Tbutton.create(nil);
with bb5 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb4.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%D';
            color:=clbutton;
            font.color:=clblack;          
          end;          
lb23:=tlabel.create(nil);
   with lb23 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top := lb22.top+15;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current date in ''''yy-mm-dd'''' format';
            Layout := tlCenter;
          end;
          
        

bb6:=Tbutton.create(nil);
with bb6 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb5.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%E';
            color:=clbutton;
            font.color:=clblack;          
          end;          
lb24:=tlabel.create(nil);
   with lb24 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top := lb23.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current date in ''''yy/mm/dd'''' format';
            Layout := tlCenter;
          end;
bb7:=Tbutton.create(nil);
with bb7 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb6.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%F';
            color:=clbutton;
            font.color:=clblack;          
          end;          
lb25:=tlabel.create(nil);
   with lb25 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb24.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current date in ''''dd.mm.yyyy'''' format';
            Layout := tlCenter;
          end;
bb8:=Tbutton.create(nil);
with bb8 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb7.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%H';
            color:=clbutton;
            font.color:=clblack;          
          end;          
lb26:=tlabel.create(nil);
   with lb26 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb25.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'document title';
            Layout := tlCenter;
          end;
bb9:=Tbutton.create(nil);
with bb9 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb8.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%W';
            color:=clbutton;
            font.color:=clblack;          
          end;           
 lb27:=tlabel.create(nil);
   with lb27 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb26.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current date in ''''mm/dd/yy'''' format';
            Layout := tlCenter;
          end; 
bb10:=Tbutton.create(nil);
with bb10 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb9.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%m';
            color:=clbutton;
            font.color:=clblack;          
          end;                     
lb28:=tlabel.create(nil);
   with lb28 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb27.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'the hostname up to the first ''''.'''' character';
            Layout := tlCenter;
          end;
 bb11:=Tbutton.create(nil);
with bb11 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb10.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%M';
            color:=clbutton;
            font.color:=clblack;          
          end;                     
          lb29:=tlabel.create(nil);
   with lb29 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb28.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'the full hostname';
            Layout := tlCenter;
          end;
           bb12:=Tbutton.create(nil);
with bb12 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb11.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%n';
            color:=clbutton;
            font.color:=clblack;          
          end;                     
          lb30:=tlabel.create(nil);
   with lb30 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb29.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'the user login name';
            Layout := tlCenter;
          end;
bb13:=Tbutton.create(nil);
with bb13 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb12.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '$n';
            color:=clbutton;
            font.color:=clblack;          
          end;                     
          lb31:=tlabel.create(nil);
   with lb31 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb30.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'input file name without the directory part';
            Layout := tlCenter;
          end;
bb14:=Tbutton.create(nil);
with bb14 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb13.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '$N';
            color:=clbutton;
            font.color:=clblack;          
          end;                     
          lb32:=tlabel.create(nil);
   with lb32 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb31.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'the full input file name';
            Layout := tlCenter;
          end;//    
 bb15:=Tbutton.create(nil);
with bb15 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb14.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%t';
            color:=clbutton;
            font.color:=clblack;          
          end;                     
lb33:=tlabel.create(nil);
   with lb33 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb32.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current time in 12-hour am/pm format';
            Layout := tlCenter;
          end;
 bb16:=Tbutton.create(nil);
with bb16 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb15.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%T';
            color:=clbutton;
            font.color:=clblack;          
          end;                     
lb34:=tlabel.create(nil);
   with lb34 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb33.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current time in 24-hour format ''''hh:mm''''';
            Layout := tlCenter;
          end;
 bb17:=Tbutton.create(nil);
with bb17 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb16.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '%*';
            color:=clbutton;
            font.color:=clblack;          
          end;                      
 lb35:=tlabel.create(nil);
   with lb35 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb34.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'current time in 24-hour format with seconds ''''hh:mm:ss''''';
            Layout := tlCenter;
          end;  
 bb18:=Tbutton.create(nil);
with bb18 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb17.top+15;
            Width := 65;
            onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '$v';
            color:=clbutton;
            font.color:=clblack;          
          end;                               
lb36:=tlabel.create(nil);
   with lb36 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb35.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'the sequence number of the current input file';
            Layout := tlCenter;
          end;
          
 bb19:=Tbutton.create(nil);
with bb19 as tbutton do
 begin    
   parent:=gb10;
            Left := 6;
            Top := bb18.top+15;
            Width := 65;onclick:=headertextBBclick;
            Height := 15;
            Alignment := taCenter;
            Caption := '|';
            color:=clbutton;
            font.color:=clblack;          
          end;                               
lb38:=tlabel.create(nil);
   with lb38 as tlabel  do
   begin    
   parent:=gb10;
            Left := 75;
            Top :=lb36.top+15;
            Width := 60;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
            Caption := 'seperator for  '''' left | center | right '''' alignment';
            Layout := tlCenter;
          end;
edit1:=tedit.create(nil);
with edit1 as tedit do
begin
 parent:=gb10;
            Left := 6;
            Top :=lb38.top+25;
            Width := gb10.width-10;
            Height := 25;
         // hint:=edit1.text;
        // showhint:=true;
        
         //   Layout := tlCenter;


end; 
end;//with gb10 as tgroupbox  do

 gb11:=tgroupbox.create(nil);
 with gb11 do
 begin
 parent:=p4;
   Left := 8;
          Top := 360-6;
          Width := 577+8;
          Height := 57;
          Caption := 'Underlay text font';
          TabOrder := 5;

   
     sb3:=TSpeedButton.create(nil);
     with sb3 do
     begin
      parent:=gb11;
            Left := 16;
            Top := 16;
            Width := 161;
            Height := 33;
            name:='sb3';
            Caption := 'Choose font';
       //     Glyph.Data = {
           Margin := 7;
            Spacing := 12;
                 try
            Glyph.loadfromfile(UserCallingImageDIR+'fonts.png');
            except
            ;
            end;
   onclick:=fontdlgclick;
          end;
          
   lb37:=tlabel.create(nil);       
      with lb37 do
      begin
        parent:=gb11;
            Left := 192;
            Top := 22;
            Width := 377;
            Height := 33;
            AutoSize :=True;
            Caption := 'Underlay text font';
            Masked := True;
            Transparent := True;
            Layout := tlCenter;
          end;

end;//////88888 gb11:=tgroupbox.create(nil);888888888888888888888888888888888888888888888888888888


 gb8:=tgroupbox.create(nil);
 with gb8 do
 begin
 parent:=p4;
   Left := 8;
          Top := 416;
          Width := 577+8;
          Height := 57;
          Caption := 'Header text font';
         // TabOrder := 5;
           
   lb12:=tlabel.create(nil);       
      with lb12 do
      begin
        parent:=gb8;
            Left := 192;
            Top := 22;
            Width := 377;
            Height := 33;
            AutoSize := True;
            Caption := 'Header text font';
            Masked := True;
            Transparent := True;
            Layout := tlCenter;
          end;
 
     sb2:=TSpeedButton.create(nil);
     with sb2 do
     begin
      parent:=gb8;
            Left := 16;
            Top := 16;
            Width := 161;
            Height := 33;
            name:='sb2';
            Caption := 'Choose font';
       //     Glyph.Data = {
           Margin := 7;
            Spacing := 12;
            try
            Glyph.loadfromfile(UserCallingImageDIR+'fonts.png');
            except
            ;
            end;
  onclick:=fontdlgclick;
          end;
   
end;//////88888 gb8:=tgroupbox.create(nil);888888888888888888888888888888888888888888888888888888

   
     //   TabVisible := (PageIndex mod 2 = 0);
    //    Caption := 'PageIndex: ' +
     //   IntToStr(PageIndex) + '  TabIndex: ' +
    //      IntToStr(TabIndex);  
    //      color:= 15059399+(i*100);
        //  onshow:=tabshow; 
 //       parentfont:=false;
       //   BorderWidth:=5;
//OnHide:=tabhide;   
      end;
end;
//
 procedure   TRedstone_pagesetup.fontFclick(Sender: TObject);
 begin
 fontf.modalresult:=mrOK;
 end;
  procedure   TRedstone_pagesetup.fontdlgclick(Sender: TObject);
var  sd:string;
BitMap1:tbitmap;
i:integer;
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
bb22:=tbutton.create(application);
bb22.parent:=fontF;
bb22.height:=30;
bb22.ShowHint := True;
bb22.hint:='Click to apply';
bb22.align:=albottom;
//bb22.ModalResult:=mrOK;
bb22.onclick:=fontFclick;
 bb22.Color := 16755370;
 bb22.font.name:='sans';
 bb22.font.color:=clBackground; 
 bb22.Cursor := crHandPoint;
 bb22.font.style:=[fsbold];
 bb22.caption:='Apply';
 BitMap1 := TBitMap.Create;
  try
    BitMap1.loadfromfile(Ini.ReadString ('xfgMainButtonImage', 'xfgMainButton', 'none'));
   bb22.bitmap:=BitMap1;
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
lbox.items.add('AvantGarde-Demi');               
lbox.items.add('AvantGarde-DemiOblique');       
lbox.items.add('AvantGarde-Book');             
lbox.items.add('AvantGarde-BookOblique');        
lbox.items.add('Bookman-Demi');                  	
lbox.items.add('Bookman-DemiItalic');            	
lbox.items.add('Bookman-Light');                 	
lbox.items.add('Bookman-LightItalic');           	
lbox.items.add('Courier-Bold');                    	
lbox.items.add('Courier-BoldOblique');              	
lbox.items.add('Courier');                          	
lbox.items.add('Courier-Oblique');               	
lbox.items.add('Helvetica');                     	
lbox.items.add('Helvetica-Bold');                	
lbox.items.add('Helvetica-BoldOblique');         	
lbox.items.add('Helvetica-Condensed');           	
lbox.items.add('Helvetica-Condensed-Bold');      	
lbox.items.add('Helvetica-Condensed-BoldObl');   	
lbox.items.add('Helvetica-Condensed-Oblique');   	
lbox.items.add('Helvetica-Narrow');              	
lbox.items.add('Helvetica-Narrow-Bold');         	
lbox.items.add('Helvetica-Narrow-BoldOblique');  	
lbox.items.add('Helvetica-Narrow-Oblique');      	
lbox.items.add('Helvetica-Oblique');             	
lbox.items.add('NewCenturySchlbk-Bold');         	
lbox.items.add('NewCenturySchlbk-BoldItalic');   	
lbox.items.add('NewCenturySchlbk-Italic');      	
lbox.items.add('NewCenturySchlbk-Roman');        	
lbox.items.add('Palatino-Bold');                 	
lbox.items.add('Palatino-BoldItalic');           	
lbox.items.add('Palatino-Italic');               	
lbox.items.add('Palatino-Roman');                	
lbox.items.add('Symbol');  
lbox.items.add('Times-Roman');                       	
lbox.items.add('Times-Bold');                    	
lbox.items.add('Times-BoldItalic');              	
lbox.items.add('Times-Italic');                  	
lbox.items.add('ZapfChancery-MediumItalic');     	
lbox.items.add('ZapfDingbats');                 
with (sender as tspeedbutton)do
begin

if name='sb2' then 
begin 
for i:=1 to 50 do 
begin
sd:=inttostr(i+i);
lbox2.items.add(sd);
end;
sd:='{'+lb12.caption+'}';
Lbox.ItemIndex:= Lbox.Items.IndexOf(k.CRS_GetParamAtPos(sd,'{','}','@',1));
Lbox2.ItemIndex:= Lbox2.Items.IndexOf(k.CRS_GetParamAtPos(sd,'{','}','@',2));
end;

if name='sb1' then 
begin 
for i:=1 to 50 do 
begin
sd:=inttostr(i+i);
lbox2.items.add(sd);

end;
sd:='{'+lb11.caption+'}';
Lbox.ItemIndex:= Lbox.Items.IndexOf(k.CRS_GetParamAtPos(sd,'{','}','@',1));
Lbox2.ItemIndex:= Lbox2.Items.IndexOf(k.CRS_GetParamAtPos(sd,'{','}','@',2));
end;

if name='sb3' then 
begin 


lbox2.items.add('25');
lbox2.items.add('30');
lbox2.items.add('35');
lbox2.items.add('40');
lbox2.items.add('45');
lbox2.items.add('50');
lbox2.items.add('55');
lbox2.items.add('60');
lbox2.items.add('65');
lbox2.items.add('70');
lbox2.items.add('75');
lbox2.items.add('80');
lbox2.items.add('85');
lbox2.items.add('100');
lbox2.items.add('120');
lbox2.items.add('130');
lbox2.items.add('140');
lbox2.items.add('150');
lbox2.items.add('160');
lbox2.items.add('170');
lbox2.items.add('180');
lbox2.items.add('190');
lbox2.items.add('200');
lbox2.items.add('250');
lbox2.items.add('300');
lbox2.items.add('350');
lbox2.items.add('400');
lbox2.items.add('450');
lbox2.items.add('500');
sd:='{'+lb37.caption+'}';
Lbox.ItemIndex:= Lbox.Items.IndexOf(k.CRS_GetParamAtPos(sd,'{','}','@',1));
Lbox2.ItemIndex:= Lbox2.Items.IndexOf(k.CRS_GetParamAtPos(sd,'{','}','@',2));
end;

end;
 if   FontF.ShowModal=mrOK then
 begin
 with (sender as tspeedbutton)do
begin
if name='sb3' then lb37.caption:=lbox.items.strings[Lbox.ItemIndex]+'@'+lbox2.items.strings[Lbox2.ItemIndex];
if name='sb1' then lb11.caption:=lbox.items.strings[Lbox.ItemIndex]+'@'+lbox2.items.strings[Lbox2.ItemIndex];

if name='sb2' then lb12.caption:=lbox.items.strings[Lbox.ItemIndex]+'@'+lbox2.items.strings[Lbox2.ItemIndex];
 end;
 
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
procedure TRedstone_pagesetup.createts3; 
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
 



procedure TRedstone_pagesetup.creatememo;
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
      //Font.Name := 'courier';
      Font.Pitch := fpVariable; 
     Font.Style := [];
      ParentFont := False;
      ScrollBars := ssBoth;
      TabOrder := 0;
      WordWrap := False;
      readonly:=false;
       BorderStyle := bsRaisedPanel;
  //    OnMouseEnter = Memo1MouseEnter
    end;

end;

procedure TRedstone_pagesetup.createspeedbutton;
var  mi,sbint:integer;

begin

   sbint:=10;
 for mi := 0 to l1.Count - 1 do 
begin
if (tobooklet=true)and (mi=l1.Count-2)then begin
speedbutton:=TSpeedButton.Create (nil);
speedbutton.parent:=p1;
 speedbutton.left:=8;
 speedbutton.font.style:=[fsbold];
 speedbutton.font.color:=clwhite;
  speedbutton.font.name:='sans';
      speedbutton.Top := sbint;
      speedbutton.Width := 95;
      speedbutton.Height := 70;
      
    speedbutton.Hint :='Save text to postscript in booklet format';
     speedbutton.caption:='Save as booklet';
     speedbutton.name:='tobooklet';
      speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
      if fileexists(Ini.Readstring ('xfgPrintBooklet', 'pagetopostcript2bookletimg', 'none'))=true then
 SpeedButton.Glyph.LoadFromFile(Ini.Readstring ('xfgPrintBooklet', 'pagetopostcript2bookletimg', 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
    speedbutton.OnClick := spclick;
speedbutton.visible:=true;
sbint:=sbint+70+10;
//exit;

 // Ini.writestring ('xfgPrintBooklet', 'pagetopostcript2booklet', 'fakse');
  

end;
if (ToPS=true)and (mi=l1.Count-2)then begin
speedbutton:=TSpeedButton.Create (nil);
speedbutton.parent:=p1;
 speedbutton.left:=8;
 speedbutton.font.style:=[fsbold];
 speedbutton.font.color:=clwhite;
  speedbutton.font.name:='sans';
      speedbutton.Top := sbint;
      speedbutton.Width := 95;
      speedbutton.Height := 70;
      
    speedbutton.Hint :='Save text to postscript format';
     speedbutton.caption:='To postscript';
     speedbutton.name:='ToPS';
      speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
      if fileexists(Ini.Readstring ('xfgPrintBooklet', 'pagetopostcriptimg', 'none'))=true then
 SpeedButton.Glyph.LoadFromFile(Ini.Readstring ('xfgPrintBooklet', 'pagetopostcriptimg', 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
    speedbutton.OnClick := spclick;
speedbutton.visible:=true;
sbint:=sbint+70+10;
//exit;

 // Ini.writestring ('xfgPrintBooklet', 'pagetopostcript2booklet', 'fakse');
  

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
      
    speedbutton.Hint :=l1.Strings[mi];
     speedbutton.caption:=l1.Strings[mi];
      speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
      if fileexists(Ini.Readstring ('xfgOptionsSidePanel', l1.Strings[mi], 'none'))=true then
     SpeedButton.Glyph.LoadFromFile(Ini.Readstring ('xfgOptionsSidePanel', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
    speedbutton.OnClick := spclick;
speedbutton.visible:=true;
sbint:=sbint+70+10;

end;
l1.clear;
end;


 procedure TRedstone_pagesetup.SpClick(Sender: TObject);
var
//p:tpoint;
  //l1,l2,l3:tstringlist;
  i,ii:integer;//,ii,currP,groupP,l2int,index:integer;
//  intP:extended;
//  pagerange,ss,instr,outstr,enscript,instr2,backupstr,sss,ram:string;
 // l2First:Boolean;
 enscript,instr,outstr,messgstr,GuidStr,TEMPSTR:string;CanDelInstr:boolean;
 
 begin
 with (sender as tspeedbutton) do
 begin
 if lowercase(caption)='close' then f.close;
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
////////////////////////////////////////////////////////////////////////////////////////////////
if lowercase(name)='tobooklet' then 
begin 

//enscript --font=Times-Roman@12 --ul-font=Palatino-Bold@200 --header-font=NewCenturySchlbk-Bold@18 
//--columns=1 --media=A4 --word-wrap --mark-wrapped-lines=none --header='  | $% of $= |  ' 
//--nup=1 --margins=10:10:10:10 --file-align=1 --borders --portrait --underlay='Banned' 
//--ul-style=filled --ul-position=+40+60 --ul-gray=.8 --ul-angle=60 --highlight-bars=2 
//--highlight-bar-gray=.9  --output=%out %in
update_page(1);

(******************************************************************************************)
if Detach=false then
begin
FPassStringList.savetofile(UserCallingDataDIR+'Redstone_pagesetupBookletTMP.txt');
instr:=UserCallingDataDIR+'Redstone_pagesetupBookletTMP.txt';
outstr:=UserCallingDataDIR+'Redstone_pagesetupBookletTMP.ps';
enscript:=Ini.Readstring ('xfgMainButton', 'pagetopostcript', 'none');
enscript:=StringReplace(enscript,'--output=%out %in','--output='+
                       outstr+
                       ' '+instr,[rfIgnoreCase]) ;

libc.system(pchar(enscript));
instr:=UserCallingDataDIR+'Redstone_pagesetupBookletSigTMP.ps';
enscript:='psbook '+outstr+' > '+instr;
//enscript:='psselect -p'+pagerange+' '+outstr+' '+instr;
if DEBUG=true then memo1.lines.add(enscript);
libc.system(pchar(enscript));


outstr:=form2filelist.directory.location+'xfgBooklet.ps';

enscript:='psnup -P'+cmb1.text+' -p'+bookletcmb1.text+' -d'+bookletcmb4.text+' -b'+bookletcmb3.text
                    +' -'+bookletcmb5.text;
if bookletcmb2.text='column-major' then  enscript:=enscript+' -c';
if cmb2.text='Landscape' then enscript:=enscript+' -l';
enscript:=enscript+' '+instr+' > '+outstr;
libc.system(pchar(enscript));
if DEBUG=true then memo1.lines.add(enscript);
messgstr:=outstr;
HAVE_SAVE_BOOK:=true;
MessageDlg ('Postscript in booklet format save to :'+#13#10+
             messgstr, mtInformation, [mbOK], 0); 

end;//if Detach=false then
(******************************************************************************************)
if Detach=true then
begin
if not directoryexists(K.RS_OnMyTablePath) then forcedirectories(K.RS_OnMyTablePath);
messgstr:='';
for i:=0 to FPassStringList.count-1 do
begin
CanDelInstr:=false;
instr:=FPassStringList[i];
if lowercase(extractfileext(FPassStringList[i]))<>'.ps' then
begin
GuidStr:='';
GuidStr:=k.CRS_GetGuid;
outstr:=UserCallingDataDIR+GuidStr;
enscript:=Ini.Readstring ('xfgMainButton', 'pagetopostcript', 'none');
enscript:=StringReplace(enscript,'--output=%out %in','--output="'+
                       outstr+'" "'+instr+'"',[rfIgnoreCase]) ;

libc.system(pchar(enscript));
instr:=UserCallingDataDIR+GuidStr+'BookletSigTMP.ps';
CanDelInstr:=true;
enscript:='psbook "'+outstr+'" > "'+instr+'"';

//enscript:='psselect -p'+pagerange+' '+outstr+' '+instr;
if DEBUG=true then memo1.lines.add(enscript);
libc.system(pchar(enscript));

deletefile(outstr);
end;

outstr:=K.RS_OnMyTablePath+'/'+extractfilename(FPassStringList[i])+'.'+'xfgBooklet.ps';

if fileexists(outstr)then
begin
ii:=0;
repeat
ii:=1+ii;
TEMPSTR:=K.RS_OnMyTablePath+'/'+extractfilename(FPassStringList[i])+'('+inttostr(ii)+').'+'xfgBooklet.ps';
until not fileexists(TEMPSTR);
K.crs_copyfile(outstr,TEMPSTR,false,true,false);
deletefile(outstr);
end;

enscript:='psnup -P'+cmb1.text+' -p'+bookletcmb1.text+' -d'+bookletcmb4.text+' -b'+bookletcmb3.text
                    +' -'+bookletcmb5.text;
if bookletcmb2.text='column-major' then  enscript:=enscript+' -c';
if cmb2.text='Landscape' then enscript:=enscript+' -l';
enscript:=enscript+' "'+instr+'" > "'+outstr+'"';

libc.system(pchar(enscript));
if DEBUG=true then memo1.lines.add(enscript);
messgstr:=messgstr+outstr+#13#10;

if CanDelInstr=true then
deletefile(instr);


end;//for i:=0 to FPassStringList.count-1 do

HAVE_SAVE_BOOK:=true;
MessageDlg ('Postscript in booklet format save to :'+#13#10+
             messgstr, mtInformation, [mbOK], 0); 

end;//if Detach=true then

end;

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
if lowercase(name)='tops' then 
begin 

//enscript --font=Times-Roman@12 --ul-font=Palatino-Bold@200 --header-font=NewCenturySchlbk-Bold@18 
//--columns=1 --media=A4 --word-wrap --mark-wrapped-lines=none --header='  | $% of $= |  ' 
//--nup=1 --margins=10:10:10:10 --file-align=1 --borders --portrait --underlay='Banned' 
//--ul-style=filled --ul-position=+40+60 --ul-gray=.8 --ul-angle=60 --highlight-bars=2 
//--highlight-bar-gray=.9  --output=%out %in
update_page(1);

(******************************************************************************************)
if Detach=false then
begin

MessageDlg ('Running in detach mode is not implemented .'+#13#10
             , mtInformation, [mbOK], 0); 
exit;
end;//if Detach=false then
(******************************************************************************************)
if Detach=true then
begin
if not directoryexists(K.RS_OnMyTablePath) then forcedirectories(K.RS_OnMyTablePath);
messgstr:='';
for i:=0 to FPassStringList.count-1 do
begin

instr:=FPassStringList[i];
outstr:=K.RS_OnMyTablePath+'/'+extractfilename(FPassStringList[i])+'.ps';
if fileexists(outstr)then
begin
ii:=0;
repeat
ii:=1+ii;
TEMPSTR:=K.RS_OnMyTablePath+'/'+extractfilename(FPassStringList[i])+'('+inttostr(ii)+').'+'ps';
until not fileexists(TEMPSTR);
K.crs_copyfile(outstr,TEMPSTR,false,true,false);
deletefile(outstr);
end;

enscript:=Ini.Readstring ('xfgMainButton', 'pagetopostcript', 'none');
enscript:=StringReplace(enscript,'--output=%out %in','--output="'+
                       outstr+'" "'+instr+'"',[rfIgnoreCase]) ;

libc.system(pchar(enscript));

if DEBUG=true then memo1.lines.add(enscript);

messgstr:=messgstr+outstr+#13#10;

end;//for i:=0 to FPassStringList.count-1 do

HAVE_SAVE_BOOK:=true;
MessageDlg ('Postscript format save to :'+#13#10+
             messgstr, mtInformation, [mbOK], 0); 

end;//if Detach=true then

end;

///////////////////////////////////////////////////////////////////////////

if lowercase(caption)='update preview' then 
begin 


update_page(1);
dopreview;
end;
if lowercase(caption)='apply settings' then 
begin 
//l2.clear;
update_page(1);
MessageDlg ('Page format settings saved', mtinformation, [mbOK], 0); 
end;

end;
 end;//
 

procedure TRedstone_pagesetup.createpanel1;
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

procedure TRedstone_pagesetup.createpanel2;
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

procedure TRedstone_pagesetup.createsplitter;
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




initialization
registerclass(TRedstone_pagesetup);
finalization

unregisterclass(TRedstone_pagesetup);
end.
(*
l1:=tstringlist.create;
l2:=tstringlist.create;
l3:=tstringlist.create;
l1.loadfromfile(outstr);
for i:=0 to l1.count-1 do
begin
instr:=l1.strings[i];
instr:='{'+instr+'}';
if DEBUG=true then memo1.lines.add(instr);
if pos('Pages:',instr)>0 then 
begin
ss:=trim(k.CRS_GetParamAtPos(instr,'{','}',':',2));
if ss<>'(atend)' then currP:=strtoint(ss)else
if ss='(atend)' then 
begin
for ii:=l1.count-1  downto 0 do
begin
instr:=l1.strings[ii];
instr:='{'+instr+'}';
if DEBUG=true then memo1.lines.add(instr);
if pos('Pages:',instr)>0 then 
begin
ss:=trim(k.CRS_GetParamAtPos(instr,'{','}',':',2));
if ss<>'(atend)'then currP:=strtoint(ss);
break;
end;
end;
end;
break;


end;//if pos('%Pages:',l1.strings[i])>0 then 
end;//for i:=0 to l1.count-1 do

//if Odd(intP)=true or Odd(intP)=false then 
l1.clear;
//currP:=9;
ii:=currP;
intP:=(currP) / 4;
if pos('.',floattostr(intP))<>0 then
begin
//form1.Caption:=floattostr(intP)+ ' for '+floattostr(currP);
repeat
currP:=currP+1;
//Inc(currP);
intP:=(currP) / 4;
until pos('.',floattostr(intP))=0;
//form1.Caption:=form1.Caption+'    change to '
  //                    +floattostr(intP)+ ' for '+floattostr(currP)+
    //                  ' --->>  Numder of empty pages to insert is '+
      //                inttostr(currP-ii);
end;
groupP:=currP div 4;
l2int:=currP div 2;
for i:=1 to l2int  do
begin
l1.add(inttostr(i));
end;
for i:=currP downto l2int+1  do
begin
l2.add(inttostr(i));
end;

//memo1.lines.clear;

if DEBUG=true then
for i:=0 to l1.count-1 do
begin
memo1.lines.add(l1.strings[i]);
end;
if DEBUG=true then
for i:=0 to l2.count-1 do
begin
memo1.lines.add(l2.strings[i]);
end;

//  [24]  [1]  [2] [23] 
//  [22]  [3]  [4] [21] 
//  [20]  [5]  [6] [19] 
//  [18]  [7]  [8] [17] 
//  [16]  [9] [10] [15] 
//  [14] [11] [12] [13] 
// 24,  1,  2, 23,
// 22,  3,  4, 21,
// 20,  5,  6, 19,
// 18,  7,  8, 17,
// 16,  9, 10, 15,
// 14, 11, 12, 13,
//l2First:=true;
pagerange:='';
for i:=1 to groupP do
begin

pagerange:=pagerange+l2.strings[0]+','+l1.strings[0]+','+
           l1.strings[1]+','+l2.strings[1];
           if i<>groupP then 
           begin
pagerange:=pagerange+',';
for ii:=0 to 1 do
begin 
l2.delete(0);
l1.delete(0);
end;end;

end;
if DEBUG=true then
memo1.lines.add(pagerange);
if DEBUG=true then
memo1.lines.add(ss);


l1.free;
l2.free;
l3.free;

*)
