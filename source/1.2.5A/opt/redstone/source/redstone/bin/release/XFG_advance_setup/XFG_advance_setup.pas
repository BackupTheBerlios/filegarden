unit XFG_advance_setup;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types,QButtons, QComCtrls,Libc, QMenus
  ,RedStone_Public_Comp, QFileCtrls, SyncObjs,StrUtils
  ,PClass_Command_RedStone
  ;

type

  TXFG_advance_setup = class(TRedStone_Public_Comp)
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
     Tree: TTreeView;
    PP,PPBottom:tpanel;
   PASSxfgmemo:tmemo;
     Lst,Lst2Image,Lst3Values,TreeLst:tstringlist;
    BExpand,BClose,BAddNewParent,BAddNewChild,BDelete:Tbutton;

  UserCallingIniconf,UserCallingDataDIR,UserCallingVersion:string;
  SaveDialog1:tsavedialog;
  Opendialog1:topendialog;
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
        procedure BottonButtonOnClick(Sender: TObject) ;
 
  protected
 form2filelist:tfileiconview;
ConfigDefaultFile:string;Kini:TMemIniFile;TempStr:string;
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

constructor TXFG_advance_setup.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
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
//UserCallingIniconf:=K.RS_AppConfigPath+'/'+K.RS_App_Configuration_Name+'.'+K.RS_App_Configuration_Extension; 
UserCallingDataDIR:=k.RS_APP_data_dir+'/';
//  constructor Create(ACRS_Handle:QApplicationH;ACRS_Form:TForm;AExeName:String);//override;
ini:=nil;
Kini:=nil;
TempStr:='';
  if fileexists(k.RS_USER_RESOURCE_PATH+'/XFGVCLAdvanceSetupConfigInput')then
libc.system(pchar('cp '+k.RS_USER_RESOURCE_PATH+'/XFGVCLAdvanceSetupConfigInput'+' '
                       +UserCallingDataDIR+'xfg0001'+'ToBeDeleted'))else
    if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLAdvanceSetupConfigInput')then
  libc.system(pchar('cp '+k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLAdvanceSetupConfigInput'+' '
                       +UserCallingDataDIR+'xfg0001'+'ToBeDeleted'));
                       
kini:=TMemIniFile.create(UserCallingDataDIR+'xfg0001'+'ToBeDeleted');

ConfigDefaultFile:=Kini.readstring('ConfigDefault',APassCallingCaptionHint,'none');
TempStr:=stringreplace(Kini.readstring('ConfigInput',APassCallingCaptionHint,'none')
,'[HOME]',GetEnvironmentVariable('HOME'),[rfReplaceAll, rfIgnoreCase]);
UserCallingIniconf:=TempStr;
libc.system(pchar('cp '+UserCallingIniconf+' '
                       +UserCallingDataDIR+'xfg0001.do'));

ini:=tinifile.create(UserCallingDataDIR+'xfg0001.do');

 try
     F := TForm.Create (application);
    try
 f.height:=500;
f.width:=750;
 // f.parent:=af;
    f.top:=screen.height-(screen.height-20);
f.left:=50;
       f.Constraints.MinHeight := f.height;
 f.Constraints.MinWidth := f.width;
// f. Constraints.MaxWidth := f.width;
// f.Constraints.MaxHeight :=  f.Constraints.MinHeight;
//f.onclose:=DoClose2;
f.Font.Charset :=fcsDefaultCharSet;
    F.caption:='XFG_advance_setup';

       createpanel1;
         
       createsplitter;
        
          createpanel2;
           
           createspeedbutton;
          createpagecontrol;
          createts1;
          
       //   createts2;
          createts3;
          creatememo;
          memo1.lines.add(TempStr);
          
              memo1.lines.add(APassCallingCaptionHint);
   (*       
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
  *)    
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

procedure TXFG_advance_setup.BottonButtonOnClick(Sender: TObject) ;
var 
 MyTreeNode: TTreeNode;instr:string;
