unit Redstone_input_frame;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types, QFileCtrls, QButtons, QMenus,Variants, QImgList,
QComCtrls,libc
  ,RedStone_Public_Comp
  //,PPClass_RedStone
    ,PClass_Command_RedStone
  ;



type
  TRedstone_input_frame = class(TRedStone_Public_Comp)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure createFileIconView;
    procedure createpanel1;
    procedure createpanel2;
    procedure createspeedbutton;
    procedure createpopup;
    procedure createimglist;
    procedure popupclick(Sender: TObject);
    procedure spclick(Sender: TObject); 
    procedure filelistSelectItem(Sender: TObject; Item: TIconViewItem; Selected: Boolean);
   // procedure filelistMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  //  procedure filelistItemClicked(Sender: TObject;Item: TIconViewItem);
    procedure filelistChange(Sender: TObject; Item: TIconViewItem;Change: TItemChange);
    procedure filelistDirectoryChange(Sender: TObject;const NewDir: WideString);
    procedure cmbonchange(Sender: TObject);
    procedure cmbOnSelect(Sender: TObject);   
    procedure filelistMouseEnter(Sender: TObject);
    procedure filelistMouseLeave(Sender: TObject);
    procedure DoPopup(Sender: TObject);
        procedure DoClose;
  private
    //d:TPPClass_RedStone;
    F:tform;
    
    p1,p2:tpanel;
    sp,spb,sps:tspeedbutton;
    cmb:tcombobox;
    filelist:TFileIconView;
    Popup: TPopupMenu;
   mi,mi1,mi2,mi3,mi4,mi5,mi6:TMenuItem;
    ini:tinifile;
    GIconItem:TIconViewItem;
    imglist: TImageList;
    icontypelist,internallist:tstringlist;
 K:TPClass_Command_RedStone;
ParentDIR,AAProc:string;
memo:tmemo;
internal,external,alreadyUP:Boolean;
AF:TForm;
  protected

  public
   
    constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
    destructor Destroy; override;
  published

  end;
   

implementation

constructor TRedstone_input_frame.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList);
var  sr: TSearchRec;  FileAttrs: Integer; 
ss:string;
ps,pc,FPPClass_Filename,FCallClass_Filename:string;
h:THandle;
comp:tcomponent;
begin
inherited;
internal:=false;
external:=false;
alreadyUP:=true;
  K:=TPClass_Command_RedStone.create(application.handle,APass_Form,APass_ExeName);  
AF:=APass_Form;
F:=nil; 
ParentDIR:=k.RS_mainpath;
AAProc:=APass_ExeName;
application.handle:=nil;
application.handle:=APass_Handle;



if  fileexists(ExtractFilePath(APass_ExeName) + 'xfg.conf')=false  then begin
   MessageDlg ('Error in Component: ' +#13#10+
               'You need to supply full path name to FileGarden'+#13#10+
               'in the second parameter.', mtError, [mbOK], 0);
        
application.terminate;end;

if  application.exename=k.RS_SysPath+'Command_Redstone' then external:=true;
 try
ss:='cp '+ExtractFilePath(APass_ExeName) + 'xfg.conf'+' '
                      +ExtractFilePath(APass_ExeName)+'data/xfginputframe.dod';

libc.system(pchar(ss));
  ini:=TInifile.create(ExtractFilePath(APass_ExeName)+'data/xfginputframe.dod');
internallist:=tstringlist.create;
icontypelist:=tstringlist.create;
GIconItem:=nil;
application.HintPause:=50;
application.HintHidePause:=60000;

   F := TForm.Create (AF); 
   
  try  
 
//F.parent:=AF;
//   F.caption:=ExtractFilePath(Application.ExeName) + 'xfg.conf';
     F.caption:='Redstone Commander';
      F.Left := 338;
 f.Top := 110;
 f. Width := 350;
  f.Height := 400;
 // VertScrollBar.Range := 348;
 // ActiveControl := FileIconView1;
//ActiveControl := filelist;
//  Color := clBackground;
 f.Constraints.MaxHeight := 400;
  f.Constraints.MaxWidth := 350;
  f.Constraints.MinHeight := 400;
 f.Constraints.MinWidth := 350;
