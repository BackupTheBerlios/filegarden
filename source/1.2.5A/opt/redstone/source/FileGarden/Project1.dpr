program Project1;

uses
 SysUtils, QDialogs, QControls, QForms,QStyle,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4};
 
{$R *.res}


begin


  Application.Initialize;
Application.style.defaultstyle:=dsPlatinum;
//(dsWindows, dsMotif, dsMotifPlus, dsCDE, dsQtSGI, dsPlatinum, dsSystemDefault)
 Application.CreateForm(TForm1, Form1);
form1.hide;
  Application.CreateForm(TForm2, Form2);
Form2.hide;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
form1.show;
Form2.show; 
form1.xfgmemo.clear;
  Application.Run;


end.
 
