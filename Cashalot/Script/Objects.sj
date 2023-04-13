﻿//USEUNIT Configurations
//USEUNIT CONST
//USEUNIT Dictinaries
//USEUNIT ObjectTypes
//USEUNIT Types
//USEUNIT Parameters

//-----------------------------------------------------------------------METHODS-----------------------------------------------------------------------------------
function IsNullOrUndefined(object)
{
  if(object==undefined || object==null)
    return true;
  else
    return false;
}

function Receipt(ReceiptViewModel, gridObject)
{
  var grid = gridObject;
  var  VM = ReceiptViewModel;
  
  this.CanSelect = false;
  this.CanDelete = false;
  
  //Сумма оплаты картой
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.CardSumString))
  {
  this.CardSum = VM.ReceiptGrid.DataContext.ReceiptVM.CardSumString.OleValue;
  }
  //Имя кассира
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.CashierName))
  {
    this.CashierName = VM.ReceiptGrid.DataContext.ReceiptVM.CashierName.OleValue;
  }
  //Фискальный номер кассы
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.CashRegisterFiscalNumber))
  {
  this.CashRegisterFiscalNumber = VM.ReceiptGrid.DataContext.ReceiptVM.CashRegisterFiscalNumber.OleValue;
  }
  //Имя кассы
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.CashRegisterName))
  {
  this.CashRegisterName = VM.ReceiptGrid.DataContext.ReceiptVM.CashRegisterName.OleValue;
  }
  //сумма оплаты наличкой
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.CashSumString))
  {
  this.CashSum = VM.ReceiptGrid.DataContext.ReceiptVM.CashSumString.OleValue;
  }
  //Комментарий
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.Comment))
  {
  this.Comment = VM.ReceiptGrid.DataContext.ReceiptVM.Comment.OleValue;
  }
  //Сумма скидки
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.DiscountSum))
  {
  this.DiscountSum = VM.ReceiptGrid.DataContext.ReceiptVM.DiscountSum.OleValue;
  }
  //Статус чека
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.Status))
  {
  this.Status = VM.ReceiptGrid.DataContext.ReceiptVM.Model.Status.OleValue;
  }
  //Локальный номер чека
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.LocalNumber))
  {
  this.LocalNumber = VM.ReceiptGrid.DataContext.ReceiptVM.LocalNumber;
  }
  //Дата формирования
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.OrderDate))
  {
  this.OrderDate = VM.ReceiptGrid.DataContext.ReceiptVM.OrderDate.OleValue;
  }
  //Сумма предоплаты
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.PrepaymentSumString))
  {
  this.PrepaymentSum = VM.ReceiptGrid.DataContext.ReceiptVM.PrepaymentSumString.OleValue;
  }
  //Общая сумма
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.SumToDisplay))
  {
  this.Sum = VM.ReceiptGrid.DataContext.ReceiptVM.SumToDisplay.OleValue;
  }
  //Тип чека
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.Type))
  {
  this.Type = VM.ReceiptGrid.DataContext.ReceiptVM.Type.OleValue;
  }
  //Отобращаемое имя типа чека
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.ViewerName))
  {
  this.ViewerName = VM.ReceiptGrid.DataContext.ReceiptVM.ViewerName.OleValue;
  }
  //Фискальный номер, появляется после фискализации
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.FiscalNumber))
  {
  this.FiscalNumber = VM.ReceiptGrid.DataContext.ReceiptVM.FiscalNumber.OleValue;
  }
  //Статус смены
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.ShiftStatus))
  {
  this.Shift_Status = VM.ReceiptGrid.DataContext.ReceiptVM.ShiftStatus.OleValue;
  }
    //Статус чека
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.CashDocumentStatus))
  {
  this.StatusCheck = VM.ReceiptGrid.DataContext.ReceiptVM.CashDocumentStatus.OleValue;
  }
  //EDRPOU
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.EDRPOU))
  {
  this.EDRPOU = VM.ReceiptGrid.DataContext.ReceiptVM.EDRPOU.OleValue;
  }
  //Найменування операції
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.ParetFNString))
  {
  this.NameParetFN = VM.ReceiptGrid.DataContext.ReceiptVM.ParetFNString.OleValue;
  }
  //TypeName (например Видатковий чек)
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.TypeName))
  {
  this.TypeNameCheck = VM.ReceiptGrid.DataContext.ReceiptVM.TypeName.OleValue;
  }
  //ReceiptName (например ЧЕК СТОРНУВАННЯ)
  if(!Objects.IsNullOrUndefined(VM.ReceiptGrid.DataContext.ReceiptVM.ReceiptName))
  {
  this.ReceiptNameCheck = VM.ReceiptGrid.DataContext.ReceiptVM.ReceiptName.OleValue;
  }
  
  
  if(!Objects.IsNullOrUndefined(gridObject))
  {
    this.CanSelect = true;
//    this.CanDelete = grid.DataContext.DeleteReceiptCommand.CanExecute(VM.ReceiptGrid.DataContext.ReceiptVM);
    
    this.Select = function()
    {
      grid.set_SelectedItem(VM.ReceiptGrid.DataContext.ReceiptVM);
    }
    
//    this.Delete = function()
//    {
//      this.Select();
//      if(this.CanDelete)
//      {
//        Runner.CallObjectMethodAsync(grid.DataContext.DeleteReceiptCommand, "Execute", VM.ReceiptGrid.DataContext.ReceiptVM);
//        var msg = new Objects.MessageBox();
//        msg.Ok();
//      }
//    }
  }
  
  return this;
}


