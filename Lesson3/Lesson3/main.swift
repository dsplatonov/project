//
//  main.swift
//  Lesson3
//
//  Created by Дмитрий on 06.08.2021.
//

import Foundation

//Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.

enum state:String { //перечисление режимов работы двигателя
    case start
    case stop
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



//Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.

//структура для спортивного автомобиля

struct SportCar {
    var trademark:String //марка
    var year:Int //год выпуска
    var trunkVolume:Double //объём багажника
    var engineState:state //запущен ли двигатель
    var windowState:windows //открыты ли окна
    var currentTrunkVolume:trunk //заполненный объём багажника
    
    //Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
    
    //метод наверное не самый нужный, но более полезный я не смог придумать
    
    mutating func changeWin(currentState:state){ //если двигатель работает, то закрываем окна, если перестал работать, то открываем
        if currentState.rawValue=="start" {
            self.windowState = .close
        } else {
            self.windowState = .open
        }
    }
}

//структура для грузового автомобиля

struct TrunkCar {
    var trademark:String //марка
    var year:Int //год выпуска
    var trunkVolume:Double //объём кузова
    var engineState:state //запущен ли двигатель
    var windowState:windows//открыты ли окна
    var currentTrunkVolume:trunk //заполненность багажника
    
    //Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
    
    mutating func winAlert(currentWindowState:windows){//если окна открыты, глушим двигатель и закрываем окна, если закрыты, то выводим сообщение, что всё хорошо
        if currentWindowState.rawValue=="open" {
            self.engineState = .stop
            self.windowState = .close
            print("Машина остановлена, окна закрыты")
        } else {
            print("Всё в порядке")
        }
    }
    
    
}

//Инициализировать несколько экземпляров структур. Применить к ним различные действия.

var porsche = SportCar(trademark:"Porsche", year: 2021, trunkVolume: 100.5, engineState: .stop, windowState: .open, currentTrunkVolume: .empty)
var zil = TrunkCar(trademark: "Zil", year: 1967, trunkVolume: 1932, engineState: .start, windowState: .close, currentTrunkVolume: .half)

print("Применяем различные действия к первой машине")
print("")

print("Статус двигателя до смены статуса - \(porsche.engineState)")
porsche.engineState = .start
print("Статус двигателя после смены статуса - \(porsche.engineState)")
porsche.changeWin(currentState: porsche.engineState)
print("Статус окон после вызова метода - \(porsche.windowState)")
porsche.engineState = .stop
print("Меняем режим двигателя до повторного вызова метода - \(porsche.engineState)")
porsche.changeWin(currentState: porsche.engineState)
print("Статус окон после повторного вызова метода - \(porsche.windowState)")

//Вывести значения свойств экземпляров в консоль.
print("Выводим свойства машины")
print("Марка - \(porsche.trademark)")
print("Год выпуска - \(porsche.year)")
print("Объём багажника - \(porsche.trunkVolume)")
print("Статус двигателя - \(porsche.engineState)")
print("Статус окон - \(porsche.windowState)")
print("Заполненность багажника - \(porsche.currentTrunkVolume)")

print("")
print("Применяем различные действия ко второй машине")
print("")


print("Статус окон до смены статуса - \(zil.windowState)")
zil.windowState = .open
print("Статус окон после смены статуса - \(zil.windowState)")
print("Статус двигателя до вызова метода - \(zil.engineState)")
zil.winAlert(currentWindowState: zil.windowState)
print("Статус окон после вызова метода - \(zil.windowState)")
print("Статус двигателя после вызова метода - \(zil.engineState)")
zil.winAlert(currentWindowState: zil.windowState)
print("Статус окон после повторного вызова метода - \(zil.windowState)")
print("Статус двигателя после повторного вызова метода - \(zil.engineState)")

print("")
//Вывести значения свойств экземпляров в консоль.
print("Выводим свойства машины")
print("")

print("Марка - \(zil.trademark)")
print("Год выпуска - \(zil.year)")
print("Объём багажника - \(zil.trunkVolume)")
print("Статус двигателя - \(zil.engineState)")
print("Статус окон - \(zil.windowState)")
print("Заполненность багажника - \(zil.currentTrunkVolume)")

