unit Redstone_mail_implant;

interface

uses
//  Qt, SysUtils,Variants, QTypes, QControls,Types,Classes, QForms,QButtons,QMenus,StrUtils,
//  QDialogs, QStdCtrls,inifiles,XLIB,libc, DateUtils, QGraphics, QExtCtrls,QComCtrls

QComCtrls,
   Qt, QDialogs, QStdCtrls, SysUtils, Types, Classes, Variants, QTypes, QGraphics, QControls, QForms,
 
  qExtCtrls,inifiles,QButtons,  QMenus,QClipbrd
  , SyncObjs,StrUtils,libc,DateUtils,mimepart,synautil,synachar

,



QFileCtrls
   ,RedStone_Public_Comp,smtpsend,POP3Send,mimemess


  ,PClass_Command_RedStone
  ;

type
 
  TRedstone_mail_implant = class(TRedStone_Public_Comp)
  procedure UpdateConfiguration;
  procedure ViewMailSource(Item: TListItem);  
    procedure SendMail(MailLst:tstringlist;IsMessageText:Boolean);
    procedure DoClose;
   procedure DoClose2(Sender: TObject; var Action: TCloseAction);
    procedure Mailcreatespeedbutton;
    procedure MAILComposeNew;
    procedure createMailPanelMessage;
    procedure MailcreateListView;
      procedure  GetMailFileListInfo(ApassDirStr:string);
Function PrepareTextToMail(MailTo,MailCc,MailSubject,Mailtext:string;AttachList,OriginalDecodedMessageLst:tstringlist):string;

    procedure MailListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean); 
    //procedure MailListView1Click(Sender: TObject); 
     procedure MailListView1ItemDoubleClick(Sender: TObject; Item: TListItem)  ;
      procedure createMailPanelFolder;
      procedure createMailReadControl;
     procedure MailSpClick(Sender: TObject);
          procedure FOnClose(Sender: TObject; var Action: TCloseAction);
          procedure MailCreatePOP;
          procedure MailCreateSmtp;
                procedure  CheckDeleteTMPAttachment;
 procedure createpagecontrol; 
 procedure HTMLViewOnHighlightText(Sender: TObject; const HighlightedText: WideString);
  procedure HTMLViewOnclick(Sender: TObject);
 procedure HTMLViewOnTextChanged(Sender: TObject);
 procedure HTMLViewOnMouseleave(Sender: TObject) ;
 procedure WriteToActiveMainMemo(APASSlst:Tstringlist;APASSName:string);
   procedure createpopup(sender:TObject);
procedure MailListViewItemClick(Sender:TObject;Button:TMouseButton;Item:TListItem;const Pt:TPoint;ColIndex:Integer);
procedure popupclick(Sender: TObject);
procedure PopupMenuPopup(Sender: TObject);
procedure ClearAllPanel;
procedure DeconstructMail(APASFilename:string);
  private
 //const Pt:TPoint;ColIndex:Integer

  protected
  POPPASSWORD:string;
  MailListViewCanClick:Boolean;
  AttachmentHTMLViewCurrentText,AttachmentHTMLViewHighlightedText,HTMLViewCurrentText,HTMLViewHighlightedText:string;
DoingMIME,DoSource:Boolean;
 
  Mailsplt:tsplitter;
  MAILContainerLst:Tstringlist;
  POP:TPOP3send;
  Smtp:TSmtpsend;
 
MailPanelMessageOn,MailPanelFolderOn:Boolean;
 MailTEMPAttachmentFolder,InfoListViewCurrentDir, QueueFolderDir,MyLetterFolderDir,
 PersonsFolderDir,TRASHFolderDir,OUTBOXFolderDir,INBOXFolderDir:string;
 MailK:TPClass_Command_RedStone;
MailINI:TMemIniFile;

  UserCallingDIR,UserCallingIniconf,UserCallingDataDIR,UserCallingVersion:string;
  
  ComposeNewAttachPopup,
  ComposeNewMemoPopup,
  MaillistviewPopup:tpopupmenu;
  
 Mailspeedbutton:tspeedbutton;
   pc:TPagecontrol;
   
   ComposeNewSpl:Tsplitter;
  ts1,ts2,ts3,ts4,ts5:TTabsheet;
 restartxfg:Boolean;
 // PASSxfgmemo:tmemo;
     form2filelistPanel,form2treeViewPanel:TPanel;
 Mailform2filelist:tfileiconview;Mailform2splitter:Tsplitter;
Mailform2treeView:TListView;
form2filelistDirectory:TDirectory;
  DEBUG:boolean;
  AForm:TFORM;
 MailPanelFolder,MailPanelMessage,ComposememoViewPanel,ComposememoOverWriteViewPanel:TPanel;      
  Maillistview:tlistview;
 EDTolb,EDCclb,EDSubjectlb:Tlabel;
 EDTo,EDCc,EDSubject,EDSmtpServer,EDUsername,EDPOPServer,EDEmail,EDPassword,EDSmtpPort,EDPOPPort:tedit;
 LBSmtpServer,LBUsername,LBPOPServer,LBEmail,LBPassword,LBSmtpPort,LBPOPPort,LBKeepMailOnServer:tlabel;
 EDKeepMailOnServer:tcheckbox;
 HTMLmemoView,ComposememoView:tmemo;LBoxAttach:Tlistbox; AttachmentHTMLView,HTMLView:TTextBrowser;
  public
 
    constructor Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList); override;
    destructor Destroy; override;
  published
 
  end;
const
 Iniconf:string='xfg.conf';  
//var

implementation

constructor TRedstone_mail_implant.Create(APass_Handle:QApplicationH;APass_Form:Tform;const APassCallingCaptionHint,APass_ExeName:string;
                             APassStringList:TStringList);   
var  i,ii,iii:integer;temp:Tcomponent;  ff:tform;tempControl:Tcontrol;Aini:TMemIniFile;
begin
inherited;
DoingMIME:=false;
DoSource:=false;
TimeSeparator := ':';       
// ShortTimeFormat := ''; 
DateSeparator := '-';
  ShortDateFormat := 'dd/mm/yyyy'; 
MailPanelMessageOn:=false;
MailPanelFolderOn:=false;
 application.handle:=nil;
 application.handle:=APass_Handle;

  application.HintPause:=50;
application.HintHidePause:=90000;     
AForm:=APass_Form;

 MailK:=TPClass_Command_RedStone.Create(application.Handle,AForm,application.exename);
//UserCallingDIR:=ExtractFilePath(APass_ExeName);
//UserCallingIniconf:=UserCallingDIR+Iniconf;
//UserCallingDataDIR:=UserCallingDIR+'data/';
//UserCallingDIR:=K.RS_Calling_APPPath+'/';
UserCallingIniconf:=MailK.RS_AppConfigPath+'/'+MailK.RS_App_Configuration_Name+'.'+
MailK.RS_App_Configuration_Extension; 
UserCallingDataDIR:=MailK.RS_APP_data_dir+'/';
//ini:=TMemIniFile.create(ExtractFilePath(Application.ExeName) + 'xfg.conf');
//if not fileexists(UserCallingIniconf) then beep;
//ini:=TMemIniFile.create(UserCallingIniconf);
//if lowercase(Ini.Readstring ('xfgMain', 'DEBUG', 'none'))='true' then DEBUG:=true;

//UserCallingVersion:=lowercase(Ini.Readstring ('xfgMain', 'owner', 'none'));

//GetEnvironmentVariable('HOME')
restartxfg:=false;
DEBUG:=false; 
//////////////////////////////////////////////////////////////////////////////////////////////////
 MailK:=TPClass_Command_RedStone.Create(application.Handle,AForm,application.exename);
MailINI:=nil;
if fileexists(MailK.RS_USER_RESOURCE_PATH+'/XFGVCL_Mail_Implant_Properties')then
begin
//libc.system(pchar('cp '+k.RS_SYSTEM_RESOURCE_PATH+'/XFGVCL_Mail_Implant_Properties'+' '
//                       +UserCallingDataDIR+'xfg0005_XFGVCL_Mail_Implant_Properties_'+'ToBeDeleted'));

MailINI:=TMemIniFile.create(MailK.RS_USER_RESOURCE_PATH+'/XFGVCL_Mail_Implant_Properties');
end else
begin
libc.system(pchar('touch '+MailK.RS_USER_RESOURCE_PATH+'/XFGVCL_Mail_Implant_Properties'));

MailINI:=TMemIniFile.create(MailK.RS_USER_RESOURCE_PATH+'/XFGVCL_Mail_Implant_Properties');

end;
//////////////////////////////////////////////////////////////////////////////////////////////////
//MyLetterFolderDir,PersonsFolderDir,
 try   
if (MailINI.ReadBool ('Main', 'DEBUG', false))=true then DEBUG:=true;
 
 if (MailINI.valueexists('Mail Folder','MailTEMPAttachmentFolder'))and 
 (directoryexists(MailINI.readstring('Mail Folder','MailTEMPAttachmentFolder','')))then
MailTEMPAttachmentFolder:=mailK.crs_makeFullPath(MailINI.readstring('Mail Folder','MailTEMPAttachmentFolder',''))else
begin
forcedirectories(MailK.RS_OnMyTablePath+'/Mail/MailTEMPAttachmentFolder/');
MailTEMPAttachmentFolder:=(MailK.RS_OnMyTablePath+'/Mail/MailTEMPAttachmentFolder/');
MailINI.writestring('Mail Folder','MailTEMPAttachmentFolder',MailTEMPAttachmentFolder)
end;


 if (MailINI.valueexists('Mail Folder','Persons'))and 
 (directoryexists(MailINI.readstring('Mail Folder','Persons','')))then
PersonsFolderDir:=mailK.crs_makeFullPath(MailINI.readstring('Mail Folder','Persons',''))else
begin
forcedirectories(MailK.RS_OnMyTablePath+'/Mail/Persons/');
PersonsFolderDir:=(MailK.RS_OnMyTablePath+'/Mail/Persons/');
MailINI.writestring('Mail Folder','Persons',PersonsFolderDir)
end;

 if (MailINI.valueexists('Mail Folder','My Letter'))and 
 (directoryexists(MailINI.readstring('Mail Folder','My Letter','')))then
MyLetterFolderDir:=mailK.crs_makeFullPath(MailINI.readstring('Mail Folder','My Letter',''))else
begin
forcedirectories(MailK.RS_OnMyTablePath+'/Mail/My Letter/');
MyLetterFolderDir:=(MailK.RS_OnMyTablePath+'/Mail/My Letter/');
MailINI.writestring('Mail Folder','My Letter',MyLetterFolderDir)
end;

 if (MailINI.valueexists('Mail Folder','InBox'))and 
 (directoryexists(MailINI.readstring('Mail Folder','InBox','')))then
INBOXFolderDir:=mailK.crs_makeFullPath(MailINI.readstring('Mail Folder','InBox',''))else
begin
forcedirectories(MailK.RS_OnMyTablePath+'/Mail/InBox/');
INBOXFolderDir:=(MailK.RS_OnMyTablePath+'/Mail/InBox/');
MailINI.writestring('Mail Folder','InBox',INBOXFolderDir)
end;

 if (MailINI.valueexists('Mail Folder','OutBox'))and 
 (directoryexists(MailINI.readstring('Mail Folder','OutBox','')))then
OUTBOXFolderDir:=mailK.crs_makeFullPath(MailINI.readstring('Mail Folder','OutBox',''))else
begin
forcedirectories(MailK.RS_OnMyTablePath+'/Mail/OutBox/');
OUTBOXFolderDir:=(MailK.RS_OnMyTablePath+'/Mail/OutBox/');
MailINI.writestring('Mail Folder','OutBox',OUTBOXFolderDir)
end;

 if (MailINI.valueexists('Mail Folder','Trash'))and 
 (directoryexists(MailINI.readstring('Mail Folder','Trash','')))then
TRASHFolderDir:=mailK.crs_makeFullPath(MailINI.readstring('Mail Folder','Trash',''))else
begin
forcedirectories(MailK.RS_OnMyTablePath+'/Mail/Trash/');
TRASHFolderDir:=(MailK.RS_OnMyTablePath+'/Mail/Trash/');
MailINI.writestring('Mail Folder','Trash',TRASHFolderDir)
end;

 if (MailINI.valueexists('Mail Folder','Queue'))and 
 (directoryexists(MailINI.readstring('Mail Folder','Queue','')))then
QueueFolderDir:=mailK.crs_makeFullPath(MailINI.readstring('Mail Folder','Queue',''))else
begin
forcedirectories(MailK.RS_OnMyTablePath+'/Mail/Queue/');
QueueFolderDir:=(MailK.RS_OnMyTablePath+'/Mail/Queue/');
MailINI.writestring('Mail Folder','Queue',QueueFolderDir)
end;
MailINI.updatefile;

if not AnsiEndsStr('/',trim(INBOXFolderDir)) then INBOXFolderDir:=trim(INBOXFolderDir)+'/';
if not AnsiEndsStr('/',trim(OUTBOXFolderDir)) then OUTBOXFolderDir:=trim(OUTBOXFolderDir)+'/';
if not AnsiEndsStr('/',trim(TRASHFolderDir)) then TRASHFolderDir:=trim(TRASHFolderDir)+'/';
if not AnsiEndsStr('/',trim(MyLetterFolderDir)) then MyLetterFolderDir:=trim(MyLetterFolderDir)+'/';
if not AnsiEndsStr('/',trim(QueueFolderDir)) then QueueFolderDir:=trim(QueueFolderDir)+'/';
(*
for i:=(APass_Form as tform).ComponentCount-1 downto 0 do
begin
 temp := APass_Form.Components[i]; 
     if (APass_Form.Components[i] is Tmemo) then 
      begin
       PASSxfgmemo:=(APass_Form.Components[i] as Tmemo);
    end; 
end;
*) 
if lowercase(ExtractFileName(application.exename))<>'command_redstone' then
begin
for  I := 0 to Screen.FormCount-1 do
begin


if  trim(lowercase(Screen.Forms[I].caption ))='redstone commander' then 
 begin
   ff:=  Screen.Forms[I];
   for ii := ff.ComponentCount - 1 downto 0 do
    begin
     temp := ff.Components[ii]; 
      if (temp is TPanel) then 
     begin
     for iii := (temp as TPanel).ControlCount - 1 downto 0 do
     begin
     if ((temp as TPanel).Controls[iii] is TPanel)and ((temp as TPanel).Controls[iii].name='MailPanelMessage')then 
     begin
     MailPanelMessageOn:=true;
     
     //(temp as TPanel).Controls[iii].free;
     end;
     if ((temp as TPanel).Controls[iii] is TPanel)and ((temp as TPanel).Controls[iii].name='MailPanelFolder')then 
     begin
     MailPanelFolderOn:=true;
     
     
     //(temp as TPanel).Controls[iii].free;
     end    ;
     if ((temp as TPanel).Controls[iii] is TFileIconView) then 
     begin
   //  Write(((temp as TPanel).classname));
     form2filelistPanel:=(temp as TPanel);
     
     Mailform2filelist:=(temp as TPanel).Controls[iii] as TFileIconView;
end;
     if ((temp as TPanel).Controls[iii] is TListView) then 
     begin
    // Write(((temp as TPanel).classname));
     form2treeViewPanel:=(temp as TPanel);
     Mailform2TreeView:=(temp as TPanel).Controls[iii] as TListView;

end;
   if ((temp as TPanel).Controls[iii] is TSplitter) then 
     begin
    // Write(((temp as TPanel).classname));
     Mailform2splitter:=(temp as TPanel).Controls[iii] as TSplitter;
   

