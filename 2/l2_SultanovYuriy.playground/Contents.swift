//1. Написать функцию, которая определяет, четное число или нет.
print("--------[1]--------")
var value = 9
func isEven (val: Int) -> (Bool) {
    return (val%2) == 0
}
print(isEven(val: value))

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.
print("--------[2]--------")
func mod3 (val: Int) -> (Bool) {
    return (val%3) == 0
}
print(mod3(val: value))

//3. Создать возрастающий массив из 100 чисел.
print("--------[3]--------")
var array = [Int]()
array += 0...99
print(array)

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
print("--------[4]--------")
for i in array where (isEven(val: i) || mod3(val: i)){
    if let index = array.firstIndex(of: i){
        array.remove(at: index)
    }
}
print(array)

//5. Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов.
//      Числа Фибоначчи определяются соотношениями Fn=Fn-1 + Fn-2.
print("--------[5]--------")
var fibArr = [Double]()
func fibAdd2 (_ n : Int) -> Double {
    switch fibArr.count {
    case 0:
        return 0
    case 1...2:
        return 1
    default:
        return fibArr[fibArr.count-1] + fibArr[fibArr.count-2]
    }
}
for i in 0...99{
    fibArr.append(fibAdd2(i))
}
print(fibArr)

//Формирование массива, с заданным количеством элементов, в функции и его вывод:
//func fibAdd(_ n: Int) -> [Double] {
//    var fibArr = [Double]()
//    guard n==0 else {
//        while fibArr.count < n {
//            if fibArr.count==0{
//                fibArr.append(0)
//            }else if fibArr.count != 0 && fibArr.count < 3 {
//                fibArr.append(1)
//            }else {
//                fibArr.append(fibArr[fibArr.count - 1] + fibArr[fibArr.count-2])
//            }
//        }
//    return fibArr
//    }
//    return fibArr
//}
//
//print(fibAdd(100))


//6. Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу.
print("--------[6]--------")
func isSimple(_ number: Int) -> Bool {
    return number > 1 && !(2..<number).contains { number % $0 == 0 }
}

var simpleArray = [Int]()
simpleArray += 2...101
for i in simpleArray where !isSimple(i){
    if let index = simpleArray.firstIndex(of: i){
        simpleArray.remove(at: index)
    }
}
print(simpleArray)
// Второй вариант с количеством элементов и массивом на выходе
//func simArr (_ n: Int) -> [Int]{
//    var simA = [Int]()
//    guard n == 0 else {
//        while simA.count < n {
//            simA.count == 0 ? simA.append(2) : simA.append(simA[simA.count-1]+1)
//        }
//        for i in simA where !isSimple(i){
//            if let index = simA.firstIndex(of: i){
//                simA.remove(at: index)
//            }
//        }
//        return simA
//    }
//    return simA
//}
//print (simArr(100))

print("-------[DONE]-------")
