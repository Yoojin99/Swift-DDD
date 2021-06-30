//
//  ViewController.swift
//  DDD
//
//  Created by NHN on 2021/06/29.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    // MARK: coreData
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpView()
    }

    private func setUpView() {
        view.backgroundColor = .white
    }
    
    // MARK: coreData saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: data handling
    private func createUser(id: String, name: String) throws {
        let userModel: UserModel = try UserModel(id: id, name: name)
        let userService: UserService = UserService()
        
        if userService.isNameDuplicate(userModel: userModel) {
            throw ExceptionError.ExceptionError("중복되는 이름")
        }
        
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        if let entity = entity {
            let user = NSManagedObject(entity: entity, insertInto: context)
            user.setValue(userModel.userId.value, forKey: "id")
            user.setValue(userModel.name, forKey: "name")
        }
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
//
//class FullName: Equatable {
//    private(set) var firstName: String
//    private(set) var lastName: String
//
//    init(firstName: String, lastName: String) throws {
//        if lastName.count < 3 {
//            throw ArgumentExceptionError.ArgumentExceptionError("성이 3글자 미만")
//        }
//
//        self.firstName = firstName
//        self.lastName = lastName
//    }
//
//    func equals(fullName: FullName) -> Bool {
//        guard self === fullName
//                || self.firstName == fullName.firstName
//                && self.lastName == fullName.lastName else {
//            return false
//        }
//        return true
//    }
//
//    static func == (lhs: FullName, rhs: FullName) -> Bool {
//        guard lhs === rhs
//                || lhs.firstName == rhs.firstName
//                && lhs.lastName == rhs.lastName else {
//            return false
//        }
//        return true
//    }
//}
//
//
//class Money {
//    private(set) var amount: Decimal
//    private(set) var currency: String
//
//    init(amount: Decimal, currency: String) {
//        self.amount = amount
//        self.currency = currency
//    }
//
//    func addMoney(money: Money) throws -> Money {
//        guard self.currency == money.currency else {
//            throw ArgumentExceptionError.ArgumentExceptionError("화폐 단위가 다르다")
//        }
//        return Money(amount: amount + money.amount, currency: currency)
//    }
//}

