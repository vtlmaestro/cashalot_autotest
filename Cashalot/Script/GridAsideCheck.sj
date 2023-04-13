
//Грид Відкладені чеки
function DockPanelGridAsideCheck()
{
 var GridAsideCheckDocPanel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.zgrid;

 //Знайти Відкладений чек на поточну дату та з вказанним локальним номером (localNumber)
 this.FindAsideCheck = function(localNumCheck)
 {
  var dateNow = dotNET.System.DateTime.Now().ToShortDateString().OleValue;
  var getLocalCheck;
  for(i=0; i<GridAsideCheckDocPanel.Items.Count; i++)
  {
   if(GridAsideCheckDocPanel.Items.get_Item(i).OrderDate.Date.Compare(GridAsideCheckDocPanel.Items.get_Item(i).OrderDate.Date.OleValue, dateNow) == 0 
   && GridAsideCheckDocPanel.Items.get_Item(i).LocalNumber == localNumCheck)
    {
     getLocalCheck = GridAsideCheckDocPanel.Items.get_Item(i).LocalNumber;
    }
  }
  if(getLocalCheck == localNumCheck)
  {
     return true;
  }
   else
  {
    return false;
  }
 }
}