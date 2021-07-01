//
//  UserRepository.swift
//  DDD
//
//  Created by NHN on 2021/07/01.
//

import Foundation
import CoreData

protocol Repository {
    associatedtype ModelType
    
    static func save(model: ModelType)
    static func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T]
}

extension Repository {
    static func save(model: ModelType) {}
    static func fetchData<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try PersistencyManager.persistentContainer.viewContext.fetch(request)
            return fetchResult
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

protocol UserRepsoitoryProtocol: Repository {
    static func findUserByName(name: String) -> [User]?
}

class UserRepository: UserRepsoitoryProtocol {
    typealias ModelType = UserModel
    
    
    static func save(model: UserModel) {
        let context = PersistencyManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        if let entity = entity {
            let user = NSManagedObject(entity: entity, insertInto: context)
            user.setValue(model.userId.value, forKey: "id")
            user.setValue(model.name, forKey: "name")
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    static func findUserByName(name: String) -> [User]? {
        let context = PersistencyManager.persistentContainer.viewContext
        let query: NSFetchRequest<User> = User.fetchRequest()
        
        let predicate = NSPredicate(format: "name contains[c] %@", name)
        query.predicate = predicate

        do{
            let users = try context.fetch(query)
            return users
        }catch{
            print("error")
        }
        
        return nil
    }
}
