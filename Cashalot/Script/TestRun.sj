//USEUNIT WinHandler
//USEUNIT Objects
//USEUNIT GetObject
//USEUNIT Parameters
//USEUNIT ModulsHandlerDirectory

function Test2()
{
var calc;
calc = Sys.Process("Calculator");
calc.Window("SciCalc", "Calculator Plus").MainMenu.Click("Help|About Calculator Plus");
if( !calc.WaitWindow("#32770", "About Calculator Plus", -1,10000).Exists)
{
 Log.Error("Окно About не открылось!");
}
else
{
 calc.Window("#32770", "About Calculator Plus").Close();
}
}
//создание объекта через new Object()
function Test3(){

var myCar = new Object();
myCar.make = "Ford";
myCar.model = "Mustang";
myCar.year = 1969;

function showProps(obj, objName) {
  var result = "";
  for (var i in obj) {
    if (obj.hasOwnProperty(i)) {
    result += objName + "." + i + " = " + obj[i] + "; ";
    }
  }
  return result;
}
Log.Message(showProps(myCar, "myCar"));
}

//создание объекта через function() и new
function Test4(){

function Car(make, model, year) {
  this.make = make;
  this.model = model;
  this.year = year;
}

function showProps(obj, objName) {
  var result = "";
  for (var i in obj) {
    if (obj.hasOwnProperty(i)) {
    result += objName + "." + i + " = " + obj[i] + "; ";
    }
  }
  return result;
}

var mycar = new Car("Eagle", "Talon TSi", 1993);
Log.Message(showProps(mycar, "myCar"));
}

function showProps(obj, objName) {
  var result = "";
  for (var i in obj) {
    if (obj.hasOwnProperty(i)) {
    result += objName + "." + i + " = " + obj[i] + "; ";
    }
  }
  return result;
}

function Test6(){
//Creates a new object, myobj, with two properties, a and b.
var myobj = new Object;
myobj.a = 5;
myobj.b = 12;

//Removes the a property, leaving myobj with only the b property.
delete myobj.a;
Log.Message(showProps(myobj, "myobj"));

}

function Test1()
{
  var createDoc = new WinHandler.CreateCashDocument()
  {
    createDoc.CreateCashDoc();
   Log.Message("Результат: "+createDoc.CreateOfficialGiving());
  }
}

function Test88()
{
  Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtShiftActiveDoZvit.Click();
  Aliases.CashaLot.HwndSource_PopupRoot3.PopupRoot.NonLogicalAdornerDecorator.Button.Click();
  Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.WaitWPFObject("CustomMessageBoxWindow", "Z-звіт (закриття зміни)", 3);
  Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.CustomMessageBoxWindow.Button_Yes.Click();
  Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.WaitWPFObject("Grid", "*", 3);
  
  
}

function SendDataTest()
{
    var SendDataButton =  Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.Button2;
    var MessBox = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Textblock;
    var OkButton = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Button;
    
    //Нажать на кнопку Відправити дані
    SendDataButton.Click();
    WinHandler.InsertPWD();
    if(Aliases.CashaLot.HwndSource_WindowDialog.WaitWPFObject("WindowDialog", "*", 7).Exists && aqString.Compare(MessBox.Text.OleValue, SYNCSUCCESS, true)==0)
    {
      OkButton.Click();
      return true;
    }
    else
    {
      return false;
    }
}


