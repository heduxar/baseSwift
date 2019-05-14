import UIKit
//Использую VAR для переменных, знаю что можно использовать let :) это на будущее, вдруг будут запросы к пользователю. Формулы используют константы.
//1. Решить квадратное уровнение: ax^2+bx+c=0
var a: Int = 3
var b: Float = -14
var c: Double = -5
let disc = (pow(Double(b),2)-(Double(4)*Double(a)*Double(c)))
if a != 0{
    if disc>0 {
        var x1: Double?
        var x2: Double?
        x1 = ((Double(-b))+(sqrt(disc)))/(2*Double(a))
        x2 = ((Double(-b))-(sqrt(disc)))/(2*Double(a))
        print("x1=",x1 ?? "","x2=",x2 ?? "")
    }else if disc==0{
        var x: Double?
        x = Double(-b)/Double(2)*Double(a)
        print(x ?? "")
    }else if disc<0{
        print ("Уравнение не имеет корней")
    }
}else{
    print ("a=0")
}

//2. Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
var cat1: Double = 3.14
var cat2: Double = 59.26
let area = (Double(cat1 * cat2)) / 2
let hypotenuse = sqrt(pow(Double(cat1),2) + pow(Double(cat2),2))
let perimeter = (Double(cat2 + cat1)) + hypotenuse
print("Площадь треугольника=",area, "Периметр треугольника=", perimeter,  "Длина гипотенузы треугольника=", hypotenuse)

//3. Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
var deposit: Float = 56789
let percent: Float = 7
let years: UInt = 5
var counter: UInt = 0
while (counter<years) {
    deposit = ((deposit/100*percent)+deposit)
    counter+=1
}
if years<=4 {
    print("Сумма вклада через", years, "года будет равна", deposit)
} else {
    print("Сумма вклада через", years, "лет будет равна", deposit)
}



