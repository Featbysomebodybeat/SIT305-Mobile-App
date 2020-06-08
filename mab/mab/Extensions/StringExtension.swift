//
//  StringExtension.swift
//  BOYOU
//
//  Created by Shuo Wang on 24/5/20.
//  Copyright © 2020 Shuo Wang. All rights reserved.
//

import Foundation
import SwiftDate
import HandyJSON
import CryptoSwift

extension String {
    
    /// string not null
    public var isNotEmpty: Bool { return !self.isEmpty }

    /// get Int value, if cannot achieve then back to 0
    /// value with decial will transfer to double then Int
    var intValue: Int {
        
        if let intV = Int(self) {
            return intV
        } else if let doubleV = Double(self) {
            return Int(doubleV)
        } else {
            return 0
        }
        
    }
    
    /// get double value, if cannot achieve then back to 0
    var doubleValue: Double {
        if let doubleV = Double(self) {
            return doubleV
        }else {
            return 0.0
        }
    }
    
    /// transfer json
    public func toDic() -> Dictionary<String, Any>? {
        if let data = self.data(using: .utf8) {
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                return result as? Dictionary<String, Any>
            }catch {
                DPrint("解析 jsonString 失败， error: \(error.localizedDescription)")
            }
        }
        return nil
    }
    
    /// string
    public func toSecurity() -> String {
        let tmp = self.replacingOccurrences(of: " ", with: "")
        guard tmp.isNotEmpty else { return "" }
        
        let lenth = tmp.count
        
        switch lenth {
        case 0, 1:
            return self
        case 2, 3, 4:
            var s = ""
            for _ in 0..<lenth {
                s += "*"
            }
            return s + self.gm_subString(from: lenth-1)
        case 5, 6:
            let head = self.gm_subString(to: 1)
            let trail = self.gm_subString(from: 4)
            var s = ""
            for _ in 0..<3 {
                s += "*"
            }
            return head + s + trail
        case 7, 8:
            let head = self.gm_subString(to: 2)
            let trail = self.gm_subString(from: 5)
            var s = ""
            for _ in 0..<3 {
                s += "*"
            }
            return head + s + trail
        case 9:
            let head = self.gm_subString(to: 3)
            let trail = self.gm_subString(from: 6)
            var s = ""
            for _ in 0..<3 {
                s += "*"
            }
            return head + s + trail
        default:
            let head = self.gm_subString(to: 3)
            let trail = self.gm_subString(from: lenth-4)
            var s = ""
            for _ in 0..<lenth-7 {
                s += "*"
            }
            return head + s + trail
        }
    }
    
    /// get string size
    public func getFullSize(font: UIFont, targetSize: CGSize) -> CGSize {
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        let tmp = NSString(string: self)
        return tmp.boundingRect(with: targetSize, options: .usesLineFragmentOrigin, attributes: [.font: font, .paragraphStyle: style], context: nil).size
    }

    /// transfer to date
    public func gm_toDate(format: String) -> Date? {
        return toDate(format)?.date
    }
    
}

extension String {
    
    /// get string
    public func gm_substring(at index: Int) -> String {
        guard index < self.count else { return "" }
        let idx = self.index(startIndex, offsetBy: index)
        return String(self[idx])
    }
    
    /// 从第几个开始截取字符串到最后个
    public func gm_subString(from index: Int) -> String {
        guard index < self.count else {
            return ""
        }
        return self[index..<self.count]
    }
    
    /// 从第一个开始截取字符串到第几个
    public func gm_subString(to index: Int) -> String {
        guard index < self.count else {
            return ""
        }
        return self[0..<index]
    }
    
    /// 直接获取某个位置的Index，当这个Index超出startIndex和endIndex时会返回空，注意字符串endIndex是结束符而不是最后一个字符
    public func gm_index(_ position: Int) -> Index? {
        // 字符串"012"Index的范围是(0,1)到(3,0)
        guard position >= 0, position <= self.count else {
            return nil
        }
        return self.index(self.startIndex, offsetBy:position)
    }
    
    /// 提供substring的下标便捷方式，半闭合区间，当超出范围会返回""或什么都不做
    subscript (r: Range<Int>) -> String {
        get {   // 获取
            if let idxStart = self.gm_index(r.lowerBound), let idxEnd = self.gm_index(r.upperBound) { // 保证在范围内
                return String(self[idxStart..<idxEnd])
            }
            return ""
        }
        
        set {   // 设置
            if let idxStart = self.gm_index(r.lowerBound), let idxEnd = self.gm_index(r.upperBound) {
                let range = idxStart...idxEnd
                self.replaceSubrange(range, with: "")
            }
        }
    }
    
}

// MARK: - 身份证相关
extension String {
    
    /// 是否是身份证号
    public var isIdNo: Bool { return predicate(matched: "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)") }
    
    /// 验证字符串是否是身份证，如果是就返回原字符串，否则返回""
    public func judgeIdNo() -> String { guard self.isIdNo else { return "" }; return self }
    
    /// 是否是女性
    public var isFemale: Bool {
        guard isNotEmpty else { return false }
        if self.count == 15 {
            let tmp = self.gm_substring(at: self.count - 1)
            let tmpInt = Int(tmp) ?? 0
            return (tmpInt % 2 == 0)
        }else {
            let tmp = self.gm_substring(at: self.count - 2)
            let tmpInt = Int(tmp) ?? 0
            return (tmpInt % 2 == 0)
        }
    }
    
