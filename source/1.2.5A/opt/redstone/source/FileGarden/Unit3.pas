 
unit Unit3;

interface

uses
Qt,types,

QGraphics,libc,Qtypes,QFileCtrls ,SysUtils, Classes, qControls, qForms, qDialogs,  QStdCtrls,PClass_Command_RedStone,
  qExtCtrls, QButtons,QComCtrls;

type

///////////////////////////////////////////////////////////////////////////////////////////
  TForm3 = class(TForm)

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
 
     procedure FormDestroy(Sender: TObject);
     
    procedure ImageThumbOnClick(Sender: TObject);
    procedure ImageThumbOnDoubleClick(Sender: TObject);
 procedure ImageThumbMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

   private
      thumbsize:integer;
  iconthumbDELETElist:tstringlist;
   
    { Private declarations }
   CanWorkOnThumbnail:boolean;
    spb,sp,sps:tspeedbutton;
    K:TPClass_Command_RedStone;
    DOSelectALL:boolean;
    p2:tpanel;
 //   thumbnailimage:timage;

  
  
 
 scrollbox:tscrollbox;
    ThumbnailSelectList:tstringlist;
sbSelectALL,sbCOPY,sbMOVE,sbDELETE:tspeedbutton;
  
   procedure CheckSpeedButtonEnabled; 
    procedure spclick(Sender: TObject); 
     function checkFilesSelected:BOOLEAN;
  public
    { Public declarations }
  
  thumbPanel:tpanel;
  
 spp:tspeedbutton; 
  procedure IMAGEcaculateINFO;
    procedure drawThumbnail(APASSLocation:string);
 
  
  end;

var
  Form3: TForm3;
  iconthumblist,iconthumblistOriginal:tstringlist; 
  iconthumblistOriginalConvert,iconthumblistDATAINFO:tstringlist;
implementation



{$R *.xfm}
uses Unit1,Unit2,Unit4;

//////////////////////////////////////////////////////////////////////////////////
procedure TForm3.CheckSpeedButtonEnabled;
begin
if ThumbnailSelectList<>NIL then begin
if ThumbnailSelectList.count=0 then 
begin
if sbCOPY<>nil then sbCOPY.enabled:=false;
if sbMOVE<>nil then sbMOVE.enabled:=false;
if sbDELETE<>nil then sbDELETE.enabled:=false;
if sbSelectALL<>nil then sbSelectALL.enabled:=true;
end else 
if ThumbnailSelectList.count>0 then 
begin
if sbCOPY<>nil then sbCOPY.enabled:=true;
if sbMOVE<>nil then sbMOVE.enabled:=true;
if sbDELETE<>nil then sbDELETE.enabled:=true;
if sbSelectALL<>nil then sbSelectALL.enabled:=true;
end
end;

if ThumbnailSelectList=NIL then begin
if sbCOPY<>nil then sbCOPY.enabled:=false;
if sbMOVE<>nil then sbMOVE.enabled:=false;
if sbDELETE<>nil then sbDELETE.enabled:=false;
if sbSelectALL<>nil then sbSelectALL.enabled:=false;

end;


end;
////////////////////////////////////////////////////////////////////////////////
procedure TForm3.ImageThumbMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var ss,ss1,imgfile:string;BB:tbitmap;
begin

  if button=mbRight then
  begin
 
 if fileexists(form1.DATADIR+'/@@@@@@@@@@@@@@@@@@@@redstone@@@.jpg') 
    then deletefile(form1.DATADIR+'/@@@@@@@@@@@@@@@@@@@@redstone@@@.jpg');   

