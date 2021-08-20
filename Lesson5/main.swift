//
//  main.swift
//  Lesson5
//
//  Created by Дмитрий on 13.08.2021.
//

import Foundation

//делаем перечисление для свойств машин

enum windowState { //перечисление состояний окон
    case open, close
}

enum engineState { //перечисление состояний работы двигателя
    case start, stop
}

enum doorState {//перечисление состояний дверей
    case open, close
}

//Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.

protocol Car {
    var numberOfWheels: Int {get set}   //количество колёс
    var color: String {get set}         //цвет
    var windows:windowState {get set}   //состояние окон
    var engine:engineState {get set}    //состояние работы двигателя
    var doors:doorState {get set}       //состояние дверей
    mutating func openWindows()         //функция, позволяющая открыть двери
    mutating func closeWindows()        //функция, позволяющая закрыть двери
    mutating func startEngine()         //функция, запускающая двигатель
    mutating func stopEngine()          //функция, останавливающая двигатель
    mutating func openCar()             //функция, открывающая двери в машине
    mutating func closeCar()            //функция, закрывающая двери в машине
    func getColor()-> String            //функция, возвращающая цвет машины (понимаю, что можно и без такой функции, но другой я не придумал
    func getNumberOfWheels() -> Int     //функция, возвращающая количество колёс
}

//Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).

extension Car {
    mutating func openWindows(){        //реализовываем функцию открывания окон
        self.windows = .open            //меняем статус окон
        print("Окна открылись ")        //выводим сообщение в консоль
    }
    mutating func closeWindows(){       //реализовываем функцию закрывания окон
        self.windows = .close           //меняем статус окон
        print("Окна закрылись ")        //выводим сообщение в консоль
    }
    mutating func startEngine(){        //реализовываем функцию, запускающую двигатель
        self.engine = .start            //меняем статус двигателя
        print("Двигатель стартовал ")   //выводим сообщение в консоль
    }
    mutating func stopEngine(){         //реализовываем функцию, останавливающую двигатель
        self.engine = .stop             //меняем статус двигателя
        print("Двигатель остановлен ")  //выводим сообщением в консоль
    }
    mutating func openCar(){            //реализовываем функцию, которая открывает двери машины
        self.doors = .open              //меняем статус дверей
        print("Машина открылась ")      //выводим сообщение в консоль
    }
    mutating func closeCar(){           //реализовываем функцию, которая закрывает двери машины
        self.doors = .close             //меняем статус дверей
        print("Машина закрылась")       //выводим сообщение в консоль
    }
    func getColor()-> String {          //реализовываем функцию, возвращающую цвет машины
        return self.color               //возвращаем цвет машины
    }
    func getNumberOfWheels() -> Int {   //реализовываем функцию, возвращающую количество колёс
        return self.numberOfWheels      //возвращаем количество колёс
    }
}

//Создать два класса, имплементирующих протокол «Car»: tunkCar и sportCar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.

class trunkCar:Car {
    //свойства всех машин
    var numberOfWheels: Int
    var color: String
    var windows: windowState
    var engine: engineState
    var doors: doorState
    
    //свойства цистерны

    var trunkVolume: Int //объём цистерны
    var tubeLength:Int   //длина шланга
    
    //делаем стандартный конструктор
    init(numberOfWheels:Int, color:String, windows:windowState, engine:engineState, doors:doorState, trunkVolume:Int, tubeLength:Int){
        self.numberOfWheels=numberOfWheels
        self.color=color
        self.windows=windows
        self.engine=engine
        self.doors=doors
        self.trunkVolume=trunkVolume
        self.tubeLength=tubeLength
    }
}

enum nitroOxideState {//перечисление вариантов режимов использования оксида азота в машине (необходимо для спортивной машины)
    case on, off
}

class sportCar:Car {
    //свойства всех машин
    
    var numberOfWheels: Int
    var color: String
    var windows: windowState
    var engine: engineState
    var doors: doorState
    
    //свойства спортивной машины
    
    var maxSpeed:Int                    //максимальная скорость
    var acceleration: nitroOxideState   //включено ли ускорение с помощью оксида азота
    