function ShiftControlCloseTest()
{
  var stackPanel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.StackPanel;
  var shiftActive = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtShiftActiveDoZvit;
  var closeShift = Aliases.CashaLot.HwndSource_PopupRoot3.PopupRoot.NonLogicalAdornerDecorator.Button;
  var yesBtn = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.CustomMessageBoxWindow.Button_Yes;
  var boderZzvit = Aliases.CashaLot.HwndSource_WindowDialog9.WindowDialog.Border;
  var docForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
  var officialGiving = Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction;
  var documForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
  
  if(shiftActive.Visible && aqString.Compare(shiftActive.WPFControlText, OPENSHIFT, true) == 0)
  {
    shiftActive.Click();
    closeShift.Click();
    if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.WaitWPFObject("CustomMessageBoxWindow", "Z-звіт (закриття зміни)", 5).Exists)
    {
      yesBtn.Click();
      
      if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.WaitWPFObject("Grid", "*", 5).Exists)
      {
        var confirmPwd = new WinHandler.UCConfirmPwd();
        confirmPwd.EnterPassword(USERCERTPASSWORD);
        confirmPwd.Ok();
        
       if(Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction.Exists) 
       {
        if(Aliases.CashaLot.HwndSource_WindowDialog8.WaitWPFObject("WindowDialog", "Службова видача", 3).Exists)
        {
          officialGiving.btnOk.Click();
          aqUtils.Delay(1500);
          
          if(Aliases.CashaLot.HwndSource_WindowDialog.WaitWPFObject("WindowDialog", "*", 3).Exists)
          {
            documForPrint.btnReady.Click();
            aqUtils.Delay(1500);
            confirmPwd.EnterPassword(USERCERTPASSWORD);
            confirmPwd.Ok();
          }
        }
       }
       if(Aliases.CashaLot.HwndSource_WindowDialog9.WaitWPFObject("WindowDialog", "Z-звіт", 5).Exists)
       {
         boderZzvit.ButtonZ.Click();
          if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.WaitWPFObject("Grid", "*", 5).Exists)
          {
            docForPrint.btnReady.Click();
          }
       }
      }
    }
  }
}


//Закриття зміни, якщо вона відкрита
function ShiftControlCloseTest3()
{
  var stackPanel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.StackPanel;
  var shiftActive = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtShiftActiveDoZvit;
  var closeShift = Aliases.CashaLot.HwndSource_PopupRoot3.PopupRoot.NonLogicalAdornerDecorator.Button;
  var yesBtn = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.CustomMessageBoxWindow.Button_Yes;
  var boderZzvit = Aliases.CashaLot.HwndSource_WindowDialog9.WindowDialog.Border;
  var docForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
  var officialGiving = Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction;
  var documForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
  
  if(shiftActive.Visible && aqString.Compare(shiftActive.WPFControlText, OPENSHIFT, true) == 0)
  {
    shiftActive.Click();
    closeShift.Click();
    if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.WaitWPFObject("CustomMessageBoxWindow", "Z-звіт (закриття зміни)", 700).Exists)
    {
      yesBtn.Click();
      WinHandler.InsertPWD();
       if(Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction.Exists) 
       {
        if(Aliases.CashaLot.HwndSource_WindowDialog8.WaitWPFObject("WindowDialog", "Службова видача", 500).Exists)
        {
          officialGiving.btnOk.Click();
          aqUtils.Delay(3000);
          if(Aliases.CashaLot.WaitWPFObject("HwndSource: WindowDialog", "*", 500).Exists)
          {
            if(Aliases.CashaLot.HwndSource_WindowDialog.WaitWPFObject("WindowDialog", "*", 500).Exists)
            {
             if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.WaitWPFObject("Border", "*", 500).Exists)
             {
               if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.WaitWPFObject("Grid", "*", 500).Exists)
               {
                if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Grid.DialogPresenter.WaitWPFObject("UCDocumentForPrint", "*", 500).Exists)
                {
                documForPrint.btnReady.Click();
                WinHandler.InsertPWD();
                }
               }
              }
            }
          }
        }
      } 
    }

    if(Aliases.CashaLot.HwndSource_WindowDialog9.WaitWPFObject("WindowDialog", "Z-звіт", 500).Exists)
    {
    boderZzvit.ButtonZ.Click();
     if(Aliases.CashaLot.WaitWPFObject("HwndSource: WindowDialog", "*", 500).Exists)
     {
       if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Grid.DialogPresenter.WaitWPFObject("UCDocumentForPrint", "*", 500).Exists)
       {
        docForPrint.btnReady.Click();
       }
     }
    }
  }  
}