//af.FormStyle := fsnormal;
//application.NormalizeTopMosts; ;
//  f.FormStyle := fsStayOnTop;
 
 createimglist;

 createpanel1;
 
 createpanel2;
  createspeedbutton;
 createFileIconView; 
  createpopup;
 
  filelist.popupmenu:=popup;

memo:=tmemo.create(f);
with memo as tmemo do
begin
parent:=f;
 Left := 0;
    Top := 41;
    Width := 350;
    Height := 307;
    align:=alclient;
       ScrollBars := ssBoth;
   //   TabOrder := 0;
      WordWrap := False;
      readonly:=false;
       BorderStyle := bsRaisedPanel;
visible:=true;
(filelist as tcomponent).bringtofront;
//(memo as tcomponent).bringtofront; 
end;
////////////////////////////////////////////////////////////////////////////
  h:=GetModuleHandle('~/redstone/FileGarden/FileGarden');
   SetLength(PS, 100);	
   SetLength(PS, GetModuleFilename( h, PChar(ps), Length(ps) ) );
   SetLength(PC, 100);
   SetLength(PC, GetModuleFilename( 0, PChar(pc), Length(pc) ) );
   FPPClass_Filename:=ps;
   FCallClass_Filename:=pc;
   comp:=FindGlobalComponent('xfgmemo');
 if comp <> nil then memo.lines.add('xfgmemo   --->  '+(comp as tcomponent).classname);

 //  FRedStone_SysPath:=extractfilepath(FPPClass_Filename);
 //  FPPClass_UserHOMEDIR:=GetEnvironmentVariable('HOME');
   /////////////////////////////////////////////////////////////////////////////
memo.lines.add('AProc   --->  '+APass_ExeName);
memo.lines.add('Application EXEName   --->  '+Application.exename );
memo.lines.add('k.crs_mainpath  --->  '+k.RS_mainpath);
memo.lines.add('FPPClass_Filename   --->  '+ps );
memo.lines.add('FCallClass_Filename  --->  '+pc);
//   f.caption:=GetEnvironmentVariable('HOME');
  F.onclose:=FormClose;
     F.Show;
 //    F.ShowModal;
 //  Screen.Forms[0].FormStyle := fsnormal;
 // (af as tform).FormStyle := fsnormal;
 // application.NormalizeTopMosts; 
 //    Screen.Forms[1].FormStyle := fsStayOnTop;
 
     
//  if FindFirst('~/xfg.conf', faAnyFile, sr) = 0 then f.caption:='~/xfg.conf';
 //   FindClose(sr); 
finally
//doclose;
end;
  except
   on E: Exception do
    begin
    MessageDlg ('Error in Component: ' +
        E.Message, mtError, [mbOK], 0);
//   showmessage('Testing Component' );  
//AF.close;         
 // doclose;
 application.terminate;
    end;
  end;

end;

   procedure TRedstone_input_frame.FormClose(Sender: TObject; var Action: TCloseAction);
   begin
if icontypelist<>nil then   icontypelist.free;
   if internallist<>nil then   internallist.free;
   if ini<>nil then  ini.free;
 if external=true  then
 AF.close;
Action := caFree;
end;

procedure TRedstone_input_frame.DoClose;
   begin
if icontypelist<>nil then   icontypelist.free;
   if internallist<>nil then   internallist.free;
   if ini<>nil then  ini.free;
 if external=true  then
 AF.close;
   if f<>nil then f.free;
end;
    procedure TRedstone_input_frame.filelistMouseEnter(Sender: TObject);
    begin
    application.HintPause:=500;
application.HintHidePause:=2500;
end;

    procedure TRedstone_input_frame.filelistMouseLeave(Sender: TObject);
    begin
application.HintPause:=50;
application.HintHidePause:=60000;
end;

procedure TRedstone_input_frame.DoPopup(Sender: TObject);
var i:integer;
begin
if internallist.count=1 then mi2.enabled:=true;
if internallist.count>1 then mi2.enabled:=false;
if internallist.count=0 then exit;
for i:=0 to internallist.count-1 do
begin
if directoryexists(internallist.strings[i])=true then 
begin mi3.enabled:=false;
exit;end;
end;
mi3.enabled:=true;


