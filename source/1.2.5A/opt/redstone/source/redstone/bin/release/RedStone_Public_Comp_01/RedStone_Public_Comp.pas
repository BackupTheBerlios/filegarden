unit RedStone_Public_Comp;

interface

uses
  SysUtils, Qt,  Classes, qGraphics, qControls, qForms, qDialogs;
              //  Qt, QTypes, SysUtils, Classes, Types, QGraphics, QControls, QMenus,
 // QActnList, QStyle, HelpIntfs
type
 TRedStone_Public_Comp=class;
 TRedStone_Internal_Public_Comp=class of TRedStone_Public_Comp;

TRedStone_Public_Comp =class(TPersistent)

  private


  protected

  public

    constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); Virtual;
    destructor  Destroy; override;


  published

  end;



implementation

  constructor TRedStone_Public_Comp.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); 
begin
 inherited Create;

 /////
end;

destructor TRedStone_Public_Comp.Destroy;
begin
////
////
  inherited Destroy;
end;







end.
 