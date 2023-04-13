//USEUNIT Config
//USEUNIT StepRequestType
//USEUNIT TestStatus
//USEUNIT UtilsCashalot
//USEUNIT Parameters

var RecieveCollection = "olexandr.filippov@medoc.ua Hennadii.Bilokopytov@medoc.ua Oleksii.Tseshnatii@medoc.ua Yaroslav.Zaiets@medoc.ua Vitaliy.Miniailo@medoc.ua";
var sb = new UtilsCashalot.StringBuilder();
var CurrentDate = dotNET.System.DateTime.Now().ToShortDateString();
  
function SendRequest(stepName, requesttype, stepresult)
{
  if(Components.IsNullOrUndefined(Project.Variables.ExecutionGuid))
  {
    return;
  }
  var address = aqString.Format("http://10.200.87.125/TestCaseExec/%s", (requesttype == StepRequestType.ExecutionStart)?"StartTestItem":"FinishTestItem");
  // Define the request body JSON string
  var requestBody = aqString.Format('{ "TCExecGuid":"%s", "StepName":"%s", "Status":%i, "Notation":""}', Project.Variables.ExecutionGuid, stepName, stepresult);
  // Create the aqHttpRequest object
  var aqHttpRequest = aqHttp.CreatePostRequest(address);
  // Specify the Content-Type header value
  aqHttpRequest.SetHeader("Content-Type", "application/json");
  // Send the request, create the aqHttpResponse object
  var steplogFolderStartTeams = Log.CreateFolder("Send Request", "", pmNormal, Config.attrBlock);
  Log.PushLogFolder(steplogFolderStartTeams);
  var aqHttpResponse = aqHttpRequest.Send(requestBody);
  Log.Message(requestBody);
  // Check the response:
  Log.Message(aqHttpResponse.StatusCode); // A status code
  Log.Message(aqHttpResponse.Text); // A body
  Log.PopLogFolder();
}

function SendMessage(msg, to)
{
  var commandString = aqString.Format("%s \"%s\" %s", Project.ConfigPath+"\\libs\\TeamSender.exe", msg, to);
  Sys.OleObject("WScript.Shell").Run(commandString);
}

function IsNullOrUndefined(obj)
{
  if(obj==undefined || obj==null)
  {
    return true;
  }
  else
  {
    return false;
  }
}

function SendTeamsMessageStartTest(issue, tcName, versionCashalot)
{
//  if(CreateCopyDB())
//  {
//  var versionCashalot = GetCashalotVersionFromDB();
//  }
  StringBuilderRunned =(NetworkSuite.Variables.CashalotUpdateType!="unread")?
  aqString.Format("Версія програми: %s;<br> Тип оновлення: %s<br>", versionCashalot, (aqString.ToUpper(NetworkSuite.Variables.CashalotUpdateType)=="REAL")?"релізне":"тестове"):
  aqString.Format("Версія програми: %s;<br>", versionCashalot);
  StringBuilderRunned += aqString.Format("Користувач: %s<br>", NetworkSuite.Variables.UserName);
  StringBuilderRunned += "Запуск на виконання циклу автоматичних тестів:<br>";
  StringBuilderRunned+=issue + " "+tcName+"<br>";
//  Components.SendMessage(StringBuilderRunned, Components.RecieveCollection);
}

function SendTeamsMessageStopTest(issue, tcName, currentTestStepStatus, versionCashalot)
{
  var StringB = "";
  var UpdateType = "unread";
  UpdateType = (aqString.ToUpper(NetworkSuite.Variables.CashalotUpdateType)=="REAL")?"релізне":"тестове";
  StringB+=(NetworkSuite.Variables.CashalotUpdateType!="unread")?
  aqString.Format("Версія програми: %s;<br> Тип оновлення: %s<br>", versionCashalot,UpdateType):
  aqString.Format("Версія програми: %s;<br>", versionCashalot);
  StringB+=aqString.Format("Користувач: %s<br>", NetworkSuite.Variables.UserName);
  StringB+="Автоматичний тест завершено:<br>";
  StringB+=issue+"<br>";
  StringB+=tcName+"<br>";
  StringB+=(currentTestStepStatus == "FAIL")?"Результат: FAIL":"Результат: PASS";
//  Components.SendMessage(StringB,Components.RecieveCollection);
}

