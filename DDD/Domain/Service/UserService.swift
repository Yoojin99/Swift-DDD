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
    static func isNameDuplicate(userName: String) -> Bool {
        // check whether name is duplicate
        if UserRepository.findUserByName(name: userName) != nil {
            return true
        }
        return false
    }
}
