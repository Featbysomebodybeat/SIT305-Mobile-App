//
//  MBSignNavigationController.swift
//  mab
//
//  Created by Shuo Wang on 2/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBSignNavigationController: UINavigationController, MBStoryboardable {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }

}