end;
   end;
    end;
    end;
 end;
 
  

 

end;//for  I := 0 to Screen.FormCount-1 do
end;//if ExtractFilePath(APass_ExeName)<>'command_redstone' then
 
if (MailPanelMessageOn=false) or (MailPanelFolderOn=false)then
begin
CheckDeleteTMPAttachment;
POP:=nil;
 MAILContainerLst:=nil;

  Smtp:=nil;
createMailPanelMessage;
createMailPanelFolder;
libc.system(pchar('cp '+UserCallingIniconf+' '
                       +UserCallingDataDIR+'xfg0005MailImplantUserCallingIniconf'+'ToBeDeleted'));

Aini:=TMemIniFile.create(UserCallingDataDIR+'xfg0005MailImplantUserCallingIniconf'+'ToBeDeleted');

Aini.writestring('IndependentComponentPanel','MailPanelMessage','1');
Aini.writestring('IndependentComponentPanel','MailPanelFolder','1');
Aini.updatefile;
Aini.free;
libc.system(pchar('cp '+UserCallingDataDIR+'xfg0005MailImplantUserCallingIniconf'+'ToBeDeleted'+
                     ' '+UserCallingIniconf));

Mailcreatespeedbutton;
MailcreateListView;
MailListViewCanClick:=false;
 (*********************************************)
Mailsplt:=tsplitter.create(AForm);
Mailsplt.parent:=MailPanelMessage;
with Mailsplt as tsplitter do
begin
//
//  Left := form2.width-5;
 //   Top := 26;
   align:=altop;
  //  Height := 375;
 //   Beveled := True;
    Color := $00D5A186  ;
    width:=5;
 // Beveled:=true;
   MinSize:=15;
AutoSnap:=false; 

end;
(*********************************************)
createpagecontrol;
EDSmtpServer.text:=MailINI.readString('Mail Setting','SmtpServer','smtp.red.com');
EDPOPServer.text:=MailINI.readString('Mail Setting','PopServer','pop.red.com');
EDEmail.text:=MailINI.readString('Mail Setting','Email','check@email.org');
EDPassword.text:='';
EDSmtpPort.text:=MailINI.readString('Mail Setting','SmtpTargetPort','25');
EDPOPPort.text:=MailINI.readString('Mail Setting','PopTargetPort','110');
EDUsername.text:=MailINI.readString('Mail Setting','Username','root');
EDKeepMailOnServer.checked:=MailINI.readbool('Mail Setting','KeepMailOnServer',true);

UpdateConfiguration;
POPPASSWORD:='';
MailCreatePOP;
MailCreateSmtp;
GetMailFileListInfo(INBOXFolderDir);
InfoListViewCurrentDir:=INBOXFolderDir;
end else
;

  except
  
    on E: Exception do begin
      if MessageDlg ('Error in Component: '+E.Message, mtError, [mbOK], 0) =MROK then
 DoClose
       end;
        


end;

end;



//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
  procedure TRedstone_mail_implant.FOnClose(Sender: TObject; var Action: TCloseAction);
begin
if MailK <> nil then MailK.free;
 if MailINI <> nil then begin MailINI.updatefile;MailINI.free;end;
 Action := caFree;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

  procedure TRedstone_mail_implant.DoClose;
 var ii:integer;
begin
 
 
if Smtp<> nil then Smtp.free;
if pop<> nil then pop.free;
if MAILContainerLst<> nil then MAILContainerLst.free;
 if MailK <> nil then MailK.free;
 if MailINI <> nil then begin MailINI.updatefile;MailINI.updatefile;MailINI.free;end;

end;

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TRedstone_mail_implant.MailCreatePOP;
begin
POP:=nil;
POP:=TPOP3send.create;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TRedstone_mail_implant.MailCreateSmtp;
begin
smtp:=nil;
 smtp:=tsmtpsend.create;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TRedstone_mail_implant.ClearAllPanel;
begin
//MAILComposeNew;

HTMLmemoView.clear;
HTMLView.text:='';
AttachmentHTMLView.text:='';
//ComposememoView.clear;
//LBoxAttach.items.clear;
//pc.activepage:=ts1;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TRedstone_mail_implant.SendMail(MailLst:tstringlist;IsMessageText:Boolean); 
// IsMessageText=true   : Memo.text
// IsMessageText=false  : filelisting
var instr,instr1,strK,MailToIndexSTR:string;
i,ii,MailToIndex:integer;FileListInfoWorkMassage:Tmimemess;
outlst:tstringlist;
begin
UpdateConfiguration;
outlst:=nil;
FileListInfoWorkMassage:=nil;
outlst:=tstringlist.create;
FileListInfoWorkMassage:=TMIMEMESS.create;
if IsMessageText=true then 
begin
strK:=MAILK.CRS_getguid;
outlst.text:=MailLst.text;
outlst.savetofile(UserCallingDataDIR+strK+'-tobedeleted');
MailLst.clear;
MailLst.add(UserCallingDataDIR+strK+'-tobedeleted');
end;


// smtp.Timeout:=MAILINI.readinteger('Mail Setting','Timeout',15); 
 smtp.TargetHost := MAILINI.readstring('Mail Setting','SmtpServer','smtp.red.com'); 
smtp.Password := POPPASSWORD; 
 smtp.TargetPort := inttostr(MAILINI.readinteger('Mail Setting','SmtpTargetPort',25));  
 smtp.UserName := MAILINI.readstring('Mail Setting','Username','root');  
 if (trim(smtp.TargetHost)='')then   
begin
MessageDlg ('No SMTP server defined'+#13#10
            , mtInformation, [mbOK], 0);
pc.activepage:=ts5;
exit;
end;
  if not smtp.Login then
  begin
  MessageDlg ('Can''t reach server address at '+smtp.TargetHost+#13#10
            , mtInformation, [mbOK], 0);
   if not  smtp.Logout then
   exit;     
   end;
   ii:=0;
   try
   MailToIndexSTR:='';
for i:=0 to MailLst.Count-1 do
begin
outlst.clear;
outlst.loadfromfile(MailLst[i]);
FileListInfoWorkMassage.clear;
FileListInfoWorkMassage.Lines.loadfromfile(MailLst[i]);
FileListInfoWorkMassage.DecodeMessage;
if trim(FileListInfoWorkMassage.header.ToList.text)='' then
continue;
instr:='';

 //  smtp.Verify(getemailaddr(Edit1.text));
smtp.MailFrom(MAILINI.readstring('Mail Setting','Email','') , 100);

for MailToIndex:=0 to FileListInfoWorkMassage.header.ToList.count-1 do
begin
  if not smtp.MailTo(getemailaddr(FileListInfoWorkMassage.header.ToList[MailToIndex])) then
   begin
   MailToIndexSTR:=MailToIndexSTR+getemailaddr(FileListInfoWorkMassage.header.ToList[MailToIndex])+#13#10;
//  MessageDlg ('Can''t reach destination address at '+
//  (getemailaddr(FileListInfoWorkMassage.header.ToList[MailToIndex]))+#13#10
 //           , mtInformation, [mbOK], 0);
   
//   continue;     
   end;

end; 

if not smtp.MailData(outlst)then
   begin
  MessageDlg ('Error sender email message body.'+#13#10
            , mtInformation, [mbOK], 0);
   
   continue;     
   end;
ii:=ii+1;
if fileexists(MailLst[i]) then
begin
outlst.savetofile(OUTBOXFolderDir+MAILK.CRS_extractfilename(MailLst[i]));
deletefile(MailLst[i]);
end;
 end;
 


 finally
 if MailToIndexSTR<>'' then MailToIndexSTR:='Can''t reach destination address at '+#13#10+MailToIndexSTR;
  MessageDlg (inttostr(ii)+' of '+inttostr(MailLst.Count)+' messages sent '+#13#10+
              MailToIndexSTR
            , mtInformation, [mbOK], 0);
   if not  smtp.Logout then ;

if FileListInfoWorkMassage<>nil then  FileListInfoWorkMassage.free;
if outlst<>nil then  outlst.free;
GetMailFileListInfo(OUTBOXFolderDir);
 end;



end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TRedstone_mail_implant.UpdateConfiguration;
begin
// EDTo,EDCc,EDSubject,EDSmtpServer,EDUsername,EDPOPServer,EDEmail,EDPassword,EDSmtpPort,EDPOPPort:tedit;
 //LBSmtpServer,LBUsername,LBPOPServer,LBEmail,LBPassword,LBSmtpPort,LBPOPPort,LBKeepMailOnServer:tlabel;
 //EDKeepMailOnServer:tcheckbox;
 //MailINI.readString('Mail Setting','PopServer','pop.red.com');
// MailINI.readBool('Mail Setting','KeepMailOnServer',true);
MailINI.writeString('Mail Setting','SmtpServer',EDSmtpServer.text);
MailINI.writeString('Mail Setting','PopServer',EDPOPServer.text);
MailINI.writeString('Mail Setting','Email',EDEmail.text);
MailINI.writeString('Mail Setting','SmtpTargetPort',EDSmtpPort.text);
MailINI.writeString('Mail Setting','PopTargetPort',EDPOPPort.text);
MailINI.writeString('Mail Setting','Username',EDUsername.text);
MailINI.writebool('Mail Setting','KeepMailOnServer',EDKeepMailOnServer.checked);
POPPASSWORD:=EDPassword.text;
MailINI.updatefile;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TRedstone_mail_implant.MailSpClick(Sender: TObject);
(*
 InfoListViewCurrentDir, 
 MyLetterFolderDir,
 PersonsFolderDir,
 TRASHFolderDir,
 OUTBOXFolderDir,
 INBOXFolderDir:string;
*)
 var  i,ii:integer;cm,temp:TControl;instr,mailID:string;KeepMailOnServer:boolean;lst:tstringlist;
 begin
 with (sender as tspeedbutton) do
 begin

  if lowercase(caption)='configure' then
  begin
 pc.activepage:=ts5 ;
 UpdateConfiguration;
 
   end;
   
  if lowercase(caption)='get all' then
  begin
  UpdateConfiguration;
    with pop as TPOP3send do
begin
TargetHost:=MailINI.readString('Mail Setting','PopServer','pop.red.com');
 TargetPort:=inttostr(MailINI.readinteger('Mail Setting','PopTargetPort',110));
  UserName:=MailINI.readString('Mail Setting','Username','root');
KeepMailOnServer:=MailINI.readBool('Mail Setting','KeepMailOnServer',true);
//Timeout:=MAILINI.readinteger('Mail Setting','Timeout',15); 
Password:=POPPASSWORD;
 if (trim(Password)='')then   
begin
MessageDlg ('Unable to login , check your password'+#13#10
            , mtInformation, [mbOK], 0);
pc.activepage:=ts5;
exit;
end;
if (trim(TargetHost)='')then   
begin
MessageDlg ('No POP server defined'+#13#10
            , mtInformation, [mbOK], 0);
