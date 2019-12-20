//
//  UIColorExtension.swift
//  MyProof
//
//  Created by Athi S on 01/07/19.
//  Copyright © 2019 gsmplus. All rights reserved.
//

import UIKit

extension UIColor {
    //MARK: - init method with RGB values from 0 to 255, instead of 0 to 1. With alpha(default:1)
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    //MARK: - init method with hex string and alpha(default: 1)
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)        }
        else {
            return nil
        }
    }
    
    //MARK: - init method from Gray value and alpha(default:1)
    public convenience init(gray: CGFloat, alpha: CGFloat = 1) {
        self.init(red: gray/255, green: gray/255, blue: gray/255, alpha: alpha)
    }
    
    //MARK: - Red component of UIColor (get-only)
    public var redComponent: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }
    
    //MARK: - Green component of UIColor (get-only)
    public var greenComponent: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }
    
    //MARK: - blue component of UIColor (get-only)
    public var blueComponent: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
    
    //MARK: - Alpha of UIColor (get-only)
    public var alpha: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
    public class var appNavTint: UIColor {
        return UIColor(hexString: "#2D5672")!
    }
    public class var appPurple: UIColor {
        return UIColor(r: 89.0, g: 83.0, b: 253.0)
    }
    public class var appBlueGrey: UIColor {
        return UIColor(r: 78.0, g: 96.0, b: 131.0)
    }
    public class var appShadow: UIColor {
        return UIColor(r: 212.0, g: 216.0, b: 221.0)
    }
    public class var calenderTitle: UIColor {
        return UIColor(r: 180.0, g: 185.0, b: 199.0)
    }
    public class var appTextGrey: UIColor {
        return UIColor(r: 152.0, g: 152.0, b: 152.0)
    }
    public class var appTextBlue: UIColor {
        return UIColor(hexString: "#3497FD")!
    }
    public class var appLineColor: UIColor {
        return UIColor(r: 230.0, g: 230.0, b: 230.0)
    }
    
    public class var appTextDark: UIColor {
        return UIColor(r: 33.0, g: 33.0, b: 33.0)
    }
    
    public class var appIconDark: UIColor {
        return UIColor(r: 99.0, g: 99.0, b: 99.0)
    }
    
    public class var appTextLight: UIColor {
        return UIColor(r: 120.0, g: 127.0, b: 141.0)
    }
    
    public class var appBackground: UIColor {
        return UIColor(hexString: "#F7F7FA")!
    }
    
    public class var appLoginBG: UIColor {
        return UIColor(hexString: "#5166B0")!
    }
    
    public class var appLinkColor: UIColor {
        return UIColor(hexString: "#00F5FF")!
    }
    public class var appBaseColor: UIColor {
        return UIColor(hexString: "#225FC4")!
    }
    public class var editBtnColor: UIColor {
        return UIColor(hexString: "#03AEEF")!
    }
    
    public class var grayColor: UIColor {
        return UIColor(hexString: "#D8D8D8")!.withAlphaComponent(56)
    }
    
}