function CreateZzvitAndCloseShiftTest()
  {
  var boderZzvit = Aliases.CashaLot.HwndSource_WindowDialog9.WindowDialog.Border;
  var docForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
  var officialGiving = Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction;
  var documForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint; 
  
//  var MessageBoxWindow = new GetObject.GetMessageBoxWinObj(CusromMessBox, TEXTMESSBZZVITCLOSE);
//  MessageBoxWindow.Ok();
//  WinHandler.InsertPWD();

       WinHandler.InsertPWD();        
       if(Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction.Exists) 
       {
        var WinDial8 = Aliases.CashaLot.HwndSource_WindowDialog8.WaitWPFObject("WindowDialog", "Службова видача", 3);
        if(WinDial8.Exists)
        {
          officialGiving.btnOk.Click();
          aqUtils.Delay(1500);
          var WinDial = Aliases.CashaLot.HwndSource_WindowDialog.WaitWPFObject("WindowDialog", "*", 3);
          if(WinDial.Exists)
          {
            documForPrint.btnReady.Click();
            WinHandler.InsertPWD();
          }
        }
       }
       var WinDial9 = Aliases.CashaLot.HwndSource_WindowDialog9.WaitWPFObject("WindowDialog", "Z-звіт", 5);
       if(WinDial9.Exists)
       {
         boderZzvit.ButtonZ.Click();
          var WindDialBorderGrid = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.WaitWPFObject("Grid", "*", 5);
          if(WindDialBorderGrid.Exists)
          {
            docForPrint.btnReady.Click();
          }
       }

  }

  function Test89()
  {
  var MessBox = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border;  
  var messageBoxObj = new Objects.MessageBox(MessBox);
    if(aqString.Compare(messageBoxObj.Text, SYNCSESSIONNOTFOUND, true) == 0)
    {
      Log.Message("Під час завантаження даних отримано повідомлення: "+SYNCSESSIONNOTFOUND);
      MessBox.Button.Click();
      return true;
    }
  }
  
  
  function Test2ShiftControlClose()
{
  var stackPanel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.StackPanel;
  var shiftActive = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.txtShiftActiveDoZvit;
  var closeShift = Aliases.CashaLot.HwndSource_PopupRoot3.PopupRoot.NonLogicalAdornerDecorator.Button;
  var yesBtn = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.CustomMessageBoxWindow.Button_Yes;
  var boderZzvit = Aliases.CashaLot.HwndSource_WindowDialog9.WindowDialog.Border;
  var docForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
  var officialGiving = Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction;
  var documForPrint = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCDocumentForPrint;
  var result;
  
  if(shiftActive.Visible && aqString.Compare(shiftActive.WPFControlText, OPENSHIFT, true) == 0)
  {
    shiftActive.Click();
    closeShift.Click();
    if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow3.WaitWPFObject("CustomMessageBoxWindow", "Z-звіт (закриття зміни)", 5000).Exists)
    {
      yesBtn.Click();
      WinHandler.InsertPWD();
       if(Aliases.CashaLot.HwndSource_WindowDialog8.WindowDialog.UCNewTransaction.Exists) 
       {
        if(Aliases.CashaLot.HwndSource_WindowDialog8.WaitWPFObject("WindowDialog", "Службова видача", 5000).Exists)
        {
          officialGiving.btnOk.Click();
          aqUtils.Delay(5000);
          if(Aliases.CashaLot.WaitWPFObject("HwndSource: WindowDialog", "*", 7000).Exists)
          {
            if(Aliases.CashaLot.HwndSource_WindowDialog.WaitWPFObject("WindowDialog", "*", 7000).Exists)
            {
             if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.WaitWPFObject("Border", "*", 7000).Exists)
             {
               if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.WaitWPFObject("Grid", "*", 7000).Exists)
               {
                if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Grid.DialogPresenter.WaitWPFObject("UCDocumentForPrint", "*", 7000).Exists)
                {
                documForPrint.btnReady.Click();
                WinHandler.InsertPWD();
                result = true;
                }
               }
              }
            }
          }
        }
      } 
    }
    if(Aliases.CashaLot.HwndSource_WindowDialog9.WaitWPFObject("WindowDialog", "Z-звіт", 7000).Exists)
    {
    boderZzvit.ButtonZ.Click();
    aqUtils.Delay(5000);
     if(Aliases.CashaLot.WaitWPFObject("HwndSource: WindowDialog", "*", 7000).Exists)
     {
       if(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Grid.DialogPresenter.WaitWPFObject("UCDocumentForPrint", "*", 7000).Exists)
       {
        docForPrint.btnReady.Click();
        result = true;
       }
     }
    }
  }  
  return result;
}

