﻿//USEUNIT AppControl
//USEUNIT Handler
//USEUNIT TestStatus
//USEUNIT Parameters

var Menu;

//Закриття зміни
function ShiftControlClose()
{
  var stackPanel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.StackPanel;
  var shiftActive = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtShiftActiveDoZvit;
  var closeShift = Aliases.CashaLot.HwndSource_PopupRoot3.PopupRoot.NonLogicalAdornerDecorator.Button;
  var yesBtn = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.CustomMessageBoxWindow.Button_Yes;
  var boderZzvit = Aliases.CashaLot.HwndSource_WindowDialog9.WindowDialog.Border;
  var docForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
  var officialGiving = Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction;
  var windowDialogSign = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCConfirmPwd.pwdTextControl;
  var textblockDocPrintZzvit = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint.TextblockZ;
  var textBlockMessage = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.TextBlock_Message;
  var buttonYes = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Button_Yes;
  var sendZzvit = Aliases.CashaLot.HwndSource_WindowDialog9;
  var GridWndPanel = NameMapping.Sys.CashaLot.HwndSource_mainWindow.mainWindow_.Grid.SecondWndPanel;
  //result = 0 - зміна не була відкрита на момент перевірки
  //result = 1 - зміна успішно закрита
  //result = -1 - помилка закриття зміни
  var result = 0;
  
  //перевірка, чи закрита зміна
  if(shiftActive.Visible && aqString.Compare(shiftActive.WPFControlText, OPENSHIFT, true) == 0)
  {
    shiftActive.Click();
    closeShift.Click();
    while(!Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.Exists)
    {
      aqUtils.Delay(500);
      Log.Message("Очикування вікна закриття зміни HwndSource_CustomMessageBoxWindow3");
    }
    if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.WaitWPFObject("CustomMessageBoxWindow", "Z-звіт (закриття зміни)", 500).Exists)
    {
      yesBtn.Click();
    }
    while(!officialGiving.Exists && !windowDialogSign.Exists && !sendZzvit.Exists)
    {
      aqUtils.Delay(500);
      Log.Message("Очикування вікна Службова видача, підпису або відправки з-звіта");
    }
    //Закрытие смены без остатка денег: онлайн
    if(windowDialogSign.Exists)
    {
      WinHandler.InsertPWD();
      while(!sendZzvit.Exists && !officialGiving.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна Службова видача або відправки з-звіта");
      }
      //Закрытие смены без остатка денег: онлайн
      if(sendZzvit.Exists)
      {
        boderZzvit.ButtonZ.Click();
        while(!docForPrint.Exists && !textBlockMessage.Exists)
        {
          aqUtils.Delay(500);
          Log.Message("Очикування вікна друкованної форми З-звіта або повідомлення Відсутній звязок з ФСКО");
        }
        //Если пропала связь с ФСКО после открытия смены, то обрабатываем окно TextBlock_Message (Відсутній звязок з ФСКО)
        if(textBlockMessage.Exists)
        {
          buttonYes.Click();
          while(!docForPrint.Exists)
          {
          aqUtils.Delay(500);
          Log.Message("Очикування вікна друкованної форми З-звіта");
          }
          if(docForPrint.Exists && aqString.Compare(textblockDocPrintZzvit.Text.OleValue, ZZVITDOCPRINT, true) == 0)
          {
          docForPrint.btnReady.Click();
          Log.Message("Виконано закриття зміни в офлайн режимі без Службової видачи");
          result = 1;
          return result;
          }
        }
        
        //Если закрываем в онлайн-режиме
        if(docForPrint.Exists && aqString.Compare(textblockDocPrintZzvit.Text.OleValue, ZZVITDOCPRINT, true) == 0)
        {
        docForPrint.btnReady.Click();
        Log.Message("Виконано закриття зміни в онлайн режимі без Службової видачи");
        result = 1;
        return result;
        }
      }

    }
    
    //Закрытие смены с остатком денег: оффлайн (смена была открыта в оффлайн)
    if(officialGiving.Exists && GridWndPanel.DataContext.IsOffline)
    {
      officialGiving.btnOk.Click();
      while(!windowDialogSign.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна підпису");
      }
      if(windowDialogSign.Exists)
      {
       WinHandler.InsertPWD();
      }
      while(!docForPrint.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна друкованної форми Службової видачи");
      }
      if(docForPrint.Exists)
      {
        docForPrint.btnReady.Click();
      }
      while(!sendZzvit.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна відправки З-звіта");
      }
      if(sendZzvit.Exists)
      {
        boderZzvit.ButtonZ.Click();
      }
      while(!windowDialogSign.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна підпису");
      }
      if(windowDialogSign.Exists)
      {
       WinHandler.InsertPWD();
      }
      while(!docForPrint.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна друкованної форми З-звіта");
      }
      if(docForPrint.Exists && aqString.Compare(textblockDocPrintZzvit.Text.OleValue, ZZVITDOCPRINT, true) == 0)
      {
       docForPrint.btnReady.Click();
       Log.Message("Виконано закриття зміни в офлайн режимі з формуванням Службової видачи");
       result = 1;
       return result;
      }
    }
    
    //Закрытие смены c остатком денег: онлайн
    if(officialGiving.Exists && GridWndPanel.DataContext.IsOffline == false)
    {
      officialGiving.btnOk.Click();
      while(!windowDialogSign.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна підпису");
      }
      if(windowDialogSign.Exists)
      {
       WinHandler.InsertPWD();
      }
      while(!docForPrint.Exists && !textBlockMessage.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна друкованної форми Службової видачи або повідомлення Відсутній звязок з ФСКО");
      }
      //Если пропала связь с ФСКО после открытия смены, то обрабатываем окно TextBlock_Message (Відсутній звязок з ФСКО)
      if(textBlockMessage.Exists)
      {
        buttonYes.Click();
        while(!docForPrint.Exists)
        {
          aqUtils.Delay(500);
          Log.Message("Очикування вікна друкованної форми Службової видачи");
        }
        if(docForPrint.Exists)
        {
          docForPrint.btnReady.Click(); 
        }
        while(!sendZzvit.Exists)
        {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна відправки З-звіта");
        }
        if(sendZzvit.Exists)
        {
        boderZzvit.ButtonZ.Click();
        }
        while(!windowDialogSign.Exists)
        {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна підпису");
        }
        if(windowDialogSign.Exists)
        {
        WinHandler.InsertPWD();
        }
        while(!docForPrint.Exists)
        {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна друкованної форми З-звіта");
        }
        if(docForPrint.Exists && aqString.Compare(textblockDocPrintZzvit.Text.OleValue, ZZVITDOCPRINT, true) == 0)
        {
        docForPrint.btnReady.Click();
        Log.Message("Виконано закриття зміни в офлайн режимі з формуванням Службової видачи");
        result = 1;
        return result;
        }
      }
      //Если смена закрывается в онлайн-режиме
      if(docForPrint.Exists)
      {
        docForPrint.btnReady.Click(); 
        while(!windowDialogSign.Exists)
        {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна підпису");
        }
        if(windowDialogSign.Exists)
        {
        WinHandler.InsertPWD();
        }
        while(!sendZzvit.Exists)
        {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна відправки З-звіта");
        }
        if(sendZzvit.Exists)
        {
        boderZzvit.ButtonZ.Click();
        }
        while(!docForPrint.Exists)
        {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна друкованної форми З-звіта");
        }
        if(docForPrint.Exists && aqString.Compare(textblockDocPrintZzvit.Text.OleValue, ZZVITDOCPRINT, true) == 0)
        {
        docForPrint.btnReady.Click();
        Log.Message("Виконано закриття зміни в онлайн режимі з формуванням Службової видачи");
        result = 1;
        return result;
        }
      }
    }
    
    //Закрытие смены без остатка денег: оффлайн (смена была открыта в оффлайн)
    if(sendZzvit.Exists && GridWndPanel.DataContext.IsOffline)
    {
      boderZzvit.ButtonZ.Click();
      while(!windowDialogSign.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна підпису");
      }
      if(windowDialogSign.Exists)
      {
       WinHandler.InsertPWD();
      }
      while(!docForPrint.Exists)
      {
        aqUtils.Delay(500);
        Log.Message("Очикування вікна друкованної форми З-звіта");
      }
      if(docForPrint.Exists && aqString.Compare(textblockDocPrintZzvit.Text.OleValue, ZZVITDOCPRINT, true) == 0)
      {
        docForPrint.btnReady.Click();
        Log.Message("Виконано закриття зміни в офлайн режимі без Службової видачи");
        result = 1;
        return result;
      }
    }
  }
}


