unit RS_IO;

interface

function RSxxx1(APASSOldFilename,APASSNewFilename: PCHAR): Boolean; cdecl; 
function RSxxx2(APASSFilename: PCHAR): Boolean; cdecl; export;
function RSxxx3(APASSOldFilename,APASSNewFilename: String): Boolean; cdecl; 
implementation

function RSxxx1; external 'librsio.so' name 'RSxxx1';
function RSxxx2; external 'librsio.so' name 'RSxxx2';
function RSxxx3; external 'librsio.so' name 'RSxxx3';

end.
 
