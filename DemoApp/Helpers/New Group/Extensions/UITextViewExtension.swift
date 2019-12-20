//
//  UITextViewExtension.swift
//  MyProof
//
//  Created by Athi S on 04/07/19.
//  Copyright © 2019 gsmplus. All rights reserved.
//

import Foundation
import UIKit

class LinedTextView : UITextView {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderWidth = 0
    }
    
    
    
    //    override func draw(_ rect: CGRect)
    //    {
    //        let context = UIGraphicsGetCurrentContext()
    //        context?.setLineWidth(1.0)
    //        let colorSpace = CGColorSpaceCreateDeviceRGB()
    //        let components: [CGFloat] = [0.0, 0.0, 1.0, 1.0]
    //        let color = CGColor(colorSpace: colorSpace, components: components)
    //        context?.setStrokeColor(color!)
    //        context?.move(to: CGPoint(x: 30, y: 30))
    //        context?.addLine(to: CGPoint(x: 300, y: 400))
    //        context?.closePath()
    //        context?.strokePath()
    //    }
    
    var lineHeight: CGFloat = 50.0
    
    override var font: UIFont? {
        didSet {
            if let newFont = font {
                lineHeight = newFont.lineHeight 
                
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setStrokeColor(UIColor.black.cgColor)
        let numberOfLines = Int(rect.height / lineHeight)
        let topInset = textContainerInset.top
        ctx?.setLineWidth(0.5)
        for i in 1...numberOfLines {
            let y = topInset + CGFloat(i) * lineHeight
            
            let line = CGMutablePath()
            line.move(to: CGPoint(x: 0.0, y: y))
            line.addLine(to: CGPoint(x: rect.width, y: y))
            ctx?.addPath(line)
        }
        
        ctx?.strokePath()
        
        super.draw(rect)
    }
}


