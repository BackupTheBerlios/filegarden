unit XFG_default_filemanager;

interface

uses
  Qt,qForms,SysUtils, Classes, qGraphics, qControls,  qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types,QButtons, QComCtrls,Libc, QMenus
  ,RedStone_Public_Comp, QFileCtrls, SyncObjs,StrUtils
  ,PClass_Command_RedStone
  ;

type

  TXFG_default_filemanager = class(TRedStone_Public_Comp)
    procedure DoClose;
   procedure DoClose2(Sender: TObject; var Action: TCloseAction);
procedure ColorDLGClick(Sender: TObject) ;
 procedure FontDLGClick(Sender: TObject) ;
procedure cmbKeyPress(Sender: TObject; var Key: Char);

   procedure createpagecontrol;
   procedure createts1; 
   procedure createts2;
   procedure createts3;
  procedure creatememo;
    procedure createspeedbutton;
    procedure createpanel1;
  procedure createpanel2;
  procedure createsplitter;
  
        procedure SpClick(Sender: TObject);
 //       procedure PEDBClick(Sender: TObject);
   private

   PASSxfgmemo:tmemo;
   ColorDialog1: TColorDialog;
 FontDialog1: TFontDialog;
  EDB1,EDB2,EDB3,EDB4,EDB5,EDB6,EDB7,EDB8:tedit;
  lb1,lb2,lb3,lb4,lb5,lb6,lb7,lb8,lb9,lb10:tlabel;
  CHK1,CHK2:tcheckbox;
  BB1,BB2,BB3,BB4:Tbutton;
BBF1,BBF2,BBF3,BBF4:Tbutton;
  UserCallingDIR,UserCallingIniconf,UserCallingDataDIR,UserCallingVersion:string;
  SaveDialog1:tsavedialog;
  pc:TPagecontrol;
  ts1,ts2,ts3:TTabsheet;
  memo1:tmemo;
  F:TForm;
 restartxfg:Boolean;
 gb3,gb9:tgroupbox;

     p1:tpanel;
     p2:tpanel;
     p3,p4:tpanel;
      sp:TSplitter;
        speedbutton:tspeedbutton;
       
             ini:Tinifile;
AF:TForm;
  
  protected
   form2filelist:tfileiconview;
    form2filelistview:TListView;
  public
  DEBUG:boolean;

    constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
    destructor Destroy; override;
  published

  end;
const
 Iniconf:string='xfg.conf';  
var
K:TPClass_Command_RedStone;

implementation

constructor TXFG_default_filemanager.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList);   
var  i,ii:integer;temp:Tcomponent;  ff:tform;
begin
inherited;

F:=nil; 
form2filelist:=nil;
form2filelistview:=nil;
 application.handle:=nil;
 application.handle:=APass_Handle;
 //application.CreateHandle;
 
  AF:=APass_Form;
  application.HintPause:=50;
application.HintHidePause:=90000;     
//application.font.name:='helvetica';
restartxfg:=false;
DEBUG:=false; 
 K:=TPClass_Command_RedStone.Create(application.Handle,APass_Form,application.exename);
//UserCallingDIR:=ExtractFilePath(APass_ExeName);
//UserCallingIniconf:=UserCallingDIR+Iniconf;
//UserCallingDataDIR:=UserCallingDIR+'data/';
//UserCallingDIR:=K.RS_Calling_APPPath+'/';
UserCallingIniconf:=K.RS_AppConfigPath+'/'+K.RS_App_Configuration_Name+'.'+K.RS_App_Configuration_Extension; 
UserCallingDataDIR:=k.RS_APP_data_dir+'/';
//  constructor Create(ACRS_Handle:QApplicationH;ACRS_Form:TForm;AExeName:String);//override;



