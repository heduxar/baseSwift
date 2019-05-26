//+ Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//+ Описать пару его наследников TruckCar и SportCar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//+Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет TrunkCar, а какие – SportCar. Добавить эти действия в перечисление.
//+В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//+Создать несколько объектов каждого класса. Применить к ним различные действия.
//+Вывести значения свойств экземпляров в консоль.

enum Makers {
    case Lexus, Volvo, BMW, Mercedes, Audi, Infiniti, Cadillac
}
enum TruckMakers {
    case Volvo, Mercedes, Iveco, Man, Freightliner
}
enum SportMakers{
    case McLaren, Aston_Martin, Lamborghini, Ferrari, Porsche
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

class AllCars {
    static var totalAuto = 0
    let madeBy: Any
    let madeY: UInt
    let engine: Engine
    let transmission: Transmission
    let drive: Drive
    var bagArea: Double = 0
    var bagOccuped: Double = 0
    fileprivate var abs: Bool = true{
        didSet {
            oldValue == true ? print("ABS отключен") : print("ABS включен")
        }
    }
    fileprivate var ebs: Bool = true{
        didSet {
            oldValue == true ? print("Курсовая устойчивость отлючена") : print("Курсовая устойчивость включена")
        }
    }
    fileprivate var engineState : EngineStatus = .off {
        didSet {
            oldValue == .on ? print(engineState.rawValue) : print(engineState.rawValue)
        }
    }
    fileprivate var windowsState : OpenClose = .close{
        didSet {
            oldValue == .open ? print("Окна закрыты") : print("Окна открыты")
        }
    }
    func cargo(value:Double, mode: Capacity){
        guard self.bagArea>value else {
            return print("Большой объем груза: \(value)")
        }
        switch mode {
        case .load:
            self.bagOccuped += value
            print("Загрузили: \(value) Свободно: \(self.bagArea-value) Груз: \(self.bagOccuped)")
        case .release:
            self.bagOccuped -= value
            print("Выгрузили: \(value) Свободно: \(self.bagArea-self.bagOccuped) Остаток груза: \(self.bagOccuped)")
        }
    }
    func engineStatus(mode: EngineStatus){
        switch mode {
        case .on:
            self.engineState = .on
        case .off:
            self.engineState = .off
        }
    }
    func windowsStatus(mode: OpenClose){
        switch mode {
        case .open:
            self.windowsState = .open
        case .close:
            self.windowsState = .close
        }
    }
    func absSwitch() {
        guard (self.engineState == .on) else{
            return print("Двигатель не заведен")
        }
        self.abs == true ? (self.abs=false) : (self.abs=true)
    }
    func ebsSwitch() {
        guard (self.engineState == .on) else{
            return print("Двигатель не заведен")
        }
        self.ebs == true ? (self.ebs=false) : (self.ebs=true)
    }
    func status(){
        print("Марка: \(self.madeBy), Год выпуска: \(self.madeY) \nДвигатель: \(self.engine.rawValue), КПП: \(self.transmission.rawValue), Привод: \(self.drive.rawValue) \nABS включен: \(self.abs), EBS включен: \(self.ebs), \nСостояние двигателя: \(self.engineState), Состояние окон: \(self.windowsState)")
    }
    init(model: Any, year: UInt, engine: Engine, transmission: Transmission, drive: Drive){
        self.madeBy = model as Any
        self.madeY = year
        self.engine = engine
        self.transmission = transmission
        self.drive = drive
        Car.totalAuto += 1
        print("Плюс один, всего на дорогах \(Car.totalAuto) авто")
    }
    deinit {
        Car.totalAuto -= 1
        print("Минус один")
    }
}

class Car: AllCars {
    private var bag: Double
    override var bagArea: Double {
        set {bag = newValue}
        get {return bag}
    }
    init(model: Makers, year: UInt, engine: Engine, transmission: Transmission, drive: Drive, baggage: Double){
        self.bag = baggage
        super.init(model: model, year: year, engine: engine, transmission: transmission, drive: drive)
    }
}
class SportCar: AllCars {
    private var roof: Roof
    private var roofState : OpenClose = .close{
        didSet {
            oldValue == .open ? print(roof.rawValue,"-",roofState.rawValue) : print(roof.rawValue,"-",roofState.rawValue)
        }
    }
    private var driveMode: EngineMode = .Sport{
        willSet{
            print("Включен режим \(newValue)")
        }
    }
    private var turbo: Double = 1{
        willSet {
            print("Максимальное давление давление турбины: \(newValue) bar")
        }
    }
    override func cargo(value: Double, mode: Capacity) {
        print("В спорт карах не возят багаж!")
    }
    func roofSwitch() {
        roofState == .open ? (roofState = .close) : (roofState = .open)
    }
    func DriveMode(mode: EngineMode){
        guard (self.engineState == .on) else{
            return print("Для выбора режимов заведите двигатель")
        }
        switch mode {
        case .Eco:
            self.driveMode = .Eco
            self.turbo = 0.5
            if self.ebs == false{
                self.ebs = true
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
    override func status(){
        super.status()
        print("Состояние крыши: \(self.roofState)")
    }
    init(model: SportMakers, year: UInt, engine: Engine, transmission: Transmission, drive: Drive, roof: Roof) {
        self.roof = roof
        super.init(model: model, year: year, engine: engine, transmission: transmission, drive: drive)
    }
    
}
class Truck: AllCars {
    private var cargo: Double
    private var cargoLift : Bool
    override var bagArea: Double{
        set {cargo = newValue}
        get {return cargo}
    }
    private var cargoSum: Double = 0
    override func cargo(value: Double, mode: Capacity) {
        super.cargo(value: value, mode: mode)
        if mode == .load {
            cargoSum += value
        }
    }
    func totalCargo(){
        print("Всего перевезено груза: \(cargoSum)")
    }
    func releaseCargo(){
        guard (self.cargoLift == true) else {
            return print ("Грузовик не оборудован")
        }
        self.cargo(value: self.bagOccuped, mode: .release)
        print("Весь груз выгружен")
    }
    override func status(){
        super.status()
        print("Груз: \(self.bagOccuped) Перевезено груза: \(self.cargoSum)")
    }
    init(model: TruckMakers, year: UInt, engine: Engine, transmission: Transmission, drive: Drive, capacity: Double, cargoLift: Bool) {
        self.cargo = capacity
        self.cargoLift = cargoLift
        super.init(model: model, year: year, engine: engine, transmission: transmission, drive: drive)
    }
}

var myCar = Car (model: .Cadillac, year: 2019, engine: .Hybrid, transmission: .Semi_Automatic, drive: .Semi_Full, baggage: 600)
myCar.cargo(value: 200, mode: .load)
myCar.bagOccuped
myCar.absSwitch()
myCar.status()
print("\n")
var mySportCar = SportCar (model: .Ferrari, year: 2019, engine: .Petrol, transmission: .Automatic, drive: .Full, roof: .hatch)
mySportCar.cargo(value: 200, mode: .load)
mySportCar.roofSwitch()
mySportCar.roofSwitch()
mySportCar.ebsSwitch()
mySportCar.DriveMode(mode: .Eco)
mySportCar.DriveMode(mode: .Sport)
mySportCar.DriveMode(mode: .SportPlus)
mySportCar.status()
print("\n")
var myTruck = Truck (model: .Freightliner, year: 2019, engine: .Hybrid, transmission: .Semi_Automatic, drive: .Rear, capacity: 30000, cargoLift: true)
myTruck.cargo(value: 4000, mode: .load)
myTruck.cargo(value: 2000, mode: .release)
myTruck.cargo(value: 6000, mode: .load)
myTruck.releaseCargo()
myTruck.totalCargo()
myTruck.engineStatus(mode: .on)
myTruck.status()


