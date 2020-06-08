//
//  MBRegisterController.swift
//  mab
//
//  Created by Shuo Wang on 2020/6/2.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBRegisterController: MBBaseController {

    // phone field
    @IBOutlet weak var phoneField: UITextField!
    /// name field
    @IBOutlet weak var nameField: UITextField!
    /// pwd field
    @IBOutlet weak var pwdField: UITextField!
    /// verify field
    @IBOutlet weak var pwdVerifyField: UITextField!
    
    /// back to login
    @IBAction private func backToLogin(_ sender: Any) {
        pop()
    }
    
    /// sign up
    @IBAction private func signUp(_ sender: Any) {
        if pwdVerifyField.text != pwdField.text {
            showCenterToast("Inconsistent passwords!")
            return
        }
        var user = UserInfo()
        user.name = nameField.text ?? ""
        user.phone = phoneField.text ?? ""
        user.pwd = pwdField.text ?? ""
        
        showLoading()
        MBUserCenter.shared.signUp(user) { [weak self] (result) in
            self?.hideLoading()
            
            switch result {
            case .success(_):
                self?.pop()
                self?.showCenterToast("Sign up succeed!")
            case .failure(let error):
                self?.showCenterToast(error.localizedDescription)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - UITextFieldDelegate
extension MBRegisterController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.returnKeyType {
        case .next:
            if textField == nameField {
                pwdField.becomeFirstResponder()
            }else {
                pwdVerifyField.becomeFirstResponder()
            }
            return false
        case .done:
            textField.resignFirstResponder()
            return false
        default:
            return true
        }
    }
    
}