begin

if (sender as tbutton).hint='Expand All' then
begin
 tree.FullExpand;
end;

if (sender as tbutton).hint='Collapse All' then
begin
  tree.FullCollapse;
end;
if (tree.selected)=nil then 
begin
MessageDlg ('No selection of node' +#13#10
    , mtInformation, [mbOK], mrOK);
exit;
end;

if (sender as tbutton).hint='Add New Parent Node...' then
begin
MyTreeNode:=(tree.selected);
if (MyTreeNode.parent<>nil)or (MyTreeNode.index=0) then 
begin
MessageDlg ('Need to select a parent node before inserting.' +#13#10
              
    , mtInformation, [mbOK], mrOK);
    exit;
    end else
    begin
 // MyTreeNode := Tree.Items[3];
//  rootNode:=Tree.Items[(tree.selected).index];
//  MyTreeNode := (tree.selected).GetPrev;
 // Tree.Items.Add(rootNode, 'RootTreeNode3'); 
 
 instr:='';
 instr:=k.CRS_InputQuery((sender as tbutton).hint,'Parent Label ...','',false);
 if trim(instr)='' then exit else
   Tree.Items.Insert(MyTreeNode,trim(instr));
//if (tree.selected).Parent=nil then
 end;
end;

if (sender as tbutton).hint='Add New Child Node...' then
begin
 // MyTreeNode := Tree.Items[3];
//  rootNode:=Tree.Items[(tree.selected).index];
//  MyTreeNode := (tree.selected).GetPrev;
MyTreeNode:=(tree.selected);

(*
if (MyTreeNode.Parent=nil) and (MyTreeNode.GetFirstChild<>nil)then 
begin
MessageDlg ('Need to select a child node before inserting.' +#13#10
              
    , mtInformation, [mbOK], mrOK);
    exit;
    end else
    begin
*)    
    instr:='';
     instr:=k.CRS_InputQuery((sender as tbutton).hint,' Child Label ...','',false);
 if trim(instr)='' then exit else
 begin
//if MyTreeNode.GetFirstChild=nil then Tree.Items.addchild(MyTreeNode, trim(instr))else
if MyTreeNode.parent<>nil then Tree.Items.insert(MyTreeNode, trim(instr))else 
Tree.Items.addchild(MyTreeNode, trim(instr));
end;

end;

if (sender as tbutton).hint='Delete' then
begin

MyTreeNode:=(tree.selected);
if MyTreeNode.Parent=nil then
begin

if MessageDlg ('Are you sure you want to delete this parent node ?' +#13#10+
              'Deleting a parent node will clear all the child nodes.'+#13#10
    , mtWarning, [mbOK,mbNo], 0)=mrOK then
 MyTreeNode.delete 
 else
 exit;
 end else
  MyTreeNode.delete ;
end;

if (sender as tbutton).hint='Go To %WorkShellFile% Section' then
begin
 
end;

if (sender as tbutton).hint='Get Menu Image Section ...' then
begin
 
end;
end;
//////////////////////////////////////////////////////////////////////////////////

 procedure TXFG_advance_setup.SpClick(Sender: TObject);
 
 var  i,ii:integer;Aini:tinifile;
 begin
 with (sender as tspeedbutton) do
 begin

  if lowercase(caption)='load from file' then
  begin
 
   Opendialog1:=tOpendialog.create(application);
 Opendialog1.InitialDir := '~';
  if Opendialog1.Execute then
  begin
    Lst.clear;
TreeLst.clear;
Lst2Image.clear;
Lst3Values.clear;
Lst.loadfromfile( Opendialog1.FileName);
libc.system(pchar('cp '+Opendialog1.FileName+' '
                       +UserCallingDataDIR+'xfg0004.do'));

