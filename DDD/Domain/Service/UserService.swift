//
//  UserService.swift
//  DDD
//
//  Created by NHN on 2021/06/30.
//

import Foundation
import CoreData
import UIKit

class UserService {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func isNameDuplicate(userName: String) -> Bool {
        // check whether name is duplicate
        if userRepository.findUserByName(name: userName) != nil {
            return true
        }
        return false
    }
    
    func saveUser(user: UserModel) {
        userRepository.save(user: user)
    }
}
