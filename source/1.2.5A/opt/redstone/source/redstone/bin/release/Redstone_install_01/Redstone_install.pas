unit Redstone_install;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,Types,inifiles,
  qExtCtrls, QComCtrls,QButtons,QPrinters,Libc
  ,RedStone_Public_Comp
  ,PClass_Command_RedStone
  //,PPClass_RedStone
  ;

type
  TRedstone_install = class(TRedStone_Public_Comp)
   procedure createspeedbutton;
  procedure creatememo;
  procedure createview;
  procedure createlistbox;
  procedure createpanel1;
  procedure createpanel2;
   procedure createpanel3;
  procedure createsplitter;
   procedure SpClick(Sender: TObject);
  procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
 
   
  private
  lb1,lb2:tlabel;
    //d:TPPClass_RedStone;
     view1:TTextBrowser;
     LB:tListBox;
     ini:tinifile; 
   index:string;
       l1,l2:tstringlist;
ini2:tinifile;
 K:TPClass_Command_RedStone;
   F:tform;
   img:timage;
     p1:tpanel;
     p2:tpanel;
     p3:tpanel;
     sp:TSplitter;
     memo1:tmemo;
   AF:TForm;
   speedbutton:tspeedbutton;
userEXEDIR,userCONFNAME,userCONFDIR:string;
  sr: TSearchRec; 

  protected
 
  public
constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
destructor Destroy; override;

  published

  end;
  const
INSTALL_DIR:string='install';
INSTALL_DATA_CONF:string='data_conf';    
INSTALL_DATA_INSTALL_FILE:string='data_install_file';  
implementation

constructor TRedstone_install.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList);
                  
var 
s,instr1,instr2,scp,configowner,debug,HOMEDIR:string;
h:Thandle;
DUP:BOOLEAN;
i,ii,iii:integer;
 FileAttrs: Integer;
begin


inherited;
 TimeSeparator := '-';
  ShortDateFormat := 'hh:mm:ss'; 
DateSeparator := '-';
  ShortDateFormat := 'dd/mm/yyyy'; 
 
DUP:=false;
AF:=APass_Form;
F:=nil; 
 application.handle:=nil;
 application.handle:=APass_Handle;


  F := TForm.Create (Application);
  try
    F.caption:=APass_Form.caption+' Redstone_install';
 
     f.width:=700;
     f.height:=500;
 
     createpanel1;
     createsplitter;
     createpanel2;
   //     createpanel3;
  //     createspeedbutton;
 //    createListBox;
    creatememo;
//createview;
p1.width:=600;
p1.caption:='';
memo1.font.size:=10;
F.onclose:=Formclose;
img:=timage.create(nil);
img.parent:=p1;
img.width:=p1.width;
img.height:=p1.height;
img.center:=true;
lb1:=tlabel.create(nil);
lb1.parent:=p1;
lb1.top:=20;
lb1.left:=5;
lb1.autosize:=true;
lb1.font.size:=14;
lb1.font.name:='sans';
lb1.transparent:=true;
     F.Show;
 // F.bitmap.loadfromfile(extractfilepath(aproc)+'splash.jpg'); 
// ini:=tinifile.create(k.CRS_MainPath+INSTALL_DATA_CONF);

if fileexists(INSTALL_DATA_CONF)=true then 
ini:=tinifile.create(INSTALL_DATA_CONF);

if fileexists(INSTALL_DATA_CONF)=false then 
ini:=tinifile.create(extractfilepath(APass_ExeName)+INSTALL_DATA_CONF);




 configowner:=ini.readstring('xfgMain','owner','none');
 if lowercase(ini.readstring('xfgMain','DEBUG','none'))='true' then
 debug:='true';
if lowercase(ini.readstring('xfgMain','type','none'))='application' then 
begin
lb1.caption:='Start installing program for '+configowner+' on '+DateToStr(Date)+'  '+TimeToStr(Time);
memo1.lines.add('Start installing program for '+configowner+' on '+DateToStr(Date)+'  '+TimeToStr(Time));
end;
if lowercase(ini.readstring('xfgMain','type','none'))='config' then  
begin
memo1.lines.add('Start installing configurations for '+configowner+' on '+DateToStr(Date)+
                   '  '+TimeToStr(Time));
