import UIKit

print("1. Написать функцию, которая определяет, четное число или нет.")

func isEven(number: Int) -> Bool {
    //если число делится на 2 без остатка, значит число чётное
    if number % 2 == 0 {
        return true
    } else {
        return false
    }
    
    
}

print("2. Написать функцию, которая определяет, делится ли число без остатка на 3.")

func isDiv3(number:Int) -> Bool {
    
    if number % 3 == 0 {
        return true
    } else {
        return false
    }
}

print("3. Создать возрастающий массив из 100 чисел.")

var massiv = [Int]()
for i in 152...251 {
    massiv.append(i)
}

print("4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.")

for value in massiv {
    if isEven(number: value) || !isDiv3(number: value) { //записываем все условия по задаче
        massiv.remove(at: massiv.firstIndex(of: value)!)
    }
}

print("5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов. Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2")

func fib(array: inout [Int]){
    //для того, чтобы добавить число, в массиве должно быть по крайней мере 2 элемента, если их нет, то добавим
    if array.count==0 {
        array.append(1)
    } else if array.count==1 {
        array.append(2)
    } else {//добавляем элементы по формуле
        array.append(array[array.count-1]+array[array.count-2])
    }
}

var newFib=[Int]() //объявляем массив, в который будем добавлять элементы из функции
//вызываем функцию 50 раз
for _ in (1...50) {
    fib(array: &newFib)
}

print("6. * Заполнить массив элементов различными простыми числами.")

//сначала сделаем массив, наполненный всеми числами от 0 до 100
var simpleBegin=[Int]()
for i in 2...100 {
    simpleBegin.append(i)
}

var simpleFinish=[Int]()//в этот массив будем записывать простые числа
var flag:Bool=true //флаг для определения, была ли сделана запись первого числа

for p in simpleBegin {
    
    for value in simpleBegin{
        
        if value%p==0 {//записываем первое число, которое делится без остатка на само себя и потом ставим флаг, чтобы другие числа, которые делятся без остатка не записывались в итоговый массив
            if flag {
                simpleFinish.append(value)
                flag=false
            }
            simpleBegin.remove(at: simpleBegin.firstIndex(of: value)!)//удаляем все остальные числа из первоначального массива
        }
    }
    flag=true //ставим флаг после одной полной итерации, чтобы записать следующее оставшееся число в исходном массиве
    
}
// в итоге в массиве simpleFinish записаны только простые числа от 0 до 100