//if AnsiLowercase((sender as timage).hint) = 'broken image file' then 
(*************************************
if AnsiPos('broken image file',AnsiLowercase((sender as timage).hint))>0 then
begin
ss1:=StringReplace((sender as timage).hint,#13#10,'=',[rfIgnoreCase]) ;
 ss1:='{'+ss1+'}';
  ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',1);
end;

if AnsiPos('broken image file',AnsiLowercase((sender as timage).hint))=0 then
begin
ss1:=StringReplace((sender as timage).hint,#13#10,'=',[rfIgnoreCase]) ;
  ss1:='{'+ss1+'}';
  ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',1);
end;  
*************************************)
(****** 
for ii:=0 to iconthumblistOriginal.count-1 do
begin

if ss=iconthumblistOriginal.strings[ii] then
begin
ss1:=iconthumblistOriginal.strings[ii] ;
ss:=iconthumblistOriginalConvert.strings[ii];
form4.caption:=ss1;
break;
end;

end;  
*****)
//actualSIZE:=true;
//if actualSIZE=true then
//begin

ss1:=StringReplace((sender as timage).hint,#13#10,'=',[rfIgnoreCase]) ;
  ss1:='{'+ss1+'}';
  ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',1);
  
form4.caption:=(k.CRS_GetParamAtPos('{'+
    iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(ss)]+
            '}','{','}','=',1));
imgfile:=(k.CRS_GetParamAtPos('{'+
    iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(ss)]+
            '}','{','}','=',6));
  
form4.show;
      BB:=tbitmap.create;
  BB.loadfromfile(imgfile);

      if form4.FullImage=True then
      begin
      form4.image1.align:=alclient;
           if (BB.width>form4.image1.width)or(BB.height>form4.image1.height)then
           begin
        
       form4.image1.align:=alnone;
        form4.image1.AutoSize:=true;
        form4.image1.Stretch:=false;
        form4.image1.center:=true;
  form4.image1.picture.bitmap.FreePixmap;
      end else
            begin
       
       form4.image1.align:=alclient;
        form4.image1.AutoSize:=false;
        form4.image1.Stretch:=false;
        form4.image1.center:=true;
  form4.image1.picture.bitmap.FreePixmap;
      end ;
     form4.image1.picture.assign(BB);  
        form4. EnableAutoRange; 
     end else
       begin
   
     form4.image1.align:=alclient;
        form4.image1.AutoSize:=false;
        form4.image1.Stretch:=false;
        form4.image1.center:=true;
  // form4.image1.top:=0;
  // form4.image1.left:=0;
  form4.image1.picture.bitmap.FreePixmap; 
      


          if (BB.width>form4.image1.width)or(BB.height>form4.image1.height)then
  form4.DisplayBitmap(BB,form4.image1) else form4.image1.Picture.assign(BB);
BB.free;
   end;
//end;
// if actualSIZE=false th-en
//begin
// form4.show;

  
 // form4.image1.picture.bitmap.FreePixmap;
//  form4.image1.picture.bitmap.loadfromfile(ss);
  

//end;
{
    bmp:=tbitmap.create;
   try
      form4.caption:=ss;    
   bmp.loadfromfile(ss);
    form4.image1.picture.loadfromfile(ss);
    except
   on EInvalidGraphic : Exception do
    begin
libc.system(pchar('/usr/bin/convert '+ss+' '+form1.DATADIR+'/@@@@@@@@@@@@@@@@@@@@redstone@@@.jpg'));
if not fileexists(form1.DATADIR+'/@@@@@@@@@@@@@@@@@@@@redstone@@@.jpg') 
    then ss:=form1.IMAGEDIR+'/'+'file_broken-48.png';
 if fileexists(form1.DATADIR+'/@@@@@@@@@@@@@@@@@@@@redstone@@@.jpg') 
    then ss:=form1.DATADIR+'/@@@@@@@@@@@@@@@@@@@@redstone@@@.jpg';   
     bmp.loadfromfile(ss);
  form4.image1.picture.loadfromfile(ss);
    end;//on EInvalidGraphic : Exception do
 end;//try
}
{
  form4.image1.align:=alclient;form4.image1.center:=true;
   if form4.image1.picture.width>350 then begin 
   form4.image1.align:=alnone;form4.image1.center:=false ; end;
     if form4.image1.picture.height>400 then begin 
   form4.image1.align:=alnone;form4.image1.center:=false;   end;   
 }  
 // bmp.free;
 


  end;
 
end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TForm3.ImageThumbOnClick(Sender: TObject);
var ss,ss1,PASShint:string;foundequal:boolean;

begin
{
 if thumbImageSelected=false then begin
    (sender as timage).Canvas.Brush.Color := clblue;
    (sender as timage).Canvas.Brush.Style := bsDiagCross;
  (sender as timage).Canvas.FillRect(Rect(0,0,(sender as timage).width,(sender as timage).height));
      thumbImageSelected:=true; exit;end;
   if thumbImageSelected=true then begin
   (sender as timage).picture.bitmap.FreePixmap;
(sender as timage).picture.loadfromfile(iconthumblistOriginal.strings[iconthumblistINDEX]);

      thumbImageSelected:=false; end;
      
}
;
//sbCOPY,sbMOVE,sbDELETE:
if CanWorkOnThumbnail=false then exit;

foundequal:=false;
with (sender as timage) do
begin

PASShint:=(sender as timage).hint;
//if AnsiLowercase((sender as timage).hint) = 'broken image file' then 
//            PASShint:=form1.IMAGEDIR+'/'+'file_broken-48.png'+#13#10+'xxxxxxx ';
 
(***************************************************
if AnsiPos('broken image file',AnsiLowercase((sender as timage).hint))>0 then
begin
ss1:=StringReplace((sender as timage).hint,#13#10,'=',[rfIgnoreCase]) ;
 ss1:='{'+ss1+'}';
  ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',2);
end;           
if AnsiPos('broken image file',AnsiLowercase(PASShint)) =0 then
begin
//   PASShint:=form1.IMAGEDIR+'/'+'file_broken-48.png'+#13#10+'xxxxxxx ';

ss1:=StringReplace(PASShint,#13#10,'=',[rfIgnoreCase]) ;
ss1:='{'+ss1+'}';
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',1);
end; 
**************************************************)

ss1:=StringReplace(PASShint,#13#10,'=',[rfIgnoreCase]) ;
ss1:='{'+ss1+'}';
ss:=k.CRS_GetParamAtPos(ss1,'{','}','=',1);

if ThumbnailSelectList.indexof(ss)>-1 then
begin
foundequal:=true;
picture.bitmap.FreePixmap;
picture.bitmap.loadfromfile(k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[iconthumblistDATAINFO.indexofname(ss)]+'}',
                                       '{','}','=',2));
ThumbnailSelectList.delete(ThumbnailSelectList.indexof(ss));                                       
CheckSpeedButtonEnabled;
exit;
end;
(*********************************************
for i:=0 to ThumbnailSelectList.count-1 do
begin
// application.processmessages;   
if ss=ThumbnailSelectList.strings[i] then 
begin 
foundequal:=true;
picture.bitmap.FreePixmap;
for ii:=0 to iconthumblistOriginal.count-1 do
begin
if ThumbnailSelectList.strings[i]=iconthumblistOriginal.strings[ii] then
begin
picture.bitmap.FreePixmap;
//picture.loadfromfile(iconthumblist.strings[ii]);
picture.bitmap.loadfromfile(iconthumblist.strings[ii]);
end;
end;
ThumbnailSelectList.delete(i);
//ThumbnailSelectList.savetofile(form1.DATADIR+'/iconthumbSelectList.lst');
 CheckSpeedButtonEnabled;
exit;
end;
end;
********************************************)
if foundequal=false then 
begin 

 ThumbnailSelectList.add(ss);
// (sender as timage).transparent:=true;
// (sender as timage).transparent:=false;
 //(sender as timage).picture.bitmap.transparentcolor:=clwhite;
// (sender as timage).Canvas.CopyMode := cmWhiteness;
//    ARect := Rect(0, 0, thumbsize, thumbsize);
//    (sender as timage).Canvas.CopyRect(ARect, (sender as timage).Canvas, ARect);    
//    (sender as timage).Canvas.CopyMode := cmSrcCopy; { restore the copy mode }
 (sender as timage).Canvas.Brush.Color := clblue;
 (sender as timage).Canvas.Brush.Style := bsDiagCross;
 (sender as timage).Canvas.FillRect(Rect(0,0,(sender as timage).width,(sender as timage).height));
// ThumbnailSelectList.savetofile(form1.DATADIR+'/iconthumbSelectList.lst');
 
 CheckSpeedButtonEnabled;
           
exit;
end;


end;//with (sender as timage) do


end;

////////////////////////////////////////////////////////////////////////////////
procedure TForm3.IMAGEcaculateINFO;
var TEMPbmp:tbitmap;
Temp: TControl;i,APASSINDEX:integer;
begin

//(**********************************************************************************************
 MT_IMAGE_GET_INFO_TASK_RUNNING:=true; 
   TEMPbmp:=tbitmap.create;
  for I := 0 to thumbPanel.ControlCount - 1 do
  begin
    application.processmessages; 
  if MT_IMAGE_GET_INFO_TASK_RUNNING=false then break;
 
    Temp := thumbPanel.Controls[I];
    if (temp is TIMAGE)  then
    begin
    with (temp as timage) do 
      begin
       //  if AnsiPos('broken image file',AnsiLowercase(hint)) >0 then continue;
       //  if AnsiPos('broken image file',AnsiLowercase(hint)) =0 then
       if hint<>'' then
          begin
         APASSINDEX:=iconthumblistDATAINFO.IndexOfName(k.CRS_GetParamAtPos('{'+StringReplace(hint,#13#10,
                                                           '=',[rfIgnoreCase])+'}','{','}','=',1));
          If APASSINDEX=-1 then continue;
          If APASSINDEX>-1 then
          begin
 //         TEMPbmp.FreePixmap;
 //         TEMPbmp.loadfromfile(k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[APASSINDEX]+'}',
 //                                                      '{','}','=',2));
          if MT_IMAGE_GET_INFO_TASK_RUNNING=false then break;
//,NEWfilesize
//          NEWfilesize:=k.crs_getfilesize(k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[APASSINDEX]+'}',
//                                                       '{','}','=',1));
      if k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[APASSINDEX]+'}','{','}','=',2)=form1.IMAGEDIR+'/'+'file_broken-48.png'
         then (temp as timage).hint:=k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[APASSINDEX]+'}','{','}','=',1)+#13#10+
                             ' Broken image file' else                                                 
        (temp as timage).hint:=k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[APASSINDEX]+'}','{','}','=',1)+#13#10+
                 '    width : '+(k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[APASSINDEX]+'}','{','}','=',5))+' pixels'+#13#10+
                     '   height : '+(k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[APASSINDEX]+'}','{','}','=',4))+' pixels'; 
          end;//If APASSINDEX>-1 then
          end; 
      end;//with (temp as timage) do 
    end; 
  end;
  