lb1.caption:='Start installing configurations for '+configowner+' on '+DateToStr(Date)
                         +'  '+TimeToStr(Time);
lb1.font.color:=clblack;
end;

//if FileExists(GetEnvironmentVariable('HOME')+'/'+redstonedir+'/'+filegardenDIR+'/'+filegardenCONF)=true  
 //  then begin
 
//INSTALL_DIR:string='install';
//INSTALL_DATA_CONF:string='data_conf';    
//INSTALL_DATA_INSTALL_FILE:string='data_install_file';  
//userEXEDIR=[HOME]/redstone/FileGarden

l1:=tstringlist.create;
l2:=tstringlist.create;
HOMEDIR:=GetEnvironmentVariable('HOME');
userEXEDIR:=ini.readstring('xfgMain','userEXEDIR','none');
userEXEDIR:=StringReplace(userEXEDIR,'[HOME]',HOMEDIR,[rfIgnoreCase]);
userCONFDIR:=ini.readstring('xfgMain','userCONFDIR','none');
userCONFDIR:=StringReplace(userCONFDIR,'[HOME]',HOMEDIR,[rfIgnoreCase]);
userCONFNAME:=ini.readstring('xfgMain','userCONFNAME','none');
memo1.lines.add('userEXEDIR   '+userEXEDIR );
memo1.lines.add('userEXEDIR   '+userCONFDIR );
memo1.lines.add('userCONFNAME   '+userCONFNAME );
ini.readsection('xfgUserDir',l1);
// {$I-}
for i:=0 to l1.count-1 do
begin
if DirectoryExists(userEXEDIR+'/'+l1.strings[i])=true then 
begin 
memo1.lines.add('Directory or file Exists   '+userEXEDIR+'/'+l1.strings[i] );

continue; 
end
else if DirectoryExists(userEXEDIR+'/'+l1.strings[i])=false then begin

mkdir(userEXEDIR+'/'+l1.strings[i]);
memo1.lines.add('Can''t find  directory or file   '+userEXEDIR+'/'+l1.strings[i] );
memo1.lines.add('       ------>   Create directory or file   '+userEXEDIR+'/'+l1.strings[i] );
end; 

end;

   K:=TPClass_Command_RedStone.create(application.handle,APass_Form,APass_ExeName); 
 
if fileexists(k.RS_MainPath+'splash.jpg') =true then
 img.picture.loadfromfile(k.RS_MainPath+'splash.jpg');  
  if fileexists(extractfilepath(APass_ExeName)+'splash.jpg') =true  then
img.picture.loadfromfile(extractfilepath(APass_ExeName)+'splash.jpg'); 


  if fileexists('splash.jpg') =true  then
 img.picture.loadfromfile('splash.jpg'); 


//  memo1.lines.assign(AStringList);
  memo1.lines.add(' ');
  memo1.lines.add(' ');
  memo1.lines.add(' ');
  memo1.lines.add(' ');
  memo1.lines.add('Component testing output results ============================================');
    memo1.lines.add(' ');
  memo1.lines.add(' ');
  memo1.lines.add('AProc    '+APass_ExeName);
  memo1.lines.add('k.RedStone_SysPath    '+k.RS_SysPath);
  memo1.lines.add('k.CRS_MainPath    '+k.RS_MainPath);
  memo1.lines.add('k.CRS_RecPath    '+k.RS_Calling_APPRecPath);
  memo1.lines.add('k.CRS_CompRecPath    '+k.RS_CompRecPath);
  memo1.lines.add('k.CRS_MenuRecPath    '+k.RS_MenuRecPath);
  memo1.lines.add('k.CRS_CompRecName    '+k.RS_CompRecName);
  memo1.lines.add('k.CRS_MenuRecName    '+k.RS_MenuRecName);

