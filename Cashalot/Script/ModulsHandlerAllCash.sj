﻿//USEUNIT Objects
//USEUNIT CONST
//USEUNIT UtilsCashalot
//USEUNIT WinHandler
//USEUNIT Config


//Модуль Все кассы
function UCListOfShop()
{
  this.ModuleName = "Всі каси";  
  this.ModuleType = Types.UC_LIST_OF_SHOP;
  
  while(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Exists)
    aqUtils.Delay(100);
  
  var RRO_Obj = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList;
  var shifts = new List();
  var RROGroup = RRO_Obj.GroupItem;
  var GOComboBox = new Objects.ComboBox(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.SelectGO);
  
  for(var i=0; i<RROGroup.ChildCount; i++)
    shifts.Add(new Objects.Shift(RROGroup.Child(i)));
    
  
  this.ToolBar = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border2;
  
  this.Update = function()
  {
    RRO_Obj = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList;
    shifts = new List();
    RROGroup = RRO_Obj.GroupItem;
  
    for(var i=0; i<RROGroup.ChildCount; i++)
      shifts.Add(new Objects.Shift(RROGroup.Child(i)));
  }
  
  //Обрати Господарську одиницю
  this.SelectNameGO = function(nameGo)
  {
    for(i=0; i<GOComboBox.Obj.wItemCount; i++)
      { 
      if(aqString.Compare(GOComboBox.Obj.Items.get_Item(i).OleValue, nameGo, true) == 0)
        {
          GOComboBox.Obj.SelectItemWithValue(GOComboBox.Obj.Items.get_Item(i), true);
          this.Update();
          return this;
        }
      }
  }
  
//  //Відкрити касу без превірки offline
//  this.OpenByName = function(name)
//  {
//    var count = 0;
//    var OpenShiftWindow = Aliases.CashaLot.HwndSource_WindowDialog2.WindowDialog.Border.UCOpenNewShift;
//    var ConfirmPWDWindow = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCConfirmPwd;
//    var resultOpenShift = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtShiftActiveDoZvit;
//    var messageBoxWindow = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow;
//    var buttonYes = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Button_Yes;
//    
//    for(var i=0; i<shifts.Count; i++)
//    {
//      if(aqString.ToUpper(shifts.GetValue(i).Name)==aqString.ToUpper(name))
//      {
//        shifts.GetValue(i).Open();
//        if(OpenShiftWindow.Exists)
//          {
//          OpenShiftWindow.btnOk.Click();
//////          if(ConfirmPWDWindow.WaitWinFormsObject("UCOpenNewShift", "*", 7, 1000).Exists)
//          if(ConfirmPWDWindow.Exists)
//           {
//           var confirmPwd = new WinHandler.UCConfirmPwd(true);
//           confirmPwd.EnterPassword(Parameters.USERCERTPASSWORD);
//           confirmPwd.Ok();
//           while(count != 30)
//           {
//             if(!resultOpenShift.Exists)
//             {
//             aqUtils.Delay(1000);
//             count++;
//             }
//             else
//             {
//               break;
//             }
//           }
//           if(aqString.Compare(resultOpenShift.WPFControlText, CONST.OpenShift, true) == 0)
//             {
//              return true;
//             }
//           }
//          }
//        else
//          return false;
//      }
//    }
//  }
//  return this;
//}

  //Відкрити касу з перевіркою offLine
  this.OpenByName = function(name)
  {
    var count = 0;
    var OpenShiftWindow = Aliases.CashaLot.HwndSource_WindowDialog2.WindowDialog.Border.UCOpenNewShift;
    var ConfirmPWDWindow = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCConfirmPwd.pwdTextControl;
    var resultOpenShift = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtShiftActiveDoZvit;
    var buttonYes = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Button_Yes;
    var textBlockMessage = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.TextBlock_Message;
    var messageOfflineMode = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.edTextMessageOfflineMode;
    
    for(var i=0; i<shifts.Count; i++)
    {
      if(aqString.ToUpper(shifts.GetValue(i).Name)==aqString.ToUpper(name))
      {
        shifts.GetValue(i).Open();
        if(OpenShiftWindow.btnOk.Exists)
        {
          OpenShiftWindow.btnOk.Click();
          while(!ConfirmPWDWindow.Exists && !textBlockMessage.Exists)
          {
           aqUtils.Delay(1000);
          }
          if(ConfirmPWDWindow.Exists)
          {
           WinHandler.InsertPWD();
          }
//          while(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Exists)
          while(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.UC_.Exists)
          {
            aqUtils.Delay(1000);
            if(textBlockMessage.Exists)
            {
              buttonYes.Click();
            }
          }           
//           while(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Exists)
//           {
//             aqUtils.Delay(1000);
//           }  
           if(messageOfflineMode.Exists && aqString.Compare(messageOfflineMode.Text.OleValue, Parameters.ALARMNONCONNECTFSKO, true)==0)
           {
             Log.Message("Увага. Відсутній зв'язок з ФСКО. Під час відкриття зміни програму переведено в режим «офлайн».", "", pmNormal, Config.attrBlock);
           }
           if(aqString.Compare(resultOpenShift.WPFControlText, CONST.OpenShift, true) == 0)
             {
              return true;
             }
          }
           else
           return false;
      }
    }
  return this;
  }
}











