//
//  GMPresentationBaseNavController.swift
//  TestDemo
//
//  Created by Leo on 2018/11/5.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

class GMPresentationBaseNavController: UINavigationController, MBStoryboardable {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
        setup()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        modalPresentationStyle = .custom
    }

}
