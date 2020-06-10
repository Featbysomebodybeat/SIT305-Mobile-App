//
//  MBRootController.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBRootController: MBBaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delay(seconds: 2) {
            self.switchRoot()
        }
    }
    
    override func setup() {
        // to prepare datas
        MBDatabaseManager.copyDbFileToSandbox()
        MBDatabaseManager.createTables { (success) in
            if success {
                DPrint("Create tables succeed")
            }else {
                DPrint("Create tables failed")
            }
        }
    }
    
    private func switchRoot() {
        if MBUserCenter.shared.isSignedIn {
            MBApplication.switchToMain()
        }else {
            MBApplication.switchToUserSign()
        }
    }

}
