//
//  UserRepository.swift
//  DDD
//
//  Created by NHN on 2021/07/01.
//

import Foundation

protocol UserRepository {
    @discardableResult
    func findUserByName(name: String) -> [UserModel]?
    func save(user: UserModel)
}
