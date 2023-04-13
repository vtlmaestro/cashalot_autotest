//USEUNIT Parameters
//USEUNIT WinHandler

//Модуль Довідники
function DirectoryNomenklatura()
{
  var directoryPanel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel;
  var btnAddNewGoods = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.btnEditGoods;
  var addVendorCode = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.edVendorCode;
  var addGoodsName = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.edGoodsName;
  var cmbGoodsGrp = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.cmbGoodsGroup;
  var cmbGoodsType = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.cmbGoodsType;
  var cmbUKDZED = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.cmbUKDZED;
  var textFilterUKTZED = Aliases.CashaLot.HwndSource_WindowDialog15.WindowDialog.Container_.textFilter;
  var btnOkUktzed = Aliases.CashaLot.HwndSource_WindowDialog15.WindowDialog.Container_.Button;
  var cmbUnitType = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.cmbUnitType;
  var textFilterUnit = Aliases.CashaLot.HwndSource_WindowDialog16.WindowDialog.textFilter;
  var btnOkUnit = Aliases.CashaLot.HwndSource_WindowDialog16.WindowDialog.Button2;
  var cmbDKPP = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.ScrollViewer.cmbDKPP;
  var textFilterDKPP = Aliases.CashaLot.HwndSource_WindowDialog18.WindowDialog.textFilter;
  var btnOkDKPP = Aliases.CashaLot.HwndSource_WindowDialog18.WindowDialog.Button;
  var scrollViewer = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.ScrollViewer;
                
  
  //Виклик вікна Новий товар\послуга
  this.GetWindowAddNewGoods = function()
  {
    var windowDialogAddNewGoods = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border;
    btnAddNewGoods.Click();
    while(!windowDialogAddNewGoods.Exists)
    {
      if(windowDialogAddNewGoods.Exists)
      {
        break;
      }
      Log.Message("Очикування вікна створення нового товару");
      aqUtils.Delay(200);
    }
    
    if(windowDialogAddNewGoods.Exists)
    {
      return windowDialogAddNewGoods;
    }
  }
  
  //додати артикул товара
  this.SetVendorCode = function(vendorCode)
  {
    addVendorCode.set_Text(vendorCode);
  }
  
  //додати найменування товару
  this.SetNameGood = function(goodsName)
  {
    addGoodsName.set_Text(goodsName);
  }
  
  //обрати групу товару
  this.SelectGroupGoods = function(groupName)
  {
    for(i=0; i<cmbGoodsGrp.Items.Count; i++)
    { 
     if(aqString.Compare(cmbGoodsGrp.Items.get_Item(i).Name.OleValue, groupName, true) == 0)
     {
     cmbGoodsGrp.set_SelectedItem(cmbGoodsGrp.Items.get_Item(i));
     }
    }
  }
  
  //обрати тип товару
  this.SelectTypeGoods = function(typeGood)
  {
    for(i=0; i<cmbGoodsType.Items.Count; i++)
    { 
     if(aqString.Compare(cmbGoodsType.Items.get_Item(i).Name.OleValue, typeGood, true) == 0)
     {
     cmbGoodsType.set_SelectedItem(cmbGoodsType.Items.get_Item(i));
     }
    }
  }
  
  //обрати УКТЗЕД товару
  this.SelectUKTZEDGood = function(UKTZEDGood)
  {
//    cmbUKDZED.DataContext.set_UktzGoodsCode(UKTZEDGood);
    cmbUKDZED.Click();
    cmbUKDZED.Keys("[Tab]");
    cmbUKDZED.Keys("[Enter]");
    textFilterUKTZED.set_Text(UKTZEDGood);
    btnOkUktzed.Click();
  }
  
  //Обрати одиницю виміру
  this.SelectUnit = function(nameUnit)
  {
   cmbUnitType.Click();
   cmbUnitType.Keys("[Tab]");
   cmbUnitType.Keys("[Enter]");
   textFilterUnit.set_Text(nameUnit);
   btnOkUnit.Click();
  }
  
  //Обрати код за ДКПП
  this.SelectDKPP = function(codeDkpp)
  {
   cmbDKPP.Click();
   cmbDKPP.Keys("[Tab]");
   cmbDKPP.Keys("[Enter]");
   textFilterDKPP.set_Text(codeDkpp);
   btnOkDKPP.Click();
  }
  
  //Обрати скролвьювер товару
  this.SelectScrollViewer = function(nameScrollViewer)
  {
  scrollViewer.Tabs.ClickTab(nameScrollViewer);
  }
  
  //додати ціну товару
  this.AddPriceGoods = function(costCoods, markUp)
  {
    var btnAddPrice = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.ScrollViewer.Tabs.btAddPrice;
    var prcTextBox = Aliases.CashaLot.HwndSource_WindowDialog19.WindowDialog.prcInTextBox;
    var markUpTextBox = Aliases.CashaLot.HwndSource_WindowDialog19.WindowDialog.prcTradeMarginTextBox;
    var sellPriceTextBox = Aliases.CashaLot.HwndSource_WindowDialog19.WindowDialog.prcOutTextBox;
    var saveBtn = Aliases.CashaLot.HwndSource_WindowDialog19.WindowDialog.Button;
    btnAddPrice.Click();
    prcTextBox.set_Text(costCoods);
    markUpTextBox.set_Text(markUp);
//    sellPriceTextBox.set_Text(sellPrice);
   saveBtn.Click();
  }
  
  //додати ставку податку ПДВ
  this.AddTaxRatePDV = function(taxRatePdv)
  {
    var ratePDV = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.ScrollViewer.Tabs.VATRate;
    for(i=0; i<ratePDV.Items.Count; i++)
    { 
     if(aqString.Compare(ratePDV.Items.get_Item(i).Name.OleValue, taxRatePdv, true) == 0)
     {
     ratePDV.set_SelectedItem(ratePDV.Items.get_Item(i));
     }
    }
  }
  
  //додати ставку акцизного податку 
  this.AddTaxRateAksiz = function(taxRateAksiz)
  {
    var rateAksiz = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.ScrollViewer.Tabs.ExciseRate;
    for(i=0; i<rateAksiz.Items.Count; i++)
    { 
     if(aqString.Compare(rateAksiz.Items.get_Item(i).Name.OleValue, taxRateAksiz, true) == 0)
     {
     rateAksiz.set_SelectedItem(rateAksiz.Items.get_Item(i));
     }
    }
  }
  
  //додати ставку податку ПФ
  this.AddTaxRatePF = function(taxRatePf)
  {
    var ratePF = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.ScrollViewer.Tabs.AdditionalTaxRate;
    for(i=0; i<ratePF.Items.Count; i++)
    { 
     if(aqString.Compare(ratePF.Items.get_Item(i).Name.OleValue, taxRatePf, true) == 0)
     {
     ratePF.set_SelectedItem(ratePF.Items.get_Item(i));
     }
    }
  }
  
  //зберігти доданий товар
  this.SaveGood = function()
  {
    var saveBtn = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.btSave;
    saveBtn.Click();
  } 
}

