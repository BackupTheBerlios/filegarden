unit PPClass_RedStone;

interface

uses
Qt, SysUtils, Classes, qGraphics, qControls, qForms, qDialogs,inifiles
 ,RedStone_Public_Comp
  ;

type


  TPPClass_RedStone = class(TObject)


  private
    FPassRS_Calling_Form:TForm;
    FPassRS_Calling_Handle:QApplicationH;
    FCurrComp_Pakage_Class:TRedStone_Public_Comp;
    FCurrComp_Pakage_Handle: HMODULE;
    FPPClass_Filename:String;
    FCallClass_Filename:String;
    FRedStone_SysPath:String;
    FRedstone_UserSysRecIni:String;
    FRedstone_UserSysCompIni:String;
    FPPClass_UserHOMEDIR:String;
    FPassRS_Calling_Form_Caption:String;
    FRS_SYSTEM_RESOURCE_PATH:String;
    FRS_USER_RESOURCE_PATH:String;
    (******************************************)
    FRS_MainPath:String;
    FRS_Calling_APPPath:String;
    FRS_Calling_APPRecPath:String;
    FRS_AppConfigPath:String;
    FRS_CompRecPath:String;
    FRS_OnMyTablePath:String;
    FRS_MenuRecPath:String;
    FRS_CompRecName:String;
    FRS_MenuRecName:String;
    FRS_App_Configuration_Name:String;
    FRS_App_Configuration_Extension:String;
    FRS_Component_Configuration_Extension:String;
    FRS_APP_data_dir:String;
    FRS_APP_image_dir:String;
    FARS_Calling_APP_ExeName:String;
    FAPassPublic_Comp_Name:String;
    FAPassPublic_Comp_classname:String;
  protected

  public
    constructor Create(APassRS_Calling_Handle:QApplicationH;
                          APassRS_Calling_Form:TForm;APassRS_Calling_APP_ExeName:String);//override;    
    destructor Destroy; override;
    function CRS_GetCompType(ACompProcName:String):String;
    function RS_GetRecValue(const ASection,Akey:String):String;
    procedure LoadCompVCL(const APassPublic_Comp_Name: String;const APass_ExeName:string;APassStringList:TStringList);
    procedure UnloadComp;
    procedure UnloadLib;
    procedure LoadCompDLLFromString(const APASSDLLName,APASSDLLFunction: String);
    function CRS_Print_Properties2Str:String;
    Procedure CRS_Print_Properties2File(AFilename:string);
    property RS_Calling_Form: TForm read FPassRS_Calling_Form;
    property RS_Calling_Handle:QApplicationH  read FPassRS_Calling_Handle;
    property RS_CallClassFilename: String read FCallClass_Filename;
    property RS_Class_Filename: String read FPPClass_Filename;
    property RS_Calling_APP_ExeName:String read FARS_Calling_APP_ExeName;
    property RS_Calling_Form_Caption: String read FPassRS_Calling_Form_Caption;
    property RS_APP_data_dir: String read FRS_APP_data_dir;    
    property RS_APP_image_dir: String read FRS_APP_image_dir;    
    property RS_MainPath:String read FRS_MainPath;
    property RS_Calling_APPPath:String read FRS_Calling_APPPath;
    property RS_Calling_APPRecPath:String read FRS_Calling_APPRecPath;
    property RS_Redstone_UserSysRecIni:String read FRedstone_UserSysRecIni;
    property RS_Redstone_UserSysCompIni:String read FRedstone_UserSysCompIni;
    property RS_OnMyTablePath:String read FRS_OnMyTablePath;
    property RS_AppConfigPath:String read FRS_AppConfigPath;
    property RS_CompRecPath:String read FRS_CompRecPath;
    property RS_MenuRecPath:String read FRS_MenuRecPath;
    property RS_MenuRecName:String read FRS_MenuRecName;
    property RS_CompRecName:String read FRS_CompRecName;
    property RS_Calling_MenuRecName:String read FRS_MenuRecName;
    property RS_App_Configuration_Name:String read FRS_App_Configuration_Name;
    property RS_App_Configuration_Extension:String read FRS_App_Configuration_Extension;
    property RS_Component_Configuration_Extension:String read FRS_Component_Configuration_Extension;
    property RS_Calling_UserHOMEDIR: String read FPPClass_UserHOMEDIR;
    property RS_SysPath: String read FRedStone_SysPath;
    property RS_APassPublic_Comp_Name: String read FAPassPublic_Comp_Name;
    property RS_APassPublic_Comp_classname: String read FAPassPublic_Comp_classname;
    property RS_SYSTEM_RESOURCE_PATH: String read FRS_SYSTEM_RESOURCE_PATH;
    property RS_USER_RESOURCE_PATH: String read FRS_USER_RESOURCE_PATH;
 

  published

  end;
 const
    Constant_SYSTEM_Conf_Filename:string='redsys.rec';
    Constant_CALLING_App_Conf_Extension:string='conf';
    Constant_Component_Conf_Extension:string='rec';
    Constant_SYSTEM_RESOURCE_DIRNAME:string='resource';
