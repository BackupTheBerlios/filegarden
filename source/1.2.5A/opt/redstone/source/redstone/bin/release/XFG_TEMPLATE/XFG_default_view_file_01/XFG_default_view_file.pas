unit XFG_default_filemanager;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types,QButtons, QComCtrls,Libc, QMenus
  ,RedStone_Public_Comp, QFileCtrls, SyncObjs,StrUtils
  ,PClass_Command_RedStone
  ;

type

  TXFG_default_filemanager = class(TRedStone_Public_Comp)
    procedure DoClose;
   procedure DoClose2(Sender: TObject; var Action: TCloseAction);
 
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
 //       procedure PCMBClick(Sender: TObject);
   private
 
   PASSxfgmemo:tmemo;
 
    cmb1,cmb2,cmb3,cmb4,cmb5,cmb6:tcombobox;
  lb1,lb2,lb3,lb4,lb5,lb6:tlabel;
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
 application.handle:=nil;
 application.handle:=APass_Handle;
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
 
    f.width:=500;
    f.height:=380;
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
   ///////////////////////////////////////////////////////////////////

if lowercase(ExtractFileName(application.exename))<>'command_redstone' then
begin
for  I := 0 to Screen.FormCount-1 do
begin
if  trim(lowercase(Screen.Forms[I].caption ))='redstone commander' then 
 begin
   ff:=  Screen.Forms[I];
   for ii := ff.ComponentCount - 1 downto 0 do
    begin
     temp := ff.Components[ii]; 
     if (temp is Tfileiconview) then form2filelist:=temp as Tfileiconview;
   
    end;
 end;
 
  
if  trim(lowercase(Screen.Forms[I].caption ))=UserCallingVersion then 
 begin
     ff:=  Screen.Forms[I];
     f.left:=ff.left+50;
     f.top:=ff.top+5;
       for ii := ff.ComponentCount - 1 downto 0 do
    begin
     temp := ff.Components[ii]; 
     if (temp is Tmemo) then 
      begin
       PASSxfgmemo:=temp as Tmemo;
    end; 
    end;
 end;
 

end;//for  I := 0 to Screen.FormCount-1 do
end;//if ExtractFilePath(APass_ExeName)<>'command_redstone' then
 

  

//form2filelist.invalidate;
(*******************************************************************
    for ii := ACallingForm.ComponentCount - 1 downto 0 do
    begin
     temp := ACallingForm.Components[ii]; 
     if (temp is Tmemo) then 
      begin
       PASSxfgmemo:=temp as Tmemo;
      end; 
    end; 
*************************************************************************)
 

    F.caption:='XFG_default_filemanager';
   // F.Show;
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
      instr:='cmb'+stringreplace((temp as Tlabel).name,'lb','',[rfIgnoreCase]);
      cm:=gb3.FindChildControl(instr);

    ini.WriteString('MenuViewWith',(temp as Tlabel).caption,(cm as tcombobox).Text+' $in &');
    end; 
    end;
 ini.updatefile;
 restartxfg:=true;
   end;
   
  if lowercase(caption)='stop search' then
  begin
 
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
(*
MessageDlg ('Configuration changed.' +#13#10+
              'You need to reload then main application by using the menu'+#13#10+
              '    --->   File  |  Reload configurations    ', mtWarning, [mbOK], 0);
*)
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
 end;creatememo
 end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
 
