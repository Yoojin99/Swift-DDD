//
//  ViewController.swift
//  DDD
//
//  Created by NHN on 2021/06/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpView()
        
        var user1: User
        var user2: User
        
        do {
            user1 = try User(id: "id1", name: "hii")
            user2 = try User(id: "id1", name: "Hii")
            
            print(user1.equals(user: user2))
            print(user1 == user2)

        } catch {
            print(error)
        }
        
    }


    private func setUpView() {
        view.backgroundColor = .white
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

