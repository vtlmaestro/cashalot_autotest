//USEUNIT Objects

function Scales()
{
 var scalesSetting = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border2.UCScalesSetting; 
// var typeConfigScalesCmb = Sys.Process("CashaLot").WPFObject("HwndSource: mainWindow").WPFObject("mainWindow").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("CashiersArea").WPFObject("Border", "", 1).WPFObject("borderWithContent").WPFObject("UCDeviceSettingsMainWindow", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("ScrollViewer", "", 1).WPFObject("borderWithContent").WPFObject("UCScalesSetting", "", 1).WPFObject("Grid", "", 1).WPFObject("GroupBox", "Налаштування ваг", 1).WPFObject("Grid", "", 1).WPFObject("Grid", "", 1).WPFObject("ComboBox", "", 1);
 var typeConfigScalesCmb = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.ComboBox;
 var BtnSave = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.btnSave;
 var BtnTestConnection = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.btnTestConnection;
 
 this.SelectTypeConfigScales = function(nameConfigScales)
 {
    for(i=0; i<typeConfigScalesCmb.Items.Count; i++)
    { 
      if(aqString.Compare(typeConfigScalesCmb.Text.OleValue, nameConfigScales, true) != 0)
        {
          aqUtils.Delay(500);
          typeConfigScalesCmb.SelectNext();
        }
        else if(typeConfigScalesCmb.Items.Count == 1)
        {
            aqUtils.Delay(500);
            typeConfigScalesCmb.SelectNext();          
        }
        else
        {
          break;
        }
    }   
 }
 
  this.SelectDriverScales = function(pathDriverScales, fileExeScales)
  {
    var cashaLot = Aliases.CashaLot;
    var pathDriver = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.Border3.Grid.edGenericDriver;
    pathDriver.Click();
    pathDriver.Keys("[Tab]");
    pathDriver.Keys("[Enter]");
    var dlg_ = cashaLot.dlg_3;
    var progress = dlg_.WorkerW.ReBarWindow32.AddressBandRoot.progress;
    progress.BreadcrumbParent.toolbar.ClickR();
    progress.BreadcrumbParent.toolbar.PopupMenu.Click("Изменить адрес");
    progress.comboBox.SetText(pathDriverScales);
    dlg_.OpenFile(fileExeScales);
  }
 
  this.SelectModelScales = function(nameModelScales)
  {
//    var modelScalesCmb = Sys.Process("CashaLot").WPFObject("HwndSource: mainWindow").WPFObject("mainWindow").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("CashiersArea").WPFObject("Border", "", 1).WPFObject("borderWithContent").WPFObject("UCDeviceSettingsMainWindow", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("ScrollViewer", "", 1).WPFObject("borderWithContent").WPFObject("UCScalesSetting", "", 1).WPFObject("Grid", "", 1).WPFObject("GroupBox", "Налаштування ваг", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("GroupBox", "Параметри підключення ваг", 1).WPFObject("StackPanel", "", 1).WPFObject("ComboBox", "", 1);
    var modelScalesCmb = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.ComboBox;
    for(i=0; i<modelScalesCmb.Items.Count; i++)
    { 
      if(aqString.Compare(modelScalesCmb.Text.OleValue, nameModelScales, true) != 0)
        {
          aqUtils.Delay(500);
          modelScalesCmb.SelectNext();
        }
        else if(modelScalesCmb.Items.Count == 1)
        {
            aqUtils.Delay(500);
            modelScalesCmb.SelectNext();          
        }
        else
        {
          break;
        }
    }   
  }  
  
  this.SetPort = function(comPort)
  {
//    var portScalesCmb = Sys.Process("CashaLot").WPFObject("HwndSource: mainWindow").WPFObject("mainWindow").WPFObject("Border", "", 1).WPFObject("Grid", "", 1).WPFObject("CashiersArea").WPFObject("Border", "", 1).WPFObject("borderWithContent").WPFObject("UCDeviceSettingsMainWindow", "", 1).WPFObject("Grid", "", 1).WPFObject("Border", "", 2).WPFObject("ScrollViewer", "", 1).WPFObject("borderWithContent").WPFObject("UCScalesSetting", "", 1).WPFObject("Grid", "", 1).WPFObject("GroupBox", "Налаштування ваг", 1).WPFObject("Grid", "", 1).WPFObject("StackPanel", "", 1).WPFObject("GroupBox", "Параметри підключення ваг", 1).WPFObject("StackPanel", "", 1).WPFObject("ComboBox", "", 2);
    var portScalesCmb = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.ComboBox2;
    portScalesCmb.set_Text(comPort);
  }
  
  this.SaveSettingsScales = function()
  {
    BtnSave.Click();
    Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.WaitProperty("Exists", true, 30000);
    var msg = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow;
    var testMessage = msg.TextBlock_Message.Text.OleValue;
    aqUtils.Delay(1000);
    msg.Close();
    var resRunMeth = new ResultRunMethod();
    if(aqString.Compare(testMessage, SAVESACCESSCALES, true) == 0)
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
  
  this.TestConnectScales = function()
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