Try to follow the file directory structure for first time installation ::

VERSION : 1.2.4A
DATE    : 1.9.2004 
CONTACT : alred@singnet.com.sg

ChangeLog : Add support for execution from user's home directory
            Some changes to directory structure of the program

Suggestion and advice are welcome from anybody.Don't hesitate.
Any new features suggested will be consider seriously as long as
it is within my ability.

1) Login as root ,Uncompress the gzip file into " /opt " under the root
   directory . eg.

/opt/
    - redstone/
              - FileGarden/
              - mainlib/

2) Put line this into /etc/ld.so.conf
    
 
   /opt/redstone/mainlib

 
3) Type ldconfig in your terminal and press enter

4) Put line this into your login startup script
    example : ~/.bash_profile

   export LD_LIBRARY_PATH=/opt/redstone/mainlib

5)Create a symlink from " /opt/redstone/FileGarden/filegarden-install "
  to " /usr/bin/filegarden-install "
  eg. ln -s /opt/redstone/FileGarden/filegarden-install /usr/bin/
  
6)Logout your linux session( ** not X session ** ) and login again

7)Login as normal user , type " filegarden-install "
  in your terminal and press enter.This will install the program into 
  your home directory. eg. " ~/redstone/FileGarden "
  Watch for errors in your terminal and send me an email if problems
  with libraries not found , runtime error , segmentation faults etc

8)Execute the command " ~/redstone/FileGarden/FileGarden " from your terminal.
  
  The above procedure should work , email me if you encounter any 
  problem.
  
8)Read the configuration file and compare it to the program,s interface
  You should be able to figure it out structure of the file :
  
   ~/redstone/FileGarden/xfg.conf

  note : try to be case-sensitive and neat with configurations
         enscript must be installed to run the program and the 
         page setup dialog
         
EMAIL :  alred@singnet.com.sg

The purpose of this software is to showcase  Linux's  limitless power in files processing.
The build-in plus some free third parties  commandline file utilities coupled with
an implementation of Graghic User Interface in X is limitless.For my case with
the help of Borland Kylix components programming.Hopes that this software will be
a great help for some.
The images use in this sofware are taken from RedHat Linux 9 distribution.
ImageMagik , Ghostscript , gsview and netpnm are being used by this sofware.
Kylix Open Edition ,Kylix vcl component technology are being used by this sofware. 
I  have  included  a  license text , GPL text and a deploy text from Borland and for
Borland  in  the compressed file , please read it and send me some clues
about it.  

I am not responsible for any damage and any hazards of any kinds caused
by this software in execution and installalion.
You are free to download  and use this software at your own risk. 
If you  like  this  sofware  ,  please send in donations in the forms of 
postcards,junks,antique computers or money of any amount.

Email me your response,suggestion,corrections.

thankyou
