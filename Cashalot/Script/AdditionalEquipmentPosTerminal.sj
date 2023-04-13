//USEUNIT Objects

function PosTerminal()
{
  var GroupboxPos = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos;
  var TypeConfigCmb = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.ComboBox;
  var AddressTerminal = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos.edTerminalIP;
  var PortTerminal = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos.edTerminalPort;
  var BtnTestConnection = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos.btnTestConnection;
  var BtnSave = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos.btnSave;
  var BtnCancel = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos.btnCancel;
  var PathUSB = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos.edGenericDriverJsonPathUSB;
  
  this.SelectTypeConfig = function(nameConfig)
  {
    for(i=0; i<TypeConfigCmb.Items.Count; i++)
    { 
      if(aqString.Compare(TypeConfigCmb.Text.OleValue, nameConfig, true) != 0)
        {
          aqUtils.Delay(500);
          TypeConfigCmb.SelectNext();
        }
        else if(TypeConfigCmb.Items.Count == 1)
        {
            aqUtils.Delay(500);
            TypeConfigCmb.SelectNext();          
        }
        else
        {
          break;
        }
    }
  }
  
  this.SelectDriverJsonPathUSB = function(pathDriver, fileExeConfig)
  {
    var cashaLot = Aliases.CashaLot;
    var edGenericDriverJsonPathUSB = cashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.GroupboxPos.edGenericDriverJsonPathUSB;
    edGenericDriverJsonPathUSB.Click();
    edGenericDriverJsonPathUSB.Keys("[Tab]");
    edGenericDriverJsonPathUSB.Keys("[Enter]");
    var dlg_ = cashaLot.dlg_3;
    var progress = dlg_.WorkerW.ReBarWindow32.AddressBandRoot.progress;
    progress.BreadcrumbParent.toolbar.ClickR();
    progress.BreadcrumbParent.toolbar.PopupMenu.Click("Изменить адрес");
    progress.comboBox.SetText(pathDriver);
    dlg_.OpenFile(fileExeConfig);
  }
  
  this.SetAddressDriver = function(addressDriver)
  {
    AddressTerminal.set_Text(addressDriver);
  }
  
  this.SetPortDriver = function(portDriver)
  {
    PortTerminal.set_Text(portDriver);
  }
  
  this.SetUSBComPort = function(portComDriver)
  {
    var USBComPort = Sys.Process("CashaLot").WPFObject("HwndSource: mainWindow").WPFObject("mainWindow").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("CashiersArea").WPFObject("Border", "", 1).WPFObject("borderWithContent").WPFObject("UCDeviceSettingsMainWindow", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("borderWithContent").WPFObject("UCPOSTerminalSettings", "", 1).WPFObject("Grid", "", 1).WPFObject("GroupBox", "Налаштування POS-терміналу", 1).WPFObject("StackPanel", "", 1).WPFObject("Grid", "", 1).WPFObject("PrivatJsonUSB").WPFObject("prmConnectJson").WPFObject("StackPanel", "", 1).WPFObject("edTerminalComPort");
    USBComPort.set_Text(portComDriver);
  }
  
  this.SaveSettingsDriver = function()
  {
    BtnSave.Click();
    Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.WaitProperty("Exists", true, 30000);
    var msg = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow;
    var testMessage = msg.TextBlock_Message.Text.OleValue;
    aqUtils.Delay(1000);
    msg.Close();
    var resRunMeth = new ResultRunMethod();
    if(aqString.Compare(testMessage, SAVESUCCESSPOSTERMINAL, true) == 0)
    {
      aqUtils.Delay(1000);
      resRunMeth.BoolValue = true;
      resRunMeth.TextValue = testMessage;
      return resRunMeth;
    }
    else
    {
      Log.Message("Помилка збереження налаштувань драйвера: "+testMessage);
      resRunMeth.BoolValue = false;
      resRunMeth.TextValue = testMessage;
      return resRunMeth;
    }
  }
  
  this.TestConnectDriver = function()
  {
    BtnTestConnection.Click();
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
      resRunMeth.BoolValue = false;
      resRunMeth.TextValue = testMessage;
      return resRunMeth;
    }
  }
}












