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
        
        let viewController = UIApplication.shared.windows.first!.rootViewController as! ViewController
        let context = viewController.persistentContainer.viewContext
        let query: NSFetchRequest<User> = User.fetchRequest()
        
        let predicate = NSPredicate(format: "name contains[c] %@", userName)
        query.predicate = predicate

        do{
            let users = try context.fetch(query)
            
            if users.count > 0 {
                return true
            }
        }catch{
            print("error")
        }
        
        return false
    }
}
