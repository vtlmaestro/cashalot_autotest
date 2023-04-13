//USEUNIT Objects
//USEUNIT WinHandler

//Грид История операций
function OperationsHistory()
{
 var GridOperationsHistoryDockPanel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.zgrid;
 var StornoButton = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.zgrid.ItemsControl.Button;
 var MessageWindow = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow;
 
 //Натиснути на кнопку Створити сторно
 this.ClickStorno = function()
 {
   var StornoBtn = new Objects.Button(StornoButton);
   StornoBtn.ClickBtn();
 
 }
 
 //Натиснути на кнопку Далі та ввести пароль ключа
 this.CreateStorno = function()
 {
   if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.WaitWPFObject("CustomMessageBoxWindow", "*", 3000).Exists)
   {
   var MessageBoxContinue = new Objects.MessageBox(MessageWindow); 
   MessageBoxContinue.Ok();
   WinHandler.InsertPWD();
   while(Aliases.CashaLot.HwndSource_AnimatedWaitView.AnimatedWaitView.StackPanel.Exists)
   {
    if(!Aliases.CashaLot.HwndSource_AnimatedWaitView.AnimatedWaitView.StackPanel.Exists)
    {
     break;
    }
   aqUtils.Delay(700);
   }
   }
 }
 
 //Перевірити наявність створенного сторно
 this.IsExistCheckStorno = function()
 {
   //Забираем из грида Истории операций последний созданный чек и проверяем поле ReceiptName, содержит ли строку ЧЕК СТОРНУВАННЯ 
   var newCheckStorno = GridOperationsHistoryDockPanel.Items.get_Item(GridOperationsHistoryDockPanel.Items.Count-1);
   if(aqString.Compare(newCheckStorno.ReceiptName.OleValue, CHECKSTORNO, false) == 0)
   {
     return newCheckStorno.FiscalNumber;
   }
   else
   {
     Log.Error("Чек сторнування не створено");
   }
   
 }
 
}