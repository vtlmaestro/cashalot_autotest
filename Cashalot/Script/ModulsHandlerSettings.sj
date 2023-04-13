
//Вибір груп налаштувань в розділі Загальні налаштування(Господарська одиниця, ПРРО, Прокси сервер)
function GeneralSettingsModul()
{
  var listViewGeneralSettings = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.ListView;
  
  this.SelectGroupSettings = function(groupSettingsName)
  {
    for(i=0; i<listViewGeneralSettings.Items.Count; i++)
    { 
     if(aqString.Compare(listViewGeneralSettings.Items.get_Item(i).WPFControlText, groupSettingsName, true) == 0)
     {
     listViewGeneralSettings.set_SelectedItem(listViewGeneralSettings.Items.get_Item(i));
     }
    }
  }
}

//Вибір груп налаштувань в розділі Додаткове обладнання (Принтери, POS-термінал, Ваги)
function AdditionalEquipment()
{
  var listViewAdditionalEquipment = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.ListView;
  
  this.SelectAdditionalEquipment = function(nameAdditionalEquipment)
  {
    for(i=0; i<listViewAdditionalEquipment.Items.Count; i++)
    { 
     if(aqString.Compare(listViewAdditionalEquipment.Items.get_Item(i).Tag.OleValue, nameAdditionalEquipment, true) == 0)
     {
     listViewAdditionalEquipment.set_SelectedItem(listViewAdditionalEquipment.Items.get_Item(i));
     }
    }
  }
}


















