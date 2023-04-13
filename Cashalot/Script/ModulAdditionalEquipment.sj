//USEUNIT Parameters
//USEUNIT AdditionalEquipmentPrinter
//USEUNIT AdditionalEquipmentPosTerminal
//USEUNIT AdditionalEquipmentScales

function CheckSettingsPrinter()
{
  var printerObj = new Printer();
  
  this.SetPrinter = function(namePrint)
  {
  var res = printerObj.MakeActivePrinter(namePrint);
  if(res == 1)
  {
    return ALREADYUSE;
  }
  else if(res == 2)
  {
    return PRINUSE;
  }
  }
  
  this.CheckPrintActive = function(namePrint)
  {
    if(printerObj.DoesPrintActive(namePrint))
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}

function CheckSettingsPosTerminal()
{
  var posTermObj = new PosTerminal();
  
  this.CheckPosTerminal = function(nameConfig, pathDriver, fileExeConfig, addressDriver, portDriver)
  {
    var resultTestConnection;
    posTermObj.SelectTypeConfig(nameConfig);
    posTermObj.SelectDriverJsonPathUSB(pathDriver, fileExeConfig);
    posTermObj.SetAddressDriver(addressDriver);
    posTermObj.SetPortDriver(portDriver);
    var resSaveSettingsDriver = posTermObj.SaveSettingsDriver();
    if(resSaveSettingsDriver.BoolValue)
    {
      Log.Message("Результат збереження налаштувань в розділі Pos-термінал: "+resSaveSettingsDriver.TextValue)
    }
    resultTestConnection = posTermObj.TestConnectDriver();
    return resultTestConnection;
  }

}

function CheckSettingsScales()
{
  var scales = new Scales();
  
  this.CheckScales = function(nameScales, pathDriverScales, fileExeScales, nameModelScales, comPort)
  {
    scales.SelectTypeConfigScales(nameScales);
    scales.SelectDriverScales(pathDriverScales, fileExeScales);
    scales.SelectModelScales(nameModelScales);
    scales.SetPort(comPort);
    var resSaveSettingsScales = scales.SaveSettingsScales();
    if(resSaveSettingsScales.BoolValue)
    {
      Log.Message("Результат збереження налаштувань в розділі Ваги: "+resSaveSettingsScales.TextValue)
    }
    resultTestConnection = scales.TestConnectScales();
    return resultTestConnection;
  }
}