end;


    procedure TRedstone_input_frame.cmbOnSelect(Sender: TObject);      
        begin
    filelist.Directory.Location := cmb.text;
    end;

    procedure TRedstone_input_frame.cmbonchange(Sender: TObject);
    begin
  //  if directoryexists(cmb.text) then
  //  filelist.Directory.Location := cmb.text;
  ;
    end;
    

procedure TRedstone_input_frame.filelistSelectItem(Sender: TObject; 
                  Item: TIconViewItem; Selected: Boolean);
begin

if item.caption<>'..' then 
begin

GIconItem:=item;
if selected =false then 
begin
if internallist.indexof(filelist.directory.location+item.caption)<>-1 then

internallist.delete(internallist.indexof(filelist.directory.location+item.caption));
end;
if selected =true then 
begin
if filelist.selcount>1 then
internallist.add(filelist.directory.location+item.caption);
if filelist.selcount=1 then
begin
internallist.clear;
internallist.add(filelist.directory.location+item.caption);
end;


//  if directoryexists(Item.caption)=true			

//            then mi3.enabled:=false else
//if directoryexists(Item.caption)=false	 then
//mi3.enabled:=true;  
end;
//internallist.savetofile('/0000.popo');


end;//if item<>'..' then 
end;
    
procedure TRedstone_input_frame.filelistDirectoryChange(Sender: TObject;
  const NewDir: WideString);
// var  ci:integer;
begin
cmb.items.Insert(0, cmb.text); 

cmb.text:=( filelist.directory.Location) ;

end;
procedure TRedstone_input_frame.filelistChange(Sender: TObject; Item: TIconViewItem;
  Change: TItemChange);
  var s,ss,iconfile:string;i:integer;
begin


      s:= filelist.Directory.Location+item.Caption;
         if directoryexists(s) then item.ImageIndex:=0 else
         if not directoryexists(s) then
         begin
         ss:=   lowercase(extractfileExt( s));
         ss:= Copy(ss, 2, length(ss)-1);
         
         //LoadFromFile(Ini.Readstring ('xfgFileTypeIcon', icontypelist[i], 'none'));
         // Copy(S; Index, Count: Integer):
   
         iconfile:=Ini.Readstring ('xfgFileTypeIcon', ss, 'none');
         if fileexists(iconfile)then
              item.ImageIndex:=icontypelist.IndexOf(ss) else  item.ImageIndex:=1;
        end;
    end;      


      

    procedure TRedstone_input_frame.createimglist;
    var img:tbitmap;i:integer;
    begin
  
    ini.readsection('xfgFileTypeIcon',icontypelist);
    imglist:=timagelist.create(f);
    with imglist as timagelist do
    begin
  //  Masked:=false;
     Height := 24;
    Width := 24;
      end;
      img:=tbitmap.create;
    with img as tbitmap do
      begin
  
      for i:=0 to icontypelist.count-1 do
      begin
LoadFromFile(Ini.Readstring ('xfgFileTypeIcon', icontypelist[i], 'none'));
 imglist.Add(Img, nil);
    end;
    end;
 
    end;

    procedure TRedstone_input_frame.createFileIconView;
begin
filelist:=tfileiconview.create(f);
filelist.parent:=f;
with filelist as tfileiconview do
begin
  align:=alclient;
  Left := 0;
    Top := 41;
    Width := 350;
    Height := 307;
    Align := alclient;
    BorderStyle := bsEmbossed;
    Color := clWhite;
    Directory.AutoUpdate := True;
    Directory.Location := '~/';
    Directory.FileType := [ftHidden, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];
    Directory.FileMask := '*';
    Directory.SortMode := smType;
  //  DragMode := dmAutomatic;
    Font.Color := clBlack;
    Font.Height := 13;
    
    Font.Name := 'lucida';
    Font.Pitch := fpVariable;
  //  Font.Style := [];
    IconOptions.Arrangement := (iaTop);
  Images := imglist;
    MultiSelect := True;
    ParentFont := False;
    ParentShowHint := False;
    PopupMenu := popup;
    ShowHint := True;
 //   TabOrder := 0;
    TextPosition := itpRight;
   OnChange := filelistChange;
  //  OnChanging := FileIconView1Changing;
 //OnClick := filelistClick;
  //  OnContextPopup := FileIconView1ContextPopup;
  //  OnCustomDrawItem := FileIconView1CustomDrawItem;
  //  OnDblClick := FileIconView1DblClick;
   OnDirectoryChange := filelistDirectoryChange;
   // OnDragDrop := FileIconView1DragDrop;
   // OnDragOver := FileIconView1DragOver;
   // OnDrawItem := FileIconView1DrawItem;
  //  OnEdited := FileIconView1Edited;
  //  OnEditing := FileIconView1Editing;
  //  OnEndDrag := FileIconView1EndDrag;