pc.activepage:=ts5;
exit;
end;

  if  not Login then 
  begin
  MessageDlg ('Cannot reach your mail server at '+#13#10+
            TargetHost+' as user '+UserName+#13#10, mtInformation, [mbOK], 0);
  exit;
  end else
  begin
 if not stat then 
 begin
   MessageDlg ('Cannot retrieve mail count from your mail server at '+#13#10+
            TargetHost+' as user '+UserName+#13#10, mtInformation, [mbOK], 0);
if not logout then 
exit;
end;
if statcount>0 then
begin
if not list(0)then
 begin
   MessageDlg ('Cannot retrieve mail listing from your mail server at '+#13#10+
            TargetHost+' as user '+UserName+#13#10, mtInformation, [mbOK], 0);
if not logout then 
exit;
end else
 begin
//MAILContainerLst.clear;
//MAILContainerLst.assign(FullResult);
 for i:=1 to statcount do
 begin
 if not Retr(i)then continue else
 begin
  mailID:=MailK.crs_getguid;
 FullResult.savetofile(INBOXFolderDir+'/'+mailID);
  if not KeepMailOnServer then
  if not dele(i)then continue;
  end;
end;
end;
end else
if statcount=0 then
MessageDlg ('No new mail in your mail box from '+#13#10+
            TargetHost+' as user '+UserName+#13#10, mtInformation, [mbOK], 0);
if not logout then exit;

  end ;
GetMailFileListInfo(INBOXFolderDir);  
InfoListViewCurrentDir:=INBOXFolderDir;
pc.activepage:=ts1;
 end;//with pop as TPOP3send do
 
   end;//if lowercase(caption)='get all' then
   




if lowercase(caption)='info' then 
begin
pc.activepage:=ts2;
lst:=tstringlist.create;
lst.add('<!DOCTYPE doctype PUBLIC "-//w3c//dtd html 4.0 transitional//en">');
lst.add('<html>');
lst.add('<head>');
lst.add('<title> FileGarden Mailer</title>');
lst.add('</head>');
lst.add('<body bgcolor=white>');
lst.add('<pre>');
lst.add('<font size=4 face=Helvetica>');
lst.add('FileGarden Mailer</font>');
lst.add('<font size=4 face=Helvetica>');
lst.add('This Mailer was developed using <a href="http://www.ararat.cz/synapse/">SYNAPSE library</a>.');
lst.add('<i>SYNAPSE library was not developed by the author of FileGarden</i>');
lst.add(' ');
lst.add('<a href="http://www.ararat.cz/synapse/">SYNAPSE library home page</a>');
lst.add('<a href="http://www.ararat.cz/synapse/files/synapse.zip">SYNAPSE library DOWNLOAD</a>');
lst.add('</font>');
lst.add('');
lst.add('<font size=4 face=Helvetica>');
lst.add('<i>Below is an extracts from SYNAPSE library documentation</i></font>');
lst.add('');
lst.add('<CENTER>');
lst.add('<FONT FACE="sans-serif" SIZE="+1" COLOR="Blue">');
lst.add('<B>Synchronous TCP/IP Library for Delphi,<br> C++ Builder, Kylix and FreePascal</B>');
lst.add('</FONT>');
lst.add('</CENTER>');
lst.add('');
lst.add('</pre>');
lst.add('');
lst.add('<FONT FACE="sans-serif" SIZE="+1" COLOR="Blue"><B>Project idea:</B></FONT>');
lst.add('The <FONT COLOR="Blue"><a href="http://www.ararat.cz/synapse/">SYNAPSE library</a></FONT> aims to create a complete library of classes and functions that would markedly simplify application programming of network communication using Winsock.');
lst.add('At first glance this effort might seem needless as there are many free components covering this area, However they mostly use asynchronous methods while SYNAPSE library operates in a synchronous method.');
lst.add('After having a look at ''competitive'' libraries I must say all of them were created relatively early (for Delphi 1.0 and Win16). Thanks to cooperative multitasking, a synchronous access to Winsock was not possible. This is the reason why ');
lst.add('Microsoft added asynchronous mode to Winsock implementation.');
lst.add('Authors did not want to rewrite their libraries after WIN32 arrived and so their work still remains in asynchronous mode. Somewhere here is the root of Delphi programmers'' myth that Winsock operates just asynchronously. However, ');
lst.add('synchronous mode is more natural in pre-emptive multitasking and multithreading environment. Synchronous mode (called ''blocking'' in Winsock terminology) features acting thread waits until the needed operation terminates. Thus when');
lst.add('we want to send data, the program exits function only after data is sent - or - if we want to receive data, the program exits the function only after the desired data is received.');
lst.add('Thus, much more crisp and simple programming is achieved. You especially feel it when trying to implement any Internet protocol, which is typically based on ''send-wait for reply'' method. If you want to implement it in an ');
lst.add('asynchronous method, you would have to accept complicated event processing and synchronous mode simulation. Therefore a synchronous socket is simple and natural for the majority programming tasks.');
lst.add('The whole library is oriented on the WIN32 environment or Linux enviroment, so you will need Delphi 3.0 or higher and Kylix 1.0 or higher to use it.');
lst.add(' ');
lst.add('<pre>');
lst.add('==============================================================================');
lst.add('<font size=4 face=Helvetica>');
lst.add('<b>SYNAPSE library copyright notice</b></font></font>');
lst.add(' ');
lst.add('Copyright (c)1999-2002, Lukas Gebauer');
lst.add('All rights reserved.');
lst.add(' ');
lst.add('Redistribution and use in source and binary forms, with or without');
lst.add('modification, are permitted provided that the following conditions are met:');
lst.add('Redistributions of source code must retain the above copyright notice, this');
lst.add('list of conditions and the following disclaimer.');
lst.add('Redistributions in binary form must reproduce the above copyright notice,');
lst.add('this list of conditions and the following disclaimer in the documentation');
lst.add('and/or other materials provided with the distribution.');
lst.add('Neither the name of Lukas Gebauer nor the names of its contributors may');
lst.add('be used to endorse or promote products derived from this software without');
lst.add('specific prior written permission.');
lst.add('THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"');
lst.add('AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE');
lst.add('IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE');
lst.add('ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR');
lst.add('ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL');
lst.add('DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR');
lst.add('SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER');
lst.add('CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT');
lst.add('LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY');
lst.add('OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH');
lst.add('DAMAGE.');
lst.add('==============================================================================');
lst.add('</pre>');
lst.add('</font>');
lst.add('</body>');
lst.add('</html>');
HTMLViewCurrentText:=lst.text;
HTMLView.text:=lst.text;
lst.free;
end;




if lowercase(caption)='compose new' then 
begin
MAILComposeNew;
end;
if lowercase(caption)='queue' then 
begin
ClearAllPanel;
InfoListViewCurrentDir:=QueueFolderDir;
GetMailFileListInfo(InfoListViewCurrentDir);
end;
if lowercase(caption)='inbox' then 
begin 
ClearAllPanel;
InfoListViewCurrentDir:=INBOXFolderDir;
GetMailFileListInfo(InfoListViewCurrentDir);
end;
if lowercase(caption)='outbox' then 
begin 
ClearAllPanel;
InfoListViewCurrentDir:=OUTBOXFolderDir;
GetMailFileListInfo(InfoListViewCurrentDir);
end;//MyLetterFolderDir,PersonsFolderDir,
if lowercase(caption)='persons' then 
begin 
ClearAllPanel;
InfoListViewCurrentDir:=PersonsFolderDir;
GetMailFileListInfo(InfoListViewCurrentDir);
end;
if lowercase(caption)='my letter' then 
begin 
ClearAllPanel;
InfoListViewCurrentDir:=MyLetterFolderDir;
GetMailFileListInfo(InfoListViewCurrentDir);
end;
if lowercase(caption)='trash' then 
begin 
ClearAllPanel;
InfoListViewCurrentDir:=TRASHFolderDir;
GetMailFileListInfo(InfoListViewCurrentDir);
end;
if lowercase(caption)='exit' then 
begin 
ClearAllPanel;
//createMailPanelMessage;
//createMailPanelFolder;

//MailCreatePOP//DoClose;
end;

end;
 end;
 
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

 procedure TRedstone_mail_implant.DoClose2(Sender: TObject; var Action: TCloseAction);
 var ii:integer;
begin


end;
 //////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
procedure TRedstone_mail_implant.Mailcreatespeedbutton;
var  
 mi,sbint,sbLeft:integer;ss,sectionSTR:string;Aini:TMemIniFile;
 l1:tstringlist;
begin

 l1:=tstringlist.create;
Aini:=nil;
if not fileexists(MailK.RS_USER_RESOURCE_PATH+'/XFGVCLOptionPanel')then
if fileexists(MailK.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel')then
libc.system(pchar('cp '+MailK.RS_SYSTEM_RESOURCE_PATH+'/XFGVCLOptionPanel'+' '
                       +MailK.RS_USER_RESOURCE_PATH+'/XFGVCLOptionPanel'));
if fileexists(MailK.RS_USER_RESOURCE_PATH+'/XFGVCLOptionPanel')then
begin


Aini:=TMemIniFile.create(MailK.RS_USER_RESOURCE_PATH+'/XFGVCLOptionPanel');
if Aini.SectionExists('Mail Implant')then 
begin
Aini.ReadSection('Mail Implant',l1) ;

sectionSTR:='Mail Implant';
end else
begin
libc.system(pchar('cp '+UserCallingIniconf+' '
                       +UserCallingDataDIR+'xfg0002MailImplant'+'ToBeDeleted'));
 
Aini:=TMemIniFile.create(UserCallingDataDIR+'xfg0002MailImplant'+'ToBeDeleted');
Aini.ReadSection('xfgOptionsSidePanel',l1);
 sectionSTR:='Redstone_mail_implant';
 end;
end;
   sbLeft:=8;
   sbint:=10;
 for mi := 0 to l1.Count - 1 do 
begin
if AnsiLowercase(l1.Strings[mi])='mailtempattachmentfolder'then continue;
 if sbint+70+3>form2filelistPanel.Height then begin sbLeft:=8+95+8;sbint:=10;end;
Mailspeedbutton:=TSpeedButton.Create (nil);
Mailspeedbutton.parent:=MailPanelFolder;
 Mailspeedbutton.left:=sbLeft;
 Mailspeedbutton.font.style:=[fsbold];
 Mailspeedbutton.font.color:=clwhite;
  Mailspeedbutton.font.name:='sans';
      Mailspeedbutton.Top := sbint;
      Mailspeedbutton.Width := 95;
      Mailspeedbutton.Height := 70;
  
 
    ss:= l1.Strings[mi];

      Mailspeedbutton.Hint :=ss;
       Mailspeedbutton.caption:=ss;
      Mailspeedbutton.Flat := true;
      Mailspeedbutton.Layout := blGlyphTOP;
      if fileexists(stringreplace(Aini.Readstring (sectionSTR, l1.Strings[mi], 'none')
,'[HOME]',GetEnvironmentVariable('HOME'),[rfReplaceAll, rfIgnoreCase]))=true then
     Mailspeedbutton.Glyph.LoadFromFile(    stringreplace(Aini.Readstring (sectionSTR, l1.Strings[mi], 'none')
,'[HOME]',GetEnvironmentVariable('HOME'),[rfReplaceAll, rfIgnoreCase]));
      Mailspeedbutton.ParentShowHint := False;
      Mailspeedbutton.ShowHint := True;
      Mailspeedbutton.Spacing := 5;
   Mailspeedbutton.OnClick := MailSpClick;
Mailspeedbutton.visible:=true;
sbint:=sbint+70+10;

end;
form2filelistPanel.width:=sbLeft+8+95+8;
Aini.free;
l1.clear;
l1.free;
if fileexists(UserCallingDataDIR+'xfg0005MailImplant'+'ToBeDeleted')then
deletefile(UserCallingDataDIR+'xfg0005MailImplant'+'ToBeDeleted');
if fileexists(UserCallingDataDIR+'xfg0002MailImplant'+'ToBeDeleted')then
deletefile(UserCallingDataDIR+'xfg0002MailImplant'+'ToBeDeleted');
end;

//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TRedstone_mail_implant.createMailPanelFolder;
begin
MailPanelFolder:=TPanel.create(nil);
with MailPanelFolder as tpanel do
begin
parent:=form2filelistPanel;
name:='MailPanelFolder';
  Align := alclient;
    borderstyle:=bsnone;
    BevelOuter := bvNone;
    visiblE:=true;
  borderwidth:=3;
  caption:='';
 // color:=AForm.color;
   Color := 16755370; 
 //   MailPanelFolder.Constraints.MinWidth := 100;
 //   MailPanelFolder.Constraints.MaxWidth := 200;
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TRedstone_mail_implant.createMailPanelMessage;
begin




MailPanelMessage:=TPanel.create(nil);
with MailPanelMessage as tpanel do
begin
parent:=form2treeViewPanel;
name:='MailPanelMessage';
  Align := alclient;
    borderstyle:=bsnone;
    BevelOuter := bvNone;
    visiblE:=true;
    caption:='';
  borderwidth:=3;
  color:=AForm.color;
//  MailPanelMessage.Constraints.MinWidth := 300;
end;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure TRedstone_mail_implant.MailcreateListView;
var  Cl: TListColumn;SD:TSORTDIRECTION;

begin

Maillistview:=TListView.create(MailPanelMessage);
with Maillistview as TListView do
begin
parent:=MailPanelMessage;
//parent:=panelcenter;
//imglist2:=timagelist.create(ListView);
//imglist2.assign(imglist);
name:='Maillistview';
//Images := imglist2;
    Left:=0;
    Top:=0;
    Width:=543;
    Height:=(MailPanelMessage.height div 2)-25;
    Align:=altop;
    BorderStyle:=bsNone;
    Cl:=Columns.add;
    Cl.width:=300;
    Cl.caption:='Subject';
    Cl:=Columns.add;
    Cl.width:=65;
    Cl.caption:='Mixed';
    Cl:=Columns.add;
    Cl.width:=90;
    Cl.caption:='From';
    Cl:=Columns.add;
    Cl.width:=70;
    Cl.caption:='Date';
    Cl:=Columns.add;
    Cl.width:=50;
    Cl.caption:='Size';
    Cl:=Columns.add;
        Cl.width:=100;
    Cl.caption:='To';
    Cl:=Columns.add;
        Cl.width:=100;
    Cl.caption:='Reply To'; 
    Cl:=Columns.add;
        Cl.width:=100;
    Cl.caption:='MessageID'; 

    SortColumn:=4;
    MultiSelect := True;
   // OwnerDraw := True;
    RowSelect := True;
    ReadOnly := True;
    //ShowColumnSortIndicators := True;
    TabOrder := 0;
    sorted:=false;
    ViewStyle := vsReport;
  //  OnChange := ListView1Change
   // OnChanging := ListView1Changing
  //  OnClick := MailListView1Click;
  // OnColumnClick :=OnColumnClick;
  //  OnDblClick = ListView1DblClick
  //  OnDeletion = ListView1Deletion
  //  OnInsert = ListView1Insert
 OnItemClick:=MailListViewItemClick;
   

  OnItemDoubleClick := MailListView1ItemDoubleClick;
  //  OnItemEnter = ListView1ItemEnter
 //   OnItemMouseDown := ListView1ItemMouseDown;
   // OnSelectItem := MailListView1SelectItem;
//OnDrawItem:= ListViewDrawItem;
try
color:=clwhite;
  // Color := stringtocolor(MailINI.Readstring ('Color', 'ListView_BGColor', 'none'));
font.Color := 8940896;
 //  Font.Color := stringtocolor(MailINI.Readstring ('Color', 'ListView_FGColor', 'none'));
   font.name:= 'helvitica';
//font.name:= (MailINI.Readstring ('Color', 'ListView_FontName', 'none'));
font.size:=11;
//font.size:=strtoint(MailINI.Readstring ('Color', 'ListView_FontSize', 'none'));
except
//Color := $00E6E6E6 ;
Color := clwhite;
Font.Color := 8940896;
Font.Height := 11;
Font.Name := 'helvitica';
end;
 end; 

(*********************************************)
  MaillistviewPopup:=tpopupmenu.create(Maillistview);
  with MaillistviewPopup as tpopupmenu do
  begin
AutoPopup := true;
//OnPopup:= DoPopup;
name:='MaillistviewPopup';
Alignment := (paLeft);
 OnPopup:=PopupMenuPopup;
 
  createpopup(MaillistviewPopup as tpopupmenu);
Maillistview.popupmenu:=MaillistviewPopup;

 end;

(*********************************************)    
 (************************************
 QueueFolderPopup,
  INBOXBOXFolderPopup,
  OUTBOXFolderPopup,
  TRASHFolderPopup,
  MyLetterFolderPopup,
  PersonsFolderPopup:tpopupmenu;
  

 l:=tstringlist.create;
 fileinfopopup:=tpopupmenu.create(form2);
//popup.parent:=filelist;
fileinfopopup.AutoPopup := true;
fileinfopopup.OnPopup:= DoPopup;
fileinfopopup.Alignment := (paLeft);
if not inifile.sectionexists('xfgFileInputInfoMenu')then begin l.free;exit;end;
 inifile.readsection('xfgFileInputInfoMenu',l);

for i:=0 to l.count-1 do
begin

Pitem:=TMenuItem.create(fileinfopopup);
 with Pitem as TMenuItem do
    begin
   Caption := l[i];
   Hint := l[i];
   imgfile:=inifile.readstring('xfgFileInputInfoMenuImage',l[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
       OnClick := popupclick;
 
 end;
fileinfopopup.items.add(Pitem);
end;
****************************)
//Listview.popupmenu:=fileinfopopup;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
 procedure TRedstone_mail_implant.createpagecontrol; 
 begin
pc:=tpagecontrol.create(MailPanelMessage) ;
 with pc do begin
 pc.parent:=MailPanelMessage;
  Left := 100;
    Top := 0;
    Width := 609;
    Height := 512;
    Align := alClient;
    TabHeight := 16;
    TabOrder := 1;
    TabWidth := 100;
  font.size:=10;
      
 end;
  ts1:=TTabSheet.Create(pc);
      with ts1 as ttabsheet do
      begin
   PageControl := pc;
   caption:=' View as Text';  
   
 end;
  ts2:=TTabSheet.Create(pc);
      with ts2 as ttabsheet do
      begin
   PageControl := pc;
   caption:='View as HTML';  
   
 end;
   ts3:=TTabSheet.Create(pc);
      with ts3 as ttabsheet do
      begin
   PageControl := pc;
   caption:='Attachments'; 
   
 end;
   ts4:=TTabSheet.Create(pc);
      with ts4 as ttabsheet do
      begin
   PageControl := pc;
   caption:='Compose New'; 

   
   
 end; 
   ts5:=TTabSheet.Create(pc);
      with ts5 as ttabsheet do
      begin
   PageControl := pc;
   caption:='Configure'; 
 end; 

 createMailReadControl;
  pc.ActivePage := ts1;
 // ts1,ts2:TTabsheet;HTMLmemoView:tmemo;
 end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
 procedure TRedstone_mail_implant.HTMLViewOnTextChanged(Sender: TObject);
 begin

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
 procedure TRedstone_mail_implant.HTMLViewOnHighlightText(Sender: TObject; const HighlightedText: WideString);
begin
if (sender as TTextBrowser).name='HTMLView' then
HTMLViewHighlightedText:=HighlightedText else
AttachmentHTMLViewHighlightedText:=HighlightedText;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
  procedure TRedstone_mail_implant.HTMLViewOnclick(Sender: TObject);
  
begin
if DoingMIME=true then exit;
if (sender as TTextBrowser).name='HTMLView' then
begin
if HTMLViewHighlightedText<>'' then libc.system(pchar('dillo '+HTMLViewHighlightedText+' &'));
end else
begin
//if (AttachmentHTMLViewHighlightedText<>'') and
if (AttachmentHTMLViewHighlightedText<>'')then
libc.system(pchar('dillo '+AttachmentHTMLViewHighlightedText+' &'));
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure TRedstone_mail_implant.HTMLViewOnMouseleave(Sender: TObject) ;
begin
if (HTMLViewCurrentText='')and(AttachmentHTMLViewCurrentText='')then exit;
if (sender as TTextBrowser).name='HTMLView' then
begin

if HTMLView.text<>HTMLViewCurrentText then
HTMLView.text:=HTMLViewCurrentText;
end else
begin
if AttachmentHTMLView.text<>AttachmentHTMLViewCurrentText then
AttachmentHTMLView.text:=AttachmentHTMLViewCurrentText;

end;
end;

//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
 procedure TRedstone_mail_implant.createMailReadControl;
// var HTMLViewMIMESourceFactory: TMimeSourceFactory;
var edtop,edleft,lbleft,edwidth,
edHeight:integer;
 begin
 HTMLView:=TTextBrowser.create(MailPanelMessage);
     HTMLView.parent:=ts2;
    with HTMLView as TTextBrowser do
    begin
    name:='HTMLView';
   //  HTMLViewMIMESourceFactory:=TMimeSourceFactory.create;
      Align := alClient;
      LinkColor := clblue;
      textformat:=tfautotext;
    //  textformat:=tfText; 
       BorderStyle := bsnone;
    //  fontname:='helvitica';
 //   HTMLView.showhint:=true;
TextColor:=clblack;
//Factory.RegisterMimeType('*','dillo');
//Factory:=HTMLViewMIMESourceFactory;
    text:='';
UseDefaultFactory :=true;
//HTMLView.loadfromfile('/opera6.html');
  //    OnMouseEnter = Memo1MouseEnter
  OnHighlightText:=HTMLViewOnHighlightText;
  Onclick:=HTMLViewOnclick;
 // OnTextChanged:= HTMLViewOnTextChanged;//(Sender: TObject);
   OnMouseLeave:= HTMLViewOnMouseLeave;
    end;
/////////////////////////////////////////////////////////////////////////////
 AttachmentHTMLView:=TTextBrowser.create(MailPanelMessage);
     AttachmentHTMLView.parent:=ts3;
    with AttachmentHTMLView as TTextBrowser do
    begin
    name:='AttachmentHTMLView';
   //  HTMLViewMIMESourceFactory:=TMimeSourceFactory.create;
      Align := alClient;
      LinkColor := clblue;
      textformat:=tfautotext;
    //  textformat:=tfText; 
       BorderStyle := bsnone;
    //  fontname:='helvitica';
  //  HTMLView.showhint:=true;
     text:='';
TextColor:=clblack;
//backgroundcolor:=$00CBF3EE ;
//Factory.RegisterMimeType('*','dillo');
//Factory:=HTMLViewMIMESourceFactory;

UseDefaultFactory :=true;
//HTMLView.loadfromfile('/opera6.html');
  //    OnMouseEnter = Memo1MouseEnter
  OnHighlightText:=HTMLViewOnHighlightText;
  Onclick:=HTMLViewOnclick;
 // OnTextChanged:= HTMLViewOnTextChanged;//(Sender: TObject);
   OnMouseLeave:= HTMLViewOnMouseLeave;
    end;

/////////////////////////////////////////////////////////////////////////////
 HTMLmemoView:=tmemo.create(MailPanelMessage);
     HTMLmemoView.parent:=ts1;
    with HTMLmemoView as tmemo do
    begin
      Left := 0;
      Top := 0;
    //  Width := 610;
    //  Height := 428;
      Align := alClient;
       name:='HTMLmemoView'; 
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
  HTMLmemoView.clear;

    end;
/////////////////////////////////////////////////////////////////////////////

ComposememoViewPanel:=TPanel.create(MailPanelMessage);
with ComposememoViewPanel as tpanel do
begin
parent:=ts4;
name:='ComposememoViewPanel';
  Align := altop;
    borderstyle:=bsnone;
    BevelOuter := bvNone;
    visiblE:=true;
  borderwidth:=3;
  caption:='';
 // color:=AForm.color;
 //  Color := 16755370; 
    height:= 100;
    Left := 2;
      Top := 2;
      Width := 610;
      Height := 428;
 
end;  

/////////////////////////////////////////////////////////////////////////////
 ComposememoView:=tmemo.create(MailPanelMessage);
     ComposememoView.parent:=ts4;
    with ComposememoView as tmemo do
    begin
      Width := 400;
    //  Height := 428;
      Align := alLeft;
        name:='ComposememoView'; 
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
      readonly:=false;
       BorderStyle := bsNone;
   Constraints.MinWidth := 50;
  ComposememoView.clear;
 
    end;    
(*********************************************)
 // EDTo,EDCc,EDSubject:tedit;
//   LBoxAttach:Tlistbox;ComposeNewAttachPopup:TPOPUP;ComposeNewSpl:Tsplitter;
//EDTolb,EDCclb,EDSubjectlb:tlabel;
//edtop,edleft,lbleft:integer;
edtop:=5;
edleft:=70;
edwidth:=435;
edHeight:=15;
lbleft:=10;
EDTo:=tedit.create(MailPanelMessage);
with EDTo as tedit do
begin
 parent:=ComposememoViewPanel;
 Left := edleft;
 Top :=edtop;
   name:='EDTo'; 
 Width := edwidth;
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';
text:='';
end; 
EDTolb :=tlabel.create(MailPanelMessage);
with EDTolb as tlabel do
begin
//name:='lb1';
   parent:=ComposememoViewPanel;
//   visible:=false;
   Left := lbleft;
   Top := EDTo.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
 AutoSize := true;
   Layout := tlCenter;
   caption:='To :';
   font.size:=12;
 //  update;
end;
(*********************************************)

EDCc:=tedit.create(MailPanelMessage);
with EDCc as tedit do
begin
 parent:=ComposememoViewPanel;
 Left := edleft;
   name:='EDCc'; 
 Top :=EDTo.top+EDTo.height+3;
 Width := edwidth;
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';
text:='';
end; 
EDCclb :=tlabel.create(MailPanelMessage);
with EDCclb as tlabel do
begin
//name:='lb1';
   parent:=ComposememoViewPanel;
//   visible:=false;
   Left := lbleft;
   Top := EDCc.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
   AutoSize := true;
   Layout := tlCenter;
   caption:='Cc :';
   font.size:=12;
 //  update;
end;
(*********************************************)

EDSubject:=tedit.create(MailPanelMessage);
with EDSubject as tedit do
begin
 parent:=ComposememoViewPanel;
 Left := edleft;
   name:='EDSubject'; 
 Top :=EDCc.top+EDCc.height+3;
 Width := edwidth;
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';
text:='';
end; 
EDSubjectlb :=tlabel.create(MailPanelMessage);
with EDSubjectlb as tlabel do
begin
//name:='lb1';
   parent:=ComposememoViewPanel;
//   visible:=false;
   Left := lbleft;
   Top := EDSubject.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
   AutoSize := true;
   Layout := tlCenter;
   caption:='Subject :';
   font.size:=12;
 //  update;
end;

ComposememoViewPanel.height:=EDSubject.top+EDSubject.height+5;
(*********************************************)

ComposeNewSpl:=tsplitter.create(MailPanelMessage);
ComposeNewSpl.parent:=ts4;
with ComposeNewSpl as tsplitter do
begin
//
  Left := ComposememoView.width+5;
 //   Top := 26;
 align:=alleft;
  //  Height := 375;
 //   Beveled := True;
    Color := $00D5A186  ;
    width:=5;
 // Beveled:=true;
   MinSize:=15;
AutoSnap:=true; 

end;
(*********************************************)
  (*********************************************)
 LBoxAttach:=tlistbox.create(MailPanelMessage);
with LBoxAttach as tlistbox do 
begin
parent:=ts4;
//left:=160;
left:=160;
align:=alclient;
  name:='LBoxAttach'; 
MultiSelect := false;
ShowHint := True;
 BorderStyle := bsNone;
hint:='Attachment items';
onclick:=POPUPCLICK;
Constraints.MinWidth := 50;
end;
(*********************************************)
  ComposeNewAttachPopup:=tpopupmenu.create(MailPanelMessage);
  with ComposeNewAttachPopup as tpopupmenu do
  begin
AutoPopup := true;
//OnPopup:= DoPopup;
name:='ComposeNewAttachPopup';
Alignment := (paLeft);
  createpopup(ComposeNewAttachPopup as tpopupmenu);
 LBoxAttach.popupmenu:=ComposeNewAttachPopup;
 OnPopup:=PopupMenuPopup;
 end;

(*********************************************)
  ComposeNewMemoPopup:=tpopupmenu.create(MailPanelMessage);
  with ComposeNewMemoPopup as tpopupmenu do
  begin
AutoPopup := true;
//OnPopup:= DoPopup;
name:='ComposeNewMemoPopup';
Alignment := (paLeft);
  createpopup(ComposeNewMemoPopup as tpopupmenu);
  ComposememoView.popupmenu:=nil;
 ComposememoView.popupmenu:=ComposeNewMemoPopup;
 OnPopup:=PopupMenuPopup;
 end;
     
/////////////////////////////////////////////////////////////////////////////
// EDSmtpServer,EDUsername,EDPOPServer,EDEmail,EDPassword,EDSmtpPort,EDPOPPort,EDKeepMailOnServer:tedit;
// LBSmtpServer,LBUsername,LBPOPServer,LBEmail,LBPassword,LBSmtpPort,LBPOPPort,LBKeepMailOnServer:tlabel;
edtop:=5;
edleft:=170;
edwidth:=300;
edHeight:=15;
lbleft:=10;
EDSmtpServer:=tedit.create(MailPanelMessage);
with EDSmtpServer as tedit do
begin
 parent:=ts5;
 Left := edleft;
 Top :=edtop;
   name:='EDSmtpServer'; 
 Width := edwidth;
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';

end; 
LBSmtpServer :=tlabel.create(MailPanelMessage);
with LBSmtpServer as tlabel do
begin
//name:='lb1';
   parent:=ts5;
//   visible:=false;
   Left := lbleft;
   Top := EDSmtpServer.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
 AutoSize := true;
   Layout := tlCenter;
   caption:='Smtp Server :';
   font.size:=12;
 //  update;
end;
(*********************************************)

EDPOPServer:=tedit.create(MailPanelMessage);
with EDPOPServer as tedit do
begin
 parent:=ts5;
 Left := edleft;
   name:='EDPOPServer'; 
 Top :=EDSmtpServer.top+EDSmtpServer.height+3;
 Width := edwidth;
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';

end; 
LBPOPServer :=tlabel.create(MailPanelMessage);
with LBPOPServer as tlabel do
begin
//name:='lb1';
   parent:=ts5;
//   visible:=false;
   Left := lbleft;
   Top := EDPOPServer.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
   AutoSize := true;
   Layout := tlCenter;
   caption:='POP Server : ';
   font.size:=12;
 //  update;
end;
(*********************************************)

EDUsername:=tedit.create(MailPanelMessage);
with EDUsername as tedit do
begin
 parent:=ts5;
 Left := edleft;
    name:='EDUsername'; 
 Top :=EDPOPServer.top+EDPOPServer.height+3;
 Width := edwidth;
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';

end; 
LBUsername :=tlabel.create(MailPanelMessage);
with LBUsername as tlabel do
begin
//name:='lb1';
   parent:=ts5;
//   visible:=false;
   Left := lbleft;
   Top := EDUsername.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
   AutoSize := true;
   Layout := tlCenter;
   caption:='Login User Name :';
   font.size:=12;
 //  update;
end;
(******************************************************************************************************)
(*********************************************)
// EDSmtpServer,EDUsername,EDPOPServer,EDEmail,EDPassword,EDSmtpPort,EDPOPPort,EDKeepMailOnServer:tedit;
// LBSmtpServer,LBUsername,LBPOPServer,LBEmail,LBPassword,LBSmtpPort,LBPOPPort,LBKeepMailOnServer:tlabel;

EDPassword:=tedit.create(MailPanelMessage);
with EDPassword as tedit do
begin
 parent:=ts5;
 Left := edleft;
 Top :=EDUsername.top+EDUsername.height+3;
 Width := edwidth;
    name:='EDPassword'; 
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
hint:='Password will only be valid in this session only.'+#13#10+
      'After you exit from the main application,your password'+#13#10+
      'will be cleared and will not be saved.';
EchoMode:=empassword;
end; 
LBPassword :=tlabel.create(MailPanelMessage);
with LBPassword as tlabel do
begin
//name:='lb1';
   parent:=ts5;
//   visible:=false;
   Left := lbleft;
   Top := EDPassword.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
   AutoSize := true;
   Layout := tlCenter;
   caption:='Login Password :';
   font.size:=12;
 //  update;
end;
(******************************************************************************************************)
(*********************************************)
// EDSmtpServer,EDUsername,EDPOPServer,EDEmail,EDPassword,EDSmtpPort,EDPOPPort,EDKeepMailOnServer:tedit;
// LBSmtpServer,LBUsername,LBPOPServer,LBEmail,LBPassword,LBSmtpPort,LBPOPPort,LBKeepMailOnServer:tlabel;

EDEmail:=tedit.create(MailPanelMessage);
with EDEmail as tedit do
begin
 parent:=ts5;
 Left := edleft;
    name:='EDEmail'; 
 Top :=EDPassword.top+EDPassword.height+3;
 Width := edwidth;
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';

end; 
LBEmail :=tlabel.create(MailPanelMessage);
with LBEmail as tlabel do
begin
//name:='lb1';
   parent:=ts5;
//   visible:=false;
   Left := lbleft;
   Top := EDEmail.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
   AutoSize := true;
   Layout := tlCenter;
   caption:='Email Address :';
   font.size:=12;
 //  update;
end;
(******************************************************************************************************)
(*********************************************)
// EDSmtpServer,EDUsername,EDPOPServer,EDEmail,EDPassword,EDSmtpPort,EDPOPPort,EDKeepMailOnServer:tedit;
// LBSmtpServer,LBUsername,LBPOPServer,LBEmail,LBPassword,LBSmtpPort,LBPOPPort,LBKeepMailOnServer:tlabel;

EDSmtpPort:=tedit.create(MailPanelMessage);
with EDSmtpPort as tedit do
begin
 parent:=ts5;
 Left := edleft;
  name:='EDSmtpPort'; 
 Top :=EDEmail.top+EDEmail.height+3;
 Width := edwidth;
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';
text:='25';

end; 
LBSmtpPort :=tlabel.create(MailPanelMessage);
with LBSmtpPort as tlabel do
begin
//name:='lb1';
   parent:=ts5;
//   visible:=false;
   Left := lbleft;
   Top := EDSmtpPort.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
   AutoSize := true;
   Layout := tlCenter;
   caption:='Smtp Port :';
   font.size:=12;
 //  update;
end;
(******************************************************************************************************)
(*********************************************)
// EDSmtpServer,EDUsername,EDPOPServer,EDEmail,EDPassword,EDSmtpPort,EDPOPPort,EDKeepMailOnServer:tedit;
// LBSmtpServer,LBUsername,LBPOPServer,LBEmail,LBPassword,LBSmtpPort,LBPOPPort,LBKeepMailOnServer:tlabel;

EDPOPPort:=tedit.create(MailPanelMessage);
with EDPOPPort as tedit do
begin
 parent:=ts5;
 Left := edleft;
   name:='EDPOPPort'; 
 Top :=EDSmtpPort.top+EDSmtpPort.height+3;
 Width := edwidth;
 Height := edHeight;
 font.name:='lucida';
 font.size:=11;
 // hint:=edit1.text;
  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';
text:='110';

end; 
LBPOPPort :=tlabel.create(MailPanelMessage);
with LBPOPPort as tlabel do
begin
//name:='lb1';
   parent:=ts5;
//   visible:=false;
   Left := lbleft;
   Top := EDPOPPort.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
   AutoSize := true;
   Layout := tlCenter;
   caption:='POP Port :';
   font.size:=12;
 //  update;
end;
(******************************************************************************************************)
(*********************************************)
// EDSmtpServer,EDUsername,EDPOPServer,EDEmail,EDPassword,EDSmtpPort,EDPOPPort,EDKeepMailOnServer:tedit;
// LBSmtpServer,LBUsername,LBPOPServer,LBEmail,LBPassword,LBSmtpPort,LBPOPPort,LBKeepMailOnServer:tlabel;

EDKeepMailOnServer:=tcheckbox.create(MailPanelMessage);
with EDKeepMailOnServer as tcheckbox do
begin
 parent:=ts5;
 Left := edleft;
    name:='EDKeepMailOnServer'; 
 Top :=EDPOPPort.top+EDPOPPort.height+3;
 Width := 15;
Height := 15;
// font.name:='lucida';
// font.size:=11;
 // hint:=edit1.text;
//  showhint:=true;
 //   Layout := tlCenter;
//hint:='ssssssssssssssssss';
//text:='110';
checked:=true;
end; 
LBKeepMailOnServer :=tlabel.create(MailPanelMessage);
with LBKeepMailOnServer as tlabel do
begin
//name:='lb1';
   parent:=ts5;
//   visible:=false;
   Left := lbleft;
   Top := EDKeepMailOnServer.top+2;
   Width := 50;
   Height := 15;
   Alignment := taCenter;
   AutoSize := true;
   Layout := tlCenter;
   caption:='Keep Mail On Server : ';
   font.size:=12;
 //  update;
end;
(******************************************************************************************************)

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
(******************************************************************************************************)
procedure  TRedstone_mail_implant.PopupMenuPopup(Sender: TObject);
procedure  MaillistviewPopupDisable(Bool:Boolean);
var i:integer;
begin
for i:=0 to MaillistviewPopup.items.count-1 do
MaillistviewPopup.items[i].enabled:=Bool;
end;

var hastext:boolean; 
begin
(*
Attach New ...=
Remove=
Settings=
*)
if (sender as tpopupmenu)=ComposeNewAttachPopup then
begin

if LBoxAttach.items.count=0 then
begin
ComposeNewAttachPopup.items.find('Remove All').enabled:=false;
ComposeNewAttachPopup.items.find('Remove').enabled:=false;
//ComposeNewAttachPopup.items.find('Settings').enabled:=false;
end else
if LBoxAttach.items.count>0 then
begin
ComposeNewAttachPopup.items.find('Remove').enabled:=true;
//ComposeNewAttachPopup.items.find('Settings').enabled:=true;
end;

//ComposeNewMemoPopup.items.find('Attach New ...').enabled:=true;

exit;
end;

if (sender as tpopupmenu)=ComposeNewMemoPopup then
begin
if (InfoListViewCurrentDir=QueueFolderDir)or 
(InfoListViewCurrentDir=MyLetterFolderDir)or
(InfoListViewCurrentDir=OUTBOXFolderDir) then
ComposeNewMemoPopup.items.find('Save').enabled:=true else
ComposeNewMemoPopup.items.find('Save').enabled:=false;

if Maillistview.selcount=0 then ComposeNewMemoPopup.items.find('Save').enabled:=false;

if  Clipboard.astext='' then hastext:=false else hastext:=true;
ComposeNewMemoPopup.items.find('undo').enabled:=ComposememoView.canundo;
ComposeNewMemoPopup.items.find('redo').enabled:=ComposememoView.canredo;
ComposeNewMemoPopup.items.find('copy').enabled:=ComposememoView.HasSelection;
ComposeNewMemoPopup.items.find('cut').enabled:=ComposememoView.HasSelection;
ComposeNewMemoPopup.items.find('Clear Selection').enabled:=ComposememoView.HasSelection;
ComposeNewMemoPopup.items.find('paste').enabled:=hastext;
exit;
end;

(*
[MaillistviewPopup]
Reply=
-=
Delete=
Delete All=
Clear Thrash=
-=
Send Now=
Move to My Letter=
Save As ...=
Compose New=
-=
View Source=
 MailTEMPAttachmentFolder,InfoListViewCurrentDir, QueueFolderDir,MyLetterFolderDir,
 PersonsFolderDir,TRASHFolderDir,OUTBOXFolderDir,INBOXFolderDir:string;
*)
;
if (sender as tpopupmenu)=MaillistviewPopup then
begin
MaillistviewPopup.items.find('Reply').enabled:=false;

if (Maillistview.items.Count=0)or(Maillistview.selcount=0)  then 
begin
MaillistviewPopupDisable(false);
MaillistviewPopup.items.find('Compose New').enabled:=true;
if MAILK.CRS_GetDirFileCount(TRASHFolderDir)>2 then 
MaillistviewPopup.items.find('Clear Thrash').enabled:=true;
exit;
end;
if Maillistview.selcount>1 then MaillistviewPopup.items.find('View Source').enabled:=false;

if Maillistview.selcount>0 then 
begin
MaillistviewPopupDisable(true);
MaillistviewPopup.items.find('Send Now').enabled:=false;
MaillistviewPopup.items.find('Reply').enabled:=false;
if MAILK.CRS_GetDirFileCount(TRASHFolderDir)<3 then 
MaillistviewPopup.items.find('Clear Thrash').enabled:=false;

if (InfoListViewCurrentDir=QueueFolderDir)
//(InfoListViewCurrentDir=MyLetterFolderDir) or
//(InfoListViewCurrentDir=MyLetterFolderDir)
then 
begin
MaillistviewPopup.items.find('Send Now').enabled:=true;
end;

if (InfoListViewCurrentDir=MyLetterFolderDir)or
(InfoListViewCurrentDir=INBOXFolderDir)
then 
begin
MaillistviewPopup.items.find('Reply').enabled:=true;
end;


end;



end;


end;
(******************************************************************************************************)
  procedure TRedstone_mail_implant.createpopup(sender:TObject);
    var 
    i:integer;
    l:tstringlist;
  mi:tmenuitem;
    imgfile:string;
begin
l:=tstringlist.create;
try
MailINI.readsection((sender as tpopupmenu).name,l);

for i:=0 to l.count-1 do
begin
 mi:=TMenuItem.create((sender as tpopupmenu));
   with mi as TMenuItem do
    begin
 
      Caption := l.strings[i];
   Hint := l.strings[i];
  imgfile:=MailINI.readstring((sender as tpopupmenu).name,l.strings[i],'none');
   if fileexists(imgfile)then
   bitmap.loadfromfile(imgfile);
         enabled:=true;
         visible:=true;
  OnClick := POPUPCLICK;
   (sender as tpopupmenu).items.add(mi);
   
end;
end;
finally
l.free;
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
function TRedstone_mail_implant.PrepareTextToMail(MailTo,MailCc,MailSubject,Mailtext:string;
          AttachList,OriginalDecodedMessageLst:tstringlist):string;
(*****************************************************************************)          
procedure CheckOriginalAttachList(APASSMMess:TMimeMess;APASSMainPart:TMIMEPART;
APASSOriginalDecodedMessageLst:tstringlist);
var i:integer;CMPart,CMPart2:TMimepart;CMMess:TMimeMess;ss:string;
begin
CMMess:=TMimeMess.create;
CMMess.Lines.text:=APASSOriginalDecodedMessageLst.text;
CMMess.DecodeMessage; 
CMMess.MessagePart.DecomposeParts;
if CMMess.MessagePart.GetSubPartCount>0 then
begin
for i:=0 to CMMess.MessagePart.GetSubPartCount-1 do
begin

CMPart:=CMMess.MessagePart.GetSubPart(i);
if (AnsiLowercase(CMPart.Disposition)='inline') or
(AnsiLowercase(CMPart.Disposition)='attachment') then
begin

if AttachList.indexof('<'+CMPart.filename+'>')<>-1 then
begin
CMPart2:=APASSMMess.AddPart(APASSMainPart);
CMPart2.assign(CMPart);

if CMPart.GetSubPartCount>0 then
begin
CMPart.DecomposeParts;
CheckOriginalAttachList(APASSMMess,APASSMainPart,APASSOriginalDecodedMessageLst);
end;
end;

end;
end;//for i:=0 to CMMess.MessagePart.GetSubPartCount-1 do
end;//if CMMess.MessagePart.GetSubPartCount>0 then
end;
(*****************************************************************************)
var MHeader:TMessHeader;MainPart,MPart,MPart2:TMimepart;MMess:TMimeMess;Enc:Tstringlist;TBIN,TQuote:Boolean;
i,ii:integer;str:string;
begin
//function AddPartText(const Value: TStrings; const PartParent: TMimePart): TMimepart;
//function AddPartTextFromFile(const FileName: String; const PartParent: TMimePart): TMimepart;
//AddPartBinaryFromFile(const FileName: string; const PartParent: TMimePart)
//AddPartMultipart(const MultipartType: String; const PartParent: TMimePart): TMimePart;
//MHeader:=TMessHeader.create;
////EDTo,EDCc,EDSubject
//ME_7BIT, ME_8BIT, ME_QUOTED_PRINTABLE and ME_BASE64
result:=(Mailtext);
Enc:=Tstringlist.create;
MMess:=TMimeMess.create;

try
MMess.header.From:=MailINI.readstring('Mail Setting','Email','none@none.org');
MMess.header.ToList.text:=MailTo;
MMess.header.Subject:=MailSubject;
MMess.header.CCList.text:=MailCc;
MMess.header.Organization:=MailINI.readstring('Mail Setting','Organization','');
//MMess.header.ReplyTo:=EDReplyTo.text;
MMess.header.XMailer:='FileGarden Mailer (developed using Synapse component)';
MMess.header.Date:=Now;

if AttachList.count>0 then
MainPart:=MMess.AddPartMultipart( 'mixed',nil);

if AttachList.count=0 then
begin
MainPart:=MMess.AddPart(MainPart);
//MainPart.DefaultCharset:='ISO-8859-1';
MainPart.DefaultCharset:='US-ASCII';
MainPart.Charset:='US-ASCII';
MainPart.EncodingCode:=ME_7BIT;
MainPart.primary:='text';
Enc.text:=Mailtext;
Enc.savetostream(MainPart.DecodedLines);
MainPart.EncodePartHeader; 
MainPart.EncodePart;
end else
if AttachList.count>0 then
begin
MPart:=MMess.AddPart(MainPart);
//MPart.DefaultCharset:='ISO-8859-1';
MPart.DefaultCharset:='US-ASCII';
MPart.Charset:='US-ASCII';
MPart.primary:='text';
Enc.text:=Mailtext;
if NeedCharsetConversion(Mailtext)=true then
MPart.EncodingCode:=ME_QUOTED_PRINTABLE else
MPart.EncodingCode:=ME_7BIT;
Enc.savetostream(MPart.DecodedLines);
MPart.EncodePartHeader; 
MPart.EncodePart;
if OriginalDecodedMessageLst<>nil then
CheckOriginalAttachList(MMess,MainPart,OriginalDecodedMessageLst);
end;


if AttachList.count>0 then
begin
//MPart.clear;
//MPart:=MMess.AddPartMultipart( 'mixed',MMess.bodypart);
for i:=0 to AttachList.count-1 do
begin

if (AnsiEndsStr('>',trim(AttachList[i])))and
(AnsiStartsStr('<',trim(AttachList[i]))) and
(AnsiPos('/',trim(AttachList[i]))=0)then continue;

TBIN:=false;
TQuote:=false;

Enc.clear;
Enc.loadfromfile(AttachList[i]);


if (AnsiLowercase(extraCTFILEEXT(AttachList[i]))='.html') OR 
(AnsiLowercase(extraCTFILEEXT(AttachList[i]))='.htm')
then begin
MPart2:=MMess.AddPartHTMLFromFile(AttachList[i], MainPart);
if NeedCharsetConversion(Enc.text)=true then
MPart2.EncodingCode:=ME_QUOTED_PRINTABLE else
MPart2.EncodingCode:=ME_7BIT;
end else
begin
if IsBinaryString(Enc.text)=true then
begin
MPart2:=MMess.AddPartBinaryFromFile(AttachList[i], MainPart);
MPart2.EncodingCode:=ME_BASE64 ;
end else
begin
MPart2:=MMess.AddPartTextFromFile(AttachList[i], MainPart);
if NeedCharsetConversion(Enc.text)=true then
MPart2.EncodingCode:=ME_QUOTED_PRINTABLE else
MPart2.EncodingCode:=ME_7BIT;
end;
end;


//MPart2.DefaultCharset:='ISO-8859-1';
MPart2.DefaultCharset:='US-ASCII';
MPart2.Charset:='US-ASCII';
str:=MAILK.CRS_ExtractFileName(AttachList[i]);
MPart2.filename:=str;
MPart2.Disposition:='attachment';
Enc.savetostream(MPart2.DecodedLines);
MPart2.EncodePartHeader; 
MPart2.EncodePart;


end;//for i:=0 to LBoxAttach.items.count-1 do
end;//if LBoxAttach.items.count>0 then
MMess.EncodeMessage;
result:=(MMess.lines.text);
//MMess.lines.savetofile('/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');

finally

Enc.free;
MMess.free;

end;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure TRedstone_mail_implant.popupclick(Sender: TObject);
//var item:tmenuitem;
var instr,instr1,strK,senderVCLMethod:string;FileListInfoWorkMassage:tMIMEMess;
i,ii:integer;
outlst:tstringlist;l1:tstringlist;
begin
outlst:=tstringlist.create;
l1:=tstringlist.create;
try
(***************************************************)
if sender is tmenuitem then 
begin
with Sender as tmenuitem do
begin

strK:='';
instr:='';
instr1:='';
if (sender as TMenuitem).GetParentMenu=ComposeNewAttachPopup then
begin
(*
Attach New ...=
Remove=
Settings=
*)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Attach New ...') then
begin
(MAILK.CRS_SelectFiles('Select mail attachment files ...','~','','',l1));
LBoxAttach.items.AddStrings(l1);
end;
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Remove') then
begin

LBoxAttach.items.delete(LBoxAttach.itemindex);


end;

if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Remove All') then
begin

LBoxAttach.clear;


end;
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Settings') then
begin

end;

end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Compose New') then
begin
MAILComposeNew;

end;
(***************************************************)
(*
Queue=
Send Now=
Save to My Letter=
Save New Mail As ...=
Compose New=
-=
Undo=
Redo=
-=
Cut=
Copy=
Paste=
-=
Clear All=
Select All=
*)
if (sender as TMenuitem).GetParentMenu=ComposeNewMemoPopup then
begin

l1.clear;
outlst.clear;
outlst.loadfromfile(InfoListViewCurrentDir+'.xfgMailercatch');
for i:=0 to Maillistview.items.Count-1 do
begin
if Maillistview.items[i].selected=true then
begin
l1.add(outlst[i]);
//l1.add(InfoListViewCurrentDir+(Maillistview.items[i].caption));
end;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Save') then
begin
if Maillistview.items.count=0 then exit;
if Maillistview.selcount=0 then exit;
if  Maillistview.selected<>nil then           
l1.loadfromfile(outlst[Maillistview.selected.index]);
instr:=ComposememoView.lines.text;
outlst.text:=LBoxAttach.items.text;
instr1:=PrepareTextToMail(EDTo.text,EDCc.text,EDSubject.text,instr,outlst,l1);
l1.text:=instr1;
//strk:=MAILK.CRS_getguid;
outlst.clear;
outlst.loadfromfile(InfoListViewCurrentDir+'.xfgMailercatch');
l1.savetofile(outlst[Maillistview.selected.index]);
GetMailFileListInfo(InfoListViewCurrentDir);
ComposememoView.modified:=false;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Save to My Letter') then
begin
if  Maillistview.selected<>nil then           
l1.loadfromfile(outlst[Maillistview.selected.index]);
instr:=ComposememoView.lines.text;
outlst.text:=LBoxAttach.items.text;
instr1:=PrepareTextToMail(EDTo.text,EDCc.text,EDSubject.text,instr,outlst,l1);
l1.text:=instr1;
strk:=MAILK.CRS_getguid;
l1.savetofile(MyLetterFolderDir+strK);
ComposememoView.modified:=false;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Queue') then
begin
if  Maillistview.selected<>nil then           
l1.loadfromfile(outlst[Maillistview.selected.index]);
instr:=ComposememoView.lines.text;
outlst.text:=LBoxAttach.items.text;
instr1:=PrepareTextToMail(EDTo.text,EDCc.text,EDSubject.text,instr,outlst,l1);
l1.text:=instr1;
strk:=MAILK.CRS_getguid;
l1.savetofile(QueueFolderDir+strK);
ComposememoView.modified:=false;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Save New Mail As ...') then
begin
//EDTo,EDCc,EDSubject
if  Maillistview.selected<>nil then           
l1.loadfromfile(outlst[Maillistview.selected.index]);
instr:=ComposememoView.lines.text;
outlst.text:=LBoxAttach.items.text;
instr1:=PrepareTextToMail(EDTo.text,EDCc.text,EDSubject.text,instr,outlst,l1);
l1.text:=instr1;
strK:=MAILK.CRS_SaveFile('Save New Mail As ...','~','','NewMail');
if strK<>'' then
l1.savetofile(strK);
ComposememoView.modified:=false;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Send Now') then
begin
if trim(EDTo.text)=''then 
if  MessageDlg ('No destination address'+#13#10
            , mtInformation, [mbOK], 0)=mrOK then exit;
if trim(EDSubject.text)=''then 
if  MessageDlg ('No mail subject,continue ?'+#13#10
            , mtInformation, [mbYes,mbNo], 0)=mrNo then exit;
if  Maillistview.selected<>nil then           
l1.loadfromfile(outlst[Maillistview.selected.index]);
instr1:=PrepareTextToMail(EDTo.text,EDCc.text,EDSubject.text,ComposememoView.lines.text,outlst,l1);
instr:=ComposememoView.lines.text;
outlst.text:=LBoxAttach.items.text;
instr1:=PrepareTextToMail(EDTo.text,EDCc.text,EDSubject.text,instr,outlst,l1);
l1.text:=instr1;       
SendMail(l1,true);
//ComposememoView.modified:=true;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Undo') then
begin
ComposememoView.undo;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Redo') then
begin
ComposememoView.Redo;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Cut') then
begin
ComposememoView.CutToClipboard;;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Copy') then
begin
ComposememoView.CopyToClipboard;;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Paste') then
begin
ComposememoView.PasteFromClipboard;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Clear All') then
begin
ComposememoView.Clear;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Clear Selection') then
begin
ComposememoView.ClearSelection;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Select All') then
begin
ComposememoView.SelectAll;
end;
(***************************************************)
end;
(*
 MailTEMPAttachmentFolder,InfoListViewCurrentDir, QueueFolderDir,MyLetterFolderDir,
 PersonsFolderDir,TRASHFolderDir,OUTBOXFolderDir,INBOXFolderDir:string;
*)
(***************************************************)
if (sender as TMenuitem).GetParentMenu=MaillistviewPopup then
begin
l1.clear;
outlst.clear;
outlst.loadfromfile(InfoListViewCurrentDir+'.xfgMailercatch');
for i:=0 to Maillistview.items.Count-1 do
begin
if Maillistview.items[i].selected=true then
begin
l1.add(outlst[i]);
//l1.add(InfoListViewCurrentDir+(Maillistview.items[i].caption));
end;
end;

if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Reply') then
begin

MAILComposeNew;
DeconstructMail(outlst[Maillistview.selected.index]);

FileListInfoWorkMassage:=nil;
FileListInfoWorkMassage:=tMIMEMess.create;
try
l1.loadfromfile(outlst[Maillistview.selected.index]);
//FileListInfoWorkMassage.clear;
FileListInfoWorkMassage.Lines.text:=(l1.text);
FileListInfoWorkMassage.DecodeMessage;
EDTo.text:=FileListInfoWorkMassage.header.from;
EDCc.text:=FileListInfoWorkMassage.header.CcList.text;
EDSubject.text:='Reply : '+FileListInfoWorkMassage.header.subject;

ComposememoView.clear;
ComposememoView.lines.add('On '+datetostr(FileListInfoWorkMassage.header.date)+#13#10+
                           FileListInfoWorkMassage.header.from+' wrote : '+#13#10);
                           
// EDTo,EDCc,EDSubject:tedit;EDTolb,EDCclb,EDSubjectlb:tlabel;
// HTMLmemoView,ComposememoView:tmemo;LBoxAttach:Tlistbox; AttachmentHTMLView,HTMLView:TTextBrowser;
  
for i:=0 to HTMLmemoView.lines.count-1 do 
ComposememoView.lines.add('>   '+HTMLmemoView.lines[i]);
ComposememoView.lines.add(' ');

finally
pc.activepage:=ts4;
if FileListInfoWorkMassage<>nil then FileListInfoWorkMassage.free;
end;
end;

if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Delete') then
begin
ClearAllPanel;
if InfoListViewCurrentDir=INBOXFolderDir then MAILK.X_CRS_FileCopyMoveR(2,l1,TRASHFolderDir,nil);
if InfoListViewCurrentDir=OUTBOXFolderDir then MAILK.X_CRS_FileCopyMoveR(2,l1,TRASHFolderDir,nil);
if InfoListViewCurrentDir=TRASHFolderDir then 
begin
if MessageDlg ('Permemently remove mail ?'+#13#10
            , mtInformation, [mbOK,mbCancel], 0)=mrOK then
begin
for i:=0 to l1.count-1 do
deletefile(l1[i]);
end else exit;
end ;
if InfoListViewCurrentDir=MyLetterFolderDir then MAILK.X_CRS_FileCopyMoveR(2,l1,TRASHFolderDir,nil);
if InfoListViewCurrentDir=QueueFolderDir then MAILK.X_CRS_FileCopyMoveR(2,l1,TRASHFolderDir,nil);
if InfoListViewCurrentDir=PersonsFolderDir then MAILK.X_CRS_FileCopyMoveR(2,l1,TRASHFolderDir,nil);

for i:=0 to l1.Count-1 do
begin
if not fileexists(l1[i])then outlst.delete(outlst.indexof(l1[i]));
end;
GetMailFileListInfo(InfoListViewCurrentDir);
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Delete All') then
begin
ClearAllPanel;
MAILK.X_CRS_FileCopyMoveR(2,outlst,TRASHFolderDir,nil);
if InfoListViewCurrentDir=TRASHFolderDir then 
begin
if    MessageDlg ('Permemently remove all mail ?'+#13#10
            , mtInformation, [mbOK,mbCancel], 0)=mrOK then
begin
for i:=0 to outlst.count-1 do
deletefile(outlst[i]);
end else exit;
end ;
outlst.clear;
outlst.savetofile(InfoListViewCurrentDir+'.xfgMailercatch');
GetMailFileListInfo(InfoListViewCurrentDir);
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Clear Thrash') then
begin
if InfoListViewCurrentDir=TRASHFolderDir then ClearAllPanel;
if    MessageDlg ('Permemently clear thrash folder ?'+#13#10
            , mtInformation, [mbOK,mbCancel], 0)=mrOK then
begin
GetMailFileListInfo(TRASHFolderDir);
if InfoListViewCurrentDir<>TRASHFolderDir then 
GetMailFileListInfo(InfoListViewCurrentDir);
outlst.clear;
outlst.loadfromfile(TRASHFolderDir+'.xfgMailercatch');
for i:=0 to outlst.count-1 do
deletefile(outlst[i]);
end else exit;
if InfoListViewCurrentDir=TRASHFolderDir then 
GetMailFileListInfo(TRASHFolderDir);
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Send Now') then
begin
SendMail(l1,false);
if InfoListViewCurrentDir=QueueFolderDir then 
begin
for i:=0 to l1.count-1 do
deletefile(l1[i]);
GetMailFileListInfo(QueueFolderDir);
end;
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Move to My Letter') then
begin
ClearAllPanel;
MAILK.X_CRS_FileCopyMoveR(2,l1,MyLetterFolderDir,nil);
GetMailFileListInfo(InfoListViewCurrentDir);
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('Copy To Folder ...') then
begin
strK:= MAILK.CRS_SelectDir('Copy Mails To Folder ...','~');
if trim(strK)<> '' then
MAILK.X_CRS_FileCopyMoveR(1,l1,strK,nil) else
MessageDlg ('Error copy mails'+#13#10
            , mtInformation, [mbOK], 0);
//GetMailFileListInfo(InfoListViewCurrentDir);
end;
(***************************************************)
if AnsiLowercase((sender as TMenuitem).hint)=AnsiLowercase('View Source') then
begin
ViewMailSource(Maillistview.selected); 

end;
end;//if (sender as TMenuitem).GetParentMenu=MaillistviewPopup then



end;
end;

finally
l1.free;
outlst.free;
end;

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure TRedstone_mail_implant.CheckDeleteTMPAttachment;
var  sr: TSearchRec; 
begin
(**********************************************************************)
 if FindFirst(MailTEMPAttachmentFolder+'*', faAnyFile, sr) = 0 then
    begin
      repeat
       if 

AnsiPos('tobedeleted',Ansilowercase(sr.name))<>0  then  deletefile(MailTEMPAttachmentFolder+sr.name);

      until FindNext(sr) <> 0;
        FindClose(sr);    
     end;
     
(**********************************************************************)

end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure TRedstone_mail_implant.MailListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean); 
begin
end; 

//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  
procedure TRedstone_mail_implant.MAILComposeNew;
var instr,instr1,strK:string;outlst,l1:tstringlist;
begin
//EDTo,EDCc,EDSubject,EDSmtpServer,EDUsername,EDPOPServer,EDEmail,EDPassword,EDSmtpPort,EDPOPPort:tedit;
 //LBSmtpServer,LBUsername,LBPOPServer,LBEmail,LBPassword,LBSmtpPort,LBPOPPort,LBKeepMailOnServer:tlabel;
// EDKeepMailOnServer:tcheckbox;
// HTMLmemoView,ComposememoView:tmemo;LBoxAttach:Tlistbox; AttachmentHTMLView,HTMLView:TTextBrowser;
 
 pc.activepage:=ts4;
 MailListView.height:=50;
 if (trim(EDTo.text)<>'')or(trim(EDCc.text)<>'')or(trim(EDSubject.text)<>'')or(trim(ComposememoView.lines.text)<>'')
 or((LBoxAttach.items.count)<>0)then 
 if    MessageDlg ('Do you want to save this mail to My Letter folder ?'+#13#10
            , mtInformation, [mbOK,mbNo], 0)=mrOK then
begin
outlst:=tstringlist.create;
l1:=tstringlist.create;
try
instr:=ComposememoView.lines.text;
outlst.text:=LBoxAttach.items.text;
instr1:=PrepareTextToMail(EDTo.text,EDCc.text,EDSubject.text,instr,outlst,nil);
l1.text:=instr1;
strk:=MAILK.CRS_getguid;
l1.savetofile(MyLetterFolderDir+strK);
finally
outlst.free;
l1.free;
end;
end;
EDTo.text:='';EDCc.text:='';EDSubject.text:='';
ComposememoView.clear;
LBoxAttach.clear;
ComposememoView.modified:=false;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////  

procedure TRedstone_mail_implant.WriteToActiveMainMemo(APASSlst:Tstringlist;APASSName:string);
var caretstart,ii:integer;temp:Tcomponent;PASSxfgmemo:Tmemo; 
I,index: Integer; 
  ACOMP: TControl;
begin

DoSource:=true;
try
   for ii := Aform.ComponentCount - 1 downto 0 do
    begin  
temp := Aform.Components[ii]; 
 if (temp is Tpagecontrol) then
     begin
   //  APC:=(temp as Tpagecontrol);
     if (temp as Tpagecontrol).parent= MailPanelMessage then continue else
     begin
 for index := (temp as Tpagecontrol).activepage.ControlCount - 1 downto 0 do
  begin
  (temp as Tpagecontrol).activepage.caption:=APASSName;
     ACOMP := (temp as Tpagecontrol).activepage.Controls[index];
    if  (ACOMP is TMEMO) then
    begin
     PASSxfgmemo:=(ACOMP as tmemo);
     caretstart:=PASSxfgmemo.GetTextLen-length(PASSxfgmemo.lines.strings[PASSxfgmemo.lines.count-1]);
//     if debug then Write(APASSlst.text);
     PASSxfgmemo.lines.add(APASSlst.text);
     PASSxfgmemo.SelStart:=caretstart;
     DoSource:=false;
     exit;
end;//if PanelT

 end; 
 end;
 end;

  end;
  finally
DoSource:=false;
end;

(*

   for ii := Aform.ComponentCount - 1 downto 0 do
    begin
     temp := Aform.Components[ii]; 
     if (temp is Tmemo) then
     begin
     if Ansilowercase((temp as tmemo).name)='xfgmemo' then
     begin
     PASSxfgmemo:=(temp as tmemo);
     caretstart:=PASSxfgmemo.GetTextLen-length(PASSxfgmemo.lines.strings[PASSxfgmemo.lines.count-1]);
     if debug then Write(APASSlst.text);
     PASSxfgmemo.lines.add(APASSlst.text);
     PASSxfgmemo.SelStart:=caretstart;
     end;
     
     end;
     
*)



end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure TRedstone_mail_implant.ViewMailSource(Item: TListItem);  
var FStr,FStr2:string;lst:tstringlist;FileListInfoWorkMassage:TMIMEMESS;
begin    

//if DoingMIME=true then exit;
if DoSource=true then exit;
if Item.index<0 then exit;
if not fileexists(InfoListViewCurrentDir+'.xfgMailercatch')then exit;
if Maillistview.selcount>1 then exit;
lst:=nil;
FileListInfoWorkMassage:=nil;
lst:=tstringlist.create;
FileListInfoWorkMassage:=TMIMEMESS.create;
try
//pathstr+'.xfgMailercatch'
lst.loadfromfile(InfoListViewCurrentDir+'.xfgMailercatch');
FStr:=lst[Item.index];
//lst.clear;
lst.loadfromfile(FStr);
FileListInfoWorkMassage.Lines.text:=(lst.text);
FileListInfoWorkMassage.DecodeMessage;
FStr2:= FileListInfoWorkMassage.header.Subject;
if FStr2='' then FStr2:='Mail-'+extractfilename(FStr);
WriteToActiveMainMemo(lst,FStr2);

aform.show;
finally
if lst<>nil then lst.free;
if FileListInfoWorkMassage<>nil then FileListInfoWorkMassage.free;
//instr1:=PrepareTextToMail(EDTo.text,EDCc.text,EDSubject.text,instr,outlst);
end;

end; 
//////////////////////////////////////////////////////////////////////////////////////////////////    
//////////////////////////////////////////////////////////////////////////////////////////////////    
procedure TRedstone_mail_implant.MailListView1ItemDoubleClick(Sender: TObject; Item: TListItem);  
//var FStr,FStr2:string;lst:tstringlist;FileListInfoWorkMassage:TMIMEMESS;
begin    
(*
//if DoingMIME=true then exit;
if DoSource=true then exit;
if Item.index<0 then exit;
if not fileexists(InfoListViewCurrentDir+'.xfgMailercatch')then exit;
if Maillistview.selcount>1 then exit;
lst:=nil;
FileListInfoWorkMassage:=nil;
lst:=tstringlist.create;
FileListInfoWorkMassage:=TMIMEMESS.create;
try
//pathstr+'.xfgMailercatch'
lst.loadfromfile(InfoListViewCurrentDir+'.xfgMailercatch');
FStr:=lst[Item.index];
//lst.clear;
lst.loadfromfile(FStr);
FileListInfoWorkMassage.Lines.text:=(lst.text);
FileListInfoWorkMassage.DecodeMessage;
FStr2:= FileListInfoWorkMassage.header.Subject;
if FStr2='' then FStr2:='Mail-'+extractfilename(FStr);
WriteToActiveMainMemo(lst,FStr2);

aform.show;
finally
if lst<>nil then lst.free;
if FileListInfoWorkMassage<>nil then FileListInfoWorkMassage.free;
//instr1:=PrepareTextToMail(EDTo.text,EDCc.text,EDSubject.text,instr,outlst);
end;
*)
end; 

//////////////////////////////////////////////////////////////////////////////////////////////////    
////////////////////////////////////////////////////////////////////////////////////////////////// 
procedure TRedstone_mail_implant.DeconstructMail(APASFilename:string);
var lst,AttachmentLstFoListBox,AttachmentLst,HTMLContentIDLst:tstringlist;FStr,headerstr:string;i,partNo:integer;
WorkMassage:Tmimemess;
(**************************************************************************************)
procedure GetAttachmentOfMiMEPart(APASSMimePart:TMIMEPART;APASSSTREAM:TMemoryStream;
                         APASSlst,APASSAttachmentLst:Tstringlist;APASSFilename:string);
                         //MimePart,lst,AttachmentLst,MimePart.filename 
var GS:string;str:string;
begin
GS:='';
GS:=MAILK.CRS_getguid+'-ToBeDeleted-'+APASSFilename;
if  length(APASSMimePart.ContentID) <> 0 then 
begin
//Delete(var S: string; Index, Count:Integer);
str:=APASSMimePart.ContentID;
Delete(str,1,1);
Delete(str,length(str),1);
GS:=MAILK.CRS_getguid+'-ToBeDeleted'+extractfileext(APASSFilename);
HTMLContentIDLst.add(str+'='+GS);
end;
if (APASSlst<>nil) then
APASSlst.savetofile(MailTEMPAttachmentFolder+GS)else
if (APASSSTREAM<>nil) then
APASSSTREAM.savetofile(MailTEMPAttachmentFolder+GS);
APASSAttachmentLst.add(' '); 
case APASSMimePart.EncodingCode of
ME_7BIT, ME_8BIT:str:='TEXT';
ME_QUOTED_PRINTABLE:str:='QUOTED_PRINTABLE';
ME_BASE64:str:='BINARY';
end;

if  length(APASSMimePart.ContentID) <> 0 then 
APASSAttachmentLst.add('<a href="'+MailTEMPAttachmentFolder+GS+'">'+APASSFilename+'</a>'+#13#10+
'TYPE : ContentID in '+str+' file format')else
if  AnsiLowercase(APASSMimePart.Disposition)='attachment' then 
APASSAttachmentLst.add('<a href="'+MailTEMPAttachmentFolder+GS+'">'+APASSFilename+'</a>'+#13#10+
'TYPE : Attachment in '+str+' file format')else
if  AnsiLowercase(APASSMimePart.Disposition)='inline' then 
APASSAttachmentLst.add('<a href="'+MailTEMPAttachmentFolder+GS+'">'+APASSFilename+'</a>'+#13#10+
'TYPE : Inline in '+str+' file format');
APASSAttachmentLst.add('Description : '+APASSMimePart.Description);
AttachmentLstFoListBox.add('<'+APASSFilename+'>');

end;
(**************************************************************************************)
procedure AddHTMLTag(APASSHeaders:string;APASSLst:Tstringlist);
begin
APASSLst.insert(0,'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
APASSLst.insert(1,'<html>');
APASSLst.insert(2,'<head>');
APASSLst.insert(3,'<title>'+'Mail Attachments'+'</title>');
APASSLst.insert(4,'</head>');
APASSLst.insert(5,'<body>');
APASSLst.insert(6,'<pre>');
APASSLst.insert(7,'<font face=helvitica>');
APASSLst.add('</font>');
APASSLst.add('</pre>');
APASSLst.add('</body>');
APASSLst.add('</html>');
end;
(**************************************************************************************)
procedure ProcessHTMLContentID(APASSLSTString:string);
var i:integer;s:string;
begin
//cid:1108968997.14750.7.camel@red-0005
//GS:=APASSMimePart.ContentID+'-ToBeDeleted
//MailTEMPAttachmentFolder+GS
//<001601c4f25a$f775fde0$2c01a8c0@tiptop.com.hk>-ToBeDeleted
//Write('INTO ContentID "cid=???????????"');
for i:=0 to HTMLContentIDLst.count-1 do
begin
s:=HTMLContentIDLst.Names[i];
//Write('Convert cid='+s);
//Write('   into src='+HTMLContentIDLst.Values[s]);
APASSLSTString:=stringreplace(APASSLSTString,'cid:'+s,
MailTEMPAttachmentFolder+HTMLContentIDLst.Values[s],
[rfreplaceall,rfignorecase]);
end;
//PASSxfgmemo.lines.text:=(APASSLSTString) ;
HTMLViewCurrentText:=(APASSLSTString);
HTMLView.text:=APASSLSTString;
//pc.ActivePage := ts2;
end;
(**************************************************************************************)
procedure GetBodyOfMiMEPart(APASSMimePart:TMIMEPART;APASSSTREAM:TMemoryStream;APASSlst:Tstringlist;APASSHeaders:string);
begin
lst.clear;
;
if (APASSlst<>nil) then
begin

lst.assign(APASSLst);
end else
if (APASSSTREAM<>nil) then
begin

lst.loadfromstream(APASSSTREAM);
end;

 if (ansilowercase(trim(APASSMimePart.Secondary))='html')or
    (ansilowercase(trim(APASSMimePart.Secondary))='htm')then
 begin
// Write('INTO html');
 if (AnsiPos('<!doctype html',lst.text)=0)and(lst.count>0) then
lst.insert(0,'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
//ProcessHTMLContentID(lst.text);
 HTMLViewCurrentText:=(lst.text);
 HTMLView.text:=(lst.text) ;
//PASSxfgmemo.lines.text:=(lst.text) ;
 pc.ActivePage := ts2;
 end else
 if (ansilowercase(trim(APASSMimePart.Secondary))='plain')then
 begin
 // Write('INTO plain');
 HTMLmemoView.lines.text:=(lst.text) ;
 HTMLmemoView.selstart:=0;
 pc.ActivePage := ts1;
 end;


end;
(**************************************************************************************)
procedure CheckEncodingCode(APASSHeader:string;APASSMimePart:TMIMEPART);
begin
case APASSMimePart.EncodingCode of
ME_7BIT,ME_8BIT:
begin
//Write('INTO ME_7BIT,ME_8BIT');

if (length(APASSMimePart.filename)<>0)or 
   (AnsiLowercase(APASSMimePart.Disposition)='attachment')or 
   (AnsiLowercase(APASSMimePart.Disposition)='inline')then
 begin
 GetAttachmentOfMiMEPart(APASSMimePart,nil,APASSMimePart.PartBody,AttachmentLst,APASSMimePart.filename);
end else

GetBodyOfMiMEPart(APASSMimePart,nil,APASSMimePart.PartBody,APASSHeader);

end ;//ME_7BIT,ME_8BIT:
ME_BASE64,ME_QUOTED_PRINTABLE: 
begin
//Write('INTO ME_BASE64,ME_QUOTED_PRINTABLE');

APASSMimePart.DecodePart;
if (length(APASSMimePart.filename)<>0)or 
   (AnsiLowercase(APASSMimePart.Disposition)='attachment')or 
   (AnsiLowercase(APASSMimePart.Disposition)='inline')then
 begin
 GetAttachmentOfMiMEPart(APASSMimePart,APASSMimePart.DecodedLines,nil,AttachmentLst,APASSMimePart.filename);

end else

GetBodyOfMiMEPart(APASSMimePart,APASSMimePart.DecodedLines,nil,APASSHeader);

end//ME_BASE64,ME_QUOTED_PRINTABLE: 

else
begin
//Write('INTO NONE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! in around line no. 1105');
end;
end;//case MimePart.EncodingCode of



end;
(**************************************************************************************)
procedure ProcessMIMEPart(APASSHeader:string;APASSMimePart:TMIMEPART;APASSPartCount:integer);
var i:integer;MimePart:TMimePart;
begin
 //EncodingCode=ME_7BIT, ME_8BIT, ME_QUOTED_PRINTABLE and ME_BASE64.
 // If type not recognised, result is ME_7BIT.
 //MP_TEXT, MP_MULTIPART, MP_MESSAGE and MP_BINARY
 
for i:=0 to APASSPartCount-1 do
begin

MimePart:=(APASSMimePart.GetSubPart(i));
(*
//Write
 Write(
'*********************************************************'+#13#10+
'For Mail with subject         : '+APASSHeader+#13#10+ 
'No. of mime parts             : '+inttostr(MimePart.GetSubPartCount)+#13#10+ 
'Content-Type                  : '+MimePart.Primary+'/'+MimePart.Secondary+#13#10+ 
'Content-Transfer-Encoding     : '+MimePart.Encoding+#13#10+ 
'Content-Disposition           : '+MimePart.Disposition+#13#10+ 
'filename                      : '+MimePart.filename+#13#10+
'*********************************************************'+#13#10+#13#10
);
*)
CheckEncodingCode(APASSHeader,MimePart);

if MimePart.GetSubPartCount>0 then 
begin
MimePart.DecomposeParts;
ProcessMIMEPart(APASSHeader,MimePart,MimePart.GetSubPartCount);
end;

end;//for i:=0 to partNo do

end;
(**************************************************************************************)

begin
//if MailListViewCanClick<>true then exit;

DoingMIME:=true;
lst:=nil;
AttachmentLstFoListBox:=nil;
HTMLContentIDLst:=nil;
AttachmentLst:=nil;
WorkMassage:=nil;
lst:=tstringlist.create;
AttachmentLst:=tstringlist.create;
HTMLContentIDLst:=tstringlist.create;
AttachmentLstFoListBox:=tstringlist.create;
WorkMassage:=tmimemess.create;  
try

CheckDeleteTMPAttachment;

HTMLmemoView.clear;
HTMLView.text:='';
AttachmentHTMLViewCurrentText:='';
HTMLViewCurrentText:='';
HTMLViewCurrentText:='';

AttachmentLst.add('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">');
AttachmentLst.add('<html>');
AttachmentLst.add('<head>');
AttachmentLst.add('<title>'+'Mail Attachments'+'</title>');
AttachmentLst.add('</head>');
AttachmentLst.add('<body>');
AttachmentLst.add('<pre>');
AttachmentLst.add('<font face=helvitica>');


WorkMassage.Lines.loadfromfile(APASFilename);
WorkMassage.DecodeMessage; 
//WorkMassage.MessagePart.DecomposeParts;

headerstr:=WorkMassage.header.Subject;
//WorkMassage.MessagePart.Lines.assign(WorkMassage.Lines);

partNo:= WorkMassage.MessagePart.GetSubPartCount;

 // Write('partNo='+inttostr(partNo));
 
 //EncodingCode=ME_7BIT, ME_8BIT, ME_QUOTED_PRINTABLE and ME_BASE64.
 // If type not recognised, result is ME_7BIT.
 //MP_TEXT, MP_MULTIPART, MP_MESSAGE and MP_BINARY
(*
Write
(
'*********************************************************'+#13#10+
'Subject                       : '+headerstr+#13#10+ 
'partNo                        : '+inttostr(partNo)+#13#10+ 
'Content-Type                  : '+WorkMassage.MessagePart.Primary+'/'+WorkMassage.MessagePart.Secondary+#13#10+ 
'Content-Transfer-Encoding     : '+WorkMassage.MessagePart.Encoding+#13#10+ 
'Content-Disposition           : '+WorkMassage.MessagePart.Disposition+#13#10+ 
'filename                      : '+WorkMassage.MessagePart.filename+#13#10+
'*********************************************************'+#13#10+#13#10
);
*)

if partNo>0 then 
begin
WorkMassage.MessagePart.DecomposeParts;
ProcessMIMEPart(headerstr,WorkMassage.MessagePart,partNo);
end;
if partNo=0 then 
CheckEncodingCode(headerstr,WorkMassage.MessagePart);

AttachmentLst.add('</font>');
AttachmentLst.add('</pre>');
AttachmentLst.add('</body>');
AttachmentLst.add('</html>');
AttachmentHTMLViewCurrentText:=(AttachmentLst.text);
AttachmentHTMLView.text:=(AttachmentLst.text) ;



//AttachmentLst.savetofile('/xxxxxxxxxxxxxxxxxxxxxxxc');
if  (trim(HTMLView.text)='')and (trim(HTMLmemoView.lines.text)='') then
pc.ActivePage := ts3;

if  (trim(HTMLView.text)<>'') then
begin
if HTMLContentIDLst.count>0 then
begin
FStr:=HTMLView.text;
ProcessHTMLContentID(FStr);
pc.ActivePage := ts2;
end;
end;



//MailTEMPAttachmentFolder,InfoListViewCurrentDir, QueueFolderDir,MyLetterFolderDir,
// PersonsFolderDir,TRASHFolderDir,OUTBOXFolderDir,INBOXFolderDir:string;
//EDTo,EDCc,EDSubject:tedit;EDTolb,EDCclb,EDSubjectlb:tlabel;
// HTMLmemoView,ComposememoView:tmemo;LBoxAttach:Tlistbox;
if (InfoListViewCurrentDir=QueueFolderDir)or 
(InfoListViewCurrentDir=MyLetterFolderDir)or
(InfoListViewCurrentDir=OUTBOXFolderDir) then
begin
pc.activepage:=ts4;
EDSubject.text:=trim(WorkMassage.header.Subject);
Fstr:='';
if WorkMassage.header.tolist.count<>0 then
begin
Fstr:='';
for i:=0 to WorkMassage.header.tolist.count-1 do
Fstr:=Fstr+WorkMassage.header.tolist[i]+',';
delete(Fstr,length(Fstr),1);
end;
EDTo.text:=Fstr;
Fstr:='';
if WorkMassage.header.CCList.count<>0 then
begin
Fstr:='';
for i:=0 to WorkMassage.header.CCList.count-1 do
Fstr:=Fstr+WorkMassage.header.CCList[i]+',';
delete(Fstr,length(Fstr),1);
end;
EDCc.text:=Fstr;

ComposememoView.lines.text:=HTMLmemoView.lines.text;
if AttachmentLstFoListBox.count=0 then LBoxAttach.items.clear else
LBoxAttach.items.text:=(AttachmentLstFoListBox.text);
end;


finally
if lst <> nil then lst.free;
if WorkMassage<> nil then WorkMassage.free;
if AttachmentLst<>nil then AttachmentLst.free;
if AttachmentLstFoListBox<>nil then AttachmentLstFoListBox.free;
if HTMLContentIDLst<>nil then HTMLContentIDLst.free;
DoingMIME:=false;
end;
end; 

//////////////////////////////////////////////////////////////////////////////////////////////////    
////////////////////////////////////////////////////////////////////////////////////////////////// 
procedure TRedstone_mail_implant.MailListViewItemClick(Sender:TObject;Button:TMouseButton;
                                                       Item:TListItem;const Pt:TPoint;ColIndex:Integer);
var lst:tStringlist;                                                      
begin
if (Button<>mbLeft)then exit;
if DoingMIME=true then exit;
if Maillistview.selcount>1 then exit;
DoingMIME:=true;
lst:=nil;
lst:=tStringlist.create;
if not (fileexists(InfoListViewCurrentDir+'.xfgMailercatch'))then exit else
lst.loadfromfile(InfoListViewCurrentDir+'.xfgMailercatch');
if lst.count=0 then 
begin
if lst<>nil then lst.free;
DoingMIME:=false;
exit;
end;


try



DeconstructMail(lst[Item.index]);

finally
if lst<>nil then lst.free;
DoingMIME:=false;
end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
////////////////////////////////////////////////////////////////////////////////////////////////// 
procedure TRedstone_mail_implant.GetMailFileListInfo(ApassDirStr:String);
var DSTR,FSTR,LNKSTR,Pathstr,APASSFileNAME,tempFileSTR,AttachInside:string;Pinfo:Pfileinfo;
i,fint,sint,LItemIndex:integer;stat:_stat; LItem: TListItem;
ListViewLst:tstringlist;FileListInfoWorkMassage:TMIMEMESS;
DataSortLst,RSTFilelst:tstringlist;SearchRec: TSearchRec;UnixInt:int64;
//TimeLst:tstringlist;

function PermissionString(Mode:mode_t): string;
  function TestBit(Bit: Cardinal): Char;
  begin
    Result := '-';
    if Mode and Bit = Bit then
      case Bit of
        S_IRUSR, S_IRGRP, S_IROTH:
          Result := 'r';
        S_IWUSR, S_IWGRP, S_IWOTH:
          Result := 'w';
        S_IXUSR, S_IXGRP, S_IXOTH:
          Result := 'x';
      end;
  end;
begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '!!!!';
    Exit;
  end
  else begin
    Result := Result + TestBit(S_IRUSR)+ 
                       TestBit(S_IWUSR)+ 
                       TestBit(S_IXUSR)+ 
                       TestBit(S_IRGRP)+ 
                       TestBit(S_IWGRP)+ 
                       TestBit(S_IXGRP)+ 
                       TestBit(S_IROTH)+ 
                       TestBit(S_IWOTH)+ 
                       TestBit(S_IXOTH);
    (*
    Result := Result + TestBit(S_IWUSR);
    Result := Result + TestBit(S_IXUSR);

    Result := Result + TestBit(S_IRGRP);
    Result := Result + TestBit(S_IWGRP);
    Result := Result + TestBit(S_IXGRP);

    Result := Result + TestBit(S_IROTH);
    Result := Result + TestBit(S_IWOTH);
    Result := Result + TestBit(S_IXOTH);
    *)
  end;
end;
function GetFileType(Mode:mode_t): string;
  function TestBit(Bit: Cardinal): String;
  begin
    Result := '';
    if Mode and Bit = Bit then
      case Bit of
        S_IFSOCK:
       	  Result := 'S' ;//socket
        S_IFLNK:	 
          Result := 'L'  ;//symbolic link
        S_IFREG:	 
          Result := 'F'  ;//regular file
        S_IFBLK:	 
          Result := 'B'  ;//block device
        S_IFDIR:	 
          Result := '[DIR]'  ;//directory
        S_IFCHR:	 
          Result := 'C'  ;//character device
        S_IFIFO:	 
          Result := 'I'  ;//fifo

      end;
  end;
begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '!!!!';
    Exit;
  end
  else begin
     Result := Result+TestBit(S_IFDIR)+
                      TestBit(S_IFCHR)+
                      TestBit(S_IFIFO)+
                      TestBit(S_IFLNK)+
                      TestBit(S_IFREG);
     (*
     Result := Result+TestBit(S_IFCHR);
     Result := Result+TestBit(S_IFIFO);
     Result := Result+TestBit(S_IFLNK);
     Result := Result+TestBit(S_IFREG);
     *)
    if TestBit(S_IFSOCK)<>'' then Result := 'S';
    if TestBit(S_IFBLK)<>'' then Result := 'B';
  end;
end;
function PermissionMASK(Mode:mode_t): string;
var tempINT:integer;
  function TestBit(Bit: Cardinal): integer;
  begin
    Result := 0;
    if Mode and Bit = Bit then
      case Bit of
        S_IFSOCK:
       	  Result := 0140000 ;//socket
        S_IFLNK:	 
          Result := 0120000 ;//symbolic link
        S_IFREG:	 
          Result := 0100000 ;//regular file
        S_IFBLK:	 
          Result := 0060000 ;//block device
        S_IFDIR:	 
          Result := 0040000 ;//directory
        S_IFCHR:	 
          Result := 0020000 ;//character device
        S_IFIFO:	 
          Result := 0010000 ;//fifo
        S_IRUSR:
          Result := 400; 
        S_IRGRP:
          Result := 40;  
        S_IROTH:
          Result := 4; 
        S_IWUSR:
          Result := 200;  
        S_IWGRP:
          Result := 20;  
        S_IWOTH:
          Result := 2; 
        S_IXUSR:
          Result := 100;  
        S_IXGRP:
          Result := 10;  
        S_IXOTH:
          Result := 1;
        S_ISUID:
          Result := 4000;
        S_ISGID:
          Result := 2000; 
        S_ISVTX:
          Result := 1000;  
      end;
  end;
begin
  Result := '';
  if Mode = 0 then
  begin
    Result := '!!!!';
    Exit;
  end
  else begin
  tempINT:=0;
    tempINT := tempINT + TestBit(S_IFSOCK)+ 
                         TestBit(S_IFLNK)+ 
                         TestBit(S_IFREG)+ 
                         TestBit(S_IFBLK)+ 
                         TestBit(S_IFDIR)+ 
                         TestBit(S_IFCHR)+ 
                         TestBit(S_IFIFO)+ 
                         TestBit(S_IRUSR)+ 
                         TestBit(S_IWUSR)+ 
                         TestBit(S_IXUSR)+ 
                         TestBit(S_IRGRP)+ 
                         TestBit(S_IWGRP)+ 
                         TestBit(S_IXGRP)+ 
                         TestBit(S_IROTH)+ 
                         TestBit(S_IWOTH)+ 
                         TestBit(S_IXOTH)+ 
                         TestBit(S_ISUID)+ 
                         TestBit(S_ISGID)+ 
                         TestBit(S_ISVTX);
    (*
    tempINT := tempINT + TestBit(S_IFLNK);
    tempINT := tempINT + TestBit(S_IFREG);
    tempINT := tempINT + TestBit(S_IFBLK);
    tempINT := tempINT + TestBit(S_IFDIR);
    tempINT := tempINT + TestBit(S_IFCHR);
    tempINT := tempINT + TestBit(S_IFIFO);
     
    tempINT := tempINT + TestBit(S_IRUSR);
    tempINT := tempINT + TestBit(S_IWUSR);
    tempINT := tempINT + TestBit(S_IXUSR);

    tempINT := tempINT + TestBit(S_IRGRP);
    tempINT := tempINT + TestBit(S_IWGRP);
    tempINT := tempINT + TestBit(S_IXGRP);

    tempINT := tempINT + TestBit(S_IROTH);
    tempINT := tempINT + TestBit(S_IWOTH);
    tempINT := tempINT + TestBit(S_IXOTH);
    tempINT := tempINT + TestBit(S_ISUID);
    tempINT := tempINT + TestBit(S_ISGID);
    tempINT := tempINT + TestBit(S_ISVTX);
    *)
 
  result:=inttostr(tempINT);
  end;
end;
begin
i:=1;
FSTR:='';
DSTR:='';
LNKSTR:='';
if not directoryexists(ApassDirStr)then exit;
APASSFileNAME:=ApassDirStr;
ListViewLst:=nil;
DataSortLst:=nil;
//TimeLst:=nil;
//TimeLst:=tstringlist.create;;
DataSortLst:=tstringlist.create;
ListViewLst:=tstringlist.create;
Maillistview.Cursor:= crHourGlass; 
RSTFilelst:=tstringlist.create;
//TimeLst.sorted:=true;
FileListInfoWorkMassage:=nil;
FileListInfoWorkMassage:=Tmimemess.create; 
try
////////////////////////////////////////////////////////////////

//templst.delete(templst.indexof(pathstr+'.'));
//templst.delete(templst.indexof(pathstr+'..'));
Maillistview.Items.clear;
ListViewLst.clear;
   if LastDelimiter('/',APASSFileNAME)<>length(APASSFileNAME) then APASSFileNAME:=APASSFileNAME+'/';
   pathstr:=(APASSFileNAME);
 //   if FindFirst(APASSFileNAME + '*', faReadOnly Or faHidden  Or faDirectory
 //       Or faSysFile Or faAnyFile Or fasymlink, SearchRec) = 0 then
    if FindFirst(APASSFileNAME + '*', 
        faAnyFile , SearchRec) = 0 then
      try
        repeat
          if (SearchRec.Name ='.') or
              (SearchRec.Name = '..') or
              (trim(SearchRec.Name) = '.xfgMailercatch')then continue
              else
             
              begin
             
       //APASSLst.Add(APASSFileNAME + SearchRec.Name);
     //  tempFileSTR:=(APASSFileNAME + SearchRec.Name);
      // if (tempFileSTR='') or (tempFileSTR=pathstr+'.')or
           //   (tempFileSTR=pathstr+'..')then continue;
 
LNKSTR:='';
//Pinfo:=AllocFileInfo(SearchRec);
//stat:=Pinfo.stat;
//if (SearchRec.Attr and faSymLink <> 0) then 
//if (access(pchar(Pinfo.linktarget),R_OK)<>-1)then LNKSTR:=Pinfo.linktarget 
//else LNKSTR:='Broken file link'; 
if (SearchRec.Attr and faDirectory = 0) then 
//if not(Directoryexists(pathstr+SearchRec.Name))  then 
begin

DSTR:=MAILK.CRS_getguid;
RSTFilelst.clear;   
AttachInside:='';

FileListInfoWorkMassage.clear;
//FileListInfoWorkMassage:TMIMEMESS;
 FileListInfoWorkMassage.Lines.loadfromfile(pathstr+SearchRec.Name);
 FileListInfoWorkMassage.DecodeMessage;
 UnixInt:=DateTimeToUnix(FileListInfoWorkMassage.header.Date);
if UnixInt<0 then continue;
  LNKSTR:=inttostr(UnixInt);


 FileListInfoWorkMassage.MessagePart.DecomposeParts; ;
if (FileListInfoWorkMassage.MessagePart.GetSubPartCount)>1 then
AttachInside:='Yes';


if DataSortLst.count=0 then
begin
DataSortLst.add(LNKSTR);
LItem:=Maillistview.Items.add ;
ListViewLst.add(pathstr+DSTR);//ListViewLst.savetofile(pathstr+'.xfgMailercatch');
//DSTR 
//pathstr+SearchRec.Name
end else
begin

for i:=DataSortLst.count-1 downto 0 do
begin
//MAILK.CRS_DEBUGAppend(LNKSTR,'/zxzxzxzxzxzxz');
if UnixInt>int64(strtoint(DataSortLst[i]))then 
begin 
LItemIndex:=i;
//MAILK.CRS_DEBUGAppend(LNKSTR,'/zxzxz');
end else 
if UnixInt<=int64(strtoint(DataSortLst[i]))then 
begin
LItemIndex:=i+1;
//MAILK.CRS_DEBUGAppend(LNKSTR,'/zxzxz');
break;
end;

end;//for i:=DataSortLst.count-1 downto 0 do

if LItemIndex>DataSortLst.count-1 then
begin
DataSortLst.add(LNKSTR);
LItem:=Maillistview.Items.add ;
ListViewLst.add(pathstr+DSTR);//ListViewLst.savetofile(pathstr+'.xfgMailercatch'); 
end else
//if LItemIndex<DataSortLst.count-1 then
begin
DataSortLst.Insert(LItemIndex,LNKSTR);
ListViewLst.Insert(LItemIndex,pathstr+DSTR);//ListViewLst.savetofile(pathstr+'.xfgMailercatch'); 
LItem:=Maillistview.Items.Insert(LItemIndex);

end;


end;



LItem.caption:=FileListInfoWorkMassage.header.Subject;
             RSTFilelst.add(AttachInside);
             RSTFilelst.add(FileListInfoWorkMassage.header.From);
             RSTFilelst.add(DateTimeToStr(FileListInfoWorkMassage.header.Date));
             RSTFilelst.add(MailK.CRS_GetHumanReadBlockSizeStr(SearchRec.size));
             RSTFilelst.add(stringreplace(FileListInfoWorkMassage.header.ToList.text,#10,'',[rfreplaceall]));
             RSTFilelst.add(FileListInfoWorkMassage.header.ReplyTo);
             RSTFilelst.add(FileListInfoWorkMassage.header.MessageID);
  
LItem.SubItems.assign(RSTFilelst);

renamefile(pathstr+SearchRec.Name,pathstr+DSTR);
//MAILK.CRS_DEBUGAppend(LNKSTR,'/zxzxzxzxzxzxz');

//MAILK.CRS_DEBUGAppend(inttostr(DataSortLst.count),'/zxzxzxzxzxzxz');


end;
end;
        until FindNext(SearchRec) <> 0;
      finally
        FindClose(SearchRec);
        Maillistview.Cursor:= crDefault; 
        ListViewLst.savetofile(pathstr+'.xfgMailercatch');  
      //  DataSortLst.savetofile('/zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz');  
      //if FileListInfoWorkMassage<> nil then FileListInfoWorkMassage.free;
      end;
 
//////////////////////////////////////////////////////////////////
//NoRECURSESearchDir(APASSFileNAME,'*',templst);


//templst.delete(templst.count-1);
Maillistview.Cursor:= crDefault;   
if RSTFilelst<>nil then RSTFilelst.free;
if ListViewLst<>nil then ListViewLst.free;
if FileListInfoWorkMassage<> nil then FileListInfoWorkMassage.free;
if DataSortLst<>nil then DataSortLst.free;
except
if FileListInfoWorkMassage<> nil then FileListInfoWorkMassage.free;
Maillistview.Cursor:= crDefault;   
if RSTFilelst<>nil then RSTFilelst.free;
if ListViewLst<>nil then ListViewLst.free;
if DataSortLst<>nil then DataSortLst.free;

end;
end;
//////////////////////////////////////////////////////////////////////////////////////////////////    
////////////////////////////////////////////////////////////////////////////////////////////////// 


destructor TRedstone_mail_implant.Destroy;

begin
CheckDeleteTMPAttachment;
inherited;

end;

//////////////////////////////////////////////////////////////////////////////////////////////////    
////////////////////////////////////////////////////////////////////////////////////////////////// 


initialization
registerclass(TRedstone_mail_implant);
finalization

unregisterclass(TRedstone_mail_implant);
end.
