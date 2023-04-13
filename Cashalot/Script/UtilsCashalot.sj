function GetGUID()
{
  Log.Message("Генеруємо GUID")
  var TypeLib = new ActiveXObject("Scriptlet.TypeLib")
  return TypeLib.Guid;
}

//  var guid = UtilsCashalot.GetGUID();
//  Project.Variables.ExecutionGuid = aqString.SubString(guid, 1 , aqString.GetLength(guid)-4);

function StringBuilder()
{
  var strings = new Array();
  
  this.Append = function(value)
  {
    strings.push(value);
  }
  
  this.AppendLine = function(value)
  {
   strings.push(value+dotNET.System.Environment.NewLine); 
  }
  
  this.Get = function()
  {
   return aqString.Replace(strings.toString(),dotNET.System.Environment.NewLine+",",dotNET.System.Environment.NewLine);
  }
  
  this.ToString = function()
  {
    return this.Get();
  }
  
  this.Clear = function()
  {
    strings = new Array();
  }
  
  return this;
}

//вывод свойств объекта
function showProps(obj, objName) {
  var result = "";
  for (var i in obj) {
    if (obj.hasOwnProperty(i)) {
    result += objName + "." + i + " = " + obj[i] + "\n";
    }
  }
  return result;
}

function GetCurrentDate(format)
{
  var nowDate = aqDateTime.Now();
  var day = aqDateTime.GetDay(nowDate);
  var month = aqDateTime.GetMonth(nowDate);
  var year = aqDateTime.GetYear(nowDate);
  var hours = aqDateTime.GetHours(nowDate);
  var minutes =aqDateTime.GetMinutes(nowDate);
  var seconds = aqDateTime.GetSeconds(nowDate);
  
  switch(format)
  {
    case "yyyy-MM-dd":
      if(month<10)
        return aqString.Format("%i-0%i-%i", year, month, day);
      return aqString.Format("%i-%i-%i", year, month, day);
    case "dd-MM-yyyy":
      return aqString.Format("%i-%i-%i",day,month,year);
    case "dd.MM.yyyy":
      if(month<10)
        return aqString.Format("%i.0%i.%i",day,month,year);
      return aqString.Format("%i.%i.%i",day,month,year);
  }
}

function GetCurrentPeriod()
{
  var nowDate = aqDateTime.Now();
  var day = aqDateTime.GetDay(nowDate);
  var month = aqDateTime.GetMonth(nowDate);
  var year = aqDateTime.GetYear(nowDate);
  var hours = aqDateTime.GetHours(nowDate);
  var minutes =aqDateTime.GetMinutes(nowDate);
  var seconds = aqDateTime.GetSeconds(nowDate);
  if(month<10)
    return aqString.Format("01.0%i.%i",month,year);
  return aqString.Format("01.%i.%i",month,year);
}

//Получить рандомный номер
function GetRandomNum(maxRange)
{
  return Math.floor(Math.random()*(maxRange-1+1))+1;;
}