function CheckObject(ReceiptViewModel)
{
  var  VM = ReceiptViewModel;
  
  //Сумма оплаты картой
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.CardSumString))
  {
  this.CardSum = VM.DataContext.ReceiptVM.CardSumString.OleValue;
  }
  //Имя кассира
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.CashierName))
  {
    this.CashierName = VM.DataContext.ReceiptVM.CashierName.OleValue;
  }
  //Фискальный номер кассы
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.CashRegisterFiscalNumber))
  {
  this.CashRegisterFiscalNumber = VM.DataContext.ReceiptVM.CashRegisterFiscalNumber.OleValue;
  }
  //Имя кассы
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.CashRegisterName))
  {
  this.CashRegisterName = VM.DataContext.ReceiptVM.CashRegisterName.OleValue;
  }
  //сумма оплаты наличкой
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.CashSumString))
  {
  this.CashSum = VM.DataContext.ReceiptVM.CashSumString.OleValue;
  }
  //Комментарий
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.Comment))
  {
  this.Comment = VM.DataContext.ReceiptVM.Comment.OleValue;
  }
  //Сумма скидки
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.DiscountSum))
  {
  this.DiscountSum = VM.DataContext.ReceiptVM.DiscountSum.OleValue;
  }
  //Статус чека
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.Status))
  {
  this.Status = VM.DataContext.ReceiptVM.Model.Status.OleValue;
  }
  //Локальный номер чека
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.LocalNumber))
  {
  this.LocalNumber = VM.DataContext.ReceiptVM.LocalNumber;
  }
  //Дата формирования
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.OrderDate))
  {
  this.OrderDate = VM.DataContext.ReceiptVM.OrderDate.OleValue;
  }
  //Сумма предоплаты
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.PrepaymentSumString))
  {
  this.PrepaymentSum = VM.DataContext.ReceiptVM.PrepaymentSumString.OleValue;
  }
  //Общая сумма
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.SumToDisplay))
  {
  this.Sum = VM.DataContext.ReceiptVM.SumToDisplay.OleValue;
  }
  //Тип чека
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.Type))
  {
  this.Type = VM.DataContext.ReceiptVM.Type.OleValue;
  }
  //Отобращаемое имя типа чека
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.ViewerName))
  {
  this.ViewerName = VM.DataContext.ReceiptVM.ViewerName.OleValue;
  }
  //Фискальный номер, появляется после фискализации
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.FiscalNumber))
  {
  this.FiscalNumber = VM.DataContext.ReceiptVM.FiscalNumber.OleValue;
  }
  //Статус смены
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.ShiftStatus))
  {
  this.Shift_Status = VM.DataContext.ReceiptVM.ShiftStatus.OleValue;
  }
    //Статус чека
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.CashDocumentStatus))
  {
  this.StatusCheck = VM.DataContext.ReceiptVM.CashDocumentStatus.OleValue;
  }
  //EDRPOU
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.EDRPOU))
  {
  this.EDRPOU = VM.DataContext.ReceiptVM.EDRPOU.OleValue;
  }
  //Найменування операції
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.ParetFNString))
  {
  this.NameParetFN = VM.DataContext.ReceiptVM.ParetFNString.OleValue;
  }
  //TypeName (например Видатковий чек)
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.TypeName))
  {
  this.TypeNameCheck = VM.DataContext.ReceiptVM.TypeName.OleValue;
  }
  //ReceiptName (например ЧЕК СТОРНУВАННЯ)
  if(!Objects.IsNullOrUndefined(VM.DataContext.ReceiptVM.ReceiptName))
  {
  this.ReceiptNameCheck = VM.DataContext.ReceiptVM.ReceiptName.OleValue;
  }
  
  return this;
}

