//
//  Utils.swift
//  mab
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

/// tool
final class MBUtils: NSObject {
    
    //imer
    var timer: DispatchSourceTimer?
    
    static let shareInstance = MBUtils()
    /// get root
    static func getRootVC() -> UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    /// print AppHome Path
    static func printAppHomePath() {
        DPrint("App SandBox Path == \(NSHomeDirectory())")
    }
    
    /// make a call
    static func callPhone(numbers: Array<String>) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for number in numbers {
            let action = UIAlertAction(title: number, style: .default, handler: { (act) in
                let urlStr = "tel://" + (act.title ?? "")
                if let url = URL(string: urlStr) {
                    //                    UIApplication.shared.openURL(url)
                    UIApplication.shared.open(url)
                }
            })
            alert.addAction(action)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    // get icon path
    static func getHeadImagePath(_ fileName: String = "headImage") -> String {
       let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? ""
        let downloadFilePath = cachePath  + "/" + fileName
        return  downloadFilePath

    }
    
}

extension MBUtils {
    // count lines
    static func getRows(column: Int, amount: Int) -> Int {
        var row = amount / column
        let change = amount % column
        if change > 0 {
            row += 1
        }
        return row
    }
}



extension MBUtils {
    
    func DispatchTimer(_ timeInterval: Double, _ repeatCount:Int, handler:@escaping (DispatchSourceTimer?, Int)->())
    {
        if repeatCount <= 0 {
            return
        }
        
        var count = repeatCount
        let  timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        self.timer = timer
        timer.schedule(wallDeadline: .now(), repeating: timeInterval)
        timer.setEventHandler(handler: {
            count -= 1
            DispatchQueue.main.async {
                handler(timer, count)
            }
            if count == 0 {
                timer.cancel()
                self.timer = nil
                self.timer?.cancel()
            }
        })
        timer.resume()
    }
}

// MARK:----date & String convert

extension MBUtils {
    
  static func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let dateString = formatter.string(from: date)
        return dateString
    }
    
   static func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }
    
}

extension MBUtils  {
    
    static func noMoreThanVersion(_ version: String) -> Bool {
        let order = UIDevice.current.systemVersion.compare(version)
        return (order != .orderedAscending)
    }
    
    /// generate attributted text
     static func attributedText(fromText text: String, color: UIColor, font: UIFont, lineSpace: CGFloat) -> NSAttributedString {
         
         let style = NSMutableParagraphStyle()
         style.lineSpacing = lineSpace
         style.lineBreakMode = .byWordWrapping
        return NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.foregroundColor:color,NSAttributedString.Key.paragraphStyle:style])
        

     }
}

extension MBUtils {
    
    static func inputEmoj(text:String)->Bool {
        let primaryLanguage = UIApplication.shared.textInputMode?.primaryLanguage
        if(primaryLanguage == nil){
            return true
        }else{
            return false
        }
    }

}

extension MBUtils {
    /// get invisible tel
       static func securityPhoneNumber(_ phone: String) -> String {
        
           if phone.count < 8 {
               return ""
           }
        let beginIndex = phone.index(phone.startIndex, offsetBy: 3)
        let endIndex = phone.index(phone.startIndex, offsetBy: 7)
        return phone.replacingCharacters(in: beginIndex..<endIndex, with: "xxxx")
    
       }
       
      
}