procedure TXFG_default_filemanager.createts1; 
var 
cmbS,labelS:integer;

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
   cmbS:=25;
   labelS:=17;
           
                               
    cmb1:=tcombobox.create(nil);           
 with cmb1 as tcombobox do
 begin
      parent:=gb3;
      name:='cmb1';
            Left := 140;
            Top := 16;
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'me -u root'); 
                  Items.add( 'gedit');  
                   Items.add( 'nedit');  
                    Items.add( 'abiword');  
     ItemIndex := 0;
       end;
      cmb2:=tcombobox.create(nil);           
 with cmb2 as tcombobox do
 begin
      parent:=gb3;
      name:='cmb2';
            Left := 140;
            Top := 16+(cmbS*1)+(2*1);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'dillo'); 
                  Items.add( 'opera');  
                  Items.add( 'galeon');  
                  Items.add( 'mozilla');  
     ItemIndex := 0;
       end;     
      cmb3:=tcombobox.create(nil);           
 with cmb3 as tcombobox do
 begin
      parent:=gb3;
      name:='cmb3';
            Left := 140;
            Top := 16+(cmbS*2)+(2*2);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'display'); 
                  Items.add( 'xv');  
                   Items.add( 'gimp');  
     ItemIndex := 0;
       end;     
      cmb4:=tcombobox.create(nil);           
 with cmb4 as tcombobox do
 begin
      parent:=gb3;
      name:='cmb4';
            Left := 140;
            Top := 16+(cmbS*3)+(2*3);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'gv'); 
            Items.add( 'gsview'); 
            Items.add( 'ggv'); 
     ItemIndex := 0;
       end;     
      cmb5:=tcombobox.create(nil);           
 with cmb5 as tcombobox do
 begin
      parent:=gb3;
      name:='cmb5';
            Left := 140;
            Top := 16+(cmbS*4)+(2*4);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'gv'); 
                  Items.add( 'acroread');  
                  Items.add( 'xpdf');
                  Items.add( 'ggv');
     ItemIndex := 0;
       end;     
             cmb6:=tcombobox.create(nil);           
 with cmb6 as tcombobox do
 begin
      parent:=gb3;
      name:='cmb6';
            Left := 140;
            Top := 16+(cmbS*5)+(2*5);
            Width := 200;
            Height := 23;
            Cursor := crHandPoint;
          //  Style := csDropDownList;
            ItemHeight := 17;
            Items.add( 'xdvi'); 
                  Items.add( 'tkdvi');  
     ItemIndex := 0;
       end;     
  lb1:=tlabel.create(nil);
   with lb1 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb1';
            Left := 20;
            Top := cmb1.top+6;
            Width := 120;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'View text file';
             cmb1.text:=stringreplace(ini.ReadString('MenuViewWith',Caption,'none'),' $in &','',[rfreplaceall,rfIgnoreCase]);
            Layout := tlCenter;
          end;
          
  lb2:=tlabel.create(nil);
   with lb2 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb2';
            Left := 20;
            Top := cmb2.top+6;
            Width := 120;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'View HTML';
            cmb2.text:=stringreplace(ini.ReadString('MenuViewWith',Caption,'none'),' $in &','',[rfreplaceall,rfIgnoreCase]);
            Layout := tlCenter;
          end;
  lb3:=tlabel.create(nil);
   with lb3 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb3';
            Left := 20;
            Top := cmb3.top+6;
            Width := 120;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'View Image';
            cmb3.text:=stringreplace(ini.ReadString('MenuViewWith',Caption,'none'),' $in &','',[rfreplaceall,rfIgnoreCase]);
            Layout := tlCenter;
          end;
  lb4:=tlabel.create(nil);
   with lb4 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb4';
            Left := 20;
            Top := cmb4.top+6;
            Width := 120;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'View PS';
            cmb4.text:=stringreplace(ini.ReadString('MenuViewWith',Caption,'none'),' $in &','',[rfreplaceall,rfIgnoreCase]);
            Layout := tlCenter;
          end;       
          
  lb5:=tlabel.create(nil);
   with lb5 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb5';
            Left := 20;
            Top := cmb5.top+6;
            Width := 120;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'View PDF';
            cmb5.text:=stringreplace(ini.ReadString('MenuViewWith',Caption,'none'),' $in &','',[rfreplaceall,rfIgnoreCase]);
            Layout := tlCenter;
          end;    
          
  lb6:=tlabel.create(nil);
   with lb6 as tlabel  do
   begin    
   parent:=gb3;
   name:='lb6';
            Left := 20;
            Top := cmb6.top+6;
            Width := 120;
            Height := 16;
            Alignment := taLeftJustify;
            AutoSize := false;
            Caption := 'View Dvi';
            cmb6.text:=stringreplace(ini.ReadString('MenuViewWith',Caption,'none'),' $in &','',[rfreplaceall,rfIgnoreCase]);

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
      if lowercase(l1.Strings[mi])='update preview' then continue;
 
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
