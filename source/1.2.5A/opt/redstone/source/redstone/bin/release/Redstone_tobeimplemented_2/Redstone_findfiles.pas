unit Redstone_findfiles;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types,QButtons, QComCtrls,Libc, QMenus
  ,RedStone_Public_Comp, QFileCtrls, SyncObjs,StrUtils
  ,PClass_Command_RedStone
  ;

type
///////////////////////////////////////////////////////////////////////////////////////////
TRunMultiTask2 = class (TThread)
  private
  protected
   TAPASSMODE:integer;
    TAPASSMASK: string; 
    TAPASS2FileNAME: string; 
    TAPASSFolder: string; 
    TAPASSFileNAME: string; 
    TAPASSFindFirst: string; 
    TAPASSLst: TStrings;
     TAPASSMEMO:Tmemo;
    procedure CheckExpression;
    procedure RECURSESearchDir2(T2APASSFolder: string);
    procedure runMEMOAppend;
    procedure Execute; override;
     procedure cleanup;
        procedure checkout2(Sender: TObject);
 //      procedure checkout2(Sender: TObject);
  public
    AIO: PIOFile;
constructor Create(APASSFolder: string; APASSMASK: string; APASSLst: TStrings;APASSMEMO:Tmemo;MODE:integer);
  end;
/////////////////////////////////////////////////////////////////////////////////////////////// 
  TRedstone_findfiles = class(TRedStone_Public_Comp)
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
   procedure checkout2(Sender: TObject);
        procedure SpClick(Sender: TObject);
 //       procedure PCMBClick(Sender: TObject);
   private
    
   MT_FILE_SEARCH_TASK_RUNNING:BOOLEAN;
   MT2:TRunMultiTask2;
   PASSxfgmemo:tmemo;
 
   
  UserCallingDIR,UserCallingIniconf,UserCallingDataDIR,UserCallingVersion:string;
  SaveDialog1:tsavedialog;
  pc:TPagecontrol;
  ts1,ts2,ts3:TTabsheet;
  memo1:tmemo;
  F:TForm;
  cmb:tcombobox;
  lb:tlabel;
 gb3,gb9:tgroupbox;

     p1:tpanel;
     p2:tpanel;
     p3,p4:tpanel;
      sp:TSplitter;
        speedbutton:tspeedbutton;
        l1,l2:tstringlist;
             ini:Tinifile;
AF:TForm;
  
  protected
BookletFilePathCaption:string;
 form2filelist:tfileiconview;

  public
  DEBUG:boolean;
  sbStartSearch,sbStopSearch:tspeedbutton;
    constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
    destructor Destroy; override;
  published

  end;
const
 Iniconf:string='xfg.conf';  
var
K:TPClass_Command_RedStone;
 Critical1: TCriticalSection;
implementation

constructor TRedstone_findfiles.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
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

Critical1 := TCriticalSection.Create;
MT2:=nil;
MT_FILE_SEARCH_TASK_RUNNING:=false;
DEBUG:=false;
UserCallingDIR:=ExtractFilePath(APass_ExeName);
UserCallingIniconf:=UserCallingDIR+Iniconf;
UserCallingDataDIR:=UserCallingDIR+'data/';

 

//  constructor Create(ACRS_Handle:QApplicationH;ACRS_Form:TForm;AExeName:String);//override;
  K:=TPClass_Command_RedStone.Create(application.Handle,APass_Form,application.exename);
