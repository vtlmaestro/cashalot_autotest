

function Printer()
{
  var PrintListView = Sys.Process("CashaLot").WPFObject("HwndSource: mainWindow").WPFObject("mainWindow").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("CashiersArea").WPFObject("Border", "", 1).WPFObject("borderWithContent").WPFObject("UCDeviceSettingsMainWindow", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("borderWithContent").WPFObject("UCPrinterSettings", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("lvPrintList");  
 
//  var PrintListView = Sys.Process("CashaLot").WPFObject("HwndSource: mainWindow").WPFObject("mainWindow").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("CashiersArea").WPFObject("Border", "", 1).WPFObject("borderWithContent").WPFObject("UCDeviceSettingsMainWindow", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("ScrollViewer", "", 1).WPFObject("borderWithContent").WPFObject("UCPrinterSettings", "", 1).WPFObject("Grid", "", 1).WPFObject("ScrollViewer", "", 1).WPFObject("lvPrintList");
  this.SelectPrinter = function(namePrinter)
  {
    for(i=0; i<PrintListView.Items.Count; i++)
    { 
     if(aqString.Compare(PrintListView.Items.get_Item(i).Name.OleValue, namePrinter, true) == 0)
     {
     PrintListView.set_SelectedItem(PrintListView.Items.get_Item(i));
     return i;
     }
    }
  } 
  
  this.MakeActivePrinter = function(namePrinter)
  {
    var one = 1;
    var two = 2;
    
    for(i=0; i<PrintListView.Items.Count; i++)
    { 
      //если у передаваемого принтера IsCurrentPrinterDefault=true, то выходим
      if(aqString.Compare(PrintListView.Items.get_Item(i).Name.OleValue, namePrinter, true) == 0 && PrintListView.Items.get_Item(i).IsCurrentPrinterDefault)
      {
        aqUtils.Delay(1000);
        return one;
      }
      //если у какого-то другого принтера IsCurrentPrinterDefault=true, то устанавливаем в false
      else if(PrintListView.Items.get_Item(i).IsCurrentPrinterDefault)  
      {
       aqUtils.Delay(1000);
       PrintListView.Items.get_Item(i).set_IsCurrentPrinterDefault(false);
       PrintListView.Items.get_Item(i).RefreshEntireViewModel();
      }
    }
    //установить IsCurrentPrinterDefault в true в принтере, имя которого передается
    aqUtils.Delay(1000);
    PrintListView.Items.get_Item(this.SelectPrinter(namePrinter)).set_IsCurrentPrinterDefault(true);
    PrintListView.Items.get_Item(i).RefreshEntireViewModel();
    return two;
  }
  
  this.DoesPrintActive = function(namePrinter)
  {
   var result;
   for(i=0; i<PrintListView.Items.Count; i++)
    { 
      if(aqString.Compare(PrintListView.Items.get_Item(i).Name.OleValue, namePrinter, true) == 0 && PrintListView.Items.get_Item(i).IsCurrentPrinterDefault)
      {
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