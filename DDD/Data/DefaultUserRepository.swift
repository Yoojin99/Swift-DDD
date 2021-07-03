//
//  UserRepository.swift
//  DDD
//
//  Created by NHN on 2021/07/01.
//

import Foundation
import CoreData

final class DefaultUserRepository {
    private let viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
}

extension DefaultUserRepository: UserRepository {
    func save(user: UserModel) {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: viewContext)
        
        if let entity = entity {
            let userEntity = NSManagedObject(entity: entity, insertInto: viewContext)
            userEntity.setValue(user.userId.value, forKey: "id")
            userEntity.setValue(user.name, forKey: "name")
        }
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    func findUserByName(name: String) -> [UserModel]? {
        let query: NSFetchRequest<User> = User.fetchRequest()
        
        let predicate = NSPredicate(format: "name contains[c] %@", name)
        query.predicate = predicate

        do{
            let users = try viewContext.fetch(query)
            
            if users.count == 0 {
                return nil
            }
            
            return users.map { user -> UserModel in
                var userModel: UserModel!
                do {
                    userModel =  try UserModel(id: user.id!, name: user.name!)
                } catch {
                    print(error)
                }
                return userModel
            }
            
        } catch{
            print("error")
        }
        
        return nil
    }
}