////Закриття зміни, якщо вона відкрита (старий)
//function ShiftControlClose()
//{
//  var stackPanel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.StackPanel;
//  var shiftActive = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtShiftActiveDoZvit;
//  var closeShift = Aliases.CashaLot.HwndSource_PopupRoot3.PopupRoot.NonLogicalAdornerDecorator.Button;
//  var yesBtn = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.CustomMessageBoxWindow.Button_Yes;
//  var boderZzvit = Aliases.CashaLot.HwndSource_WindowDialog9.WindowDialog.Border;
//  var docForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
//  var officialGiving = Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction;
//  var documForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
//  var windowDialogSign = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCConfirmPwd.pwdTextControl;
//  //result = 0 - зміна не була відкрита
//  //result = 1 - зміна успішно закрита
//  //result = -1 - помилка закриття зміни
//  var result = 0;
//  
//  if(shiftActive.Visible && aqString.Compare(shiftActive.WPFControlText, OPENSHIFT, true) == 0)
//  {
//    shiftActive.Click();
//    closeShift.Click();
//    if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.WaitWPFObject("CustomMessageBoxWindow", "Z-звіт (закриття зміни)", 5000).Exists)
//    {
//      yesBtn.Click();
//      if(windowDialogSign.Exists)
//      {
//      WinHandler.InsertPWD();
//      }
//       if(Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction.Exists) 
//       {
//        if(Aliases.CashaLot.HwndSource_WindowDialog8.WaitWPFObject("WindowDialog", "Службова видача", 5000).Exists)
//        {
//          officialGiving.btnOk.Click();
//          aqUtils.Delay(5000);
//          if(Aliases.CashaLot.WaitWPFObject("HwndSource: WindowDialog", "*", 7000).Exists)
//          {
//            if(Aliases.CashaLot.HwndSource_WindowDialog.WaitWPFObject("WindowDialog", "*", 7000).Exists)
//            {
//             if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.WaitWPFObject("Border", "*", 7000).Exists)
//             {
//               if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.WaitWPFObject("Grid", "*", 7000).Exists)
//               {
//                if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Grid.DialogPresenter.WaitWPFObject("UCDocumentForPrint", "*", 7000).Exists)
//                {
//                documForPrint.btnReady.Click();
//                if(windowDialogSign.Exists)
//                {
//                WinHandler.InsertPWD();
//                }
//                result = 1;
//                }
//                else 
//                {
//                  result = -1;
//                }
//               }
//              }
//            }
//          }
//        }
//      } 
//    }
//    if(Aliases.CashaLot.HwndSource_WindowDialog9.WaitWPFObject("WindowDialog", "Z-звіт", 7000).Exists)
//    {
//    boderZzvit.ButtonZ.Click();
//    aqUtils.Delay(5000);
//     if(Aliases.CashaLot.WaitWPFObject("HwndSource: WindowDialog", "*", 7000).Exists)
//     {
//       if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Grid.DialogPresenter.WaitWPFObject("UCDocumentForPrint", "*", 7000).Exists)
//       {
//        docForPrint.btnReady.Click();
//        result = 1;
//       }
//       else 
//       {
//       result = -1;
//       }
//     }
//    }
//    return result;
//  }  
//  return result;
//}


//Работа с кассой
function Shifts()
{
  return new ModulsHandlerAllCash.AllRRO();
}

function OpenShiftByName(shiftName)
{
  MenuOpen(["Всі каси"]);
  var shifts = new ModulsHandlerAllCash.AllRRO();
  if(shifts.OpenByName(shiftName))
  {
    var openShiftWnd = new WinHandler.UCOpenNewShift();
    openShiftWnd.EnterSum("1000");
    openShiftWnd.Open();
  }
}

//Авторизация, возвращает DialogResult
function Login(username, password, save_password)
{
  var loginForm = new LoginForm();
  save_password = (!Objects.IsNullOrUndefined(save_password))?save_password:false;
  loginForm.SavePassword(save_password);
  loginForm.SelectUser(username);
  loginForm.EnterPassword(password);
  var result = loginForm.Enter();
//  if(result.Result){
//    Menu = new MainMenu();
//    }
  return result;
}

//работа с меню
function MenuOpen(array)
{
  Menu.Open(array);
}