TEMPbmp.free;
MT_IMAGE_GET_INFO_TASK_RUNNING:=false;
//***************************************************************************************************)
end;

//////////////////////////////////////////////////////////////////////////////////////////////////    

////////////////////////////////////////////////////////////////////////////////

procedure TForm3.ImageThumbOnDoubleClick(Sender: TObject);
 var Temp: TControl;i:integer;ss:string;
 
begin
//form3.caption:='ccccccccccccccccccccccccccc';
//(sender as timage).onclick(sender);
//  ss1:=StringReplace((sender as timage).hint,#13#10,'=',[rfIgnoreCase]) ;
//  ss1:='{'+ss1+'}';
//  NotThis:=k.CRS_GetParamAtPos(ss1,'{','}','=',1);
 if CanWorkOnThumbnail=false then exit; 
 CanWorkOnThumbnail:=false;
if sbCOPY<>nil then sbCOPY.enabled:=false;
if sbMOVE<>nil then sbMOVE.enabled:=false;
if sbDELETE<>nil then sbDELETE.enabled:=false;
if sbSelectALL<>nil then sbSelectALL.enabled:=false;

//bmp2:=tbitmap.create;
//bmp2.height:=thumbsize;
//bmp2.width:=thumbsize;


  for I := 0 to thumbPanel.ControlCount - 1 do
  begin
 application.processmessages; 
    Temp := thumbPanel.Controls[I];
    if (temp is TIMAGE)  then
    begin
    
        // PASShint:=hint;
         (*************************************************
           if AnsiPos('broken image file',AnsiLowercase(hint)) >0 then 
          begin 
      //    ss1:=StringReplace(hint,#13#10,'=',[rfIgnoreCase]) ;
       //   ss1:='{'+StringReplace(hint,#13#10,'=',[rfIgnoreCase])+'}';
          ss:=trim(k.CRS_GetParamAtPos('{'+StringReplace(hint,#13#10,'=',[rfIgnoreCase])+'}','{','}','=',2));
          end;
          if AnsiPos('broken image file',AnsiLowercase(hint)) =0 then
          begin
      //   ss1:=StringReplace(hint,#13#10,'=',[rfIgnoreCase]) ;
       //   ss1:='{'+StringReplace(hint,#13#10,'=',[rfIgnoreCase])+'}';
          ss:=k.CRS_GetParamAtPos('{'+StringReplace(hint,#13#10,'=',[rfIgnoreCase])+'}','{','}','=',1);
          end; 
          *************************************************)
          ss:=k.CRS_GetParamAtPos('{'+StringReplace((temp as timage).hint,#13#10,'=',[rfIgnoreCase])+'}','{','}','=',1);
    
           if ThumbnailSelectList.indexof(ss)>-1 then
  
         begin
         
     
          (temp as timage).picture.bitmap.FreePixmap;
          (temp as timage).picture.bitmap.loadfromfile(k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(ss)]+'}',
                                       '{','}','=',2));
            //   
            //  iconthumblist.strings[iconthumblistOriginal.indexof(ss)]);
         

         // bmp2.canvas.assign(Picture.bitmap.canvas);
           //  picture.bitmap.FreePixmap;
        //   ARect := Rect(0, 0, thumbsize, thumbsize);
          //  bmp2.Canvas.CopyMode := cmSrcCopy;
          //  bmp2.Canvas.CopyRect(ARect, picture.bitmap.Canvas, ARect);   
          //      picture.bitmap.Canvas.CopyMode := cmSrcCopy;
  //  ARect := Rect(0, 0, thumbsize, thumbsize);
  //  picture.bitmap.Canvas.CopyRect(ARect, bmp2.Canvas, ARect);    
 //   picture.bitmap.Canvas.CopyMode := cmSrcCopy; { restore the copy mode }
            
        end;//   if ThumbnailSelectList.indexof(ss)>-1 then
    end; 
  end;
  

 // bmp2.free;
ThumbnailSelectList.clear;
CheckSpeedButtonEnabled;
CanWorkOnThumbnail:=true;

end;


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
;
end;

procedure TForm3.FormDestroy(Sender: TObject);

begin

{
if (iconthumbDELETElist<>nil) then
if (iconthumbDELETElist.count<>0) then 
begin
for i:=0 to iconthumbDELETElist.count-1 do
deletefile(iconthumbDELETElist.strings[i]);
end;
}

if iconthumbDELETElist<> nil then begin iconthumbDELETElist.free;end; 
if ThumbnailSelectList<> nil then begin ThumbnailSelectList.free;end; 
if iconthumblistOriginal<> nil then begin iconthumblistOriginal.free;end; 
if iconthumblist<> nil then begin iconthumblist.free;end; 
if iconthumblistOriginalConvert<> nil then begin iconthumblistOriginalConvert.free;end; 
if iconthumblistDATAINFO<> nil then begin iconthumblistDATAINFO.free;end; 

end;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
 

procedure TForm3.FormCreate(Sender: TObject);
var sbint,mi:integer;l1:tstringlist;
begin

 K:=TPClass_Command_RedStone.Create(application.Handle,form3,application.exename);
DOSelectALL:=false;
thumbPanel:=nil;
CanWorkOnThumbnail:=false;
thumbsize:=100;
    width:=(6*10)+(5*thumbsize)+10;
  height:=480;
  top:=0;
  left:=200;
   AutoScroll:=true;
caption:='RedstoneImage ThumbView';
 hide;
 
  p2:=tpanel.create(form3);
p2.parent:=form3;
with p2 as tpanel do
begin
  Left := 0;
    Top := 0;
    Width := 350;
    Height := 38;
    Align := altop;
      visiblE:=true;
   
end;

///////////////////////////////////////////////
scrollbox:=tscrollbox.create(form3);
with scrollbox as tscrollbox do
begin
parent:=form3;
align:=alclient;
 Left := 0;
    Top := 0;
HorzScrollBar.visible:=true;
VertScrollBar.visible:=true;
autoscroll:=true;
visible:=true;
borderstyle:=bsNone;
end;
/////////////////////////////////////////////////////////
sp:=TSpeedButton.Create (nil);
sp.parent:=p2;
with sp as tspeedbutton do
begin
 
      Top :=3;
      Width := 113;
      Height := 32;
       Left :=563 -113-5;
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
 
    sp.Glyph.LoadFromFile(inifile.Readstring ('xfgMainButtonImage', 'xfgFileInputToEditor', 'none'));
    //  Font.Style := []
    
          visible:=true;
            enabled:=true;
    onclick:=spclick;
      end;
      
 sps:=TSpeedButton.Create (nil);
sps.parent:=p2;
with sps as tspeedbutton do
begin
 
      Top :=3;
      Width := 32;
    
      Height := 32;
       Left := sp.left-Width-5;
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
  
      visible:=true;
      enabled:=true;
    onclick:=spclick;
      end;     
////////////////////////////////////////////////////////////

l1:=tstringlist.create;
 sbint:=10;
inifile.readsection('xfgImageThumbViewTop',l1);


 for mi := 0 to l1.Count - 1 do 
begin
 if AnsiLowercase(l1.Strings[mi])='editor mode' then
 begin
spp:=TSpeedButton.Create (nil);
with spp as TSpeedButton do
 begin
parent:=p2;

     Top := 3;
     Width := 32;
     Height := 32;
    //    name:=l1.Strings[mi];
    Flat := true;
    Layout := blGlyphTOP;
    Hint :=l1.Strings[mi];
 
    if AnsiLowercase(hint)='editor mode' then
    begin
   left:=sp.left-Width-5-32-9;
        if fileexists(inifile.Readstring ('xfgFileInputTopImage', l1.Strings[mi], 'none'))then 
    Glyph.LoadFromFile(inifile.Readstring ('xfgFileInputTopImage', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
     ParentShowHint := False;
     ShowHint := True;
     name:='editormode';
     Spacing := 5;
  
visible:=true;
  enabled:=true;
    OnClick := spclick;
    end;
 end;   
end;

 if AnsiLowercase(l1.Strings[mi])<>'editor mode' then
 begin
spb:=TSpeedButton.Create (nil);
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
 spb.visible:=true;
 
     spb.OnClick := spclick;
           if fileexists(inifile.Readstring ('xfgImageThumbViewTopImage', l1.Strings[mi], 'none'))
           then 
 
     spb.Glyph.LoadFromFile(inifile.Readstring ('xfgImageThumbViewTopImage', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      spb.ParentShowHint := False;
      spb.ShowHint := True;
      spb.Spacing := 5;
 
 spb.enabled:=true;
        if AnsiLowercase(spb.hint)='copy to file commander' then begin 
        sbCOPY:=spb;end;
    if AnsiLowercase(spb.hint)='move to file commander'then begin 
    sbMOVE:=spb;end;
    if AnsiLowercase(spb.hint)='delete'then begin 
    sbDELETE:=spb;end;
  if AnsiLowercase(spb.hint)='select all'then begin   
sbSelectALL:=spb;end;

sbint:=sbint+32+10;
end;
end;

////////////////////////////////////////////////////////////////////////////////
if sbSelectALL<>nil then sbSelectALL.enabled:=true;
if sbCOPY<>nil then sbCOPY.enabled:=true;
if sbMOVE<>nil then sbMOVE.enabled:=true;
if sbDELETE<>nil then sbDELETE.enabled:=true;

 
 l1.free;

end;

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

function Tform3.checkFilesSelected:BOOLEAN;
begin
result:=true;
if (ThumbnailSelectList=nil) then 
if MessageDlg ('No files selected ', mtConfirmation, [mbOK], 0, mbYes)=mrOK then result:=false;
if (ThumbnailSelectList<>nil) then 
begin
if ThumbnailSelectList.count=0 then 
if MessageDlg ('No files selected ', mtConfirmation, [mbOK], 0, mbYes)=mrOK then result:=false;
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure Tform3.spclick(Sender: TObject); 
var i:integer;ss:string;Temp: TControl;ss1:string;IGNOREALL:boolean;
senderVCLMethod:string;
begin
///////////////////////////////
if AnsiLowercase((sender as tspeedbutton).hint)=AnsiLowercase('Configure slides show') then 
begin
form4.slideInterval:=strtoint(k.CRS_InputQuery('Configure slides show','Please key in how many slides seconds per picture ...',
'2',true));
inifile.writeinteger('xfgMain','SlideInterval',form4.slideInterval);
if form4.TT<>nil then form4.TT.interval:=form4.slideInterval*1000;
exit;
end;
///////////////////////////////
if AnsiLowercase((sender as tspeedbutton).hint)=AnsiLowercase('Start slides show') then 
begin
 //form4.SlideINDEX:=iconthumblistOriginal.indexof(form4.caption)+1;

// if form4.caption='Redstone ImageView' then 
// begin
if (iconthumblistDATAINFO=nil)or(iconthumblistDATAINFO.count=0) then 
begin
form4.SlideTimerStop:=true;
 if form4.TT<>nil then 
form4.TT.free ;
form4.TT:=nil;
exit;
end else
if (iconthumblistDATAINFO.count<>0) then 
begin
if iconthumblistOriginal.indexof(form4.caption)<0 then
form4.caption:=iconthumblistOriginal[0];
form4.SlideTimerStop:=false;
end;

//end;
(sender as tspeedbutton).hint:='Stop slides show';
if fileexists(inifile.Readstring ('xfgImageThumbViewTopImage', 'Stop slides show', 'none'))then 
(sender as tspeedbutton).Glyph.LoadFromFile(inifile.Readstring ('xfgImageThumbViewTopImage', 'Stop slides show', 'none'));


form4.SlideTimerStop:=false;
form4.slideInterval:=inifile.readinteger('xfgMain','SlideInterval',form4.slideInterval);
form4.startslideshow;
exit;
end;
///////////////////////////////
if AnsiLowercase((sender as tspeedbutton).hint)=AnsiLowercase('Stop slides show') then 
begin
(sender as tspeedbutton).hint:='Start slides show';
if fileexists(inifile.Readstring ('xfgImageThumbViewTopImage', 'Start slides show', 'none'))then 
(sender as tspeedbutton).Glyph.LoadFromFile(inifile.Readstring ('xfgImageThumbViewTopImage', 'Start slides show', 'none'));

form4.SlideTimerStop:=true;
exit;
end;
///////////////////////////////
if AnsiLowercase((sender as tspeedbutton).hint)='send files to editor' then 
begin
if checkFilesSelected=false then exit; 
for i:=0 to ThumbnailSelectList.count-1 do
form1.xfgmemo.lines.add(ThumbnailSelectList.strings[i]);
exit;
end;
if AnsiLowercase((sender as tspeedbutton).hint)='clear editor' then 
begin
form1.xfgmemo.clear;
exit;
end;
if AnsiLowercase((sender as tspeedbutton).name)= 'editormode' then begin
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
exit;
end;




if AnsiLowercase((sender as tspeedbutton).hint)='show file commander' then 
begin
form2.show;
exit;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////
IGNOREALL:=false;
if AnsiLowercase((sender as tspeedbutton).hint)<>'select all' then 
if checkFilesSelected=false then exit; 
with sender as tspeedbutton do
begin

 if (trim(AnsiLowercase(IniFile.ReadString ('xfgImageThumbViewBottom', hint, 'none')))='vclinternal')or
(trim(AnsiLowercase(IniFile.ReadString ('xfgImageThumbViewBottom', hint, 'none')))='vclexternal')or
(trim(AnsiLowercase(IniFile.ReadString ('xfgImageThumbViewBottom', hint, 'none')))='vcl')    then 
begin 
senderVCLMethod:=(trim(AnsiLowercase(IniFile.ReadString ('xfgImageThumbViewBottom', hint, 'none'))));
form1.APASSUserExecVCL(hint,senderVCLMethod,iconthumblistOriginal);
exit;
end;
 if (trim(AnsiLowercase(IniFile.ReadString ('xfgImageThumbViewTop', hint, 'none')))='vclinternal')or
(trim(AnsiLowercase(IniFile.ReadString ('xfgImageThumbViewTop', hint, 'none')))='vclexternal')or
(trim(AnsiLowercase(IniFile.ReadString ('xfgImageThumbViewTop', hint, 'none')))='vcl')    then 
begin 
senderVCLMethod:=(trim(AnsiLowercase(IniFile.ReadString ('xfgImageThumbViewTop', hint, 'none'))));
form1.APASSUserExecVCL(hint,senderVCLMethod,iconthumblistOriginal);
exit;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////

if AnsiLowercase(hint)='copy to file commander' then 
begin

if checkFilesSelected=false then exit; 
if form2.filelist.directory.location=form1.DATADIR+'/.thrash bin/' then exit;
if fileexists(iconthumblistOriginal.strings[0]) then 
if extractfilepath(ThumbnailSelectList.strings[0])=form2.filelist.directory.location then exit;
form1.FileCopyMove(1,2,ThumbnailSelectList);

end;
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////

if AnsiLowercase(hint)='move to file commander' then 
begin

if ThumbnailSelectList.count<>0 then ss1:=extractfilepath(ThumbnailSelectList[0]);
if checkFilesSelected=false then exit; 
if form2.filelist.directory.location=form1.DATADIR+'/.thrash bin/' then exit;
if fileexists(iconthumblistOriginal.strings[0]) then 
if extractfilepath(ThumbnailSelectList.strings[0])=form2.filelist.directory.location then exit;
form1.FileCopyMove(2,1,ThumbnailSelectList);
//form1.RUN_drawThumbnail_TASK(ss1);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////


if AnsiLowercase(hint)='delete' then 
begin
//if ThumbnailSelectList.count<>0 then ss1:=extractfilepath(ThumbnailSelectList[0]);
if checkFilesSelected=false then exit; 
form1.FileDelete(1,ThumbnailSelectList);
//form1.RUN_drawThumbnail_TASK(ss1);
end;
////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////

if AnsiLowercase(hint)='select all' then 
begin
if sbCOPY<>nil then sbCOPY.enabled:=false;
if sbMOVE<>nil then sbMOVE.enabled:=false;
if sbDELETE<>nil then sbDELETE.enabled:=false;
 {
    CopyMode := cmWhiteness;
    ARect := Rect(0, 0, Image.Width, Image.Height);
    CopyRect(ARect, Image.Canvas, ARect);    
    CopyMode := cmSrcCopy; // restore the copy mode 
 }   

//bmp:=tbitmap.create;
{
bmpcross:=tbitmap.create;
bmpcross.width:=thumbsize;
bmpcross.height:=thumbsize;
bmpcross.Transparent := True;
bmpcross.transparentcolor:=clblue;  
bmpcross.TransparentMode := tmAuto;      
bmpcross.Canvas.Brush.Color := clblue;
bmpcross.Canvas.Brush.Style := bsDiagCross;
bmpcross.Canvas.FillRect(Rect(0,0,thumbsize,thumbsize));
crossRect := Rect(0, 0, thumbsize, thumbsize);
imgRect:= Rect(0, 0, thumbsize, thumbsize);
//thumbnailimage.picture.bitmap.FreePixmap;
//thumbnailimage.picture.loadfromfile(imgfile);
//bmp.FreePixmap;
//bmp.loadfromfile(imgfile);
//thumbnailimage.Picture.Graphic := bmp;
//bmpcross:=tbitmap.create; 
}

// ThumbnailSelectList:tstringlist;
//    iconthumblist,iconthumblistOriginal:tstringlist;
if iconthumblistOriginal=nil then if  MessageDlg ('No files to select ' +#13#10+#13#10
     , mtConfirmation, [mbOk], 0, mbOk)=mrOk then exit;
if iconthumblist=nil then if  MessageDlg ('No files to select ' +#13#10+#13#10
     , mtConfirmation, [mbOk], 0, mbOk)=mrOk then exit;
if iconthumblist.count=0 then if  MessageDlg ('No files to select ' +#13#10+#13#10
     , mtConfirmation, [mbOk], 0, mbOk)=mrOk then exit;
if iconthumblistOriginal.count=0 then if  MessageDlg ('No files to select ' +#13#10+#13#10
     , mtConfirmation, [mbOk], 0, mbOk)=mrOk then exit;

///////////////////////////////

/////////////////////

  for I := 0 to thumbPanel.ControlCount - 1 do
  begin
    Temp := thumbPanel.Controls[I];
    if (temp is TIMAGE)  then
    begin
    
    with (temp as timage) do 
      begin
   
ThumbnailSelectList.add(ss);

    //  canvas.CopyMode := cmSrcInvert;//cmPatCopy   cmSrcAnd  cmMergeCopy cmSrcCopy cmMergePaint
      //cmPatInvert    cmSrcInvert  cmDstInvert cmCreateMask   
    //  Canvas.Pen.Width := 2;
        Canvas.Brush.Color := clblue;
        Canvas.Brush.Style := bsDiagCross;
       Canvas.FillRect(Rect(0,0,thumbsize,thumbsize));    
       
//Canvas.Draw(0,0,bmpcross);
     //  Canvas.CopyRect(imgRect,bmpcross.canvas, crossRect);
    //   canvas.CopyMode := cmSrcCopy;
      end;//with (temp as timage) do 
     end;//if (temp is TIMAGE)  then
  end;// for I := 0 to thumbPanel.ControlCount - 1 do

ThumbnailSelectList.assign(iconthumblistOriginal);
//ThumbnailSelectList.savetofile(form1.DATADIR+'/iconthumbSelectList.lst');
 CheckSpeedButtonEnabled;

end;

end;
end;

/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm3.FormShow(Sender: TObject);
begin
;
end;


/////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm3.drawThumbnail(APASSLocation:string);
 var i,ii,thumbINT,REALImgHt,REALImgWt,pre:integer;
     imgfile,convertimgfile,tempstr1,tempstr2,convertFilename,TEMPconvertimgfile:string;
     bmp:tbitmap;
     thumbnailimage:timage; 
     sr: TSearchRec;  
     FileAttrs: Integer;
     TEMPiconthumblist:tstringlist;
     Pinfo:PFileInfo;
     FileChange:Boolean;
begin


if form4.TT<>nil then form4.show else
form4.close;
MT_DRAW_Thumbnail_TASK_RUNNING:=true;
spViewthumbnail.enabled:=false;


CanWorkOnThumbnail:=false;

thumbINT:=0; 
ii:=1;


//////////////////////////////////////////////

if thumbPanel<>nil then begin thumbPanel.free;thumbPanel:=nil;end;

if ThumbnailSelectList<> nil then begin ThumbnailSelectList.free;ThumbnailSelectList:=nil;end; 
if iconthumblist<>nil then begin iconthumblist.free;iconthumblist:=nil;end;
if iconthumblistOriginal<>nil then begin iconthumblistOriginal.free;iconthumblistOriginal:=nil;end;
if iconthumblistOriginalConvert<> nil then begin iconthumblistOriginalConvert.free;iconthumblistOriginalConvert:=nil;end; 
if iconthumblistDATAINFO<> nil then begin iconthumblistDATAINFO.free;iconthumblistDATAINFO:=nil;end; 

////////////////////////////////////////////////////////////////////////////////////////////////
iconthumblist:=tstringlist.create;
iconthumblistOriginal:=tstringlist.create;
iconthumblistOriginalConvert:=tstringlist.create;
ThumbnailSelectList:=tstringlist.create;
iconthumblistDATAINFO:=tstringlist.create;
////////////////////////////////////////////////////////////////////////////////////////////////
//if not directoryexists(form1.DATADIR+'/.thumbnailStorage/') then
//mkdir(form1.DATADIR+'/.thumbnailStorage/');
// if not directoryexists(form1.DATADIR+'/.thumbnailStorage'+extractfilepath(iconthumblist.strings[0])) then
//    forcedirectories(form1.DATADIR+'/.thumbnailStorage'+extractfilepath(iconthumblist.strings[0]));
if not directoryexists(form1.DATADIR+'/.thumbnailStorage'+APASSLocation) then
    forcedirectories(form1.DATADIR+'/.thumbnailStorage'+APASSLocation);
 
thumbINT:=0; 
ii:=1;

(******************************************)
   FileAttrs := faReadOnly+ faHidden+ faSysFile+ faAnyFile;
 
TEMPiconthumblist:=tstringlist.create;
TEMPiconthumblist.Sorted:=true;
TEMPiconthumblist.CaseSensitive:=true;
 TEMPiconthumblist.Duplicates:=dupIgnore; 


    if FindFirst(APASSLocation+'*', FileAttrs, sr) = 0 then
    begin
      repeat
     //   if (sr.Attr and FileAttrs) = sr.Attr then
     //   begin

    if GimageEXTlist.IndexOf(Copy(AnsiLowercase(extractfileExt( APASSLocation+sr.name)), 
    2, length(AnsiLowercase(extractfileExt( APASSLocation+sr.name)))-1))>-1 then
    begin
      TEMPiconthumblist.add(APASSLocation+sr.name);
    
    thumbINT:=thumbINT+1;
    if thumbINT=5 then begin thumbINT:=0;ii:=ii+1; end;
         end;
      //      end; 
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;  
 iconthumblist.assign(TEMPiconthumblist);
 

 TEMPiconthumblist.clear;  
(*******************************************************************************
  for i:=0 to form2.filelist.Items.count-1 do
begin 
 if not directoryexists(form2.filelist.directory.location+form2.filelist.items[i].caption) then
 begin
    imgfile:=form2.filelist.directory.location+form2.filelist.items[i].caption;
    extstring:= Copy(AnsiLowercase(extractfileExt( imgfile)), 2, length(AnsiLowercase(extractfileExt( imgfile)))-1);

    if GimageEXTlist.IndexOf(extstring)>-1 then
      iconthumblist.add(imgfile);
    thumbINT:=thumbINT+1;
    if thumbINT=5 then begin thumbINT:=0;ii:=ii+1;end;
end;// if not directoryexists(filelist.directory.location+filelist.items[i].caption) then

 end;// for i:=0 to filelist.Items.count-1 do
***************************)
///////////////////////////////////////////////////////////////////////////////////////
 (***************************************)
iconthumblistDATAINFO.clear;
if fileexists(form1.DATADIR+'/.thumbnailStorage'+APASSLocation+'.xfgimgdatainfo') then
begin
iconthumblistDATAINFO.loadfromfile(form1.DATADIR+'/.thumbnailStorage'+APASSLocation+'.xfgimgdatainfo');
k.crs_checkfilelistIndexOfName(iconthumblistDATAINFO,1);
end;
(***************************************)


///////////////////////////////////////////////////////////////////////////////////////

if  iconthumblist.count=0 then 
begin 
iconthumblist.free;
iconthumblist:=nil;
(*********************************************)
for i:=0 to iconthumblistDATAINFO.count -1 do
begin
tempstr2:=k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO[i]+'}','{','}','=',2);
if fileexists(tempstr2)then deletefile(tempstr2);
end;
iconthumblistDATAINFO.clear;
iconthumblistDATAINFO.savetofile(form1.DATADIR+'/.thumbnailStorage'+APASSLocation+'.xfgimgdatainfo');
(*********************************************)
exit;
end;

   iconthumblistOriginal.assign(  iconthumblist);
   iconthumblistOriginalConvert.assign(  iconthumblist);

form3.thumbPanel:=tpanel.create(form3);
form3.thumbPanel.parent:=scrollbox;
with form3.thumbPanel as tpanel do
begin
   Align := alnone;
  height:=((ii+1)*10)+(ii*thumbsize)+10;
  width:=form3.width;
   BorderStyle := bsnone;
   visible:=true;
end;

form3.Constraints.MaxHeight := 480+p2.height+4;
  form3.Constraints.MaxWidth := (6*10)+(5*thumbsize)+2;
  thumbPanel.width:=(6*10)+(5*thumbsize)+2;
 pre:=((ii+1)*10)+(ii*thumbsize)+10;
  if pre>479 then
begin
form3.Constraints.MaxWidth := thumbPanel.width+16;
form3.width:=thumbPanel.width+16;
end;    


if pre>479 then form3.height:=pre+p2.height+4;
              
{ if thumbPanel.height>480 then
begin
form3.Constraints.MaxWidth := thumbPanel.width+16;
form3.width:=thumbPanel.width+16;
end;  }       


 

thumbINT:=0; 
ii:=1;
bmp:=tbitmap.create;
bmp.transparent:=false;
bmp.transparentmode:=tmAuto;
//bmp.PixelFormat:=pf8bit;
///////////////////////////////////////////////////////////////////////////////////

for i:=0 to   iconthumblist.count-1 do
begin

if MT_DRAW_Thumbnail_TASK_RUNNING=false then break;
  application.processmessages; 
thumbINT:=thumbINT+1;
thumbnailimage:=timage.create(form3.thumbPanel);
thumbnailimage.parent:=form3.thumbPanel;
thumbnailimage.autosize:=false;
thumbnailimage.center:=true;
thumbnailimage.transparent:=false;
//thumbnailimage.IncrementalDisplay:=true;
//thumbnailimage.picture.bitmap.PixelFormat:=pf8bit;
thumbnailimage.width:=thumbsize;
thumbnailimage.height:=thumbsize;

thumbnailimage.top:=(10*ii)+((thumbsize*ii)-thumbsize);
thumbnailimage.left:=(10*thumbINT)+((thumbsize*thumbINT)-thumbsize);
thumbnailimage.showhint:=true;
thumbnailimage.onclick:=ImageThumbOnClick;
thumbnailimage.onDblclick:=ImageThumbOnDoubleClick;
thumbnailimage.onmousedown:=ImageThumbMouseDown;
if thumbINT=5 then begin thumbINT:=0;ii:=ii+1;end; 
FileChange:=false;
//if FindFirst(iconthumblist.strings[i],  
//          faAnyFile Or faReadOnly Or faHidden Or faSysFile, SR) = 0 
//then  Pinfo:=AllocFileInfo(SR);
//findclose(sr);  
//Pinfo:=form2.filelist.directory.Files(form2.filelist.directory.indexof(extractfilename(iconthumblist.Strings[i])));
Pinfo:=K.CRS_GetFilePInfo(iconthumblist.Strings[i]);
 //thumbPanel.height:=(ii*10)+(ii*thumbsize)+10;
          
try

{******************************************************************************************}
imgfile:=  iconthumblist.strings[i];
tempstr1:='  -  ';
tempstr2:='  -  ';


{******************************************************************************************}

 convertFilename:='xfg1428'+extractfilename(imgfile);
 convertimgfile:=extractfilepath(imgfile)+convertFilename;
 TEMPconvertimgfile:='';
if fileexists(form1.DATADIR+'/.thumbnailStorage'+APASSLocation+'.xfgimgdatainfo') then
begin
if iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i])>-1
then
begin
 if iconthumblistDATAINFO.count>0 then
 TEMPconvertimgfile:=(k.CRS_GetParamAtPos('{'+
            iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i])]+
            '}','{','}','=',2));
            
if Pinfo.stat.st_mtime <> strtoint(k.CRS_GetParamAtPos('{'+
            iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i])]+
            '}','{','}','=',3))then 