//    OnEnter := filelistEnter;
 //  OnExit := filelistExit;
  //  OnFileFound := FileIconView1FileFound;
  //  OnGetImageIndex := FileIconView1GetImageIndex;
 //   OnItemClicked := filelistItemClicked;
  //  OnItemDoubleClick := FileIconView1ItemDoubleClick;
  //  OnItemEnter := FileIconView1ItemEnter;
  //  OnItemExitViewportEnter := FileIconView1ItemExitViewportEnter;
  //  OnKeyDown := FileIconView1KeyDown;
  //  OnKeyPress := FileIconView1KeyPress;
  //  OnKeyString := FileIconView1KeyString;
  //  OnKeyUp := FileIconView1KeyUp;
  //  OnMaskChange := FileIconView1MaskChange;
  // OnMouseDown := filelistMouseDown;
   OnMouseEnter := filelistMouseEnter;
   OnMouseLeave := filelistMouseLeave;
  //  OnMouseMove := FileIconView1MouseMove;
  //  OnMouseUp := FileIconView1MouseUp;
  //  OnResize := FileIconView1Resize;
 OnSelectItem := filelistSelectItem;
  //  OnStartDrag := FileIconView1StartDrag;

end;
end;
  procedure TRedstone_input_frame.createpanel1;
begin
 p1:=tpanel.create(f);
p1.parent:=f;
with p1 as tpanel do
begin
     Left:= 0;
    Top := 0;
    Width := 350;
    Height := 38;
    Align := alTop;
    BevelOuter := bvNone;
    visiblE:=true;
  
end;
end;
    procedure TRedstone_input_frame.createpanel2;
begin
 p2:=tpanel.create(f);
p2.parent:=f;
with p2 as tpanel do
begin
  Left := 0;
    Top := 348;
    Width := 350;
    Height := 38;
    Align := albottom;
      visiblE:=true;
        cmb:=tcombobox.create(p2);
    with cmb as tcombobox do 
    begin
    parent:=p2;
       Left := 100;
      Top := 8;
      Width := 238;
      Height := 21;
      Font.Color := clGray;
      Font.Height := 13;
      Font.Name := 'lucida';
      Font.Pitch := fpVariable;
      Font.Style := [];
      ItemHeight := 15;
      ParentFont := False;
      TabOrder := 0;
      InsertMode:=(ciAfterCurrent);		

     Text := '~/';
     MaxItems:=10;
     duplicates:=dupIgnore;
   //  AutoComplete:=true;
     onchange:=cmbonchange;
     OnSelect:=cmbOnSelect; 
      end;
end;
end;
    procedure TRedstone_input_frame.createspeedbutton;
var  mi,sbint:integer;
l1:tstringlist;
 
begin
   sbint:=5;
 l1:=tstringlist.create;
ini.readsection('xfgFileInputTop',l1);

 for mi := 0 to l1.Count - 1 do 
