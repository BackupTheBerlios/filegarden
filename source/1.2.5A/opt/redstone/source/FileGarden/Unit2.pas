 
 
unit Unit2;

interface

uses
  Qt,SysUtils,StrUtils, QComCtrls,Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types, QFileCtrls, QButtons, QMenus,Variants, QImgList,
libc,Qtypes,
TypInfo
  ;



type
  

 
  TForm2 = class(TForm)
    procedure FilelistDoDoubleClick(ApassFileName:string);
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject; var Action: TCloseAction);
    procedure createFileIconView;
    procedure createpanel1;
    procedure createpanel2;
    procedure ListViewDrawItem(Sender: TCustomListView; Item: TListItem; 
                  Canvas: TCanvas; const Rect: TRect; State: TOwnerDrawState);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean); 
    procedure ListView1Click(Sender: TObject); 
     procedure ListView1ItemDoubleClick(Sender: TObject; Item: TListItem)  ;
  // procedure  ListView1ItemMouseDown(Sender: TObject; Button: TMouseButton;
  //  Item: TListItem; const Pt: TPoint; ColIndex: Integer);      
  //        procedure ListViewItemClick(Sender: TObject; Button: TMouseButton;
  //  Item: TListItem; const Pt: TPoint; ColIndex: Integer);       
    procedure popupclick(Sender: TObject);
    procedure spclick(Sender: TObject); 
  //  procedure FileIconView1ItemEnter(Sender: TObject; Item: TIconViewItem);//
    procedure filelistSelectItem(Sender: TObject; Item: TIconViewItem; Selected: Boolean);
//    procedure filelistChange(Sender: TObject; Item: TIconViewItem;Change: TItemChange);
    procedure filelistDirectoryChange(Sender: TObject;const NewDir: WideString);
    procedure filelistItemDoubleClick(Sender: TObject;Item: TIconViewItem);
    procedure filelistItemClicked(Sender: TObject;Item: TIconViewItem);
    procedure filelistClick(Sender: TObject);
  //  procedure FileIconView1GetImageIndex(Sender: TObject; Item: TIconViewItem);
    procedure FileIconView1Changing(Sender: TObject; Item: TIconViewItem; 
                    Change: TItemChange; var AllowChange: Boolean) ;
//    procedure FileIconView1GetImageIndex(Sender: TObject; Item: TIconViewItem);
    procedure xfgListDirCommand(Sender: TObject);
    procedure cmbonchange(Sender: TObject);
    procedure cmbOnSelect(Sender: TObject);   
    procedure filelistMouseEnter(Sender: TObject);
    procedure filelistMouseLeave(Sender: TObject);
    procedure DoPopup(Sender: TObject);
    procedure cmbtextchange(Sender: TObject; Index: Integer);

 private
    ADor2,ASize:integer;
    ParentDIR:string;
    xfgmemointernallist:tstringlist;
    internal,external,alreadyUP,ExitShowIcon:Boolean;
    ListViewHasDo:Boolean;
    GIconItem:TIconViewItem;
    p1,p2,mainPANEL,cmbPANEL:tpanel; 
    sp,spb,sps:tspeedbutton;
    deleteSB,copySB,symlinkSB,moveSB:tspeedbutton;
    mi1,mi2,mi3,mi4,mi5,mi6,mi7,mi8:TMenuItem;
    splt:tsplitter;PANELcenter,PANEL3,PANEL4:tpanel;
    DirItemCacheLstINI:TMemIniFile;
    DirItemCacheLst:Tstringlist;
    
    DirItemCacheLstLoad,Form2FinishCreate:Boolean;
    overload:Boolean;
    FirstCaption:string;
 
//    procedure DoIconListViewFileInfo(DirStr:String);
  //  Function FileListGetIcon(APASSFilename:string):integer;
    
    procedure create_new_menu(APASSFromThisMenu:String;APASSParentMenuItem:TMenuItem) ;
    procedure toeditor(Sender: TObject);
    procedure checkselectdelete;
    procedure GoToForm1ShellFiles(Sender: TObject);
    procedure InputMenuClick (Sender: TObject); 
    procedure FileViewFilterClick(Sender: TObject);
    procedure checkMenuitemCheckFileEXT(APASSCOMPONENT:TCOMPONENT;APASSLIST:TSTRINGLIST);
    procedure checkMenuitemCheckFileEXT_DisabledAll(APASSCOMPONENT:TCOMPONENT;APASSLIST:TSTRINGLIST);
    procedure createListView;
 
 
 protected
  
IntoFileListSetDIRChangeInfo:Boolean;
   
 public
   extstring:string; 
   
 memo:tmemo;
 imglist,imglist2: TImageList;
    Popup: TPopupMenu;
   fileinfopopup: TPopupMenu;
    filemodeSP:tspeedbutton;
    internallist:tstringlist;    
    cmb:tcombobox;
    ListView:TListView;
    filelist:TFileIconView;
    XFGCurrentDir:string;
    procedure fileOperationSBUpdate(Mode:Boolean);
        procedure createimglist;
    procedure rowup(APASSFORM:TFORM);
   procedure DoListViewFileInfo(DIRStr:String);
         procedure createspeedbutton;
    procedure createpopup(sender:TObject);
 property Dor2: integer read ADor2;

  end;

var
  Form2: TForm2;
  spViewthumbnail:tspeedbutton;
  icontypelist:tstringlist;    
 
implementation

{$R *.xfm}
uses Unit1,Unit3,Unit4;


//////////////////////////////////////////////////////////////////////////////////////////////////    

  procedure TForm2.FormDestroy(Sender: TObject; var Action: TCloseAction);
begin
if icontypelist<>nil then icontypelist.free;
if DirItemCacheLst<>nil then  DirItemCacheLst.free;
if xfgmemointernallist<>nil then xfgmemointernallist.free;
if internallist<>nil then internallist.free; 
if DirItemCacheLstINI<>nil then DirItemCacheLstINI.free; 
end;


//////////////////////////////////////////////////////////////////////////////////////////////////    

procedure TForm2.cmbtextchange(Sender: TObject; Index: Integer);
    
begin
cmb.hint:=cmb.text;

end;

//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure TForm2.xfgListDirCommand(Sender: TObject);
var caretstart,ii,i:integer;lst:tstringlist;
begin
lst:=tstringlist.create;
try
for i:=0 to internallist.count-1 do
begin
if (AnsiEndsStr('/.',internallist[i])=true)or (AnsiEndsStr('/..',internallist[i])=true)then continue;
caretstart:=(form1.xfgmemo).GetTextLen-length((form1.xfgmemo).lines[(form1.xfgmemo).lines.count-1]);
if directoryexists(internallist[i]) then 
begin
lst.text:=k.CRS_GetDirFileList(internallist[i]);
for ii:=0 to lst.count-1 do
begin
if (trim(lst[ii])='')or (AnsiEndsStr('/.',lst[ii])=true)or (AnsiEndsStr('/..',lst[ii])=true)then continue;
form1.xfgmemo.lines.add(lst[ii]);
//form1.xfgmemo.append(k.CRS_GetDirFileList(internallist[i]))
end;
end 
else
form1.xfgmemo.append(internallist[i]);
(form1.xfgmemo).SelStart:=caretstart;
end;
finally
form1.show;
lst.free;
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    

procedure TForm2.toeditor(Sender: TObject);
var instr:string;i:integer;

begin
instr:='';
if form2.FocusedControl=memo then 

begin
  form1.doopen(memo.lines); 
  exit;
end;
//if (form2.FocusedControl=filelist)or(form2.FocusedControl=listview) then 
//begin
if internallist.count=0 then
if MessageDlg ('No files selected ', mtConfirmation, [mbOK], 0, mbYes)=mrOK then begin exit;;end;
for i:=0 to internallist.count-1 do
  if fileexists(internallist.strings[i]) then
     instr:=instr+internallist.strings[i]+#13#10;
if (form1.chkbox1=false) and (internallist.count > 5 )then 
begin
  if   MessageDlg('This is not a file listing'+#13#10+
       'You are trying to Open '+inttostr(internallist.count)+' files in text mode'+#13#10+
                  instr+ #13#10+
       'Open more than 5 non-text files in '+
       'text mode may burn your machine', mtWarning, [mbOk,mbCancel], 0)<>mrok then exit;
 
end;
 
   form1.doopen(internallist); 
   
//end; 
(**********************
if form2.FocusedControl=listview then 
begin
if listview.items.count=0 then exit;
templst:=tstringlist.create;
for i:=0 to listview.items.count-1 do
begin
if listview.items[i].selected=true then
templst.add(InfoListViewCurrentDir+listview.items[i].caption);
end;
if (form1.chkbox1=false) and (templst.count > 5 )then 
begin
  if   MessageDlg('This is not a file listing'+#13#10+
       'You are trying to Open '+inttostr(templst.count)+' files in text mode'+#13#10+
                  templst.text+ #13#10+
       'Open more than 5 non-text files in '+
       'text mode may burn your machine', mtWarning, [mbOk,mbCancel], 0)<>mrok then 
       begin templst.free;exit;end;
 
end;
form1.doopen(templst); 
templst.free;
end;
************************************)
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure TForm2.FormResize(Sender: TObject);
begin
 if Form2FinishCreate=true then   
 begin
// splt.MinSize:=15;
// begin
//splt.MinSize:=form2.width-10;
if panel3.width> form2.width then
panel3.width := form2.width-15;
end;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
 procedure TForm2.FormCreate(Sender: TObject);
begin

IntoFileListSetDIRChangeInfo:=false;
//filelistImageList:=tstringlist.create;
InfoListViewCurrentDir:='';
XFGCurrentDir:='';
ListViewHasDo:=false;
Form2FinishCreate:=false;
DirItemCacheLst:=nil;
DirItemCacheLst:=tstringlist.create;
DirItemCacheLst.CaseSensitive:=true;
DirItemCacheLst.sorted:=true;
DirItemCacheLst.Duplicates := (dupIgnore);
FirstCaption:=k.RS_APP_data_dir+'/'+k.CRS_GetGuid+'DirItemCacheLstToBeDeleted';
DirItemCacheLst.savetofile(FirstCaption);
DirItemCacheLstINI:=nil;
DirItemCacheLstINI:=TMemIniFile.create(FirstCaption);
DirItemCacheLstINI.clear;
DirItemCacheLstLoad:=false;
FirstCaption:='';
//FirstCaptionInt:=0;
ASize:=0;
overload:=false;
if not directoryexists(form1.DATADIR+'/.thrash bin') then
forcedirectories(form1.DATADIR+'/.thrash bin');

imglist:=nil; 
filemodeSP:=nil;
ADor2:=0;
internal:=false;
external:=false;
alreadyUP:=true;
ParentDIR:=k.RS_mainpath;
ExitShowIcon:=false;

GIconItem:=nil;
internallist:=nil;
xfgmemointernallist:=nil;
icontypelist:=nil;
xfgmemointernallist:=tstringlist.create;
internallist:=tstringlist.create;
icontypelist:=tstringlist.create;

application.HintPause:=50;
application.HintHidePause:=60000;
     form2.caption:='Redstone Commander';
 //  form2.Constraints.MaxHeight := 420;
//form2.Constraints.MaxWidth := 640;
  form2.Constraints.MinHeight := 490;
 form2.Constraints.MinWidth := 640;
 form2.Constraints.MaxWidth := screen.width;
 form2.Constraints.MaxHeight := screen.Height-20;

 
   form2. Width := form2.Constraints.MinWidth ;
   form2.Height := form2.Constraints.MinHeight ;
   if screen.width=640 then form2.Left:=0 else
   form2.Left :=screen.width-form2.Constraints.MinWidth-10;
   if screen.height=480 then form2.top:=0 else
   form2.Top :=screen.height-form2.Constraints.MinHeight-50;
   
  
 createimglist;

 createpanel1;

 createpanel2;
  


createspeedbutton;
memo:=tmemo.create(form2);
with memo as tmemo do
begin
parent:=panel3;

    align:=alclient;
       ScrollBars := ssAutoBoth;
        UndoLevels :=256;
      HMargin:=3;
   //   MaxLength :=0;
      ReadOnly:=false;
       alignment:=taLeftJustify;
   //   TabOrder := 0;
      WordWrap := False;
        WantTabs:=true;
       WantReturns:=true;
       BorderStyle := bsRaisedPanel;
visible:=true;

end;
 createFileIconView; 
panel3.width:=form2.width-15;;
 (*********************************************)
splt:=tsplitter.create(form2);
splt.parent:=panelcenter;
with splt as tsplitter do
begin
//
  Left := form2.width-5;
    Top := 26;
 //  align:=alleft;
  //  Height := 375;
 //   Beveled := True;
    Color := $00D5A186  ;
    width:=5;
 // Beveled:=true;
   MinSize:=15;
AutoSnap:=false; 

end;
(*********************************************)
// panel3.width:=form2.width-10;
popup:=tpopupmenu.create(Form2);
popup.AutoPopup := true;
popup.OnPopup:= DoPopup;
popup.name:='popup';

Popup.Alignment := (paLeft);
  createpopup(popup as tpopupmenu);
  filelist.popupmenu:=popup;
  //form1.CheckForm2Refresh;
   createListView;
  fileinfopopup:=tpopupmenu.create(Form2);
fileinfopopup.AutoPopup := true;
fileinfopopup.OnPopup:= DoPopup;
fileinfopopup.name:='fileinfopopup';
fileinfopopup.Alignment := (paLeft);
  createpopup(fileinfopopup as tpopupmenu);
 Listview.popupmenu:=fileinfopopup;

filelist.bringtofront;
//deletesb.enabled:=true;
fileOperationSBUpdate(true);
extstring:='*';
filelistDoDoubleClick(GetEnvironmentVariable('HOME'));
IntoFileListSetDIRChangeInfo:=true;
filelist.directory.location:=GetEnvironmentVariable('HOME');

DoListViewFileInfo(filelist.directory.location);
Form2FinishCreate:=true;
form2.filelist.setfocus;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure Tform2.createListView;
var  Cl: TListColumn;

begin

ListView:=TListView.create(Form2);
with ListView as TListView do
begin
parent:=PANEL4;
//parent:=panelcenter;
//imglist2:=timagelist.create(ListView);
//imglist2.assign(imglist);
try
//color:=$00E6E6E6 ;
   Color := stringtocolor(inifile.Readstring ('xfgMain', 'Filemanager_ListView_BGColor', 'none'));
//font.Color := 8940896;
   Font.Color := stringtocolor(inifile.Readstring ('xfgMain', 'Filemanager_ListView_FGColor', 'none'));
 //  font.name:= 'Lucida';
