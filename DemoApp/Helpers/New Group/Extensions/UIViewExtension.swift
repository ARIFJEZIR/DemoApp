//
//  UIViewExtension.swift
//  MyProof
//
//  Created by Athi S on 03/07/19.
//  Copyright © 2019 gsmplus. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    var width:      CGFloat { return self.frame.size.width }
    var height:     CGFloat { return self.frame.size.height }
    var size:       CGSize  { return self.frame.size}
    
    var origin:     CGPoint { return self.frame.origin }
    var x:          CGFloat { return self.frame.origin.x }
    var y:          CGFloat { return self.frame.origin.y }
    var centerX:    CGFloat { return self.center.x }
    var centerY:    CGFloat { return self.center.y }
    
    var left:       CGFloat { return self.frame.origin.x }
    var right:      CGFloat { return self.frame.origin.x + self.frame.size.width }
    var top:        CGFloat { return self.frame.origin.y }
    var bottom:     CGFloat { return self.frame.origin.y + self.frame.size.height }
    var YMax:       CGFloat { return self.y + self.height }
    var XMax:       CGFloat { return self.x + self.width }
    
    
    func setX(x:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.x = x
        self.frame = frame
    }
    
    func setY(y:CGFloat) {
        var frame:CGRect = self.frame
        frame.origin.y = y
        self.frame = frame
    }
    
    func setWidth(width:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.width = width
        self.frame = frame
    }
    
    func setHeight(height:CGFloat) {
        var frame:CGRect = self.frame
        frame.size.height = height
        self.frame = frame
    }
    
    func setShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    func roundCorners(_ radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    
    func cornerView(){
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius  = 25
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        } else {
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath
              self.layer.mask = maskLayer
        }

        
      
    }
    
    func addBorder(){
        self.layer.borderWidth = 0.8
        self.layer.borderColor = UIColor.white.cgColor                      //UIColor(hexString: "#D4D8DD")?.cgColor
        self.layer.cornerRadius = 18
    }
    func addWebViewBorder(){
        self.layer.borderWidth = 0.8
        self.layer.borderColor = UIColor.appTextLight.cgColor                    //UIColor(hexString: "#D4D8DD")?.cgColor
        self.layer.cornerRadius = 18
    }
    
    @IBInspectable var cornerRadiusView: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}


    extension UITableView {
        func scrollToBottom(animated: Bool = true) {
            let sections = self.numberOfSections
            let rows = self.numberOfRows(inSection: sections - 1)
            if (rows > 0){
                self.scrollToRow(at: IndexPath(row: rows - 1, section: sections - 1), at: .bottom, animated: true)
            }
        }
    }




extension UIScrollView {
    var currentPage:Int{
        return Int((self.contentOffset.x+(0.5*self.frame.size.width))/self.frame.width)+1
    }
}

extension UIButton {
    
    
    func addBtnBorder(){
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.white.cgColor                //UIColor(hexString: "#D4D8DD")?.cgColor
        self.layer.cornerRadius = 25
    }
    
    func editDeleteBorder() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.editBtnColor.cgColor              //UIColor(hexString: "#D4D8DD")?.cgColor
        self.layer.cornerRadius = 25
    }
}

