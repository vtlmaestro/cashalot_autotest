//USEUNIT UtilsCashalot

//Имя пользователя по умолчанию
var USERCERTNAME = "Автотест Старший Касир(Старший касир)";
//var USERCERTNAME = "Директор Арнольд Иванович(Директор)";
//Пароль сертификата по умолчанию
var USERCERTPASSWORD = "111";

//Путь к каталогу с сертификатами и ключами по умолчанию
var USERCERTPATH = "Рабочий стол|Cashalot Autotest Keys";

//Value properties
var NAMEUSER = "Автотест С. К.";
var NAMECASHIER = "Автотест С. К.";
var NAMEPRRO6 = "ПРРО №6";
var GONAME = "Магазин \"Автотести\"";
var GONAMEandADDRESS = "Магазин \"Автотести\" (УКРАЇНА, м. Київ, вул. Тестова, 24)";
var NAMEPRRO3 = "ПРРО №3";
var NAMEPRRO4 = "ПРРО №4";
var NAMEPRRO1 = "ПРРО №1";
var NAMEPRRO23 = "ПРРО №23";
var NAMECASHDOCUMENTS = "Службова видача";
var TYPEPAY_CASH = "Готівка";
var TYPEPAY_ALL = "Всі види";
var METHODPAY = "Передоплата";
var NUMBERCHECK = "1203";
var NAMEPRODUCTGROUP = "Ломбардні операції";
var NAMEZZVIT = "zZvit";
var SUM = "500";
var SUM700 = "700";
var USERCOMMECT = "Коментар";
var ENTER = "[Enter]";
var PATHDBORIG = "C:\\ProgramData\\Cashalot\\Cashalot\\cash.lot";
var PATHDBCOPY = "C:\\ProgramData\\Cashalot\\Cashalot\\cashCopy.lot";
var OFFICPAYMENT = "Службове внесення";
var OFFICGIVING = "Службова видача";
var REGISTERED = "Зареєстровано";
var CHECKSTORNO = "ЧЕК СТОРНУВАННЯ";
var CUSTOMER = "Сідоров П.Р.";
var PASSPORT = "Паспорт";
var INFOPASSPORT = "Видано 12.12.2012 Бориспільським УМВС у Київській області";
var TEXTMESSBZZVITCLOSE = "Z-звіт (закриття зміни)";
var SYNCSESSIONNOTFOUND = "Сесію синхронізації не знайдено. Спробуйте ще раз.";
var IPADDRESS = "198.197.196.195";
var WRONGPORT = "1111";

//Способи оплати
var PAYWITHOUTREMAIN = "Оплата без решти";
var DISCOUNT = "Знижка";
var PAYMENTCASH = "Оплата готівкою";
var PAYMENTCARD = "Оплата карткою";
var COMBINEDPAYMENT = "Комбінована оплата";


var OPENSHIFT = "Зміна відкрита";
var DOCSUCCESSAVE = "Документ успішно збережено";
var CHECKSUCCESS = "Перевірка пройшла успішно";
var ERRORDESCRIPTION = "Опис помилки";
var LOADSUCCESS = "Завантаження завершено успішно";
var SYNCSUCCESS = "Синхронізація успішна!";

//Статус чека
var STATUSCHECK = "Fiscalised";

//Формування ім'я лог-файлу
var NAMELOGFILE = Project.Path+"\\Log\\"+dotNET.System.DateTime.Now().ToShortDateString()+"-";
var TCMLOG = ".TCMLog";

var DATENOW = dotNET.System.DateTime.Now().ToShortDateString().OleValue;
var DATENOWMINUSMONTH = aqConvert.DateTimeToStr(dotNET.System.DateTime.Now().AddMonths(-1).Date.Date.OleValue);

var TOTALSUM = "Загальна сума";
var REPORTSOLDGOODS = "Звіт про реалізовані товари";
var NOCONNECTIONWITHFSKO = "Відсутній зв'язок з сервером ФСКО.";
var ALARMNONCONNECTFSKO = "Увага. Відсутній зв'язок з ФСКО. Програму переведено в режим «офлайн».";
var ZZVITDOCPRINT = "Z - звіт";
var SUCCESSREGISTERED = "Успішно зареєстровано!";
var ERRORCONNECTBACKOFFICE = "Помилка з'єднання з бекофисом";

