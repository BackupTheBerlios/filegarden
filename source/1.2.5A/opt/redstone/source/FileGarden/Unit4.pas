unit Unit4;

interface

uses
  SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms, 
  QDialogs, QStdCtrls, QExtCtrls,Math;

type
  TForm4 = class(TForm)
    Image1: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure  TTOnTimer(Sender: TObject) ;
     procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
 
  private
    { Private declarations }
    
  
  public
    { Public declarations }
 slideInterval:integer;     
SlideTimerStop:Boolean;
FullImage,ConstraintImage:Boolean;
 TT:TTimer;
   procedure StartSlideShow;
  PROCEDURE DisplayBitmap(CONST Bitmap:  TBitmap;CONST Image :  TImage);
   end;

var
  Form4: TForm4;



implementation

{$R *.xfm}
uses Unit1,Unit2,Unit3;
PROCEDURE TForm4.DisplayBitmap(CONST Bitmap:  TBitmap;CONST Image :  TImage);
  VAR
  StretchHeight:Boolean;
    Half      :  INTEGER;
    Height    :  INTEGER;
  NewBitmap :  TBitmap;
   TargetArea:  TRect;
    Width     :  INTEGER;
BEGIN
image.center:=false;
 NewBitmap := TBitmap.Create;
  TRY
    NewBitmap.Width  := Image.Width;
    NewBitmap.Height := Image.Height;
    NewBitmap.PixelFormat := pf16bit;

  NewBitmap.Canvas.Brush.color := form4.color;
  NewBitmap.Canvas.FillRect(NewBitmap.Canvas.ClipRect);

    // "equality" (=) case can go either way in this comparison

    IF   Bitmap.Width / Bitmap.Height  <  Image.Width / Image.Height
    THEN BEGIN

      // Stretch Height to match.
      TargetArea.Top    := 0;
      TargetArea.Bottom := NewBitmap.Height;

      // Adjust and center Width.
      Width := MulDiv(NewBitmap.Height, Bitmap.Width, Bitmap.Height);
      Half := (NewBitmap.Width - Width) DIV 2;

      TargetArea.Left  := Half;
      TargetArea.Right := TargetArea.Left + Width;
    END
    ELSE BEGIN
      // Stretch Width to match.
      TargetArea.Left    := 0;
      TargetArea.Right   := NewBitmap.Width;

      // Adjust and center Height.
      Height := MulDiv(NewBitmap.Width, Bitmap.Height, Bitmap.Width);
      Half := (NewBitmap.Height - Height) DIV 2;

      TargetArea.Top    := Half;
      TargetArea.Bottom := TargetArea.Top + Height
    END;

    NewBitmap.Canvas.StretchDraw(TargetArea, Bitmap);
   // Image.Picture.Graphic := NewBitmap
   Image.Picture.assign(NewBitmap); //:= NewBitmap
  FINALLY
    NewBitmap.Free
  END
 
END ;


////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure  TForm4.TTOnTimer(Sender: TObject) ;

 var
sizeConst : Double;BB:TBitmap; TTSlideINDEX:integer;
begin
if iconthumblistDATAINFO.count=0 then
begin

SlideTimerStop:=true;
 if TT<>nil then 
 begin
 TT.Enabled:=false;
TT.free ;
TT:=nil;
end;
exit;
end;
try
if SlideTimerStop=true then TT.Enabled:=false;
TTSlideINDEX:=iconthumblistOriginal.IndexOf(caption);
if (TTSlideINDEX<0) or (TTSlideINDEX= iconthumblistOriginal.count-1)then 
begin
caption:=iconthumblistOriginal[0];
TTSlideINDEX:=0;
end else
inc(TTSlideINDEX);
//if SlideINDEX>iconthumblistOriginal.count -1 then SlideINDEX:=0;

