library RSIO;

Uses linux;

function RSxxx1(APASSOldFilename,APASSNewFilename: String): Boolean;cdecl; export;
begin
 if not Link (APASSOldFilename,APASSNewFilename) then
      RSxxx1:=false else
      RSxxx1:=true;

end;

function RSxxx2(APASSOldFilename,APASSNewFilename: PChar): Boolean;cdecl; export;
   Var 
    Os ,Ns: String;
begin
 Os:=StrPas (APASSOldFilename) ;
 Ns:=StrPas (APASSNewFilename) ;
 if not Link (Os,Ns) then
      RSxxx2:=false else
      RSxxx2:=true;

end;

function RSxxx3(APASSFilename: PChar): Boolean;cdecl; export;
   Var 
    Fs: String;
begin
 Fs:=StrPas (APASSFilename) ;
 if not unLink (Fs) then
      RSxxx3:=false else
      RSxxx3:=true;

end;

exports
  RSxxx1,RSxxx2,RSxxx3;

end.


