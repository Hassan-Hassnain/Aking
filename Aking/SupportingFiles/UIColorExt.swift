//
//  UIColorExt.swift
//  Aking
//
//  Created by Usama Sadiq on 4/16/20.
//  Copyright © 2020 Usama Sadiq. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    func toRGBAString(uppercased: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgba = [r, g, b, a].map { $0 * 255 }.reduce("", { $0 + String(format: "%02x", Int($1)) })
        return uppercased ? rgba.uppercased() : rgba
    } // out put as "00000000"
    
    public convenience init?(hexaDecimalString: String) {
        
        let r, g, b, a: CGFloat
        
        if hexaDecimalString.hasPrefix("#") {
            let start = hexaDecimalString.index(hexaDecimalString.startIndex, offsetBy: 1)
            let hexColor = hexaDecimalString.substring(from: start)
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    //Convert RGBA String to UIColor object
    //"rgbaString" must be separated by space "0.5 0.6 0.7 1.0" 50% of Red 60% of Green 70% of Blue Alpha 100%
    public convenience init?(rgbaString : String){
        self.init(ciColor: CIColor(string: rgbaString))
    }
    
    //Convert UIColor to RGBA String
    func toRGBAString()-> String {
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return "\(r) \(g) \(b) \(a)"
        
    }// output as  "0.0 0.0 0.0 0.0"
    
    // Convert UIColor to Hexadecimal String
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
}

