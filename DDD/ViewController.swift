//
//  ViewController.swift
//  DDD
//
//  Created by NHN on 2021/06/29.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    private let userService: UserService = UserService(userRepository: DefaultUserRepository(viewContext: PersistencyManager.shared().persistentContainer.viewContext))
    
    private var userIdTextField: UITextField!
    private var userNameTextField: UITextField!
    private var createUserBtn: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpView()
        setConstraints()
    }

    // MARK: View
    
    private func setUpView() {
        view.backgroundColor = .white
        setUpUserIdTextField()
        setUpUserNameTextField()
        setUpCreateUserBtn()
    }
    
    private func setUpUserIdTextField() {
        userIdTextField = UITextField()
        userIdTextField.translatesAutoresizingMaskIntoConstraints = false
        userIdTextField.layer.cornerRadius = 4
        userIdTextField.layer.borderWidth = 2
        userIdTextField.backgroundColor = UIColor(red: 0xD4/255, green: 0xF1/255, blue: 0xF4/255, alpha: 1.0)
        userIdTextField.layer.borderColor = CGColor(red: 0x05/255, green: 0x44/255, blue: 0x5E/255, alpha: 1.0)

        view.addSubview(userIdTextField)
    }
    
    private func setUpUserNameTextField() {
        userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.layer.cornerRadius = 4
        userNameTextField.layer.borderWidth = 2
        userNameTextField.backgroundColor = UIColor(red: 0xD4/255, green: 0xF1/255, blue: 0xF4/255, alpha: 1.0)
        userNameTextField.layer.borderColor = CGColor(red: 0x05/255, green: 0x44/255, blue: 0x5E/255, alpha: 1.0)
        
        view.addSubview(userNameTextField)
    }
    
    private func setUpCreateUserBtn() {
        createUserBtn = UIButton()
        createUserBtn.translatesAutoresizingMaskIntoConstraints = false
        createUserBtn.setTitle("사용자 생성", for: .normal)
        createUserBtn.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        createUserBtn.backgroundColor = UIColor(red: 0x75/255, green: 0xE6/255, blue: 0xDA/255, alpha: 1.0)
        createUserBtn.layer.cornerRadius = 8
        
        view.addSubview(createUserBtn)
    }
    
    // MARK: constraint
    private func setConstraints() {
        setUserIdTextFieldConstraint()
        setUserNameTextFieldConstraint()
        setCreateUserBtn()
    }
    
    private func setUserIdTextFieldConstraint() {
        userIdTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        userIdTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        userIdTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        userIdTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setUserNameTextFieldConstraint() {
        userNameTextField.topAnchor.constraint(equalTo: userIdTextField.bottomAnchor, constant: 20).isActive = true
        userNameTextField.leadingAnchor.constraint(equalTo: userIdTextField.leadingAnchor).isActive = true
        userNameTextField.trailingAnchor.constraint(equalTo: userIdTextField.trailingAnchor).isActive = true
        userNameTextField.heightAnchor.constraint(equalTo: userIdTextField.heightAnchor).isActive = true
    }
    
    private func setCreateUserBtn() {
        createUserBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        createUserBtn.leadingAnchor.constraint(equalTo: userIdTextField.leadingAnchor).isActive = true
        createUserBtn.trailingAnchor.constraint(equalTo: userIdTextField.trailingAnchor).isActive = true
        createUserBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        createUserBtn.addTarget(self, action: #selector(tapCreateUserBtn), for: .touchUpInside)
    }
    
    // MARK: Action
    @objc private func tapCreateUserBtn() {
        guard let id = userIdTextField.text,
              let name = userNameTextField.text else {
            return
        }
        
        if userService.isNameDuplicate(userName: name) {
            print("duplicate")
            return
        }
        createUser(id: id, name: name)
    }

    // MARK: data handling
    private func createUser(id: String, name: String) {
        do {
            let userModel: UserModel = try UserModel(id: id, name: name)
            userService.saveUser(user: userModel)
        } catch {
            print(error)
        }
    }
    
    
}