    //стандартный конструктор
    
    init(numberofWheels:Int, color:String, windows:windowState, engine:engineState, doors:doorState, maxSpeed:Int, acceleration:nitroOxideState){
        
        self.numberOfWheels=numberofWheels
        self.color=color
        self.windows=windows
        self.engine=engine
        self.doors=doors
        self.maxSpeed=maxSpeed
        self.acceleration=acceleration
    }
    
}

//Для каждого класса написать расширение, имплементирующее протокол «CustomStringConvertible».

//И чтобы выполнить условие домашнего задания по выводу всего объекта в консоль, распишу все характеристики объекта в расширении

//расширение класса грузовой машины

extension trunkCar:CustomStringConvertible {
    var description: String {
        return "Trunk car have the following characteristics:\n number of wheels - \(self.numberOfWheels)\n color - \(self.color)\n state of the windows - \(self.windows)\n state of the engine - \(self.engine)\n state of the doors - \(self.doors)\n trunk volume - \(self.trunkVolume)\n tube length - \(self.tubeLength)"
    }
}

//расширение класса спортивной машины

extension sportCar:CustomStringConvertible {
    var description: String {
        return "Sportcar have the following characteristics:\n number of wheels - \(self.numberOfWheels)\n color - \(self.color)\n state of the windows - \(self.windows)\n state of the engine - \(self.engine)\n state of the doors - \(self.doors)\n maximum speed - \(self.maxSpeed)\n can use acceleration - \(self.acceleration)"
    }
}

//Создать несколько объектов каждого класса. Применить к ним различные действия.
//Вывести сами объекты в консоль.

//создаём две спортивные машины

var oka = sportCar(numberofWheels: 4, color: "Black", windows: .close, engine: .stop, doors: .close, maxSpeed: 100, acceleration: .off)
var aurus = sportCar(numberofWheels: 4, color: "Pearl white", windows: .open, engine: .stop, doors: .open, maxSpeed: 178, acceleration: .off)

//и проверяем, как работает CustomStringConvertible, а заодно и выполняем вывод созданных объектов в консоль

print(oka)
print(aurus)

//проверяем методы протокола

let okaColor=oka.getColor() //назначаем цвет машины в переменную
print("The color of oka is - \(okaColor)") //печатаем результат

let aurusWheels=aurus.getNumberOfWheels() //назначаем количество колёс в переменную
print("Aurus has \(aurusWheels) wheels") //выводим в консоль

//перекрасим оку
oka.color = "Red"
//выведем новый цвет на экран
print(oka.getColor())
//применим оксид азота к аурусу
aurus.acceleration = nitroOxideState.on
//выведем на экран
print(aurus.acceleration)

//создаём 2 грузовые машины

var kamaz = trunkCar(numberOfWheels: 6, color: "Red", windows: .close, engine: .stop, doors: .close, trunkVolume: 8000, tubeLength: 5)
var zil = trunkCar(numberOfWheels: 8, color: "Black", windows: .open, engine: .start, doors: .open, trunkVolume: 12000, tubeLength: 13)


//и проверяем, как работает CustomStringConvertible, а заодно и выполняем вывод созданных объектов в консоль

print(kamaz)
print(zil)

//проверяем методы протокола

let kamazColor=kamaz.getColor()
print("Kamaz color is \(kamazColor)")

let zilWheels=zil.getNumberOfWheels()
print("Zil has \(zilWheels) wheels")

//заведём зил
zil.startEngine()
//выведем новое состояние в консоль
print(zil.engine)

//наденем 2 доп.колеса на камаз
kamaz.numberOfWheels=6+2
//и выведем на экран
print(kamaz.getNumberOfWheels())

//откроем окна с помощью функции из протокола
kamaz.openWindows()
//выведем состояние окон на экран
print(kamaz.windows)

//закроем двери
zil.closeCar()
//и выведем на экран
print(kamaz.doors)

//применим другие функции, текст распечатается в консоль из этих функций
kamaz.stopEngine()
zil.openCar()
