//
//  Array.swift
//  Chen
//
//  Created by iOS on 2023/10/24.
//

import Foundation

extension Array {
    
    ///  下标取值,不用担心越界
    public subscript (safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// 下标和长度截取子数组
    public subscript (_ startIndex: Int,_ offset: Int) -> [Element] {
        
        if self.isEmpty == false || !indices.contains(startIndex) || offset <= 0 || startIndex + offset > self.count {return []}
        
        let slice = self[startIndex..<startIndex+offset]
        
        return Array(slice)
    }
    
    /// 判断数组是否有某个类型的元素值
    public func containsType<T>(of element: T) -> Bool {
        let elementType = type(of: element)
        return contains { type(of: $0) == elementType}
    }
    
    /// 获得数组的一个随机元素
    public func randomElement() -> Element? {
        guard self.isEmpty == false else { return nil }
        let index = Int(arc4random_uniform(UInt32(count)))
        return self[index]
    }
    
    /// check是否对数组的每个元素返回true
    public func all(_ check: @escaping (Element) -> Bool) -> Bool {
        return !contains { !check($0) }
    }
}

extension Array where Element: Equatable {
    
    /**
     是否包含指定数组的每一个元素
     @Parameters:
     - array:指定数组
     */
    public func containsEveryElement(_ array: [Element]) -> Bool {
        guard self.isEmpty == false,array.isEmpty == false else {return false}
        return array.all { firstIndex(of: $0) ?? -1 >= 0 }
    }
    
    /**
     是否包含指定数组的每一个元素
     @Parameters:
     - elements:指定数组
     */
    public func containsEveryElement(_ elements: Element...) -> Bool {
        containsEveryElement(elements)
    }
    
    /**
     是否包含指定的子数组,返回值(Bool,Int),第一个值表示是否包含,如果包含,则第二个值表示子数组的第一个元素在数组的索引
     @Parameters:
     - array: 子数组
     */
    public func containsSubarray(_ array: [Element]) -> (Bool,Int) {
        guard self.isEmpty == false,array.isEmpty == false,count >= array.count,let firstIndex = firstIndex(of: array[0]),count - firstIndex >= array.count else { return (false,0) }
        let firstIndexes = indexesForElement(array[0])
        var same = 0
        var start = 0
        for i in 0..<firstIndexes.count {
            same = 0
            let index = firstIndexes[i]
            if count - index < array.count { break }
            for j in 0..<array.count {
                if self[index+j] == array[j] {
                    same += 1
                }else {
                    break
                }
            }
            start = index
            if same == array.count { break }
        }
        return (same == array.count,start)
    }
    
    /**
     是否包含指定的子数组,返回值(Bool,Int),第一个值表示是否包含,如果包含,则第二个值表示子数组的第一个元素在数组的索引
     @Parameters:
     - elements: 子数组
     */
    public func containsSubarray(_ elements: Element...) -> (Bool,Int) {
        return containsSubarray(elements)
    }
    
    ///  获取某个元素的所有索引
    public func indexesForElement(_ element: Element) -> [Int] {
        return enumerated().lazy.compactMap { ($0.element == element) ? $0.offset : nil }
    }
    
    /// 移除指定元素element,如果数组中有多个element,则只移除第一个
    public mutating func removeElement(_ element: Element) -> Void {
        guard let index = firstIndex(of: element) else { return }
        remove(at: index)
    }
    
    /// 移除所有指定元素element
    public mutating func removeElements(_ element: Element) -> Void {
        guard let _ = firstIndex(of: element) else { return }
        self = self.lazy.compactMap({ ($0 == element) ? nil : $0 })
    }
    
    /// 移除指定数组的所有元素,如果不包含指定数组的每一个元素,则不做任何操作
    public mutating func removeArrayElements(_ elements: [Element]) -> Void {
        guard containsEveryElement(elements) else { return }
        self = self.lazy.filter { !elements.contains($0) }
    }
    
    /// 移除指定数组的所有元素,如果不包含指定数组的每一个元素,则不做任何操作
    public mutating func removeArrayElements(_ elements: Element...) -> Void {
        removeArrayElements(elements)
    }
    
    /// 移除指定数组,如果数组不包含指定数组,则不做任何操作
    public mutating func removeArray(_ elements: [Element]) -> Void {
        let tuple = containsSubarray(elements)
        guard tuple.0 else { return }
        removeSubrange(tuple.1..<tuple.1+elements.count)
    }
    
    /// 移除指定数组,如果数组不包含指定数组,则不做任何操作
    public mutating func removeArray(_ elements: Element...) -> Void {
        removeArray(elements)
    }
}