function Test78()
{
   var GoodsGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.GoodsGrid;  
   var CustomMessageBoxWindow = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow5.CustomMessageBoxWindow;
   var ButtonYes = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow5.CustomMessageBoxWindow.Button_Yes;
   var result;
   
   for(i=0; i<GoodsGrid.Items.Count; i++)
    { 
     if(aqString.Compare(GoodsGrid.Items.get_Item(i).VendorCode.OleValue, "8989", true) == 0)
     {
       GoodsGrid.WPFObject("DataGridRow", "", i+1).WPFObject("DataGridCell", "", 9).Click();
//     GoodsGrid.set_SelectedItem(GoodsGrid.Items.get_Item(i));
       
     while(!CustomMessageBoxWindow.Exists)
     {
       aqUtils.Delay(500);
       Log.Message("Очикування вікна видалення товару");
     }
       if(CustomMessageBoxWindow.Exists && aqString.Compare(CustomMessageBoxWindow.WPFControlText, DELETEMESSAGE, true)==0)
       {
         ButtonYes.Click();
       }
       result = true;
     }
     else
     {
       result = false;
     }
    }
    Log.Message(result);
    return result;
}

function Test5()
{
  var result;
  var btnSynchronization = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Button;
  var windowDialogSign = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCConfirmPwd.pwdTextControl;
  var animatedWaitView = Aliases.CashaLot.HwndSource_AnimatedWaitView.AnimatedWaitView.StackPanel;
  var windowDialog = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border;
  
  btnSynchronization.Click();
  
  while(!windowDialogSign.Exists)
  {
  aqUtils.Delay(1000);
  Log.Message("Очикування вікна підпису");
  }
  if(windowDialogSign.Exists)
  {  
  WinHandler.InsertPWD(); 
  } 
  
  while(animatedWaitView.Exists)
  {
    aqUtils.Delay(500);
    Log.Message("Очикування завершення завантаження данних в базу бек-офис");
  }
  
  if(windowDialog.Exists)
  {
    var msgBox = new MessageBox(Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border);
    if(windowDialog.Exists && aqString.Compare(msgBox.Text, SYNCSUCCESS, true)==0)
    {
      windowDialog.Button.Click();
      result = true;
    }
    else
    {
      Log.Message("Помилка під час спроби синхронизації: " + msgBox.Text);
      windowDialog.Button.Click();
      result = false;
    }
  }
  Log.Message(result);
  return result;
}

function Test7()
{
  var pathFile = "C:\\Users\\Vitaliy.Miniailo\\Desktop\\Шаблон для імпорту.xlsx";
  var btnExportFileTemplate = Aliases.CashaLot.HwndSource.WindowDialog.Button;
  var progress = Aliases.CashaLot.dlg_2.WorkerW.ReBarWindow32.AddressBandRoot.progress;
  
  
  //Видалити файл Шаблон для імпорту.xlsx, якщо існує 
  try
  {
  if(dotNET.System_IO.File.Exists(pathFile))
  {
    dotNET.System_IO.File.Delete(pathFile);
    Log.Message("Файл 'Шаблон для імпорту.xlsx' успішно видалено");
  }
  }
  catch(e)
  {
  Log.Error("Помилка видалення файла 'Шаблон для імпорту.xlsx': " + e)
  }  

  btnExportFileTemplate.Click();
  
  while(!progress.Exists)
  {
    aqUtils.Delay(500);
    Log.Message("Очикування браузера каталогів")
  }
  var toolbar_ = progress.BreadcrumbParent.toolbar;
//  toolbar_.ClickItemR("Этот компьютер", false);
  toolbar_.ClickR();
  toolbar_.PopupMenu.Click("Изменить адрес");
  var comboBox = progress.comboBox;
  comboBox.SetText("C:\\Users\\Vitaliy.Miniailo\\Desktop");
  comboBox.ComboBox.Edit.Keys("[Enter]");
  Aliases.CashaLot.dlg_2.btn_.Click();
}

