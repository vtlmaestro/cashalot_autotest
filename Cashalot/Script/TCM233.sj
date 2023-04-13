//USEUNIT Components
//USEUNIT Config
//USEUNIT StepRequestType
//USEUNIT Objects
//USEUNIT AppControl
//USEUNIT WinHandler
//USEUNIT Cashalot
//USEUNIT Handler
//USEUNIT Parameters
//USEUNIT GetObject


var cashalotApp;
var CurrentTestStepStatus;
var FinalTestStatusValue = new List();
var StringBuilderRunned = "";
var Issue = "TCM-233";
var TCName = "(Автотест) Перевірка відкриття модулів програми Cashalot";
var logFile = Parameters.NAMELOGFILE+Issue+Parameters.TCMLOG;
var versionCashalot;

//TestSteps
var TestSteps = new List();
TestSteps.Add("Запуск програми");
TestSteps.Add("Вікно авторизації. Перевірка функціональних кнопок");
TestSteps.Add("Вікно авторизації. Ввести не вірний пароль");
TestSteps.Add("Вікно авторизації. Ввести вірний пароль");
TestSteps.Add("Відкриття модулів програми");

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
      
    break;
    
    case "Вікно авторизації. Перевірка функціональних кнопок":
      var loginWnd = new WinHandler.LoginForm();
      //Проверка открытия настроек прокси (использовать ручные настройки прокси)
      var manualSetProxy = loginWnd.ProxySettings();
      if(manualSetProxy.Exists)
      {
        manualSetProxy.SetSettingType();
        Log.Message("Обрано: Налаштування проксі вручну.", "", pmNormal, Config.attrBlock);
        aqUtils.Delay(3000);
        manualSetProxy.SetAddress(IPADDRESS);
        manualSetProxy.SetPort(WRONGPORT);
        manualSetProxy.SaveProxi();
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
        else
        {
        Log.Error(aqString.Format("Помилка перевірки налаштувань проксі-сервера: %s", loginWnd.Message));
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
        }
      //Проверка открытия настроек прокси (использовать системные настройки прокси)
      var systemSetProxy = loginWnd.ProxySettings();
      if(systemSetProxy.Exists)
      {
        systemSetProxy.SetSettingType(2);
        Log.Message("Обрано: Використовувати системні налаштування проксі-сервера.", "", pmNormal, Config.attrBlock);
        aqUtils.Delay(3000);
        systemSetProxy.SaveProxi();
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
        else
        {
        Log.Error(aqString.Format("Помилка перевірки налаштувань проксі-сервера: %s", loginWnd.Message));
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
        }
      //Проверка открытия настроек прокси (не использовать прокси)
      var noSetProxy = loginWnd.ProxySettings();
      if(noSetProxy.Exists)
      {
        noSetProxy.SetSettingType(1);
        Log.Message("Обрано: Не використовувати проксі-сервер.", "", pmNormal, Config.attrBlock);
        aqUtils.Delay(3000);
        noSetProxy.TestConnection();
        noSetProxy.SaveProxi();
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
        else
        {
        Log.Error(aqString.Format("Помилка перевірки налаштувань проксі-сервера: %s", loginWnd.Message));
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
        }      

    break;
    
    case "Вікно авторизації. Ввести не вірний пароль":
      var dialog = Cashalot.Login(Parameters.USERCERTNAME, "132");
      if(!dialog.Result)
      {
        Log.Message(aqString.Format("Перевірка вводу не коректного пароля виконана успішно: %s", dialog.Message), "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
        Log.Error(aqString.Format("Помилка перевірки вводу не коректного пароля: %s", dialog.Message));
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
    break;
    
    case "Вікно авторизації. Ввести вірний пароль":
      var dialog = Cashalot.Login(Parameters.USERCERTNAME, Parameters.USERCERTPASSWORD);
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
        Log.Message("Перевірка на коректный пароль пройшла успішно.", "", pmNormal, Config.attrBlock);
        aqUtils.Delay(3000);
        versionCashalot = GetObject.GetVersionCashalot();
        SendTeamsMessageStartTest(Issue, TCName, versionCashalot);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
    break;
    
    case "Відкриття модулів програми":

    var menu = new Handler.MainMenu();
    if(!menu.CheckOpenModules())
      {
        Log.Error(aqString.Format("Помилка перевірки відкриття модулів. %s", menu.Message));
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      else
      {
        Log.Message("Перевірка відкриття модулів виконана успішно!", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
    break;
  }
  
  //Если статус теста фейл то останавливаем весь тест
//  if(CurrentTestStepStatus==TestStatus.FAIL)
//  {
//    SendTeamsMessageStopTest(Issue, TCName, CurrentTestStepStatus);
//    cashalotApp.Dispose();
//    Runner.Stop(true);
////    Runner.Halt(e.message);
//  }
}

function dridText()
{
  var grid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.zgrid;
  var receipt = new Objects.Receipt(grid.Items.get_Item(1), grid);
  receipt.Delete();
}