font.name:= (inifile.Readstring ('xfgMain', 'Filemanager_ListView_FontName', 'none'));
//font.size:=11;
font.size:=strtoint(inifile.Readstring ('xfgMain', 'Filemanager_ListView_FontSize', 'none'));
except
Color := $00E6E6E6 ;
Font.Color := 8940896;
Font.Height := 11;
Font.Name := 'helvetica';
end;
//Images := imglist2;
    Left:=0;
    Top:=0;
    Width:=543;
    Height:=375;
    Align:=alClient;
    BorderStyle:=bsNone;
    Cl:=Columns.add;
    Cl.width:=200;
    Cl.caption:='Name';
    Cl:=Columns.add;
    Cl.width:=40;
    Cl.caption:='Type';
    Cl:=Columns.add;
    Cl.width:=70;
    Cl.caption:='Link target';
    Cl:=Columns.add;
    Cl.width:=70;
    Cl.caption:='Size';
    Cl:=Columns.add;
    Cl.caption:='Block';
    Cl:=Columns.add;
    Cl.caption:='Mode';
    Cl:=Columns.add;
    Cl.width:=70;
    Cl.caption:='Permission';
    Cl:=Columns.add;
    Cl.caption:='Owner';
    Cl:=Columns.add;
    Cl.caption:='Group';
    Cl:=Columns.add;
        Cl.width:=160;
    Cl.caption:='Modified';
     Cl:=Columns.add;
     Cl.width:=160;
        Cl.caption:='Accessed';
            Cl:=Columns.add;
            Cl.width:=160;
            Cl.caption:='Changed';

    
 
 
    
    MultiSelect := True;
   // OwnerDraw := True;
    RowSelect := True;
    ReadOnly := True;
    //ShowColumnSortIndicators := True;
    TabOrder := 0;
    sorted:=false;
    ViewStyle := vsReport;
  //  OnChange := ListView1Change
   // OnChanging := ListView1Changing
    OnClick := ListView1Click;
  //  OnColumnClick := ListView1ColumnClick
  //  OnDblClick = ListView1DblClick
  //  OnDeletion = ListView1Deletion
  //  OnInsert = ListView1Insert
//OnItemClick := ListViewItemClick;
  OnItemDoubleClick := ListView1ItemDoubleClick;
  //  OnItemEnter = ListView1ItemEnter
 //   OnItemMouseDown := ListView1ItemMouseDown;
    OnSelectItem := ListView1SelectItem;
//OnDrawItem:= ListViewDrawItem;
 end; 
 (************************************
 l:=tstringlist.create;
 fileinfopopup:=tpopupmenu.create(form2);
//popup.parent:=filelist;
fileinfopopup.AutoPopup := true;
fileinfopopup.OnPopup:= DoPopup;
fileinfopopup.Alignment := (paLeft);
if not inifile.sectionexists('xfgFileInputInfoMenu')then begin l.free;exit;end;
 inifile.readsection('xfgFileInputInfoMenu',l);

for i:=0 to l.count-1 do
begin

Pitem:=TMenuItem.create(fileinfopopup);
 with Pitem as TMenuItem do
    begin
   Caption := l[i];
   Hint := l[i];
   imgfile:=inifile.readstring('xfgFileInputInfoMenuImage',l[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
       OnClick := popupclick;
 
 end;
fileinfopopup.items.add(Pitem);
end;
****************************)
//Listview.popupmenu:=fileinfopopup;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.ListViewDrawItem(Sender: TCustomListView; Item: TListItem; 
                  Canvas: TCanvas; const Rect: TRect; State: TOwnerDrawState);
begin
if (directoryexists(InfoListViewCurrentDir+Item.caption))and
not (item.caption='.') and not(item.caption='..')
then 
begin

Canvas.Brush.Color := clRed;    
//Canvas.Brush.Style := bsSolid;
Canvas.font.style:=[fsbold];
 //canvas.SetClipRect(Rect);
//canvas.fillRect(Rect);

 //TheRect := Rect(10,10,100,100);  Form1.
Canvas.TextRect(Rect,3,3,'____________________________________________________________');
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean); 
begin
//checkselectdelete;
if (item.caption='..')or(item.caption='.')  then exit;

if (selected =false)then begin
if internallist.indexof(InfoListViewCurrentDir+item.caption)<>-1 then
internallist.delete(internallist.indexof(InfoListViewCurrentDir+item.caption));

exit;
end;
//form1.xfgmemo.lines.add(item.caption);
if (item.caption<>'..')and(item.caption<>'.') then
begin

if (selected =true)then 
begin

if ListView.selcount>1 then 
begin
if internallist.indexof(InfoListViewCurrentDir+item.caption)<>-1 then
internallist.delete(internallist.indexof(InfoListViewCurrentDir+item.caption));
internallist.add(InfoListViewCurrentDir+item.caption); 
XFGCurrentDir:=InfoListViewCurrentDir;
exit;
end;

if ListView.selcount=1 then
begin
internallist.clear;
internallist.add(InfoListViewCurrentDir+item.caption); 
XFGCurrentDir:=InfoListViewCurrentDir;
exit;
end;

if ListView.selcount=0 then
begin
XFGCurrentDir:=InfoListViewCurrentDir;
internallist.clear;exit;
end;

end;
//internallist.savetofile('/0000.popo');


end;



end; 
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.ListView1Click(Sender: TObject); 
begin
panel3.color:=form1.color;
panel4.color:=$0000DEE6;
cmb.text:=InfoListViewCurrentDir;
//cmb.items.Insert(0, InfoListViewCurrentDir);
chdir(InfoListViewCurrentDir); 
XFGCurrentDir:=InfoListViewCurrentDir;
checkselectdelete;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.DoListViewFileInfo(DirStr:String);
var predir:string;LItem: TListItem;
i:integer;ListViewLst:tstringlist;
begin
predir:=InfoListViewCurrentDir;
ListViewLst:=nil;
ListViewLst:=tstringlist.create;;


listview.Cursor:= crHourGlass; 
//try
(K.CRS_GetDirFileListInfo(DirStr,ListViewLst));
if ListViewLst=nil then
begin
//except

if ListViewLst<>nil then ListViewLst.free;ListViewLst:=nil;
listview.Cursor:= crDefault;   
MessageDlg('Can''t access directory or file ...', mtInformation, [mbOk], 0);
DoListViewFileInfo(predir);
exit;
end;
//FileLst.text:=ListViewSTRING;
listview.Items.clear;

for i:=0 to ListViewLst.count-1 do
begin
//application.processmessages;
//if extractfilename(FileLst.names[i])='.' then continue;
LItem:=listview.Items.add;
//LItem.caption:=extractfilename(ListViewLst.names[i]);
LItem.caption:=ListViewLst.names[i];
//LItem.ImageIndex:=FileListGetIcon(FileLst.names[i]);
LItem.SubItems.Delimiter:='=';  
LItem.SubItems.DelimitedTexT:=ListViewLst.ValueFromIndex[i];
end;
if ListViewLst<>nil then ListViewLst.free;
ListViewLst:=nil;

if panel3.width> form2.width-100 then panel3.width:=form2.width div 2;
if lastdelimiter('/',DirStr)<>length(DirStr) then InfoListViewCurrentDir:=DirStr+'/'
else if lastdelimiter('/',DirStr)=length(DirStr) then InfoListViewCurrentDir:=DirStr;
listview.Cursor:= crDefault;   
cmb.text:=InfoListViewCurrentDir;
cmb.items.Insert(0, InfoListViewCurrentDir);
chdir(InfoListViewCurrentDir); 
XFGCurrentDir:=InfoListViewCurrentDir;
//listview.Items.EndUpdate;


end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure Tform2.ListView1ItemDoubleClick(Sender: TObject; Item: TListItem);  
var dirstr:string;
begin    
checkselectdelete;
if (Item.caption='.')or (InfoListViewCurrentDir+Item.caption='/..') then exit; 
internallist.clear;
internallist.add(InfoListViewCurrentDir+Item.caption); 

if directoryexists(InfoListViewCurrentDir+Item.caption) then 
begin
dirstr:=InfoListViewCurrentDir+Item.caption;
if  Item.caption='..'then 
begin
dirstr:=InfoListViewCurrentDir;
delete(dirstr,length(dirstr),1);

dirstr:=leftstr(dirstr,lastdelimiter('/',dirstr));
end;
 if directoryexists(dirstr) then 
DoListViewFileInfo(dirstr);
exit;
end;

 if not (directoryexists(filelist.directory.location+item.caption))then 
  begin
  //internallist.add(InfoListViewCurrentDir+Item.caption); 
  XFGCurrentDir:=InfoListViewCurrentDir;
  form1.doopen(internallist);  
  exit;
  end;

end; 

//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure Tform2.FormClose(Sender: TObject; var Action: TCloseAction);
   begin
 //  bmp.free;

  action:=canone;
{
if icontypelist<>nil then   icontypelist.free;
   if internallist<>nil then   internallist.free;
   if form1.inifile<>nil then  form1.inifile.free;
}
end;

//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

    procedure Tform2.filelistMouseEnter(Sender: TObject);
    begin
    application.HintPause:=500;
application.HintHidePause:=2500;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

    procedure Tform2.filelistMouseLeave(Sender: TObject);
    begin
application.HintPause:=50;
application.HintHidePause:=60000;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

procedure Tform2.filelistClick(Sender: TObject);
begin
panel3.color:=$0000DEE6; 
panel4.color:=form1.color;
cmb.text:=filelist.directory.location;
//cmb.items.Insert(0, InfoListViewCurrentDir);
chdir(filelist.directory.location); 
checkselectdelete;
XFGCurrentDir:=filelist.directory.location;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

procedure Tform2.filelistItemClicked(Sender: TObject;Item: TIconViewItem);
//var FR:TRecord;

begin
cmb.text:=filelist.directory.location;
//cmb.items.Insert(0, InfoListViewCurrentDir);
chdir(filelist.directory.location); 
checkselectdelete;
//if not fileexists(form2.filelist.directory.location+'.xfgdir')then
XFGCurrentDir:=filelist.directory.location;



end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

procedure Tform2.checkselectdelete;

begin
if form2.FocusedControl=form2.filelist then 
begin 
if (filelist.selcount=1) and (filelist.selected.caption='..') then 
begin mi3.enabled:=false;mi2.enabled:=false;fileOperationSBUpdate(false);internallist.clear;exit;end;
if (filelist.selcount=1) and (filelist.selected.caption<>'..') then 
begin mi3.enabled:=true;mi2.enabled:=true;fileOperationSBUpdate(true);exit;end;
if filelist.selcount=0 then internallist.clear;
if filelist.selcount>1 then mi2.enabled:=false;

if internallist.count=0 then begin mi2.enabled:=false;mi3.enabled:=false;fileOperationSBUpdate(false);
exit;end;

if filelist.selcount=0 then begin mi2.enabled:=false;mi3.enabled:=false;fileOperationSBUpdate(false);
exit;end;

mi3.enabled:=true;
fileOperationSBUpdate(true);
end;
if form2.FocusedControl=form2.listview then 
begin 
if (listview.selcount=1) and (listview.selected.caption='..') then 
begin mi3.enabled:=false;mi2.enabled:=false;fileOperationSBUpdate(false);internallist.clear;exit;end;
if (listview.selcount=1) and (listview.selected.caption<>'..') then 
begin mi3.enabled:=true;mi2.enabled:=true;fileOperationSBUpdate(true);exit;end;
if listview.selcount=0 then internallist.clear;
if listview.selcount>1 then mi2.enabled:=false;

if internallist.count=0 then begin mi2.enabled:=false;mi3.enabled:=false;fileOperationSBUpdate(false);
exit;end;

if listview.selcount=0 then begin mi2.enabled:=false;mi3.enabled:=false;fileOperationSBUpdate(false);
exit;end;

mi3.enabled:=true;
fileOperationSBUpdate(true);
end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
 procedure Tform2.cmbOnSelect(Sender: TObject);      
        begin
        
if directoryexists(cmb.text) then
begin
if lastdelimiter('/',cmb.text)<>length(cmb.text)then cmb.text:=cmb.text+'/';
 if XFGCurrentDir=filelist.directory.location then 
 begin
 //
 if form2.FocusedControl<>(ListView)then
 begin
// if filelist.directory.location=cmb.text then exit;
if cmb.text=filelist.directory.location then exit;
 filelistDoDoubleClick(cmb.text);
 filelist.directory.location:=cmb.text;
 XFGCurrentDir:=cmb.text;
 //IntoFileListSetDIRChangeInfo:=false;
end;
 end
  else
  if (cmb.text<>form1.DATADIR+'/.thrash bin/')then DoListViewFileInfo(cmb.text);
if lastdelimiter('/',cmb.text)<>length(cmb.text)then XFGCurrentDir:=cmb.text+'/';
if lastdelimiter('/',cmb.text)=length(cmb.text)then XFGCurrentDir:=cmb.text;
XFGCurrentDir:=cmb.text;
end else
cmb.items.delete(cmb.items.indexof(cmb.text));
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

    procedure Tform2.cmbonchange(Sender: TObject);
    begin
      if directoryexists(cmb.text) then
begin

  cmb.hint:=cmb.text;

 ExitShowIcon:=true;  
 end else
 cmb.items.delete(cmb.items.indexof(cmb.text));
    end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
    
procedure Tform2.filelistDoDoubleClick(ApassFileName:string);
var DSTR,FSTR,LNKSTR:string;Pinfo:Pfileinfo;
stat:_stat;IsLink:boolean;
RSTFilelst:tstringlist;SearchRec: TSearchRec;
ss1:string;

FTypeValues,FLinkTypeValues,FCurDirPlusItemCapValues,
CurDirPlusItemCap,ItemExt:string;


function PermissionString(Mode:mode_t): string;
  function TestBit(Bit: Cardinal): Char;
  begin
    Result := '-';
    if Mode and Bit = Bit then
      case Bit of
        S_IRUSR, S_IRGRP, S_IROTH:
          Result := 'r';
        S_IWUSR, S_IWGRP, S_IWOTH:
          Result := 'w';
        S_IXUSR, S_IXGRP, S_IXOTH:
          Result := 'x';
      end;
  end;
begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '!!!!';
    Exit;
  end
  else begin
    Result := Result + TestBit(S_IRUSR)+ 
                       TestBit(S_IWUSR)+ 
                       TestBit(S_IXUSR)+ 
                       TestBit(S_IRGRP)+ 
                       TestBit(S_IWGRP)+ 
                       TestBit(S_IXGRP)+ 
                       TestBit(S_IROTH)+ 
                       TestBit(S_IWOTH)+ 
                       TestBit(S_IXOTH);
    (*
    Result := Result + TestBit(S_IWUSR);
    Result := Result + TestBit(S_IXUSR);

    Result := Result + TestBit(S_IRGRP);
    Result := Result + TestBit(S_IWGRP);
    Result := Result + TestBit(S_IXGRP);

    Result := Result + TestBit(S_IROTH);
    Result := Result + TestBit(S_IWOTH);
    Result := Result + TestBit(S_IXOTH);
    *)
  end;
end;
function GetFileType(Mode:mode_t): string;
  function TestBit(Bit: Cardinal): String;
  begin
    Result := '';
    if Mode and Bit = Bit then
      case Bit of
        S_IFSOCK:
       	  Result := 'S' ;//socket
        S_IFLNK:	 
          Result := 'L'  ;//symbolic link
        S_IFREG:	 
          Result := 'F'  ;//regular file
        S_IFBLK:	 
          Result := 'B'  ;//block device
        S_IFDIR:	 
          Result := '[DIR]'  ;//directory
        S_IFCHR:	 
          Result := 'C'  ;//character device
        S_IFIFO:	 
          Result := 'I'  ;//fifo

      end;
  end;
begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '!!!!';
    Exit;
  end
  else begin
     Result := Result+TestBit(S_IFDIR)+
                      TestBit(S_IFCHR)+
                      TestBit(S_IFIFO)+
                      TestBit(S_IFLNK)+
                      TestBit(S_IFREG);
     (*
     Result := Result+TestBit(S_IFCHR);
     Result := Result+TestBit(S_IFIFO);
     Result := Result+TestBit(S_IFLNK);
     Result := Result+TestBit(S_IFREG);
     *)
    if TestBit(S_IFSOCK)<>'' then Result := 'S';
    if TestBit(S_IFBLK)<>'' then Result := 'B';
  end;
end;
function PermissionMASK(Mode:mode_t): string;
var tempINT:integer;
  function TestBit(Bit: Cardinal): integer;
  begin
    Result := 0;
    if Mode and Bit = Bit then
      case Bit of
        S_IFSOCK:
       	  Result := 0140000 ;//socket
        S_IFLNK:	 
          Result := 0120000 ;//symbolic link
        S_IFREG:	 
          Result := 0100000 ;//regular file
        S_IFBLK:	 
          Result := 0060000 ;//block device
        S_IFDIR:	 
          Result := 0040000 ;//directory
        S_IFCHR:	 
          Result := 0020000 ;//character device
        S_IFIFO:	 
          Result := 0010000 ;//fifo
        S_IRUSR:
          Result := 400; 
        S_IRGRP:
          Result := 40;  
        S_IROTH:
          Result := 4; 
        S_IWUSR:
          Result := 200;  
        S_IWGRP:
          Result := 20;  
        S_IWOTH:
          Result := 2; 
        S_IXUSR:
          Result := 100;  
        S_IXGRP:
          Result := 10;  
        S_IXOTH:
          Result := 1;
        S_ISUID:
          Result := 4000;
        S_ISGID:
          Result := 2000; 
        S_ISVTX:
          Result := 1000;  
      end;
  end;
begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '!!!!';
    Exit;
  end
  else begin
  tempINT:=0;
    tempINT := tempINT + TestBit(S_IFSOCK)+ 
                         TestBit(S_IFLNK)+ 
                         TestBit(S_IFREG)+ 
                         TestBit(S_IFBLK)+ 
                         TestBit(S_IFDIR)+ 
                         TestBit(S_IFCHR)+ 
                         TestBit(S_IFIFO)+ 
                         TestBit(S_IRUSR)+ 
                         TestBit(S_IWUSR)+ 
                         TestBit(S_IXUSR)+ 
                         TestBit(S_IRGRP)+ 
                         TestBit(S_IWGRP)+ 
                         TestBit(S_IXGRP)+ 
                         TestBit(S_IROTH)+ 
                         TestBit(S_IWOTH)+ 
                         TestBit(S_IXOTH)+ 
                         TestBit(S_ISUID)+ 
                         TestBit(S_ISGID)+ 
                         TestBit(S_ISVTX);
    (*
    tempINT := tempINT + TestBit(S_IFLNK);
    tempINT := tempINT + TestBit(S_IFREG);
    tempINT := tempINT + TestBit(S_IFBLK);
    tempINT := tempINT + TestBit(S_IFDIR);
    tempINT := tempINT + TestBit(S_IFCHR);
    tempINT := tempINT + TestBit(S_IFIFO);
     
    tempINT := tempINT + TestBit(S_IRUSR);
    tempINT := tempINT + TestBit(S_IWUSR);
    tempINT := tempINT + TestBit(S_IXUSR);

    tempINT := tempINT + TestBit(S_IRGRP);
    tempINT := tempINT + TestBit(S_IWGRP);
    tempINT := tempINT + TestBit(S_IXGRP);

    tempINT := tempINT + TestBit(S_IROTH);
    tempINT := tempINT + TestBit(S_IWOTH);
    tempINT := tempINT + TestBit(S_IXOTH);
    tempINT := tempINT + TestBit(S_ISUID);
    tempINT := tempINT + TestBit(S_ISGID);
    tempINT := tempINT + TestBit(S_ISVTX);
    *)
 
  result:=inttostr(tempINT);
  end;
end;

begin
ss1:=trim(ApassFileName);
internallist.clear;
internallist.add(ss1); 

//overload:=false;
if not directoryexists(form1.datadir+'/.thumbnailStorage'+ApassFileName) 
then forcedirectories(form1.datadir+'/.thumbnailStorage'+ApassFileName);
//DirItemCacheLst.savetofile(form1.datadir+'/.thumbnailStorage'+form2.filelist.directory.location+'.xfgdir');
//DirItemCacheLst.clear;
ASize:=0;
//form1.xfgmemo.popupmenu:=nil;
  if not (directoryexists(ss1))then 
  begin

  XFGCurrentDir:=filelist.directory.location;
  
  form1.doopen(internallist);  
  exit;
  end;


if directoryexists(ss1) then
begin
XFGCurrentDir:=ss1;
chdir(ss1);

if AnsiEndsStr('/', ss1)then
delete(ss1,Length(ss1),1);
//filelist.directory.location:=ss1;
//filelist.items.BeginUpdate ;







(*

//if DirItemCacheLstLoad=false then
if fileexists(form1.datadir+'/.thumbnailStorage'+
ss1+'/.xfgdir')then
begin
//form1.xfgmemo.lines.add('       2');

//DirItemCacheLst.clear;
//DirItemCacheLst.loadfromfile(form1.datadir+'/.thumbnailStorage'+
//ss1+'/.xfgdir');
//DirItemCacheLstLoad:=true;
end;
DirItemCacheLstLoad:=true;
*)
(******************************************************************************************)

FSTR:='';
DSTR:='';
LNKSTR:='';
RSTFilelst:=tstringlist.create;

////////////////////////////////////////////////////////////////
 //  if LastDelimiter('/',APASSFileNAME)<>length(APASSFileNAME) then APASSFileNAME:=APASSFileNAME+'/';
 //  pathstr:=(APASSFileNAME);
    if FindFirst(ss1 +'/'+ '*', 
        faAnyFile , SearchRec) = 0 then
      try
        repeat
        //  if (SearchRec.Name <> '.') or
        //      (SearchRec.Name <> '..') then
        //     
              begin
             
  
      
LNKSTR:='';
IsLink:=false;
//Pinfo:=nil;
//Pinfo:=CRS_GetFilePInfo(tempFileSTR);
Pinfo:=AllocFileInfo(SearchRec);
stat:=Pinfo.stat;
if (SearchRec.Attr and faSymLink <> 0) then 
begin
IsLink:=true;
if (access(pchar(Pinfo.linktarget),R_OK)<>-1)then LNKSTR:=Pinfo.linktarget 
else LNKSTR:='Broken file link';
end;
///////////////////////////////////////////////////////////////////
if GetFileType(stat.st_mode)='[DIR]' then
begin
if IsLink then


RSTFilelst.add(      SearchRec.Name+'='+
//inttostr(icontypelist.indexof('%linkfolder%')))
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%linkfolder%',1)-1))
                //   +'='+inttostr(stat.st_mode) )
                   else
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%folder%')));
                  inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%folder%',1)-1));
                 //  +'='+inttostr(stat.st_mode) )    ;
                   

continue;                   
end;
///////////////////////////////////////////////////////////////////
if GetFileType(stat.st_mode)='B' then
begin
if IsLink then
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%linkblock%')))
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%linkblock%',1)-1))
                 // + '='+inttostr(stat.st_mode) )
                  else
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%block%')));
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%block%',1)-1));
                  // +'='+inttostr(stat.st_mode) )    ;
continue;                   
end;
///////////////////////////////////////////////////////////////////
if GetFileType(stat.st_mode)='S' then
begin
if IsLink then
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%linksocket%')))
                inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%linksocket%',1)-1))
                  // +'='+inttostr(stat.st_mode) )
                   else
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%socket%')));
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%socket%',1)-1));
                 //  +'='+inttostr(stat.st_mode) )    ;
continue;                   
end;
///////////////////////////////////////////////////////////////////
if GetFileType(stat.st_mode)='C' then
begin
if IsLink then
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%linkcharacter%')))
                inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%linkcharacter%',1)-1))
             // '='+inttostr(stat.st_mode) )
                 else
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%character%')));
                 inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%character%',1)-1));
               //  '='+inttostr(stat.st_mode) )    ;
continue;                   
end;
///////////////////////////////////////////////////////////////////
if GetFileType(stat.st_mode)='I' then
begin
if IsLink then
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%linkfifo%')))
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%linkfifo%',1)-1))
               //    '='+inttostr(stat.st_mode) )
                  else
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%fifo%')));
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%fifo%',1)-1));
             //  '='+inttostr(stat.st_mode) )    ;
continue;
end;
///////////////////////////////////////////////////////////////////
if AnsiPos('x', PermissionString(stat.st_mode))<>0 then
begin
if IsLink then
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%linkexecutables%')))
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%linkexecutables%',1)-1))
                  // '='+inttostr(stat.st_mode) )
                  else
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%executables%')));
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%executables%',1)-1));
                 //  '='+inttostr(stat.st_mode) )    ;
                   
continue;
end;
///////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////if (S_Mode and (S_IFREG)<>0)then 
if GetFileType(stat.st_mode)='F' then
begin
CurDirPlusItemCap:=SearchRec.Name;
ItemExt:=K.CRS_extractfileExt( CurDirPlusItemCap);
//inifile.casesensitive:=false;

if IsLink then 
FLinkTypeValues:='%link'+copy(trim(FTypeValues),2,length(FTypeValues))
else
FTypeValues:=inifile.Readstring ('xfgFileTypeIconImage',
Copy(AnsiLowercase(ItemExt), 
2, length(AnsiLowercase(ItemExt))-1),'none');

FCurDirPlusItemCapValues:=Copy(AnsiLowercase(extractfileExt( CurDirPlusItemCap)), 
2, length(AnsiLowercase(extractfileExt( CurDirPlusItemCap)))-1);

if AnsiPos('%',FTypeValues)=0 then//%text%
 begin
// if (S_Mode and (S_IFREG)<>0)and(S_Attr and faSymLink <> 0 )then 
 if IsLink then 
 begin
  if inifile.valueexists('xfgFileTypeIconBuiltin',FLinkTypeValues)then
 // if icontypelist.indexof(FLinkTypeValues) <> -1 then
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof(FLinkTypeValues)))
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin',FLinkTypeValues,1)-1))
               //    '='+inttostr(stat.st_mode)) 
               else
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%linkfile%')));
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%linkfile%',1)-1));
                  // '='+inttostr(stat.st_mode) )    ;
continue;

  end else begin
  if inifile.valueexists('xfgFileTypeIconBuiltin',FTypeValues)then
 //  if icontypelist.indexof(FTypeValues) <> -1 then
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof(FTypeValues)))
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin',FTypeValues,1)-1))
                  // '='+inttostr(stat.st_mode) )  
 else
 if inifile.valueexists('xfgFileTypeIconBuiltin',inifile.Readstring ('xfgFileTypeIconImage',
FCurDirPlusItemCapValues,'none'))
//if icontypelist.indexof(FCurDirPlusItemCapValues)<>-1
then
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof(FCurDirPlusItemCapValues)))
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin',inifile.Readstring ('xfgFileTypeIconImage',
FCurDirPlusItemCapValues,'none'),1)-1))
                //   '='+inttostr(stat.st_mode) )  
 else
 
RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%file%')));
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%file%',1)-1));
                //   '='+inttostr(stat.st_mode) )  ;


    end; 

continue;
end  else

if AnsiPos('%',FTypeValues )>0 then//%text%
 begin  

// if (S_Mode and (S_IFREG)<>0)and(S_Attr and faSymLink <> 0 )then 
 if IsLink then 
  begin
       if inifile.valueexists('xfgFileTypeIconBuiltin',FLinkTypeValues)then
        //   if icontypelist.indexof(FLinkTypeValues)<>-1then
 RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof(FLinkTypeValues)))
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin',FLinkTypeValues,1)-1))
                 //  '='+inttostr(stat.st_mode) )    
  else
   RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%linkfile%')));
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%linkfile%',1)-1));
                  // '='+inttostr(stat.st_mode) )  ;    
   
  end else begin
    if inifile.valueexists('xfgFileTypeIconBuiltin',FTypeValues)then
  //  if icontypelist.indexof(FTypeValues)<>-1then
     RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof(FTypeValues)))
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin',FTypeValues,1)-1))
                   //'='+inttostr(stat.st_mode) )     
  else
 if inifile.valueexists('xfgFileTypeIconBuiltin',inifile.Readstring ('xfgFileTypeIconImage',
FCurDirPlusItemCapValues,'none'))then
//  if icontypelist.indexof(FCurDirPlusItemCapValues)<>-1then
     RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof(FCurDirPlusItemCapValues)))
                inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin',inifile.Readstring ('xfgFileTypeIconImage',
FCurDirPlusItemCapValues,'none'),1)-1))
                //   '='+inttostr(stat.st_mode) )     
                   
 else
     RSTFilelst.add(      SearchRec.Name+'='+//inttostr(icontypelist.indexof('%file%')));
                   inttostr(inifile.Readinteger('xfgFileTypeIconBuiltin','%file%',1)-1));
               //    '='+inttostr(stat.st_mode) )  ;    
    
    end;
end;
//inifile.casesensitive:=true;
//item.imageindex:=index;
//continue;

end;//if (S_Mode and (S_IFREG)<>0)then 

(****************************************************************************)


              end;
        until FindNext(SearchRec) <> 0;
      finally
        FindClose(SearchRec);
      end;
 


(******************************************************************************************)
//end else
//DirItemCacheLstLoad:=false;
//DirItemCacheLst.clear;
DirItemCacheLst.assign(RSTFilelst);
try
DirItemCacheLst.savetofile(form1.datadir+'/.thumbnailStorage'+
ss1+'/.xfgdir');
RSTFilelst.insert(0,'[icon]');
IntoFileListSetDIRChangeInfo:=true;
DirItemCacheLstINI.setstrings(RSTFilelst);

//DirItemCacheLstINI.updatefile;
except
//IntoFileListSetDIRChangeInfo:=false;
end;
//DirItemCacheLst.savetofile('/xxxxxxxxxxxxxxxx');

if RSTFilelst<>nil then RSTFilelst.free;


//filelist.items.EndUpdate;

end;



end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
    procedure Tform2.filelistItemDoubleClick(Sender: TObject;Item: TIconViewItem);

    begin 
    
    filelistDoDoubleClick((filelist.directory.location)+item.caption);
     if filelist.selcount=0 then exit;
     if filelist.selcount>1 then exit;
  //  filelist.directory.location:=(filelist.directory.location)+item.caption;
  // filelistDoDoubleClick((filelist.directory.location)+item.caption);
//DirectoryINTO:=true;


end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure Tform2.checkMenuitemCheckFileEXT(APASSCOMPONENT:TCOMPONENT;APASSLIST:TSTRINGLIST);
var i,ii:integer;Temp: tComponent;lst,lst1:tstringlist;itemcaption,s:string;

begin

