var ConfigsPath = Project.Path+"\\Config\\";
var PathApp = "C:\\ProgramData\\Cashalot\\Cashalot";

//Логирование
var ErrorAt = Log.CreateNewAttributes();
ErrorAt.Bold=true;
ErrorAt.FontColor = BuiltIn.clRed;
ErrorAt.Underline=true;
var greenMessage = Log.CreateNewAttributes();
greenMessage.Bold=true;
greenMessage.FontColor= BuiltIn.clGreen;
greenMessage.Underline=true;
var attrBlock = Log.CreateNewAttributes();
attrBlock.Bold=true;
attrBlock.FontColor= BuiltIn.clBlue;
attrBlock.Underline=false;
var attrError = Log.CreateNewAttributes();
attrError.Bold=true;
attrError.FontColor= BuiltIn.clRed;
attrError.Underline=false;
var blueLogAttr = Log.CreateNewAttributes();
blueLogAttr.Bold=true;
blueLogAttr.FontColor= BuiltIn.clBlue;
blueLogAttr.Underline=true;
var greenMessageNotUnderline = Log.CreateNewAttributes();
greenMessage.Bold=true;
greenMessage.FontColor= BuiltIn.clGreen;
greenMessage.Underline=false;