//довідники, створення товару
var NAMEPRODUCT = "product";
var VENDORCODE = "8787";
var NAMEUNIT = "0301";
var DKPPCODE = "10.51.5";
var VENDORCODE8989 = "8989";
var CODEUKTZED = "0402291100";
var NAMEGOOD = "Молоко спеціального призначення";
var NAMEPRODUCTGROUPOTHER = "Інше";
var TYPEGOODS = "Товар";
var SCROLLVIEWERPRICE = "Ціна";
var MARKUP = "150";
var SCROLLVIEWERTAXRATE = "Ставка податку";
var SCROLLVIEWERKIT = "Комплект (набір)";
var SCROLLVIEWERADDITIONALDATA = "Додаткові дані";
var SCROLLVIEWERWAREHOUSE = "Склад";
var TAXRATEPDV20 = "ПДВ А=20%";
var TAXRATEAKSIZ5 = "Акциз Д=5%";
var TAXRATEPF = "ПФ П=7,5%";
var TAXNORATEPF = "ПФ =Без ставки";
var TAXNORATEPDV = "ПДВ =Без ставки";
var TAXNORATEACSIZ = "Акциз =Без ставки";
var DELETEMESSAGE = "Видалення товару";
//var PATHIMPEXPFILE = "C:\\Users\\Vitaliy.Miniailo\\Desktop\\Шаблон для імпорту.xlsx";
var PATHIMPEXPFILE = "C:\\Users\\User1\\Шаблон для імпорту.xlsx";
//var RESIMPORT = "невдача"; 
var RESIMPORT = "Імпорт завершено";
//var DIRECTORYFOREXPORT = "C:\\Users\\Vitaliy.Miniailo\\Desktop";
var DIRECTORYFOREXPORT = "C:\\Users\\User1";

//розділ Налаштування
var BUSINESSUNIT = "Господарська одиниця";
var PRRO = "ПРРО";
var PROXYSERVER = "Проксі сервер";
var SETTINGPROXYSAVESUCCESS = "Налаштування проксі-серверу успішно збережено!";
var NOUSEPROXY = "1";
var USESYSTEMPROXY = "2";
var NAMEENTERPRISE = "Автотест Кашалот Операції";
var IPNENTERRPISE = "170320007777";
var EDRPOUENTERPRISE = "17032000";
var MAILADDRESS = "zvit33333@ukr.net";
var MAILSERVER = "smtp.ukr.net";
var MAILPORT = "465";
var MAILNAME = "zvit33333@ukr.net";
var MAILPASS = "mkhJ2IasUnu43gcd";
var CHECKMAILSUCCESS = "Перевірку з’єднання з сервером вихідної пошти виконано успішно";
var FAILEDAUTHENTICATION = "Невдала аутентифікація";
var WRONGPASSWORD = UtilsCashalot.GetRandomNum("999999999");
var FISCALNAMBER = "4000019023";
var KASIR = "Касир";
var IPN = "1703200071";
var PRINTER = "PrintSettings";
var POSTERMINAL = "POSTerminalSettings";
var SCALES = "ScalesSetting";
var ONENOTE = "OneNote for Windows 10";
var XPS = "Microsoft XPS Document Writer";
var PRINTTOPDF = "Microsoft Print to PDF";
var FAX = "Fax";
var ALREADYUSE = " вже було встановлено за замовчуванням";
var PRINUSE = " успішно встановлено за замовчанням";
var NOTSET = "Не задано";
var PRIVATUSB = "ПриватБанк (USB)";
var PRIVATLAN = "ПриватБанк (LAN)";
var PRINTEKUSBCOM = "Принтек (USB/COM)";
var PRINTEKLAN = "Принтек (LAN)";
var PATHDRIVER = "C:\\DriverPrivat";
var DRIVERUSBEXE = "C:\\DriverPrivat\\genericDriverJsonUSB.exe"
var ADDRESSDRIVER = "localhost";
var PORTDRIVER = "3000";
var SAVESUCCESSPOSTERMINAL = "Налаштування POS-терміналу успішно збережено!";
var NOTCONNECTPOSTERMINAL = "Не вдалося з'єднатися з POS-терміналом, перевірте налаштування";
var SAVESACCESSCALES = "Налаштування ваг успішно збережено";
var COMPORT = "COM4";
var UNIPROCOM = "UniPro (COM)";
var PATHDRIVERSCALES = "C:\\uniscalesdriver";
var DRIVERSCALES = "C:\\uniscalesdriver\\UniScalesDriver.exe";
var SHOPINGSCALES = "BTA-60/..-5, BTA-60/..-5-A, BTA-60/..-6-A (Торгові ваги)";
var SCALESWITHCRISTALINDICATOR = "BH-..-A-PK, BH-..-1D-A-PK (Блоки ВН- з рідинно-кристалічним індикатором)";
var SCALESWITHLEDINDICATOR = "BH-..-A-CI, BH-..-1D-A-CI, BH-..- 220B (Блоки ВН- зі світлодіодним індикатором)";


