lst:=tstringlist.create;
lst1:=tstringlist.create;
lst1.CaseSensitive:=false;

inifile.readsection('xfgMenuitemCheckFileEXT',lst);
  for I := 0 to APASSCOMPONENT.Componentcount - 1 do
  begin
 
    Temp := APASSCOMPONENT.Components[I];
    if (temp is Tmenuitem)  then
    begin
 
    with (temp as Tmenuitem) do 
      begin
      
     if  APASSCOMPONENT is TPOPUPMENU  then
       if trim(AnsiLowercase(inifile.readstring('xfgFileInputMenu',hint,'none')))='%createnew%' then 
           checkMenuitemCheckFileEXT((temp as Tmenuitem),APASSLIST);
       if  APASSCOMPONENT is Tmenuitem then
      if trim(AnsiLowercase(inifile.readstring((temp as Tmenuitem).parent.hint,hint,'none')))='%createnew%' then 
      checkMenuitemCheckFileEXT((temp as Tmenuitem),APASSLIST);
      
       if lst.indexof(hint)<>-1 then 
       begin
       
       for II := 0 to APASSLIST.count - 1 do
       begin
        itemcaption:=APASSLIST[II];
        s:=AnsiLowercase(trim(inifile.readstring('xfgMenuitemCheckFileEXT',hint,'none')));
       if s='xfgallext'
       then 
       begin
       if APASSLIST.count> 0 then begin
       enabled:=true ;
       ;end;//else
      // if APASSLIST.count=0 then (temp as Tmenuitem).enabled:=false;
      continue;
      //break
      end;
       if s='xfgallfilesext'
        then 
       begin
       if APASSLIST.count> 0 then 
       if not directoryexists(APASSLIST[II])then begin
       enabled:=true ;
       end;//else
       //(temp as Tmenuitem).enabled:=false;
       continue;
      end;
       if s='xfgalldirext'
        then 
       begin
       if APASSLIST.count> 0 then 
       if directoryexists(APASSLIST[II])then begin
       enabled:=true;end;// else
       //(temp as Tmenuitem).enabled:=false;
       continue;
      end;
      lst1.clear;
//if  AnsiContainsStr(AnsiLowercase(),AnsiLowercase())=true
      lst1.CaseSensitive:=false;
       inifile.readsection(inifile.readstring('xfgMenuitemCheckFileEXT',hint,'none'),lst1);
        if lst1.indexof(AnsiLowercase(copy(extractfileext(itemcaption),2,length(itemcaption))))<>-1 then
        begin
       
        enabled:=true;
        lst1.clear;
       //break;
        end else
       if lst1.indexof(AnsiLowercase(copy(K.CRS_extractfileext(itemcaption),2,length(itemcaption))))<>-1 then 
       begin
       
        enabled:=true;
        lst1.clear;
       //break;
        end;
      end;//for II := 0 to APASSLIST.count - 1 do
      end; //if lst.indexof(hint)>-1 then  
   
      end;//with (temp as timage) do 
      //(temp as Tmenuitem).enabled:=false;
    end; 
  end;


lst.free;
lst1.free;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure Tform2.checkMenuitemCheckFileEXT_DisabledAll(APASSCOMPONENT:TCOMPONENT;APASSLIST:TSTRINGLIST);
var i:integer;Temp: tComponent;lst,lst1:tstringlist;
begin

lst:=tstringlist.create;
lst1:=tstringlist.create;
lst1.CaseSensitive:=false;
inifile.readsection('xfgMenuitemCheckFileEXT',lst);
  for I := 0 to APASSCOMPONENT.Componentcount - 1 do
  begin
 
    Temp := APASSCOMPONENT.Components[I];
    if (temp is Tmenuitem)  then
    begin
    with (temp as Tmenuitem) do 
      begin
     if  APASSCOMPONENT is TPOPUPMENU then
       if trim(AnsiLowercase(inifile.readstring('xfgFileInputMenu',hint,'none')))='%createnew%' then 
           checkMenuitemCheckFileEXT_DisabledAll((temp as Tmenuitem),APASSLIST);
       if  APASSCOMPONENT is Tmenuitem then
      if trim(AnsiLowercase(inifile.readstring((temp as Tmenuitem).parent.hint,hint,'none')))='%createnew%' then 
      checkMenuitemCheckFileEXT_DisabledAll((temp as Tmenuitem),APASSLIST);
         if AnsiLowercase(trim(inifile.readstring('xfgMenuitemCheckFileEXT',hint,'none')))='xfgallext'
       then 
       begin
       if APASSLIST.count> 0 then 
       enabled:=true else
       if APASSLIST.count=0 then enabled:=false;
       continue;
       end;
       if lst.indexof(hint)>-1 then 
       begin
       
         enabled:=false;
    
       
       end; //if lst.indexof(hint)>-1 then  
   
      end;//with (temp as timage) do 
    end; 
  end;


lst.free;
lst1.free;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure Tform2.filelistSelectItem(Sender: TObject; 
                  Item: TIconViewItem; Selected: Boolean);

begin
 
 checkselectdelete;
if (selected =false)then begin
if internallist.indexof(filelist.directory.location+item.caption)<>-1 then
internallist.delete(internallist.indexof(filelist.directory.location+item.caption));

exit;
end;

//if (item.caption='..') then begin internallist.clear;exit;end;
if (item.caption<>'..') then
begin

XFGCurrentDir:=filelist.directory.location;
GIconItem:=item;
if (selected =true)then 
begin
(*****
//listview.ItemFocused:=listview.selected;
listview.selected:=listview.FindCaption(0,item.caption, false, true, true);
//listview.scrollby(0,listview.selected.DisplayRect.top);
listview.FindCaption(0,item.caption, false, true, true).MakeVisible;
****)
if (InfoListViewCurrentDir=filelist.directory.location)and
(filelist.selcount=1) then
listview.selected:=listview.FindCaption(0,item.caption, false, true, true);
if listview.selected<>nil then listview.selected.MakeVisible;

if filelist.selcount>1 then 
begin
if internallist.indexof(filelist.directory.location+item.caption)<>-1 then
internallist.delete(internallist.indexof(filelist.directory.location+item.caption));
internallist.add(filelist.directory.location+item.caption); 
exit;
end;

if filelist.selcount=1 then
begin
internallist.clear;
internallist.add(filelist.directory.location+item.caption); 
exit;
end;

if filelist.selcount=0 then
begin
internallist.clear;exit;
end;

end;
//internallist.savetofile('/0000.popo');


end;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    


procedure Tform2.filelistDirectoryChange(Sender: TObject;
  const NewDir: WideString);
var 
tempstr,s:string;i:integer;lst:tstringlist;
begin
IntoFileListSetDIRChangeInfo:=false;
if not directoryexists(form1.datadir+'/.thumbnailStorage'+form2.filelist.directory.location) 
then forcedirectories(form1.datadir+'/.thumbnailStorage'+form2.filelist.directory.location);
lst:=nil;
lst:=tstringlist.create;

K.NoRECURSESearchDir(form1.datadir+'/.thumbnailStorage'+form2.filelist.directory.location,'*',lst);
for i:=0 to lst.count -1 do
begin
//application.processmessages;
s:=lst[i];
//if fileexists(s)then continue;
if AnsiPos('/',s)=length(s)then delete(s,length(s),1);
if (not directoryexists(form2.filelist.directory.location+copy(s,lastdelimiter('/',s)+1,length(s))+'/'))

then if directoryexists(s+'/')then K.CRS_FileDeleteR(s+'/');
end;
if lst<>nil then
lst.free;
(*
for i:=0 to DirItemCacheLst.count -1 do
begin
//application.processmessages;
if not fileexists(form2.filelist.directory.location+'/'+DirItemCacheLst.Names[i])then
DirItemCacheLst.delete(i);
end;
*)
DirItemCacheLst.savetofile(form1.datadir+'/.thumbnailStorage'+form2.filelist.directory.location+'.xfgdir');
 
tempstr:=( filelist.directory.Location) ;

chdir(form2.filelist.directory.location);


cmb.text:=NewDir;
cmb.items.Insert(0, NewDir); 

popup.items.find(mi8.hint).enabled:=false;
popup.items.find(mi7.hint).enabled:=false;
popup.items.find(mi4.hint).enabled:=true;

if cmb.text=form1.DATADIR+'/.thrash bin/' then 
begin 
popup.items.find(mi8.hint).enabled:=true;
popup.items.find(mi7.hint).enabled:=true;
popup.items.find(mi4.hint).enabled:=false;
 end;

internallist.clear;
XFGCurrentDir:=filelist.directory.location;
 
end;

//////////////////////////////////////////////////////////////////////////////////////////////////  
(*
procedure Tform2.FileIconView1GetImageIndex(Sender: TObject; Item: TIconViewItem);
 begin

end;
//////////////////////////////////////////////////////////////////////////////////////////////////  
*)
procedure Tform2.FileIconView1Changing(Sender: TObject; Item: TIconViewItem; Change: TItemChange; 
var AllowChange: Boolean);

begin

if (item=nil)or (item.caption='')or(Change <>(ctImage))then exit else
begin
(*
if IntoFileListSetDIRChangeInfo=false then
begin
filelist.directory.location:=filelist.directory.location;
filelistDoDoubleClick(filelist.directory.location);

//IntoFileListSetDIRChangeInfo:=true;
exit;
end;
*)





//application.processmessages;


Item.ImageIndex:=DirItemCacheLstINI.readinteger('icon',item.caption,0);

end;
end;

(*****************************  

procedure Tform2.filelistChange(Sender: TObject; Item: TIconViewItem;
  Change: TItemChange);

begin
;
end;
*****************************) 
 //////////////////////////////////////////////////////////////////////////////////////////////////    

//////////////////////////////////////////////////////////////////////////////////////////////////    
     

    procedure Tform2.createimglist;
    var img:tbitmap;i:integer;imgfile:string;
    begin
    if imglist<>nil then imglist.free;imglist:=nil;
    inifile.readsection('xfgFileTypeIconImage',icontypelist);
    imglist:=timagelist.create(self);
    with imglist as timagelist do
    begin
  //  Masked:=false;
  
   Height := (inifile.readinteger('xfgMain','WMIconSize',17))-1;
   Width := (inifile.readinteger('xfgMain','WMIconSize',17))-1;
 
    end;
      img:=tbitmap.create;
    with img as tbitmap do
      begin
  
      for i:=0 to icontypelist.count-1 do
      begin

      imgfile:=inifile.Readstring ('xfgFileTypeIconImage', icontypelist[i], 'none');
      if imgfile='none'then continue;
      //if AnsiPos('%',imgfile)>0 then continue;
      if (fileexists(imgfile))then
      begin
         img.FreePixmap;
         img.LoadFromFile(imgfile);
         imglist.Add(Img, nil);
         
      end;
    end;
    end;
 img.free;
 if filelist<>nil then form2.filelist.Images := form2.imglist;   
 
    end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

    procedure Tform2.createFileIconView;
begin
filelist:=tfileiconview.create(Form2);
filelist.parent:=panel3;
with filelist as tfileiconview do
begin
 
  Left := 0;
    Top := 41;
    Width := form2.width-50;;
    Height := 307;
    align:=alclient;
    BorderStyle := bsEmbossed;
    try
 //  Color := $00E6E6E6 ;
    Color :=  stringtocolor(inifile.Readstring ('xfgMain', 'Filemanager_IconView_BGColor', 'none'));
     //   Font.Color := 4473924;
  Font.Color := stringtocolor(inifile.Readstring ('xfgMain', 'Filemanager_IconView_FGColor', 'none'));
 //   Font.Height := 11;
   Font.Height := strtoint(inifile.Readstring ('xfgMain', 'Filemanager_IconView_FontSize', 'none'));
   //items.ItemWidth:=0;
  //  Font.Name := 'lucida';
    Font.Name := (inifile.Readstring ('xfgMain', 'Filemanager_IconView_FontName', 'none'));
except
Color := $00E6E6E6 ;
Font.Color := 4473924;
Font.Height := 11;
Font.Name := 'lucida';
end;
    //Directory.AutoUpdate := True;
    //filelistDoDoubleClick(GetEnvironmentVariable('HOME'));
    //Directory.Location := '~/';
    //Directory.FileType := [ftHidden, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];
    directory.filetype:=[ftReadOnly, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];

    Directory.FileMask := '*';
    Directory.SortMode := smType;
 //  Directory.SortMode :=  (smAttributes);
  //  DragMode := dmAutomatic;

    Font.Pitch := fpVariable;
  //  Font.Style := [];
 // ownerdraw:=true;
 //Spacing:=5;
  IconOptions.WrapText:=false;
// IconOptions.autoarrange:=false;
    IconOptions.Arrangement := (iaTop);
 Images := imglist;
    MultiSelect := True;
    ParentFont := False;
    ParentShowHint := False;
    PopupMenu := popup;
    ShowHint := True;
 //   TabOrder := 0;
    TextPosition := itpRight;
 //  OnChange := filelistChange;
  OnChanging := FileIconView1Changing;
OnClick := filelistClick;
  //  OnContextPopup := FileIconView1ContextPopup;
  //  OnCustomDrawItem := FileIconView1CustomDrawItem;
  //  OnDblClick := FileIconView1DblClick;
   OnDirectoryChange := filelistDirectoryChange;
   // OnDragDrop := FileIconView1DragDrop;
   // OnDragOver := FileIconView1DragOver;
   
//OnDrawItem:= FileIconView1DrawItem;
 
  //  OnEdited := FileIconView1Edited;
  //  OnEditing := FileIconView1Editing;
  //  OnEndDrag := FileIconView1EndDrag;
//    OnEnter := filelistEnter;
 //  OnExit := filelistExit;
  //  OnFileFound := FileIconView1FileFound;
 // OnGetImageIndex := FileIconView1GetImageIndex;
   OnItemClicked := filelistItemClicked;
  OnItemDoubleClick := filelistItemDoubleClick;
  //OnItemEnter := FileIconView1ItemEnter;//(Sender: TObject; Item: TIconViewItem)
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
//controlstyle:=controlstyle+[csOpaque];
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

  procedure Tform2.createpanel1;
begin
 p1:=tpanel.create(Form2);
p1.parent:=form2;
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

mainPANEL:=tpanel.create(Form2);
mainPANEL.parent:=p1;
with mainPANEL as tpanel do
begin
     Left:= 0;
    Top := 0;
    Width := 100;
    Height := 38;
    Align := alRIGHT;
    borderstyle:=bssingle;
    BevelOuter := bvNone;
    visiblE:=true;
  
end;
PANELcenter:=tpanel.create(Form2);
PANELcenter.parent:=form2;
with PANELcenter as tpanel do
begin
 
   // Width := form2.width-50;
   // Height := 38;
 //  borderwidth:=3;
    Align := alclient;
    borderstyle:=bssingle;
    BevelOuter := bvNone;
    visiblE:=true;
  
end;


PANEL3:=tpanel.create(Form2);
PANEL3.parent:=PANELcenter;
with PANEL3 as tpanel do
begin
 
   // Width := form2.width-50;
   // Height := 38;
    Align := alleft;
    borderstyle:=bsnone;
 //   borderwidth:=3;
    BevelOuter := bvNone;
    visiblE:=true;
  borderwidth:=3;
  color:=form1.color;
