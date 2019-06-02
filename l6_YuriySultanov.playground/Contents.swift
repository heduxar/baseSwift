import UIKit
enum CakeTypes: String {
    case americanVelvet = "Красный бархат"
    case kings = "Королевский"
    case honey = "Медовик"
    case tiramisu = "Тирамису"
    case saher = "Захер"
    case cheesecake = "Чизкейк"
}
protocol Cake {
    var cakeType: CakeTypes { get set }
    var radius: Double { get set }
    var cakeWeight: Double { get set }
}
protocol Kkal: Cake {
    var kkal: Double { get }
    func kkal100(_ : CakeTypes) -> Double
}
extension Kkal{
    var kkal: Double {
        return kkal100(cakeType)
    }
    func kkal100(_ : CakeTypes) -> Double {
        switch cakeType {
        case .americanVelvet:
            return round(358.3/100*cakeWeight)
        case .kings:
            return round(344.46/100*cakeWeight)
        case .cheesecake:
            return round(321/100*cakeWeight)
        case .honey:
            return round(478/100*cakeWeight)
        case .saher:
            return round(351.6/100*cakeWeight)
        case .tiramisu:
            return round(295.5/100*cakeWeight)
        }
    }
}
class ReadyCake: Cake, Kkal, CustomStringConvertible{
    var description: String{
        return "Торт: \(cakeType.rawValue), Радиус: \(radius) см, Вес: \(cakeWeight) г. Ккал: \(kkal)"+"\n"
    }
    var cakeType: CakeTypes
    var radius: Double
    var cakeWeight: Double
    init(Cake: CakeTypes, Radius: Double, Weight: Double) {
        self.cakeType = Cake
        self.radius = Radius
        self.cakeWeight = Weight
    }
}

var myCake = ReadyCake (Cake: .tiramisu, Radius: 30, Weight: 700)
print(myCake)


struct Queue<T: Kkal> {
    private var cakes: [T] = []
    var value: UInt = 0
    mutating func push (_ cake:T){
        cakes.append(cake)
        value += 1
        print("Добавлено на витрину: \n\(cake)")
    }
    mutating func take () -> T? {
        guard cakes.count > 0 else {
            return nil
        }
        value -= 1
        print("Минус торт")
        return cakes.removeFirst()
    }
    mutating func filterByKkal(cake: T, condition: (Double) -> Bool){
        if condition(cake.kkal){
            cakes.append(cake)
            value += 1
            print("Добавлено на витрину с условием по ккал: \n\(cake)")
        }
    }
    subscript (cakes: Int ...) -> Set <String>{
        var kkal: Set <String> = []
        for index in cakes where index < self.cakes.count {
            kkal.insert(String(self.cakes[index].kkal))
        }
        return kkal
    }
}

var showcase = Queue<ReadyCake>()

showcase.push(ReadyCake(Cake: .honey, Radius: 30, Weight: 900))
showcase.push(ReadyCake(Cake: .honey, Radius: 30, Weight: 900))
showcase.push(ReadyCake(Cake: .tiramisu, Radius: 30, Weight: 700))
showcase.push(ReadyCake(Cake: .cheesecake, Radius: 30, Weight: 500))

print(showcase[0])


let lowKK: (Double) -> Bool = { (it: Double) -> Bool in
    return it < 2400
}

showcase.filterByKkal(cake: ReadyCake (Cake: .saher, Radius: 30, Weight: 650), condition: lowKK)
print(showcase)


func kkalFilter(showcase1: [ReadyCake], predicate: (Double) -> Bool) -> [ReadyCake]{
    var newArray = [ReadyCake]()
    var k = 0
    while k < showcase1.count {
        if predicate(showcase1[k].kkal){
            newArray.append(showcase1[k])
        }
        k += 1
    }
    return newArray
}
var newShowcase = [ReadyCake]()
var counter = showcase.value
while counter != 0{
    newShowcase.append(showcase.take()!)
    counter -= 1
    
}

print(newShowcase)
print("Удовлетворяющие условию \n", kkalFilter (showcase1: newShowcase, predicate: lowKK))