function CashalotObject(obj)
{
  var _object = obj;
  
  this.Type = ObjectTypes.CASHALOT_OBJECT;
  
  this.GetType = function()
  {
    if(_object.ClrClassName==Types.UC_MAIN_WINDOW)
    {
      if(!Objects.IsNullOrUndefined(_object.DataContext))
      {
        return _object.DataContext.CurrentViewModel.ClrClassName;
      }
    }
    if(_object.ChildCount>0)
      for(var i=0; i<=_object.ChildCount; i++)
        if(!Objects.IsNullOrUndefined(_object.Child(i).DataContext))
          return _object.Child(i).DataContext.ClrClassName;
    else
      return Types.UNDETECT;  
  }
}

function IsNullOrWhiteSpace(object)
{
  if(IsNullOrUndefined(object))
    return true;
  else
  {
    if(object=="" || object==" ")
      return true;
     return false;
  }
}

function GetAllButtonsFromControl(control)
{
  var ctrl = control;
  var btns = new List();
  var grid;
  for(var i=0; i<ctrl.ChildCount; i++)
  {
    var child = ctrl.Child(i);
    if(child.ChildCount>0)
    {
      btns.Add(GetAllButtonsFromControl(child));
    }
    else
    {
      if(child.ClrClassName=="Button")
        btns.Add(child);
    }
  }
  return btns;
}

function GetAllTextBoxFromControl(control)
{
  var ctrl = control;
}

function updatePeriod(startPeriod, endPeriod)
{
var perPicker = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.DockPanel.PeriodPicker;
perPicker.set_StartPeriod(startPeriod);
perPicker.set_EndPeriod(endPeriod);
}

function updatePeriodReportPrepare(startPeriod, endPeriod)
{
var perPicker = Aliases.CashaLot.HwndSource_WindowDialog3.WindowDialog.UCPeriodicalReportPrepare.Periodpicker;
perPicker.set_StartPeriod(startPeriod);
perPicker.set_EndPeriod(endPeriod);
}

function updatePeriodSoldGoods(startPeriod, endPeriod)
{
var perPicker = Aliases.CashaLot.HwndSource_WindowDialog4.WindowDialog.UCReportGoodsPrepare.Periodpicker;
perPicker.set_StartPeriod(startPeriod);
perPicker.set_EndPeriod(endPeriod);
}