end;


end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

    procedure Tform2.createpanel2;
begin
 p2:=tpanel.create(Form2);
p2.parent:=form2;
with p2 as tpanel do
begin
  Left := 0;
    Top := 348;
    Width := 350;
    Height := 38;
    Align := albottom;
      visiblE:=true;
      
cmbPANEL:=tpanel.create(Form2);
cmbPANEL.parent:=p2;
with cmbPANEL as tpanel do
begin
   width:=10;
    Left:= 0;
    Top := 0;
    Height := 38;
    Align := alRIGHT;
    BevelOuter := bvNone;
    visiblE:=true;
  
end;
        cmb:=tcombobox.create(Form2);
    with cmb as tcombobox do 
    begin
    parent:=cmbPANEL;
     Left := 0;
      Top := 6;
      Width := 350;
      Height := 30;
      Font.Color := clBLACK;
      Font.Height := 13;
      Font.Name := 'lucida';
      Font.Pitch := fpVariable;
      Font.Style := [];
      ItemHeight := 30;
      ParentFont := False;
      TabOrder := 0;
      InsertMode:=(ciAfterCurrent);		
DropDownCount:=25;
     Text := '~/';
     MaxItems:=100;
     duplicates:=dupIgnore;
   //  AutoComplete:=true;
     onchange:=cmbonchange;
     OnSelect:=cmbOnSelect; 
     OnHighlighted:=cmbtextchange; 
     
     showhint:=true;
      end;
      
cmbPANEL.width:=cmb.Width+5;
end;
PANEL4:=tpanel.create(Form2);
PANEL4.parent:=PANELcenter;
with PANEL4 as tpanel do
begin
 
   // Width := form2.width-50;
   // Height := 38;
    Align := alclient;
    borderstyle:=bsnone;
    BevelOuter := bvNone;
    visiblE:=true;
  borderwidth:=3;
  color:=form1.color;
end;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

    procedure Tform2.createspeedbutton;
var  mi,sbint,sbinttop,sbintBottom:integer;
l1:tstringlist;
  I: Integer;
  Temp: TComponent;
begin


   sbint:=10;
 l1:=tstringlist.create;
inifile.readsection('xfgFileInputTop',l1);

 for mi := 0 to l1.Count - 1 do 
begin
if mi<>0 then
sbint:=sbint+32+10;
  if AnsiLowercase(l1.Strings[mi])='editor mode' then
  //  if AnsiLowercase(sp.hint)='editor mode' then
    begin
    
    filemodeSP:=TSpeedButton.Create (Form2);
filemodeSP.parent:=mainPANEL;

      filemodeSP.Top := 3;
      filemodeSP.Width := 32;
      filemodeSP.Height := 32;
    //    name:=l1.Strings[mi];
     filemodeSP.Flat := true;
      filemodeSP.Layout := blGlyphTOP;
    filemodeSP.Hint :=l1.Strings[mi];
    
        if fileexists(inifile.Readstring ('xfgFileInputTopImage', l1.Strings[mi], 'none'))then 
     filemodeSP.Glyph.LoadFromFile(inifile.Readstring ('xfgFileInputTopImage', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      filemodeSP.ParentShowHint := False;
      filemodeSP.ShowHint := True;
       filemodeSP.name:='editormode';
      filemodeSP.Spacing := 5;
    filemodeSP.OnClick := spclick;
filemodeSP.visible:=true;
    continue;
    end;
    


  if AnsiLowercase(l1.Strings[mi])<>'editor mode' then   
  begin
sp:=TSpeedButton.Create (Form2);
sp.parent:=p1;

      sp.Top := 3;
      sp.Width := 32;
      sp.Height := 32;
    //    name:=l1.Strings[mi];
     sp.Flat := true;
      sp.Layout := blGlyphTOP;
    sp.Hint :=l1.Strings[mi];
 
 
    
 if AnsiLowercase(sp.hint)='image thumbnail mode' then begin 
 sp.hint:='View image thumbnail';spViewthumbnail:=sp;
 end;

   //   speedbutton.caption:=' ';
    sp.left:=sbint;
     
      if fileexists(inifile.Readstring ('xfgFileInputTopImage', l1.Strings[mi], 'none'))then 
     sp.Glyph.LoadFromFile(inifile.Readstring ('xfgFileInputTopImage', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      sp.ParentShowHint := False;
      sp.ShowHint := True;
    
      sp.Spacing := 5;
      sp.OnClick := spclick;
sp.visible:=true;
//sbint:=sbint+32+10;
end;
end;
l1.clear;


mainPANEL.width:=(32*2)+113+(3*4)+10;

sps:=TSpeedButton.Create (Form2);
sps.parent:=mainPANEL;
with sps as tspeedbutton do
begin
 
      Top :=3;
      Width := 113;
      Height := 32;
       Left := mainPANEL.width-width-5;
      Hint := 'Send files to editor';
      Caption := 'To editor';
      Flat := True;
      Font.Color := 4473924;
      Font.Height := 15;
      ShowHint := True;
      Font.Name := 'sans';
      Layout := blGlyphleft;
      Font.Pitch := fpVariable;
     
             if fileexists(inifile.Readstring ('xfgMainButtonImage','xfgFileInputToEditor', 'none'))then 
 
    sps.Glyph.LoadFromFile(inifile.Readstring ('xfgMainButtonImage', 'xfgFileInputToEditor', 'none'));
    //  Font.Style := []
    onclick:=toeditor;
      end;
 sps:=TSpeedButton.Create (Form2);
sps.parent:=mainPANEL;
with sps as tspeedbutton do
begin
 
      Top :=3;
      Width := 32;
    
      Height := 32;
       Left := mainPANEL.width-width-5-113-3;
      Hint := 'Clear editor';
   //   Caption := 'Clear editor';
      Flat := True;
      Font.Color := 4473924;
      Font.Height := 15;
      ShowHint := True;
      Font.Name := 'sans';
      Layout := blGlyphleft;
      Font.Pitch := fpVariable;
                 if fileexists(inifile.Readstring ('xfgMainButtonImage','button10', 'none'))then 
 
       sps.Glyph.LoadFromFile(inifile.Readstring ('xfgMainButtonImage', 'button10', 'none'));
    //  Font.Style := []
    onclick:=spclick;
    visible:=true;
      end;     

filemodeSP.left:=sps.left-32-8;

sbinttop:=sbint;

////////////////////////////////////////////////////////////////////////////////////////////////////

  sbint:=10;
inifile.readsection('xfgFileInputBottom',l1);

 for mi := 0 to l1.Count - 1 do 
begin
spb:=TSpeedButton.Create (Form2);
spb.parent:=p2;
 spb.left:=sbint;
      spb.Top := 3;
      spb.Width := 32;
      spb.Height := 32;
    spb.Hint :=l1.Strings[mi];
    //  name:=l1.Strings[mi];
   //   speedbutton.caption:=' ';
      spb.Flat := true;
      spb.Layout := blGlyphTOP;
      

           if fileexists(inifile.Readstring ('xfgFileInputBottomImage', l1.Strings[mi], 'none'))
           then 
 
     spb.Glyph.LoadFromFile(inifile.Readstring ('xfgFileInputBottomImage', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      spb.ParentShowHint := False;
      spb.ShowHint := True;
      spb.Spacing := 5;
    spb.OnClick := spclick;
spb.visible:=true;
sbint:=sbint+32+10;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
sbintBottom:=sbint;

 l1.free;
 
if sbintTop>sbintBottom
then form2.Constraints.MinWidth :=sbintTop+mainPANEL.width;
if sbintTop<sbintBottom
then form2.Constraints.MinWidth :=sbintBottom+cmb.width;

form2.Width := form2.Constraints.MinWidth ;
form2.left:=screen.width-form2.Width -10;

  for I := ComponentCount - 1 downto 0 do
  begin
    Temp := Components[I];
     if (Temp is TSpeedbutton) then
     if  not(inifile.valueexists('IndependentComponentPanel',(Temp as tspeedbutton).parent.name))then
     begin
     form1.xfgmemo.lines.add((Temp as tspeedbutton).parent.name);
     if AnsiLowercase((temp as tspeedbutton).hint)='delete'
     then begin deleteSB:=(temp as tspeedbutton);end else
     if AnsiLowercase((temp as tspeedbutton).hint)='copy'
     then begin copySB:=(temp as tspeedbutton);end else
     if AnsiLowercase((temp as tspeedbutton).hint)='create symlink'
     then begin symlinkSB:=(temp as tspeedbutton);end else
     if AnsiLowercase((temp as tspeedbutton).hint)='move'
     then begin moveSB:=(temp as tspeedbutton);end;
     end;
    end;
   // fileOperationSBUpdate(false); 
end;

//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure Tform2.fileOperationSBUpdate(Mode:Boolean);
begin
deleteSB.enabled:=mode;
copySB.enabled:=mode;
symlinkSB.enabled:=mode;
moveSB.enabled:=mode;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
    procedure Tform2.createpopup(sender:TObject);
    var 
    i:integer;
    l:tstringlist;
  mi:tmenuitem;
    imgfile:string;
begin
l:=tstringlist.create;


 inifile.readsection('xfgFileInputMenu',l);

for i:=0 to l.count-1 do
begin
//Select all=%BUILTIN%
//Rename=%BUILTIN%
//Delete=%BUILTIN%
//New directory=%BUILTIN%
//New postscript file=%BUILTIN%

    
if AnsiLowercase(l.strings[i])='select all' then 
begin
mi1:=TMenuItem.create(sender as tpopupmenu);
 with mi1 as TMenuItem do
    begin
   Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgFileInputMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
         OnClick := popupclick;
 (sender as tpopupmenu).items.add(mi1);
 end;
 continue;
end;
(****************************
if AnsiLowercase(l.strings[i])='invert select' then 
begin
mi2:=TMenuItem.create(popup);
 with mi2 as TMenuItem do
    begin
   Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgFileInputMenuImage',l.strings[i],'none');
 if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
     OnClick := popupclick;
 popup.items.add(mi2);
 end;
 //continue;
end;
****************************************)
if AnsiLowercase(l.strings[i])='delete' then 
begin
mi3:=TMenuItem.create((sender as tpopupmenu));
 with mi3 as TMenuItem do
    begin
   Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgFileInputMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
         OnClick := popupclick;
 (sender as tpopupmenu).items.add(mi3);
 end;
 continue;
end;
if AnsiLowercase(l.strings[i])='new directory' then 
begin
mi4:=TMenuItem.create((sender as tpopupmenu));
 with mi4 as TMenuItem do
    begin
   Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgFileInputMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
         OnClick := popupclick;
 (sender as tpopupmenu).items.add(mi4);
 end;
 continue;
end;
if AnsiLowercase(l.strings[i])='new postscript file' then 
begin
mi5:=TMenuItem.create((sender as tpopupmenu));
 with mi5 as TMenuItem do
    begin
   Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgFileInputMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
         OnClick := popupclick;
 (sender as tpopupmenu).items.add(mi5);
 end;
 continue;
end;
  if AnsiPos('---seperator',AnsiLowercase(l.strings[i]))>0 then 
begin
mi6:=TMenuItem.create((sender as tpopupmenu));
 with mi6 as TMenuItem do
    begin
   Caption := '-';
         enabled:=true;
         visible:=true;
 (sender as tpopupmenu).items.add(mi6);
 end;
  continue;
end;

if AnsiLowercase(l.strings[i])='recover trash' then 
begin
mi7:=TMenuItem.create((sender as tpopupmenu));
 with mi7 as TMenuItem do
    begin
   Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgFileInputMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
        
         visible:=true;
         OnClick := InputMenuClick;
 (sender as tpopupmenu).items.add(mi7);
  enabled:=false;
 end;
 continue;
end;
if AnsiLowercase(l.strings[i])='empty trash bin' then 
begin
mi8:=TMenuItem.create(popup);
 with mi8 as TMenuItem do
    begin
   Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgFileInputMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
        
         visible:=true;
         OnClick := InputMenuClick;
 (sender as tpopupmenu).items.add(mi8);
  enabled:=false;
 end;
 continue;
end;

 mi:=TMenuItem.create((sender as tpopupmenu));
   with mi as TMenuItem do
    begin
 
      Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring('xfgFileInputMenuImage',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
         
if (AnsiPos(ansilowercase('%xfgListDirCommand%'),ansilowercase(trim(IniFile.ReadString ('xfgFileInputMenu', l.Strings[i], 'none'))))>0)
   then  begin OnClick:= xfgListDirCommand;  (sender as tpopupmenu).items.add(mi);continue;end; 
         
 if (AnsiPos(ansilowercase('%DoListCustomCommand%'),ansilowercase(trim(IniFile.ReadString ('xfgFileInputMenu',
 l.Strings[i], 'none'))))>0)
   then  begin OnHighlighted:= form1.MenuItemOnHighlighted;  (sender as tpopupmenu).items.add(mi);continue;end; 
        
  if (AnsiPos('%proc%',AnsiLowercase(trim(IniFile.ReadString ('xfgFileInputMenu', l.Strings[i], 'none'))))>0)
   then  begin OnClick := form1.GoToGetProc;   (sender as tpopupmenu).items.add(mi);continue;end;

if (ansipos(ansiLowercase('%proc%'),
ansiLowercase(IniFile.ReadString ('WorkShellFile',l.Strings[i],'none')))<>0)
then begin OnClick := form1.GoToGetProc;  (sender as tpopupmenu).items.add(mi);continue;end;
          
 if AnsiLowercase(l.strings[i])='invert select' 
then begin  OnClick :=popupclick;(sender as tpopupmenu).items.add(mi);continue;end; 

if AnsiLowercase(l.strings[i])='file info'
   then begin  OnClick :=InputMenuClick;(sender as tpopupmenu).items.add(mi);continue;end; 

   if ansipos('%xfgonmytable%',trim(AnsiLowercase(inifile.Readstring ('xfgFileInputMenu', l.Strings[i], 'none'))))>0
    then begin 
    (sender as tpopupmenu).items.add(mi);form1.MyTableCreateMenu(sender as tpopupmenu,mi);continue;end;
       
  if trim(AnsiLowercase(inifile.Readstring ('xfgFileInputMenu', l.Strings[i], 'none')))='%builtin%' 
    then begin OnClick := InputMenuClick;  (sender as tpopupmenu).items.add(mi);continue;end;
     if trim(AnsiLowercase(inifile.Readstring ('xfgFileInputMenu', l.Strings[i], 'none')))='%fileviewfilter%' 
    then begin OnClick := FileViewFilterClick;  (sender as tpopupmenu).items.add(mi);continue;end;
   if trim(AnsiLowercase(inifile.Readstring ('xfgFileInputMenu', l.Strings[i], 'none')))='%createnew%' 
    then begin create_new_menu(l.Strings[i],mi) ;(sender as tpopupmenu).items.add(mi);
    if trim(AnsiLowercase(mi.hint))='rename' then mi2:=mi;continue;end;
    

if(trim(AnsiLowercase(IniFile.ReadString ('xfgMainMenu', l.Strings[i], 'none')))='shell')
   then begin  OnClick :=GoToForm1ShellFiles;(sender as tpopupmenu).items.add(mi);continue;end; 
   
if(trim(AnsiLowercase(IniFile.ReadString ('xfgMainMenu', l.Strings[i], 'none')))='file')
   then   begin  OnClick :=GoToForm1ShellFiles;(sender as tpopupmenu).items.add(mi);continue;end;  
   

if(trim(AnsiLowercase(IniFile.ReadString ('xfgMainMenu', l.Strings[i], 'none')))='shellfile')
   then  begin  OnClick :=GoToForm1ShellFiles;(sender as tpopupmenu).items.add(mi);continue;end;  
   
if trim(AnsiLowercase(inifile.Readstring ('xfgFileInputMenu', l.Strings[i], 'none')))='%menuviewwith%' 
 then begin OnClick := GoToForm1ShellFiles;(sender as tpopupmenu).items.add(mi);continue;end;
 
if (trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu', l.Strings[i], 'none')))='%workshellfile%')
   then  begin  OnClick :=GoToForm1ShellFiles;(sender as tpopupmenu).items.add(mi);continue;end;
     
if AnsiPos('%realtask%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu' ,l.Strings[i], 'none')))))>0 
  then begin
   if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'))then
   bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));  
   OnClick := form1.runMULTITASKcommandCLICK;
   (sender as tpopupmenu).items.add(mi);
   continue;  
   end;      
 
 
   OnClick := POPUPCLICK;
   (sender as tpopupmenu).items.add(mi);
   

    end;     
 

end;
l.free;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.create_new_menu(APASSFromThisMenu:String;APASSParentMenuItem:TMenuItem) ;
var i:integer;imgfile:string;l:tstringlist;mm:TMenuItem;
begin
l:=tstringlist.create;

 inifile.readsection(APASSFromThisMenu,l);
for i:=0 to l.count-1 do
begin

  mm:=TMenuItem.create(APASSParentMenuItem);
   with mm as TMenuItem do
    begin
  if AnsiPos('---seperator',AnsiLowercase(l.strings[i]))>0 then 
   Caption := '-' else
      Caption := l.strings[i];
   Hint := l.strings[i];
   imgfile:=inifile.readstring(APASSFromThisMenu+'Image',l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;    
         


if (AnsiPos(ansilowercase('%xfgListDirCommand%'),ansilowercase(trim(IniFile.ReadString (APASSFromThisMenu,
 l.Strings[i], 'none'))))>0)
   then  begin OnClick:= xfgListDirCommand;  APASSParentMenuItem.add(mm);continue;end; 

if (AnsiPos(ansilowercase('%DoListCustomCommand%'),ansilowercase(trim(IniFile.ReadString (APASSFromThisMenu,
 l.Strings[i], 'none'))))>0)
   then  begin OnHighlighted:= form1.MenuItemOnHighlighted;  APASSParentMenuItem.add(mm);continue;end; 



     if (AnsiPos('%proc%',AnsiLowercase(trim(IniFile.ReadString (APASSFromThisMenu, l.Strings[i], 'none'))))>0)
   then  begin OnClick := form1.GoToGetProc;   APASSParentMenuItem.add(mm);continue;end;

 if (ansipos(ansiLowercase('%proc%'),
ansiLowercase(IniFile.ReadString ('WorkShellFile',l.Strings[i],'none')))<>0)
then begin OnClick := form1.GoToGetProc;   APASSParentMenuItem.add(mm);continue;end;


    if (trim(AnsiLowercase(inifile.Readstring (APASSFromThisMenu, l.Strings[i], 'none')))='%menuviewwith%' )
    then begin OnClick := GoToForm1ShellFiles;APASSParentMenuItem.add(mm);continue;end;
 
  if (trim(AnsiLowercase(inifile.Readstring (APASSFromThisMenu, l.Strings[i], 'none')))='%createnew%' )
    then begin create_new_menu(l.Strings[i],mm);APASSParentMenuItem.add(mm);continue;end;
  if (trim(AnsiLowercase(inifile.Readstring (APASSFromThisMenu, l.Strings[i], 'none')))='%builtin%' )
    then begin OnClick := InputMenuClick;  APASSParentMenuItem.add(mm);continue;end;
  if (trim(AnsiLowercase(inifile.Readstring (APASSFromThisMenu, l.Strings[i], 'none')))='%fileviewfilter%' )
    then begin OnClick := FileViewFilterClick;  APASSParentMenuItem.add(mm);continue;end;
 if (trim(AnsiLowercase(IniFile.ReadString (APASSFromThisMenu, l.Strings[i], 'none')))='%workshellfile%')
   then begin  
   if AnsiPos('%realtask%',(trim(AnsiLowercase(IniFile.ReadString ('WorkShellFile',l.Strings[i], 'none')))))>0 
   then if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'))then
   bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));   
   OnClick :=GoToForm1ShellFiles;
   APASSParentMenuItem.add(mm);
   continue;
   end;  
   
if(trim(AnsiLowercase(IniFile.ReadString ('xfgMainMenu', APASSFromThisMenu, 'none')))='shell')
   then begin   OnClick :=GoToForm1ShellFiles;APASSParentMenuItem.add(mm);continue;end;   
   
if(trim(AnsiLowercase(IniFile.ReadString ('xfgMainMenu', APASSFromThisMenu, 'none')))='file')
   then   begin   OnClick :=GoToForm1ShellFiles;APASSParentMenuItem.add(mm);continue;end;  
   
if(trim(AnsiLowercase(IniFile.ReadString ('xfgMainMenu', APASSFromThisMenu, 'none')))='shellfile')
   then  begin   OnClick :=GoToForm1ShellFiles;APASSParentMenuItem.add(mm);continue;end;
   
if AnsiPos('%realtask%',(trim(AnsiLowercase(IniFile.ReadString (APASSFromThisMenu,l.Strings[i], 'none')))))>0 
  then begin
   if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'))then
   bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));  
   OnClick := form1.runMULTITASKcommandCLICK;
   APASSParentMenuItem.add(mm);
   continue;  
   end;        
  
 //  if (trim(AnsiLowercase(IniFile.ReadString (APASSFromThisMenu, l.Strings[i], 'none')))='none')
  // then begin   OnClick :=POPUPCLICK;APASSParentMenuItem.add(mm);continue;end;;   
  
      OnClick := POPUPCLICK;
     APASSParentMenuItem.add(mm);
    
      end;
   
