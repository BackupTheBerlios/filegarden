unit aaa;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types
  ,RedStone_Public_Comp ,PClass_Command_RedStone
  //,PPClass_RedStone
  ;

type
  Taaa = class(TRedStone_Public_Comp)
        procedure memoonclick(sender:tobject); 
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
 
  private
    K:TPClass_Command_RedStone;
    F:tform;
 
AF:TForm;
memo:tmemo;
  protected

  public
  
    constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
    destructor Destroy; override;
  published

  end;
   

implementation

constructor Taaa.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); 
var  sr: TSearchRec;  FileAttrs,i: Integer; 
begin
inherited;

AF:=APass_Form;
F:=nil; 
 application.handle:=nil;
 application.handle:=APass_Handle;
  k:=TPClass_Command_RedStone.Create(APass_Handle,AF,APass_ExeName);

  F := TForm.Create (application);
 try 
  
  
     F.caption:='Testing component template';
//   f.caption:=GetEnvironmentVariable('HOME');
       F.onclose:=FormClose;
     F.Show;
     F.width:=screen.width-100;
     F.height:=screen.height-100;
   
       memo:=tmemo.create(f);
 memo.parent:=f;
     with memo as tmemo do
    begin
      Left := 2;
      Top := 2;
    //  Width := 610;
    //  Height := 428;
      Align := alClient;
       onclick:=memoonclick; 
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
//  if FindFirst('~/xfg.conf', faAnyFile, sr) = 0 then f.caption:='~/xfg.conf';
 //   FindClose(sr); 
 for  I := 0 to Screen.FormCount-1 do
  begin
 
   memo.lines.add(Screen.Forms[I].Name+'--->'+Screen.Forms[I].caption);
    
       
   end;

memo.lines.add(k.CRS_Print_Properties2Str); 
memo.lines.add('Calling Sender Hint or Caption ================>           '+APassCallingCaptionHint); 

  except
   on E: Exception do
    begin
    MessageDlg ('Error in Component: ' +
        E.Message, mtError, [mbOK], 0);
//   showmessage('Testing Component' );  
AF.close;         
   
  // application.terminate;
    end;
  end;
  memo.lines. add(' ');
  memo.lines. add(' ');
  memo.lines. add('(******************************************************************)');
  memo.lines. add('                    These text was from xfg editor                  ');
  memo.lines. add('(******************************************************************)');
  memo.lines. add(' ');
memo.lines. add(APassStringList.text);


end;

  procedure Taaa.memoonclick(Sender: TObject);
   begin
 //  f.free;
 //

 
 
end;

   procedure Taaa.FormClose(Sender: TObject; var Action: TCloseAction);
   begin
 
  //  Action := caFree;
 AF.close;
 //AF:=nil;
 //   F.Free;

 
 
end;



destructor Taaa.Destroy;
begin

inherited;

end;



initialization
registerclass(Taaa);
finalization

unregisterclass(Taaa);
end.