//Lst.text:=stringreplace(Lst.text,'[HOME]',k.RS_Calling_UserHOMEDIR,[rfReplaceAll, rfIgnoreCase]);
Aini:=tinifile.create( UserCallingDataDIR+'xfg0004.do');
Aini.SetStrings(Lst);
Aini.ReadSections(Lst);
Tree.items.clear;
for i:=0 to Lst.count-1 do
begin
TreeLst.add(trim('['+Lst[i]+']'));
Aini.ReadSectionValues(Lst[i],Lst3Values);
for ii:=0 to Lst3Values.count-1 do
begin
TreeLst.add(' '+trim(Lst3Values[ii]));
end;
Lst2Image.clear;
Lst3Values.clear;
end;
//TreeLst.savetostream(LstStream);
TreeLst.savetofile(UserCallingDataDIR+'xfgAdvanceSetupTemp'); 
Tree.loadfromfile(UserCallingDataDIR+'xfgAdvanceSetupTemp');
Aini.free;
  Lst.clear;
TreeLst.clear;
Lst2Image.clear;
Lst3Values.clear;

end;
Opendialog1.free;
if fileexists(UserCallingDataDIR+'xfg0004.do')then
deletefile(UserCallingDataDIR+'xfg0004.do');
end;


  if lowercase(caption)='apply settings' then
  begin
ini.updatefile;
ini.free;

  tree.SaveToFile(UserCallingDataDIR+'xfgAdvanceSetupTemp001');
Aini:=tinifile.create(UserCallingDataDIR+'xfgAdvanceSetupTemp001');
Lst.clear;
TreeLst.clear;
Lst2Image.clear;
Lst3Values.clear;
//Lst.loadfromfile('/xxxxxxxxxxxxx');

Aini.ReadSections(Lst);
for i:=0 to Lst.count-1 do
begin
if i<>0 then TreeLst.add((' '));
TreeLst.add(trim('['+Lst[i]+']'));
Aini.ReadSectionValues(Lst[i],Lst3Values);
for ii:=0 to Lst3Values.count-1 do
begin
TreeLst.add(trim(Lst3Values[ii]));
end;
Lst2Image.clear;
Lst3Values.clear;
end;
TreeLst.savetofile(UserCallingDataDIR+'xfg0001.do');

libc.system(pchar('cp '+UserCallingDataDIR+'xfg0001.do'+' '
                       +UserCallingIniconf));
   