function EditGoods()
{
  
 //видалити код УКТЗЕД
 this.DeleteUKTZED = function()
 {
  var cmbUKDZED = Aliases.CashaLot.HwndSource_WindowDialog17.WindowDialog.ScrollViewer.cmbUKDZED;
  cmbUKDZED.Click();
  cmbUKDZED.Keys("[Tab][Tab]");
  cmbUKDZED.Keys("[Enter]");  
 }
 
 //редагувати ДКПП
 this.EditDKPP = function(codeDkpp)
 {
  var cmbDKPP = Aliases.CashaLot.HwndSource_WindowDialog17.WindowDialog.ScrollViewer.cmbDKPP;
  cmbDKPP.Click();
  cmbDKPP.Keys("[Tab]");
  cmbDKPP.Keys("[Enter]");
  var textFilterDKPP = Aliases.CashaLot.HwndSource_WindowDialog18.WindowDialog.textFilter;
  textFilterDKPP.set_Text(codeDkpp);
  var btnOkDKPP = Aliases.CashaLot.HwndSource_WindowDialog18.WindowDialog.Button;
  btnOkDKPP.Click();
 }
 
 //редагувати ціну
 this.EditPriceGood = function(sum)
 {
  var btnAddPrice = Aliases.CashaLot.HwndSource_WindowDialog17.WindowDialog.ScrollViewer.Tabs.btAddPrice;
  var prcTextBox = Aliases.CashaLot.HwndSource_WindowDialog19.WindowDialog.prcInTextBox;  
  var saveBtn = Aliases.CashaLot.HwndSource_WindowDialog19.WindowDialog.Button;
  btnAddPrice.Click();
  prcTextBox.set_Text(sum);
  saveBtn.Click();
 }
 
 //зберігти відредагований товар
 this.SaveEditGood = function()
 {
  var btnSave = Aliases.CashaLot.HwndSource_WindowDialog17.WindowDialog.btSave;
  btnSave.Click();
 }
 
 //Обрати скролвьювер товару, що редагуеться
 this.SelectScrollViewerEditGood = function(nameScrollViewer)
 {
 var ScrollViewerTab = Aliases.CashaLot.HwndSource_WindowDialog17.WindowDialog.ScrollViewer.Tabs;
 ScrollViewerTab.ClickTab(nameScrollViewer);
 }
 
  //редагувати ставку податку ПДВ
  this.EditTaxRatePDV = function(newtaxRatePdv)
  {
    var ratePDV = Aliases.CashaLot.HwndSource_WindowDialog17.WindowDialog.ScrollViewer.Tabs.VATRate;
    for(i=0; i<ratePDV.Items.Count; i++)
    { 
     if(aqString.Compare(ratePDV.Items.get_Item(i).Name.OleValue, newtaxRatePdv, true) == 0)
     {
     ratePDV.set_SelectedItem(ratePDV.Items.get_Item(i));
     }
    }
  }
  
  //редагувати ставку акцизного податку 
  this.EditTaxRateAksiz = function(newtaxRateAksiz)
  {
    var rateAksiz = Aliases.CashaLot.HwndSource_WindowDialog17.WindowDialog.ScrollViewer.Tabs.ExciseRate;
    for(i=0; i<rateAksiz.Items.Count; i++)
    { 
     if(aqString.Compare(rateAksiz.Items.get_Item(i).Name.OleValue, newtaxRateAksiz, true) == 0)
     {
     rateAksiz.set_SelectedItem(rateAksiz.Items.get_Item(i));
     }
    }
  }
 
  //редагувати ставку податку ПФ
  this.EditTaxRatePF = function(newtaxRatePf)
  {
    var ratePF = Aliases.CashaLot.HwndSource_WindowDialog17.WindowDialog.ScrollViewer.Tabs.AdditionalTaxRate;
    for(i=0; i<ratePF.Items.Count; i++)
    { 
     if(aqString.Compare(ratePF.Items.get_Item(i).Name.OleValue, newtaxRatePf, true) == 0)
     {
     ratePF.set_SelectedItem(ratePF.Items.get_Item(i));
     }
    }
  }
 
  //виклик вікна редагування товару
  this.CallWindowEditGood = function(indexRow)
  {
    var GoodsGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.GoodsGrid; 
    GoodsGrid.WPFObject("DataGridRow", "", indexRow).WPFObject("DataGridCell", "", 10).Click();
  }
}

  //Видалити товар
