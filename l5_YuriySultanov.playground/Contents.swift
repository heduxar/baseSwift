//+1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//+2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//+3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar.
//+4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//+5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//+6. Вывести сами объекты в консоль.
enum Makers {
    case Lexus, Volvo, BMW, Mercedes, Audi, Infiniti, Cadillac
}
enum SportMakers{
    case McLaren, Aston_Martin, Lamborghini, Ferrari, Porsche
}
enum TruckMakers {
    case Volvo, Mercedes, Iveco, Man, Freightliner
}
enum EngineStatus: String {
    case on = "Двигатель работает"
    case off = "Двигатель выключен"
}
enum OpenClose: String{
    case open = "Открыто"
    case close = "Закрыто"
}
enum Capacity{
    case load
    case release
}
enum Roof: String{
    case cabrio = "Крыша кабриолета"
    case panoramic = "Панорамная крыша"
    case hatch = "Люк"
}
enum Engine: String{
    case Petrol = "Бензиновый"
    case Diesel = "Дизельный"
    case Hybrid = "Гибридный"
    case Electrical = "Электрический"
}
enum Transmission: String{
    case Automatic = "Автоматическая"
    case Manual = "Механическая"
    case Semi_Automatic = "Полуавтоматическая"
}
enum Drive: String{
    case Front = "Передний"
    case Rear = "Задний"
    case Semi_Full = "Подключаемый полный"
    case Full = "Постоянный полный"
}
enum EngineMode: String{
    case Eco = "Экономичный"
    case Sport = "Спорт"
    case SportPlus = "Спорт+"
}

protocol Auto {
    var madeY: UInt { get set }
    var engine: Engine { get set }
    var transmission: Transmission { get set }
    var drive: Drive { get set }
}

protocol AutoBaggage {
    var bagArea: Double { get set }
    var bagOccuped: Double { get set }
    mutating func cargo(value:Double, mode: Capacity)
}
extension AutoBaggage {
    mutating func cargo(value:Double, mode: Capacity){
        guard (self.bagArea>value) && ((self.bagArea - self.bagOccuped)>=value) else {
            return print("Большой объем груза: \(value), Свободно: \(self.bagArea-self.bagOccuped)")
        }
        switch mode {
        case .load:
            self.bagOccuped += value
            print("Загрузили: \(value) Свободно: \(self.bagArea-self.bagOccuped) Груз: \(self.bagOccuped)")
        case .release:
            self.bagOccuped -= value
            print("Выгрузили: \(value) Свободно: \(self.bagArea-self.bagOccuped) Остаток груза: \(self.bagOccuped)")
        }
    }
}