//procedure Register;

implementation

function TPPClass_RedStone.RS_GetRecValue(const ASection,Akey:String):String;
var
ini:tinifile;
outstr:string;
begin
try
ini:=tinifile.create(FRedstone_UserSysRecIni);
if ini<>nil then
begin
outstr:=ini.ReadString(ASection,Akey,'');
  if pos('[HOME]/',outstr)<>0 then 
      outstr:=StringReplace(outstr,'[HOME]',FPPClass_UserHOMEDIR,[rfIgnoreCase]);
result:=outstr;
//result:= FPPClass_Filename;
ini.free;
end ;
except
result:='';
end;
end;

constructor TPPClass_RedStone.Create(APassRS_Calling_Handle:QApplicationH;
                          APassRS_Calling_Form:TForm;APassRS_Calling_APP_ExeName:String);//override;
var
ps,pc,s:string;
h:THandle;
tempstrLst:tstringlist;
begin
  inherited create;
   FPassRS_Calling_Form:=nil;
   FPassRS_Calling_Handle:=nil;
   FPassRS_Calling_Form:=APassRS_Calling_Form;
   FPassRS_Calling_Form_Caption:=APassRS_Calling_Form.caption;
   FPassRS_Calling_Handle:=APassRS_Calling_Handle;
   h:=GetModuleHandle('PPClass_RedStone_01.so');
   SetLength(PS, 100);	
   SetLength(PS, GetModuleFilename( h, PChar(ps), Length(ps) ) );
   SetLength(PC, 100);
   SetLength(PC, GetModuleFilename( 0, PChar(pc), Length(pc) ) );
   FPPClass_Filename:=ps;
   FCallClass_Filename:=pc;
   FPPClass_UserHOMEDIR:=GetEnvironmentVariable('HOME');
   FRedStone_SysPath:=extractfilepath(FPPClass_Filename);
   FRS_SYSTEM_RESOURCE_PATH:=FRedStone_SysPath+Constant_SYSTEM_RESOURCE_DIRNAME;
   if not (directoryexists(FPPClass_UserHOMEDIR+'/redstone/')) then
      forcedirectories(FPPClass_UserHOMEDIR+'/redstone/');
   FRS_USER_RESOURCE_PATH:=FPPClass_UserHOMEDIR+'/redstone/'+Constant_SYSTEM_RESOURCE_DIRNAME;
  FRedstone_UserSysRecIni:=FPPClass_UserHOMEDIR+'/redstone/'+Constant_SYSTEM_Conf_Filename;
  FRedstone_UserSysCompIni:=FPPClass_UserHOMEDIR+'/redstone/'+'Redstone_comp.'+Constant_Component_Conf_Extension;
   tempstrLst:=tstringlist.create;
   tempstrLst.loadfromfile(FRedStone_SysPath+'/'+Constant_SYSTEM_Conf_Filename);
   tempstrLst.savetofile(FRedstone_UserSysRecIni);
   //FRedStone_SysPath+'/'+'Redstone_comp.'+Constant_Component_Conf_Extension
   tempstrLst.clear;
   tempstrLst.loadfromfile(FRedStone_SysPath+'/'+'Redstone_comp.'+Constant_Component_Conf_Extension);
   tempstrLst.savetofile(FRedstone_UserSysCompIni);
   tempstrLst.free;
   FARS_Calling_APP_ExeName:=APassRS_Calling_APP_ExeName;
