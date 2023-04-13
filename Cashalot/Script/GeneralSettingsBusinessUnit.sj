//USEUNIT Objects

function BusinessUnitSettings()
{
  var ScrollViewerBusinessUnit = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border2.ScrollViewer;
  var NameEnterpriseScrollViewerGrid = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border2.ScrollViewer.Grid;
  
  this.GetEnterpriseInfo = function()
  {
    var enterpriseInf = new EnterpriseInfo();
    var NameEnterprise = NameEnterpriseScrollViewerGrid.Textbox;
    var IpnEnterprise = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.TextBoxNumberOrder;
    var EDRPOUEnterprise = NameEnterpriseScrollViewerGrid.Textbox2;
    
    enterpriseInf.EnterpriseName = NameEnterprise.get_Text();
    enterpriseInf.EnterpriseIPN = IpnEnterprise.get_Text();
    enterpriseInf.EnterpriseEDRPOU = EDRPOUEnterprise.get_Text();
    enterpriseInf.BoolValue = null;
    
    return enterpriseInf;
  }

}

function GOSettings()
{
  var NameGOList = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid;
  
  this.GetGOInfo = function()
  {
    var GoInf = new GOInfo();
    var NameGO = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.Textbox;
    var AddressGO = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.TextBoxNumberOrder;
    var TelephoneGO = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.Textbox2;
    var EmailGO = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.TextboxEmail;
    
    GoInf.BoolValue = null;
    GoInf.GOName = NameGO.get_Text();
    GoInf.GOAddress = AddressGO.get_Text();
    GoInf.GOTelephone = TelephoneGO.get_Text();
    GoInf.GOEmail = EmailGO.get_Text();
    
    return GoInf;
  }
  
  
}

function MailSettings()
{
  var BtnSettingsEmail = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.OpenSettingsBtn;
  var GridMailSettings = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings;
  var CloseSettingsBtnGridMailSettings = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.CloseSettingsBtn;
  var MailAddressTextBox = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.Textbox;
  var MailServerTextBox = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.srvName;
  var MailPortTextBox = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.srvPort;
  var MailNameTextBox = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.Textbox2;
  var MailPassTextBox = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.passwordTxb;
  var BtnCheckMailConnect = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.Button;
  var BtnSaveMailSettings = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.Button2;
  
  this.OpenMailSettings = function()
  {
    if(Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.OpenSettingsBtn.IsFocused == false)
    {
    BtnSettingsEmail.Click();     
    }
    if(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.WaitProperty("Exists", true, 3000))
    {
    aqUtils.Delay(500);
    Log.Message("Очикування вікна налаштувань пошти");
    }
    if(GridMailSettings.Exists)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  this.SetMailSettings = function()
  {
   if(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.WaitProperty("Exists", true, 3000))
   {
   aqUtils.Delay(500);
   Log.Message("Очикування вікна налаштувань пошти");
   }
   
   if(GridMailSettings.Exists)
   {
   MailAddressTextBox.set_Text(MAILADDRESS);
   if(MailAddressTextBox.Text == null)
   {
     qUtils.Delay(200);
     Log.Message("Очикування заповнення поля MailAddressTextBox");
   }
   else
   {
   MailNameTextBox.set_Text(MAILNAME);
   }
   if(MailNameTextBox.Text == null)
   {
     qUtils.Delay(200);
     Log.Message("Очикування заповнення поля MailNameTextBox");
   }
    else
    {
    MailPassTextBox.set_Password(MAILPASS);  
    aqUtils.Delay(500);
    MailPassTextBox.Click();
    }
   }
  }
  
  this.SetWrongMailSettings = function()
  {
   if(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.WaitProperty("Exists", true, 3000))
   {
   aqUtils.Delay(500);
   Log.Message("Очикування вікна налаштувань пошти");
   }
   
   if(GridMailSettings.Exists)
   {
   MailAddressTextBox.set_Text(MAILADDRESS);
   }
   if(MailAddressTextBox.Text == null)
   {
     qUtils.Delay(200);
     Log.Message("Очикування заповнення поля MailAddressTextBox");
   }
   else
   {
   MailNameTextBox.set_Text(MAILNAME);
   }
   if(MailNameTextBox.Text == null)
   {
     qUtils.Delay(200);
     Log.Message("Очикування заповнення поля MailNameTextBox");
   }
   else
   {
   //Вказали не вірний пароль
   MailPassTextBox.set_Password(WRONGPASSWORD);  
   aqUtils.Delay(500);
   MailPassTextBox.Click();
   }
  }
  
  this.ClickBtnCheckConnect = function()
  {
//  if(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.Button.WaitProperty("Exists", true, 500))
  while(!BtnCheckMailConnect.get_IsEnabled())
  {
  aqUtils.Delay(500);
  Log.Message("Очикування активації кнопки 'Перевірити з'єднання'");
  }  
  if(BtnCheckMailConnect.get_IsEnabled())
  {
    BtnCheckMailConnect.Click();
  }
  else
  {
    Log.Message("Кнопка 'Перевірити з'єднання' не активована");
  }
  while(!Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.WaitProperty("Exists", true, 10000))
  {
  aqUtils.Delay(500);
  Log.Message("Очикування вікна результату перевірки пошти");
  }
  msgBox = new Objects.MessageBox(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow);
  if(aqString.Compare(msgBox.Text, CHECKMAILSUCCESS, true) == 0)
  {
  msgBox.Ok();
  msgBox.BoolValue = true;
  return msgBox;
  }
  else
  {
    msgBox.Ok();
    msgBox.BoolValue = false;
    return msgBox;
  }
  }
  
  this.SaveMailSettings = function()
  {
//  if(!Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.lvRROList.Grid.MailSettings.Button2.WaitProperty("Exists", true, 500))
  while(!BtnSaveMailSettings.get_IsEnabled())
  {
  aqUtils.Delay(500);
  Log.Message("Очикування активації кнопки 'Зберігти'");
  }  
  if(BtnSaveMailSettings.get_IsEnabled())
  {
    BtnSaveMailSettings.Click();
  }
  else
  {
    Log.Message("Кнопка 'Зберегти' не активована");
  }
  }
  
 this.CloseMailSettings = function()
 {
   CloseSettingsBtnGridMailSettings.Click();
 }
}