begin
FileChange:=true;
TEMPconvertimgfile:='';
iconthumblistDATAINFO.delete(iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i]));
end;  
end;        
end;
   
{******************************************************************************************}

if (FileChange=false)
and (AnsiPos('/.thumbnailStorage',TEMPconvertimgfile)>0)
then
if fileexists(TEMPconvertimgfile) then 
begin

bmp.FreePixmap;
bmp.loadfromfile(TEMPconvertimgfile);

imgfile:=  iconthumblist.strings[i];
end;

if(AnsiPos('/.thumbnailStorage',TEMPconvertimgfile)=0)
or (TEMPconvertimgfile='')
or (FileChange=true)
then
begin
imgfile:=  iconthumblist.strings[i];
bmp.FreePixmap;
bmp.loadfromfile(iconthumblist.strings[i]);
REALImgHt:=bmp.height;
REALImgWt:=bmp.width;
if iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i])<>-1 then
iconthumblistDATAINFO.delete(iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i]));
iconthumblistDATAINFO.add(iconthumblistOriginal.strings[i]+
 '='+iconthumblist.strings[i]+'='+
     inttostr(Pinfo.stat.st_mtime)+'='+
     inttostr(REALImgHt)+'='+
     inttostr(REALImgWt)+'='+
     iconthumblistOriginalConvert.strings[i]); 