if  (pos('command_redstone',lowercase(APassRS_Calling_APP_ExeName))>1) then
begin
 FRS_MainPath:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'parent_path');
 FRS_Calling_APPPath:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'main_path');
 FRS_Calling_APPRecPath:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'rec_path');
 FRS_AppConfigPath:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'app_config_path');
 FRS_CompRecPath:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'comp_rec_path');
 FRS_MenuRecPath:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'menu_rec_path');
 FRS_CompRecName:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'comp_rec_name');
 FRS_MenuRecName:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'menu_rec_name');
 FRS_App_Configuration_Name:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'config_name');
 FRS_App_Configuration_Extension:=Constant_CALLING_App_Conf_Extension;
 FRS_Component_Configuration_Extension:=Constant_Component_Conf_Extension;
 FRS_APP_data_dir:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'data_dir');
 FRS_APP_image_dir:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'image_dir');
 FRS_OnMyTablePath:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'on_my_table');
 end;
 
 if  (pos('command_redstone',lowercase(APassRS_Calling_APP_ExeName))=0) then
 begin
 s:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'parent_app');
 FRS_MainPath:=extractfilepath(s);
 FRS_Calling_APPPath:=RS_getrecvalue(extractfilename(s),'main_path');
 FRS_Calling_APPRecPath:=RS_getrecvalue(extractfilename(s),'rec_path');
 FRS_AppConfigPath:=RS_getrecvalue(extractfilename(s),'app_config_path');
 FRS_CompRecPath:=RS_getrecvalue(extractfilename(s),'comp_rec_path');
 FRS_MenuRecPath:=RS_getrecvalue(extractfilename(s),'menu_rec_path');
 FRS_CompRecName:=RS_getrecvalue(extractfilename(s),'comp_rec_name');
 FRS_MenuRecName:=RS_getrecvalue(extractfilename(s),'menu_rec_name');
 FRS_App_Configuration_Name:=RS_getrecvalue(extractfilename(s),'config_name');
 FRS_App_Configuration_Extension:=Constant_CALLING_App_Conf_Extension;
 FRS_Component_Configuration_Extension:=Constant_Component_Conf_Extension;
 FRS_APP_data_dir:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'data_dir');
 FRS_APP_image_dir:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'image_dir');
 FRS_OnMyTablePath:=RS_getrecvalue(extractfilename(APassRS_Calling_APP_ExeName),'on_my_table');
 end;

end;

destructor TPPClass_RedStone.Destroy;
begin

  UnloadComp;
  inherited;
end;

Procedure TPPClass_RedStone.LoadCompVCL(const APassPublic_Comp_Name: String;
                              const  APass_ExeName:string;APassStringList:TStringList);

var
  ini:tinifile;
  RSP: TRedStone_Internal_Public_Comp;
  sss
  ,app_rec_path
  ,app_rec_name

  :string;
begin
  ini:=nil;