//ini:=tinifile.create(ExtractFilePath(Application.ExeName) + 'xfg.conf');
if not fileexists(UserCallingIniconf) then beep;
ini:=tinifile.create(UserCallingIniconf);
if lowercase(Ini.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then DEBUG:=true;

UserCallingVersion:=lowercase(Ini.Readstring ('xfgMain', 'owner', 'none'));

 try
     F := TForm.Create (application);
    try
 
    f.width:=620;
    f.height:=420;
 // f.parent:=af;
    f.top:=screen.height-(screen.height-20);
f.left:=50;
       f.Constraints.MinHeight := f.height;
 f.Constraints.MinWidth := f.width;
// f. Constraints.MaxWidth := f.width;
 f.Constraints.MaxHeight :=  f.Constraints.MinHeight;
//f.onclose:=DoClose2;
f.Font.Charset :=fcsDefaultCharSet;
       createpanel1;
         
       createsplitter;
        
          createpanel2;
           
           createspeedbutton;
          createpagecontrol;
          createts1;
          
       //   createts2;
          createts3;
          creatememo;
          
           if  lowercase(Ini.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then
           begin
      memo1.lines.add(ExtractFilePath(APass_ExeName)); 
        memo1.lines.Add('1 RedStone_SysPath = '+k.RS_SysPath );
  memo1.lines.Add('2 CRS_MainPath = '+k.RS_getrecvalue(extractfilename(application.exename),'main_path') );
  memo1.lines.Add('3 CRS_RecPath = '+k.RS_Calling_APPRecPath );
  memo1.lines.Add('4 CRS_CompRecName = '+k.RS_CompRecName );
  memo1.lines.Add('5 application.exename = '+application.exename );
  memo1.lines.Add('6 extractfilename(AExeName) = '+extractfilename(application.exename) );
  memo1.lines.Add('UserCallingDIR:=ExtractFilePath(APROC) = '+UserCallingDIR);
  memo1.lines.Add('UserCallingIniconf:=UserCallingDIR+Iniconf = '+UserCallingIniconf);
  memo1.lines.Add('UserCallingDataDIR:=UserCallingDIR+''''/data/'''' = '+UserCallingDataDIR);
      end ;
      
       pc.ActivePage := ts1;
 
    F.caption:='XFG_default_filemanager';
   // F.Show;

       ColorDialog1:= TColorDialog.create(F);
   with ColorDialog1 as TColorDialog do
   begin
  ColorDialog1.color:=clwhite;
    end;
       FontDialog1:= TFontDialog.create(F);
   with FontDialog1 as TFontDialog do
   begin
  
    end;
    F.ShowModal;
    /////////////////////////////////////////////////////////////////

   finally
   
 
 DoClose;

    end;   
  
  except
    on E: Exception do begin
      MessageDlg ('Error in Component: '+E.Message, mtError, [mbOK], 0);
  DoClose  ;   

 //f.close;
 
        end;
        


end;
end;


//////////////////////////////////////////////////////////////////////////////////

 procedure TXFG_default_filemanager.SpClick(Sender: TObject);
 
 var  ii:integer;cm,temp:TControl;instr:string;
 begin
 with (sender as tspeedbutton) do
 begin
 
  if lowercase(caption)='apply settings' then
  begin
         for ii := gb3.ControlCount - 1 downto 0 do
    begin
     temp := gb3.Controls[ii]; 
     if (temp is Tlabel) then 
      begin
      instr:='EDB'+stringreplace((temp as Tlabel).name,'lb','',[rfIgnoreCase]);
      cm:=gb3.FindChildControl(instr);
if cm is tedit then
    ini.WriteString('xfgMain',(temp as Tlabel).caption,(cm as tedit).Text);
 
    end; 
    end;
      ini.WriteBool('xfgMain',lb9.caption,chk1.checked);
    //  ini.WriteBool('xfgMain',lb10.caption,chk2.checked);
 
 //(xfgform2 as tform).show; 
    //color:=$00E6E6E6 ;
(*
(form2filelistview).Color := stringtocolor(ini.Readstring ('xfgMain', 'Filemanager_ListView_BGColor', 'none'));
//font.Color := 8940896;
(form2filelistview as tListView).Font.Color := stringtocolor(ini.Readstring ('xfgMain', 'Filemanager_ListView_FGColor', 'none'));
 //  font.name:= 'Lucida';
(form2filelistview as tListView).font.name:= (ini.Readstring ('xfgMain', 'Filemanager_ListView_FontName', 'none'));
//font.size:=11;
(form2filelistview as tListView).font.size:=strtoint(ini.Readstring ('xfgMain', 'Filemanager_ListView_FontSize', 'none'));

(form2filelist as tfileiconview).Color := stringtocolor(ini.Readstring ('xfgMain', 'Filemanager_IconView_BGColor', 'none'));
//font.Color := 8940896;
(form2filelist as tfileiconview).Font.Color := stringtocolor(ini.Readstring ('xfgMain', 'Filemanager_IconView_FGColor', 'none'));
 //  font.name:= 'Lucida';
(form2filelist as tfileiconview).font.name:= (ini.Readstring ('xfgMain', 'Filemanager_IconView_FontName', 'none'));
//font.size:=11;
(form2filelist as tfileiconview).font.size:=strtoint(ini.Readstring ('xfgMain', 'Filemanager_IconView_FontSize', 'none'));
*)
 ini.updatefile;
 restartxfg:=true;
   end;
   
  if lowercase(caption)='use default' then
  begin
  (* //(xfgform2 as tform).show; 
 (form2filelist as tfileiconview).Color := $00E6E6E6 ;EDB1.color:=$00E6E6E6;
 (form2filelist as tfileiconview).Font.Color := 4473924;EDB2.color:=4473924;
 (form2filelist as tfileiconview).font.name:= 'lucida';
 (form2filelist as tfileiconview).font.size:=11;
 (form2filelistview as tListView).Color := $00E6E6E6 ;EDB5.color:=$00E6E6E6;
 (form2filelistview as tListView).Font.Color := 8940896;EDB6.color:=8940896;
 (form2filelistview as tListView).font.name:= 'helvetica';
 (form2filelistview as tListView).font.size:=11;
 *)
 ini.Writestring ('xfgMain', 'Filemanager_IconView_BGColor', '$00E6E6E6');
 ini.Writestring ('xfgMain', 'Filemanager_IconView_FGColor', '4473924');
 ini.Writestring ('xfgMain', 'Filemanager_IconView_FontName', 'lucida');
 ini.Writestring ('xfgMain', 'Filemanager_IconView_FontSize', '11');
 ini.Writestring ('xfgMain', 'Filemanager_ListView_BGColor', '$00E6E6E6');
 ini.Writestring ('xfgMain', 'Filemanager_ListView_FGColor', '8940896');
 ini.Writestring ('xfgMain', 'Filemanager_ListView_FontName', 'helvetica');
 ini.Writestring ('xfgMain', 'Filemanager_ListView_FontSize', '11');
 ini.WriteBool('xfgMain',lb9.caption,true);
EDB1.color:=$00E6E6E6;EDB2.color:=4473924;EDB5.color:=$00E6E6E6;EDB6.color:=8940896;
EDB1.text:='$00E6E6E6';
EDB2.text:='4473924';
EDB3.text:='lucida';
EDB4.text:='11';
EDB5.text:='$00E6E6E6';
EDB6.text:='8940896';
EDB7.text:='helvetica';
EDB8.text:='11';
 ini.updatefile;
 restartxfg:=true;
   end;
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

end;
 end;//
 

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
  procedure TXFG_default_filemanager.DoClose;
 
begin
 
if restartxfg=true then   

MessageDlg ('Configuration changed.' +#13#10+
              'You need to reload then main application by using the menu'+#13#10+
              '    --->   File  |  Reload configurations    ', mtWarning, [mbOK], 0);

ini.free;

k.free;    

F.free;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

 procedure TXFG_default_filemanager.DoClose2(Sender: TObject; var Action: TCloseAction);
 
begin

     ini.free;

k.free;    

F.free;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TXFG_default_filemanager.FontDLGClick(Sender: TObject) ;
begin

if FontDialog1.execute then
begin
if (sender as tbutton).name='BBF1' then 
begin
EDB3.text:=fontDialog1.font.name;
EDB4.text:=inttostr(fontDialog1.font.size);
end;
if (sender as tbutton).name='BBF2' then 
begin
EDB3.text:=fontDialog1.font.name;
EDB4.text:=inttostr(fontDialog1.font.size);
end;
if (sender as tbutton).name='BBF3' then 
begin
EDB7.text:=fontDialog1.font.name;
EDB8.text:=inttostr(fontDialog1.font.size);
end;
if (sender as tbutton).name='BBF4' then 
begin
EDB7.text:=fontDialog1.font.name;
EDB8.text:=inttostr(fontDialog1.font.size);
end;
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TXFG_default_filemanager.ColorDLGClick(Sender: TObject) ;
begin

if ColorDialog1.execute then
begin
//(APASSMemo as tmemo).font:=fontdialog1.font;
if (sender as tbutton).name='BB1' then 
begin
EDB1.color:=ColorDialog1.color;
EDB1.text:=ColorToString(ColorDialog1.color);
end;
if (sender as tbutton).name='BB2' then 
begin
EDB2.color:=ColorDialog1.color;
EDB2.text:=ColorToString(ColorDialog1.color);
end;
if (sender as tbutton).name='BB3' then 
begin
EDB5.color:=ColorDialog1.color;
EDB5.text:=ColorToString(ColorDialog1.color);
end;
if (sender as tbutton).name='BB4' then 
begin
EDB6.color:=ColorDialog1.color;
EDB6.text:=ColorToString(ColorDialog1.color);
end;
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TXFG_default_filemanager.cmbKeyPress(Sender: TObject; var Key: Char);
begin
//Key:=;
(sender as tedit).text:=(sender as tedit).text;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TXFG_default_filemanager.createpagecontrol; 
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
 creatememo
 end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TXFG_default_filemanager.createts1; 
var 
EDBS,labelS,lbWidth,EDBLeft:integer;

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


 gb3:=tgroupbox.create(application);
with gb3 as tgroupbox  do
begin
parent:=p3;
 Left := 5;
   Align := alClient;
          Top := 8;
(*         
View Man=man !in | col -bx
View Dvi=xdvi %in &
View text file=me -u root $in &
View PS=gv %in &
View PDF=gv %in &
View HTML=dillo %in &
View Image=display %in &
Play sound with Xine=xine -g -I -H --no-logo --no-splash --session session=0,quit ; xine -g -Z --no-logo --no-splash --loop=loop --enqueue $in -pq --session session=0,playlist=first,play &
Play video with Xine=xine -g -I -H --no-logo --no-splash --session session=0,quit ; xine -g -Z --no-logo --no-splash --loop=loop --enqueue $in -pq --session session=0,playlist=first,play &
Play sound with XMMS=xmms -ep $in &
View with Gimp=gimp $in &
View with XFig=xfig $in &
View PDF with Acroread=acroread $in &
*)
   EDBS:=25;
   labelS:=17;
   EDBLeft:=240;        
   lbWidth:=200;
                               
    EDB1:=tedit.create(nil);           
 with EDB1 as tedit do
 begin
      parent:=gb3;
      name:='EDB1';
            Left := EDBLeft;
            Top := 16;
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
            ReadOnly:=true;
       //   Style :=   csOwnerDrawFixed;
        //  Style := csDropDownList;
       end;
       
     BB1:=tbutton.create(nil);           
 with BB1 as tbutton do
 begin
      parent:=gb3;
      name:='BB1';
            Left := EDBLeft+200+5;
            Top := 16;
            Width := 23;
            Height := 23;
            Cursor := crHandPoint;
            caption:='...';
          OnClick:=ColorDLGClick;
       end;
       
      EDB2:=tedit.create(nil);           
 with EDB2 as tedit do
 begin
      parent:=gb3;
      name:='EDB2';
            Left := EDBLeft;
            Top := 16+(EDBS*1)+(2*1);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
            ReadOnly:=true;
       //   Style := csDropDownList;
       end;   
       
caption:='';
 BB2:=tbutton.create(nil);        
 with BB2 as tbutton do
 begin
      parent:=gb3;
      name:='BB2';
            Left := EDBLeft+200+5;
            Top := 16+(EDBS*1)+(2*1);
            Width := 23;
            Height := 23;
            Cursor := crHandPoint;
            caption:='...';
          OnClick:=ColorDLGClick;
       end;  
       

      EDB3:=tedit.create(nil);           
 with EDB3 as tedit do
 begin
      parent:=gb3;
      name:='EDB3';
            Left := EDBLeft;
            Top := 16+(EDBS*2)+(2*2);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
            ReadOnly:=true;
 
         //   Style := csDropDownList;
       end; 
       
 BBF1:=tbutton.create(nil);        
 with BBF1 as tbutton do
 begin
      parent:=gb3;
      name:='BBF1';
            Left := EDBLeft+200+5;
            Top := 16+(EDBS*2)+(2*2);
            Width := 23;
            Height := 23;
            Cursor := crHandPoint;
            caption:='...';
          OnClick:=FontDLGClick;
       end;  
       
      EDB4:=tedit.create(nil);           
 with EDB4 as tedit do
 begin
      parent:=gb3;
      name:='EDB4';
            Left := EDBLeft;
            Top := 16+(EDBS*3)+(2*3);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
            ReadOnly:=true;
            
        //   Style := csDropDownList;
       end; 
       
 BBF2:=tbutton.create(nil);        
 with BBF2 as tbutton do
 begin
      parent:=gb3;
      name:='BBF2';
            Left := EDBLeft+200+5;
            Top := 16+(EDBS*3)+(2*3);
            Width := 23;
            Height := 23;
            Cursor := crHandPoint;
            caption:='...';
          OnClick:=FontDLGClick;
       end;  
       
      EDB5:=tedit.create(nil);           
 with EDB5 as tedit do
 begin
      parent:=gb3;
      name:='EDB5';
            Left := EDBLeft;
            Top := 16+(EDBS*4)+(2*4);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
             ReadOnly:=true;
      //    Style := csDropDownList;
       end;  
       
  
 BB3:=tbutton.create(nil);              
 with BB3 as tbutton do
 begin
      parent:=gb3;
      name:='BB3';
            Left := EDBLeft+200+5;
            Top := 16+(EDBS*4)+(2*4);
            Width := 23;
            Height := 23;
            Cursor := crHandPoint;
            caption:='...';
            OnClick:=ColorDLGClick;
       end;   
       

      EDB6:=tedit.create(nil);           
 with EDB6 as tedit do
 begin
      parent:=gb3;
      name:='EDB6';
            Left := EDBLeft;
            Top := 16+(EDBS*5)+(2*5);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
            ReadOnly:=true;
             //         Style := csDropDownList;
       end;  
       

BB4:=tbutton.create(nil);        
 with BB4 as tbutton do
 begin
      parent:=gb3;
      name:='BB4';
            Left := EDBLeft+200+5;
            Top := 16+(EDBS*5)+(2*5);
            Width := 23;
            Height := 23;
            Cursor := crHandPoint;
            caption:='...';
            OnClick:=ColorDLGClick;
          //  Style := csDropDownList;
       end;     
            
      EDB7:=tedit.create(nil);           
 with EDB7 as tedit do
 begin
      parent:=gb3;
      name:='EDB7';
            Left := EDBLeft;
            Top := 16+(EDBS*6)+(2*6);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
            ReadOnly:=true;
       //     Style := csDropDownList;
       end;   
        
 BBF3:=tbutton.create(nil);        
 with BBF3 as tbutton do
 begin
      parent:=gb3;
      name:='BBF3';
            Left := EDBLeft+200+5;
            Top := 16+(EDBS*6)+(2*6);
            Width := 23;
            Height := 23;
            Cursor := crHandPoint;
            caption:='...';
          OnClick:=FontDLGClick;
       end;  
             
      EDB8:=tedit.create(nil);           
 with EDB8 as tedit do
 begin
      parent:=gb3;
      name:='EDB8';
            Left := EDBLeft;
            Top := 16+(EDBS*7)+(2*7);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
            ReadOnly:=true;
       //    Style := csDropDownList;
       end;   
         
 BBF4:=tbutton.create(nil);        
 with BBF4 as tbutton do
 begin
      parent:=gb3;
      name:='BBF4';
            Left := EDBLeft+200+5;
            Top := 16+(EDBS*7)+(2*7);
            Width := 23;
            Height := 23;
            Cursor := crHandPoint;
            caption:='...';
          OnClick:=FontDLGClick;
       end; 
 CHK1:=tcheckbox.create(nil); 
 with CHK1 as tcheckbox do
 begin
      parent:=gb3;
      name:='CHK1';
            Left := EDBLeft;
            Top := 16+(EDBS*8)+(2*8);
            Width := 15;
            Height := 23;
            Cursor := crHandPoint;
            caption:='';
        //    ReadOnly:=true;
       //    Style := csDropDownList;
       end; 
        CHK2:=tcheckbox.create(nil); 
  
 
  lb1:=tlabel.create(nil);
   with lb1 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb1';
            Left := 20;
            Top := EDB1.top+6;
            Width := lbWidth;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'Filemanager_IconView_BGColor';
             EDB1.text:=ini.ReadString('xfgMain',Caption,'none');
             EDB1.color:=stringtocolor(EDB1.text);
            Layout := tlCenter;
          end;
          
  lb2:=tlabel.create(nil);
   with lb2 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb2';
            Left := 20;
            Top := EDB2.top+6;
            Width := lbWidth;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'Filemanager_IconView_FGColor';
            EDB2.text:=ini.ReadString('xfgMain',Caption,'none');
            EDB2.color:=stringtocolor(EDB2.text);
            Layout := tlCenter;
          end;
  lb3:=tlabel.create(nil);
   with lb3 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb3';
            Left := 20;
            Top := EDB3.top+6;
            Width := lbWidth;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'Filemanager_IconView_FontName';
            EDB3.text:=ini.ReadString('xfgMain',Caption,'none');
            Layout := tlCenter;
          end;
  lb4:=tlabel.create(nil);
   with lb4 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb4';
            Left := 20;
            Top := EDB4.top+6;
            Width := lbWidth;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'Filemanager_IconView_FontSize';
            EDB4.text:=ini.ReadString('xfgMain',Caption,'none');
            Layout := tlCenter;
          end;       
          
  lb5:=tlabel.create(nil);
   with lb5 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb5';
            Left := 20;
            Top := EDB5.top+6;
            Width := lbWidth;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'Filemanager_ListView_BGColor';
            EDB5.text:=ini.ReadString('xfgMain',Caption,'none');
            EDB5.color:=stringtocolor(EDB5.text);
            Layout := tlCenter;
          end;    
          
  lb6:=tlabel.create(nil);
   with lb6 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb6';
            Left := 20;
            Top := EDB6.top+6;
            Width := lbWidth;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'Filemanager_ListView_FGColor';
            EDB6.text:=ini.ReadString('xfgMain',Caption,'none');
            EDB6.color:=stringtocolor(EDB6.text);
            Layout := tlCenter;
          end;        
                            
  lb7:=tlabel.create(nil);
   with lb7 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb7';
            Left := 20;
            Top := EDB7.top+6;
            Width := lbWidth;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'Filemanager_ListView_FontName';
            EDB7.text:=ini.ReadString('xfgMain',Caption,'none');
            Layout := tlCenter;
          end;        
  
  lb8:=tlabel.create(nil);
   with lb8 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb8';
            Left := 20;
            Top := EDB8.top+6;
            Width := lbWidth;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'Filemanager_ListView_FontSize';
            EDB8.text:=ini.ReadString('xfgMain',Caption,'none');
            Layout := tlCenter;
          end;        
//Always_Use_RecycleBin=none
//Always_List_File_OnDoubleClick=none
  lb9:=tlabel.create(nil);
   with lb9 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb9';
            Left := 20;
            Top := CHK1.top+6;
            Width := lbWidth;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'Always_Use_RecycleBin';
            CHK1.checked:=ini.ReadBool('xfgMain',Caption,true);
            Layout := tlCenter;
          end;    
          
 
     end;//with gb3 as tgroupbox  do


end;
   end;
        
end;

procedure TXFG_default_filemanager.createts2; 
begin
 ts2:=TTabSheet.Create(application);
      with ts2 do
      begin
        parent:=pc;
      PageControl := pc;
    caption:='Advance';  
    
p4:=tpanel.create(application);
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


 gb9:=tgroupbox.create(application);
with gb9 as tgroupbox  do
begin
parent:=p4;
      Left := 5;
    Top := 8;
    Align := alClient;
    

end;
end;

end;
//

procedure TXFG_default_filemanager.createts3; 
begin
 ts3:=TTabSheet.Create(application);
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
 



procedure TXFG_default_filemanager.creatememo;
begin
   memo1:=tmemo.create(application);
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
   //   TabOrder := 0;
      WordWrap := False;
      readonly:=false;
       BorderStyle := bsRaisedPanel;
  //    OnMouseEnter = Memo1MouseEnter
    end;
     
end;

procedure TXFG_default_filemanager.createspeedbutton;
var  mi,sbint:integer;ss:string;
 l1:tstringlist;
begin
l1:=tstringlist.create;
 Ini.ReadSection('xfgOptionsSidePanel',l1);
   sbint:=10;
 for mi := 0 to l1.Count - 1 do 
begin
  
 
speedbutton:=TSpeedButton.Create (application);
speedbutton.parent:=p1;
 speedbutton.left:=8;
 speedbutton.font.style:=[fsbold];
 speedbutton.font.color:=clwhite;
  speedbutton.font.name:='sans';
      speedbutton.Top := sbint;
      speedbutton.Width := 95;
      speedbutton.Height := 70;
      ss:= l1.Strings[mi];
          if lowercase(l1.Strings[mi])='update preview' then  ss:= 'Use Default';
    
    
      speedbutton.Hint :=ss;
       speedbutton.caption:=ss;
      speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
      if fileexists(Ini.Readstring ('xfgOptionsSidePanel', l1.Strings[mi], 'none'))=true then
     SpeedButton.Glyph.LoadFromFile(Ini.Readstring ('xfgOptionsSidePanel', l1.Strings[mi], 'none'));
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


procedure TXFG_default_filemanager.createpanel1;
begin
p1:=tpanel.create(application);
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

procedure TXFG_default_filemanager.createpanel2;
begin

p2:=tpanel.create(application);
p2.parent:=f;
with p2 as tpanel do
begin

  Left := 188;
    Top := 0;
  //  Width := 355;
  //  Height := 375;
    Align := alClient;
  //     BevelInner := bvRaised;
    BorderWidth := 1;
 //   BorderStyle := bsSingle;
 //   Caption := 'Panel2';
  //  Constraints.MinWidth := 30;
  //  TabOrder := 1;
  
end;

end;

procedure TXFG_default_filemanager.createsplitter;
begin
sp:=tsplitter.create(application);
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

destructor TXFG_default_filemanager.Destroy;

begin

inherited;

end;



initialization
registerclass(TXFG_default_filemanager);
finalization

unregisterclass(TXFG_default_filemanager);
end.