protocol AutoElectronic {
    var abs: Bool { get set }
    var ebs: Bool { get set }
    var engineState: EngineStatus { get set }
    var windowsState: OpenClose { get set }
    mutating func absSwitch()
    mutating func ebsSwitch()
    mutating func engineStatus(mode: EngineStatus)
    mutating func windowsStatus(mode: OpenClose)
}
extension AutoElectronic {
    mutating func absSwitch(){
        guard (self.engineState == .on) else{
            return print("Двигатель не заведен")
        }
        self.abs == true ? (self.abs=false) : (self.abs=true)
    }
    mutating func ebsSwitch() {
        guard (self.engineState == .on) else{
            return print("Двигатель не заведен")
        }
        self.ebs == true ? (self.ebs=false) : (self.ebs=true)
    }
    mutating func engineStatus(mode: EngineStatus){
        switch mode {
        case .on:
            self.engineState = .on
        case .off:
            self.engineState = .off
        }
    }
    mutating func windowsStatus(mode: OpenClose){
        switch mode {
        case .open:
            windowsState = .open
        case .close:
            windowsState = .close
        }
    }
}
protocol UsualCar: Auto, AutoBaggage, AutoElectronic {
    var madeBy: Makers { get set }
}
protocol AutoSport: AutoElectronic, Auto {
    var madeBy: SportMakers { get set }
    var roof: Roof { get set }
    var roofState : OpenClose { get set }
    var driveMode: EngineMode { get set }
    var turbo: Double { get set }
    mutating func roofSwitch()
    mutating func DriveMode(mode: EngineMode)
}
extension AutoSport {
    mutating func roofSwitch() {
        roofState == .open ? (roofState = .close) : (roofState = .open)
    }
    mutating func DriveMode(mode: EngineMode){
        guard (self.engineState == .on) else{
            return print("Для выбора режимов заведите двигатель")
        }
        switch mode {
        case .Eco:
            self.driveMode = .Eco
            self.turbo = 0.5
            if self.ebs == false{
                self.ebsSwitch()
            }
        case .Sport:
            self.driveMode = .Sport
            self.turbo = 1
        case .SportPlus:
            self.driveMode = .SportPlus
            self.turbo = 1.5
            if self.ebs == true{
                self.ebsSwitch()
            }
        }
    }
}
protocol AutoTruck: Auto, AutoElectronic, AutoBaggage {
    var madeBy: TruckMakers { get set }
    var cargoLift: Bool { get set }
    var cargoSum: Double { get set }
    func totalCargo()
    mutating func releaseCargo()
}
extension AutoTruck {
    mutating func cargo(value: Double, mode: Capacity) {
        guard (self.bagArea>value) && ((self.bagArea - self.bagOccuped)>=value) else {
            return print("Большой объем груза: \(value), Свободно: \(self.bagArea-self.bagOccuped)")
        }
        switch mode {
        case .load:
            self.bagOccuped += value
            self.cargoSum += value
            print("Загрузили: \(value) Свободно: \(self.bagArea-self.bagOccuped) Груз: \(self.bagOccuped)")
        case .release:
            self.bagOccuped -= value
            print("Выгрузили: \(value) Свободно: \(self.bagArea-self.bagOccuped) Остаток груза: \(self.bagOccuped)")
        }
    }
    func totalCargo() {
        print("Всего перевезено груза: \(cargoSum)")
    }
    mutating func releaseCargo() {
        guard (self.cargoLift == true) else {
            return print ("Грузовик не оборудован")
        }
        self.cargo(value: self.bagOccuped, mode: .release)
        print("Весь груз выгружен")
    }
}
class AutoCounter {
    static var autoCounter: UInt = 0
}

class JustCar: AutoCounter, UsualCar, CustomStringConvertible {
    var description: String {
        return "Марка: \(self.madeBy), Год выпуска: \(self.madeY) \nДвигатель: \(self.engine.rawValue), КПП: \(self.transmission.rawValue), Привод: \(self.drive.rawValue) \nABS включен: \(self.abs), EBS включен: \(self.ebs), \nСостояние двигателя: \(self.engineState), Состояние окон: \(self.windowsState)"
    }
    var madeBy: Makers
    var madeY: UInt
    var engine: Engine
    var transmission: Transmission
    var drive: Drive
    var abs: Bool = true{
        didSet{
            oldValue == true ? print("ABS отключен") : print("ABS включен")
        }
    }
    var ebs: Bool = true{
        didSet {
            oldValue == true ? print("Курсовая устойчивость отлючена") : print("Курсовая устойчивость включена")
        }
    }
    var engineState: EngineStatus = .off{
        didSet {
            print(engineState.rawValue)
        }
    }
    var windowsState: OpenClose = .close{
        didSet {
            oldValue == .open ? print("Окна закрыты") : print("Окна открыты")
        }
    }
    var bagArea: Double
    var bagOccuped: Double = 0
    init(madeBy: Makers, year: UInt, engine: Engine, transmission: Transmission, drive: Drive, bagArea: Double) {
        self.madeBy = madeBy
        self.madeY = year
        self.engine = engine
        self.transmission = transmission
        self.drive = drive
        self.bagArea = bagArea
        AutoCounter.autoCounter += 1
    }
    deinit {
        AutoCounter.autoCounter -= 1
    }
}

