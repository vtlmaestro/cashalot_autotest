//USEUNIT Objects

function Prro()
{
  var NameGOCmb = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.ComboBox;
  var SerchPrroTextbox = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border2.ScrollViewer.Grid.Textbox;                      
  var RroList = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList;

  this.SelectNameGO = function(goName)
  {
    for(i=0; i<NameGOCmb.Items.Count; i++)
    {
      if(aqString.Compare(NameGOCmb.Items.get_Item(i).Name.OleValue, goName, true) == 0)
      {
      NameGOCmb.SelectItemWithValue(NameGOCmb.Items.get_Item(i), true);
      break;
      }
    }
  }
  
  this.SerchPrro = function(stringPrro)
  {
    SerchPrroTextbox.set_Text(stringPrro);
  }
  
  this.GetItemPrro = function(ind)
  {
    var prroItem;
    var prroInf = new PRROInfo();
    for(i=0; i<RroList.Items.Count; i++)
    {
      if(ind == i)
      {
       prroItem = RroList.Items.get_Item(ind);
       break;
      }
    }
    
    prroInf.BoolValue = null;
    prroInf.PrroName = prroItem.RROName;
    prroInf.FiscalNum = prroItem.FiscalNumber;
    
    return prroInf;
  }
}











