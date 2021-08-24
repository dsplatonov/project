//
//  main.swift
//  Lesson6
//
//  Created by Дмитрий on 17.08.2021.
//

import Foundation

//Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//Будем реализовывать интернет-магазин по продаже техники и сопутствующих услуг (установка и подключение ПК, например). Техника может быть разной, услуги тоже. Нам необходимо посчитать сумму для оплаты покупателем за устройства и сопутствующие услуги с учётом доставки

protocol Pricible {                             //протокол, которому должны соответствовать все товары
    var price: Double {get set}                 //цена товара
    var totalPrice: Double {get set}            //общая цена с учётом доставки
}

class Devices:Pricible {                        //класс устройств, которые продаёт наш магазин
    var price: Double                           //поле из протокола
    var totalPrice: Double                      //поле из протокола
    var model: String                           //наименование модели
    var deliveryPrice:Double                    //стоимость доставки
    var deliveryAddress:String                  //адрес доставки
    //почти стандартный конструктор с вычислением общей стоимости
    init(price: Double, model: String, deliveryPrice: Double, deliveryAddress: String) {
        self.price=price
        self.model=model
        self.deliveryPrice=deliveryPrice
        self.deliveryAddress=deliveryAddress
        self.totalPrice=price+deliveryPrice
    }
}

class Services:Pricible {                       //класс услуг, которые оказывает наша компания
    var price: Double                           //поле из протокола
    var totalPrice: Double                      //поле из протокола
    let serviceDescription: String              //описание услуги
    let amountOfWorkers: Int                    //количество людей, которые будут выполнять услугу
    //стандартный конструктор
    init(price:Double, serviceDescription: String, amountOfWorkers: Int) {
        self.price=price
        self.totalPrice=price
        self.serviceDescription=serviceDescription
        self.amountOfWorkers=amountOfWorkers
    }
    
}
//дженерик со структурой queue, которая дополнительно подсчитывает общую стоимость всех товаров или услуг соответствующего класса
struct Queue<T: Pricible> {
    var elements: [T]=[]                //объявляем массив элементов Т
    mutating func push (element:T){     //новый элемент добавляем в начало queue
        elements.insert(element, at: 0)
    }
    mutating func pull()-> T? {         //забираем элемент с конца очереди
        return elements.removeLast()
    }
    var totalCostForCustomer: Double {  //считаем общую сумму всех товаров или услуг (складываем total cost по каждому экземпляру
        var totalCost: Double = 0.0
        for element in elements {
            totalCost+=element.totalPrice
        }
        return totalCost
    }
    
}

//создаём 2 тестовые очереди

var orderForDevices = Queue<Devices>()      //очередь с заказом на устройства
var orderForServices = Queue<Services>()    //очередь с заказом на услуги

var realTotalCostForCustomer: Double        //объявляем переменную, в которой сохраним итоговую сумму заказа для покупателя
//добавляем в заказ 3 устройства и 1 услугу
orderForDevices.push(element: Devices(price: 100.4, model: "Apple macbook pro", deliveryPrice: 10, deliveryAddress: "Moscow, Kremlin"))
orderForDevices.push(element: Devices(price: 200.1, model: "Asus ROG", deliveryPrice: 10, deliveryAddress: "Moscow, Kremlin"))
orderForDevices.push(element: Devices(price: 50.5, model: "Printer Epson", deliveryPrice: 5, deliveryAddress: "Moscow, Kremlin"))
orderForServices.push(element: Services(price: 50, serviceDescription: "Установка и подключение 2-х компьютеров и принтера", amountOfWorkers: 1))

//считаем финальную стоимость через функцию, описанную в дженерике

realTotalCostForCustomer=orderForDevices.totalCostForCustomer+orderForServices.totalCostForCustomer
//выводим общую сумму в консоль
print("Цена за заказ для клиента с учётом доставки составляет \(realTotalCostForCustomer) рублей")

//Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)