function Test8()
{
  var result;
  var btnImport = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.btImport;
  var ImportWindowDialog = Aliases.CashaLot.HwndSource_WindowDialog20.WindowDialog.Grid;
  var btnExportFileTemplate = Aliases.CashaLot.HwndSource_WindowDialog20.WindowDialog.Grid.Button;
  var progress = Aliases.CashaLot.dlg_2.WorkerW.ReBarWindow32.AddressBandRoot.progress;
  var textFilerImportWindowDialog = Aliases.CashaLot.HwndSource_WindowDialog20.WindowDialog.Grid.textFiler;
  var btnImportWindowDialog = Aliases.CashaLot.HwndSource_WindowDialog20.WindowDialog.Grid.Button2;
  var windowDialogResultImp = Aliases.CashaLot.HwndSource_WindowDialog20.WindowDialog;
  var btnOkWinDialogResultImp = Aliases.CashaLot.HwndSource_WindowDialog20.WindowDialog.Button_OK;
  var textWindowDialogResultImp = Aliases.CashaLot.HwndSource_WindowDialog20.WindowDialog.text1;
  
  while(!btnImport.Exists)
  {
    aqUtils.Delay(500);
    Log.Message("Очикування кнопки Імпорт в розділі Номенклатура");
  }
  if(btnImport.Exists)
  {
  btnImport.Click();
  }
  while(!ImportWindowDialog.Exists)
  {
    aqUtils.Delay(500);
    Log.Message("Очикування вікна для імпорту довідника товарів");
  }
  if(ImportWindowDialog.Exists)
  {
  //Видалити файл Шаблон для імпорту.xlsx, якщо існує 
  try
  {
  if(dotNET.System_IO.File.Exists(PATHIMPEXPFILE))
    {
    dotNET.System_IO.File.Delete(PATHIMPEXPFILE);
    Log.Message("Файл 'Шаблон для імпорту.xlsx' успішно видалено");
    }
  }
  catch(e)
  {
  Log.Error("Помилка видалення файла 'Шаблон для імпорту.xlsx': " + e)
  }  

  btnExportFileTemplate.Click();
  
  while(!progress.Exists)
  {
    aqUtils.Delay(500);
    Log.Message("Очикування браузера каталогів")
  }
  var toolbar_ = progress.BreadcrumbParent.toolbar;
  toolbar_.ClickR();
  toolbar_.PopupMenu.Click("Изменить адрес");
  var comboBox = progress.comboBox;
  comboBox.SetText(DIRECTORYFOREXPORT);
  comboBox.ComboBox.Edit.Keys("[Enter]");
  Aliases.CashaLot.dlg_2.btn_.Click();
  }
  
  //Перевірка наявності експортованого файлу
  while(!dotNET.System_IO.File.Exists(PATHIMPEXPFILE))
  {
    aqUtils.Delay(500);
    Log.Message("Очикування результату перевірки файла шаблона в каталозі PATHIMPEXPFILE");
  }
  if(dotNET.System_IO.File.Exists(PATHIMPEXPFILE))
  {
    textFilerImportWindowDialog.set_Text(PATHIMPEXPFILE);
  }
  else
  {
    Log.Error("Файл 'Шаблон для імпорту.xlsx' відсутні в каталозі");
  }
  
  var cashaLot = Aliases.CashaLot;
  cashaLot.HwndSource_WindowDialog20.WindowDialog.Grid.File_Button.ClickButton();
  var dlg_ = cashaLot.dlg_3;
  var progress = dlg_.WorkerW.ReBarWindow32.AddressBandRoot.progress;
  var toolbar = progress.BreadcrumbParent.toolbar;
  toolbar.ClickR();
  toolbar.PopupMenu.Click("Изменить адрес");
  progress.comboBox.SetText(PATHIMPEXPFILE);
  dlg_.btn_.ClickButton();  

  btnImportWindowDialog.Click();
  
  while(!textWindowDialogResultImp.Exists)
  {
   aqUtils.Delay(500);
   Log.Message("Очикування вікна результату імпорта номенклатури"); 
  }
  if(textWindowDialogResultImp.Exists && aqString.Compare(textWindowDialogResultImp.Text.OleValue, Parameters.RESIMPORT, true) == 0)
  {
    result = true;
    Log.Message("Імпорт номенклатури виконано вдало");   
    btnOkWinDialogResultImp.Click();
  }
  else
  {
    result = false;
    Log.Message("Імпорт номенклатури не виконано");
    btnOkWinDialogResultImp.Click();
  }
  
  ModulsHandlerDirectory.DelGood("8870707");
  ModulsHandlerDirectory.DelGood("8870708");
  ModulsHandlerDirectory.DelGood("8870709");

  return result;
}