function DelGood(vendorCode)
{
   var result;
   var GoodsGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.GoodsGrid;
   var CustomMessageBoxWindow = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow5.CustomMessageBoxWindow;
   var ButtonYes = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow5.CustomMessageBoxWindow.Button_Yes;
   for(i=0; i<GoodsGrid.Items.Count; i++)
    { 
     if(aqString.Compare(GoodsGrid.Items.get_Item(i).VendorCode.OleValue, vendorCode, true) == 0)
     {
     GoodsGrid.WPFObject("DataGridRow", "", i+1).WPFObject("DataGridCell", "", 9).Click();
       
     while(!CustomMessageBoxWindow.Exists)
     {
       aqUtils.Delay(500);
       Log.Message("Очикування вікна видалення товару");
     }
       if(CustomMessageBoxWindow.Exists && aqString.Compare(CustomMessageBoxWindow.WPFControlText, Parameters.DELETEMESSAGE, true)==0)
       {
         ButtonYes.Click();
       }
       result = true;
       break;
     }
     else
     {
       result = false;
     }
    }
    return result;
}

function CreateNewGood(vendorCode)
{
    var result;
    var GoodsGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.GoodsGrid;
    var ScrollViewer = Aliases.CashaLot.HwndSource_WindowDialog14.WindowDialog.Border.ScrollViewer;
    
    //Перевірка наявності в реєстрі та видалення товару з артикулом vendorCode
    while(!GoodsGrid.Exists)
    {
      aqUtils.Delay(500);
      Log.Message("Очикування вікна Номенклатура (GoodsGrid)");
    }
    for(i=0; i<GoodsGrid.Items.Count; i++)
    { 
     if(aqString.Compare(GoodsGrid.Items.get_Item(i).VendorCode.OleValue, vendorCode, true) == 0)
     {
       if(DelGood(vendorCode))
       {
       Log.Message("Знайдено та видалено товар з артикулом '8989' перед створенням товару");
       }
     break;
     }
    } 
    var newNomenklature = new DirectoryNomenklatura();
    newNomenklature.GetWindowAddNewGoods();
    newNomenklature.SetVendorCode(vendorCode);
    newNomenklature.SetNameGood(Parameters.NAMEGOOD);
    newNomenklature.SelectGroupGoods(Parameters.NAMEPRODUCTGROUPOTHER); 
    newNomenklature.SelectTypeGoods(Parameters.TYPEGOODS);
    newNomenklature.SelectUKTZEDGood(Parameters.CODEUKTZED);
    newNomenklature.SelectUnit(Parameters.NAMEUNIT);
    newNomenklature.SelectScrollViewer(Parameters.SCROLLVIEWERPRICE);
    newNomenklature.AddPriceGoods(SUM, MARKUP);
    newNomenklature.SelectScrollViewer(Parameters.SCROLLVIEWERTAXRATE);
    newNomenklature.AddTaxRatePDV(TAXRATEPDV20);
    newNomenklature.AddTaxRateAksiz(TAXRATEAKSIZ5);
    newNomenklature.SaveGood();
    
    while(ScrollViewer.Exists)
    {
      aqUtils.Delay(500);
      Log.Message("Очикування вікна Номенклатура (GoodsGrid)");
    }
    if(!ScrollViewer.Exists)
    {
    for(i=0; i<GoodsGrid.Items.Count; i++)
    { 
     if(aqString.Compare(GoodsGrid.Items.get_Item(i).VendorCode.OleValue, Parameters.VENDORCODE8989, true) == 0)
     {
     result = true;
     break;
     }
     else
     {
       result = false;
     }
    } 
    }
    return result;
}

//Виконання синхронизації довідника
function Synchronization()
{
  var result = false;
  var btnSynchronization = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Button;
  var windowDialogSign = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.UCConfirmPwd.pwdTextControl;
  var animatedWaitView = Aliases.CashaLot.HwndSource_AnimatedWaitView.AnimatedWaitView.StackPanel;
  var windowDialog = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border;
  var count = 0;
  
  btnSynchronization.Click();
  
  while(!windowDialogSign.Exists && count != 4)
  {
  aqUtils.Delay(1000);
  count++;
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
      result = true;
    }
  }
  return result;
}

//Імпорт номенклатури
function ImportNomenklatura()
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
    btnOkWinDialogResultImp.Click();
  }
  else
  {
    result = false;
    btnOkWinDialogResultImp.Click();
  }
  
  ModulsHandlerDirectory.DelGood("8870707");
  ModulsHandlerDirectory.DelGood("8870708");
  ModulsHandlerDirectory.DelGood("8870709");

  return result;
}












