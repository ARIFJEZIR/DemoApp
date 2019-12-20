//
//  UITextFieldExtension.swift
//  TaxiTerrainDriver
//
//  Created by Vino on 16/04/18.
//  Copyright © 2018 Athi. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func makeLeftContent(_ isFirstLetterCaps: Bool = true){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.height))
        self.leftView = view
        self.leftViewMode = .always
        self.rightView = view
        self.rightViewMode = .always
        self.autocapitalizationType = isFirstLetterCaps ? .words : .none
        self.textColor = UIColor.black
        self.font = UIFont.systemFont(ofSize: 15.0)
    }
    
    func addRightImage(_ image: UIImage = #imageLiteral(resourceName: "search_icon")){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.height))
        self.leftView = view
        self.leftViewMode = .always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.height, height: self.height))
        imgView.image = image
        imgView.contentMode = .center
        self.rightView = imgView
        self.rightViewMode = .always
        self.textColor = UIColor.white
        self.font = UIFont.boldCabinFont(13)
    }
    
    func shadow(){
        self.layer.shadowColor = UIColor.appShadow.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
    }
    

  
    
}

extension UITextView{
    func shadow(_ color: UIColor = .appShadow){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        self.textColor = UIColor.black
        self.font = UIFont.systemFont(ofSize: 15.0)
    }
    
//    func addBorder(){
//        self.layer.borderWidth = 0.5
//        self.layer.borderColor = UIColor(hexString: "D4D8DD")?.cgColor
//    }
}

extension UIButton{
    func circleButton(){
        self.layer.cornerRadius = self.width / 2
        self.layer.masksToBounds = true
    }
    
    func circleShadowBtn(){
        self.layer.cornerRadius = self.width / 2
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.appShadow.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: layer.cornerRadius).cgPath
        
    }
}