begin
sp:=TSpeedButton.Create (f);
sp.parent:=p1;
 sp.left:=sbint;
      sp.Top := 3;
      sp.Width := 32;
      sp.Height := 32;
    sp.Hint :=l1.Strings[mi];
   //   speedbutton.caption:=' ';
      sp.Flat := true;
      sp.Layout := blGlyphTOP;
     sp.Glyph.LoadFromFile(Ini.Readstring ('xfgFileInputTop', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      sp.ParentShowHint := False;
      sp.ShowHint := True;
      sp.Spacing := 5;
    sp.OnClick := spclick;
sp.visible:=true;
sbint:=sbint+32+10;
end;
l1.clear;
  sbint:=5;
ini.readsection('xfgFileInputBottom',l1);

 for mi := 0 to l1.Count - 1 do 
begin
spb:=TSpeedButton.Create (f);
spb.parent:=p2;
 spb.left:=sbint;
      spb.Top := 3;
      spb.Width := 32;
      spb.Height := 32;
    spb.Hint :=l1.Strings[mi];
   //   speedbutton.caption:=' ';
      spb.Flat := true;
      spb.Layout := blGlyphTOP;
     spb.Glyph.LoadFromFile(Ini.Readstring ('xfgFileInputBottom', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      spb.ParentShowHint := False;
      spb.ShowHint := True;
      spb.Spacing := 5;
    spb.OnClick := spclick;
spb.visible:=true;
sbint:=sbint+32+10;
end;
sps:=TSpeedButton.Create (f);
sps.parent:=p1;
with sps as tspeedbutton do
begin
  Left := 232;
      Top :=3;
      Width := 113;
      Height := 32;
      Hint := 'Send files to editor';
      Caption := 'To editor';
      Flat := True;
      Font.Color := clBlack;
      Font.Height := 15;
      ShowHint := True;
      Font.Name := 'sans';
      Layout := blGlyphleft;
      Font.Pitch := fpVariable;
       sps.Glyph.LoadFromFile(Ini.Readstring ('xfgMainButtonImage', 'xfgFileInputToEditor', 'none'));
    //  Font.Style := []
      end;
      

 
 l1.free;
end;


    procedure TRedstone_input_frame.createpopup;
    var 
    i:integer;
    l:tstringlist;
  
    imgfile:string;
begin
l:=tstringlist.create;
popup:=tpopupmenu.create(f);
popup.AutoPopup := true;
popup.OnPopup:= DoPopup;

Popup.Alignment := (paLeft);
     mi1:=TMenuItem.create(popup);
    with mi1 as TMenuItem do
    begin
    //mi1.parent:=popup;
      Caption := 'Select all';
           Hint := 'Select all files';
     //      enabled:=true;
      imgfile:=ini.readstring('xfgFileInputMenuImage','Select all','none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         //   visible:=true;
      OnClick := popupClick;
    end;
//    popup.items.add(mi1);
       mi2:=TMenuItem.create(popup);
    with mi2 as TMenuItem do
    begin
    //parent:=popup;
      Caption := 'Rename';
      Hint := 'Rename file or directory';
         enabled:=false;
      imgfile:=ini.readstring('xfgFileInputMenuImage','Rename','none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         visible:=true;
      OnClick := popupClick;
    end;
     popup.items.add(mi2);
     mi3:=TMenuItem.create(popup);
   with mi3 as TMenuItem do
    begin
      Caption := 'Delete';
      Hint := 'Delete file';
         enabled:=false;
                         imgfile:=ini.readstring('xfgFileInputMenuImage','Delete','none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         visible:=true;
      OnClick := popupClick;
    end;
  popup.items.add(mi3);
  
     mi4:=TMenuItem.create(popup);
   with mi4 as TMenuItem do
    begin
      Caption := 'New directory';
      Hint := 'Create new directory';
         enabled:=true;
                 imgfile:=ini.readstring('xfgFileInputMenuImage','New directory','none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         visible:=true;
      OnClick := popupClick;
    end;
  popup.items.add(mi4);

      mi5:=TMenuItem.create(popup);
   with mi5 as TMenuItem do
    begin                 
      Caption := 'New postscript file';
      Hint := 'Create new blank postscript file';
         enabled:=true;
         imgfile:=ini.readstring('xfgFileInputMenuImage','New postscript file','none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         visible:=true;
      OnClick := popupClick;
    end;
  popup.items.add(mi5);
  
  mi6:=TMenuItem.create(popup);
   with mi6 as TMenuItem do
    begin
      Caption := '-';
         enabled:=true;
         visible:=true;
    end;
     popup.items.add(mi6);
 ini.readsection('xfgSpeedButton',l);

for i:=0 to l.count-1 do
begin
  mi:=TMenuItem.create(popup);
   with mi as TMenuItem do
    begin
      Caption := l.strings[i];
   //   Hint := 'Create new blank postscript file';
   imgfile:=ini.readstring('xfgFileInputMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
      OnClick := popupClick;
    end;
     popup.items.add(mi);
end;

{
for  I := 0 to Screen.FormCount-1 do
  begin
   mi:=TMenuItem.create(popup);
    with mi as TMenuItem do
    begin
   
    mi.Caption := Screen.Forms[I].Name+'--->'+Screen.Forms[I].caption;
      enabled:=true;
         visible:=true;
           end;
    popup.items.add(mi);  end;
}
 
l.free;
end;
procedure TRedstone_input_frame.popupclick(Sender: TObject);
//var item:tmenuitem;
var instr:string;
iconitem:TIconViewItem;
i,ii:integer;
l1:tstringlist;
begin

filelist.readonly:=true;
with Sender as tmenuitem do
begin
if Sender=mi1 then    //if Sender='Select all' then
begin

end;

if Sender=mi2 then        //if caption='Rename'then
begin
instr:=GIconItem.caption;
if InputQuery('Rename','Rename   '+filelist.directory.location+instr,instr )=true then
begin
 filelist.RenameFile(GIconItem,instr);
//filelist.directory.CreateDirectory(instr);
filelist.refresh;
filelist.Selected:=filelist.items[filelist.directory.indexof(instr)];
filelist.EnsureItemVisible(filelist.Selected);
end;
end;

if Sender=mi3 then     ////if (Sender as tmenuitem).caption='Delete'then
begin
l1:=tstringlist.create;

ii:=filelist.items.indexof(GIconItem);
if i=filelist.items.count-1 then i:=i-1;
//instr:=GIconItem.caption;
instr:=#13#10;
for i:=0 to internallist.count-1 do
begin
if fileexists(internallist.strings[i]) then
instr:=instr+internallist.strings[i]+#13#10;
end;
if  MessageDlg ('Are you sure you want to delete ' +#13#10+
    instr, mtConfirmation, [mbYes,mbNo], 0, mbYes)=mrYes then
              begin
for i:=0 to internallist.count-1 do
begin
if fileexists(internallist.strings[i]) then
DeleteFile(internallist.strings[i]);
filelist.refresh;
end;
filelist.Selected:=filelist.items[ii];
filelist.EnsureItemVisible(filelist.Selected);

end;
internallist.clear;
l1.free;
end;

if Sender=mi4 then    //if caption='New directory'then
begin
instr:='NewDirectory';
if InputQuery('Create new directory', 'Create new directory', instr)=true then
begin
filelist.directory.CreateDirectory(instr);
filelist.refresh;
filelist.Selected:=filelist.items[filelist.directory.indexof(instr)];
filelist.EnsureItemVisible(filelist.Selected);
end;
end;

if Sender=mi5 then    //   'New postscript file'
begin
//
end;

end; 
//filelist.readonly:=false;
end;


procedure TRedstone_input_frame.spclick(Sender: TObject); 
begin
with sender as tspeedbutton do
begin
if lowercase(hint)='up' then filelist.GoUp;
if lowercase(hint)='home' then filelist.directory.location:='~/';
if lowercase(hint)='shows all files' then 
filelist.directory.filetype:=[ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];
if lowercase(hint)='don''t show hidden files' then 
filelist.directory.filetype:=[ftReadOnly, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];
if (lowercase(hint)='shift to bottom') or( lowercase(hint)='shift to view')then begin
f.left:=screen.width-f.width-10;
if alreadyUP=true then begin f.top:=screen.height-120;alreadyUP:=false;hint:='Shift to view';exit;end;
if alreadyUP=false then begin f.top:=screen.height-f.height-50;alreadyUP:=true;hint:='Shift to bottom';exit;end;
if lowercase(Caption )= 'to editor' then ;
end;
if lowercase(hint )= 'show memo' then begin
(memo as tcomponent).bringtofront;
end;  
if lowercase(hint )= 'show file commander' then begin
(filelist as tcomponent).bringtofront;
end;  

end; 
end;



destructor TRedstone_input_frame.Destroy;
begin
//application.handle:=nil;
//f:=nil;
inherited;

end;



initialization
registerclass(TRedstone_input_frame);
finalization

unregisterclass(TRedstone_input_frame);
end.
