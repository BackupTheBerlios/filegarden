unit Redstone_sendtoprinter;

interface

uses
  Qt,SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,  QStdCtrls,
  qExtCtrls,inifiles,types
  ,RedStone_Public_Comp ,PClass_Command_RedStone
  //,PPClass_RedStone
  ;

type
  TRedstone_sendtoprinter = class(TRedStone_Public_Comp)
        procedure memoonclick(sender:tobject); 
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
 
  private
    K:TPClass_Command_RedStone;
    F:tform;
 
AF:TForm;
P:Tpanel;
  protected

  public
  
    constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
    destructor Destroy; override;
  published

  end;
   

implementation

constructor TRedstone_sendtoprinter.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); 
var  sr: TSearchRec;  FileAttrs,i: Integer; 
begin
inherited;

AF:=APass_Form;
//F:=nil; 
 application.handle:=nil;
 application.handle:=APass_Handle;
  k:=TPClass_Command_RedStone.Create(APass_Handle,AF,APass_ExeName);
try
  F := TForm.Create (application);
  
    try
  
     F.caption:='Testing component template';
//   f.caption:=GetEnvironmentVariable('HOME');
       F.onclose:=FormClose;
    // F.ShowModal;
     F.width:=screen.width-100;
     F.height:=screen.height-100;
 P:=tpanel.create(application);
with p as tpanel do
begin
parent:=f;
align:=alclient;
caption:='To be implemented , please go to  http://redstone.sourceforge.net/   '+#13#10+
'to download this component.'+#13#10;



end; 
 F.ShowModal;
finally
K.free;
F.free;

end;
  except
   on E: Exception do
    begin
    MessageDlg ('Error in Component: ' +
        E.Message, mtError, [mbOK], 0);
//   showmessage('Testing Component' );  
K.free;
F.free;      
   
  // application.terminate;
    end;
  end;

end;

  procedure TRedstone_sendtoprinter.memoonclick(Sender: TObject);
   begin
 //  f.free;
 //

 
 
end;

   procedure TRedstone_sendtoprinter.FormClose(Sender: TObject; var Action: TCloseAction);
   begin
 
  //  Action := caFree;
// AF.free;
 //AF:=nil;
 //   F.Free;

 
 
end;



destructor TRedstone_sendtoprinter.Destroy;
begin

inherited;

end;



initialization
registerclass(TRedstone_sendtoprinter);
finalization

unregisterclass(TRedstone_sendtoprinter);
end.
