﻿//USEUNIT GeneralSettingsProxyServer
//USEUNIT GeneralSettingsBusinessUnit
//USEUNIT GeneralSettingsPRRO
//USEUNIT Parameters


function CheckProxyServerSettings()
{
  var proxySettings = new ProxyServerSettings();
  
  this.GetCurrentSettings = proxySettings.CurrentSettings;
  
  this.SaveSettingProxy = function()
  {
   return proxySettings.SaveProxi();
  }
  
  this.SaveSettingProxyWithTestConnect = function()
  {
   return proxySettings.Save(true);
  }
  
  this.SetProxyAddress = function(proxyAddress)
  {
    proxySettings.SetAddress(proxyAddress);
  }
  
  this.ClearProxyAddress = function()
  {
    proxySettings.ClearAddress();
  }
  
  this.SetProxyPort = function(proxyPort)
  {
    proxySettings.SetPort(proxyPort);
  }
  
  this.ClearProxyPort = function()
  {
    proxySettings.ClearPort();
  }
  
  this.SetProxySettingType = function(proxySettingType)
  {
    proxySettings.SetSettingType(proxySettingType);
  }
  
  this.CancelBtn = function()
  {
    proxySettings.Cancel();
  }
  
  this.TestProxyConnection = function()
  {
    return proxySettings.TestConnection();
  }
}

function CheckPRRO()
{
  this.GetPrroItem = function()
  {
    var prroItem;
    var newPrro = new Prro();
    newPrro.SelectNameGO(GONAME);
    newPrro.SerchPrro(FISCALNAMBER);
    prroItem = newPrro.GetItemPrro("0");
    
    if(aqString.Compare(prroItem.FiscalNum, FISCALNAMBER, true) == 0)
    {
    prroItem.BoolValue = true;
    return prroItem;
    }
    else
    {
     prroItem.BoolValue = false;
     return prroItem;     
    }
  }
}

function CheckBusinessUnit()
{ 
  this.CheckEnterprise = function()
  {
//  var businessUnitSettings = new BusinessUnitSettings();
  var enterpriseInfo = new BusinessUnitSettings().GetEnterpriseInfo();

  if(aqString.Compare(enterpriseInfo.EnterpriseEDRPOU.OleValue, EDRPOUENTERPRISE, true)==0 && aqString.Compare(enterpriseInfo.EnterpriseIPN.OleValue, IPNENTERRPISE, true)==0)
  {
    enterpriseInfo.BoolValue = true;
    return enterpriseInfo;
  }
  else
  {
    return false;
  }
  }
  
  this.CheckGO = function()
  {
  var goInfo = new GOSettings().GetGOInfo();
  if(aqString.Compare(goInfo.GOName.OleValue, GONAME, true)==0)
  {
    goInfo.BoolValue = true;
    return goInfo;
  }
  else
  {
    return false;
  }
  }
  
  this.CheckWrongEmail = function()
  {
    var mailSetting = new MailSettings();
    if(mailSetting.OpenMailSettings())
    {
    mailSetting.SetWrongMailSettings();
    mailSetting.SaveMailSettings();
    }
    else
    {
    Log.Message("Відсутнє вікно налаштувань пошти");
    }
    var checkMailConnect = mailSetting.ClickBtnCheckConnect();
    return checkMailConnect;
  }
  
  this.CheckEmail = function()
  {
    var mailSetting = new MailSettings();
    mailSetting.SetMailSettings();
    mailSetting.SaveMailSettings();

    var checkMailConnect = mailSetting.ClickBtnCheckConnect();
    return checkMailConnect;
  }
}


























