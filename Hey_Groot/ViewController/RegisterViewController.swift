//
//  RegisterViewController.swift
//  Hey_Groot
//
//  Created by 황수비 on 2023/08/28.
//

import Foundation
import UIKit
import Moya

class RegisterViewController: UIViewController {
    
    private let provider = MoyaProvider<Types>()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPasswordTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        
        let registerParent = self.view!
        
        registerParent.addSubview(emailTextField)
        registerParent.addSubview(passwordTextField)
        registerParent.addSubview(checkPasswordTextField)
        registerParent.addSubview(registerBtn)
        
        emailTextField.borderStyle = .roundedRect
        emailTextField.frame = CGRect(x: 0, y: 0, width: 358, height: 50)
        emailTextField.layer.cornerRadius = 5
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor(red: 0.889, green: 0.894, blue: 0.9, alpha: 1).cgColor
        emailTextField.placeholder = "이메일을 입력해주세요."
        
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.frame = CGRect(x: 0, y: 0, width: 358, height: 50)
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor(red: 0.889, green: 0.894, blue: 0.9, alpha: 1).cgColor
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "비밀번호를 입력해주세요."
        
        checkPasswordTextField.borderStyle = .roundedRect
        checkPasswordTextField.frame = CGRect(x: 0, y: 0, width: 358, height: 50)
        checkPasswordTextField.layer.cornerRadius = 5
        checkPasswordTextField.layer.borderWidth = 1
        checkPasswordTextField.layer.borderColor = UIColor(red: 0.889, green: 0.894, blue: 0.9, alpha: 1).cgColor
        checkPasswordTextField.isSecureTextEntry = true
        checkPasswordTextField.placeholder = "비밀번호를 확인해주세요."
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.widthAnchor.constraint(equalToConstant: 358).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: registerParent.leadingAnchor, constant: 16).isActive = true
        emailTextField.topAnchor.constraint(equalTo: registerParent.topAnchor, constant: 274).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.widthAnchor.constraint(equalToConstant: 358).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: registerParent.leadingAnchor, constant: 16).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: registerParent.topAnchor, constant: 345).isActive = true
        
        checkPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        checkPasswordTextField.widthAnchor.constraint(equalToConstant: 358).isActive = true
        checkPasswordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        checkPasswordTextField.leadingAnchor.constraint(equalTo: registerParent.leadingAnchor, constant: 16).isActive = true
        checkPasswordTextField.topAnchor.constraint(equalTo: registerParent.topAnchor, constant: 416).isActive = true
        
        
        
        
        registerBtn.frame = CGRect(x: 0, y: 0, width: 358, height: 57)
        registerBtn.layer.backgroundColor = UIColor(red: 0.6, green: 0.808, blue: 0.506, alpha: 1).cgColor
        registerBtn.layer.cornerRadius = 12
        registerBtn.translatesAutoresizingMaskIntoConstraints = false
        registerBtn.widthAnchor.constraint(equalToConstant: 358).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 57).isActive = true
        registerBtn.leadingAnchor.constraint(equalTo: registerParent.leadingAnchor, constant: 16).isActive = true
        registerBtn.topAnchor.constraint(equalTo: registerParent.topAnchor, constant: 740).isActive = true
        registerBtn.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        registerBtn.setTitle("완료하기", for: .normal)
    }
    
    
    @IBAction func pressTegisterBtn(_ sender: UIButton) {
        
        guard let email = emailTextField.text, !email.isEmpty else {
            print("error")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            print("error")
            return
            
        }
        guard let checkPassword = checkPasswordTextField.text, !password.isEmpty else {
            print("error")
            return
            
        }
        
        register(email: email, password1: password, password2:checkPassword)
   
    }
    
    func gotoLoginView(){
        guard let gotoLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        gotoLoginVC.modalTransitionStyle = .crossDissolve
        gotoLoginVC.modalPresentationStyle = .fullScreen
        self.present(gotoLoginVC, animated: true, completion: nil)
       
    }
    
    @MainActor
    func register(email: String, password1: String, password2:String) {
        provider.request(.postNewUser(email: email, password1: password1, password2: password2)) { [weak self] result in
            switch result {
            case .success(_):
                self?.gotoLoginView()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}
