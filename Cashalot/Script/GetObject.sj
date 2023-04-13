//USEUNIT Config
//USEUNIT Objects
//USEUNIT Parameters


//Отримати об'єкт MessBox та порівняти текст, отриманий в параметрі з тестом в заголовку MessBoxWin створенного об'єкта, якщо співпадає - повертаємо об'єкт newObjMessBox
function GetMessageBoxWinObj(messBoxWin, txtMessBox)
{
  var newObjMessBox = new Objects.MessageBox(messBoxWin);
  
  if(aqString.Compare(newObjMessBox.Text, txtMessBox, true)==0)
  {
    return newObjMessBox;
  }
   else
   {
    Log.Error("Отриманий в параметрі текст не співпадає з заголовком MessBoxWin: " + messBoxWin.TextBlock_Message.Text.OleValue);
   }
}

function GetVersionCashalot()
{
  var version;
  var versionCashalot = new Objects.AboutProgramm();
  versionCashalot.ClickInfoBtn();
  versionCashalot.ClickAboutProgram();
  version = versionCashalot.GetVersion();
  versionCashalot.CloseAboutProgram();
  return version;
}










