//USEUNIT Parameters
//USEUNIT WinHandler

//Грид открытой смены
function WorkOpenShiftGrid()
{
var dataContextReceiptVMWorkShiftGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel;
var DockPanelReceiptGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.ReceiptGrid;
var UCGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_;
//var CrtNewCheckBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.btnNewReceipt.CrtReceiptBtnDefault;
var CrtNewCheckBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.UC_.CrtReceiptBtnDefault;
var AsideCheckBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.btnStallReceipt;
var CancelCheckBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.btnCancelReceipt;
var PanelFiscalizedCheck = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized;
//Повернення
var RefundBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.btnReturnReceipt;
var SearchProduct = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.txbEnterGoods;
var ConfirmPostponedReceiptBtn = Aliases.CashaLot.HwndSource_WindowDialog5.WindowDialog.Border.UCConfirmPostponedReceipt.Button;
var dialogResult = new DialogResult();

this.NewCheckLocalNumber;
this.NewCheckOrderNum;


 //Создать чек
 this.CreateNewCheck = function(nameproduct)
  {
  while(!CrtNewCheckBtn.Exists)
  {
    aqUtils.Delay(1000);
    Log.Message("Очикування кнопки створення чека");
  }
  CrtNewCheckBtn.Click();
  SearchProduct.Keys(nameproduct);
  SearchProduct.Keys(ENTER);
  this.NewCheckLocalNumber = DockPanelReceiptGrid.DataContext.ReceiptVM.LocalNumber;
  this.NewCheckOrderNum = DockPanelReceiptGrid.DataContext.ReceiptVM.Model.Ordernum;
  var newReceipt = new Objects.Receipt(dataContextReceiptVMWorkShiftGrid, DockPanelReceiptGrid);
  return newReceipt;
  }
 //Отложить чек
 this.AsideCheck = function()
  {
  var asideBtn = new Button(AsideCheckBtn);
  asideBtn.ClickBtn();
  ConfirmPostponedReceiptBtn.Click();
  }
  
  this.RegisterCheckDPS = function()
  {
    var RegisterCheckDPSBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Button3;
    RegisterCheckDPSBtn.Click();
    aqUtils.Delay(1500);
  }
  
  //Сделать оплату
 this.CreatePayment = function()
 {
  //Оплата без решти
  var PaymentWithoutRemainder = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptOperationsStart.Button;
  //Знижка
  var Discount = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptOperationsStart.Button2;
  //Оплата готівкою
  var PaymentCash = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptOperationsStart.Button3;
  //Оплата карткою
  var PaymentCard = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.Button99;
  //Комбінована оплата 
  var CombinedPayment = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.Button2;
  //Провести оплату
  var MakePayButton = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.PayButton;
  //Зареєструвати чек в ДПС
  var RegisterCheckDPSBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Button3;
  //Вікно результу фіскалізації
  var ReceiptFiscalized = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized;

  //Оплата без решти та реєстрація чека
  this.makePaymentWithoutRemainder = function()
  {
    var leftCheckPanel =  Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Pages.WaitWPFObject("UCReceiptOperationsStart", "*", 3000)
    if(leftCheckPanel.Exists)
    {
    PaymentWithoutRemainder.Click();
    }
    while(!RegisterCheckDPSBtn.Exists)
    {
      aqUtils.Delay(500);
      Log.Message("Очикування кнопки 'Зареєструвати чек в ДПС'");
    }
    RegisterCheckDPSBtn.Click();
    WinHandler.InsertPWD();
    //Проверка наличия зарегистрированного чека
//    while(!ReceiptFiscalized.Exists && !aqString.Compare(ReceiptFiscalized.Textblock.Text.OleValue, SUCCESSREGISTERED, true) == 0)
//    {
//    aqUtils.Delay(500);
//    Log.Message("Очикування вікна з текстом Успішно зареєстровано");
//    }
    aqUtils.Delay(5000);
    var ReceiptFiscalizedPanel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized.WaitWPFObject("Grid", "*", 3000);
    if(ReceiptFiscalizedPanel.Exists && aqString.Compare(ReceiptFiscalized.DataContext.ReceiptVM.Status.OleValue, STATUSCHECK, true)==0)
    {
      return true;
    }
    else
     {
      if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Exists)
      {
      var msgBox = new MessageBox(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow);
      Log.Message(msgBox.Text);
      }
      return false;
     }
  }
  //Знижка
  this.makeDiscount = function()
  {
    if(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Pages.WaitWPFObject("UCReceiptOperationsStart", "*", 3000).Exists)
    {
    Discount.Click();
    }
    MakePayButton.Click();
    RegisterCheckDPSBtn.Click();
    WinHandler.InsertPWD();
    while(!ReceiptFiscalized.Exists && !aqString.Compare(ReceiptFiscalized.Textblock.Text.OleValue, SUCCESSREGISTERED, true) == 0)
    {
    aqUtils.Delay(500);
    }
    if(ReceiptFiscalized.Exists && aqString.Compare(ReceiptFiscalized.DataContext.ReceiptVM.StatusName.OleValue, REGISTERED, true) == 0)
    {
      return true;
    }
    else
     {
      return false;
     }
  }
  //Оплата готівкою
  this.makePaymentCash = function()
  {
    if(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Pages.WaitWPFObject("UCReceiptOperationsStart", "*", 3000).Exists)
    {
    PaymentCash.Click();
    }
    MakePayButton.Click();
    RegisterCheckDPSBtn.Click();
    WinHandler.InsertPWD();
    while(!ReceiptFiscalized.Exists && !aqString.Compare(ReceiptFiscalized.Textblock.Text.OleValue, SUCCESSREGISTERED, true) == 0)
    {
    aqUtils.Delay(500);
    }
    if(ReceiptFiscalized.Exists && aqString.Compare(ReceiptFiscalized.DataContext.ReceiptVM.StatusName.OleValue, REGISTERED, true) == 0)
    {
      return true;
      Log.Message("Чек успішно зареєстровано");
    }
    else
     {
      return false;
     }
  }
  //Оплата карткою
  this.makePaymentCard = function()
  {
    if(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Pages.WaitWPFObject("UCReceiptOperationsStart", "*", 3000).Exists)
    {
    PaymentCard.Click();
    }
    MakePayButton.Click();
    RegisterCheckDPSBtn.Click();
    WinHandler.InsertPWD();
    while(!ReceiptFiscalized.Exists && !aqString.Compare(ReceiptFiscalized.Textblock.Text.OleValue, SUCCESSREGISTERED, true) == 0)
    {
    aqUtils.Delay(500);
    }
    if(ReceiptFiscalized.Exists && aqString.Compare(ReceiptFiscalized.DataContext.ReceiptVM.StatusName.OleValue, REGISTERED, true) == 0)
    {
      return true;
      Log.Message("Чек успішно зареєстровано");
    }
    else
     {
      return false;
     }
  }
  //Комбінована оплата 
  this.makeCombinedPayment = function()
  {
    if(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Pages.WaitWPFObject("UCReceiptOperationsStart", "*", 3000).Exists)
    {
    CombinedPayment.Click();
    }
    MakePayButton.Click();
    RegisterCheckDPSBtn.Click();
    WinHandler.InsertPWD();
    while(!ReceiptFiscalized.Exists && !aqString.Compare(ReceiptFiscalized.Textblock.Text.OleValue, SUCCESSREGISTERED, true) == 0)
    {
//      if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Exists)
//      {
//      var msgBox = new MessageBox(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow);
//      if(aqString.Compare(dialogResult.Message, NOCONNECTIONWITHFSKO, true)==0)
//      {
//       msgBox.Ok();
//       Log.Message("Перехід в режим офлайн під час реєстрації чека");
//      }
//      }
    aqUtils.Delay(500);
    }
    if(ReceiptFiscalized.Exists && aqString.Compare(ReceiptFiscalized.DataContext.ReceiptVM.StatusName.OleValue, REGISTERED, true) == 0)
    {
      return true;
      Log.Message("Чек успішно зареєстровано");
    }
    else
     {
      return false;
     }
  }
 }  
 
 //Повернення коштів
 this.Refund = function()
 {
   var SelectPrroNumCmb = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.ComboBox;
   var FiscalNumTextBox = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.FiscalNumberTextbox;
   //Button Повернення готівкою
   var RefundCashBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Button4;
   //Button Повернення безготівкове
   var CashlessReturnBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Button5
   //Button Повернення комбіноване
   var CombinedReturnBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Button6;
   //Кнопка Повернення
   var ClickRefundBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.btnReturnReceipt
   
   //Нажать кнопку Повернення 
   this.ClickRefund = function()
   {
     if(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.WaitWPFObject("Grid", "*", 5000).Exists)
     {
     ClickRefundBtn.Click();
     }
     else
     {
       Log.Message("'btnReturnReceipt' не знайдено")
     }
   }
   
   this.setTextFiscalNumBox = function(checkFiscalNumber)
   {
     FiscalNumTextBox.set_Text(checkFiscalNumber);
   }
   
   this.SelectPrroNum = function(prroFiscalNumber)
   {
     for(i=0; i<SelectPrroNumCmb.wItemCount; i++)
      {
        if(aqString.Compare(SelectPrroNumCmb.Items.get_Item(i).OleValue, prroFiscalNumber, true) == 0)
        {
          SelectPrroNumCmb.SelectItemWithValue(SelectPrroNumCmb.Items.get_Item(i), true)
          break;
        }
      }
   }
   
   //Нажать кнопку Перевірити
   this.ClickSearchBtn = function()
   {
     var SearchBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.leftSideDockPanel.SearchButton;
     SearchBtn.Click();
   }
   
   //Кнопка Продовжити повернення  
   this.ContinueRefund = function()
   {
     var ScrollViewerWPFControlText = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Scrollviewer.WPFControlText;
     var OkBtn = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Button_OK;
     if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.WaitWPFObject("CustomMessageBoxWindow", "*", 3000).Exists && aqString.Find(ScrollViewerWPFControlText, CHECKSUCCESS, 0, true)==0)
     {
       OkBtn.Click();
       return true;
     }
     else
     {
       Log.Message("Не знайдено зареєстрований чек за вказаним фіскальним номером");
       return false;
     }
     
   }
   
   //Повернення готівкою
   this.RefundCash = function()
   {
     var PanelFiscalCheck = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized;
     
     RefundCashBtn.Click();
     Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.Button3.WaitProperty("Exists", true, 3000);
     var gridOpenShift = new WorkOpenShiftGrid();
     gridOpenShift.RegisterCheckDPS();
     WinHandler.InsertPWD();
     while(!PanelFiscalCheck.Exists)
     {
     aqUtils.Delay(500);
     Log.Message("Очикування вікна результату реєстрації чека: PanelFiscalCheck");
     }
     aqUtils.Delay(5000);
     if(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized.WaitWPFObject("Grid", "*", 4000).Exists && aqString.Compare(PanelFiscalCheck.DataContext.ReceiptVM.Status.OleValue, STATUSCHECK, true)==0)
     {
       var refundNewCheck = new Objects.CheckObject(PanelFiscalizedCheck);
       if(PanelFiscalizedCheck.DataContext.ReceiptVM.FiscalNumber.OleValue != null || PanelFiscalizedCheck.DataContext.ReceiptVM.FiscalNumber.OleValue != undefined)
       {
       Log.Message("Фіскальний номер зареєстрованого чека отримано успішно");
       return refundNewCheck;
       }
       else
       {
        Log.Error("Фіскальний номер зареєстрованого чека не отримано"); 
       }
     }
     else
       {
        Log.Error("Фіскальний номер зареєстрованого чека не отримано"); 
       }
   }
   
   //Повернення безготівкове
   this.CashlessReturn = function()
   {
     var PanelFiscalCheck = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized;
     
     CashlessReturnBtn.Click();
     WinHandler.InsertPWD();
     aqUtils.Delay(1500);
     var gridOpenShift = new WorkOpenShiftGrid();
     gridOpenShift.RegisterCheckDPS();
     WinHandler.InsertPWD();
     if(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized.WaitWPFObject("Grid", "*", 4000).Exists && aqString.Compare(PanelFiscalCheck.DataContext.ReceiptVM.Status.OleValue, STATUSCHECK, true)==0)
     {
       var refundNewCheck = new Objects.CheckObject(PanelFiscalizedCheck);
       if(PanelFiscalizedCheck.DataContext.ReceiptVM.FiscalNumber.OleValue != null || PanelFiscalizedCheck.DataContext.ReceiptVM.FiscalNumber.OleValue != undefined)
       {
       Log.Message("Фіскальний номер зареєстрованого чека отримано успішно");
       return refundNewCheck;
       }
       else
       {
        Log.Error("Фіскальний номер зареєстрованого чека не отримано"); 
       }
     }
   }
   
   //Повернення комбіноване
   this.CombinedReturn = function()
   {
     var PanelFiscalCheck = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized;
     
     CombinedReturnBtn.Click();
     WinHandler.InsertPWD();
     aqUtils.Delay(1500);
     var gridOpenShift = new WorkOpenShiftGrid();
     gridOpenShift.RegisterCheckDPS();
     WinHandler.InsertPWD();
     if(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.UC_.UCReceiptFiscalized.WaitWPFObject("Grid", "*", 4000).Exists && aqString.Compare(PanelFiscalCheck.DataContext.ReceiptVM.Status.OleValue, STATUSCHECK, true)==0)
     {
       var refundNewCheck = new Objects.CheckObject(PanelFiscalizedCheck);
       if(PanelFiscalizedCheck.DataContext.ReceiptVM.FiscalNumber.OleValue != null || PanelFiscalizedCheck.DataContext.ReceiptVM.FiscalNumber.OleValue != undefined)
       {
       Log.Message("Фіскальний номер зареєстрованого чека отримано успішно");
       return refundNewCheck;
       }
       else
       {
        Log.Error("Фіскальний номер зареєстрованого чека не отримано"); 
       }
     }
   }
 }
}












