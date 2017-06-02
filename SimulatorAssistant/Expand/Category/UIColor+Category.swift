//
//  UIColor+Category.swift
//  SimulatorAssistant
//
//  Created by 齐科 on 2017/5/26.
//  Copyright © 2017年 齐科. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func mainBGColor() -> UIColor {
        return hexStringToColor(hexString: "F9F9F9")
    }
    
    class func karRed() -> UIColor {
        return UIColor.init(colorLiteralRed: 255.0 / 255.0, green: 75.0 / 255.0, blue: 98.0 / 255.0, alpha: 1.0)
    }
    
    class func karPink() -> UIColor {
        return UIColor.init(colorLiteralRed: 255.0 / 255.0, green: 200.0 / 255.0, blue: 207.0 / 255.0, alpha: 1.0)
    }
    
    class func karBule() -> UIColor {
        return UIColor.init(colorLiteralRed: 0.0 / 255.0, green: 188.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
    }
    
    class func hexStringToColor(hexString: String) -> UIColor{
        
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if cString.characters.count < 6 {return UIColor.black}
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        
        if cString.hasPrefix("0X") {cString = cString.substring(from: index)}
        
        if cString.hasPrefix("#") {cString = cString.substring(from: index)}
        
        if cString.characters.count != 6 {return UIColor.black}
        
        
        
        var range: NSRange = NSMakeRange(0, 2)
        
        let rString = (cString as NSString).substring(with: range)
        
        range.location = 2
        
        let gString = (cString as NSString).substring(with: range)
        
        range.location = 4
        
        let bString = (cString as NSString).substring(with: range)
        
        
        
        var r: UInt32 = 0x0
        
        var g: UInt32 = 0x0
        
        var b: UInt32 = 0x0
        
        Scanner.init(string: rString).scanHexInt32(&r)
        
        Scanner.init(string: gString).scanHexInt32(&g)
        
        Scanner.init(string: bString).scanHexInt32(&b)
        
        
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1))
    }
    
}