end;


if (bmp.width=0)or (bmp.height=0)then 
begin
   iconthumblistOriginalConvert.delete(i);
  iconthumblist.delete(i);
  iconthumblist.insert(i,form1.IMAGEDIR+'/'+extractfilename(form1.IMAGEDIR+'/'+'file_broken-48.png')); 
  iconthumblistOriginalConvert.insert(i,form1.IMAGEDIR+'/'+extractfilename(form1.IMAGEDIR+'/'+'file_broken-48.png')); 
bmp.FreePixmap;
if MT_DRAW_Thumbnail_TASK_RUNNING=false then break;
bmp.loadfromfile(form1.IMAGEDIR+'/'+extractfilename(form1.IMAGEDIR+'/'+'file_broken-48.png'));


end;


 

If (bmp.width>100)or  (bmp.height>100)   then 
begin

if fileexists(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)) then 
k.CRS_DeleteFile(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile));

 
if not (fileexists(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)))
or(FileChange=true) then 
begin

if not directoryexists(form1.DATADIR+'/.thumbnailStorage'+extractfilepath(convertimgfile)) then
forcedirectories(form1.DATADIR+'/.thumbnailStorage'+extractfilepath(convertimgfile));

libc.system(pchar('/usr/bin/convert '+'"'+
                   imgfile+'" -type TrueColorMatte '+'-resize '+inttostr(thumbSize)+'x'+inttostr(thumbSize)+' +profile "*" '+
                   '"'+form1.DATADIR+'/.thumbnailStorage'+convertimgfile+'"'));
                   
         
