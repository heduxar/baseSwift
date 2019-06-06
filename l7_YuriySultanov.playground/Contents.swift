class Bank: CustomStringConvertible {
    var description: String {
        return users.description
    }
    
    enum BankErrors: Error{
        case noAccounts
        case noUser
        case notEnoughFounds (needMore: Double)
        case deleteErrorByBalance (balance: Double)
        case emptyFio
        
    }
    fileprivate var users = [
        "Иванов Иван Иванович": 0.0,
        "Сидоров Василий Григорьевич": 0.0,
        "Кузнецов Сергей Андреевич": 1.0
        ]

    func checkBalance(fio: String) throws -> Double {
        guard users[fio] != nil else {throw BankErrors.noUser}
        return users[fio]!
    }
    
    func avergeUsersBalance() throws -> Double {
        guard users.count > 0 else { throw BankErrors.noAccounts }
        
        var totalBalance: Double = 0
        users.forEach { totalBalance += $0.value }
        
        return totalBalance / Double(users.count)
    }
    
    func biggestBalance() throws -> [String:Double] {
        guard users.count > 0 else { throw BankErrors.noAccounts }
        
        let maxValue = users.values.max()
        let maxUserName = users.filter {$0.value == maxValue}
        return maxUserName
    }
    
    func addBalance(fio: String, value: Double) throws -> Double {
        guard users[fio] != nil else { throw BankErrors.noUser }
        users.updateValue((users[fio] ?? 0) + value, forKey: fio)
        return users[fio]!
    }
    
    func spendBalance(fio: String, value: Double) throws -> Double {
        guard users[fio] != nil else { throw BankErrors.noUser }
        guard users[fio]! >= value else { throw BankErrors.notEnoughFounds (needMore: value - users[fio]!)}
        users.updateValue((users[fio] ?? 0) - value, forKey: fio)
        return users[fio]!
    }
    
    func deleteUser(fio: String) throws {
        guard users[fio] != nil else { throw BankErrors.noUser }
        guard users[fio]! == 0.0 else { throw BankErrors.deleteErrorByBalance (balance: users[fio]!)}
        users.removeValue(forKey: fio)
    }
    
    func addUser(fio: String) throws {
        guard fio != "" else { throw BankErrors.emptyFio }
        let newOne = fio
        for user in users {
            if user.key == newOne {
                print("Пользователь уже существует")
            } else {
                users[newOne] = 0.0
            }
        }
    }
}

let bankManager = Bank()
let name = "Иванов Иван Иванович"
do {
    try bankManager.addUser(fio: name)
    print("Баланс:", try bankManager.checkBalance(fio: name))
}catch Bank.BankErrors.emptyFio{
    print("Введите ваши данные")
}
print (bankManager)
do {
    try bankManager.addBalance(fio: name, value: 23.5)
    print("Баланс:", try bankManager.checkBalance(fio: name))
} catch Bank.BankErrors.noUser {
    print("Пользователь не найден")
}

do {
    try bankManager.spendBalance(fio: name, value: 24.5)
    print("Баланс:", try bankManager.checkBalance(fio: name))
} catch Bank.BankErrors.noUser {
    print("Пользователь не найден")
} catch Bank.BankErrors.notEnoughFounds(let needMore) {
    print("Недостаточно средств. Не хватает: \(needMore) ₽")
}

do {
    print("Наибольший баланс:", try bankManager.biggestBalance())
} catch Bank.BankErrors.noAccounts {
    print("Счета отсутсвуют.")
}

do {
    try print("Баланс:",bankManager.checkBalance(fio: "F.Banking.System"))
} catch Bank.BankErrors.noUser {
    print("Пользователь не найден")
}

try bankManager.spendBalance(fio: "Кузнецов Сергей Андреевич", value: 1)
try bankManager.spendBalance(fio: "Иванов Иван Иванович", value: 23.5)
try bankManager.deleteUser(fio: "Иванов Иван Иванович")
try bankManager.deleteUser(fio: "Кузнецов Сергей Андреевич")
try bankManager.deleteUser(fio: "Сидоров Василий Григорьевич")
print(bankManager)

do {
    try bankManager.avergeUsersBalance()
    print("Средний баланс по пользователям:",try bankManager.avergeUsersBalance())
} catch Bank.BankErrors.noAccounts {
    print("Счета отсутсвуют.")
}


do {
    try bankManager.deleteUser(fio: "Сидоров Василий Григорьевич")
    print ("Пользователь удален")
} catch Bank.BankErrors.deleteErrorByBalance (let balance) {
    print("Невозможно удалить, баланс пользователя: \(balance)")
} catch Bank.BankErrors.noUser {
    print("Пользователь не найден")
}

// Замечательно потренеровал Словари xD
