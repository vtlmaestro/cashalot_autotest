//USEUNIT Objects

//не используется
function MenuName()
{
//  var menuNameDictionary = new ActiveXObject("Scripting.Dictionary");
  var menuNameDictionary = new Objects.Dictionary();

  menuNameDictionary.Add("Відкладені чеки", "Операції");
  menuNameDictionary.Add("Касові документи", "Операції");
  menuNameDictionary.Add("Історія операцій", "Операції");
  menuNameDictionary.Add("Z-звіт", "Звіти");
  menuNameDictionary.Add("Денні звіти", "Звіти");
  menuNameDictionary.Add("Періодичні звіти", "Звіти");
  menuNameDictionary.Add("Про реалізовані товари", "Звіти");
  menuNameDictionary.Add("Надходження товарів", "Склад");
  menuNameDictionary.Add("Переміщення товарів", "Склад");
  menuNameDictionary.Add("Інвентаризація", "Склад");
  menuNameDictionary.Add("Списання товарів", "Склад");
  menuNameDictionary.Add("Заявки на товар", "Склад");
  menuNameDictionary.Add("Залишки по товарам", "Склад");
  menuNameDictionary.Add("Номенклатура", "Довідники");
  menuNameDictionary.Add("Програми лояльності", "Довідники");
  menuNameDictionary.Add("Загальні налаштування", "Налаштування");
  menuNameDictionary.Add("Сервісні операції", "Налаштування");
  menuNameDictionary.Add("Додаткове обладнання", "Налаштування");
  menuNameDictionary.Add("Користувачі", "Налаштування");
  
  return menuNameDictionary;
}
