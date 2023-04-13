//USEUNIT Cashalot_Autotest

//@tag LogIn
function LogInTest(incorrectPass)
{
  incorrectPass = (Objects.IsNullOrUndefined(incorrectPass))?true:incorrectPass;
  var resultForm;
  if(incorrectPass)
    resultForm = Cashalot.Login(Parameters.USERCERTNAME, Parameters.USERCERTPASSWORD);
  else
    resultForm = Cashalot.Login(Parameters.USERCERTNAME, "test");
    
  if(resultForm.Result)
  {
    if(!incorrectPass)
      Log.Error("Ввели не корректний пароль але зайшли у программу");
    else
      Log.Message("Вхід у програму виконаний успішно");
      
  }
  else
  {
    if(!incorrectPass)
    {
      Log.Message("Ввели не корректний пароль та не зайшли у програму");
      if(resultForm.Message == CONST.INCORRECT_PASS_MESSAGE_LOGINFORM)
        Log.Message("Очикуване повідомлення вірне "+resultForm.Message)
      else
        Log.Error("Не коректне повідомлення "+resultForm.Message);
    }
    else
    {
      Log.Error("Ввели коректиний пароль та не зайшли у програму "+resultForm.Message)
    }
  }
}

function run()
{
  LogInTest(true);
}