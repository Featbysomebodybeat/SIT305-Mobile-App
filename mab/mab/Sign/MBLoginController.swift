//
//  MBLoginController.swift
//  mab
//
//  Created by Shuo Wang on 2/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBLoginController: MBBaseController {

    /// phone field
    @IBOutlet weak var phoneField: UITextField!
    /// pwd field
    @IBOutlet weak var pwdField: UITextField!
    
    /// login
    @IBAction private func login(_ sender: Any) {
        guard let phone = phoneField.text, let pwd = pwdField.text else {
            return
        }
        
        showLoading()
        MBUserCenter.shared.login(phone: phone, pwd: pwd) { [weak self] (result) in
            self?.hideLoading()
            
            switch result {
            case .success(_):
                self?.showCenterToast("Login success")
                delay(seconds: 1) {
                    MBApplication.switchToMain()
                }
            case .failure(let error):
                self?.showErrorMessage(error.localizedDescription)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}

// MARK: - UITextFieldDelegate
extension MBLoginController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.returnKeyType {
        case .next:
            pwdField.becomeFirstResponder()
            return false
        case .done:
            textField.resignFirstResponder()
            return false
        default:
            return true
        }
    }
    
}