end;

l.free;
end;


//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    

procedure Tform2.DoPopup(Sender: TObject);
var templst:tstringlist;
begin
try
templst:=tstringlist.create;
templst.assign(internallist);

if ((Sender as tpopupmenu))=popup then 
begin
chdir(getcurrentdir);
checkMenuitemCheckFileEXT_DisabledAll(popup,templst);
checkMenuitemCheckFileEXT(popup,templst);
end;
if ((Sender as tpopupmenu))=fileinfopopup then 
begin
cmb.text:=InfoListViewCurrentDir;
xfgcurrentdir:=InfoListViewCurrentDir;
chdir(InfoListViewCurrentDir);
checkMenuitemCheckFileEXT_DisabledAll(fileinfopopup,templst);
checkMenuitemCheckFileEXT(fileinfopopup,templst);

ListView1Click(listview as tlistview);
fileinfopopup.items.find(mi8.hint).enabled:=false;
fileinfopopup.items.find(mi7.hint).enabled:=false;
fileinfopopup.items.find(mi4.hint).enabled:=true;

if  InfoListViewCurrentDir=form1.DATADIR+'/.thrash bin/' then 
begin 
fileinfopopup.items.find(mi8.hint).enabled:=true;
fileinfopopup.items.find(mi7.hint).enabled:=true;
fileinfopopup.items.find(mi4.hint).enabled:=false;
 end;
 
end;
templst.free;

except
exit;
end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.GoToForm1ShellFiles(Sender: TObject);
var cp,s1,s2,strK:string;APASSLST:TStringlist;
begin
//form1.xfgmemo.text:=internallist.text + 'internallist.text';

APASSLST:=nil;
APASSLST:=Tstringlist.create;
ADor2:=1;
cp:=(sender as tmenuitem ).hint;

(***********************************************************************************************)
 if (trim(AnsiLowercase(inifile.Readstring ('xfgFileInputMenu', cp, 'none')))='%menuviewwith%' )
    then begin s1:=inifile.Readstring ('MenuViewWith',cp, 'none');s2:='MenuViewWith';end else
 if (trim(AnsiLowercase(inifile.Readstring ('xfgFileInputMenu', cp, 'none')))='%workshellfile%' )
    then begin s1:=inifile.Readstring ('WorkShellFile',cp, 'none');s2:='WorkShellFile';end else
    begin
 s2:=(sender as tmenuitem ).parent.hint;
 s1:=(trim(AnsiLowercase(inifile.Readstring (s2,cp, 'none'))));
 end;
