//
//  User.swift
//  DDD
//
//  Created by NHN on 2021/06/29.
//

import Foundation
    
struct UserId : Equatable {
    let value: String
    
    func equals(userId: UserId) -> Bool {
        if value == userId.value {
            return true
        }
        
        return false
    }
    
    static func == (lhs: UserId, rhs: UserId) -> Bool {
        lhs.equals(userId: rhs)
    }
}

class UserModel: Equatable {
    private let userId: UserId
    private(set) var name: String
    private let checkNameIsValid: (String) throws -> Void = { name in
        if name.count < 3 {
            throw ArgumentExceptionError.ArgumentExceptionError("이름이 3자 미만")
        }
    }
    
    init(id:String, name: String) throws {
        self.userId = UserId(value: id)
        // 중복! 그렇다고 !나 ?로 선언하고 싶지는 않음...
        try checkNameIsValid(name)
        self.name = name
    }
    
    func changeName(name: String) throws {
        try checkNameIsValid(name)
        self.name = name
    }
    
    func equals(user: UserModel) -> Bool {
        if self === user || self.userId == user.userId {
            return true
        }
        return false
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        lhs.equals(user: rhs)
    }
}
