﻿//USEUNIT Components
//USEUNIT Config
//USEUNIT StepRequestType
//USEUNIT Objects
//USEUNIT AppControl
//USEUNIT Cashalot
//USEUNIT Handler
//USEUNIT Parameters
//USEUNIT ModulesName
//USEUNIT GetObject
//USEUNIT ModulsHandlerSettings
//USEUNIT ModulGeneralSettings
//USEUNIT ModulSettingsUsers
//USEUNIT AdditionalEquipmentPrinter
//USEUNIT ModulAdditionalEquipment


var cashalotApp;
var CurrentTestStepStatus;
var FinalTestStatusValue = new List();
var StringBuilderRunned = "";
var Issue = "TCM-237";
var TCName = "(Автотест) Перевірка роботи модуля 'Налаштування' Cashalot";
var logFile = Parameters.NAMELOGFILE+Issue+Parameters.TCMLOG;
var versionCashalot;

//TestSteps
var TestSteps = new List();
TestSteps.Add("Запуск програми");
TestSteps.Add("Налаштування - Загальні налаштування");
TestSteps.Add("Налаштування - Сервісні операції");
TestSteps.Add("Налаштування - Додаткове обладнання");
TestSteps.Add("Налаштування - Користувачі");

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
     
     case "Налаштування - Загальні налаштування":
     var menu = new Handler.MainMenu();
     var zZvit = menu.OpenModules(SETTINGS, GENERALSETTINGS);
     var modulSettings = new GeneralSettingsModul();
     
     Log.Message("Перевірка розділу 'Господарська одиниця'", "", pmNormal, Config.attrBlock);
     modulSettings.SelectGroupSettings(BUSINESSUNIT);
     
     Log.Message("Перевірка наявності підприємства", "", pmNormal, Config.attrBlock);
     var checkEnterprise = new CheckBusinessUnit().CheckEnterprise();
     if(checkEnterprise.BoolValue)
     {
       Log.Message("Підприємство, що перевіряеться знайдено в розділі 'Господарська одиниця': "+"'"+checkEnterprise.EnterpriseName+"'", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Підприємство, що перевіряється не знайдено в розділі 'Господарська одиниця'");
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }

     Log.Message("Перевірка наявності ГО", "", pmNormal, Config.attrBlock);     
     var checkGo = new CheckBusinessUnit().CheckGO();     
     if(checkGo.BoolValue)
     {
       Log.Message("ГО, що перевіряеться знайдено в розділі 'Господарська одиниця': "+"'"+checkGo.GOName+"'", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("ГО, що перевіряється не знайдено в розділі 'Господарська одиниця'");
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }
     
     Log.Message("Перевірка помилкових налаштувань пошти", "", pmNormal, Config.attrBlock);
     var checkWrongMail = new CheckBusinessUnit().CheckWrongEmail();
     if(!checkWrongMail.BoolValue)
     {
       Log.Message("Перевірка помилкових пошти налаштувань виконана успішно: "+checkWrongMail.Text, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Message("Помилка перевірки налаштувань пошти "+checkWrongMail.Text);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS); 
     }
     
     Log.Message("Перевірка коректних налаштувань пошти", "", pmNormal, Config.attrBlock);
     var checkMail = new CheckBusinessUnit().CheckEmail();
     if(checkMail.BoolValue)
     {
       Log.Message("Перевірка налаштувань пошти виконана успішно: "+checkMail.Text, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Message("Помилка перевірки налаштувань пошти "+checkMail.Text);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS); 
     }
     
     
     Log.Message("Перевірка розділу 'ПРРО'", "", pmNormal, Config.attrBlock);
     modulSettings.SelectGroupSettings(PRRO);
     var prroItem = new CheckPRRO().GetPrroItem();
     if(prroItem.BoolValue)
     {
       Log.Message("Перевірка розділу ПРРО виконана успішно, знайдено ПРРО з назвою: "+"'"+prroItem.PrroName.OleValue+"' та ФН: "+prroItem.FiscalNum, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Помилка перевірки розділу ПРРО, в налаштуваннях не знайдено ПРРО з фіскальним номером: "+FISCALNAMBER);
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }
    
     Log.Message("Перевірка розділу 'Проксі сервер'", "", pmNormal, Config.attrBlock);
     modulSettings.SelectGroupSettings(PROXYSERVER);
     var checkProxySettings = new ModulGeneralSettings.CheckProxyServerSettings();
     
     Log.Message("Перевірка налаштування проксі з типом 'Не використовувати проксі-сервер'", "", pmNormal, Config.attrBlock);
     checkProxySettings.SetProxySettingType(NOUSEPROXY);
     
     if(checkProxySettings.SaveSettingProxy())
     {
       Log.Message("Збереження налаштування з типом 'Не використовувати проксі-сервер' виконано успішно", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Збереження налаштування з типом 'Не використовувати проксі-сервер' не виконано");
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }
     
     //Виконання перевірки з'єднання з проксі-сервером
     var resultCheckConnection = checkProxySettings.TestProxyConnection();
     
     if(resultCheckConnection.BoolValue)
     {
       Log.Message("Перевірка з'єднання з типом налаштування 'Не використовувати проксі-сервер' виконана: "+resultCheckConnection.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Message("Помилка перевірки з'єднання з типом налаштування 'Не використовувати проксі-сервер': "+resultCheckConnection.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS); 
     }
     
     Log.Message("Перевірка налаштування проксі з типом 'Використовувати системні налаштування проксі-сервера'", "", pmNormal, Config.attrBlock);
     checkProxySettings.SetProxySettingType(USESYSTEMPROXY);
     
     if(checkProxySettings.SaveSettingProxy())
     {
       Log.Message("Збереження налаштування з типом 'Використовувати системні налаштування проксі-сервера' виконано успішно", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Збереження налаштування з типом 'Використовувати системні налаштування проксі-сервера' не виконано");
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }
     
     //Виконання перевірки з'єднання з проксі-сервером
     var resultCheckSysConnection = checkProxySettings.TestProxyConnection();
     
     if(resultCheckSysConnection.BoolValue)
     {
       Log.Message("Перевірка з'єднання з типом налаштування 'Використовувати системні налаштування проксі-сервера' виконана: "+resultCheckSysConnection.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Message("Помилка перевірки з'єднання з типом налаштування 'Використовувати системні налаштування проксі-сервера': "+resultCheckSysConnection.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS); 
     }
     
     Log.Message("Перевірка налаштування проксі з типом 'Налаштувати проксі вручну'", "", pmNormal, Config.attrBlock);
     checkProxySettings.SetProxySettingType();
     checkProxySettings.SetProxyAddress(IPADDRESS);
     checkProxySettings.SetProxyPort(WRONGPORT);
     
     if(checkProxySettings.SaveSettingProxy())
     {
       Log.Message("Збереження налаштування з типом 'Налаштувати проксі вручну' виконано успішно", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Збереження налаштування з типом 'Налаштувати проксі вручну' не виконано");
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }
     
     //Виконання перевірки з'єднання з проксі-сервером з типом налаштування 'Налаштувати проксі вручну'
     var resultCheckManualConnection = checkProxySettings.TestProxyConnection();
     
     if(resultCheckManualConnection.BoolValue)
     {
       Log.Message("Перевірка з'єднання з типом налаштування 'Налаштувати проксі вручну' виконана: "+resultCheckManualConnection.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Message("Помилка перевірки з'єднання з типом налаштування 'Налаштувати проксі вручну': "+resultCheckManualConnection.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS); 
     }
     
     //повернення початкових налаштувань проксі
     checkProxySettings.ClearProxyAddress();
     checkProxySettings.ClearProxyPort();
     checkProxySettings.SetProxySettingType(NOUSEPROXY);
     checkProxySettings.SaveSettingProxy();
     
     break;
    
     case "Налаштування - Сервісні операції":
     var menu = new Handler.MainMenu();
     var zZvit = menu.OpenModules(SETTINGS, SERVICEOPERATIONS);     
     
     break;
     
     case "Налаштування - Додаткове обладнання":
     var menu = new Handler.MainMenu();
     var zZvit = menu.OpenModules(SETTINGS, ADDITIONALEQUIPMENT);  
     var additionalEquipment = new AdditionalEquipment();
     additionalEquipment.SelectAdditionalEquipment(PRINTER);
     
     Log.Message("Перевірка налаштувань принтера", "", pmNormal, Config.attrBlock);
     var resCheckprint;
     var printCheck = new CheckSettingsPrinter();
     resCheckprint = printCheck.SetPrinter(ONENOTE);
     if(printCheck.CheckPrintActive(ONENOTE))
     {
       Log.Message(aqString.Concat(ONENOTE, resCheckprint), "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Притер "+ONENOTE+" не було обрано за замовчуванням", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }
     
     resCheckprint = printCheck.SetPrinter(XPS);
     if(printCheck.CheckPrintActive(XPS))
     {
       Log.Message(aqString.Concat(XPS, resCheckprint), "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Притер "+XPS+" не було обрано за замовчуванням", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }     

     resCheckprint = printCheck.SetPrinter(PRINTTOPDF);
     if(printCheck.CheckPrintActive(PRINTTOPDF))
     {
       Log.Message(aqString.Concat(PRINTTOPDF, resCheckprint), "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Притер "+PRINTTOPDF+" не було обрано за замовчуванням", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     } 
     
     resCheckprint = printCheck.SetPrinter(FAX);
     if(printCheck.CheckPrintActive(FAX))
     {
       Log.Message(aqString.Concat(FAX, resCheckprint), "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Притер "+FAX+" не було обрано за замовчуванням", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }

     Log.Message("Перевірка налаштування POS-термінала", "", pmNormal, Config.attrBlock);
     additionalEquipment.SelectAdditionalEquipment(POSTERMINAL);
     var checkPosTerminal = new CheckSettingsPosTerminal();
     var resultCheckConnectTerminal = checkPosTerminal.CheckPosTerminal(PRIVATUSB, PATHDRIVER, DRIVERUSBEXE, ADDRESSDRIVER, PORTDRIVER);
     if(resultCheckConnectTerminal.BoolValue)
     {
       Log.Message("Перевірка з'єднання з драйвером "+PRIVATUSB+" виконана: "+resultCheckConnectTerminal.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Message("Помилка перевірки з'єднання з драйвером "+PRIVATUSB+": "+resultCheckConnectTerminal.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS); 
     }    
     
     Log.Message("Перевірка налаштувань розділу Ваги", "", pmNormal, Config.attrBlock);
     additionalEquipment.SelectAdditionalEquipment(SCALES);
     var checkSettingsScale = new CheckSettingsScales();
     var resultCheckConnecScales =  checkSettingsScale.CheckScales(UNIPROCOM, PATHDRIVERSCALES, DRIVERSCALES, SCALESWITHCRISTALINDICATOR, COMPORT);
     if(resultCheckConnecScales.BoolValue)
     {
       Log.Message("Перевірка з'єднання з драйвером "+UNIPROCOM+" виконана: "+resultCheckConnectTerminal.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Message("Помилка перевірки з'єднання з драйвером "+UNIPROCOM+": "+resultCheckConnectTerminal.TextValue, "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS); 
     }      
     
     break;
     
     case "Налаштування - Користувачі":
     var menu = new Handler.MainMenu();
     var zZvit = menu.OpenModules(SETTINGS, USERS);    
     var listusers = new CheckListUsers(); 
     Log.Message("Пошук користувача "+NAMEUSER+" в ListView", "", pmNormal, Config.attrBlock);
     if(listusers.CheckSetSearch(NAMEUSER))
     {
       Log.Message("Користувача "+NAMEUSER+" знайдено в переліку ListView", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Користувач "+NAMEUSER+" відсутній в переліку ListView");
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }
     
     //Видалення данних в пошуковому полі SearchBox
      listusers.ClearSearchText();
      
      Log.Message("Обрати користувача в ListView", "", pmNormal, Config.attrBlock);
      var user = listusers.SelectUserOnList(NAMEUSER);
      if(user.BoolValue)
     {
       Log.Message("Користувача "+NAMEUSER+" успішно обрано в переліку ListView", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Користувач "+NAMEUSER+" відсутній в переліку ListView");
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }
      
     Log.Message("Первірка данних обраного користувача", "", pmNormal, Config.attrBlock);
     listusers.CheckSetSearch(NAMEUSER);
     var userData = listusers.CheckUserData(NAMEUSER, KASIR, IPN);
     if(userData.BoolValue)
     {
       Log.Message("Користувач "+NAMEUSER+" присутній в GridDataUser", "", pmNormal, Config.attrBlock);
       CurrentTestStepStatus = TestStatus.PASS;
       FinalTestStatusValue.Add(TestStatus.PASS);
     }
     else
     {
       Log.Error("Користувача "+NAMEUSER+" не знайдено в GridDataUser");
       CurrentTestStepStatus = TestStatus.FAIL;
       FinalTestStatusValue.Add(TestStatus.FAIL); 
     }
     //Видалення данних в пошуковому полі SearchBox
      listusers.ClearSearchText();
     
     break;
  }
}














