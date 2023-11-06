//
//  UIViewEx.swift
//  Chen
//
//  Created by iOS on 2023/11/3.
//

import UIKit

extension UIView {
    
    /// EZSE: getter and setter for the x coordinate of the frame's origin for the view.
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame = CGRect(x: newValue, y: self.y, width: self.w, height: self.h)
        }
    }

    /// EZSE: getter and setter for the y coordinate of the frame's origin for the view.
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame = CGRect(x: self.x, y: newValue, width: self.w, height: self.h)
        }
    }

    /// EZSE: variable to get the width of the view.
    public var w: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame = CGRect(x: self.x, y: self.y, width: newValue, height: self.h)
        }
    }

    /// EZSE: variable to get the height of the view.
    public var h: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame = CGRect(x: self.x, y: self.y, width: self.w, height: newValue)
        }
    }

    /// EZSE: getter and setter for the x coordinate of leftmost edge of the view.
    public var left: CGFloat {
        get {
            return self.x
        }
        set {
            self.x = newValue
        }
    }

    /// EZSE: getter and setter for the x coordinate of the rightmost edge of the view.
    public var right: CGFloat {
        get {
            return self.x + self.w
        }
        set {
            self.x = newValue - self.w
        }
    }

    /// EZSE: getter and setter for the y coordinate for the topmost edge of the view.
    public var top: CGFloat {
        get {
            return self.y
        }
        set {
            self.y = newValue
        }
    }

    /// EZSE: getter and setter for the y coordinate of the bottom most edge of the view.
    public var bottom: CGFloat {
        get {
            return self.y + self.h
        }
        set {
            self.y = newValue - self.h
        }
    }

    /// EZSE: getter and setter the frame's origin point of the view.
    public var origin: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            self.frame = CGRect(origin: newValue, size: self.frame.size)
        }
    }

    /// EZSE: getter and setter for the X coordinate of the center of a view.
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }

    /// EZSE: getter and setter for the Y coordinate for the center of a view.
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }

    /// EZSE: getter and setter for frame size for the view.
    public var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame = CGRect(origin: self.frame.origin, size: newValue)
        }
    }

    /// EZSE: getter for an leftwards offset position from the leftmost edge.
    public func leftOffset(_ offset: CGFloat) -> CGFloat {
        return self.left - offset
    }

    /// EZSE: getter for an rightwards offset position from the rightmost edge.
    public func rightOffset(_ offset: CGFloat) -> CGFloat {
        return self.right + offset
    }

    /// EZSE: aligns the view to the top by a given offset.
    public func topOffset(_ offset: CGFloat) -> CGFloat {
        return self.top - offset
    }

    /// EZSE: align the view to the bottom by a given offset.
    public func bottomOffset(_ offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    /// UIView.animate(withDuration: duration, animations: animations, completion: completion)
    public func uiviewAnimate(_ duration: TimeInterval = 1.0,_ animations: @escaping (() -> Void), completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
}