//-----------------------------------------------------------------------CLASSES------------------------------------------------------------------------------------
function ComboBox(cmdObject)
{
  this.Obj = cmdObject;
  this.Items = new List();
  this.SelectedItem = null;
  this.ClrItemClassName = null;
  this.GetItemByName = null;
  
  //loadItems
  for(var i=0; i<this.Obj.Items.Count; i++)
  {
    this.ClrItemClassName = this.Obj.Items.get_Item(i).ClrClassName;
    this.Items.Add(this.Obj.Items.get_Item(i));
  }
  
  this.SelectedItem = this.Obj.SelectedItem;
  
  this.SelectItem = function(item)
  {
    this.Obj.set_SelectedItem(item);
  }
  
  if(this.ClrItemClassName == Types.NAME_VIEW_MODEL)
  {
    this.GetItemByName = function(name)
    {
      for(var i=0; i<this.Items.Count; i++)
      {
        if(aqString.ToUpper(this.Items.GetValue(i).Name.OleValue)==aqString.ToUpper(name))
          return this.Items.GetValue(i);
      }
    }
  }
  return this;
}

function ProxySetting(address, port, setting_type)
{
  this.Address = address;
  this.Port = port;
  this.Type = setting_type;
  
  return this;
}

function Button(btnObject)
{

  this.Obj = btnObject;
  this.BtnText = null;
  this.ClickBtn = function()
  {
    this.Obj.ClickButton();
  }
  return this;
}

function DialogResult()
{
  this.Message;
  this.Result;
  
  return this;
}

function MessageBox(msgObject)
{
  if(Objects.IsNullOrUndefined(msgObject))
  {
    while(!Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow.Exists)
    {
     aqUtils.Delay(100);
     if(Aliases.CashaLot.HwndSource_CustomMessageBoxWindow2.CustomMessageBoxWindow.Exists)
     {
       msgObject = Aliases.CashaLot.HwndSource_CustomMessageBoxWindow2.CustomMessageBoxWindow;
       break;
     }  
    }
      
    msgObject = (IsNullOrUndefined(msgObject))?Aliases.CashaLot.HwndSource_CustomMessageBoxWindow.CustomMessageBoxWindow:msgObject;
  }
  this.Obj = msgObject;
  this.BoolValue = null;
  this.Text = null;
  //Buttons
  var OkButton = null;
  var CancelButton = null;
  
  var textBlockElements = msgObject.FindAllChildren("ClrClassName", "TextBlock", 10).toArray();
  var buttonsElements = msgObject.FindAllChildren("ClrClassName", "Button", 10).toArray();
  
  this.BaseHandler = function()
  {
    this.Ok();
  }
  
  //Получаем текстовку мсгбокса
  for(var i=0; i<textBlockElements.length; i++)
  {
    if(!IsNullOrWhiteSpace(textBlockElements[i].Text.OleValue))
    {
      this.Text = textBlockElements[i].Text.OleValue;
    }
  }
  
  //получаем кнопки
  for (var i=0; i<buttonsElements.length; i++)
  {
    try
    {
    if(buttonsElements[i].Content.ClrClassName=="Label" && buttonsElements[i].Visible)
    {
      for(var j=0; j<Dictinaries.ACCEPT_BTNS_WORDS.length; j++)
      {
        if(aqString.ToUpper(Dictinaries.ACCEPT_BTNS_WORDS[j])==aqString.ToUpper(aqString.Replace(buttonsElements[i].Content.Content.OleValue, "_","")))
          OkButton = buttonsElements[i];
      }
    }
    }
    catch(e)
    {
      Log.Message(e);
    }
  }
  
  this.Ok = function()
  {
    OkButton.Click();
  }
  
  return this;
}

function TextBox(txtBoxObject)
{
  this.Obj = txtBoxObject;
  this.Text = null;
  
  //Function Set a new text into TextBox 
  this.SetText = null;
  
  return this;
}

function List()
{
  var list = new Array();
  this.Count = 0;
  
  //Добавление элемента в коллекцию
  this.Add = function(item){
    list.push(item);
    this.Count++;
  }
  this.GetValue = function (index)
  {
    return list[index];
  }
  this.AddRange = function(array)
  {
    for(var i=0; i<array.length; i++)
    {
      list.push(array[i]);
      this.Count++;
    }
  }
  //Проверка на наличие элемента в коллекции
  this.Contains = function(item)
  {
    for(var i=0; i< this.Count; i++)
    {
      if(list[i]==item)
        return true;
    }
    return false;
  }
  //Очистка коллекции
  this.Clear = function()
  {
    list = new Array();
    this.Count=0;
  }
  
  return this;
}

