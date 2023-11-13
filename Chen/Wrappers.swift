//
//  Wrappers.swift
//  Chen
//
//  Created by iOS on 2023/11/7.
//

import UIKit

@propertyWrapper public struct aaaaaa<value: StringProtocol> {
    
    public var projectedValue: Bool = false
    
    public var wrappedValue: String {
        set {
            
        }
        
        get {
            return "aa"
        }
    }
    public init() {
        
    }
}
