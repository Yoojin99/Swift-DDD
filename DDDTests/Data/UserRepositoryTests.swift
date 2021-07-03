//
//  UserRepositoryTests.swift
//  DDDTests
//
//  Created by NHN on 2021/07/03.
//

import XCTest
import CoreData
@testable import DDD

class TestCoreDataStack: NSObject {
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "/dev/null")
        
        let container = NSPersistentContainer(name: "Model")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}

class UserRepositoryTests: XCTestCase {
    var repository: UserRepository!
    var context: NSManagedObjectContext!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        context = TestCoreDataStack().persistentContainer.newBackgroundContext()
        repository = DefaultUserRepository(viewContext: context)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        repository = nil
        context = nil
    }

    func testSave() throws {
        let userModel1 = try DDD.UserModel(id: "id", name: "name100")
        
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        
        context.perform { [weak self] in
            self?.repository.save(user: userModel1)
        }
    
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "save not occured")
        }
        
    }
    
    func testFindByName() throws {
        let userModel1 = try DDD.UserModel(id: "id", name: "name1")
        let userModel2 = try DDD.UserModel(id: "id", name: "name2")
        let userModel3 = try DDD.UserModel(id: "id", name: "name3")

        repository.save(user: userModel1)
        repository.save(user: userModel2)
        repository.save(user: userModel3)
        
        let result1 = repository.findUserByName(name: "name1")
        let result2 = repository.findUserByName(name: "name2")
        let result3 = repository.findUserByName(name: "name3")
        
        XCTAssertNotNil(result1, "result1 nil")
        XCTAssertNotNil(result2, "result1 nil")
        XCTAssertNotNil(result3, "result1 nil")

        XCTAssertEqual(result1!.first?.name, "name1")
        XCTAssertEqual(result2!.first?.name, "name2")
        XCTAssertEqual(result3!.first?.name, "name3")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