class SportCar: AutoCounter, AutoSport, CustomStringConvertible{
    var madeBy: SportMakers
    var roof: Roof
    var roofState: OpenClose = .close{
        didSet {
            oldValue == .open ? print(roof.rawValue,"-",roofState.rawValue) : print(roof.rawValue,"-",roofState.rawValue)
        }
    }
    var driveMode: EngineMode = .Sport{
        willSet{
            print("Включен режим \(newValue)")
        }
    }
    var turbo: Double = 1{
        willSet {
            print("Максимальное давление давление турбины: \(newValue) bar")
        }
    }
    var description: String{
        return "Марка: \(self.madeBy), Год выпуска: \(self.madeY) \nДвигатель: \(self.engine.rawValue), КПП: \(self.transmission.rawValue), Привод: \(self.drive.rawValue) \nABS включен: \(self.abs), EBS включен: \(self.ebs), \nСостояние двигателя: \(self.engineState), Состояние окон: \(self.windowsState), Состояние крыши: \(self.roofState)"
    }
    var abs: Bool = true{
        didSet{
            oldValue == true ? print("ABS отключен") : print("ABS включен")
        }
    }
    var ebs: Bool = true{
        didSet {
            oldValue == true ? print("Курсовая устойчивость отлючена") : print("Курсовая устойчивость включена")
        }
    }
    var engineState: EngineStatus = .off{
        didSet {
            print(engineState.rawValue)
        }
    }
    var windowsState: OpenClose = .close{
        didSet {
            oldValue == .open ? print("Окна закрыты") : print("Окна открыты")
        }
    }
    var madeY: UInt
    var engine: Engine
    var transmission: Transmission
    var drive: Drive
    init(madeBy: SportMakers, year: UInt, engine: Engine, transmission: Transmission, drive: Drive, roof: Roof) {
        self.madeBy = madeBy
        self.madeY = year
        self.engine = engine
        self.transmission = transmission
        self.drive = drive
        self.roof = roof
        AutoCounter.autoCounter += 1
    }
    deinit {
        AutoCounter.autoCounter -= 1
    }
    
    
}

class Truck: AutoCounter, AutoTruck, CustomStringConvertible{
    var description: String {
        return "Марка: \(self.madeBy), Год выпуска: \(self.madeY) \nДвигатель: \(self.engine.rawValue), КПП: \(self.transmission.rawValue), Привод: \(self.drive.rawValue) \nABS включен: \(self.abs), EBS включен: \(self.ebs), \nСостояние двигателя: \(self.engineState), Состояние окон: \(self.windowsState),\nГруз: \(self.bagOccuped) Перевезено груза: \(self.cargoSum), \n VIN"
    }
    var madeBy: TruckMakers
    var cargoLift: Bool
    var cargoSum: Double = 0
    var madeY: UInt
    var engine: Engine
    var transmission: Transmission
    var drive: Drive
    var abs: Bool = true{
        didSet{
            oldValue == true ? print("ABS отключен") : print("ABS включен")
        }
    }
    var ebs: Bool = true{
        didSet {
            oldValue == true ? print("Курсовая устойчивость отлючена") : print("Курсовая устойчивость включена")
        }
    }
    var engineState: EngineStatus = .off{
        didSet {
            print(engineState.rawValue)
        }
    }
    var windowsState: OpenClose = .close{
        didSet {
            oldValue == .open ? print("Окна закрыты") : print("Окна открыты")
        }
    }
    var bagArea: Double
    var bagOccuped: Double = 0
    init (madeBy: TruckMakers, year: UInt, engine: Engine, transmission: Transmission, drive: Drive, capacity: Double, cargoLift: Bool) {
        self.madeBy = madeBy
        self.madeY = year
        self.engine = engine
        self.transmission = transmission
        self.drive = drive
        self.bagArea = capacity
        self.cargoLift = cargoLift
        AutoCounter.autoCounter += 1
    }
    deinit {
        AutoCounter.autoCounter -= 1
    }
}

var test = JustCar (madeBy: .Audi, year: 2019, engine: .Electrical, transmission: .Semi_Automatic, drive: .Semi_Full, bagArea: 400)
test.engineStatus(mode: .on)
test.absSwitch()
test.ebsSwitch()
test.windowsStatus(mode: .open)
test.engineStatus(mode: .off )
test.cargo(value: 300, mode: .load)
test.cargo(value: 400, mode: .load)
AutoCounter.autoCounter
print(test)
print("\n")
var truck = Truck (madeBy: .Freightliner, year: 2019, engine: .Diesel, transmission: .Manual, drive: .Rear, capacity: 30000, cargoLift: true)
truck.cargo(value: 4000, mode: .load)
truck.cargo(value: 4000, mode: .load)
truck.totalCargo()
truck.releaseCargo()
print(truck)
print("\n")
var sportCar = SportCar (madeBy: .Ferrari, year: 2019, engine: .Petrol, transmission: .Semi_Automatic, drive: .Semi_Full, roof: .cabrio)
sportCar.engineStatus(mode: .on)
sportCar.roofSwitch()
sportCar.windowsStatus(mode: .close)
sportCar.DriveMode(mode: .SportPlus)
print(sportCar)
