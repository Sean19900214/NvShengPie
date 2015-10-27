//
//  ZHConfig.swift
//  ehuangli_swift
//
//  Created by ZhangYuting on 15/4/17.
//  Copyright (c) 2015 zyt. All rights reserved.
//

import Foundation
import UIKit


// MARK: APP常用色值
func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) ->UIColor{
    
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

let ZHColorBackground = RGBA(215,g: 220,b: 222,a: 1)
let ZHColorBlue = RGBA(19,g: 105,b: 177,a: 1)
let ZHColorDarkBlue = RGBA(30,g: 67,b: 185,a: 1)





// MARK: 坐标系
func kWidth () ->CGFloat{
    
    return UIScreen.mainScreen().bounds.size.width;
}

func kHeight () ->CGFloat{
    
    return UIScreen.mainScreen().bounds.size.height;
}

func ZHX (view : UIView) ->CGFloat{
    
    return view.frame.origin.x;
}

func ZHY (view : UIView) ->CGFloat{
    
    return view.frame.origin.y;
}

func ZHWidth (view : UIView) ->CGFloat{
    
    return view.frame.size.width;
}

func ZHHeight (view : UIView) ->CGFloat{
    
    return view.frame.size.height;
}




// MARK: 常用配置参数
func appServer() -> String {
    
    let dic : NSDictionary = NSBundle.mainBundle().infoDictionary! as NSDictionary
    let s : Bool = dic["InTestServer"]!.boolValue
    return s ? "test" : "www"
}
func appVersion() -> String {
    
    let dic : NSDictionary = NSBundle.mainBundle().infoDictionary! as NSDictionary
    return dic["CFBundleShortVersionString"] as! String
}

func systemV() -> Float {
    
    let s = UIDevice.currentDevice().systemVersion as NSString
    
    return s.floatValue
}

func isOnline() -> String {
    
    let dic : NSDictionary = NSBundle.mainBundle().infoDictionary! as NSDictionary

    if dic["CFBundleIdentifier"]! as! String == "com.aps.reselling" {
    
        return "ios_aps"
    }else if dic["CFBundleIdentifier"]! as! String == "com.wjt.reselling" {
        
        return "ios_tm"
    }
    
//    #if DEBUG
//        s = "ios_tm"
//    #endif

    return "ios_aps"
}

func appChannel() -> String {
    
    let dic : NSDictionary = NSBundle.mainBundle().infoDictionary! as NSDictionary
    
    if dic["CFBundleIdentifier"]! as! String == "com.aps.reselling" {
        
        return "AppStore"
    }else if dic["CFBundleIdentifier"]! as! String == "com.wjt.reselling" {
        
        return "企业版"
    }
    return "AppStore"
}

/**
内部版本号
*/
func internalVersion() -> String {
    
    let dic : NSDictionary = NSBundle.mainBundle().infoDictionary! as NSDictionary
    return dic["InternalVersion"] as! String
}

/**
生成文件名
*/
func getFileName() -> String{
    
    let date : NSDate = NSDate(timeIntervalSinceNow: 0)
    return "_\(Int(date.timeIntervalSince1970)).jpg"
}


/**
计算下一页
- parameter count: 当前数组长度
*/
func nextPageIndex(count : Int) -> Int {

    if count < 20 {
        
        return 2
    }
    
    let x = count%20 == 0 ? 0 : 1
    
    return count/20 + x + 1
}







// MARK: 时间相关函数
///yyyy-MM-dd
let zh_timeFormatStr1 : String = "yyyy-MM-dd"
///yyyy-MM-dd EEEE
let zh_timeFormatStr2 : String = "yyyy-MM-dd EEEE"
///yyyy-MM-dd HH:mm:ss
let zh_timeFormatStr3 : String = "yyyy-MM-dd HH:mm:ss"

func zh_formatTime (date : NSDate, format : String) ->String{
    
    let dateFormat : NSDateFormatter = NSDateFormatter()
    dateFormat.locale = NSLocale(localeIdentifier: "zh_CN")
    dateFormat.dateFormat = format
    
    return dateFormat.stringFromDate(date)
}

func zh_formatTimeInterval (time : Double?, format : String) ->String {
    
    if let t = time {
    
        let date = NSDate(timeIntervalSince1970: t)
        
        let dateFormat : NSDateFormatter = NSDateFormatter()
        dateFormat.locale = NSLocale(localeIdentifier: "zh_CN")
        dateFormat.dateFormat = format
        
        return dateFormat.stringFromDate(date)
    }
    return ""
}

func zh_formatTimeInterval (time : NSString?, format : String) ->String {
    
    if let t = time {

        let date = NSDate(timeIntervalSince1970: t.doubleValue)
        
        let dateFormat : NSDateFormatter = NSDateFormatter()
        dateFormat.locale = NSLocale(localeIdentifier: "zh_CN")
        dateFormat.dateFormat = format
        
        return dateFormat.stringFromDate(date)
    }

    return ""
}

func zh_formatTimeInterval (timeInterval : Double?) -> String {
    
    if timeInterval == nil{
        return ""
    }
    
    let formdate = NSDate(timeIntervalSince1970: timeInterval!)
    let date = NSDate()
    
    let gregorian = NSCalendar(calendarIdentifier: NSGregorianCalendar)
    let unitflags: NSCalendarUnit = [NSCalendarUnit.NSMonthCalendarUnit, NSCalendarUnit.NSDayCalendarUnit]
    
    let dateFormat = NSDateFormatter()
    dateFormat.locale = NSLocale(localeIdentifier: "zh_CN")

    let com1 = gregorian?.components(unitflags, fromDate: formdate)
    let com2 = gregorian?.components(unitflags, fromDate: date)

    if com1?.month == com2?.month && com1?.day == com2?.day {
        
        dateFormat.dateFormat = "HH:mm"
        return "今天 \(dateFormat.stringFromDate(formdate))"
        
    }else if com1?.month == com2?.month && com1?.day == (com2!.day-1) {
        
        dateFormat.dateFormat = "HH:mm"
        return "昨天 \(dateFormat.stringFromDate(formdate))"
    }else {
        
        dateFormat.dateFormat = "yyyy-MM-dd"
        return "\(dateFormat.stringFromDate(formdate))"
    }
}

func zh_getCurrentTime (format : String) ->String{
    
    let dateFormat : NSDateFormatter = NSDateFormatter()
    dateFormat.locale = NSLocale(localeIdentifier: "zh_CN")
    dateFormat.dateFormat = format
    
    return dateFormat.stringFromDate(NSDate())
}

func zh_getCurrentTimeInterval() -> NSTimeInterval {
    
    return NSDate(timeIntervalSinceNow: 0).timeIntervalSince1970
}


// MARK: 自定义UI控件快捷调用方式
/**
显示Action

- parameter vc:             父视图控制器
- parameter title:          标题
- parameter msg:            内容
- parameter actions:        按钮标题数组
- parameter didSelectBlock: 按下按钮回调，取消的回调是-1，其它的按照数组顺序返回下标
*/
/*
func showActionSheetToVc(
    vc : UIViewController,
    title : String?,
    msg : String?,
    actions : NSArray,
    didSelectBlock: ((idx : Int) -> Void)?
    ){

        if #available(iOS 8.0, *) {
            let actionSheet = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (ac) -> Void in
                
                if didSelectBlock != nil {
                    
                    didSelectBlock!(idx : -1)
                }
                actionSheet.dismissViewControllerAnimated(true, completion: nil)
            }
            actionSheet.addAction(cancel)
            
            for (idx, str) in actions.enumerate(){
                
                let action = UIAlertAction(title: (str as! String), style: UIAlertActionStyle.Default) { (ac) -> Void in
                    
                    print("\(idx),\(str)")
                    if didSelectBlock != nil {
                        
                        didSelectBlock!(idx : idx)
                    }
                }
                actionSheet.addAction(action)
            }
            
            vc.presentViewController(actionSheet, animated: true, completion: nil)
        } else {
            
            let t = (title == nil ? "" : title!) + "\n" + (msg == nil ? "" : msg!)
            let ac = UIActionSheet(title: t, delegate: nil, cancelButtonTitle: nil, destructiveButtonTitle: nil)
            for (_, str) in actions.enumerate(){
                
                ac.addButtonWithTitle(str as? String)
            }
            ac.addButtonWithTitle("取消")
            ac.showInView(UIApplication.sharedApplication().keyWindow!)

            ac.rac_buttonClickedSignal().subscribeNext { (x) -> Void in
                
                let xx = x.integerValue
                let s = ac.buttonTitleAtIndex(xx)
                if s == "取消" {
                    
                    ac.dismissWithClickedButtonIndex(xx, animated: false)
                    if didSelectBlock != nil {
                        
                        didSelectBlock!(idx : -1)
                    }
                }else {
                    
                    if didSelectBlock != nil {
                        
                        didSelectBlock!(idx : xx)
                    }
                }
            }
        }
}

func showAlertToVc(
    vc : UIViewController,
    title : String?,
    msg : String?,
    actions : NSArray,
    didSelectBlock: ((idx : Int) -> Void)?
    ){
        
        if #available(iOS 8.0, *) {
        
            let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            
            for (idx, str) in actions.enumerate(){
                
                let action = UIAlertAction(title: str as? String, style: UIAlertActionStyle.Default) { (ac) -> Void in
                    
                    print("\(idx),\(str)")
                    if didSelectBlock != nil {
                        
                        didSelectBlock!(idx : idx)
                    }
                }
                alert.addAction(action)
            }
            
            vc.presentViewController(alert, animated: true, completion: nil)

        }else {
        
            let ac = UIAlertView(title: title, message: msg, delegate: nil, cancelButtonTitle: nil)
            for (_, str) in actions.enumerate(){
                
                ac.addButtonWithTitle(str as? String)
            }
            ac.show()
            
            ac.rac_buttonClickedSignal().subscribeNext { (x) -> Void in
                
                let xx = x.integerValue
                if didSelectBlock != nil {
                    
                    didSelectBlock!(idx : xx)
                }
            }
        }
}
*/


// MARK: 字符串MD5
extension String {
    var zh_md5 : String{
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.destroy();
        
        return String(format: hash as String)
    }
}

extension NSMutableArray {
    
    func zh_has(obj : AnyObject) -> Bool {
    
        if self.count <= 0 {
            return false
        }
        
        var hasObj = false
        for (_,o) in self.enumerate() {
            
            if o === obj {
                
                hasObj = true
                break
            }
        }
        return hasObj
    }
}

func setLabelHeight(myLabel: UILabel, labelHeight: NSInteger ) {
    
    let myAttributedString: NSMutableAttributedString = NSMutableAttributedString(string: myLabel.text!)
    let myParagraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
    myParagraphStyle.lineSpacing = CGFloat(labelHeight)
    let len = myLabel.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    myAttributedString.addAttribute(NSParagraphStyleAttributeName, value: myParagraphStyle, range: NSMakeRange(0, len!))
    myLabel.attributedText = myAttributedString
    myLabel.sizeToFit()
}


























