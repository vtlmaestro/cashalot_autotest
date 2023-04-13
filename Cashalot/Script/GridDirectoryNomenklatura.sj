//USEUNIT Parameters
//USEUNIT ModulsHandlerDirectory

//Грід номенклатури (Довідинки)
function GridGoods()
{
  var GoodsGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.GoodsGrid;
  
  //Виділити рядок товару
  this.SelectGood = function(vendorCode)
  {
   for(i=0; i<GoodsGrid.Items.Count; i++)
    { 
     if(aqString.Compare(GoodsGrid.Items.get_Item(i).VendorCode.OleValue, vendorCode, true) == 0)
     {
     GoodsGrid.set_SelectedItem(GoodsGrid.Items.get_Item(i));
     }
    }
  }
  
  //Видалити товар
  this.DeleteGood = function(vendorCode)
  {
   var result;
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
       if(CustomMessageBoxWindow.Exists && aqString.Compare(CustomMessageBoxWindow.WPFControlText, DELETEMESSAGE, true)==0)
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
  
  //Редагувати товар
  this.EditGood = function(vendorCode)
  {
    var ScrollViewer = Aliases.CashaLot.HwndSource_WindowDialog17.WindowDialog.ScrollViewer;
    var result;
    var GoodsGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.GoodsGrid;  
    var editGoods = new ModulsHandlerDirectory.EditGoods();
    
    //Пошук товару
    for(i=0; i<GoodsGrid.Items.Count; i++)
    { 
     if(aqString.Compare(GoodsGrid.Items.get_Item(i).VendorCode.OleValue, vendorCode, true) == 0)
     {
      editGoods.CallWindowEditGood(i+1);
      while(!ScrollViewer.Exists)
      {
       aqUtils.Delay(500);
       Log.Message("Очикування вікна редагування товару");
      }
       if(ScrollViewer.Exists)
       {
        editGoods.DeleteUKTZED();
        editGoods.EditDKPP(Parameters.DKPPCODE);
        editGoods.EditPriceGood(Parameters.SUM700);
        editGoods.SelectScrollViewerEditGood(Parameters.SCROLLVIEWERTAXRATE);
        editGoods.EditTaxRatePDV(TAXNORATEPDV);
        editGoods.EditTaxRateAksiz(TAXNORATEACSIZ);
        editGoods.EditTaxRatePF(Parameters.TAXRATEPF);
        editGoods.SaveEditGood();
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
}