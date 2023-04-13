//USEUNIT CONST
//USEUNIT Objects

function ProxyServerSettings(proxy_setting_obj)
{
  this.CurrentSettings; 
  this.Exists = true;
  var objectSettingsProxy = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border2.Groupbox;
  var rdBtnProxyNo = objectSettingsProxy.rdBtnProxyNo;
  var rdBtnProxySystem = objectSettingsProxy.rdBtnProxySystem;
  var rdBtnProxyUser = objectSettingsProxy.rdBtnProxyUser;
  var edProxyAdrress = objectSettingsProxy.edProxyAdrress;
  var edProxyPort = objectSettingsProxy.edProxyPort;
  var btnTestConnection = objectSettingsProxy.btnTestConnection;
  var btnSaveProxy = objectSettingsProxy.btnSaveProxy;
  var btnCancel = objectSettingsProxy.btnCancel;
  var CustomMessageBoxWindow = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow;
  var msgBox;
  
  if(!Objects.IsNullOrUndefined(proxy_setting_obj))
  {
    this.SetSettingType(proxy_setting_obj.Type);
    if(rdBtnProxyUser.IsChecked)
    {
      this.SetAddress(proxy_setting_obj.Address);
      this.SetPort(proxy_setting_obj.Port);
    }
    this.CurrentSettings = proxy_setting_obj;
  }
  else
  {
    var currentType;
    if(rdBtnProxyNo.IsChecked)
      currentType = 1;
    else if(rdBtnProxySystem.IsChecked)
      currentType = 2;
    else
      currentType = 3;
    this.CurrentSettings = new Objects.ProxySetting(edProxyAdrress.Text.OleValue, edProxyPort.Text.OleValue, currentType);
  }
  
  this.SetAddress = function(addr)
  {
    edProxyAdrress.set_Text(addr);
  }
  
  this.ClearAddress = function()
  {
    edProxyAdrress.Clear();
  }
  
  this.SetPort = function(port)
  {
    edProxyPort.set_Text(port);
  }
  
  this.ClearPort = function()
  {
    edProxyPort.Clear();
  }
  
  this.SetSettingType = function(int_type)
  {
    if(int_type==1)
      rdBtnProxyNo.set_IsChecked(true);
    else if(int_type==2)
      rdBtnProxySystem.set_IsChecked(true);
    else
      rdBtnProxyUser.set_IsChecked(true);
  }
  
  this.Cancel = function()
  {
    btnCancel.Click();
  }
  
  this.SaveProxi = function()
  {
    btnSaveProxy.Click();
    if(!Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.WaitProperty("Exists", true, 10000))
    {
      aqUtils.Delay(500);
      Log.Message("Очикування збереження налаштувань прокси-сервера");
    }
    msgBox = new Objects.MessageBox(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow);
    if(aqString.Compare(msgBox.Text, SETTINGPROXYSAVESUCCESS, true) == 0)
    {
    msgBox.Ok();
    Log.Message("Зміни налаштування прокси-сервера успішно збережені");
    return true;
    }
    else
    {
    Log.Warning("Помилка збереження налаштувань проксі-сервера: "+msgBox.Text);
    return false;
    }
  }
  
  //return bool
  this.TestConnection = function()
  {
    btnTestConnection.Click();
    Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.WaitProperty("Exists", true, 30000);
    var msg = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow;
    var testMessage = msg.TextBlock_Message.Text.OleValue;
    aqUtils.Delay(1000);
    msg.Close();
    var resRunMeth = new ResultRunMethod();
    if(testMessage==CONST.CORRECT_PROXY_CONNECTION)
    {
      aqUtils.Delay(1000);
      resRunMeth.BoolValue = true;
      resRunMeth.TextValue = testMessage;
      return resRunMeth;
    }
    else
    {
      Log.Message("Помилка перевірки з'єднання з проксі-сервером: "+testMessage);
      resRunMeth.BoolValue = false;
      resRunMeth.TextValue = testMessage;
      return resRunMeth;
    }
  }
  
  //Збереження змін з перевркою з'єднання з проксі
  this.Save = function(withTestConnection)
  {
    withTestConnection = (Objects.IsNullOrUndefined(withTestConnection))?false:withTestConnection;
    
    if(withTestConnection)
    {
      if(this.TestConnection())
      {
        btnSaveProxy.Click();
        if(!Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.WaitProperty("Exists", true, 10000))
        {
        aqUtils.Delay(500);
        Log.Message("Очикування збереження налаштувань прокси-сервера");
        }
        msgBox = new Objects.MessageBox(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow);
        if(aqString.Compare(msgBox.Text, SETTINGPROXYSAVESUCCESS, true) == 0)
        {
        msgBox.Ok();
        Log.Message("Зміни налаштування прокси-сервера успішно збережені");
        return true;
        }
        else
        {
        Log.Warning("Помилка збереження налаштувань проксі-сервера: "+msgBox.Text);
        return false;
        }
      }
      else
        return false;
    }
    else
    {
      btnSaveProxy.Click();
      if(!Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.WaitProperty("Exists", true, 10000))
      {
      aqUtils.Delay(500);
      Log.Message("Очикування збереження налаштувань прокси-сервера");
      }
      msgBox = new Objects.MessageBox(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow);
      if(aqString.Compare(msgBox.Text, SETTINGPROXYSAVESUCCESS, true) == 0)
      {
      msgBox.Ok();
      Log.Message("Зміни налаштування прокси-сервера успішно збережені");
      return true;
      }
      else
      {
      Log.Warning("Помилка збереження налаштувань проксі-сервера: "+msgBox.Text);
      return false;
      }
    }
  }
  return this;
}  