(***********************************************************************************************)
if s1='%menuviewwith%' then 
begin s1:=inifile.Readstring ('MenuViewWith',cp, 'none');s2:='MenuViewWith';end;
if s1='%workshellfile%' 
then begin s1:=inifile.Readstring ('WorkShellFile',cp, 'none');s2:='WorkShellFile';end;
(***********************************************************************************************)
if (AnsiPos('%in',trim(AnsiLowercase(IniFile.Readstring (s2,cp, 'none'))))=0)and
(AnsiPos('&in',trim(AnsiLowercase(IniFile.Readstring (s2,cp, 'none'))))= 0) and
(AnsiPos('!in',trim(AnsiLowercase(IniFile.Readstring (s2,cp, 'none'))))= 0) and
(AnsiPos('%realtask%',trim(AnsiLowercase(IniFile.Readstring (s2,cp, 'none')))) = 0)and
(AnsiPos('$in',trim(AnsiLowercase(IniFile.Readstring (s2,cp, 'none'))))= 0) and
(AnsiPos('%vclinternal%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu', cp, 'none')))))= 0) and
(AnsiPos('%dumptovcl%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu', cp, 'none')))))= 0) and
(AnsiPos('%vclexternal%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu', cp, 'none')))))= 0) and
(AnsiPos('vcl',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu', cp, 'none')))))= 0) and
(AnsiPos('%vclinternal%',(trim(AnsiLowercase(IniFile.ReadString (s2, cp, 'none')))))= 0) and
(AnsiPos('%dumptovcl%',(trim(AnsiLowercase(IniFile.ReadString (s2, cp, 'none')))))= 0) and
(AnsiPos('%vclexternal%',(trim(AnsiLowercase(IniFile.ReadString (s2, cp, 'none')))))= 0) and
(AnsiPos('vcl',(trim(AnsiLowercase(IniFile.ReadString (s2, cp, 'none')))))= 0) 
then
begin
//form1.xfgmemo.lines.add('=0');
ADor2:=1;
form1.UserExec(sender as tmenuitem);
form1.show;
form1.CheckStateAfterShellFile(cp);
ADor2:=0;
if APASSLST<>nil then APASSLST.free;
exit;
end; 
(***********************************************************************************************)
if AnsiPos('%realtask%',trim(AnsiLowercase(IniFile.Readstring (s2,cp, 'none')))) > 0 then 
begin
try
ADor2:=1;
if fileexists(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'))then

(Sender as tmenuitem).bitmap.LoadFromFile(IniFile.ReadString ('xfgMainMenuImage','xfgrealtaskrunnow', 'none'));  

form1.runMULTITASKcommandCLICK(sender as tmenuitem);
finally
//if inifile.ValueExists ('xfgFilelistRefresh',cp) then form1.CheckForm2Refresh;
form1.CheckStateAfterShellFile(cp);
ADor2:=0;
if APASSLST<>nil then APASSLST.free;

end;
exit;
end;
(***********************************************************************************************)
if internallist.count=0 then exit;
//if (popup).PopupComponent=filelist then if internallist.count=0 then exit;
//if (popup).PopupComponent=form1.xfgmemo then if xfgmemointernallist.count=0then exit;


(***********************************************************************************************)
if AnsiPos('!in',IniFile.Readstring (s2,cp, 'none')) > 0 then 
begin
 try
 ADor2:=1;
APASSLST.clear;
APASSLST.assign(internallist);
form1.ShellFilesTOCAT(cp,s1,'',1,APASSLST);
//form1.ACreateForm;
//if popup.PopupComponent=filelist then form1.ShellFilesTOCAT(cp,s1,'',1,APASSLST);
//if popup.PopupComponent=form1.xfgmemo then form1.ShellFilesTOCAT(cp,s1,'',1,xfgmemointernallist);


finally
//form1.afreeform;
form1.show;
form1.CheckStateAfterShellFile(cp);
ADor2:=0;
if APASSLST<>nil then APASSLST.free;
end;
exit;
end;
(***********************************************************************************************)

(***********************************************************************************************)
if AnsiPos('%in',IniFile.Readstring (s2,cp, 'none')) > 0 then 
begin
 try
 ADor2:=1;
APASSLST.clear;
APASSLST.assign(internallist);
if s2='MenuViewWith' then
form1.ShellFilesTO('',s1,'',1,APASSLST)
else
form1.ShellFilesTO(cp,s1,'',1,APASSLST);
//form1.ACreateForm;
//if popup.PopupComponent=filelist then form1.ShellFilesTO(cp,s1,'',1,APASSLST);
//if popup.PopupComponent=form1.xfgmemo then form1.ShellFilesTO(cp,s1,'',1,xfgmemointernallist);


finally
//form1.afreeform;
form1.CheckStateAfterShellFile(cp);
ADor2:=0;
if APASSLST<>nil then APASSLST.free;
end;

exit;
end;
(***********************************************************************************************)

if AnsiPos('&in',IniFile.Readstring (s2,cp, 'none')) > 0 then 
begin 
 try
 ADor2:=1;
APASSLST.clear;
APASSLST.assign(internallist);

//form1.ACreateForm;

strK:='{'+StringReplace(IniFile.Readstring (s2,cp, 'none'),'&out','@',[rfIgnoreCase])+'}';
strK:=K.CRS_GetParamAtPos(strK,'{','}','@',2);
if AnsiPos(' ',strk)>0 then 
strk:=copy(strk,1,AnsiPos(' ',strk)-1);
form1.ShellFilesTOSingleFile(cp,s1,'',1,APASSLST);
//if popup.PopupComponent=filelist then form1.ShellFilesTOSingleFile(cp,s1,'',1,APASSLST);
//if popup.PopupComponent=form1.xfgmemo then form1.ShellFilesTOSingleFile(cp,s1,'',1,xfgmemointernallist);

finally
//form1.afreeform;
form1.CheckStateAfterShellFile(cp);
ADor2:=0;
if APASSLST<>nil then APASSLST.free;
end;

exit;
end;
(***********************************************************************************************)

if AnsiPos('$in',IniFile.Readstring (s2,cp, 'none')) > 0 then 
begin
try
ADor2:=1;
APASSLST.clear;
APASSLST.assign(internallist);
if s2='MenuViewWith' then
form1.ShellFilesTOSingleAPPLICATION('',s1,'',1,APASSLST)
else
form1.ShellFilesTOSingleAPPLICATION(cp,s1,'',1,APASSLST);
//form1.ACreateForm;

//if popup.PopupComponent=filelist then form1.ShellFilesTOSingleAPPLICATION(cp,s1,'',1,APASSLST);
//if popup.PopupComponent=form1.xfgmemo then form1.ShellFilesTOSingleAPPLICATION(cp,s1,'',1,xfgmemointernallist);

finally
//form1.afreeform;
form1.CheckStateAfterShellFile(cp);
ADor2:=0;
if APASSLST<>nil then APASSLST.free;
end;
exit;
end;

if APASSLST<>nil then APASSLST.free;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.FileViewFilterClick(Sender: TObject);
var  EXTlist:tstringlist;
i:integer;
begin


if AnsiLowercase(inifile.readstring('FileViewFilter',(sender as tmenuitem).hint,'none'))='all' then 
begin 
extstring:='*';
filelist.directory.filemask:=extstring;
form1.CheckForm2Refresh;
exit; 
end;

EXTlist:=tstringlist.create;

extstring:='';
inifile.readsection(inifile.readstring('FileViewFilter',(sender as tmenuitem).hint,'none'),EXTlist);
for i:=0 to EXTlist.count-1 do
extstring:=extstring+'*.'+EXTlist.strings[i]+';';
filelist.directory.filemask:=AnsiLowercase(extstring);

EXTlist.free;



end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  

procedure Tform2.InputMenuClick (Sender: TObject);
 var i,index:integer;
  outlst:tstringlist;
  ii: Integer;instr,strK,instr2:string;
begin



with Sender as tmenuitem do
begin
if AnsiLowercase((Sender as tmenuitem).hint)='file info' then
begin
listview.bringtofront;
if internallist.count<>0 then
begin
if (filelist.selected<>nil)and 
(directoryexists(form2.filelist.directory.location+filelist.selected.caption))then
begin
listview.items.clear;
DoListViewFileInfo(form2.filelist.directory.location+filelist.selected.caption);
InfoListViewCurrentDir:=form2.filelist.directory.location+filelist.selected.caption+'/';
exit;
end;
end ;
instr2:=form2.filelist.directory.location;
if (InfoListViewCurrentDir=form2.filelist.directory.location)or
 (instr2=form1.DATADIR+'/.thrash bin/')then exit;
listview.items.clear;
DoListViewFileInfo(form2.filelist.directory.location);
InfoListViewCurrentDir:=form2.filelist.directory.location;
if panel3.width> form2.width-100 then panel3.width:=form2.width div 2;
if internallist.count<>0 then
if filelist.selected<>nil then 
begin
listview.selected:=listview.FindCaption(0,filelist.selected.caption, false, true, true);
listview.selected.MakeVisible;
end;


//listview.ItemFocused:=listview.selected;
//listview.selected:=listview.FindCaption(0,filelist.selected.caption, false, true, true);
//listview.scrollby(0,listview.selected.DisplayRect.top);
//listview.FindCaption(0,filelist.selected.caption, false, true, true).MakeVisible;




exit;
end;


if AnsiLowercase((Sender as tmenuitem).hint)='recover trash' then
begin
//filelist.directory.location:=form1.DATADIR+'/.thrash bin';
if SystemBusy=true then
begin
MessageDlg ('System busy ... , so abort.'  +#13#10, mtInformation, [mbOK], 0);
internallist.clear;
exit;
end;

SystemBusy:=true;

if internallist.count=0 then
if MessageDlg ('No trash files selected ', mtConfirmation, [mbOK], 0, mbYes)=mrOK then 
begin
SystemBusy:=false;
exit;
end;
if not (fileexists(form1.DATADIR+'/.thrash bin'+'/.thrashlog')) then
if MessageDlg ('Unable to recover trash files '+#13#10+
               'Please recover trash files manually', mtConfirmation, [mbOK], 0, mbYes)=mrOK then 
begin
SystemBusy:=false;
exit;
end;

if GIconItem=nil then begin SystemBusy:=false;exit;end;
try
ii:=filelist.items.indexof(GIconItem);
if i=filelist.items.count-1 then i:=i-1;
instr:=#13#10;
for i:=0 to internallist.count-1 do
begin
if internallist.strings[i]=form1.DATADIR+'/.thrash bin'+'/.thrashlog' then continue;
if internallist.strings[i]='' then exit;


if fileexists(internallist.strings[i]) then
instr:=instr+internallist.strings[i]+#13#10;
end;

if  MessageDlg ('Are you sure you want to recover these files from trash bin' +#13#10+
    instr, mtConfirmation, [mbYes,mbNo], 0, mbYes)=mrYes then
begin
outlst:=tstringlist.create;
outlst.loadfromfile(form1.DATADIR+'/.thrash bin'+'/.thrashlog');

for i:=0 to internallist.count-1 do
begin 
application.processmessages;
//   NewPage.dvi=/home/user1/NewPage.dvi
//   Names[Index: Integer]
//   IndexOfName(const Name: string)
//   Values[const Name: string]
strK:=ExtractFileName(internallist.strings[i]);
index:=outlst.IndexOfName(strK);
if index <> -1 then
begin
instr:=ExtractFilePath(outlst.Values[strK]);
if (directoryexists(instr))
then
 begin
 
 k.CRS_FileCopyMoveR(1,internallist.strings[i],instr,nil);   
 k.X_CRS_FileDeleteRSingle(internallist.strings[i]);
outlst.delete(index);
end;

end;
end;
(*
RCount:=0;
repeat 
for i:=0 to internallist.count-1 do
begin 

if internallist.strings[i]=form1.DATADIR+'/.thrash bin'+'/.thrashlog' then continue;
if (directoryexists(internallist.strings[i]))or
 (fileexists(internallist.strings[i]))then

for ii:=0 to outlst.count-1 do
begin
strK:='{'+outlst.strings[ii]+'}';
strK:=K.CRS_GetParamAtPos(strK,'{','}','=',1);
if form1.DATADIR+'/.thrash bin/'+strK=internallist.strings[i] then
 begin
if (directoryexists(ExtractFilePath(K.CRS_GetParamAtPos('{'+outlst.strings[ii]+'}','{','}','=',2))))
then
 begin
 k.CRS_FileCopyMoveR(1,internallist.strings[i],
                     ExtractFilePath(K.CRS_GetParamAtPos('{'+outlst.strings[ii]+'}','{','}','=',2)),nil);   
 k.X_CRS_FileDeleteRSingle(internallist.strings[i]);
outlst.delete(ii);
end;
 
RCount:=RCount+1;
break;
end;
end;//for ii:=0 to outlst-count-1 do
end;//for i:=0 to internallist.count-1 do
//i:=i+1;
//if i=internallist.count-1 then i:=0;
//
until RCount=internallist.count;
*)



end;
finally
internallist.clear;
instr2:=form2.filelist.directory.location;
if instr2=form1.DATADIR+'/.thrash bin/'then 
form1.CheckForm2Refresh;
if InfoListViewCurrentDir=form1.DATADIR+'/.thrash bin/'then
DoListViewFileInfo(InfoListViewCurrentDir);
form2.show;
outlst.savetofile(form1.DATADIR+'/.thrash bin'+'/.thrashlog');
outlst.free;
SystemBusy:=false;
end;


end;





if AnsiLowercase((Sender as tmenuitem).hint)='empty trash bin' then
begin



if SystemBusy=true then
begin
MessageDlg ('System busy ... , so abort.'  +#13#10, mtInformation, [mbOK], 0);
exit;
end;



if  MessageDlg ('Are you sure you want to empty all files in trash bin ' +#13#10+#13#10
    , mtConfirmation, [mbYes,mbNo], 0, mbYes)=mrYes then
              begin
   SystemBusy:=true;
   outlst:=nil;
   outlst:=tstringlist.create;
   outlst.clear;
  
try   
//if CRS_CheckIsLink(APASSSource)then
k.NoRECURSESearchDir(form1.DATADIR+'/.thrash bin/', '*',outlst);

for i:=0 to outlst.count-1  do
  begin
//form1.xfgmemo.text:=outlst.text;

//CRS_FileDeleteR(APASSSource:String);
 // for i:=outlst.count-1 downto 0  do
//  begin
    if (outlst[i]=form1.DATADIR+'/.thrash bin/') then continue;
    if (outlst[i]=form1.DATADIR+'/.thrash bin/.') then continue;
    if (outlst[i]=form1.DATADIR+'/.thrash bin/..') then continue;
    if (outlst[i]=form1.DATADIR+'/.thrash bin') then continue;

//  if (outlst[i]=form1.DATADIR+'/.thrash bin/.xfgdir') then continue;
  if (outlst[i]=form1.DATADIR+'/.thrash bin/.thrashlog') then continue; 
 // if not (directoryexists(outlst[i]))then k.crs_deletefile(outlst[i])
 //       else k.crs_rmdir(outlst[i]);
 
 k.CRS_FileDeleteR(outlst[i]);
end;
finally
outlst.clear;
outlst.savetofile(form1.DATADIR+'/.thrash bin/.thrashlog');
outlst.free; 
if ((sender as TMenuitem).GetParentMenu) = fileinfopopup then 
begin
if InfoListViewCurrentDir=form1.DATADIR+'/.thrash bin/'then
DoListViewFileInfo(InfoListViewCurrentDir);
end;
if ((sender as TMenuitem).GetParentMenu) = Popup then form1.CheckForm2Refresh;

SystemBusy:=false;
end;
exit;


end;
end;
end;//with Sender as tmenuitem do






end; 

//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.popupclick(Sender: TObject);
//var item:tmenuitem;
var instr,instr1,strK,senderVCLMethod:string;

i,ii:integer;
l1,outlst:tstringlist;



begin

filelist.readonly:=true;
with Sender as tmenuitem do
begin

strK:='';
instr:='';
instr1:='';
(***********************************************************************************************)
if AnsiLowercase((sender as TMenuitem).hint)='invert select' then
begin
if ((sender as TMenuitem).GetParentMenu) = fileinfopopup then
begin
listview.InvertSelection;
listview.FindCaption(0,'.' ,false, true, true).Selected:=false;
listview.FindCaption(0,'..' ,false, true, true).Selected:=false;
end;
if ((sender as TMenuitem).GetParentMenu) = Popup then
begin
if filelist.selcount<>0 then
begin
l1:=tstringlist.create;
for i:=0 to filelist.items.count-1 do
if filelist.items[i].selected=true then
l1.add(filelist.items[i].caption);

filelist.SelectAll(true);
form2.filelist.FindItemByText('..').Selected:=false;
for i:=0 to l1.count-1 do
begin
form2.filelist.FindItemByText(l1[i]).Selected:=false;
end;
end;//if filelist.selcount<>0 then
end;
l1.free;
exit;
end;
//if Sender=mi1 then  //if caption='Select all' then
if AnsiLowercase((sender as TMenuitem).hint)='select all' then
begin
ii:=0;
if ((sender as TMenuitem).GetParentMenu) = fileinfopopup then
begin
for i:=0 to listview.items.count-1 do
begin
if ii=listview.selcount then break;
if listview.items[i].selected=true
then begin
listview.items[i].selected:=false;
inc(ii);
end;
end;

listview.InvertSelection;
listview.FindCaption(0,'.' ,false, true, true).Selected:=false;
listview.FindCaption(0,'..' ,false, true, true).Selected:=false;
ii:=0;
end;
if ((sender as TMenuitem).GetParentMenu) = Popup then
begin
filelist.SelectAll(true);
form2.filelist.FindItemByText('..').Selected:=false;
end;
exit;
end;
(****************************************************************************************************)

if ((sender as TMenuitem).GetParentMenu) = fileinfopopup then
begin

if (trim(AnsiLowercase((Sender as tmenuitem).hint)) ='refresh') then  
begin
//if internallist.count<>0 then
//begin
//if (filelist.selected<>nil)and 
if (directoryexists(xfgcurrentdir))then
begin
listview.items.clear;
DoListViewFileInfo(xfgcurrentdir);
InfoListViewCurrentDir:=xfgcurrentdir;
XFGCurrentDir:=InfoListViewCurrentDir;
internallist.clear;memo.lines.clear;
if panel3.width> form2.width-100 then panel3.width:=form2.width div 2;
exit;
end;
end;//if (trim(AnsiLowercase((Sender as tmenuitem).hint)) ='refresh') then  


end;//if ((sender as TMenuitem).GetParentMenu) = Popup then
(****************************************************************************************************)
if xfgcurrentdir=form1.DATADIR+'/.thrash bin/'
 then begin  
 MessageDlg ('Can''t work on trash bin directory '  +#13#10+
        'Please choose another destination directory ', mtInformation, [mbOK], 0);
        
exit;
end;
        
(****************************************************************************************************)



if (trim(AnsiLowercase((Sender as tmenuitem).hint)) ='normal') then  
begin
(****************************************************************************************************)
if ((sender as TMenuitem).GetParentMenu) = Popup then
begin
instr:=GIconItem.caption;
if InputQuery('Rename','Rename   '+filelist.directory.location+instr,instr )=true then
begin
if AnsiPos('/',instr)>0 then begin  
 MessageDlg ('Only filename allowed ,'  +#13#10+
        'but directory path found , so abort ', mtInformation, [mbOK], 0);
        
exit;
end;
 filelist.RenameFile(GIconItem,instr);
form1.CheckForm2Refresh;
   try
   filelist.Selected:=filelist.items[filelist.directory.indexof(instr)];
   filelist.EnsureItemVisible(filelist.Selected);
   except
   exit;
   end;
end;
exit;
end;
(****************************************************************************************************)
if ((sender as TMenuitem).GetParentMenu) = fileinfopopup then
begin
instr:=listview.selected.caption;
if InputQuery('Rename','Rename   '+InfoListViewCurrentDir+listview.selected.caption,instr )=true then
begin
if AnsiPos('/',instr)>0 then begin  
 MessageDlg ('Only filename allowed ,'  +#13#10+
        'but directory path found , so abort ', mtInformation, [mbOK], 0);
        
exit;
end;
RenameFile(InfoListViewCurrentDir+listview.selected.caption,instr);
DoListViewFileInfo(InfoListViewCurrentDir);
   try
   listview.Selected:=listview.FindCaption(0,instr,false,true,false);
   listview.Selected.MakeVisible;
   except
   exit;
   end;
end;
exit;
(****************************************************************************************************)
end;//if ((sender as TMenuitem).GetParentMenu) = fileinfopopup then

end;
(****************************************************************************************************)
if AnsiPos('%filenameappend',(trim(AnsiLowercase(inifile.Readstring ((sender as tmenuitem ).parent.hint,
(Sender as tmenuitem).hint, 'none')))))<>0 then
begin
outlst:=tstringlist.create;
K.CRS_FileNameAppend((sender as tmenuitem ).parent.hint,(Sender as tmenuitem).hint,GetCurrentDir,internallist,inifile,outlst);
//form1.CheckForm2Refresh;
form1.showfilelist2(outlst);
outlst.free;
exit;
end;

if (Sender=mi3)or   ////if (Sender as tmenuitem).caption='Delete'then
(AnsiLowercase(trim((Sender as tmenuitem).hint))='delete')then
begin
form1.FileDelete(2,internallist);
internallist.clear;
form2.show;
exit;
(****************************************************************************************************)
end;//if Sender=mi3 then    

(***********************************************************************************************)
//if Sender=mi4 then    //if caption='New directory'then
if AnsiLowercase(trim((Sender as tmenuitem).hint))='new directory'then
begin
instr:='NewDirectory';
if InputQuery('Create new directory', 'Create new directory', instr)=true then
begin
//if form2.FocusedControl=form2.filelist then 
if ((sender as TMenuitem).GetParentMenu) = Popup then
begin
if (filelist.directory.CreateDirectory(instr)=nil)
then  
begin
MessageDlg('Directory already exists or '+#13#10+'Disk access permission error ...'+#13#10, mtInformation, [mbOk], 0);
exit;
end;
form1.CheckForm2Refresh;
filelist.Selected:=filelist.items[filelist.directory.indexof(instr)];
filelist.EnsureItemVisible(filelist.Selected);
exit;
end;
if ((sender as TMenuitem).GetParentMenu) = fileinfopopup then
begin
  {$I-}
  MkDir(InfoListViewCurrentDir+instr);
  if IOResult <> 0 then
  begin
   MessageDlg('Directory already exists or '+#13#10+'Disk access permission error ...'+#13#10, mtInformation, [mbOk], 0);
   exit;
  end;
 {$I+}
 
DoListViewFileInfo(InfoListViewCurrentDir);
listview.Selected:=listview.FindCaption(0,instr,false,true,false);
listview.Selected.MakeVisible;
exit;
end;
end;

end;//if Sender=mi4 then 
(***********************************************************************************************)

if Sender=mi5 then    //   'New postscript file'
begin
exit;
end;
(***********************************************************************************************)
strK:='';
instr:='';
instr1:='';
instr:=(Sender as tmenuitem).hint;
//system.Delete(instr,AnsiPos('&',(Sender as tmenuitem).caption) , 1);
if (AnsiPos('%vclinternal%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu', instr, 'none')))))>0)or
(AnsiPos('%vclexternal%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu',instr, 'none')))))>0)or
(AnsiPos('%dumptovcl%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu',instr, 'none')))))>0)or
(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu',instr, 'none')))='vcl') then 

senderVCLMethod:=(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputMenu', instr, 'none'))));

if (AnsiPos('%vclinternal%',(trim(AnsiLowercase(IniFile.ReadString ((Sender as tmenuitem).parent.hint, instr, 'none')))))>0)or
(AnsiPos('%vclexternal%',(trim(AnsiLowercase(IniFile.ReadString ((Sender as tmenuitem).parent.hint,instr, 'none')))))>0)or
(AnsiPos('%dumptovcl%',(trim(AnsiLowercase(IniFile.ReadString ((Sender as tmenuitem).parent.hint,instr, 'none')))))>0)or
(trim(AnsiLowercase(IniFile.ReadString ((Sender as tmenuitem).parent.hint,instr, 'none')))='vcl') then 

senderVCLMethod:=(trim(AnsiLowercase(IniFile.ReadString ((Sender as tmenuitem).parent.hint, instr, 'none'))));


 instr1:=(sender as tmenuitem ).parent.hint;
 strK:=(trim(AnsiLowercase(inifile.Readstring (instr1,instr, 'none'))));

if (AnsiPos('%vclinternal%',strK)>0) or 
(AnsiPos('%vclexternal%',strK)>0) or 
(AnsiPos('%dumptovcl%',strK)>0) or 
(strK='vcl') then 
senderVCLMethod:=(trim(AnsiLowercase(IniFile.ReadString (instr1, instr, 'none'))));

if senderVCLMethod<>'' then
begin
//form2.caption:='aaaa         =  '+senderVCLMethod+'     sssssssssss =  '+instr;
form1.APASSUserExecVCL(instr,senderVCLMethod,internallist);
exit;
end;



(***********************************************************************************************)
GoToForm1ShellFiles(sender as tmenuitem);
(***********************************************************************************************)


end;//with Sender as tmenuitem do 

//filelist.readonly:=false;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////   
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.rowup(APASSFORM:TFORM);

begin
APASSFORM.show;

begin
if (APASSFORM.left>screen.width/2) or (APASSFORM.top>100)then     
begin
repeat
APASSFORM.left:=APASSFORM.left-50;
until APASSFORM.left<50;
APASSFORM.left:=0;
if APASSFORM.top+APASSFORM.height+20>screen.height then APASSFORM.top:=0;
APASSFORM.show;
exit;
end;

if(APASSFORM.left+APASSFORM.width<screen.width) and not (APASSFORM.width<screen.width-20) or 
(APASSFORM.top>100)then     
begin
repeat
APASSFORM.left:=APASSFORM.left+50;
until APASSFORM.left+APASSFORM.width>screen.width;
APASSFORM.left:=0;
if APASSFORM.top+APASSFORM.height+20>screen.height then APASSFORM.top:=0;
APASSFORM.show;
exit;
end;
if (APASSFORM.left<screen.width/2)then 
APASSFORM.show;
(****************************
if (APASSFORM.left<screen.width/2)then 
begin
repeat
APASSFORM.left:=APASSFORM.left+50;
until APASSFORM.left>=screen.width;
APASSFORM.left:=screen.width-50;
if APASSFORM.top+APASSFORM.height+20>screen.height then APASSFORM.top:=20;
APASSFORM.show;
exit;
end;
********)
end;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////   
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure Tform2.spclick(Sender: TObject); 
  var i:integer;senderVCLMethod,tempstr:string;
  
 listviewtrue:boolean;
begin

with sender as tspeedbutton do
begin
/////////////////////////////////////////////////////////////////////////////////////////////////////
if (AnsiPos('%vclinternal%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputBottom', hint, 'none')))))>0)or
(AnsiPos('%vclexternal%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputBottom',hint, 'none')))))>0)or
(AnsiPos('%dumptovcl%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputBottom',hint, 'none')))))>0)or
(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputBottom',hint, 'none')))='vcl')then 
begin 
senderVCLMethod:=(trim((IniFile.ReadString ('xfgFileInputBottom', hint, 'none'))));
form1.APASSUserExecVCL(hint,senderVCLMethod,internallist);
exit;
end;
if (AnsiPos('%vclinternal%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputTop', hint, 'none')))))>0)or
(AnsiPos('%vclexternal%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputTop',hint, 'none')))))>0)or
(AnsiPos('%dumptovcl%',(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputTop',hint, 'none')))))>0)or
(trim(AnsiLowercase(IniFile.ReadString ('xfgFileInputTop',hint, 'none')))='vcl')    then 
begin 
senderVCLMethod:=(trim((IniFile.ReadString ('xfgFileInputTop', hint, 'none'))));
form1.APASSUserExecVCL(hint,senderVCLMethod,internallist);
exit;
end;

if AnsiLowercase(hint)='view image thumbnail' then begin
(sender as tspeedbutton).enabled:=false;


internallist.clear;memo.lines.clear;
form3.show;
//form3.drawThumbnail;
ThumbnailCurrentPath:=xfgcurrentdir;
form1.RUN_drawThumbnail_TASK(xfgcurrentdir);


// (sender as tspeedbutton).enabled:=true;
 

end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
if AnsiLowercase(hint)='delete' then mi3.onclick((mi3 as tmenuitem));
//////////////////////////////////////////////////////////////////////////////////////////////////////
if (AnsiLowercase(hint)='copy') or(AnsiLowercase(hint)='create symlink')or(AnsiLowercase(hint)='move') then 
begin
if internallist.count=0 then 
begin
exit;
end;
listviewtrue:=false;
if form2.FocusedControl=(ListView)then listviewtrue:=true;
//if form2.xfgcurrentdir=InfoListViewCurrentDir then listviewtrue:=true;
if listviewtrue=true then
begin
form2.ActiveControl:=(filelist);
form2.xfgcurrentdir:=filelist.directory.location;
chdir(filelist.directory.location);
end else
begin
form2.ActiveControl:=(ListView);
form2.xfgcurrentdir:=InfoListViewCurrentDir;
chdir(InfoListViewCurrentDir);
end;

if (AnsiLowercase(hint)='copy')then
begin
form1.FileCopyMove(1,2,internallist);
end;
if AnsiLowercase(hint)='create symlink' then 
begin
form1.FileCopyMove(3,2,internallist);
end;
if AnsiLowercase(hint)='move' then 
begin
form1.FileCopyMove(2,2,internallist);

end;
fileOperationSBUpdate(false);
if listviewtrue=true then 
begin
for i:=0 to listview.items.count-1 do
if listview.items[i].selected=true then
listview.items[i].selected:=false;
end else
begin
filelist.selected:=nil;
end;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////////

if AnsiLowercase(hint)='up' then 
begin 
//listview.bringtofront;
filelist.bringtofront;
if form2.FocusedControl=form2.filelist then 
begin
if form2.filelist.directory.location='/' then exit;
tempstr:=filelist.directory.location;
delete(tempstr,length(tempstr),1);
//
//filelist.directory.location:=leftstr(tempstr,lastdelimiter('/',tempstr));

filelistDoDoubleClick(leftstr(tempstr,lastdelimiter('/',tempstr)));filelist.GoUp;
// filelist.directory.location:=K.RS_Calling_UserHOMEDIR;
end;
if form2.FocusedControl=form2.listview then 
begin
if form2.xfgcurrentdir='/' then exit;
tempstr:=form2.xfgcurrentdir;
delete(tempstr,length(tempstr),1);
form2.DoListViewFileInfo(leftstr(tempstr,lastdelimiter('/',tempstr)));
end;
if form2.FocusedControl<>(ListView)then
begin
fileOperationSBUpdate(false);
internallist.clear;
memo.lines.clear;
end;
end;
if AnsiLowercase(hint)='home' then 
begin 
//listview.bringtofront;
filelist.bringtofront;
if form2.FocusedControl=form2.listview then 
DoListViewFileInfo(K.RS_Calling_UserHOMEDIR) else
begin
filelistDoDoubleClick(K.RS_Calling_UserHOMEDIR);
 filelist.directory.location:=K.RS_Calling_UserHOMEDIR;
 end;
if form2.FocusedControl<>(ListView)then
begin
internallist.clear;
memo.lines.clear;
fileOperationSBUpdate(false);
end;
 end;
if AnsiLowercase(hint)='shows hidden files' then begin 
//listview.bringtofront;
filelist.bringtofront;
filelist.directory.filetype:=[ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];
filelist.directory.filemask:=AnsiLowercase(extstring) ;//form1.CheckForm2Refresh;
if form2.FocusedControl<>(ListView)then
begin
internallist.clear;memo.lines.clear;
end;
end;
if AnsiLowercase(hint)='don''t show hidden files' then  begin 
filelist.directory.filetype:=[ftReadOnly, ftSystem, ftVolumeID, ftDirectory, ftArchive, ftNormal];
filelist.directory.filemask:=AnsiLowercase(extstring) ;
filelist.bringtofront;
//listview.bringtofront;
if form2.FocusedControl<>(ListView)then
begin
internallist.clear;memo.lines.clear;
fileOperationSBUpdate(false);
end;
end;

if (AnsiLowercase(hint)='shift to bottom') or( AnsiLowercase(hint)='shift to view')then begin
form2.left:=screen.width-form2.width-10;
if (alreadyUP=true) or (form2.top=screen.height-form2.height-50)then begin form2.top:=screen.height-120;alreadyUP:=false;hint:='Shift to view';exit;end;
if (alreadyUP=false) or (form2.top=screen.height-120)then begin form2.top:=screen.height-form2.height-50;alreadyUP:=true;hint:='Shift to bottom';exit;end;
if AnsiLowercase(Caption )= 'to editor' then ;
end;
if AnsiLowercase(hint )= 'show trash bin' then begin
filelist.bringtofront;
listview.bringtofront;
filelistDoDoubleClick(form1.DATADIR+'/.thrash bin');
filelist.directory.location:=form1.DATADIR+'/.thrash bin';




//IncludeParentDir
end;  
if (AnsiLowercase(hint )= 'xfg')or (AnsiLowercase(hint )= 'hide xfg') then 
begin
form1.show;
rowup(form1);
(****
if form1.visible=false then begin form1.show;hint:= 'Hide XFG';exit;end;
if form1.visible=true then begin form1.hide;hint:= 'Show XFG';exit;end;
****)
end;  
if AnsiLowercase(hint )= 'show memo' then begin
(memo as tcomponent).bringtofront;
memo.lines.add(internallist.text);
memo.setfocus;
end;  
if AnsiLowercase(hint )= 'show file commander' then begin
filelist.bringtofront;
filelist.setfocus;
//listview.bringtofront;
end;  
if AnsiLowercase(hint )= 'show file list view' then begin
//filelist.bringtofront;
listview.bringtofront;
//if listview.width<(form2.width div 3) then listview.width:=form2.width div 2;
listview.setfocus;
end;  
if AnsiLowercase(hint)='clear editor' then 
//form1.xfgmemo.lines.clear;
form1.button10.click;
if (AnsiLowercase(hint )= 'show thumbview window')or (AnsiLowercase(hint )= 'hide thumbview window') then begin
//if form3.visible=false then begin form3.show;hint:= 'Hide thumbview window';exit;end;
//if form3.visible=true then begin form3.hide;hint:= 'Show thumbview window';exit;end;
form3.show;
end;  

if (AnsiLowercase(hint )= 'show imageview window')or (AnsiLowercase(hint )= 'hide imageview window') then begin
//if form4.visible=false then begin form4.show;hint:= 'Hide imageview window';exit;end;
//if form4.visible=true then begin form4.hide;hint:= 'Show imageview window';exit;end;
form4.show;
end;  
if AnsiLowercase(hint)='default resize' then 
begin

   form2. Width := form2.Constraints.MinWidth ;
   form2.Height := form2.Constraints.MinHeight ;
   form2.Left :=screen.width-form2.Constraints.MinWidth-10;
   form2.Top :=screen.height-form2.Constraints.MinHeight-50;
end;
if AnsiLowercase(hint)='refresh' then 
begin 
filelist.bringtofront;
//form1.CheckForm2Refresh;
form1.CheckForm2Refresh;
internallist.clear;memo.lines.clear;
fileOperationSBUpdate(false);
end;

if AnsiLowercase(name)= 'editormode' then begin

//if AnsiLowercase(hint )= 'editor mode' then begin
if form1.checkbox1.checked=true then 
begin form1.checkbox1.checked:=false ;
//(sender as tspeedbutton).hint:='Editor file list mode OFF';
(sender as tspeedbutton).Glyph.FreePixmap;
(sender as tspeedbutton).Glyph.LoadFromFile(form1.xfgimagedir+'/folder_blue.png');
(sender as tspeedbutton).hint:='Editor mode enabled';
end
else
begin
form1.checkbox1.checked:=true ;
//(sender as tspeedbutton).hint:='Editor file list mode ON';
(sender as tspeedbutton).Glyph.FreePixmap;
(sender as tspeedbutton).Glyph.LoadFromFile(form1.xfgimagedir+'/folder_blue_open.png');
(sender as tspeedbutton).hint:='File list mode enabled';
end;

end;
//if AnsiLowercase((sender as tspeedbutton).name)= 'imagethumbnailmodeSP' then begin

end;

end;




end.



