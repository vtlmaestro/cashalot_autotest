//USEUNIT Config
//USEUNIT GridWorkOpenShift
//USEUNIT ModulsHandlerAllCash
//USEUNIT ModulsHandlerOperations
//USEUNIT ModulsHandlerReport
//USEUNIT Objects
//USEUNIT Parameters
//USEUNIT Types
//USEUNIT WinHandler

GridWorkOpenShift
//Class MainMenu
function UnexpectedHandler(CashalotObject)
{
  var object = CashalotObject;
  var handledObject;
  this.Type = object.GetType();
  switch(this.Type)
  {
    case Types.UC_CONFIRM_PWD:
      handledObject = new WinHandler.UCConfirmPwd(true);
    break;
    
    case Types.MESSAGE_BOX:
      handledObject = new Objects.MessageBox();
    break;
    
    case Types.UNDETECT:
      Log.Error("Не удалось обработать окно");
      Log.Picture(Sys.Desktop.Picture(), "Не удалось обработать окно");
    break;
    
    case Types.SUGGEST_TO_UPDATE:
    handledObject = new Objects.MessageBox(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCSuggestToUpdate);
  }
  
  this.Handle = function()
  {
  handledObject.BaseHandler()
  };
  
  return this;
}

function MainMenu()
{
  var mainMenuExpander;
  var expanderButton = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Image;
  
  this.Items = new List();
  
  function MenuItem()
  {
    this.MenuName;
    this.Key;
    this.SubMenuExists = false;
    this.ItemObject;
    this.SubMenuItems = new List();
    
    return this;
  }
  
  function GetModuleObject()
  {
    var mainWnd = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_;
    var periodicalReportPrepare = Aliases.CashaLot.HwndSource_WindowDialog3.WindowDialog.UCPeriodicalReportPrepare;
    var SoldsGoodsReport = Aliases.CashaLot.HwndSource_WindowDialog4.WindowDialog.UCReportGoodsPrepare;
    
    if(periodicalReportPrepare.Exists)
    {
      return new ModulsHandlerReport.PeriodicalReportsPrepareView();
    }
    else if(SoldsGoodsReport.Exists)
    {
      return new ModulsHandlerReport.AboutSoldGoods();
    }
    
    var type = new Objects.CashalotObject(mainWnd).GetType();

    switch(type)
    {
      case Types.UC_LIST_OF_SHOP:
        return new ModulsHandlerAllCash.UCListOfShop();
        
      case Types.UC_POSTPONED_RECEIPTS:
        return new ModulsHandlerOperations.UCPostponedReceipts();
        
      case Types.UC_CACHDOCUMENTS:
        return new ModulsHandlerOperations.CashDocuments();
        
      case Types.UC_RECEIPTHISTORY:
        return new ModulsHandlerOperations.OperationsHistory();
        
      case Types.UC_DAILYREPORTS:
        return new ModulsHandlerReport.DailyReports();
        
    }
    
  }
  
  expanderButton.Click();
  
  while(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.MainMenu1.Exists)
  {
    aqUtils.Delay(100);
  }
  
  mainMenuExpander = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.MainMenu1.treeView;
  
  //LoadItems
  for(var i=0; i<mainMenuExpander.Items.Count;i++)
  {
    var item = mainMenuExpander.Items.get_Item(i);
    
    var menuitem = new MenuItem();
    if(item.ClrClassName == "TreeViewItem")
    {
      menuitem.MenuName = item.Header.Children.get_Item(item.Header.Children.Count-1)
                          .Children.get_Item(1).Children.get_Item(0).Text.OleValue;
      menuitem.Key = item.Tag.OleValue;
            
      menuitem.ItemObject = item;
      if(item.Items.Count>0)
      {
        menuitem.SubMenuExists = true;
        for(var j=0; j<item.Items.Count;j++)
        {
          var subitem = item.Items.get_Item(j);
          var Submenuitem = new MenuItem();
          Submenuitem.MenuName = subitem.Header.Children.get_Item(subitem.Header.Children.Count-1).Text.OleValue;
          Submenuitem.Key = subitem.Tag.OleValue;
          menuitem.SubMenuItems.Add(Submenuitem);
        }
      }
      this.Items.Add(menuitem);
    }
  }
  
  expanderButton.Click();
  
  this.Show = function()
  {
  expanderButton.Click();
  }
  
  //перевірка відкриття всіх модулів програми
  this.CheckOpenModules = function()
  {
  var exp1 = "";
  var exp2 = "";
  var result = false;
  var dictionaryModuleName = new Objects.Dictionary();
    
  //Получение списка имен разделов и подразделов главного меню
  for(var m=0; m<this.Items.Count;m++)
  {
    for(var sm=0; sm<this.Items.GetValue(m).SubMenuItems.Count;sm++)
    {
      dictionaryModuleName.Add(this.Items.GetValue(m).SubMenuItems.GetValue(sm).MenuName, this.Items.GetValue(m).MenuName);
    }
  }
    //Формируем значения для exp1 и exp2
    for(var i=0; i<dictionaryModuleName.Count;i++)
    {
     for(var j=0; j<this.Items.Count;j++)
     {
      if(aqString.ToUpper(dictionaryModuleName.GetValues()[i]) == aqString.ToUpper(this.Items.GetValue(j).MenuName))
       {
        exp1=aqString.Format("|[%i]",j);
       }
        if(this.Items.GetValue(j).SubMenuExists && aqString.ToUpper(dictionaryModuleName.GetValues()[i])==aqString.ToUpper(this.Items.GetValue(j).MenuName))
           {
             var subMenuName = "";
               for(var k=0; k<this.Items.GetValue(j).SubMenuItems.Count; k++)
               {
                if(aqString.ToUpper(dictionaryModuleName.GetKeys()[i])==aqString.ToUpper(this.Items.GetValue(j).SubMenuItems.GetValue(k).MenuName))
                {
                 exp2=exp1+aqString.Format("|[%i]",k);
                 subMenuName = this.Items.GetValue(j).SubMenuItems.GetValue(k).MenuName;
                }
               }
                  //Проверяем, развернут ли раздел экспандера
                 if(!this.Items.GetValue(j).ItemObject.IsExpanded)
                 {
                  this.Show();
                  aqUtils.Delay(500);
                  //Развернуть основной раздел
                  mainMenuExpander.ClickItem(exp1);
                  //Открыть проверяемый раздел
                  aqUtils.Delay(500);
                  mainMenuExpander.ClickItem(exp2);
                  aqUtils.Delay(500);
                  if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Exists)
                  {
                    Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Button_OK.ClickButton();
                    continue;
                  }
                  else if(Aliases.CashaLot.HwndSource_WindowDialog3.WindowDialog.UCPeriodicalReportPrepare.Exists)
                  {
                    Aliases.CashaLot.HwndSource_WindowDialog3.WindowDialog.UCPeriodicalReportPrepare.Button.ClickButton();
                    continue;
                  }
                  else if(Aliases.CashaLot.HwndSource_WindowDialog4.WindowDialog.UCReportGoodsPrepare.Exists)
                  {
                    Aliases.CashaLot.HwndSource_WindowDialog4.WindowDialog.UCReportGoodsPrepare.Button.ClickButton();
                    continue;
                  }
                  if(aqString.Compare(subMenuName, Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtMainWindowHeader.WPFControlText, false) != 0)
                  {
                  Log.Error(aqString.Format("Помилка перевірки відкриття модуля "+"'%s'"+"!", subMenuName), "", pmNormal, Config.attrError);
                  result = false;
                  return result;
                  }
                  else
                  {
                  Log.Message(aqString.Format("Перевірка модуля "+"'%s'"+" виконана успішно!", subMenuName), "", pmNormal, Config.attrBlock);
                  result = true;
                  }
                 }
                  else
                  {
                  this.Show();
                  //Открыть проверяемый раздел
                  aqUtils.Delay(500);
                  mainMenuExpander.ClickItem(exp2);
                  aqUtils.Delay(500);
                  if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Exists)
                  {
                    Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Button_OK.ClickButton();
                    continue;
                  }
                  else if(Aliases.CashaLot.HwndSource_WindowDialog3.WindowDialog.UCPeriodicalReportPrepare.Exists)
                  {
                    Aliases.CashaLot.HwndSource_WindowDialog3.WindowDialog.UCPeriodicalReportPrepare.Button.ClickButton();
                    continue;
                  }
                  else if(Aliases.CashaLot.HwndSource_WindowDialog4.WindowDialog.UCReportGoodsPrepare.Exists)
                  {
                    Aliases.CashaLot.HwndSource_WindowDialog4.WindowDialog.UCReportGoodsPrepare.Button.ClickButton();
                    continue;
                  } 
                  if(aqString.Compare(subMenuName, Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtMainWindowHeader.WPFControlText, false) != 0)
                  {
                  Log.Error(aqString.Format("Помилка перевірки відкриття модуля "+"'%s'"+"!", subMenuName), "", pmNormal, Config.attrError);
                  result = false;
                  return result;
                  }
                  else
                  {
                  Log.Message(aqString.Format("Перевірка модуля "+"'%s'"+" виконана успішно!", subMenuName), "", pmNormal, Config.attrBlock);
                  result = true;
                  } 
                  }
              aqUtils.Delay(500);
              exp1 = "";
              exp2 = "";
              break;
           }
       }
    }
     this.Show();
     mainMenuExpander.ClickItem("|[0]");
     return result;
    }
    
  //открытие модуля (принимает имя главного раздела и дочернего)
  this.OpenModules = function(itemarrayparent, itemarraychild)
  {
    var exp = "";
    var foundedMenuItem = false;
    var menuitem = "";
        for(var j=0; j<this.Items.Count;j++)
        {
          if(aqString.ToUpper(itemarrayparent) == aqString.ToUpper(this.Items.GetValue(j).MenuName))
           {
            menuitem = this.Items.GetValue(j);
            exp+=aqString.Format("|[%i]",j);
            foundedMenuItem = true;
           } 
           if(menuitem.SubMenuExists)
           {
              for(var k=0; k<menuitem.SubMenuItems.Count; k++)
              {
               if(aqString.ToUpper(itemarraychild)==aqString.ToUpper(menuitem.SubMenuItems.GetValue(k).MenuName))
               {
                exp+=aqString.Format("|[%i]",k);
               }
              }
              //Проверяем, открыт ли экспандер
//            if(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.MainMenu1.treeView.Visible)
              //Проверяем, развернут ли раздел
              if(!this.Items.GetValue(j).ItemObject.IsExpanded)
              {
               this.Show();
               aqUtils.Delay(1000);
               mainMenuExpander.ClickItem(exp);
              }
              else
              {
              this.Show();
              aqUtils.Delay(1000);
              mainMenuExpander.ClickItem(exp);                
              }
               break;
           }
        }
    aqUtils.Delay(1700);    
    return GetModuleObject();
  }
    
  this.OpenListOfShop = function()
  {
    this.Show();
    mainMenuExpander.ClickItem("|[0]");
    return GetModuleObject();
  }
    
  //не рабочий
  this.Open = function(itemArray)
    {
    this.Show();
    var exp = "";
    var foundedMenuItem = false;
    var menuitem;
    for(var i=0;i<itemArray.length;i++)
    {
      if(!foundedMenuItem)
      {
        for(var j=0; j<this.Items.Count;j++)
        {
          if(aqString.ToUpper(itemArray[i]) == aqString.ToUpper(this.Items.GetValue(j).MenuName))
          {
            menuitem = this.Items.GetValue(j);
            exp+=aqString.Format("|[%i]",j);
            foundedMenuItem = true;
            continue;
          }
        }
      }
      else
      {
        if(menuitem.SubMenuExists)
        {
          for(var j=0; j<menuitem.SubMenuItems.Count; j++)
          {
            if(aqString.ToUpper(itemArray[i])==aqString.ToUpper(menuitem.SubMenuItems.GetValue(j).MenuName))
            {
              exp+=aqString.Format("|[%i]",j);
            }
          }
        }
      }
    }  
    mainMenuExpander.ClickItem(exp);
    return GetModuleObject();
  }
}