function Dictionary()
{
  var dictionary = new ActiveXObject("Scripting.Dictionary");
  this.Count = 0;
  this.GetValue = function(item)
  {
    try
    {
      return dictionary.Item(item);
    }
    catch(e)
    {
      return null;
    }
  }
  this.GetValues = function()
  {
    try
    {
      return dictionary.Items().toArray();
    }
    catch(e)
    {
      return null;
    }
  }
  this.Clear = function()
  {
    dictionary = new ActiveXObject("Scripting.Dictionary");
    this.Count = 0;
  }
  this.GetKeys = function()
  {
    return dictionary.Keys().toArray();
  }
  this.Contains = function(item)
  {
    for(var i =0; i< this.Count; i++)
    {
      if(dictionary.Keys().toArray()[i]==item)
      {
        return true;
      }
    }
    return false;
  }
  this.Add = function(item0, item1)
  {
    try
    {
      dictionary.Add(item0, item1);
      this.Count++;
    }
    catch(e)
    {
      Log.Error(aqString.Format("Error function add to dictionary %s - %s ", item0, item1)+e.description);
    }
  }
  return this;
}

function Shift(ShiftItem)
{
  if(!IsNullOrUndefined(ShiftItem))
  {
    this.Name = ShiftItem.Content.RROName.OleValue;
    this.FiscalNumber = ShiftItem.Content.FiscalNumber.OleValue;
    this.IsOpened = ShiftItem.Content.IsShiftOpened;
    this.BtnOpen = ShiftItem.FindAllChildren("ClrClassname", "Button", 10).toArray()[0];
    this.Open = function()
    {
      this.BtnOpen.Click();
    }
  }
  this.Name;
  this.FiscalNumber;
  this.IsOpened;
  this.BtnOpen;
  this.Open;
  
  return this;
}

function objTest(objTestStep)
{
  this.testStep = objTestStep;
  
}

//Вікно Про програму, отримати версію Cashalot
function AboutProgramm()
{
  var infoBtn = Aliases.CashaLot.HwndSource_mainWindow.mainWindow_.InfoBtn;
  var gridAboutProgramm = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Grid.DialogPresenter.Grid;
  var aboutProgramBtn = Aliases.CashaLot.HwndSource_PopupRoot3.PopupRoot.NonLogicalAdornerDecorator.StackPanel.Button;
  var CloseBtn = Aliases.CashaLot.HwndSource_WindowDialog.WindowDialog.Border.Grid.DialogPresenter.Grid.ButtonO;
  
  this.ClickInfoBtn = function()
  {
    infoBtn.Click();
  }
  
  this.ClickAboutProgram = function()
  {
    aboutProgramBtn.Click();
  }
  
  this.GetVersion = function()
  {
    return gridAboutProgramm.txblVersion.Text.OleValue;
  }
  
  this.CloseAboutProgram = function()
  {
    CloseBtn.Click();
  }
}

function ResultRunMethod()
{
  this.BoolValue;
  this.TextValue;
  return this;
}

function EnterpriseInfo()
{
  this.BoolValue;
  this.EnterpriseName;
  this.EnterpriseIPN;
  this.EnterpriseEDRPOU;
  return this;
}

function GOInfo()
{
  this.BoolValue;
  this.GOName;
  this.GOAddress;
  this.GOTelephone;
  this.GOEmail;
  return this;
}

function PRROInfo()
{
  this.BoolValue;
  this.PrroName;
  this.FiscalNum;
  this.PrroAddress;
  this.PrroLicense;
  return this;
}

function UserCashalot()
{
  this.BoolValue;
  this.IsCurrentUserBoolValue;
  this.IsUserActiveBoolValue;
  this.Email;
  this.Comment;
  this.IPN;
  this.Login;
  this.Name;
  this.Telephone;
  this.Position;
  return this;
}





















