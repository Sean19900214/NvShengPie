//
//  ZHXibView.swift
//  ehuangli_swift
//
//  Created by ZhangYuting on 15/4/28.
//  Copyright (c) 2015年 zyt. All rights reserved.
//

import UIKit

@IBDesignable class ZHXibView: UIView {

    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            if self.borderWidth > 0 {
                
                self.setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            
            if self.borderWidth > 0 {
                
                self.setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var round: Bool = false {
        didSet {
            
            self.cornerRadius = self.bounds.size.height / 2.0
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            
            if self.cornerRadius > 0 {
                
                self.setNeedsDisplay()
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        if self.borderWidth > 0{
            
            self.drawBorder(rect)
        }else {
            
            if self.cornerRadius > 0 {
                
                self.drawRadius(rect)
            }
        }
    }
    
    func drawRadius(rect: CGRect) {
        
        self.borderColor.set()
        let br = self.bounds
        let bw = CGFloat(1)
        let r = CGRectMake(bw/2, bw/2, br.size.width - bw, br.size.height - bw)
        
        let c = self.round ? br.size.height/2.0 : self.cornerRadius
        let f = UIBezierPath(roundedRect: r, cornerRadius: c)
        
        let s = CAShapeLayer()
        s.path = f.CGPath
        self.layer.mask = s
    }
    
    func drawBorder(rect: CGRect) {
        
        self.borderColor.set()
        let br = self.bounds
        let bw = self.borderWidth
        let r = CGRectMake(bw/2, bw/2, br.size.width - bw, br.size.height - bw)
                
        let c = self.round ? br.size.height/2.0 : self.cornerRadius
        let f = UIBezierPath(roundedRect: r, cornerRadius: c)
        f.lineWidth = self.borderWidth
        f.lineCapStyle = CGLineCap.Round
        f.stroke()
        
        if self.cornerRadius > 0 {
            
            let s = CAShapeLayer()
            s.path = f.CGPath
            self.layer.mask = s
        }
    }

}