//Получить объект зарегистрированного чека, принимает тип оплаты, артикул и имя ПРРО
function GetReceiptObject(typePay, VendorCode, namePrro)
{
  var dataContextReceiptVM = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel;
  var receiptGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.ReceiptGrid;
  var PanelFiscalizedCheck = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized;
  
  //Обрати відкриту касу
  var menu = new Handler.MainMenu();
  var listOfShop = menu.OpenListOfShop();
  listOfShop.OpenByName(namePrro);
  
  var workGridShift = new GridWorkOpenShift.WorkOpenShiftGrid();
  workGridShift.CreateNewCheck(VendorCode);
  var crtPayment = new workGridShift.CreatePayment();
  switch(typePay)
   {
      case "Оплата без решти":
      if(crtPayment.makePaymentWithoutRemainder())
      {
        Log.Message("Чек 'Оплата без решти' створено успішно", "", pmNormal, Config.attrBlock);
      }
      else
      {
         Log.Error("Чек 'Оплата без решти' не створено");
      }
      break;
      
      case "Знижка":
      if(crtPayment.makeDiscount())
      {
        Log.Message("Чек 'Знижка' створено успішно", "", pmNormal, Config.attrBlock);
      }
      else
      {
         Log.Error("Чек 'Знижка' не створено");
      }
      break;
      
      case "Оплата готівкою":
      if(crtPayment.makePaymentCash())
      {
        Log.Message("Чек 'Оплата готівкою' створено успішно", "", pmNormal, Config.attrBlock);
      }
      else
      {
         Log.Error("Чек 'Оплата готівкою' не створено");
      }
      break;
      
      case "Оплата карткою":
      if(crtPayment.makePaymentCard())
      {
        Log.Message("Чек 'Оплата карткою' створено успішно", "", pmNormal, Config.attrBlock);
      }
      else
      {
         Log.Error("Чек 'Оплата карткою' не створено");
      }
      break;
      
      case "Комбінована оплата":
      if(crtPayment.makeCombinedPayment())
      {
        Log.Message("Чек 'Комбінована оплата' створено успішно", "", pmNormal, Config.attrBlock);
      }
      else
      {
         Log.Error("Чек 'Комбінована оплата' не створено");
      }
      break;
   }
   var newReceipt = new Objects.CheckObject(PanelFiscalizedCheck);
   return newReceipt;
}