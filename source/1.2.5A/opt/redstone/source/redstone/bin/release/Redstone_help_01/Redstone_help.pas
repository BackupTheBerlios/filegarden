unit Redstone_help;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,Types,inifiles,
  qExtCtrls, QComCtrls,QButtons
  ,RedStone_Public_Comp
  ,PClass_Command_RedStone
  //,PPClass_RedStone
  ;

type
  TRedstone_help = class(TRedStone_Public_Comp)
   procedure createspeedbutton;
  procedure creatememo;
  procedure createview;
  procedure createlistbox;
  procedure createpanel1;
  procedure createpanel2;
   procedure createpanel3;
  procedure createsplitter;
   procedure SpClick(Sender: TObject);
  procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
   
  private
    //d:TPPClass_RedStone;
     view1:TTextBrowser;
     LB:tListBox;
     ini:tinifile; 
   index:string;
        l1:tstringlist;
        APASSFORM:tform;
ini2:tinifile;
 K:TPClass_Command_RedStone;
   F:tform;
     p1,p2,p3:tpanel;
     sp:TSplitter;
     memo1:tmemo;
   AF:TForm;
    speedbutton:tspeedbutton;
HelpParentDIR:string;

  protected
 
  public
  
  
constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
                             
destructor Destroy; override;

  published

  end;
   

implementation

constructor TRedstone_help.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList);
begin
inherited;
 // K:=TPClass_Command_RedStone.Create(application.Handle,APass_Form,application.exename);
   K:=TPClass_Command_RedStone.create(application.handle,APass_Form,APass_ExeName);

APASSFORM:=APass_Form;
AF:=APass_Form;
F:=nil; 
application.handle:=nil;
application.handle:=APass_Handle;
//index:=extractfilepath(AProc)+'/help/index.html';
HelpParentDIR:=k.RS_mainpath;
index:=HelpParentDIR+'/help/index.html';
     
        ini2:=TInifile.create(k.RS_Redstone_UserSysRecIni);
l1:=tstringlist.create;
 Ini2.ReadSection('Redstone_help',l1); 
  Ini := TIniFile.Create (k.RS_AppConfigPath+'/help.conf');   


  try
    F := TForm.Create (AF);

    F.caption:=APass_Form.caption+' Help';
  //   F.caption:=Ini.ReadString ('help', 'Create menu item', 'none');
     f.width:=700;
     f.height:=500;
 //  F.caption:=k.RedStone_SysPath;
      createpanel1;
         createpanel2;
     createsplitter;
  
       createpanel3;
       createspeedbutton;
     createListBox;
  //  creatememo;
createview;
 f.position:=poscreencenter;
F.onclose:=Formclose;
     F.Show;
  
    Ini.ReadSection('help',lb.Items); 
    
  except
   on E: Exception do
    begin
    MessageDlg ('Error in Component: ' +
        E.Message, mtError, [mbOK], 0);
//   showmessage('Testing Component' );  
f.close;
//f.free;
end;
end;
end;
destructor TRedstone_help.Destroy;
begin


inherited;

end;

procedure TRedstone_help.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // used by the modeless form
 
 if ini2<>nil then     ini2.free;
  if l1<>nil then         l1.free;
  if k<>nil then    k.free;   
// if F<>nil then   F.Free;
  AF.close;
 
 Action := caFree;

  // application.terminate;
end;

procedure TRedstone_help.createspeedbutton;
var  mi,sbint:integer;

 
begin
   sbint:=5;
 


 for mi := 0 to l1.Count - 1 do 
begin
speedbutton:=TSpeedButton.Create (f);
speedbutton.parent:=p3;
 speedbutton.left:=sbint;
      speedbutton.Top := 1;
      speedbutton.Width := 32;
      speedbutton.Height := 32;
    speedbutton.Hint :=l1.Strings[mi];
   //   speedbutton.caption:=' ';
      speedbutton.Flat := true;
      speedbutton.Layout := blGlyphTOP;
     SpeedButton.Glyph.LoadFromFile(Ini2.Readstring ('Redstone_help', l1.Strings[mi], 'none'));
// SpeedButton.Glyph.LoadFromFile('/opt/redstone/FileGarden/image/clear.png');
      speedbutton.ParentShowHint := False;
      speedbutton.ShowHint := True;
      speedbutton.Spacing := 5;
    speedbutton.OnClick := spclick;
speedbutton.visible:=true;
sbint:=sbint+32+10;
end;
 
end;


 procedure TRedstone_help.SpClick(Sender: TObject);
var TEMPComponent,Temp:TCOMPONENT;i,ii:integer;xfgmemo:tmemo;
 begin
 with (sender as tspeedbutton) do
 begin
 if hint='Forward' then view1.forward;
 if hint='Backward' then view1.Backward;
 if hint='Reload' then view1.LoadFromFile(view1.FileName);
 if hint='Home' then view1.LoadFromFile(index);
 if hint='Email' then begin


  end;




 

end;
 end;
 

procedure TRedstone_help.creatememo;


begin
   memo1:=tmemo.create(f);
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
     // Font.Name := 'courier';
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
procedure TRedstone_help.createview;


begin
   view1:=TTextBrowser.create(f);
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
 procedure TRedstone_help.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
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
 
procedure TRedstone_help.createlistbox;
begin
LB:=tlistbox.create(f);
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

procedure TRedstone_help.createpanel1;
begin
p1:=tpanel.create(f);
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

procedure TRedstone_help.createpanel2;
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
procedure TRedstone_help.createpanel3;
begin
p3:=tpanel.create(f);
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
procedure TRedstone_help.createsplitter;
begin
sp:=tsplitter.create(f);
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

registerclass(TRedstone_help);
finalization
unregisterclass(TRedstone_help);
end.
