﻿
Процедура Печать(ТабДок, Ссылка) Экспорт
	//{{_КОНСТРУКТОР_ПЕЧАТИ(Печать)
	Макет = Документы.Карточка.ПолучитьМакет("Карточка");
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	Карточка.Email,
	|	Карточка.Адрес,
	|	Карточка.Дата,
	|	Карточка.ДатаРождения,
	|	Карточка.ЖалобыПациента,
	|	Карточка.НомерТелефона,
	|	Карточка.ФИО,
	|	Карточка.ОказанныеУслуги.(
	|		НомерСтроки,
	|		Услуга,
	|		Цена
	|	)
	|ИЗ
	|	Документ.Карточка КАК Карточка
	|ГДЕ
	|	Карточка.Ссылка В (&Ссылка)";
	Запрос.Параметры.Вставить("Ссылка", Ссылка);
	Выборка = Запрос.Выполнить().Выбрать();

	ОбластьЗаголовок = Макет.ПолучитьОбласть("Заголовок");
	Шапка = Макет.ПолучитьОбласть("Шапка");
	ОбластьОказанныеУслугиШапка = Макет.ПолучитьОбласть("ОказанныеУслугиШапка");
	ОбластьОказанныеУслуги = Макет.ПолучитьОбласть("ОказанныеУслуги");
	Подвал = Макет.ПолучитьОбласть("Подвал");

	ТабДок.Очистить();

	ВставлятьРазделительСтраниц = Ложь;
	Пока Выборка.Следующий() Цикл
		Если ВставлятьРазделительСтраниц Тогда
			ТабДок.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;

		ТабДок.Вывести(ОбластьЗаголовок);

		Шапка.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Шапка, Выборка.Уровень());

		ТабДок.Вывести(ОбластьОказанныеУслугиШапка);
		ВыборкаОказанныеУслуги = Выборка.ОказанныеУслуги.Выбрать();
		Пока ВыборкаОказанныеУслуги.Следующий() Цикл
			ОбластьОказанныеУслуги.Параметры.Заполнить(ВыборкаОказанныеУслуги);
			ТабДок.Вывести(ОбластьОказанныеУслуги, ВыборкаОказанныеУслуги.Уровень());
		КонецЦикла;

		Подвал.Параметры.Заполнить(Выборка);
		ТабДок.Вывести(Подвал);

		ВставлятьРазделительСтраниц = Истина;
	КонецЦикла;
	//}}
КонецПроцедуры
