//
//  ZHProressView.swift
//  UI
//
//  Created by ZhangYuting on 15/8/5.
//  Copyright © 2015年 wjt. All rights reserved.
//

import UIKit

class ZHProressView: UIView {

    var progress : CGFloat = 0 {
    
        didSet{
            
            self.setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        

    }
    
    
    override func drawRect(rect: CGRect) {

        self.drawProgress(rect, margin: 3, color: UIColor.redColor(), pro: progress)
    }
    
    
    
    func drawProgress(rect : CGRect, margin : CGFloat, color : UIColor, pro : CGFloat) {
        
        if pro >= 1 || pro <= 0{

            self.hidden = true
            return
        }
        self.hidden = false

        let radius = CGFloat(50)
        let startAngle = CGFloat(-M_PI_2)
        let endAngle = CGFloat(CGFloat(M_PI)*2*pro - CGFloat(M_PI_2))
        
        let centerX = CGRectGetWidth(rect) / 2
        let centerY = CGRectGetHeight(rect) / 2
        
        //底层圆环
        UIColor(red: 173/255, green: 195/255, blue: 216/255, alpha: 1).set()
        let insideFrame = UIBezierPath(ovalInRect: CGRectMake(centerX - radius/2, centerY - radius/2, radius, radius))
        insideFrame.lineWidth = 3
        insideFrame.stroke()
        //进度
        UIColor(red: 51/255, green: 118/255, blue: 1, alpha: 1).set()
        let p = UIBezierPath(arcCenter: CGPointMake(centerX, centerY), radius: radius/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        p.lineWidth = 3
        p.stroke()

        let context = UIGraphicsGetCurrentContext()
        //画实心圆
        CGContextSetAllowsAntialiasing(context, true)
        CGContextSetFillColorWithColor(context, UIColor(red: 173/255, green: 195/255, blue: 216/255, alpha: 1).CGColor)
        CGContextSetLineWidth(context, 20)
        CGContextMoveToPoint(context, centerX, centerY)
        CGContextAddArc(context, centerX, centerY, 20, 0, CGFloat(M_PI*2), 0)
        CGContextClosePath(context)
        CGContextFillPath(context)
        
        let s = "\(Int(pro*100))%" as NSString
        
        let size = NSString(string: s).boundingRectWithSize(CGSizeMake(50, 20), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : UIFont.systemFontOfSize(14)], context: nil).size
        s.drawInRect(CGRectMake(centerX - size.width/2, centerY - size.height/2, size.width, size.height), withAttributes: [NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(14)])
    }

}
