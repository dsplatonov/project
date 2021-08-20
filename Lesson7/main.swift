//
//  main.swift
//  Lesson7
//
//  Created by Дмитрий on 20.08.2021.
//

import Foundation

//Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.

//Придумал класс, осуществляющий авторизацию пользователя по логину и паролю
//описываем ошибки при авторизации
enum authError:Error {
    case wrongLogin //неверный логин
    case wrongPassword //неверный пароль
}
//объявляем класс по авторизации
class Authorization { //добавляем уже зарегистрированных пользователей и их пароли
    private var registeredUser = [
        "user1":"password1",
        "user2":"",
        "user3":"qwert"
    ]
    //делаем функцию по проверке авторизации
    func checkAuth(login:String, pass:String)->(Bool,authError?){ //bool будет всегда, ошибка опциональна
        guard let registeredPass=registeredUser[login] else { //если пользователь не зарегистрирован, то отображаем ошибку
            return (false, authError.wrongLogin)
        }
        guard pass==registeredPass else { //если логин существует, проверяем пароль
            return (false, authError.wrongPassword)
        }
        return (true, nil) //если логин и пароль прошли проверку, то авторизация будет успешна
    }
}

let auth=Authorization() //создаём элемент класса по авторизации
//проверяем работу ошибок
print(auth.checkAuth(login: "user1", pass: "password1"))
print(auth.checkAuth(login: "user2", pass: " "))
print(auth.checkAuth(login: "user4", pass: "qwert"))

var login="user3"
var pass="qwerty"

if auth.checkAuth(login: login, pass: pass).0 {
    print("Авторизация успешна")
} else {
    print(auth.checkAuth(login: login, pass: pass).1!)
}


//Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.

// Придумал класс, осуществляющий регистрацию пользователя и проверяющий соблюдения правил для логина и пароля

//варианты ошибок для регистрации
//варианты ошибок логина
enum LoginError:Error {
    case sameEntry(sameLogin:String) //ошибка, которая появляется, если было введён уже существующий логин
    case emptyEntry //ошибка, появляющаяся при вводе пустого логина
}
//ошибки паролей
enum PasswordError:Error {
    case small //если меньше 6 символов
    case sameSymbols //если в пароле используются одни и те же символы
    case retypeIncorrect // если повторили пароль не правильно
}
// создаём класс по регистрации и добавляем внего зарегистрированных пользователей
class Registration {
    private var registeredUser = [
        "user1":"password1",
        "user2":"",
        "user3":"qwert"
    ]
    //делаем функцию по регистрации
    func reg(login:String, password:String, retypePass:String) throws ->Bool {
        guard login.count>0 else { //если пароль не содержит символов, отбрасываем ошибку
            throw LoginError.emptyEntry
        }
        guard password.count>6 else {
            throw PasswordError.small
        }
        guard password==retypePass else {
            throw PasswordError.retypeIncorrect
        }
        if let pass=registeredUser[login] { //если пользователь уже зарегистрирован, то обрасываем ошибку
            throw LoginError.sameEntry(sameLogin: login)
        } else { //если все базовые проверки пройдены, то переходим к последней проверке на повторяемость символов
            var flag=false //флаг, показывающий, есть ли только повторяющиеся символы в пароле
            let tmpChar:Character=password[password.startIndex]//назначаем первый символ во временную переменную
            for char in password {//в цикле перебираем все символы и как только находим не одинаковый, то меняем статус флага
                if tmpChar != char {
                    flag=true
                    break
                }
            }
            if !flag {//если все символы в пароле одинаковые, то отбрасываем ошибку
                throw PasswordError.sameSymbols
            }
            
            return true // если все проверки пройдены, значит можно регистрироваться
        }
    }
}

//данные для проверки работы
login="user4"
pass="password22"
var retypePass="password22"
//создаём элемент класса по регистрации
var dataBase=Registration()
//пытаемся зарегистрировать нового пользователя, а также описываем каждую ошибку
do {
    let newUser:Bool = try dataBase.reg(login: login, password: pass, retypePass: retypePass)
    print("Регистрация \(login) прошла успешно") //если ошибок не было, значит регистрация прошла успешно
} catch LoginError.emptyEntry { // если поймали ошибку с пустым логином, выводим сообщение на консоль
    print("Вы не ввели логин")
} catch LoginError.sameEntry(sameLogin: let sameLogin) { // если поймали ошибку с логином, который уже есть в базе, выводим сообщение на консоль
    print("Логин \(sameLogin) уже существует, регистрация невозможна")
} catch PasswordError.retypeIncorrect { // если поймали ошибку с неправильным повторным вводом пароля, выводим сообщение на консоль
    print("Пароли из двух полей не совпадают")
} catch PasswordError.sameSymbols {// если поймали ошибку с тем, что у пароля одни и те же символы, выводим сообщение на консоль
    print("Нельзя использовать в пароле одинаковые символы")
} catch PasswordError.small {// если поймали ошибку с тем, что у пароля меньше 6 символов, выводим сообщение на консоль
    print("Пароль слишком маленький (меньше 6 символов")
} catch let error {// во всех остальных случаях выводим системное сообщение об ошибке в консоль
    print(error.localizedDescription)
}




