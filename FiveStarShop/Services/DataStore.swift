//
//  DataStore.swift
//  FiveStarShop
//
//  Created by Асанкул Садыков on 27/7/22.
//

import Foundation

class DataStore {
    
    static let shared = DataStore()
    
    let products: [Product] = [
        Product(
            article: "EL0001",
            company: "Vitek",
            model: "Электрочайник",
            description: """
                        Особенности вращение на 360 градусов, индикатор уровня воды, дисплей
                        Возможность выбора температуры есть
                        Минимальная температура нагрева 60 °C
                        Количество температурных режимов 5
                        Материал корпуса металл
                        Материал колбы металл
                        Длина сетевого шнура 0.8 м
                        """,
            price: 1500
        ),
        Product(
            article: "DU0001",
            company: "LG",
            model: "Духовка",
            description: """
                        Духовка электрическая независимая
                        Объём 58 л
                        Энергопотребление класс A, мощность подключения 3.10 кВт
                        Размеры (ВхШхГ) 60 х 59.6 x 60 см
                        """,
            price: 4000
        ),
        Product(
            article: "TV0001",
            company: "Samsung",
            model: "Телевизор",
            description: """
                        Тип LED
                        HD-формат 4K Ultra HD
                        Формат экрана 16:9
                        Контрастность 5000:1
                        Яркость 300 кд/м²
                        Угол обзора 178/178
                        Диагональ экрана 50 "
                        Разрешение 3840x2160
                        Изогнутый экран Нет
                        Тип LED-подсветки Direct LED
                        Частота обновления 60 Гц
                        Мощность звука 16 Вт
                        Smart TV Да
                        Операционная система телевизора VIDAA
                        Год выпуска модели 2021
                        """,
            price: 25000
        ),
        Product(
            article: "CD0001",
            company: "Gree",
            model: "Кондиционер",
            description: """
                        Тип настенная сплит-система
                        Инвертор (плавная регулировка мощности) есть
                        Максимальная длина коммуникаций 20 м
                        Класс энергопотребления A+
                        Основные режимы охлаждение / обогрев
                        Максимальный воздушный поток 9.17 куб. м/мин
                        Мощность в режиме охлаждения 3200 Вт
                        Мощность в режиме обогрева 3300 Вт
                        Потребляемая мощность при обогреве 1000 Вт
                        Потребляемая мощность при охлаждении 995 Вт
                        Режим приточной вентиляции нет
                        Дополнительные режимы режим вентиляции (без охлаждения и обогрева), автоматическое поддержание температуры, самодиагностика неисправностей, ночной режим
                        Режим осушения есть
                        """,
            price: 35000
        ),
        Product(
            article: "VI0001",
            company: "Gefest",
            model: "Вытяжка",
            description: """
                        Вытяжка GEFEST ВО 1602 К17- воздухоочиститель электрический бытовой.
                        Эффективно помогает снизить загрязнение стен, потолков и мебели жировыми частицами, сажей, копотью в процессе приготовления пищи.
                        Он относится к приборам, работающим под надзором, и эксплуатируется как в вытяжном режиме, так и в циркуляционном (очищенный воздух возвращается в помещение кухни).
                        Внутри короба воздухоочистителя располагаются вентилятор и узел подсветки.
                        Снизу короб закрывается металлическим фильтром.
                        На передней поверхности короба расположены кнопки управления работой воздухоочистителя.
                        В верхней полости короба воздухоочистителя находится фланец для отвода очищенного воздуха.
                        """,
            price: 7000
        ),
        Product(
            article: "PY0001",
            company: "Philips",
            model: "Пылесос",
            description: """
                        Мощный пылесос PHILIPS FC 9170 - самая высокая всасывающая мощность
                        Всасывающая мощность 500 Вт обеспечивает уборку без усилий
                        2200 Вт
                        Мощность всасывания 500 Вт
                        Моющийся фильтр HEPA 13
                        """,
            price: 8000
        ),
        Product(
            article: "FN0001",
            company: "Vitek",
            model: "Фен",
            description: """
                        Тип фен
                        Мощность 2000 Вт
                        Функции ионизация, подача холодного воздуха
                        Количество режимов 3
                        """,
            price: 1000
        ),
        Product(
            article: "UT0001",
            company: "RuJia",
            model: "Утюг",
            description: """
                        Мощность 2200 Вт
                        Подошва керамика
                        Функции постоянная подача пара
                        Регулировка подачи пара есть
                        Функция разбрызгивания есть
                        """,
            price: 1700
        ),
        Product(
            article: "BL0001",
            company: "LG",
            model: "Блендер",
            description: """
                        Тип cтационарный
                        Максимальная мощность 600 Вт
                        Управление механическое, число скоростей: 1
                        """,
            price: 4000
        ),
        Product(
            article: "RU0001",
            company: "Cat",
            model: "Рубанок",
            description: """
                        Напряжение сети, В: 220±10%
                        Частота, Гц: 50
                        Потребляемая мощность, Вт: 900
                        Частота оборотов на холостом ходу, об/мин: 16000
                        Ширина строгания, мм: 82
                        Глубина строгания, мм: 0-3
                        Размеры лезвия, мм: 82 х 5,8 х 1,3
                        Выборка четверти, мм: 0-15,5
                        Длина сетевого кабеля, м: 2
                        """,
            price: 6800
        )
    ]
    
    let users: [User] = [
        User(userId: "Dim", login: "Dim", name: "Dmitry"),
        User(userId: "EgrLdk", login: "EgrLdk", name: "Egor")
    ]
    
//    let orders: [Order] = [
//        Order(
//            userId: "EgrLdk",
//            id: 1,
//            date: "01.06.22",
//            carts: Cart.getCartGoods(DataStore.shared.products )
//        )
//        Order(
//            userId: "EgrLdk",
//            id: 2,
//            date: "12.07.22",
//            carts: [
//                Cart(product: DataStore.shared.products[9], count: 2),
//                Cart(product: DataStore.shared.products[7], count: 1),
//                Cart(product: DataStore.shared.products[2], count: 1)
//                ]
//        ),
//        Order(
//            userId: "EgrLdk",
//            id: 3,
//            date: "12.07.22",
//            carts: [
//                Cart(product: DataStore.shared.products[3], count: 1),
//                Cart(product: DataStore.shared.products[5], count: 1),
//                Cart(product: DataStore.shared.products[4], count: 2),
//                Cart(product: DataStore.shared.products[0], count: 1),
//                ]
//        ),
//        Order(
//            userId: "Dim",
//            id: 1,
//            date: "29.05.22",
//            carts: [
//                Cart(product: DataStore.shared.products[3], count: 2),
//                Cart(product: DataStore.shared.products[5], count: 1),
//                Cart(product: DataStore.shared.products[2], count: 1),
//                Cart(product: DataStore.shared.products[7], count: 1),
//                Cart(product: DataStore.shared.products[0], count: 2),
//                Cart(product: DataStore.shared.products[4], count: 1)
//                ]
//        ),
//        Order(
//            userId: "Dim",
//            id: 2,
//            date: "13.06.22",
//            carts: [
//                Cart(product: DataStore.shared.products[1], count: 1),
//                Cart(product: DataStore.shared.products[8], count: 3),
//
//                ]
//        )
//    ]
    
    private init() {}
}