//  if FCurrComp_Pakage_Handle <> 0 then
//    UnloadComp;

 
 sss:=ExtractFileName(FCallClass_Filename);
 sss:=ExtractFileName(APass_ExeName);
  // ini:=tinifile.create(FRedStone_SysPath+'/'+Constant_SYSTEM_Conf_Filename);
  ini:=tinifile.create(FRedstone_UserSysRecIni);

   app_rec_path:=ini.ReadString(sss, 'comp_rec_path', '');
   if pos('[HOME]/',app_rec_path)<>0 then 
      app_rec_path:=StringReplace(app_rec_path,'[HOME]',FPPClass_UserHOMEDIR,[rfIgnoreCase]);
   app_rec_name:=ini.ReadString(sss, 'comp_rec_name', '')+'.'+Constant_Component_Conf_Extension;
   ini.free;
   if fileexists(app_rec_path+'/'+app_rec_name)=false then
     // ini:=tinifile.create(FRedStone_SysPath+'/'+'Redstone_comp.'+Constant_Component_Conf_Extension)else
      ini:=tinifile.create(FRedstone_UserSysCompIni)else
   if fileexists(app_rec_path+'/'+app_rec_name)=true then
      ini:=tinifile.create(app_rec_path+'/'+app_rec_name);
   FAPassPublic_Comp_Name:=ini.ReadString(APassPublic_Comp_Name, 'comp_name', '');
   FAPassPublic_Comp_classname:=ini.ReadString(APassPublic_Comp_Name, 'comp_classname', '');
   ini.free;
if FAPassPublic_Comp_Name<>'' then
begin
    try
   FCurrComp_Pakage_Handle := LoadPackage(FAPassPublic_Comp_Name);
    RSP := TRedStone_Internal_Public_Comp(findClass(FAPassPublic_Comp_classname));
    FCurrComp_Pakage_Class := RSP.Create(FPassRS_Calling_Handle,FPassRS_Calling_Form, APassPublic_Comp_Name,APass_ExeName,APassStringList);
      except
    on E: Exception do
    begin
      if ini<>nil then
      ini.free;
      UnloadComp;   
    //  raise;
    end;
    end;                                  
end;

if FAPassPublic_Comp_Name=''
then  
begin
if MessageDlg (
               'Component never loaded , so abort '+#13#10+#13#10

                  , mtConfirmation, [mbOK], 0, mbOK)=mrok then
//application.terminate;    
;   
end;


end;

procedure TPPClass_RedStone.UnloadComp;

begin

  if FCurrComp_Pakage_Handle <> 0 then
  begin


    if FCurrComp_Pakage_Class <> nil then
    begin

      FCurrComp_Pakage_Class.Free;
      FCurrComp_Pakage_Class := nil;
    end;


    UnRegisterModuleClasses(FCurrComp_Pakage_Handle);

    UnloadPackage(FCurrComp_Pakage_Handle);

    FCurrComp_Pakage_Handle := 0;

  end;
      if lowercase(extractfilename(FARS_Calling_APP_ExeName))='command_redstone'
      then application.terminate;
      
FCurrComp_Pakage_Handle := 0;      
FCurrComp_Pakage_Class := nil;
end;

procedure TPPClass_RedStone.UnloadLib;
begin
(******
  if FCurrComp_Lib_Handle <> 0 then
  begin
   FreeLibrary(FCurrComp_Lib_Handle);
   FCurrComp_Lib_Handle := 0;

  end;
  ******)
  ;
end;

procedure TPPClass_RedStone.LoadCompDLLFromString(const APASSDLLName,APASSDLLFunction: String);
begin
;
end;

function TPPClass_RedStone.CRS_GetCompType(ACompProcName:String):String;
var ini:tinifile;

begin
//create_frame{vrs;default;300;200;default}  //x;xx;sss#aa|ss|qq|a;xx;x
ini:=tinifile.create(FRS_CompRecPath+'/'+FRS_CompRecName+'.rec');
result:=trim(ini.ReadString(ACompProcName, 'comp_type', ''));
ini.free;
end;