if not fileexists(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)) then 
begin

    iconthumblist.delete(i);
    iconthumblistOriginalConvert.delete(i);
        iconthumblist.insert(i,form1.IMAGEDIR+'/'+'file_broken-48.png') ;
      iconthumblistOriginalConvert.insert(i,form1.IMAGEDIR+'/'+'file_broken-48.png') ;  
    imgfile:= iconthumblist.strings[i];
    bmp.FreePixmap;
  
bmp.loadfromfile(imgfile);
end;
  
if fileexists(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)) then 
begin

  iconthumblist.delete(i);
  iconthumblist.insert(i,form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)); 
imgfile:=  iconthumblist.strings[i];
bmp.FreePixmap;
if MT_DRAW_Thumbnail_TASK_RUNNING=false then break;
bmp.loadfromfile(imgfile);

if iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i])<>-1 then
iconthumblistDATAINFO.delete(iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i]));
iconthumblistDATAINFO.add(iconthumblistOriginal.strings[i]+
 '='+iconthumblist.strings[i]+'='+
     inttostr(Pinfo.stat.st_mtime)+'='+
     inttostr(REALImgHt)+'='+
     inttostr(REALImgWt)+'='+
     iconthumblistOriginalConvert.strings[i]); 
end;

end;//if not fileexists(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)) then 

