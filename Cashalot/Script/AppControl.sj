//USEUNIT Configurations
//USEUNIT Config

  var isAutotestControllertMode = false;
  //Разбираем аргументы командной строки для получения ExecutionGuid
  for(var p=0; p<BuiltIn.ParamCount(); p++)
  {
    var items = BuiltIn.ParamStr(p).split("=");
    if(items.length != 2)
      continue;
      
    var item = aqString.ToLower(aqString.Replace(aqString.Trim(items[0]),"/",""));
    if(item == "executionguid")
    {
      var batpath =dotNET.System_IO.Path.Combine_3(Project.ConfigPath, "libs", "recreatesession.bat");
      Sys.OleObject("WScript.Shell").Run(batpath);
      Log.Message("ExecutionGUID="+items[1]);
      Project.Variables.ExecutionGuid = items[1];
      isAutotestControllertMode = true;
      NetworkSuite.Variables.CashalotUpdateType = "unread";
    }
    else if(item == "username")
    {
      NetworkSuite.Variables.UserName = items[1];
    }
  }  

function CashalotApp(path)
{
  path = (path==undefined)?ApplicationParameters.APP_PATH:path;
   
  this.Path = dotNET.System_IO.Path.Combine(path, ApplicationParameters.APP_NAME);
  this.Version;
  this.Runned = false;
  var timecount = 0;
  var ApplicationIndex = TestedApps.Add(this.Path);
  var app;
  
  this.DeleteApp = function()
  {
  try
   {
    while(TestedApps.Count!=0)
    {
      TestedApps.Delete(0);
    }
    Log.Message("All tested application was delete");
   }
  catch(e){}
  }
  
  this.Run = function()
  { 
    var p = Sys.WaitProcess("CashaLot");
    if(p.Exists)
    {
       Sys.Process("CashaLot").Terminate();
    }
	  aqUtils.Delay(3000);
    app = TestedApps.Items(ApplicationIndex).Run();
    
    this.Runned = true;
    
    if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCSuggestToUpdate.Exists)
    {
      Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCSuggestToUpdate.Button.Click();
      aqUtils.Delay(17000);
    }
    
    while(!Aliases.CashaLot.HwndSource_LoginView.LoginView.Exists)
    {
      aqUtils.Delay(1000);
      timecount++;
      if(timecount>60)
      {
        Log.Error("Програму запущено, не знайдено вікно для входа.", "", pmNormal, Config.ErrorAt);
        return false;
      }
        
    }
    Log.Message("Програму запущено, відображено вікно для входа.", "", pmNormal, Config.attrBlock);
    
    //Удаление тестовых программ из каталога TestedApps, если таковые имеются
    if(TestedApps.Count!=0)
    this.DeleteApp();

    return true;
  }
  
  this.Dispose = function()
  {
    app.Terminate();
    TestedApps.Delete(ApplicationIndex);
  }
  
  this.Close = function()
  {
    app.Terminate();
  }
  
  return this;
}
