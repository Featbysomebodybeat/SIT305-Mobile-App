//
//  GMPresentationBaseController.swift
//  TestDemo
//
//  Created by Leo on 2018/11/5.
//  Copyright © 2018 Leo. All rights reserved.
//

import UIKit

class GMPresentationBaseController: UIViewController,MBStoryboardable {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        modalPresentationStyle = .custom
    }


}
