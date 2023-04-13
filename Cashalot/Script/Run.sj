﻿//USEUNIT AppControl
//USEUNIT Cashalot
//USEUNIT Components
//USEUNIT Config


//Функция запуска автотеста
function RunTestApp(issue, tCName, testSteps, currentTestStepStatus, ObjectTest)
{
  var logFile = Project.Path+"\\Log\\"+dotNET.System.DateTime.Now().ToShortDateString()+"-"+Issue+".TCMLog";
  var cashalotApp;
  
  Components.SendTeamsMessageStartTest(issue, tCName, testSteps);
  cashalotApp = new AppControl.CashalotApp(Config.PathApp);
  for(var i=0; i<testSteps.Count; i++)
  {
    Components.SendRequest(testSteps.GetValue(i), StepRequestType.ExecutionStart, TestStatus.STEP_INPROCESS);
    var steplogFolder = Log.CreateFolder(testSteps.GetValue(i), "", pmNormal, Config.attrBlock);
    Log.PushLogFolder(steplogFolder);
    ObjectTest.Test(testSteps.GetValue(i));
    Log.PopLogFolder();
    Components.CheckStatus(testSteps.GetValue(i), currentTestStepStatus);
  }  
    Components.CreateLogFile(issue, tCName);
    var logFileFolder = Log.CreateFolder("LOGFILE");
    Log.File(logFile, "Cashalot Log File", "", pmNormal, Config.attrBlock, logFileFolder);
    Log.PopLogFolder();
    Components.SendTeamsMessageStopTest(issue, tCName, currentTestStepStatus);
    cashalotApp.Close();
    //Удаление тестовых Арр из каталога TestedApp
    cashalotApp.DeleteApp();
}