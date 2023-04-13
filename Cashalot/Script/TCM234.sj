//USEUNIT AppControl
//USEUNIT Cashalot
//USEUNIT Components
//USEUNIT Config
//USEUNIT GetObject
//USEUNIT GridAsideCheck
//USEUNIT GridOperationsHistory
//USEUNIT GridWorkOpenShift
//USEUNIT Handler
//USEUNIT ModulesName
//USEUNIT ModulsHandlerOperations
//USEUNIT Objects
//USEUNIT Parameters
//USEUNIT StepRequestType
//USEUNIT WinHandler

var cashalotApp;
var CurrentTestStepStatus;
var FinalTestStatusValue = new List();
var StringBuilderRunned = "";
var Issue = "TCM-234";
var TCName = "(Автотест) Перевірка роботи модулів розділу 'Операції' Cashalot";
var logFile = Parameters.NAMELOGFILE+Issue+Parameters.TCMLOG;
var versionCashalot;

//TestSteps
var TestSteps = new List();
TestSteps.Add("Запуск програми");
TestSteps.Add("Відкрити зміну");
TestSteps.Add("Операції - Відкладені чеки");
TestSteps.Add("Операції - Касові документи - Службове внесення");
TestSteps.Add("Операції - Касові документи - Службова видача");
TestSteps.Add("Операції - Касові документи - Акт видачи коштів при поверненні товару");
TestSteps.Add("Операції - Касові документи - Акт скасування помилкової суми розрахунків (сторно)");
TestSteps.Add("Операції - Касові документи - Акт скасування помилкової суми розрахунків (Видатковий чек)");
TestSteps.Add("Операції - Історія операцій - Завантаження чеків з ФС ДПС");
TestSteps.Add("Операції - Історія операцій - Відправлення даних");

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
  var NamberOrderCheck;
  
    switch(Step)
  {
      case "Запуск програми":
//      Indicator.PushText("Запуск програми");
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
      if(!selectGO.OpenByName(NAMEPRRO1))
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
      
      break;
      
      case "Операції - Відкладені чеки":
      
      //Створити чек без реестрації
      var workGridShift = new GridWorkOpenShift.WorkOpenShiftGrid();
      var newCheck = workGridShift.CreateNewCheck(VENDORCODE);
      var localCheckNumber = newCheck.LocalNumber;
      //Відкласти чек
      workGridShift.AsideCheck();
      //Відкрити модуль Відкладені чеки
      var menu = new Handler.MainMenu();
      var postponedChecks = menu.OpenModules(OPERATION, POSTPONEDCHECKS);
      postponedChecks.SelectUserNameUCPostponedReceipts(NAMEUSER);
      postponedChecks.SelectPrroNameUCPostponedReceipts(NAMEPRRO1);
      postponedChecks.SelectStartEndPeriod();
      var docPanelAsideCheck = new GridAsideCheck.DockPanelGridAsideCheck();
      if(docPanelAsideCheck.FindAsideCheck(localCheckNumber))
      {
        Log.Message("Відкладений чек присутній в реєстрі 'Відкладені чеки'", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
         Log.Error("Відкладений чек не створено");
         CurrentTestStepStatus = TestStatus.FAIL;
         FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      break;
    
      case "Операції - Касові документи - Службове внесення":
      
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
      
      case "Операції - Касові документи - Службова видача":
      
      var menu = new Handler.MainMenu();
      var cashDocuments = menu.OpenModules(OPERATION, CASHDOCUMENTS);
      cashDocuments.SelectStartEndPeriod();
      var createCashDoc = new ModulsHandlerOperations.CreateCashDocument();
      createCashDoc.CreateCashDoc();
      if(createCashDoc.CreateOfficialGiving())
      {
        Log.Message("Документ 'Службова видача' створено успішно", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
        Log.Error("Помилка створення документа 'Службова видача'");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      
      break;
      
      case "Операції - Касові документи - Акт видачи коштів при поверненні товару":
      
      //Створення чека та фіскалізація для 'Акт видачи коштів при поверненні товару'
      var newCheckReturnGoods = Handler.GetReceiptObject(PAYWITHOUTREMAIN, VENDORCODE, NAMEPRRO1);
      //Получаем грид открытой смены и создаем возврат
      var gridOpenShift = new WorkOpenShiftGrid();
      var refundChek = new gridOpenShift.Refund();
      refundChek.ClickRefund();
      refundChek.setTextFiscalNumBox(newCheckReturnGoods.FiscalNumber);
      refundChek.SelectPrroNum(newCheckReturnGoods.CashRegisterFiscalNumber);
      //Нажать кнопку Перевірити
      refundChek.ClickSearchBtn();
      //Нажали кнопку Продовжити повернення  
      var newRefundCheck;
      if(refundChek.ContinueRefund())
      {
        newRefundCheck = refundChek.RefundCash();
      }
      else
      {
        Log.Error("Не отримано об'єкт Чек повернення");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      //Відрити модуль Касові документи
      var menu = new Handler.MainMenu();
      var cashDocuments = menu.OpenModules(OPERATION, CASHDOCUMENTS);
      //Створення Акт видачи коштів при поверненні товару
      var createAktGivingMoneyReturnGoods = new ModulsHandlerOperations.CreateCashDocument();
      createAktGivingMoneyReturnGoods.CreateCashDoc();
      createAktGivingMoneyReturnGoods.CreateGivingMoneyReturnGoods();
      if(createAktGivingMoneyReturnGoods.ActOnGivingManyReturnGoods(NAMEPRRO1, newRefundCheck.FiscalNumber))
      {
        Log.Message("Документ 'Акт видачи коштів при поверненні товару' успішно створено", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
        Log.Error("Документ 'Акт видачи коштів при поверненні товару' не створено");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      
      break;
      
      case "Операції - Касові документи - Акт скасування помилкової суми розрахунків (сторно)":
      
      //Створення чека та фіскалізація для 'Акт скасування помилкової суми розрахунків (сторно)'
      var newCheck = Handler.GetReceiptObject(PAYWITHOUTREMAIN, VENDORCODE, NAMEPRRO1);
      //Відрити модуль Історія операцій та встановити фільтри
      var menu = new Handler.MainMenu();
      var historyOperations = menu.OpenModules(OPERATION, HISTORYOPERATIONS);
      historyOperations.SelectGONameOperationsHistory(GONAME);
      historyOperations.SelectPrroNameOperationsHistory(NAMEPRRO1); 
      historyOperations.SelectStartEndPeriod();
      historyOperations.SelectUserNameOperationsHistory(newCheck.CashierName);
      historyOperations.InsertNumberCheckOperationsHistory(newCheck.LocalNumber);
      historyOperations.SearchBtClick();   
      //Получаем грид История операций
      var operationHistory = new GridOperationsHistory.OperationsHistory(); 
      //Створюємо сторно
      operationHistory.ClickStorno();
      operationHistory.CreateStorno();
      //Очистити пошук для отримання всіх документів грида
      historyOperations.ClearSearchData();
      historyOperations.SearchBtClick();
      //Перевірити наявність сторнованого чека та отримати його ФН
      var FiscalNumberCheckStoprno = operationHistory.IsExistCheckStorno();
      //Відрити модуль Касові документи
      var menu = new Handler.MainMenu();
      var cashDocuments = menu.OpenModules(OPERATION, CASHDOCUMENTS);
      //Створення Акт скасування помилкової суми розрахунків (сторно)
      var actCancelErrorAmountCalcStorno = new ModulsHandlerOperations.CreateCashDocument();
      actCancelErrorAmountCalcStorno.CreateCashDoc();
      actCancelErrorAmountCalcStorno.CreateCancelWrongSumReversal();
      if(actCancelErrorAmountCalcStorno.ActCancelErrorAmountCalculationsStorno(NAMEPRRO1, FiscalNumberCheckStoprno))
      {
        Log.Message("Документ 'Акт про скасування помилкової суми розрахунків (сторно)' успішно створено", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
        Log.Error("Документ 'Акт про скасування помилкової суми розрахунків (сторно)' не створено");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      
      break;
      
      case "Операції - Касові документи - Акт скасування помилкової суми розрахунків (Видатковий чек)":
      
      //Створення чека та фіскалізація для 'Акт скасування помилкової суми розрахунків (Видатковий чек)'
      var newCheckCancelAkt = Handler.GetReceiptObject(PAYWITHOUTREMAIN, VENDORCODE, NAMEPRRO1);
      //Получаем грид открытой смены
      var gridOpenShiftn = new WorkOpenShiftGrid();
      var refundChekCancelAkt = new gridOpenShiftn.Refund();
      refundChekCancelAkt.ClickRefund();
      refundChekCancelAkt.setTextFiscalNumBox(newCheckCancelAkt.FiscalNumber);
      refundChekCancelAkt.SelectPrroNum(newCheckCancelAkt.CashRegisterFiscalNumber);
      //Нажать кнопку Перевірити
      refundChekCancelAkt.ClickSearchBtn();
      var newRefundCheckCancelAkt;
      //Нажали кнопку Продовжити повернення 
      if(refundChekCancelAkt.ContinueRefund())
      {
        //Получить объект зарегистрированного чека возврата
        newRefundCheckCancelAkt = refundChekCancelAkt.RefundCash();
      }
      else
      {
        Log.Error("Не отримано об'єкт Чек повернення");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      //Відрити модуль Касові документи
      var menu = new Handler.MainMenu();
      var cashDocuments = menu.OpenModules(OPERATION, CASHDOCUMENTS);
      //Створення Акт скасування помилкової суми розрахунків (Видатковий чек)
      var actCancelErrorAmountCalc = new ModulsHandlerOperations.CreateCashDocument();
      actCancelErrorAmountCalc.CreateCashDoc();
      actCancelErrorAmountCalc.CreateCancelWrongSumExpenseCheck();
      if(actCancelErrorAmountCalc.ActCancelErrorAmountCalculations(NAMEPRRO1, newRefundCheckCancelAkt.FiscalNumber))
      {
        Log.Message("Документ 'Акт про скасування помилкової суми розрахунків (видатковий чек)' успішно створено", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
        Log.Error("Документ 'Акт про скасування помилкової суми розрахунків (видатковий чек)' не створено");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      
      break;
    
      case "Операції - Історія операцій - Завантаження чеків з ФС ДПС":
      
      var menu = new Handler.MainMenu();
      var historyOperations = menu.OpenModules(OPERATION, HISTORYOPERATIONS);
      historyOperations.SelectGONameOperationsHistory(GONAME);
      historyOperations.SelectPrroNameOperationsHistory(NAMEPRRO1);
      historyOperations.SelectStartEndPeriod();
      historyOperations.SelectUserNameOperationsHistory(NAMEUSER);
      historyOperations.SelectTypePayOperationsHistory(TYPEPAY_ALL);
      historyOperations.SelectMethodPayOperationsHistory(METHODPAY);
      historyOperations.InsertNumberCheckOperationsHistory(NUMBERCHECK);
      historyOperations.SearchBtClick();
      //Завантаження чеків з ФС ДПС
      if(historyOperations.LoadingChecks(GONAME, NAMEPRRO1))
      {
        Log.Message("Завантаження чеків з ФС ДПС виконано успішно", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
        Log.Error("Завантаження чеків з ФС ДПС не виконано");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }
      
      break;
      
      case "Операції - Історія операцій - Відправлення даних":
      
      var menu = new Handler.MainMenu();
      var historyOperations = menu.OpenModules(OPERATION, HISTORYOPERATIONS);
      if(historyOperations.SendData())
      {
        Log.Message("Відправлення даних виконано успішно", "", pmNormal, Config.attrBlock);
        CurrentTestStepStatus = TestStatus.PASS;
        FinalTestStatusValue.Add(TestStatus.PASS);
      }
      else
      {
        Log.Error("Відправлення даних не виконано");
        CurrentTestStepStatus = TestStatus.FAIL;
        FinalTestStatusValue.Add(TestStatus.FAIL);
      }

      //Закриваємо зміну
      Cashalot.ShiftControlClose();
      
      break;
  }
}
















