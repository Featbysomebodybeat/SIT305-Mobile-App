//
//  MBOrderResultController.swift
//  mab
//
//  Created by Shuo Wang on 10/6/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import UIKit

enum OrderStatus: String {
    case success = "Success!"
    case failed = "Failed!"
}

class MBOrderResultController: MBBaseController {

    var state = OrderStatus.success
    
    /// stateLabel
    @IBOutlet weak var stateLable: UILabel!
    
    /// button
    @IBOutlet weak var closeButton: GMButton!
    
    /// close
    @IBAction private func clickedCloseButton(_ sender: Any) {
        pop(toRoot: state == .success)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setup() {
        super.setup()
        
        stateLable.text = state.rawValue
        if state == .success {
            closeButton.backgroundColor = MBColor.mainTint
            closeButton.setTitle("close", for: .normal)
        }else {
            closeButton.backgroundColor = UIColor.systemRed
            closeButton.setTitle("Reconfirm", for: .normal)
        }
        
    }
    
    override func setBackItem() {
        navigationItem.leftBarButtonItems = nil
    }

}