l1:=tstringlist.create;
l2:=tstringlist.create;
//ini:=tinifile.create(ExtractFilePath(Application.ExeName) + 'xfg.conf');
ini:=tinifile.create(UserCallingIniconf);
if lowercase(Ini.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then DEBUG:=true;
 Ini.ReadSection('xfgOptionsSidePanel',l1); 
UserCallingVersion:=lowercase(Ini.Readstring ('xfgMain', 'owner', 'none'));

 try
     F := TForm.Create (application);
    try
   
    f.width:=660;
    f.height:=410;
 // f.parent:=af;
 
//f.onclose:=DoClose2;

       createpanel1;
        
        createsplitter;
          createpanel2;
            createspeedbutton;
          createpagecontrol;
          createts1;
          
          createts2;
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



  
 /////////////////////////////////////////////////////////////////

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
 

    F.caption:='Redstone_findfiles';
   // F.Show;
    F.ShowModal;
    
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
//////////////////////////////////////////////////////////////////////////////////


constructor TRunMultiTask2.Create(APASSFolder: string; APASSMASK: string; 
                         APASSLst: TStrings;APASSMEMO:Tmemo;MODE:integer);
begin
//AIO:=popen(pchar(' > /dev/null'),'r');

TAPASSFindFirst:='';
  TAPASSFolder:= APASSFolder; 
    TAPASSMASK:= APASSMASK; 
       TAPASSFileNAME:= '';; 
    TAPASSLst:=(APASSMEMO.lines); 
    TAPASSMEMO:= APASSMEMO; 
    TAPASS2FileNAME:='';
  TAPASSMODE:=MODE;
inherited create(false);
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TRunMultiTask2.runMEMOAppend;
var start:integer;
begin
//Critical1.Enter;   
start:= TAPASSMEMO.GetTextLen;  
TAPASSMEMO.append(TAPASS2FileNAME); 
TAPASSMEMO.SelStart:=start+1;
//Critical1.leave;   
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TRunMultiTask2.CheckExpression;
var 
fr:tfilerecord;
begin
fr:=k.CRS_GETFileRecord(TAPASS2FileNAME);
if fr.owner_name='root' then
  Synchronize (runMEMOAppend);   
end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TRunMultiTask2.RECURSESearchDir2(T2APASSFolder: string);
var SearchRec: TSearchRec;
begin

    if FindFirst(T2APASSFolder+TAPASSMASK, faReadOnly Or faHidden
        Or faSysFile Or faArchive, SearchRec) = 0 then
      try
        repeat
        if terminated then  break;
      
        TAPASS2FileNAME:=T2APASSFolder+SearchRec.Name;
        CheckExpression;
        
          //APASSLst.Add(APASSFolder + SearchRec.Name);
        until FindNext(SearchRec) <> 0;
      finally
        FindClose(SearchRec);
      end;
   
    if FindFirst(T2APASSFolder+TAPASSMASK, faReadOnly Or faHidden Or faSysFile
        Or faArchive Or faDirectory, SearchRec) = 0 then
      try
     
        repeat
        if terminated then  break;
       
          if ((SearchRec.Attr and faDirectory) <> 0)
              and (SearchRec.Name <> '.')
              and (SearchRec.Name <> '..') then
              begin
            RECURSESearchDir2(T2APASSFolder+SearchRec.Name+ '/');
              end;
        until FindNext(SearchRec) <> 0;
      finally
        FindClose(SearchRec);
      end;
 
  end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TRunMultiTask2.Execute;
var 
i:integer;
tempLST:tstringlist;
begin
tempLST:=tstringlist.create;
//freeonterminate:=true;
TAPASSMODE:=2;
if TAPASSMODE=1 then
begin
    RECURSESearchDir2((TAPASSFolder));
end;  
  
if TAPASSMODE=2 then
begin
tempLST.assign(TAPASSLst);
for i:=0 to tempLST.count-1 do
begin
if terminated then break;
if not directoryexists(tempLST[i])then 
begin
TAPASS2FileNAME:=tempLST[i];
CheckExpression;
continue;
end;
if directoryexists(tempLST[i])then 
begin
if RightStr(trim(tempLST[i]),1)='/' then
RECURSESearchDir2((tempLST[i]));
if RightStr(trim(tempLST[i]),1)<>'/' then
RECURSESearchDir2((tempLST[i])+'/');
end;

end;
tempLST.free;
end;

end;
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

procedure TRunMultiTask2.cleanup;
begin
;
end;  
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TRunMultiTask2.checkout2(Sender: TObject);
begin

// libc.pclose(AIO);
 //wait(nil); 


end;  
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
procedure TRedstone_findfiles.checkout2(Sender: TObject);
begin
  if  MT_FILE_SEARCH_TASK_RUNNING=true then
  begin
MT2.terminate;
//libc.pclose(MT2.AIO);
 //wait(nil); 
sbStartSearch.enabled:=true;
sbStopSearch.enabled:=false;
MT_FILE_SEARCH_TASK_RUNNING:=false;
end;
end;  
//////////////////////////////////////////////////////////////////////////////////

 procedure TRedstone_findfiles.SpClick(Sender: TObject);
 
 
 begin
 with (sender as tspeedbutton) do
 begin
  if lowercase(caption)='start search' then
  begin
  
(*********************************
  if  MT_FILE_SEARCH_TASK_RUNNING=true then

MT2.terminate;
MT_FILE_SEARCH_TASK_RUNNING:=false;
//MT2:=nil;
 MT2 := TRunMultiTask2.Create (form2filelist.directory.location, '*', PASSxfgmemo.lines,PASSxfgmemo,1);
MT2.policy:=SCHED_OTHER;
MT2.priority:=0;
MT2.onterminate:=checkout2;
// MT2.Resume;
MT_FILE_SEARCH_TASK_RUNNING:=true;
sbStartSearch.enabled:=false;
sbStopSearch.enabled:=true;
*********************************)
   end;
   
  if lowercase(caption)='stop search' then
  begin
  (*********************************
 if  MT_FILE_SEARCH_TASK_RUNNING=true then 
MT2.terminate;
//MT2.free;
//MT2:=nil;

sbStartSearch.enabled:=true;
sbStopSearch.enabled:=false;
MT_FILE_SEARCH_TASK_RUNNING:=false;
*********************************)
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
  procedure TRedstone_findfiles.DoClose;
 
begin
 

Critical1.Free;
      ini.free;
l1.free;

l2.free;
k.free;    
 if  MT_FILE_SEARCH_TASK_RUNNING=true then
 begin
MT2.terminate;
MT_FILE_SEARCH_TASK_RUNNING:=false;
end;
F.free;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

 procedure TRedstone_findfiles.DoClose2(Sender: TObject; var Action: TCloseAction);
 
begin
 if  MT_FILE_SEARCH_TASK_RUNNING=true then
  if not MT2.terminated then
MT2.terminate;
MT_FILE_SEARCH_TASK_RUNNING:=false;
Critical1.Free;
     ini.free;
l1.free;

l2.free;
k.free;    

F.free;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TRedstone_findfiles.createpagecontrol; 
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
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
 
procedure TRedstone_findfiles.createts1; 

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
          
lb:=tlabel.create(nil);
   with lb as tlabel  do
   begin    
   parent:=gb3;
            Left := 70;
            Top := (f.height div 2 )-80;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
             caption:='To be implemented , please go to  http://redstone.sourceforge.net/   '+#13#10+
'to check the status and download this component plugin.'+#13#10;
            Layout := tlCenter;
          end;

        
(*********************************
    cmb:=tcombobox.create(gb3);           
 with cmb as tcombobox do
 begin
 
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
          

*********************************)

end;//with gb3 as tgroupbox  do


end;
   end;
        
end;

procedure TRedstone_findfiles.createts2; 
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
    
lb:=tlabel.create(nil);
   with lb as tlabel  do
   begin    
   parent:=gb9;
           Left := 70;
            Top := (f.height div 2 )-80;
            Width := 65;
            Height := 15;
            Alignment := taCenter;
            AutoSize := true;
             caption:='To be implemented , please go to  http://redstone.sourceforge.net/   '+#13#10+
'to check the status and download this component plugin.'+#13#10;
            Layout := tlCenter;
          end;


 (*********************************
  cmb:=tcombobox.create(nil);           
 with cmb as tcombobox do
 begin
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
          
*********************************)
end;
end;

end;
//

procedure TRedstone_findfiles.createts3; 
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
 



procedure TRedstone_findfiles.creatememo;
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

procedure TRedstone_findfiles.createspeedbutton;
var  mi,sbint:integer;ss:string;

begin

   sbint:=10;
 for mi := 0 to l1.Count - 1 do 
begin
speedbutton:=TSpeedButton.Create (nil);
speedbutton.parent:=p1;
 speedbutton.left:=8;
 speedbutton.font.style:=[fsbold];
 speedbutton.font.color:=clwhite;
  speedbutton.font.name:='sans';
      speedbutton.Top := sbint;
      speedbutton.Width := 95;
      speedbutton.Height := 70;
    ss:= l1.Strings[mi];
      if lowercase(l1.Strings[mi])='apply settings' then 
     ss:='Stop search';
       if lowercase(l1.Strings[mi])='update preview' then //continue;
       begin  ss:='Start search';sbStartSearch:=speedbutton;end;
      speedbutton.Hint :=ss;
       speedbutton.caption:=ss;
      speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
     if lowercase(l1.Strings[mi])='apply settings' then 
     begin
     ss:='Stop search';
     sbStopSearch:=speedbutton;
         if fileexists(UserCallingDIR+'image/')=true then
     SpeedButton.Glyph.LoadFromFile(UserCallingDIR+'image/kill.png');
 end else begin
      if fileexists(Ini.Readstring ('xfgOptionsSidePanel', l1.Strings[mi], 'none'))=true then
     SpeedButton.Glyph.LoadFromFile(Ini.Readstring ('xfgOptionsSidePanel', l1.Strings[mi], 'none'));
     end;
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


procedure TRedstone_findfiles.createpanel1;
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

procedure TRedstone_findfiles.createpanel2;
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

procedure TRedstone_findfiles.createsplitter;
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

destructor TRedstone_findfiles.Destroy;

begin

inherited;

end;



initialization
registerclass(TRedstone_findfiles);
finalization

unregisterclass(TRedstone_findfiles);
end.