end; //If (bmp.width>100)or  (bmp.height>100)   then 



thumbnailimage.Picture.Graphic := bmp;
thumbnailimage.Picture.Graphic.transparent:=false;

                              
 if imgfile=form1.IMAGEDIR+'/'+'file_broken-48.png'then 
        thumbnailimage.hint:=iconthumblistOriginal.strings[i]+#13#10+
                             ' Broken image file' else
thumbnailimage.hint:=  iconthumblistOriginal.strings[i]+#13#10+
                     '    width : '+(tempstr2)+' pixels'+#13#10+
                     '   height : '+(tempstr1)+' pixels'; 
 //  application.processmessages;
   
{*********************************************************************}
 except
{*********************************************************************}
 //  on EInvalidGraphic : Exception do
  //  begin
    if MT_DRAW_Thumbnail_TASK_RUNNING=false then break;
 
 //  application.processmessages; 
     imgfile:=  iconthumblist.strings[i];
      iconthumblist.delete(i);
      iconthumblistOriginalConvert.delete(i);
      
    convertFilename:='xfg1408'+extractfilename(imgfile);
 convertimgfile:=extractfilepath(imgfile)+convertFilename;
 
if fileexists(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)+'.jpg') then 
k.CRS_DeleteFile(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)+'.jpg');

