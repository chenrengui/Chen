//
//  String.swift
//  Chen
//
//  Created by iOS on 2023/10/24.
//

import Foundation

extension String {
    
    /// 将Float转为特殊格式和指定小数位数的字符串,格式默认为.decimal
    init(_ value: Float,_ style: NumberFormatter.Style = .decimal,_ precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = style
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }
    
    /// 将Double转为特殊格式和指定小数位数的字符串,格式默认为.decimal
    init(_ value: Double,_ style: NumberFormatter.Style = .decimal,_ precision: Int) {
        let nFormatter = NumberFormatter()
        nFormatter.numberStyle = style
        nFormatter.maximumFractionDigits = precision
        self = nFormatter.string(from: NSNumber(value: value))!
    }
}

extension String {
    
    /// 下标获取某个字符,返回值为String
    public subscript (_ index: Int) -> String {
        guard length > 0,index < length else { return "" }
        let i = self.index(startIndex, offsetBy: index)
        return String(self[i])
    }
    
    /// 下标和长度截取子字符串
    public subscript (_ index: Int,_ offset: Int) -> String {
        
        guard length > 0,index < length,offset > 0,index + offset <= length else { return "" }
        
        let start = self.index(startIndex, offsetBy: index)
        
        let end = self.index(start, offsetBy: offset)
        
        return String(self[start..<end])
    }
    
    /// 下标和长度截取子字符串
    public subscript (_ range: Range<Int>) -> String {
        return self[range.lowerBound,range.upperBound - range.lowerBound]
    }
    
    /// 下标和长度截取子字符串
    public subscript (_ range: ClosedRange<Int>) -> String {
        return self[range.lowerBound,range.upperBound - range.lowerBound + 1]
    }
    
    /// 字符串长度
    public var length: Int {
        return self.count
    }
    
    /// 是否只有空格和换行的字符串
    public var isBlank: Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    /// 包含指定子字符串的个数
    public func countOfSubstring(_ substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }
    
    /// 去掉首尾的空格和换行
    public func trimmed() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// 字符串转NSNumber
    public func toNumber() -> NSNumber? {
        return NumberFormatter().number(from: self)
    }
    
    /// 字符串转Bool
    public func toBool() -> Bool? {
        let trimmedString = trimmed().lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }
    
    /**
     把浮点型字符串转为特殊格式和指定小数位的字符串
     @Parameters:
     - style: 格式,默认.decimal
     - precision: 小数位数
     */
    public func floatingPointString(_ style: NumberFormatter.Style = .decimal,_ precision: Int) -> String {
        guard let num = NumberFormatter().number(from: self) else { return self }
        return String(num.doubleValue,style,precision)
    }
}
