unit template;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,Types,inifiles,
  qExtCtrls, QComCtrls,QButtons,QPrinters,libc
  ,RedStone_Public_Comp
  ,PClass_Command_RedStone
  //,PPClass_RedStone
  ;

type
  Ttemplate = class(TRedStone_Public_Comp)
   procedure createspeedbutton;
  procedure creatememo;
  procedure createview;
  procedure createlistbox;
  procedure createpanel1;
  procedure createpanel2;
   procedure createpanel3;
  procedure createsplitter;
    procedure bbclick(Sender: TObject);
   procedure SpClick(Sender: TObject);
  procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   
  private
    //d:TPPClass_RedStone;
    bb1:tbutton;
     view1:TTextBrowser;
     LB:tListBox;
     ini:tinifile; 
   index:string;
       l1:tstringlist;
ini2:tinifile;
 K:TPClass_Command_RedStone;
   F:tform;
     p1:tpanel;
     p2:tpanel;
     p3:tpanel;
     sp:TSplitter;
     memo1:tmemo;
   AF:TForm;
   speedbutton:tspeedbutton;


  protected
 
  public
  
  
constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
destructor Destroy; override;

  published

  end;
   

implementation


procedure Ttemplate.bbclick(Sender: TObject);
var
  Output: PIOFile;
  line: PChar;
  txt: string;
  str: string;
  StrLst: TStringList;
  rb: integer;
const
  BufferSize: Integer = 1000;
