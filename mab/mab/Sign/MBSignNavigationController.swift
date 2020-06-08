//
//  MBSignNavigationController.swift
//  mab
//
//  Created by Shuo Wang on 2020/6/2.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

class MBSignNavigationController: UINavigationController, MBStoryboardable {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isHidden = true
    }

}
