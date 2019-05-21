//Домашнее задание
// + Описать несколько структур – любой легковой автомобиль и любой грузовик.
//Структуры должны содержать +марку авто, +год выпуска, +объем багажника/кузова, +запущен ли двигатель, +открыты ли окна, +заполненный объем багажника.
//+Описать перечисление с возможными действиями с автомобилем:
//+запустить/заглушить двигатель,
//+открыть/закрыть окна,
//+погрузить/выгрузить из кузова/багажника груз определенного объема.
//+Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//+Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//+Вывести значения свойств экземпляров в консоль.
enum carMakers {
    case Lexus, Volvo, BMW, Mercedes, Audi, Porsche
}
enum truckMakers {
    case Volvo, Man, Mersedes, Iveco, Freightliner
}
enum engineStatus: String {
    case on = "Двигатель работает"
    case off = "Двигатель выключен"
}
enum windowsStatus: String {
    case opened = "Окна открыты"
    case closed = "Окна закрыты"
}
enum capacity{
    case load
    case release
}

struct car {
    let makeBy : carMakers
    let madeY : Int
    var bagArea : Double = 100
    var engine : engineStatus {
        didSet {
            oldValue == .on ? print(self.engine.rawValue) : print(self.engine.rawValue)
        }
    }
    var windows : windowsStatus {
        didSet {
            oldValue == .opened ? print("Окна закрыты") : print("Окна открыты")
        }
    }
    var bagOccuped: Double = 0
    mutating func engineStatus(mode: engineStatus){
        switch mode {
        case .on:
            self.engine = .on
        case .off:
            self.engine = .off
        }
    }
    mutating func windowsStatus(mode: windowsStatus){
        switch mode {
        case .opened:
            self.windows = .opened
        case .closed:
            self.windows = .closed
        }
    }
    //По заданию с 1 аргументом типа перечисления:
    mutating func windowsOpen(){
        self.windows = .opened
    }
    mutating func windowsClose(){
        self.windows = .closed
    }
    
    mutating func cargo(value:Double, mode: capacity){
        guard self.bagArea>value else {
            return print("Не верный объем груза: \(value)")
        }
        switch mode {
        case .load:
            self.bagOccuped += value
            print("Загрузили: \(value) Свободно: \(self.bagArea-value)")
        case .release:
            self.bagOccuped -= value
            print("Выгрузили: \(value) Свободно: \(self.bagArea-self.bagOccuped) Остаток груза: \(self.bagOccuped)")
        }
    }
    init(model: carMakers, year: Int, baggage: Double, engineStatus: engineStatus, windowsStatus: windowsStatus){
        self.makeBy = model
        self.madeY = year
        self.bagArea = baggage
        self.engine = engineStatus
        self.windows = windowsStatus
    }
}

struct truck {
    let makeBy : truckMakers
    let madeY : Int
    let bagArea : Double
    var engine : engineStatus {
        willSet {
            newValue == .on ? print("Двигатель запускается") : print("Двигатель отлючается")
        }
    }
    var windows : windowsStatus {
        didSet {
            oldValue == .opened ? print("Окна закрыты") : print("Окна открыты")
        }
    }
    var bagOccuped: Double = 0
    var bagSum : Double = 0
    mutating func engineStatus(mode: engineStatus){
        switch mode {
        case .on:
            self.engine = .on
        case .off:
            self.engine = .off
        }
    }
    mutating func windowStatus(mode: windowsStatus){
        switch mode {
        case .opened:
            self.windows = .opened
        case .closed:
            self.windows = .closed
        }
    }
    mutating func cargo(value:Double, mode: capacity){
        guard (self.bagArea-self.bagOccuped)>value else {
            return print("Слишком большой объем груза: \(value)")
        }
        switch mode {
        case .load:
            self.bagOccuped += value
            self.bagSum += value
            print("Загрузили: \(value) Свободно: \(self.bagArea - self.bagOccuped)")
        case .release:
            self.bagOccuped -= value
            print("Выгрузили: \(value) Свободно: \(self.bagArea-self.bagOccuped) Остаток груза в кузове: \(self.bagOccuped)")
        }
    }
    init(model: truckMakers, year: Int, cargo: Double, engineStat: engineStatus, windowsStatus: windowsStatus){
        self.makeBy = model
        self.madeY = year
        self.bagArea = cargo
        self.engine = engineStat
        self.windows = windowsStatus
    }
}


var myCar =  car (model: .Lexus, year: 2019, baggage: 350, engineStatus: .on, windowsStatus: .closed)
myCar.engineStatus(mode: .on)
myCar.engineStatus(mode: .off)
myCar.cargo(value: 20, mode: .load)
myCar.cargo(value: 10, mode: .release)
print(myCar.engine.rawValue)
print(myCar)

var myTruck = truck (model: .Freightliner, year: 2018, cargo: 40000, engineStat: .on, windowsStatus: .opened)

myTruck.cargo(value: 20000, mode: .load)
myTruck.engineStatus(mode: .on)
myTruck.windowStatus(mode: .closed)
myTruck.windowStatus(mode: .opened)
print ("Общее количество перевезенного груза:", myTruck.bagSum)
print(myTruck.engine.rawValue)
print(myTruck.windows.rawValue)
print(myTruck)