function GetCashalotVersionFromWindowDialog()
{
  return Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.txblVersion.Text;
}

//не реализовано в Кашалоте
function GetCashaloVersionFromDll()
{
  var PathToCashalot = "C:\\ProgramData\\Cashalot\\Cashalot";
  return dotNET.Helper_x64.Utils.GetCashalotVer(PathToCashalot);
}

function GetCashalotVersionFromDB()
{
  var script = "Select ProgramVer from CRINFO";
  try
  {
   var con_Cashalot = "Provider=MSDASQL.1;Persist Security Info=False;Data Source=Cashalot";
   var result;
   var Conn = new ActiveXObject("ADODB.Connection");
   Conn.ConnectionString = con_Cashalot;
   Conn.Open();
   var recSet = new ActiveXObject("ADODB.Recordset");
   recSet.Open(script, Conn);
   result=recSet.Fields.Item(0).Value;
   recSet.Close();
   return result;
  }
   catch (e)
   {
    Log.Message(e.message+" "+e.stack+" "+script);
    return null;
   }
   finally
   {
     if(!Components.IsNullOrUndefined(Conn))
     {
       Conn.Close();
     }
   }
}

function CheckStatus(testitem, testStatus)
{
     var retStatus;
     if(testStatus!="FAIL")
     {
      Log.Message("Перевірка "+testitem+" виконана успішно: step status - PASS","",pmNormal,attrBlock);
      retStatus = TestStatus.STEP_PASS;
     }
     else if(testStatus==TestStatus.STEP_BLOCK)
     {
      Log.Message("Перевірка "+testitem+" не виконана: step status - BLOCK","",pmNormal,attrBlock);
      retStatus = TestStatus.STEP_BLOCK;
     }
     else
     {
     Log.Error("Перевірка "+testitem+" не виконана: step status - FAIL","", pmNormal, attrError);
     retStatus = TestStatus.STEP_FAIL;
    }
    sb.AppendLine("    <item name=\""+aqString.Replace(testitem,"\"","&quot;")+"\" value=\""+testStatus+"\"/>");
     
    if(!IsNullOrUndefined(Project.Variables.ExecutionGuid))
    {
      SendRequest(testitem, StepRequestType.ExecutionStop, retStatus);
    }
}

function CreateLogFile(issue, tcName)
{
  var logText = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"+dotNET.System.Environment.NewLine+"<testitems testcase=\""+issue+"\" testname=\""+tcName+"\">"+dotNET.System.Environment.NewLine+dotNET.System.Environment.NewLine;
  var logFile = Project.Path+"\\Log\\"+CurrentDate+"-"+issue+".TCMLog";
  logText+=sb.Get()+dotNET.System.Environment.NewLine+"</testitems>";
  aqFile.WriteToTextFile(logFile, logText, aqFile.ctUTF8, true);
}

//Создание копии базы данных
function CreateCopyDB()
{ 
  var origDB = PATHDBORIG;
  var copyDB = PATHDBCOPY;
//  aqFileSystem.CopyFile(origDB, copyDB, true);
  try{
  if(dotNET.System_IO.File.Exists(copyDB))
  {
    dotNET.System_IO.File.Delete(copyDB);
  }
  dotNET.System_IO.File.Copy_2(origDB, copyDB);
  if(dotNET.System_IO.File.Exists(copyDB))
  {
    return true;
  }
  }
  catch(e)
  {
  Log.Error("Копія файла бази данних не створено, помилка: "+e)
  }
}