caption:=iconthumblistOriginal[TTSlideINDEX];
         BB:=tbitmap.create;
  BB.loadfromfile((k.CRS_GetParamAtPos('{'+
    iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(caption)]+
            '}','{','}','=',6)));


   if FullImage=True then
      begin
     image1.align:=alclient;
          if (BB.width>image1.width)or(BB.height>image1.height)then
           begin
           EnableAutoRange; 
       image1.align:=alnone;
        image1.AutoSize:=true;
        image1.Stretch:=false;
        image1.center:=true;
  image1.picture.bitmap.FreePixmap;
      end else
            begin
           EnableAutoRange; 
       image1.align:=alclient;
        image1.AutoSize:=false;
        image1.Stretch:=false;
        image1.center:=true;
  image1.picture.bitmap.FreePixmap;
      end ;
     image1.picture.assign(BB);  
    
     end else
       begin
   
     image1.align:=alclient;
        image1.AutoSize:=false;
        image1.Stretch:=false;
        image1.center:=true;
  // image1.top:=0;
  // image1.left:=0;
  image1.picture.bitmap.FreePixmap; 
 

          if (BB.width>image1.width)or(BB.height>image1.height)then
  DisplayBitmap(BB,image1) else image1.Picture.assign(BB);
BB.free;

    end;


if SlideTimerStop=true then TT.Enabled:=false;
except
if (SlideTimerStop=true)or (iconthumblistOriginal.count=0) then TT.Enabled:=false else
begin
TT.Enabled:=true;
if (TTSlideINDEX= -1) or (TTSlideINDEX= iconthumblistOriginal.count-1)then 
caption:=iconthumblistOriginal[0];
form1.xfgmemo.lines.add(caption);
end;

end;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm4.StartSlideShow;

begin

//TTslideINDEX:=0;   
//TTslideINDEX:=iconthumblistOriginal.indexof(caption);
  form4.show;
 if caption='Redstone ImageView' then 
 begin 
 SlideTimerStop:=true;
 TT.Enabled:=false;
 if TT<>nil then 
 begin 
TT.free;
TT:=nil;
end;
 exit;
 end;

//TTslideINDEX:=TTslideINDEX+1;
if TT<>nil then 
TT.free ;

TT:=TTimer.create(application);
//TT.Enabled:=true;
TT.interval:=slideInterval*1000;
TT.OnTimer:=TTOnTimer;//(Sender: TObject) 



//repeat
//inc(TTslideINDEX);
//if TTslideINDEX>iconthumblist.count -1 then TTslideINDEX:=0;
//caption:=iconthumblistOriginal[TTslideINDEX];
//until SlideTimerStop;  
//SlideTimerStop:=True;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form4.hide;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm4.FormCreate(Sender: TObject);
begin
slideInterval:=inifile.readinteger('xfgMain','SlideInterval',2);
TT:=nil;
SlideTimerStop:=True;
FullImage:=True;
ConstraintImage:=False;
width:=350;
height:=400;
autoscroll:=true;
form4.top:=100;
form4.left:=10;
caption:='Redstone ImageView';
HorzScrollBar.Increment:=50;
VertScrollBar.Increment:=50;
    form4.Constraints.MaxHeight := screen.height;
  form4.Constraints.MaxWidth := screen.width;
end;
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TForm4.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  

  var startindex:integer;
sizeConst : Double;BB:TBitmap; SlideINDEX:integer; 
  
begin

try


//slideINDEX:=0;   
slideINDEX:=iconthumblistOriginal.indexof(caption);
  form4.show;
   