memo1.lines.add(' ');
memo1.lines.add(' ');
memo1.lines.add(' ');
memo1.lines.add('Start copying files into directory ... ');
memo1.lines.add(' ');
memo1.lines.add(' ');



if lowercase(ini.readstring('xfgMain','type','none'))='application' then
begin
for i:=0 to l1.count-1 do
begin
scp:='cp -Hp --reply=yes --preserve=link '+k.RS_MainPath+INSTALL_DIR+'/'+l1.strings[i]+'/*';
Libc.system(pchar(scp+' '+userEXEDIR+'/'+l1.strings[i]+'/'));
memo1.lines.add(scp+' '+userEXEDIR+'/'+l1.strings[i]+'/');
end;
memo1.lines.add(' ');
memo1.lines.add(' ');
memo1.lines.add('Done copying files to '+userCONFDIR);
lb1.caption:=lb1.caption+#13#10+'Done copying files to '+userCONFDIR;


s:=extractfilename(APass_ExeName);
scp:='ln -s '+k.RS_MainPath+'/'+s+' '+userCONFDIR;
memo1.lines.add('Linking '+k.RS_MainPath+'/'+s+' to'+userCONFDIR);
Libc.system(pchar(scp));
i:=1;
if fileexists(userCONFDIR+'/'+userCONFNAME)then
begin
repeat
s:=userCONFDIR+'/'+userCONFNAME+'BACKUP-USER-PREVIOUS-'+inttostr(i);
inc(i);
until not fileexists(s);
RenameFile(userCONFDIR+'/'+userCONFNAME,s);
end;

l1.clear;
l2.clear;
ini.readsection('xfgInstallUpdateConf',l2);
//l2.add(INSTALL_DATA_CONF);

(*
INSTALL_DATA_CONF:string='data_conf';
[xfgInstallUpdateConf]
install/redstone/resource/xfgFileInputMenuOnMyTable=1
install/redstone/resource/FileManagerOpenFileSetupXFGVCLManage=1
install/redstone/resource/MainQuickButtonXFGVCLManage=1
install/redstone/resource/MyTableXFGVCLManage=1
*)
memo1.lines.add('Start preparing configuration file ...');
memo1.lines.add(' ');
memo1.lines.add(' ');
for ii:=0 to l2.count-1 do
begin
l1.clear;
l1.loadfromfile(extractfilepath(APass_ExeName)+l2[ii]);
for i:=0 to l1.count-1 do
begin
if pos('[HOME]/',l1.strings[i])<>0 then 
l1.strings[i]:=StringReplace(l1.strings[i],'[HOME]',HOMEDIR,[rfIgnoreCase]);
if debug='true' then
memo1.lines.add('Replace with user HOME directory  '+extractfilepath(APass_ExeName)+l2[ii]+
    ' --------> '+
    ini.readstring('xfgInstallUpdateConf',l2[ii],'none'));end;

memo1.lines.add('Try saving configuration file to '+
ini.readstring('xfgInstallUpdateConf',l2[ii],'none'));
l1.savetofile(StringReplace(ini.readstring('xfgInstallUpdateConf',l2[ii],'none'),'[HOME]',HOMEDIR,[rfIgnoreCase])
);
end;//for ii:=0 to l2.count-1 do
(*
s:='/installconf-'+DateToStr(Date)+'-'+TimeToStr(Time)+'-'+configowner;
s:=stringreplace(s,' ','',[rfIgnoreCase]);

if Directoryexists(userCONFDIR+'/data') =false then mkdir(userCONFDIR+'/data');
memo1.lines.add('Try to backup configuration file to '+userCONFDIR+'/data'+s);
l1.savetofile(userCONFDIR+'/data'+s);
*)
l1.clear;
memo1.lines.add('Done preparing configuration file.');
sleep(200);
lb1.caption:=lb1.caption+#13#10+'You can now exit this form'+#13#10+'Enjoy';     

end;//if ini.readstring('xfgMain','type','none')='application' then




