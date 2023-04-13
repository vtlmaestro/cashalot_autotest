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
//USEUNIT ModulsHandlerReport
//USEUNIT GridDayReports



var cashalotApp;
var CurrentTestStepStatus;
var FinalTestStatusValue = new List();
var StringBuilderRunned = "";
var Issue = "TCM-235";
var TCName = "(Автотест) Перевірка роботи модулів розділу 'Звіти' Cashalot";
var logFile = Parameters.NAMELOGFILE+Issue+Parameters.TCMLOG;
var versionCashalot;
var fiscalNumZZvit;

//TestSteps
var TestSteps = new List();
TestSteps.Add("Запуск програми");
TestSteps.Add("Відкрити зміну");
TestSteps.Add("Звіти - Z-звіт");
TestSteps.Add("Звіти - Денні звіти");
TestSteps.Add("Звіти - Періодичні звіти");
TestSteps.Add("Звіти - Про реалізовані товари");


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
      {versionCashalot

        Log.Message("Вхід в програму виконано успішно.", "", pmNormal, Config.attrBlock);
        versionCashalot = GetObject.GetVersionCashalot();
        SendTeamsMessageStartTest(Issue, TCName, versionCashalot);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      
    break;
    
    case "Відкрити зміну":
    //Якщо зміна відкрита, то закриваємо
    var resCheckShift = Cashalot.ShiftControlClose();
    if(resCheckShift == 1)
    {
     Log.Message("Відкрита зміна завершена успішно", "", pmNormal, Config.attrBlock);
     CurrentTestStepStatus = TestStatus.PASS;
     FinalTestStatusValue.Add(TestStatus.PASS);  
    }
    else if(resCheckShift == 0)
    {
     Log.Message("На початок тесту зміна не була відкрита", "", pmNormal, Config.attrBlock);
     CurrentTestStepStatus = TestStatus.PASS;
     FinalTestStatusValue.Add(TestStatus.PASS);  
    }
    else if(resCheckShift == -1)
    {
     Log.Error("Помилка закриття зміни");
    }
    //Відкрити зміну
    var allCashBox = new UCListOfShop();
    var selectGO = allCashBox.SelectNameGO(GONAMEandADDRESS);
    if(!selectGO.OpenByName(NAMEPRRO3))
     {
      Log.Error("Помилка відкриття зміни");
      CurrentTestStepStatus = TestStatus.FAIL;
      FinalTestStatusValue.Add(TestStatus.FAIL);
     }
      else
      {
        Log.Message("Відкриття зміни виконано вдало", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      
      //Створити службове внесення для перевірки "Денні звіти"
      var menu = new Handler.MainMenu();
      var cashDocuments = menu.OpenModules(OPERATION, CASHDOCUMENTS);
      cashDocuments.SelectStartEndPeriod();
      var createCashDoc = new ModulsHandlerOperations.CreateCashDocument();
      createCashDoc.CreateCashDoc();
      if(createCashDoc.CreateOfficialPayment())
      {
        Log.Message("Документ 'Службове внесення' створено успішно", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
        Log.Error("Помилка створення документа 'Службове внесення'");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
            
    break;
      
    case "Звіти - Z-звіт":
    
    var menu = new Handler.MainMenu();
    var zZvit = menu.OpenModules(ZVITY, ZZVIT);
    var newZzvit = new ModulsHandlerReport.ZZvit();
    fiscalNumZZvit = newZzvit.CreateZzvitAndCloseShift();
    if(IsNullOrUndefined(fiscalNumZZvit))
    {
     Log.Error("Документ 'Z-звіт' не створено");
     CurrentTestStepStatus = TestStatus.FAIL;
     FinalTestStatusValue.Add(TestStatus.FAIL);
    }
    else
    {
     Log.Message("Документ 'Z-звіт' створено успішно", "", pmNormal, Config.attrBlock);
     CurrentTestStepStatus = TestStatus.PASS;
     FinalTestStatusValue.Add(TestStatus.PASS);
    }
      
    break;
    
    case "Звіти - Денні звіти":
    
    var menu = new Handler.MainMenu();
    var dailyReport = menu.OpenModules(ZVITY, DAILYREPORTS);
    dailyReport.SelectPrroNameDailyReports(NAMEPRRO3);
    Objects.updatePeriod(DATENOW, DATENOW);
    var gridDayReports = new DockPanelGridDayReports();
    if(gridDayReports.FindDayReport(fiscalNumZZvit))
      {
        Log.Message("Документ 'Z-звіт' присутній в реєстрі 'Денні звіти' за поточну дату", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
        Log.Error("Документ 'Z-звіт' відсутній в реєстрі 'Денні звіти' за поточну дату");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      
    break;
    
    case "Звіти - Періодичні звіти":
    
    var menu = new Handler.MainMenu();
    var periodReport = menu.OpenModules(ZVITY, PERIODREPORTS);
    periodReport.SelectGONamePeriodicalReports(GONAME);
    periodReport.SelectPrroNamePeriodicalReports(NAMEPRRO3);
    Objects.updatePeriodReportPrepare(DATENOWMINUSMONTH, DATENOW);
    var dataPeriodicReport = periodReport.CreatePeriodicalReport();
    var res = aqString.Find(dataPeriodicReport, TOTALSUM);
    if(res != -1)
    {
     Log.Message("Документ 'Періодичний звіт' створено успішно: " + dataPeriodicReport, "", pmNormal, Config.attrBlock);
     CurrentTestStepStatus = TestStatus.PASS;
     FinalTestStatusValue.Add(TestStatus.PASS);  
    }
    else
    {
     Log.Error("Документ 'Періодичний звіт' не створено");
     CurrentTestStepStatus = TestStatus.FAIL;
     FinalTestStatusValue.Add(TestStatus.FAIL);
    }
    
    break;

    case "Звіти - Про реалізовані товари":

    //Створення чека та фіскалізація для звіта 'Про реалізовані товари'
    var newCheckReturnGoods = Handler.GetReceiptObject(PAYWITHOUTREMAIN, VENDORCODE, NAMEPRRO3);     
    var menu = new Handler.MainMenu();
    var salesReport = menu.OpenModules(ZVITY, SOLDGOODS);
    salesReport.SelectGONameAboutSoldGoods(GONAME);
    salesReport.OpenAdditionalFilter();
    Objects.updatePeriodSoldGoods(DATENOWMINUSMONTH, DATENOW);
    salesReport.SelectProductGroupSoldGoods(NAMEPRODUCTGROUPOTHER);
    salesReport.SelectCashierSoldGoods(NAMECASHIER);
    salesReport.SelectPRROSoldGoods(NAMEPRRO3);
//    salesReport.SelectZzvitSoldGoods(NAMEZZVIT);
//    salesReport.SelectProductSoldGoods(NAMEPRODUCT);
    var dataSoldGoodsReport = salesReport.CreateSoldGoodsReport();
    if(aqString.Find(dataSoldGoodsReport, REPORTSOLDGOODS) != -1)
    {
     Log.Message("Документ 'Звіт про реалізовані товари' створено успішно: " + dataSoldGoodsReport, "", pmNormal, Config.attrBlock);
     CurrentTestStepStatus = TestStatus.PASS;
     FinalTestStatusValue.Add(TestStatus.PASS);  
    }
    else
    {
     Log.Error("Документ 'Звіт про реалізовані товари' не створено");
     CurrentTestStepStatus = TestStatus.FAIL;
     FinalTestStatusValue.Add(TestStatus.FAIL);
    }
    
    //Закрити зміну
    var resCheckShift = Cashalot.ShiftControlClose();
    if(resCheckShift == 1)
    {
     Log.Message("Відкрита зміна завершена успішно", "", pmNormal, Config.attrBlock);
     CurrentTestStepStatus = TestStatus.PASS;
     FinalTestStatusValue.Add(TestStatus.PASS);  
    }
    else if(resCheckShift == 0)
    {
     Log.Message("Зміна не була відкрита", "", pmNormal, Config.attrBlock);
     CurrentTestStepStatus = TestStatus.PASS;
     FinalTestStatusValue.Add(TestStatus.PASS);  
    }
    else if(resCheckShift == -1)
    {
     Log.Error("Помилка закриття зміни");
    }
    
    break;
  }
}  



