if fileexists(UserCallingDataDIR+'xfgAdvanceSetupTemp001')then
deletefile(UserCallingDataDIR+'xfgAdvanceSetupTemp001');
ini:=tinifile.create(UserCallingDataDIR+'xfg0001.do');
ini.updatefile;
 restartxfg:=true;
 MessageDlg ('Configuration changed.' +#13#10, mtInformation, [mbOK], 0);

   end;
   

////////////////////////////////////////////////////////////////////////////////
   if lowercase(caption)='backup' then
   begin
   SaveDialog1:=tsavedialog.create(application);
 SaveDialog1.InitialDir := '~';
  if SaveDialog1.Execute then
  begin
  tree.SaveToFile(UserCallingDataDIR+'xfgAdvanceSetupTemp001');
Aini:=tinifile.create(UserCallingDataDIR+'xfgAdvanceSetupTemp001');
Lst.clear;
TreeLst.clear;
Lst2Image.clear;
Lst3Values.clear;
//Lst.loadfromfile('/xxxxxxxxxxxxx');

Aini.ReadSections(Lst);
for i:=0 to Lst.count-1 do
begin
if i<>0 then TreeLst.add((' '));
TreeLst.add(trim('['+Lst[i]+']'));
Aini.ReadSectionValues(Lst[i],Lst3Values);
for ii:=0 to Lst3Values.count-1 do
begin
TreeLst.add(trim(Lst3Values[ii]));
end;
Lst2Image.clear;
Lst3Values.clear;
end;

TreeLst.savetofile(SaveDialog1.filename);
   
 end;
SaveDialog1.free;  
if fileexists(UserCallingDataDIR+'xfgAdvanceSetupTemp001')then
deletefile(UserCallingDataDIR+'xfgAdvanceSetupTemp001');
end;
////////////////////////////////////////////////////////////////////////////////

 
  if lowercase(caption)='load default' then
  begin
  Lst.clear;
TreeLst.clear;
Lst2Image.clear;
Lst3Values.clear;
Lst.loadfromfile(ConfigDefaultFile);
Lst.text:=stringreplace(Lst.text,'[HOME]',k.RS_Calling_UserHOMEDIR,[rfReplaceAll, rfIgnoreCase]);
libc.system(pchar('cp '+ConfigDefaultFile+' '
                       +UserCallingDataDIR+'xfg0004.do'));

Aini:=tinifile.create(UserCallingDataDIR+'xfg0004.do');
Aini.SetStrings(Lst);
Aini.ReadSections(Lst);
Tree.items.clear;
for i:=0 to Lst.count-1 do
begin
TreeLst.add(trim('['+Lst[i]+']'));
Aini.ReadSectionValues(Lst[i],Lst3Values);
for ii:=0 to Lst3Values.count-1 do
begin
TreeLst.add(' '+trim(Lst3Values[ii]));
end;
Lst2Image.clear;
Lst3Values.clear;
end;
//TreeLst.savetostream(LstStream);
TreeLst.savetofile(UserCallingDataDIR+'xfgAdvanceSetupTemp'); 
Tree.loadfromfile(UserCallingDataDIR+'xfgAdvanceSetupTemp');
Aini.free;
  Lst.clear;
TreeLst.clear;
Lst2Image.clear;
Lst3Values.clear;
if fileexists(UserCallingDataDIR+'xfg0004.do')then
deletefile(UserCallingDataDIR+'xfg0004.do');
 MessageDlg ('Default configuration loaded.' +#13#10, mtInformation, [mbOK], 0);

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
  procedure TXFG_advance_setup.DoClose;
 
begin
 
if restartxfg=true then   

MessageDlg ('Configuration changed.' +#13#10+
              'You need to reload then main application by using the menu'+#13#10+
              '    --->   File  |  Reload configurations    ', mtWarning, [mbOK], 0);

if ini <> nil then ini.free;

if fileexists(UserCallingDataDIR+'xfg0001'+'ToBeDeleted')then
deletefile(UserCallingDataDIR+'xfg0001'+'ToBeDeleted');
if fileexists(UserCallingDataDIR+'xfgAdvanceSetupTemp')then
deletefile(UserCallingDataDIR+'xfgAdvanceSetupTemp');
if fileexists(UserCallingDataDIR+'xfg0001.do')then
deletefile(UserCallingDataDIR+'xfg0001.do');
if fileexists(UserCallingDataDIR+'xfg0002.do')then
deletefile(UserCallingDataDIR+'xfg0002.do');
if k <> nil then k.free;    
if Kini <> nil then Kini.free;
if Lst <> nil then Lst.free;
if Lst2Image <> nil then Lst2Image.free;
if Lst3Values <> nil then Lst3Values.free;
if TreeLst <> nil then TreeLst.free;
if F <> nil then F.free;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

 procedure TXFG_advance_setup.DoClose2(Sender: TObject; var Action: TCloseAction);
 
begin

if restartxfg=true then   

MessageDlg ('Configuration changed.' +#13#10+
              'You need to reload then main application by using the menu'+#13#10+
              '    --->   File  |  Reload configurations    ', mtWarning, [mbOK], 0);

if ini <> nil then ini.free;
if fileexists(UserCallingDataDIR+'xfg0001'+'ToBeDeleted')then
deletefile(UserCallingDataDIR+'xfg0001'+'ToBeDeleted');
if fileexists(UserCallingDataDIR+'xfgAdvanceSetupTemp')then
deletefile(UserCallingDataDIR+'xfgAdvanceSetupTemp');
if fileexists(UserCallingDataDIR+'xfg0001.do')then
deletefile(UserCallingDataDIR+'xfg0001.do');
if fileexists(UserCallingDataDIR+'xfg0002.do')then
deletefile(UserCallingDataDIR+'xfg0002.do');
if k <> nil then k.free;    
if Kini <> nil then Kini.free;
if Lst <> nil then Lst.free;
if Lst2Image <> nil then Lst2Image.free;
if Lst3Values <> nil then Lst3Values.free;
if TreeLst <> nil then TreeLst.free;
if F <> nil then F.free;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TXFG_advance_setup.createpagecontrol; 
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
 
procedure TXFG_advance_setup.createts1; 
var i,ii:integer;
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
///////////////////////////////////////////////
TreeLst:=tstringlist.create;
Lst:=tstringlist.create;
Lst2Image:=tstringlist.create;
Lst3Values:=tstringlist.create;
ini.ReadSections(Lst);

for i:=0 to Lst.count-1 do
begin
TreeLst.add(trim('['+Lst[i]+']'));
ini.ReadSection(Lst[i],Lst2Image);
ini.ReadSectionValues(Lst[i],Lst3Values);
for ii:=0 to Lst3Values.count-1 do
begin
TreeLst.add(' '+trim(Lst3Values[ii]));
end;
Lst2Image.clear;
Lst3Values.clear;
end;
//TreeLst.savetostream(LstStream);
TreeLst.savetofile(UserCallingDataDIR+'xfgAdvanceSetupTemp');
pp:=tpanel.create(application);
with PP as tpanel do
begin
parent:=gb3;
align:=alclient;
BorderStyle:=bsnone;
color:=$00E6E6E6;
font.color:=4473924;
font.name:='helvetica';
BorderWidth:=20;
visible:=true;
enabled:=true;
end;
PPBottom:=tpanel.create(application);
with PPBottom as tpanel do
begin
parent:=pp;
align:=albottom;
BorderStyle:=bsnone;
color:=$00E6E6E6;
font.color:=4473924;
font.name:='helvetica';
BorderWidth:=0;
visible:=true;
enabled:=true;
height:=30;
end;
BExpand:=Tbutton.create(application);
with BExpand as tbutton do
begin
parent:=PPBottom;
Left:=3;
width:=80;
caption:='Expand All';
hint:=caption;
top:=3;
OnClick:=BottonButtonOnClick;
enabled:=true;
visible:=true;
end;

BClose:=Tbutton.create(application);
with BClose as tbutton do
begin
parent:=PPBottom;
Left:=BExpand.left+BExpand.width+3;
width:=85;
caption:='Collapse All';
hint:=caption;
top:=3;
OnClick:=BottonButtonOnClick;

enabled:=true;
visible:=true;
end;
BAddNewParent:=Tbutton.create(application);
with BAddNewParent as tbutton do
begin
parent:=PPBottom;
Left:=BClose.left+BClose.width+3;
width:=150;
caption:='Add New Parent Node...';
hint:=caption;
top:=3;
OnClick:=BottonButtonOnClick;

enabled:=true;
visible:=true;
end;
BAddNewChild:=Tbutton.create(application);
with BAddNewChild as tbutton do
begin
parent:=PPBottom;
Left:=BAddNewParent.left+BAddNewParent.width+3;
width:=150;
caption:='Add New Child Node...';
hint:=caption;
top:=3;
OnClick:=BottonButtonOnClick;

enabled:=true;
visible:=true;
end;
BDelete:=Tbutton.create(application);
with BDelete as tbutton do
begin
parent:=PPBottom;
Left:=BAddNewChild.left+BAddNewChild.width+3;;
width:=80;
caption:='Delete';
hint:=caption;
//top:=BExpand.top+BExpand.height+3;
top:=3;
OnClick:=BottonButtonOnClick;

enabled:=true;
visible:=true;
end;
(*
BGetFileName:=Tbutton.create(application);
with BGetFileName as tbutton do
begin
parent:=PPBottom;
Left:=BDelete.left+BDelete.width+3;
width:=180;
caption:='Go To %WorkShellFile% Section';
hint:=caption;
top:=BDelete.top;
OnClick:=BottonButtonOnClick;

enabled:=true;
visible:=true;
end;
BGetImageSection:=Tbutton.create(application);
with BGetImageSection as tbutton do
begin
parent:=PPBottom;
Left:=BGetFileName.left+BGetFileName.width+3;
width:=160;
caption:='Get Menu Image Section ...';
hint:=caption;
top:=BGetFileName.top;
OnClick:=BottonButtonOnClick;

enabled:=true;
visible:=true;
end;
*)
Tree:=TTreeView.create(application);
with Tree as ttreeview do
begin
parent:=pp;
ShowButtons:=true;
//AutoExpand:=true;
ItemMargin:=2;
color:=$00E6E6E6;
font.color:=4473924;
font.name:='helvetica';
align:=alclient;
BorderStyle:=bssingle;
MultiSelect:=true;
Indent:=17;
visible:=true;
enabled:=true;
end;
//Tree.loadfromstream(LstStream);

Tree.loadfromfile(UserCallingDataDIR+'xfgAdvanceSetupTemp');




end;
end;
end;
       
end;

procedure TXFG_advance_setup.createts2; 
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

procedure TXFG_advance_setup.createts3; 
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
 



procedure TXFG_advance_setup.creatememo;
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

procedure TXFG_advance_setup.createspeedbutton;
var  mi,sbint:integer;ss,sectionSTR:string;Aini:tinifile;
 l1:tstringlist;
begin
l1:=tstringlist.create;
Aini:=nil;
if fileexists(k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel')then
begin
libc.system(pchar('cp '+k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel'+' '
                       +UserCallingDataDIR+'xfg0005'+'ToBeDeleted'));

Aini:=tinifile.create(UserCallingDataDIR+'xfg0005'+'ToBeDeleted');
if Aini.SectionExists(trim(f.caption))then 
begin
Aini.ReadSection(trim(f.caption),l1) ;

sectionSTR:=trim(trim(f.caption));
end else
begin
libc.system(pchar('cp '+UserCallingIniconf+' '
                       +UserCallingDataDIR+'xfg0002.do'));
 
Aini:=tinifile.create(UserCallingDataDIR+'xfg0002.do');
Aini.ReadSection('xfgOptionsSidePanel',l1);
 sectionSTR:=trim('xfgOptionsSidePanel');
 end;
end;

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

      speedbutton.Hint :=ss;
       speedbutton.caption:=ss;
      speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
      if fileexists(stringreplace(Aini.Readstring (sectionSTR, l1.Strings[mi], 'none')
,'[HOME]',GetEnvironmentVariable('HOME'),[rfReplaceAll, rfIgnoreCase]))=true then
     SpeedButton.Glyph.LoadFromFile(    stringreplace(Aini.Readstring (sectionSTR, l1.Strings[mi], 'none')
,'[HOME]',GetEnvironmentVariable('HOME'),[rfReplaceAll, rfIgnoreCase]));
      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
   speedbutton.OnClick := spclick;
speedbutton.visible:=true;
sbint:=sbint+70+10;

end;

Aini.free;
l1.clear;
l1.free;
if fileexists(UserCallingDataDIR+'xfg0005'+'ToBeDeleted')then
deletefile(UserCallingDataDIR+'xfg0005'+'ToBeDeleted');

end;


procedure TXFG_advance_setup.createpanel1;
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

procedure TXFG_advance_setup.createpanel2;
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

procedure TXFG_advance_setup.createsplitter;
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

destructor TXFG_advance_setup.Destroy;

begin

inherited;

end;



initialization
registerclass(TXFG_advance_setup);
finalization

unregisterclass(TXFG_advance_setup);
end.