if lowercase(ini.readstring('xfgMain','type','none'))='config' then
begin;
ini.readsection('xfgUserDir',l1);
for i:=0 to l1.count-1 do
begin
scp:='cp -Hp --reply=yes --preserve=link '+INSTALL_DIR+'/'+l1.strings[i]+'/*';
Libc.system(pchar(scp+' '+userEXEDIR+'/'+l1.strings[i]+'/'));
memo1.lines.add(scp+' '+userEXEDIR+'/'+l1.strings[i]+'/');
end;
memo1.lines.add(' ');
memo1.lines.add(' ');
memo1.lines.add('Done copying files to '+userCONFDIR);
lb1.caption:=lb1.caption+#13#10+'Done copying files to '+userCONFDIR;


memo1.lines.add('Start preparing configuration file for '+configowner+' ...');
if fileexists(userCONFDIR+'/'+userCONFNAME) then begin
if debug='true' then memo1.lines.add('userCONFDIR'+'/'+'userCONFNAME    --->    '+userCONFDIR+'/'+userCONFNAME);

l1.clear;
l1.loadfromfile(INSTALL_DATA_CONF);
if debug='true' then memo1.lines.add('k.CRS_MainPath'+'INSTALL_DATA_CONF    --->    '+k.RS_MainPath+INSTALL_DATA_CONF);
if debug='true' then memo1.lines.add(' '+#13#10+' '+#13#10+' '+#13#10+' '+#13#10);
for i:=0 to l1.count-1 do
begin
if pos('[HOME]/',l1.strings[i])<>0 then 
l1.strings[i]:=StringReplace(l1.strings[i],'[HOME]',HOMEDIR,[rfIgnoreCase]);

if debug='true' then 
memo1.lines.add(l1.strings[i]);

end;

//s:=userEXEDIR+'/installconf-'+DateToStr(Date)+'-'+TimeToStr(Time)+'-'+configowner;
s:='/installconf-'+DateToStr(Date)+'-'+TimeToStr(Time)+'-'+configowner;
s:=stringreplace(s,' ','',[rfIgnoreCase]);
if Directoryexists(userCONFDIR+'/data') =false then mkdir(userCONFDIR+'/data');
memo1.lines.add('Try to backup configuration file to '+userCONFDIR+'/data'+s);
l1.savetofile(userCONFDIR+'/data'+s);
l1.clear;
ini.free;
instr2:='###';
ini:=tinifile.create(userCONFDIR+'/'+userCONFNAME);
ini2:=tinifile.create(INSTALL_DATA_CONF);

l2.clear;
ini2.readsections(l2);
memo1.lines.add(' ');
memo1.lines.add(' ');
for i:=0 to l2.count-1 do
begin
if (l2.strings[i]='xfgMain') or( l2.strings[i]='xfgUserDir') then continue;
 //ValueExists (const Section, Ident: String):
ini2.readsection(l2.strings[i],l1); 
for ii:=0 to l1.count-1 do
begin

instr1:= ini2.ReadString(l2.strings[i],l1.strings[ii],'none' );




if ini.ValueExists (l2.strings[i], l1.strings[ii])=true then begin
DUP:=true;
if ini.ValueExists (l2.strings[i]+instr2, l1.strings[ii])=true then begin
ini.writestring( l2.strings[i]+instr2,l1.strings[ii]  ,'none') ;
continue;
end;
instr2:=( l1.strings[ii]+'-'+DateToStr(Date)+'-'+TimeToStr(Time)+' for '+configowner );
if l2.strings[i]='xfgMainMenu' then 
begin 
ini.writestring( instr2 ,' temp'  ,'none') ;
ini.deletekey( instr2 ,' temp') ;
continue;
end;

ini.writestring( ( l2.strings[i]) ,instr2  ,instr1) ;
if debug='true' then
memo1.lines.add('Writing to '+userCONFDIR+'/'+userCONFNAME+'  --->  '+l2.strings[i]+'=='+instr2+'='+instr1);
continue;
end;

if ini.ValueExists (l2.strings[i], l1.strings[ii])=false then
ini.writestring( l2.strings[i] , l1.strings[ii] ,instr1);
if debug='true' then
memo1.lines.add('Writing to '+userCONFDIR+'/'+userCONFNAME+'  --->  '+l2.strings[i]+'=='+l1.strings[ii]+'='+instr1);

end;
end;
memo1.lines.add(' ');
memo1.lines.add(' ');
instr1:='You have duplicate main menu or menu items.' +#13#10+
        'From the application main menu choose' +#13#10+
        '      Options  |  Menu setup  '+#13#10+
        'to rename the duplicates.';
if DUP=true then MessageDlg (instr1, mtWarning,  [mbOK], 0);
if DUP=true then memo1.lines.add(instr1);
memo1.lines.add('Done preparing configuration file for '+configowner);  
lb1.caption:=lb1.caption+#13#10+'Done installing configuration file ';    
lb1.caption:=lb1.caption+#13#10+'You can now exit this form'+#13#10+'Enjoy';   
end//if fileexists(userEXEDIR+'/'+userCONFNAME) then begin
else begin
memo1.lines.add(' ');
memo1.lines.add(' ');
instr1:=      'You have not installed an application' +#13#10+
              'for this configuration file.' +#13#10+
              'This installation will now die';

memo1.lines.add(instr1);
MessageDlg (instr1, mtError,  [mbOK], 0);
lb1.font.color:=clred;
 lb1.caption:=lb1.caption+#13#10+'Error in installation'; 
 lb1.caption:=lb1.caption+#13#10+'You can now exit this form'+#13#10; 
 end;     
 
         
  
l1.clear;
ini.updatefile;
ini.free;
ini2.free;
l2.free;
end;//if lowercase(ini.readstring('xfgMain','type','none'))='config' then









//if ini<>nil then ini:=tinifile.create(k.CRS_MainPath+INSTALL_DATA_CONF);


  except
   on E: Exception do
    begin
    MessageDlg ('Error in Component: ' +
        E.Message, mtError, [mbOK], 0);
      
        f.close;         
        
       // application.terminate;
    end;
  end;
 

end;

destructor TRedstone_install.Destroy;
begin
 

inherited;

end;

procedure TRedstone_install.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // used by the modeless form

  if l1<>nil then l1.free;
  

  if k<>nil then k.free;   
  AF.close;

 Action := caFree;
 // application.terminate;
end;

procedure TRedstone_install.createspeedbutton;
var  mi,sbint:integer;

 
begin
   sbint:=5;
 


 for mi := 0 to l1.Count - 1 do 
begin
speedbutton:=TSpeedButton.Create (application);
speedbutton.parent:=p3;
 speedbutton.left:=sbint;
      speedbutton.Top := 1;
      speedbutton.Width := 32;
      speedbutton.Height := 32;
    speedbutton.Hint :=l1.Strings[mi];
   //   speedbutton.caption:=' ';
      speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
     SpeedButton.Glyph.LoadFromFile(Ini2.Readstring ('Redstone_install', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
    speedbutton.OnClick := spclick;
speedbutton.visible:=true;
sbint:=sbint+32+10;
end;
 
end;


 procedure TRedstone_install.SpClick(Sender: TObject);
// var s:char;
 begin
 with (sender as tspeedbutton) do
 begin
 if hint='Forward' then view1.forward;
 if hint='Backward' then view1.Backward;
 if hint='Reload' then view1.LoadFromFile(view1.FileName);
 if hint='Home' then view1.LoadFromFile(index);
 if hint='Email' then ;
 

end;
 end;
 

procedure TRedstone_install.creatememo;


begin
   memo1:=tmemo.create(application);
     memo1.parent:=p2;
    with memo1 as tmemo do
    begin
      Left := 2;
      Top := 2;
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
   //   TabOrder := 0;
      WordWrap := False;
      readonly:=true;
       BorderStyle := bsRaisedPanel;
  //    OnMouseEnter = Memo1MouseEnter
    end;
     
end;
procedure TRedstone_install.createview;


begin
   view1:=TTextBrowser.create(application);
     view1.parent:=p2;
    with view1 as TTextBrowser do
    begin
      Left := 2;
      Top := 2;
      Width := 610;
      Height := 428;
      Align := alClient;
      LinkColor := clblue;
      textformat:=tfautotext;
       BorderStyle := bsRaisedPanel;
       filename:=index;
      
  //    OnMouseEnter = Memo1MouseEnter
    end;
     
end;
 procedure TRedstone_install.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
  var p:tpoint;
//  l:tstringlist;
 begin
 //

 p.X:=x;
p.Y:=y;
//f.Caption:=inttostr(lb.ItemAtPos(p,true));
if lb.ItemAtPos(p,true) <> -1 then begin
// l:=tstringlist.create;
 //  F.caption:=Ini.ReadString ('help', lb.items[lb.ItemAtPos(p,true)], 'none');
 //  l.loadfromfile(Ini.ReadString ('help', lb.items[lb.ItemAtPos(p,true)], 'none'));
 //  memo1.lines.assign(l);
 view1.filename:=Ini.ReadString ('help', lb.items[lb.ItemAtPos(p,true)], 'none');
 view1.loadfromfile(view1.filename);
// F.caption:='jjjjj'+view1.filename;
// view1.update;
// l.free;
   end;
   
 end;
 
procedure TRedstone_install.createlistbox;
begin
LB:=tlistbox.create(application);
lb.parent:=p1;
with lb as tlistbox do
begin
//
  Left := 3;
      Top := 3;
    //  Width := 179;
    //  Height := 369;
    //  Style:= lbOwnerDrawVariable;
      Align := alClient;
     BorderStyle := bsnone;
   //   ScrollBars := ssBoth;
    //    BorderWidth := 1;
      Color := 16755370; 
      Font.Color := clWhite;
      Font.size := 12;
      Font.Name := 'sans';
   //   Font.Pitch := fpVariable;
    //  Font.Style := [fsBold, fsItalic, fsUnderline, fsStrikeOut];
    Font.Style := [fsBold];
     // Items.Strings := ( 'sdsdsd' 'sdsdsds');
      MultiSelect := false;
  //    ParentFont := False;
  //    Rows := 2;
  //    TabOrder := 0;
    OnMouseDown := ListBox1MouseDown;
end;

end;

procedure TRedstone_install.createpanel1;
begin
p1:=tpanel.create(application);
p1.parent:=f;
with p1 as tpanel do
begin
  Left := 0;
    Top := 26;
    Width := 185;
  //  Height := 375;
    Align := alLeft;
  //  BevelInner := bvRaised;
    BorderWidth := 1;
 //   BorderStyle := bsSingle;
    Caption := 'Panel1';
   Constraints.MinWidth := 30;
  //  TabOrder := 0;
end;

end;

procedure TRedstone_install.createpanel2;
begin
p2:=tpanel.create(f);
p2.parent:=f;
with p2 as tpanel do
begin
//
  Left := 188;
    Top := 26;
  //  Width := 355;
  //  Height := 375;
    Align := alClient;
  //     BevelInner := bvRaised;
    BorderWidth := 1;
 //   BorderStyle := bsSingle;
    Caption := 'Panel2';
    Constraints.MinWidth := 30;
  //  TabOrder := 1;
  
end;

end;
procedure TRedstone_install.createpanel3;
begin
p3:=tpanel.create(application);
p3.parent:=f;
with p3 as tpanel do
begin
  Left := 0;
    Top := 0;
    height:=38;
  //  Width := 185;
  //  Height := 375;
    Align := altop;
 //   BevelInner := bvRaised;
    BorderWidth := 1;
 //   BorderStyle := bsSingle;
  //  Caption := 'Panel1';
  //  Constraints.MinWidth := 30;
  //  TabOrder := 0;
end;

end;
procedure TRedstone_install.createsplitter;
begin
sp:=tsplitter.create(application);
sp.parent:=f;
with sp as tsplitter do
begin
//
  Left := 185;
    Top := 26;
  //  Height := 375;
 //   Beveled := True;
    Color := clsilver;
    width:=3;
   
end;

end;


initialization

registerclass(TRedstone_install);
finalization
unregisterclass(TRedstone_install);
end.
