//
//  main.swift
//  Lesson4
//
//  Created by Дмитрий on 10.08.2021.
//

import Foundation

//Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет TrunkCar, а какие – SportCar. Добавить эти действия в перечисление.

enum engine:String { //перечисление режимов работы двигателя
    case start
    case stop
    case turbo //режим турбо для спортивной машины
    case trunking //режим погрузки для грузовой машины
}

enum windows:String {//перечисление режимов окна
    case open
    case close
}

enum trunk:String { //перечисление заполненности багажника/кузова
    case empty
    case half
    case full
}

//Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.

class Car {
    var engineVolume:Double     //объём двигателя
    var seats:Int               //количество мест
    var color:String            //цвет
    var wheelsRadius:Int        //радиус колёс
    var engineState:engine      //статус двигателя
    var windowState:windows     //статус окон
    var trunkState:trunk        //заполненность багажника
    
    init(engineVolume:Double,seats:Int,color:String,wheelsRadius:Int,engineState:engine,windowState:windows,trunkState:trunk){//стандартный конструктор
        self.engineVolume=engineVolume
        self.seats=seats
        self.color=color
        self.wheelsRadius=wheelsRadius
        self.engineState=engineState
        self.windowState=windowState
        self.trunkState=trunkState
    }
    
    func specialAbility(){ //пустой метод, который позволяет задействовать особенность машины(подкласса)
        
    }
    
}

//Описать пару его наследников TrunkCar и SportCar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

//В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.

class TrunkCar:Car {
    var trunkVolume:Double //свойство грузовой машины - объём кузова
    init(engineVolume:Double,seats:Int,color:String,wheelsRadius:Int,engineState:engine,windowState:windows,trunkState:trunk, trunkVolume:Double){ //переопределяем конструктор
        self.trunkVolume=trunkVolume
        super.init(engineVolume: engineVolume, seats: seats, color: color, wheelsRadius: wheelsRadius, engineState: engineState, windowState: windowState, trunkState: trunkState)
    }
    override func specialAbility() {//переопределяем метод для грузового авто, вводим его двигатель в режим "погрузка"
        engineState = .trunking
    }
    
}

class SportCar:Car {
    var maxSpeed:Double //свойство спортивной машины - максимальная скорость
    init(engineVolume:Double,seats:Int,color:String,wheelsRadius:Int,engineState:engine,windowState:windows,trunkState:trunk,maxSpeed:Double){//переопределяем конструктор
        self.maxSpeed=maxSpeed
        super.init(engineVolume: engineVolume, seats: seats, color: color, wheelsRadius: wheelsRadius, engineState: engineState, windowState: windowState, trunkState: trunkState)
    }
    override func specialAbility() {//переопределяем метод для спортивного авто, вводим двигатель в режим "турбо"
        engineState = .turbo
    }
    
}

//Создать несколько объектов каждого класса. Применить к ним различные действия.
//Вывести значения свойств экземпляров в консоль.

//объявляем спортивные машины

var zhiguli = SportCar(engineVolume: 1203, seats: 5, color: "white", wheelsRadius: 14, engineState: .stop, windowState: .close, trunkState: .empty, maxSpeed: 221)
var yomobil = SportCar(engineVolume: 2398, seats: 2, color: "Brilliant", wheelsRadius: 17, engineState: .stop, windowState: .close, trunkState: .empty, maxSpeed: 301)


zhiguli.specialAbility()        //активируем специальную способность
print(zhiguli.engineState)      //проверяем, действительно ли поменялся режим двигателя
zhiguli.windowState = .open     //откроем окна
print(zhiguli.windowState)      //выводим в консоль статус окон
zhiguli.engineState = .start    //заводим двигатель
print(zhiguli.engineState)      //выводим в консоль статус двигателя
zhiguli.trunkState = .half      //загрузили багажник на половину
print(zhiguli.trunkState)       //выводим в консоль статус заполненности багажника

//объявляем грузовые машины

var kamaz = TrunkCar(engineVolume: 4953, seats: 2, color: "Red", wheelsRadius: 34, engineState: .stop, windowState: .close, trunkState: .empty, trunkVolume: 8000)
var zil = TrunkCar(engineVolume: 8732, seats: 1, color: "Black", wheelsRadius: 55, engineState: .stop, windowState: .close, trunkState: .empty, trunkVolume: 9432)

kamaz.specialAbility()//активируем специальную способность
print(kamaz.engineState)//проверяем, действительно ли поменялся режим двигателя

zil.color = "Khacki"    //перекрашиваем машину
print(zil.color)        //выводим в консоль новый цвет
zil.wheelsRadius = 50   //меняем радиус колеса
print(zil.wheelsRadius) //выводим в консоль новый радиус колёс
zil.seats = 3           //устанавливаем дополнительные места
print(zil.seats)        //выводим в консоль количество мест
