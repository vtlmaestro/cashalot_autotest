//USEUNIT Objects

function DataUser()
{
  var GridDataUser = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid; 
  
  this.GetUserData = function()
  {
    var userData = new Objects.UserCashalot();
    userData.IsCurrentUserBoolValue = GridDataUser.DataContext.IsCurrentUser;
    userData.IsUserActiveBoolValue = GridDataUser.DataContext.IsUserActive;
    userData.Email = GridDataUser.DataContext.Email.OleValue;
    userData.Comment = GridDataUser.DataContext.Comment.OleValue;
    userData.IPN = GridDataUser.DataContext.IPN.OleValue;
    userData.Login = GridDataUser.DataContext.Login.OleValue;
    userData.Name = GridDataUser.DataContext.Name.OleValue;
    userData.Telephone = GridDataUser.DataContext.Telephone.OleValue;
    userData.Position = GridDataUser.DataContext.Position.OleValue;
    
    return userData;
  }
}

function ListUser()
{
  var PanelListUsers = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel;
  var SearchBox = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.searchBox;
  var ListView = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.ListView;
  
  this.SetSearchUser = function(userName)
  {
    SearchBox.set_Text(userName);
    try
    {
    return ListView.Items.get_Item(0).Name.OleValue;
    }
    catch(e)
    {
      Log.Warning("Користувача не знайдено: "+e)
    }
  }
  
  this.GetProfileUser = function(userName)
  {
    for(i=0; i<ListView.Items.Count; i++)
    {
     if(aqString.Compare(ListView.Items.get_Item(i).Name.OleValue, userName, true) == 0)
     {
     ListView.set_SelectedItem(ListView.Items.get_Item(i));
     return ListView.Items.get_Item(i);
     }
     else
     {
       Log.Message("Не знайдено користувача з вказаним ім'ям");
     }
    }
  }
  
  this.ClearSetSearchText = function()
  {
    SearchBox.Clear();
  }
}