extension Queue {
    //добавим фильтр для покупателя, чтобы он мог удалить товары по какому-либо условию predicate (не стал писать в сокращённой форме, так как читать сложно). Пытался удалить из Queue элемент, но он требует соответствие протоколу Equatable. Я сделал классам и структуре соответствие этому протоколу, но xcode по-прежнему ругалась
    func filter(predicate: (Double)->Bool)->[T] {
        var tmpArray:[T]=[]
        for element in elements {
            if predicate(element.price) {
                tmpArray.append(element)
            }
        }
        return tmpArray
    }
    //добавим возможность добавить несколько раз один и тот же товар
    mutating func addMulti(element:T,amount:Int, predicate: (T, Int)->[T]) {    //передаём в функцию элемент, который мы хотим несколько раз добавить, количество раз и замыкание, которое будет собирать массив элементов, который мы затем будем добавлять в queue
        let tmpArray:[T]=predicate(element,amount)                              //объявляем временный массив и передаём ему массив, полученный от замыкания
        for element in tmpArray {                                               //в цикле добавляем каждый элемент в queue
            push(element: element)
        }
    }
}

//замыкание для класса Devices, которое собирает массив из одинаковых элементов
let multi:(Devices, Int)->[Devices] = { (device: Devices, amount: Int) -> [Devices] in
    let tmpArray:[Devices]=Array(repeating: device, count: amount)
    return tmpArray
}

//тестируем массовое добавление одного устройства

orderForDevices.addMulti(element: Devices(price: 150, model: "Chromebook", deliveryPrice: 15, deliveryAddress: "Moscow, Kremlin"), amount: 3, predicate: multi)

//считаем финальную стоимость через функцию, описанную в дженерике

realTotalCostForCustomer=orderForDevices.totalCostForCustomer+orderForServices.totalCostForCustomer
//выводим общую сумму в консоль
print("Цена за заказ для клиента с учётом доставки составляет \(realTotalCostForCustomer) рублей") //цена поменялась из-за добавления 3-х компьютеров Chromebook

//замыкания для тестирования функции filter
//определяем дешёвый товар или услугу, как товар или услуга стоимостью меньше 110 рублей
let cheap:(Double)->Bool = { (element: Double) -> Bool in
    return element < 110
}
//определяем дорогой товар(услуга), как товар(услуга) стоимостью больше либо равным 110 рублей
let expensive:(Double)->Bool = { (element: Double) -> Bool in
    return element >= 110
}

//в переменную запишем массив из дешёвых устройств
var cheapDevices:Array<Devices> = orderForDevices.filter(predicate: cheap)
//в переменную запишем массив из дорогих устройств
var expensiveDevices:Array<Devices> = orderForDevices.filter(predicate: expensive)

//распечатаем результат в консоль
print("Дешёвая техника: ")
for element in cheapDevices {
    print(element.model)
}
print("Дорогая техника: ")
for element in expensiveDevices {
    print(element.model)
}

//*Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
//Если будет обращаться к существующему индексу, то отобразим сообщение, что индекс является корректным

//делаем расширение дженерика
extension Queue {
    subscript(index: Int) -> String? {  //индекс будет входным параметром, опциональная строка выходным (опциональная, так как может быть nil
        var i:Int = -1                  //объявляем временную переменную, которая будет отображать текущий индекс массива
        for _ in elements {             //перебираем элементы массива и считаем его индекс
            i+=1                        //если есть хотя бы один элемент, то i станет равным нулю, что является первым элементом в массиве в мире программирования
            if index==i {               //если вдруг переданный в subscript индекс на проверку станет равным i, то есть индекс действительно существует, то возвращаем строку, где пишем, что индекс найден и он корректный
                return "\(index) is a correct index"
            }
        }
        return nil                      //если массив пустой или индекс является не корректным, то возвращаем nil, как это требуется по условиям задачи
    }
}
//проверяем, сейчас в массиве orderForDevices 6 элементов, то есть есть 6 элементо на местах 0-5
let indexForExample:Int = 8 //должен вернуть nil

if let message=orderForDevices[indexForExample] { //если subscript возвращает не nil, то печатаем сообщение с принудительным развёртыванием
    print(orderForDevices[indexForExample]!)
} else {                                          //если subscript возвращает nil, то печатаем nil естественно без развёртывания
    print(orderForDevices[indexForExample])
}