    /// 从身份证号获取出生日期, 获取失败就返回今天的日期
    public func getBirthdayDate() -> Date {
        guard self.count >= 15 else {
            return Date()
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        var dateStr = ""
        if self.count == 15 {
            dateStr = "19" + self[6..<12]
        }else {
            dateStr = self[6..<14]
        }
        
        if let birthDate = formatter.date(from: dateStr) {
            return birthDate
        }
        
        return Date()
    }
    
    /// 根据身份证获取年龄
    public func getAge() -> Int {
        let birthDate = getBirthdayDate()
        let today = Date()
        
        var age = today.year - birthDate.year
        if today.month < birthDate.month { age -= 1 }
        return age
    }
    
}

// MARK: - url
extension String {
    // URL Encode
    func URLEncode() -> String {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'\"();@+$,%[]% ").inverted) ?? ""
    }
}

// MARK: - 正则表达式
extension String {
    
    /// 字符串是否是url
    public var isUrl: Bool {
        return predicate(matched: "(https|http|ftp|rtsp|igmp|file|rtspt|rtspu)://((((25[0-5]|2[0-4]\\d|1?\\d?\\d)\\.){3}(25[0-5]|2[0-4]\\d|1?\\d?\\d))|([0-9a-z_!~*'()-]*\\.?))([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\\.([a-z]{2,6})(:[0-9]{1,4})?([a-zA-Z/?_=]*)\\.\\w{1,5}")
    }
    
    /// 是否是电话号码
    public var isPhoneNumber: Bool { return predicate(matched: "^1+[35789]+\\d{9}") }
    
    /// 正则匹配
    public func predicate(matched pattern: String) -> Bool {
        let tmp = self.replacingOccurrences(of: " ", with: "")
        guard tmp.isNotEmpty else {
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with:self)
    }
    
}

// MARK: - 字符串加解密(使用到的第三方库 -> CryptoSwift)
extension String {
    
    /// 获取 MD5(大写) 字符串
    public func upperMD5() -> String {
        return self.md5().uppercased()
    }
    
    /// 字符串AES加密
    ///
    /// - Parameters:
    ///   - key: 16个字符的字符串
    ///   - iv: 16个字符的字符串
    /// - Returns: 加密后的字符串
    public func toAES(key: String = "jiankangwuyouabc", iv: String = "") -> String {
        var encryptedStr = ""
        do {
            if iv.isEmpty {
                let aes = try AES(key: key.bytes, blockMode: ECB(), padding: .pkcs7)
                encryptedStr = try aes.encrypt(self.bytes).toBase64() ?? ""
            }else {
                let aes = try AES(key: key.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7)
                encryptedStr = try aes.encrypt(self.bytes).toBase64() ?? ""
            }
        } catch { DPrint("error \(error.localizedDescription)") }
        return encryptedStr
    }
    
    /// 字符串AES解密
    ///
    /// - Parameters:
    ///   - key: 16个字符的字符串
    ///   - iv: 16个字符的字符串
    /// - Returns: 加密后的字符串
    public func decodeAES(key: String = "jiankangwuyouabc", iv: String = "") -> String {

        //解码 base64
        let data = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)
        
        // byte 数组
        var encrypted: [UInt8] = []
        // 把data 转成byte数组
        for i in 0..<(data?.length ?? 0) {
            var temp:UInt8 = 0
            data?.getBytes(&temp, range: NSRange(location: i,length:1))
            encrypted.append(temp)
        }
        // decode AES
        var decrypted: [UInt8] = []
        do {
            if iv.isEmpty {
                decrypted = try AES(key: key.bytes, blockMode: ECB(), padding: .pkcs7).decrypt(encrypted)
            }else {
                decrypted = try AES(key: key.bytes, blockMode: CBC(iv: iv.bytes), padding: .pkcs7).decrypt(encrypted)
            }
        } catch { DPrint("error \(error.localizedDescription)") }
        
        // byte 转换成NSData
        let encoded = NSData.init(bytes: decrypted, length: decrypted.count)
        //解密结果从data转成string
        let str = String(data: encoded as Data, encoding: .utf8) ?? ""
        return str
        
    }
    
}

// MARK: - 处理汉语拼音
extension String {
    
    /// 拼音首字母(大写)
    var firstLetter: String {
        let pinyinStr = toPinYin()
        let first = pinyinStr.gm_substring(at: 0)
        if first.predicate(matched: "^[a-zA-Z]") {
            return first.uppercased()
        }
        return "#"
    }
    
    /// 将汉语转换成拼音(tone: 是否带声调)
    func toPinYin(tone: Bool = false, first: Bool = false) -> String {
        var tmp = self
        if first {
            // 自定义
            tmp = polyphoneString(tone: tone)
        }
        let cfStr = CFStringCreateMutableCopy(nil, 0, tmp as CFString)
        // 转换成带声调的拼音
        CFStringTransform(cfStr, nil, kCFStringTransformToLatin, false)
        /// 去掉声调
        if !tone {
            CFStringTransform(cfStr, nil, kCFStringTransformStripCombiningMarks, false)
        }
        return (cfStr as String?) ?? ""
    }
    
    /// 自定义汉子首字母处理
    private func polyphoneString(tone: Bool = false) -> String {
        if self.hasPrefix("重") {return tone ? "chóng": "chong"}
        return self
    }

  
}