if not (fileexists(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)+'.jpg') )
or(FileChange=true)then 
begin
 
    if not directoryexists(form1.DATADIR+'/.thumbnailStorage'+extractfilepath(convertimgfile)) then
    forcedirectories(form1.DATADIR+'/.thumbnailStorage'+extractfilepath(convertimgfile));

    libc.system(pchar('/usr/bin/convert '+'"'+imgfile+'" -type TrueColorMatte'+' '+'"'+
                           form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)+'.jpg'+'"'));
  end;  
    if not fileexists(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)+'.jpg') then 
    begin
    
        iconthumblist.insert(i,form1.IMAGEDIR+'/'+'file_broken-48.png') ;
      iconthumblistOriginalConvert.insert(i,form1.IMAGEDIR+'/'+'file_broken-48.png') ;  
     imgfile:=  iconthumblist.strings[i];
     bmp.FreePixmap;
    if MT_DRAW_Thumbnail_TASK_RUNNING=false then break;
     bmp.loadfromfile(imgfile);   
   end; 
    if fileexists(form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)+'.jpg') then 
    begin
 
      iconthumblist.insert(i,form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)+'.jpg'); 
      iconthumblistOriginalConvert.insert(i,form1.DATADIR+'/.thumbnailStorage'+(convertimgfile)+'.jpg'); 
     imgfile:=  iconthumblist.strings[i];
     bmp.FreePixmap;
     if MT_DRAW_Thumbnail_TASK_RUNNING=false then break;
     bmp.loadfromfile(imgfile);
     REALImgHt:=bmp.height;
     REALImgWt:=bmp.width;
 

    end; 

{******************************************************************************************}
tempstr1:='  -  ';
tempstr2:='  -  ';



{******************************************************************************************}

if (bmp.width=0)or (bmp.height=0)then 
begin
     iconthumblist.insert(i,form1.IMAGEDIR+'/'+'file_broken-48.png') ;
      iconthumblistOriginalConvert.insert(i,form1.IMAGEDIR+'/'+'file_broken-48.png') ;  
     imgfile:=  iconthumblist.strings[i];
     bmp.FreePixmap;
     if MT_DRAW_Thumbnail_TASK_RUNNING=false then break;
     bmp.loadfromfile(imgfile);   

end;

if (bmp.height>100)or  (bmp.width>100)   then 
 

    begin
    
      convertFilename:='xfg1428'+extractfilename(imgfile);
 convertimgfile:=extractfilepath(imgfile)+convertFilename;
 
if fileexists(convertimgfile+'.jpg') then 
k.CRS_DeleteFile(convertimgfile+'.jpg');
 
    libc.system(pchar('/usr/bin/convert '+
                 '"'+imgfile+'" -type TrueColorMatte '+' -resize '+inttostr(thumbSize)+'x'+
                          inttostr(thumbSize)+' +profile "*" '+'"'+convertimgfile+'.jpg'+'"'));
                          
  
    
  iconthumblist.delete(i);
  iconthumblist.insert(i,convertimgfile+'.jpg'); 
 imgfile:=  iconthumblist.strings[i];
bmp.FreePixmap;
if MT_DRAW_Thumbnail_TASK_RUNNING=false then break;
bmp.loadfromfile(imgfile);
    end;

if iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i])<>-1 then
iconthumblistDATAINFO.delete(iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i]));
iconthumblistDATAINFO.add(iconthumblistOriginal.strings[i]+
 '='+iconthumblist.strings[i]+'='+
     inttostr(Pinfo.stat.st_mtime)+'='+
     inttostr(REALImgHt)+'='+
     inttostr(REALImgWt)+'='+
     iconthumblistOriginalConvert.strings[i]); 
     
 if (form3.thumbPanel)<>nil then
  thumbnailimage.Picture.Graphic := bmp; 

 if imgfile=form1.IMAGEDIR+'/'+'file_broken-48.png'then 
        thumbnailimage.hint:=iconthumblistOriginal.strings[i]+#13#10+
                             ' Broken image file' else
thumbnailimage.hint:= iconthumblistOriginal.strings[i]+#13#10+
                 '    width : '+(tempstr2)+' pixels'+#13#10+
                     '   height : '+(tempstr1)+' pixels'; 

          
    
 //   end//except
 
end;//try
end;//for i:=0 to iconthumblist.count-1 do


if thumbPanel.height<479 then form3.height:=thumbPanel.height+p2.height+1;


(****
iconthumblistDATAINFO.clear;
for i:=0 to iconthumblistOriginal.count-1 do
begin

iconthumblistDATAINFO.add(iconthumblistOriginal.strings[i]+
                              '='+iconthumblistOriginalConvert.strings[i]);

end;
****)
//iconthumblistOriginal.savetofile('/iconthumblistOriginal');
//iconthumblistOriginalConvert.savetofile('/iconthumblistOriginalConvert');
//iconthumblistDATAINFO.savetofile(form1.DATADIR+'/.thumbnailStorage'+APASSLocation+'.xfgimgdatainfo');
//TEMPSizeList.savetofile(form1.DATADIR+'/.thumbnailStorage'+APASSLocation+'.xfgsizelst');
bmp.free;
//000/newany10.gif=/root/redstone/FileGarden/data/.thumbnailStorage/000/xfg1428newany10.gif=1104523623=40=367=/000/newany10.gif
// TEMPconvertimgfile:=(k.CRS_GetParamAtPos('{'+
//            iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(iconthumblistOriginal.strings[i])]+
//            '}','{','}','=',2));
(*********************************************)
TEMPiconthumblist.clear;
for i:=0 to iconthumblistDATAINFO.count -1 do
begin
tempstr1:=iconthumblistDATAINFO.Names[i];

if fileexists(tempstr1)then 
begin
TEMPiconthumblist.add(iconthumblistDATAINFO[i]);
continue;
end  else
begin
tempstr2:=k.CRS_GetParamAtPos('{'+iconthumblistDATAINFO[i]+'}','{','}','=',2);

if fileexists(tempstr2) and not(tempstr2=form1.IMAGEDIR+'/'+'file_broken-48.png')
then deletefile(tempstr2);
end;
end;
iconthumblistDATAINFO.clear;
iconthumblistDATAINFO.assign(TEMPiconthumblist);
iconthumblistDATAINFO.savetofile(form1.DATADIR+'/.thumbnailStorage'+APASSLocation+'.xfgimgdatainfo');
TEMPiconthumblist.clear;
(*********************************************)
TEMPiconthumblist.free;

if form2<>nil then spViewthumbnail.enabled:=true;
if form2<>nil then if sbSelectALL<>nil then sbSelectALL.enabled:=true;
CanWorkOnThumbnail:=true;



MT_DRAW_Thumbnail_TASK_RUNNING:=false;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////    

end.
 