begin
 memo1.lines.clear;
 SetLength(txt,0);
  Output := popen('cp * /bbb/kk','r');
  StrLst := TStringList.Create;
  GetMem(Line,BufferSize);
  StrLst.Add('Hallo');

  if Assigned(output) then
  begin
    while FEOF(Output)=0 do
    begin
      rb := libc.fread(line,1,BufferSize,output);
      SetLength(Txt,length(txt)+rb);
      MemCpy(@txt[length(txt)-(rb-1)],line,rb);
      while pos(#10,txt) > 0 do
      begin
        str := copy(txt,1,pos(#10,txt)-1);
        StrLst.Add(str);
        txt := copy(txt,pos(#10,txt)+1,length(txt));
      end;
    end;
  end;

  Memo1.Lines.AddStrings(StrLst);
  StrLst.Free;

  libc.pclose(output);
  wait(nil);
  FreeMem(Line,BufferSize);
  
////////////////////////////////////////////////////////end;///

end;


constructor Ttemplate.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); 
                                  
var s,s11,s22,s33:string;
 s1,s2,s3:PChar;
ls:tstrings;
h:Thandle;
i,ii,iii,ph,phi,event,mpi,mpii,phii,ppp,icur:integer;
 r: TRect;
 


begin

 //Randomize;
 //ram:='/tmp/'+ExtractFileName(Application.ExeName)+inttostr(Random(628));
 //memo1.lines.savetofile(rm);
//ss:=k.RedStone_SysPath+'Command_Redstone '+(Sender as TMenuItem).Caption+' '+Application.ExeName+' '+rm+'&';
//Libc.system(pchar(ss));
//
//l:=tstringlist.create;
//k:=TPClass_Command_RedStone.Create(application.Handle,form1,Application.ExeName);
//k.LoadCompVCL(ParamStr(1),ExtractFilePath(ParamStr(2)),l);
inherited;
AF:=APass_Form;
F:=nil; 
 application.handle:=nil;
 application.handle:=APass_Handle;
//index:=AProc+'/help/index.html';
   K:=TPClass_Command_RedStone.create(application.handle,APass_Form,APass_ExeName); 
     
    //    ini2:=TInifile.create(k.RedStone_SysPath+'redsys.rec');
//l1:=tstringlist.create;
// Ini2.ReadSection('template',l1); 
//  Ini := TIniFile.Create (AProc+'/help/help.conf');    
  F := TForm.Create (application);
  try
    F.caption:=APass_Form.caption+' template';
  //   F.caption:=Ini.ReadString ('help', 'Create menu item', 'none');
     f.width:=700;
     f.height:=500;
 //  F.caption:=k.RedStone_SysPath;
  createpanel1;
         createpanel2;
  createsplitter;
  bb1:=tbutton.create(nil);
  bb1.parent:=p1;
  bb1.top:=10;
  bb1.left:=10;
  bb1.width:=150;
  bb1.onclick:=bbclick;
  bb1.caption:='io-shell-open-cmdline';
  //     createpanel3;
  //     createspeedbutton;
 //    createListBox;
    creatememo;
//createview;

F.onclose:=Formclose;
     F.Show;
     getdir(0,s);
     
  memo1.lines.assign(APassStringList);
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
  memo1.lines.add('Directory testing ============================================');
    memo1.lines.add(' ');
  memo1.lines.add(' ');
   memo1.lines.add('GetDir    '+s);
    memo1.lines.add('GetCurrentDir    '+GetCurrentDir);
    SetCurrentDir('/opt');
         memo1.lines.add('SetCurrentDir    '+ GetCurrentDir);
         ChDir('/bin');
              memo1.lines.add('ChDir    '+ GetCurrentDir);
      memo1.lines.add(' ');
  memo1.lines.add(' ');
    memo1.lines.add('Printer testing ============================================');
    memo1.lines.add(' ');
  memo1.lines.add(' ');


  with printer do begin
  i:=printers.count;
  setPrinter ('HP5L-text');
 memo1.lines.add(' setPrinter   '+'HP5L-text');
   memo1.lines.add('Printer count total'+'       '+inttostr(i)+' printers');
 for ii := 0 to printers.count - 1 do 
    memo1.lines.add('Printer count '+'           '+printers.strings[ii]);
        memo1.lines.add('Printer Xdpi            '+inttostr(xdpi));
        memo1.lines.add('Printer Ydpi            '+inttostr(ydpi));
   
    memo1.lines.add('Printer Height            '+floattostr(pageheight/Xdpi));
         memo1.lines.add('Printer Width            '+floattostr(pagewidth/ydpi));
           memo1.lines.add('Printer Height pixel           '+inttostr(pageheight));
         memo1.lines.add('Printer Width pixel           '+inttostr(pagewidth));
   
          if  Orientation=poPortrait
        then memo1.lines.add('Printer Orientation            '+'Portrait');
         if  Orientation=poLandscape
        then memo1.lines.add('Printer Orientation            '+'Landscape');
        memo1.lines.add('Printer Margins X            '+inttostr(Margins.cx));
        memo1.lines.add('Printer Margins Y            '+inttostr(Margins.cy));
        memo1.lines.add('Printer Copies            '+inttostr(Copies));
        if Printing=true then
        memo1.lines.add('Printer now printing            YES');
        if Printing=false then
        memo1.lines.add('Printer now printing            NO');
        if Aborted=true then
        memo1.lines.add('Printer now aborted by user            YES');
        if Aborted=false then
        memo1.lines.add('Printer now aborted by user            NO');
        
//procedure GetPrinter (ADevice, ADriver, APort: PChar; var ADeviceMode: THandle);

      memo1.lines.add(' ');

memo1.lines.add('Current Printer Device            ');
  memo1.lines.add(' ');
  
///////////////////////////////////////////////////////////////////////


      iii:=0;
      icur:=0;
      event:=0;
      ii:=0;
      mpi:=0;
      ppp:=0;
      phi:=1;
      ph:=Pageheight-(50*2);
  setoutputfilename('/666666.ps');
       BeginDoc;
        Canvas.Brush.Style := bsClear;
      Canvas.Brush.Color := clBlack;
 
      memo1.wordwrap:=true;
      
 for i := 0 to Memo1.Lines.Count do 
begin
  
   Canvas.TextOut(0,(0+((i-ppp)) *Canvas.TextHeight(Memo1.Lines.Strings[i])),
                  Memo1.Lines.Strings[i]);



 if ((i-ppp-2) *Canvas.TextHeight(Memo1.Lines.Strings[i])) >  ph
then begin
ppp:=i;
 f.caption:=inttostr(ppp)+'   '+floattostr((pageheight-(Margins.cy*2)) div Xdpi)
 +'   '+inttostr(pageheight)+'   '+inttostr(Margins.cx);
 
newpage;


end;

//icur:=icur+1;
end;


     
     // Canvas.fillrect(r);
   
      EndDoc;
      
  
////////////////////////////////////////////////////////end;///

   //  memo1.lines.add('END =========================================');
  //  Ini.ReadSection('help',lb.Items); 

end; 
  except
   on E: Exception do
    begin
    MessageDlg ('Error in Component: ' +
        E.Message, mtError, [mbOK], 0);
//   showmessage('Testing Component' );  
 //  ls.free;
 AF.close;       
   //   F.Free;
 //   application.terminate;
    end;
  end;
  //  ini2.free;
     //   l1.free;
  
k.free;   
//ini2:=nil;    
//K:=nil;
end;

destructor Ttemplate.Destroy;
begin
 

inherited;

end;

procedure Ttemplate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // used by the modeless form

//  Action := caFree;
    AF.close;
end;

procedure Ttemplate.createspeedbutton;
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
     SpeedButton.Glyph.LoadFromFile(Ini2.Readstring ('template', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
    speedbutton.OnClick := spclick;
speedbutton.visible:=true;
sbint:=sbint+32+10;
end;
 
end;


 procedure Ttemplate.SpClick(Sender: TObject);
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
 

procedure Ttemplate.creatememo;


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
procedure Ttemplate.createview;


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
 procedure Ttemplate.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
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
 
procedure Ttemplate.createlistbox;
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

procedure Ttemplate.createpanel1;
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

procedure Ttemplate.createpanel2;
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
procedure Ttemplate.createpanel3;
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
procedure Ttemplate.createsplitter;
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

registerclass(Ttemplate);
finalization
unregisterclass(Ttemplate);
end.
