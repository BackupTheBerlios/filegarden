unit Redstone_script;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types,QButtons, QComCtrls,Libc
  ,RedStone_Public_Comp, QFileCtrls
  ,PClass_Command_RedStone
  ;

type
  TRedstone_script = class(TRedStone_Public_Comp)
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
    procedure headertextBBclick(Sender: TObject);
        procedure SpClick(Sender: TObject);
 //       procedure PCMBClick(Sender: TObject);
   private
  UserCallingDIR,UserCallingIniconf,UserCallingDataDIR:string;
   lbox,lbox2:tlistbox;
  SaveDialog1:tsavedialog;
  previewEXE,papersize,orientation,sides:string;
  pc:TPagecontrol;
  ts1,ts2,ts3:TTabsheet;
    F,fontF:tform;
  memo1:tmemo;
  edit1:tedit;
  cmb:tcombobox;
  lb:tlabel;
  gb1,gb2,gb3,gb4,gb5,gb6,gb7,gb8,gb9,gb10,gb11,
  gb12,gb13,gb14,gb15:tgroupbox;
   img1,img2,img3,img4,img5,img6,img7,img8:timage;
  sb1,sb2,sb3,sb4:tspeedbutton;
  FirstTime,ToBooklet:boolean;
K:TPClass_Command_RedStone;
     p1:tpanel;
     p2:tpanel;
     p3,p4:tpanel;
      sp:TSplitter;
        speedbutton:tspeedbutton;
           APassStringList, l1,l2:tstringlist;
             ini:Tinifile;
AF:TForm;
  protected
BookletFilePathCaption:string;
 form2filelist:tfileiconview;
  ff:tform;
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

constructor TRedstone_script.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); 
var  temp:tcomponent;i:integer;
begin
inherited;
DEBUG:=false;
APassStringList:=APassStringList;
UserCallingDIR:=ExtractFilePath(APass_ExeName);
UserCallingIniconf:=UserCallingDIR+Iniconf;
UserCallingDataDIR:=UserCallingDIR+'data/';
FirstTime:=true;
ToBooklet:=false;
F:=nil; 
 application.handle:=nil;
 application.handle:=APass_Handle;
  AF:=APass_Form;
  application.HintPause:=50;
application.HintHidePause:=90000;     
 previewEXE:='';  
//  constructor Create(ACRS_Handle:QApplicationH;ACRS_Form:TForm;AExeName:String);//override;
  K:=TPClass_Command_RedStone.Create(application.Handle,APass_Form,application.exename);
l1:=tstringlist.create;
l2:=tstringlist.create;
//ini:=tinifile.create(ExtractFilePath(Application.ExeName) + 'xfg.conf');
ini:=tinifile.create(UserCallingIniconf);
if lowercase(Ini.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then DEBUG:=true;
   if  lowercase(Ini.Readstring ('xfgPrintBooklet', 'pagetopostcript2booklet', 'none'))='true' then 
   ToBooklet:=true;
 Ini.ReadSection('xfgOptionsSidePanel',l1); 


 try
     F := TForm.Create (application);
    try
    f.position:=poscreencenter;
    f.width:=660;
    f.height:=400;
 // f.parent:=af;
       createpanel1;
        
        createsplitter;
          createpanel2;
            createspeedbutton;
          createpagecontrol;
          createts1;
          
          createts2;
          createts3;
          creatememo;
         
          memo1.lines.add(ExtractFilePath(APass_ExeName)); 
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
         F.caption:='Redstone_script';
       pc.ActivePage := ts1;
   ///////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////

  for  I := 0 to Screen.FormCount-1 do
 if  lowercase(Screen.Forms[I].caption )='redstone commander' then ff:=  Screen.Forms[I];
 
 for I := ff.ComponentCount - 1 downto 0 do
  begin
    temp := ff.Components[I]; 
    if (temp is Tfileiconview) then begin
   form2filelist:=temp as Tfileiconview;break;
    end; end;
//f.caption:=ff.caption+'      '+inttostr(form2filelist.items.count);
form2filelist.invalidate;
///////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////

      
   F.ShowModal;
  
   finally
   
 DoClose;


    end;   
  
  except
    on E: Exception do begin
      MessageDlg ('Error in Component: '+E.Message, mtError, [mbOK], 0);
        
 
  doclose;
        end;
        

  end;
 
end;
 procedure TRedstone_script.SpClick(Sender: TObject);
var
p:tpoint;
  l1,l2,l3:tstringlist;
  i,ii,currP,groupP,l2int,index:integer;
  intP:extended;
  pagerange,ss,instr,outstr,enscript,instr2,backupstr:string;
  l2First:Boolean;
 
 
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

end;
 end;//
 

   procedure TRedstone_script.headertextBBclick(Sender: TObject);
   begin
   //
   end;
(******************************************************************************************************)

  procedure TRedstone_script.DoClose;
  var
 sr: TSearchRec; 
begin
//if ToBooklet=true then ini.writestring('xfgPrintBooklet','pagetopostcript2booklet','false');
//
     //   memo1.lines.savetofile(ExtractFilePath(Application.ExeName) + 'xfg.conf');
 if FindFirst(UserCallingDataDIR+'*.jpg.*', faAnyFile, sr) = 0 then
    begin
      repeat
              if pos('pagesetupTMP',sr.name)<>0  then
       begin
        if sr.name<>'Redstone_scriptTMP.jpg' then 
       
      deletefile(UserCallingDataDIR+sr.name);
     
      end;
      until FindNext(sr) <> 0;
        FindClose(sr);    
     end;
(******************************************************************************************************)
      ini.free;
l1.free;

l2.free;
k.free;    

F.free;
end;

procedure TRedstone_script.createpagecontrol; 
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
 
procedure TRedstone_script.createts1; 

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
       //   Width := ts1.width div 2;
       //   Height := 340;
          //    Caption := 'Page format';
  cmb:=tcombobox.create(gb3);           
 with cmb as tcombobox do
 begin
      //       Left := 8;
      //      Top := 144;
       //     Width := 177;
       //     Height := 23;
 
     parent:=gb3;
            Left := 140;
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
       

            
  lb:=tlabel.create(nil);
   with lb as tlabel  do
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
          



end;//with gb3 as tgroupbox  do


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
  

 
procedure TRedstone_script.createts2; 
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
      Left := 5;
    Top := 8;
    Align := alClient;

 
  cmb:=tcombobox.create(nil);           
 with cmb as tcombobox do
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
       

  lb:=tlabel.create(nil);
   with lb as tlabel  do
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
end;
end;

end;
//

procedure TRedstone_script.createts3; 
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
 



procedure TRedstone_script.creatememo;
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
   //   TabOrder := 0;
      WordWrap := False;
      readonly:=false;
       BorderStyle := bsRaisedPanel;
  //    OnMouseEnter = Memo1MouseEnter
    end;
     
end;

procedure TRedstone_script.createspeedbutton;
var  mi,sbint:integer;

begin

   sbint:=10;
 for mi := 0 to l1.Count - 1 do 
begin
    if lowercase(l1.Strings[mi])='update preview' then continue;

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


procedure TRedstone_script.createpanel1;
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

procedure TRedstone_script.createpanel2;
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

procedure TRedstone_script.createsplitter;
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

destructor TRedstone_script.Destroy;

begin

inherited;



end;



initialization
registerclass(TRedstone_script);
finalization

unregisterclass(TRedstone_script);
end.