if button=mbleft then 
begin
if caption='Redstone ImageView' then exit;
slideINDEX:=slideINDEX+1;
if slideINDEX>iconthumblist.count -1 then slideINDEX:=0;
caption:=iconthumblistOriginal[slideINDEX];
         BB:=tbitmap.create;
  BB.loadfromfile((k.CRS_GetParamAtPos('{'+
    iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(caption)]+
            '}','{','}','=',6)));

     if FullImage=True then
      begin
      image1.align:=alclient;
          if (BB.width>image1.width)or(BB.height>image1.height)then
           begin
           EnableAutoRange; 
       image1.align:=alnone;
        image1.AutoSize:=true;
        image1.Stretch:=false;
        image1.center:=true;
  image1.picture.bitmap.FreePixmap;
      end else
            begin
           EnableAutoRange; 
       image1.align:=alclient;
        image1.AutoSize:=false;
        image1.Stretch:=false;
        image1.center:=true;
  image1.picture.bitmap.FreePixmap;
      end ;
     image1.picture.assign(BB);  
    
     end else
       begin
    
     image1.align:=alclient;
        image1.AutoSize:=false;
        image1.Stretch:=false;
        image1.center:=true;
  // image1.top:=0;
  // image1.left:=0;
  image1.picture.bitmap.FreePixmap; 
  


          if (BB.width>image1.width)or(BB.height>image1.height)then
  DisplayBitmap(BB,image1) else image1.Picture.assign(BB);
BB.free;

    end;

end;//if button=mbleft then 

if button=mbright then 
begin

startindex:=slideINDEX;
if startindex<>0 then
slideINDEX:=startindex-1;
if startindex=0 then slideINDEX:=iconthumblist.count -1;
caption:=iconthumblistOriginal[slideINDEX];
          BB:=tbitmap.create;
  BB.loadfromfile((k.CRS_GetParamAtPos('{'+
    iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(caption)]+
            '}','{','}','=',6)));
 
     if FullImage=True then
      begin
      image1.align:=alclient;
          if (BB.width>image1.width)or(BB.height>image1.height)then
           begin
           EnableAutoRange; 
       image1.align:=alnone;
        image1.AutoSize:=true;
        image1.Stretch:=false;
        image1.center:=true;
  image1.picture.bitmap.FreePixmap;
      end else
            begin
           EnableAutoRange; 
       image1.align:=alclient;
        image1.AutoSize:=false;
        image1.Stretch:=false;
        image1.center:=true;
  image1.picture.bitmap.FreePixmap;
      end ;
     image1.picture.assign(BB);  
    
     end else
       begin
    
     image1.align:=alclient;
        image1.AutoSize:=false;
        image1.Stretch:=false;
        image1.center:=true;
  // image1.top:=0;
  // image1.left:=0;
  image1.picture.bitmap.FreePixmap; 
  


          if (BB.width>image1.width)or(BB.height>image1.height)then
  DisplayBitmap(BB,image1) else image1.Picture.assign(BB);
BB.free;

    end;
end;


if button=mbmiddle then 
begin
         BB:=tbitmap.create;
  BB.loadfromfile((k.CRS_GetParamAtPos('{'+
    iconthumblistDATAINFO.strings[iconthumblistDATAINFO.IndexOfName(caption)]+
            '}','{','}','=',6)));

if FullImage=True then
begin
 image1.picture.bitmap.FreePixmap;
     image1.align:=alclient;
        image1.AutoSize:=false;
        image1.Stretch:=false;
        image1.center:=true;
 
 
            if (BB.width>image1.width)or(BB.height>image1.height)then
  DisplayBitmap(BB,image1) else image1.Picture.assign(BB);

FullImage:=false;;
ConstraintImage:=True;
end else
begin
image1.align:=alclient;
        if (BB.width>image1.width)or(BB.height>image1.height)then
           begin
           EnableAutoRange; 
       image1.align:=alnone;
        image1.AutoSize:=true;
        image1.Stretch:=false;
        image1.center:=true;
  image1.picture.bitmap.FreePixmap;
      end else
            begin
           EnableAutoRange; 
       image1.align:=alclient;
        image1.AutoSize:=false;
        image1.Stretch:=false;
        image1.center:=true;
  image1.picture.bitmap.FreePixmap;
      end ;
     image1.picture.assign(BB);  
    
  
 FullImage:=True;;
ConstraintImage:=false;
end ;
BB.free;
end;
except
;

end;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////


end.