function Test9()
{
    var cashaLot = Aliases.CashaLot;
    var edGenericDriverJsonPathUSB = cashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos.edGenericDriverJsonPathUSB;
    edGenericDriverJsonPathUSB.Click();
    edGenericDriverJsonPathUSB.Keys("[Tab]");
    edGenericDriverJsonPathUSB.Keys("[Enter]");
    var dlg_ = cashaLot.dlg_3;
    var progress = dlg_.WorkerW.ReBarWindow32.AddressBandRoot.progress;
    progress.BreadcrumbParent.toolbar.ClickR();
    progress.BreadcrumbParent.toolbar.PopupMenu.Click("Изменить адрес");
    progress.comboBox.SetText(PATHDRIVER);
    progress.comboBox.Keys("[Enter]");
    dlg_.btn_.ClickButton();
}

function Test10()
{
  var toolbar_ = progress.BreadcrumbParent.toolbar;
  toolbar_.ClickR();
  toolbar_.PopupMenu.Click("Изменить адрес");
  var comboBox = progress.comboBox;
  comboBox.SetText(DIRECTORYFOREXPORT);
  comboBox.ComboBox.Edit.Keys("[Enter]");
  Aliases.CashaLot.dlg_2.btn_.Click();
}










function Test11()
{
    var cashaLot = Aliases.CashaLot;
    var edGenericDriverJsonPathUSB = cashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos.edGenericDriverJsonPathUSB;
    edGenericDriverJsonPathUSB.Click();
    edGenericDriverJsonPathUSB.Keys("[Tab]");
    edGenericDriverJsonPathUSB.Keys("[Enter]");
    var dlg_ = cashaLot.dlg_3;
    var progress = dlg_.WorkerW.ReBarWindow32.AddressBandRoot.progress;
    progress.BreadcrumbParent.toolbar.ClickR();
    progress.BreadcrumbParent.toolbar.PopupMenu.Click("Изменить адрес");
    progress.comboBox.SetText(PATHDRIVER);
    dlg_.OpenFile("C:\\DriverPrivat\\genericDriverJsonUSB.exe");
//    progress.comboBox.Keys("[Enter]");
//    dlg_.btn_.ClickButton();
}

function Test12()
{
    var cashaLot = Aliases.CashaLot;
    var pathDriver = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.edGenericDriver;
    pathDriver.Click();
    pathDriver.Keys("[Tab]");
    pathDriver.Keys("[Enter]");
    var dlg_ = cashaLot.dlg_3;
    var progress = dlg_.WorkerW.ReBarWindow32.AddressBandRoot.progress;
    progress.BreadcrumbParent.toolbar.ClickR();
    progress.BreadcrumbParent.toolbar.PopupMenu.Click("Изменить адрес");
    progress.comboBox.SetText(PATHDRIVERSCALES);
    dlg_.OpenFile(DRIVERSCALES);
}

function Test13()
{
  var mainWindow = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_;
  mainWindow.DockPanel.ComboBox.Click(545, 15);
  mainWindow.Click(220, 33);
}