program Command_Redstone;
 
uses  QForms ,QDialogs,SysUtils,QStyle,
 CRS in 'CRS.pas' {Form1};
{$R *.res}

begin
//  Application.Initialize;
//  Application.CreateForm(TForm1, Form1);
//application.ShowMainForm:=false;
//form1.hide;
//postquitmessage(0);
//  Application.Run;
(******************************************************************************************)
if (Paramcount<3) and(AnsiPos('%PROC%',ParamStr(1))<1)then   begin
MessageDlg ('Error in Component: ', mtinformation, [mbOK], 0);
application.terminate; 
end else
begin
  Application.Initialize;
Application.style.defaultstyle:=dsPlatinum;
application.font.name:='helvetica';
  Application.CreateForm(TForm1, Form1);
  application.ShowMainForm:=false;
  Application.Run;
end;
(******************************************************************************************)

end.
