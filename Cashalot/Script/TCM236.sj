//USEUNIT Components
//USEUNIT Config
//USEUNIT StepRequestType
//USEUNIT Objects
//USEUNIT AppControl
//USEUNIT Cashalot
//USEUNIT Handler
//USEUNIT Parameters
//USEUNIT ModulesName
//USEUNIT GetObject
//USEUNIT ModulsHandlerDirectory
//USEUNIT GridDirectoryNomenklatura 


var cashalotApp;
var CurrentTestStepStatus;
var FinalTestStatusValue = new List();
var StringBuilderRunned = "";
var Issue = "TCM-236";
var TCName = "(Автотест) Перевірка роботи модуля 'Довідники' Cashalot";
var logFile = Parameters.NAMELOGFILE+Issue+Parameters.TCMLOG;
var versionCashalot;

//TestSteps
var TestSteps = new List();
TestSteps.Add("Запуск програми");
TestSteps.Add("Довідники - Номенклатура");
TestSteps.Add("Довідники - Програми лояльності");


//Функция запуска автотеста
function Run()
{
  cashalotApp = new AppControl.CashalotApp(Config.PathApp);
  for(var i=0; i<TestSteps.Count; i++)
  {
    Components.SendRequest(TestSteps.GetValue(i), StepRequestType.ExecutionStart, TestStatus.STEP_INPROCESS);
    var steplogFolder = Log.CreateFolder(TestSteps.GetValue(i), "", pmNormal, Config.attrBlock);
    Log.PushLogFolder(steplogFolder);
    Test(TestSteps.GetValue(i));
    Log.PopLogFolder();
    //на последней итерации выставляем FinalTestStatusValue
    if(i == TestSteps.Count-1)
    {
      for(var j=0; j<FinalTestStatusValue.Count; j++)
      {
        if(FinalTestStatusValue.Contains(TestStatus.FAIL))
        {
          CurrentTestStepStatus = TestStatus.FAIL;
        }
      }
    }
    Components.CheckStatus(TestSteps.GetValue(i), CurrentTestStepStatus);
  }  
    Components.CreateLogFile(Issue, TCName);
    var logFileFolder = Log.CreateFolder("LOGFILE");
    Log.File(logFile, "Cashalot Log File", "", pmNormal, Config.attrBlock, logFileFolder);
    Log.PopLogFolder();
    SendTeamsMessageStopTest(Issue, TCName, CurrentTestStepStatus, versionCashalot);
    cashalotApp.Close();
}

//Выполнение кейсов теста
function Test(Step)
{
    switch(Step)
  {
    case "Запуск програми":
    
    CurrentTestStepStatus =(cashalotApp.Run())? TestStatus.PASS : TestStatus.FAIL;
    var dialog = Cashalot.Login(Parameters.USERCERTNAME, Parameters.USERCERTPASSWORD, false);
    if(!dialog.Result)
    {
      Log.Error(aqString.Format("Помилка під час запуску: %s", dialog.Message));
      if(aqString.Compare(dialog.Message, ERRORCONNECTBACKOFFICE, true)==0)
      {
        versionCashalot = GetObject.GetVersionCashalot();
        SendTeamsMessageStartTest(Issue, TCName, versionCashalot);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
      CurrentTestStepStatus = TestStatus.FAIL;
      FinalTestStatusValue.Add(TestStatus.FAIL);
      }
    }
      else
      {
        Log.Message("Вхід в програму виконано успішно.", "", pmNormal, Config.attrBlock);
        versionCashalot = GetObject.GetVersionCashalot();
        SendTeamsMessageStartTest(Issue, TCName, versionCashalot);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
          
    break;
    
    case "Довідники - Номенклатура":
    
    var menu = new Handler.MainMenu();
    var zZvit = menu.OpenModules(DIRECTORY, NOMENCLATURE);
    
    Log.Message("Створення нового товару з артикулом '8989'");  
    if(ModulsHandlerDirectory.CreateNewGood(Parameters.VENDORCODE8989))
    {
      CurrentTestStepStatus = TestStatus.PASS;
      FinalTestStatusValue.Add(TestStatus.PASS);
      Log.Message("Товар з артикулом '8989' успішно створено");
    }
    else
    {
      CurrentTestStepStatus = TestStatus.FAIL;
      FinalTestStatusValue.Add(TestStatus.FAIL);
      Log.Error("Товар з артикулом '8989' не створено");
    }
    
    Log.Message("Редагування створенного товару з артикулом '8989'");
    var gridGoods = new GridGoods();
    if(gridGoods.EditGood(Parameters.VENDORCODE8989))
    {
      CurrentTestStepStatus = TestStatus.PASS;
      FinalTestStatusValue.Add(TestStatus.PASS);
      Log.Message("Успішно внесені зміни в товарі");
    }
    else
    {
      CurrentTestStepStatus = TestStatus.FAIL;
      FinalTestStatusValue.Add(TestStatus.FAIL);
      Log.Error("Зміни в тестовому товарі не виконано");
    }
    
    Log.Message("Видалення товару з артикулом 8989");
    if(gridGoods.DeleteGood(Parameters.VENDORCODE8989))
    {
      CurrentTestStepStatus = TestStatus.PASS;
      FinalTestStatusValue.Add(TestStatus.PASS);
      Log.Message("Товар успішно видалений");
    }
    else
    {
      CurrentTestStepStatus = TestStatus.FAIL;
      FinalTestStatusValue.Add(TestStatus.FAIL);
      Log.Error("Тестовий товар не було видалено");
    }
    
    if(ModulsHandlerDirectory.Synchronization())
    {
      CurrentTestStepStatus = TestStatus.PASS;
      FinalTestStatusValue.Add(TestStatus.PASS);
      Log.Message("Синхронизація довідника успішно виконана");
    }
    else
    {
      CurrentTestStepStatus = TestStatus.FAIL;
      FinalTestStatusValue.Add(TestStatus.FAIL);
      Log.Error("Помилка під час виконання синхронизації довідника");
    }
    
    if(ModulsHandlerDirectory.ImportNomenklatura())
    {
      CurrentTestStepStatus = TestStatus.PASS;
      FinalTestStatusValue.Add(TestStatus.PASS);
      Log.Message("Імпорт номенклатури виконано вдало"); 
    }
    else
    {
      CurrentTestStepStatus = TestStatus.PASS;
      FinalTestStatusValue.Add(TestStatus.PASS);
      Log.Error("Імпорт номенклатури не виконано");
    }

    break;
    
    case "Довідники - Програми лояльності":
    
    var menu = new Handler.MainMenu();
    var zZvit = menu.OpenModules(DIRECTORY, LOYALTYPROGRAMS);  
    
    break;
  }
}