function TPPClass_RedStone.CRS_Print_Properties2Str:String;
begin
result:=
'FARS_Calling_APP_ExeName               --->  '+FARS_Calling_APP_ExeName+'  property of --->  RS_Calling_APP_ExeName'+#13#10+
'FPassRS_Calling_Form_Caption           --->  '+FPassRS_Calling_Form_Caption+'  property of --->  RS_Calling_Form_Caption'+#13#10+
'FRS_APP_data_dir                       --->  '+FRS_APP_data_dir+'  property of --->  RS_APP_data_dir'+#13#10+
'FRS_APP_image_dir                      --->  '+FRS_APP_image_dir+'  property of --->  RS_APP_image_dir'+#13#10+
'FCallClass_Filename                    --->  '+FCallClass_Filename+'  property of --->  RS_CallClassFilename'+#13#10+
'FPPClass_Filename                      --->  '+FPPClass_Filename+'  property of --->  RS_Class_Filename'+#13#10+
'FRedStone_SysPath                      --->  '+FRedStone_SysPath+'  property of --->  RS_SysPath'+#13#10+
'FPPClass_UserHOMEDIR                   --->  '+FPPClass_UserHOMEDIR+'  property of --->  RS_Calling_UserHOMEDIR'+#13#10+
'FAPassPublic_Comp_Name                 --->  '+FAPassPublic_Comp_Name+'  property of --->  RS_APassPublic_Comp_Name'+#13#10+
'FAPassPublic_Comp_classname            --->  '+FAPassPublic_Comp_classname+'  property of --->  RS_APassPublic_Comp_classname'+#13#10+
'FRS_MainPath                           --->  '+FRS_MainPath+'  property of --->  RS_MainPath'+#13#10+
'FRS_Calling_APPPath                    --->  '+FRS_Calling_APPPath+'  property of --->  RS_Calling_APPPath'+#13#10+
'FRS_Calling_APPRecPath                 --->  '+FRS_Calling_APPRecPath+'  property of --->  RS_Calling_APPRecPath'+#13#10+
'FRS_AppConfigPath                      --->  '+FRS_AppConfigPath+'  property of --->  RS_AppConfigPath'+#13#10+
'FRS_MenuRecPath                        --->  '+FRS_MenuRecPath+'  property of --->  RS_MenuRecPath'+#13#10+
'FRS_CompRecPath                        --->  '+FRS_CompRecPath+'  property of --->  RS_CompRecPath'+#13#10+
'FRS_CompRecName                        --->  '+FRS_CompRecName+'  property of --->  RS_CompRecName'+#13#10+
'FRS_App_Configuration_Name             --->  '+FRS_App_Configuration_Name+'  property of --->  RS_App_Configuration_Name'+#13#10+
'Constant_SYSTEM_Conf_Filename          --->  '+Constant_SYSTEM_Conf_Filename+'  property of --->  Constant_SYSTEM_Conf_Filename'+#13#10+
'FRS_App_Configuration_Extension        --->  '+FRS_App_Configuration_Extension+'  property of --->  FRS_App_Configuration_Extension'+#13#10+
'FRS_Component_Configuration_Extension  --->  '+FRS_Component_Configuration_Extension+'  property of --->  FRS_Component_Configuration_Extension'+#13#10+
'FRedstone_UserSysRecIni                --->  '+FRedstone_UserSysRecIni+'  property of --->  RS_Redstone_UserSysRecIni'+#13#10+
'FRedstone_UserSysCompIni               --->  '+FRedstone_UserSysCompIni+'  property of --->  RS_Redstone_UserSysCompIni'+#13#10+
'FRS_SYSTEM_RESOURCE_PATH               --->  '+FRS_SYSTEM_RESOURCE_PATH+'  property of --->  RS_SYSTEM_RESOURCE_PATH'+#13#10+
'FRS_USER_RESOURCE_PATH               --->  '+FRS_USER_RESOURCE_PATH+'  property of --->  RS_USER_RESOURCE_PATH'+#13#10+
'FRS_OnMyTablePath                      --->  '+FRS_OnMyTablePath+'  property of --->  RS_OnMyTablePath';

end;

Procedure TPPClass_RedStone.CRS_Print_Properties2File(AFilename:string);
begin


end;

end.
 