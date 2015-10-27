//
//  ZHUser.swift
//  Reselling
//
//  Created by ZhangYuting on 15/5/8.
//  Copyright (c) 2015 wjt. All rights reserved.
//

import UIKit

//let userFilePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0].stringByAppendingPathComponent("userinfo")
let userFilePath = NSString(string: NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]).stringByAppendingPathComponent("userinfo")
var userDeviceToken = ""

///用户信息数据模型
class ZHUser: NSObject,NSCoding {
   
    var name : NSString?
    var uid : NSString?
    var token : NSString?
    var isLogin : Bool!
    var expiresIn : NSString?
    var avatar : NSString?

    var update = false
    
    private class func shared() -> ZHUser {
        
        dispatch_once(&Inner.token, { () -> Void in
            
            Inner.instance = ZHUser()
            Inner.instance?.isLogin = false
        })
        return Inner.instance!
    }
    private struct Inner {
    
        static var instance : ZHUser?
        static var token : dispatch_once_t = 0
    }


    override init() {
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(token, forKey: "token")
        aCoder.encodeBool(isLogin, forKey: "isLogin")
        aCoder.encodeObject(expiresIn, forKey: "expiresIn")
        aCoder.encodeObject(avatar, forKey: "avatar")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.name = aDecoder.decodeObjectForKey("name") as? NSString
        self.uid = aDecoder.decodeObjectForKey("uid") as? NSString
        self.token = aDecoder.decodeObjectForKey("token") as? NSString
        self.isLogin = aDecoder.decodeBoolForKey("isLogin")

        self.expiresIn = aDecoder.decodeObjectForKey("expiresIn") as? NSString
        self.avatar = aDecoder.decodeObjectForKey("avatar") as? NSString
    }

    func isFirstInstall() -> Bool {
        
        if !NSUserDefaults.standardUserDefaults().boolForKey("everInstall"){
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "everInstall")
            //首次启动应用设置推送通知
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "not_sound_open")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "not_vibration_open")

            return true
        }
        
        return false
    }

    
    /**
    保存/更新用户信息调用
    
    - returns: 是否更新成功
    */
    func saveUser() -> Bool{
        
        ZHUser.shared().update = true
        let succeed = NSKeyedArchiver.archiveRootObject(ZHUser.shared(), toFile: userFilePath)
        ZHUser.shared().update = false
        print(succeed)
        
        return succeed
    }
    
    /**
    删除用户信息
    */
    func removeUser() {
        
        if NSFileManager.defaultManager().fileExistsAtPath(userFilePath) {
            
            do {
                try NSFileManager.defaultManager().removeItemAtPath(userFilePath)
            } catch _ {
            }
        }
        
        ZHUser.shared().name = nil
        ZHUser.shared().uid = nil
        ZHUser.shared().token = nil
        ZHUser.shared().isLogin = false
        
        ZHUser.shared().avatar = nil
        ZHUser.shared().expiresIn = nil
    }
    
    
    func login(dic : NSDictionary){

        ZHUser.shared().isLogin = true
        ZHUser.shared().name = dic["nickname"] == nil ? "" : dic["nickname"] as? NSString
        
        let u = dic["uid"] == nil ? 0 : dic["uid"]?.longLongValue
        ZHUser.shared().uid = NSString(string: NSNumber(longLong: u!).stringValue)
        ZHUser.shared().token = dic["token"] == nil ? "" : dic["token"] as? NSString

        ZHUser.shared().avatar = dic["avatar"] == nil ? "" : dic["avatar"] as? NSString
        ZHUser.shared().expiresIn = dic["expiresIn"] == nil ? "" : dic["expiresIn"] as? NSString
        
        self.saveUser()

//        MiPushSDK.setAlias(dic["uid"] as! String)
    }
    
    func logOut() {
        
//        MiPushSDK.unsetAlias(USER().uid as! String)
        ZHNetwork().getRequestWithUrl(NSURL(string: "\(baseUrl)users/signout")!, needToken: true, completionBlock: nil)
        self.removeUser()
    }

    override var description : String {

        return "<用户模型:\n \(self.name)\n \(self.uid)\n \(self.token)\n \(self.isLogin)\n \(self.avatar)\n \(self.expiresIn)\n>"
    }
}

/**
用户单例，可以直接获取用户属性
*/
func USER() -> ZHUser!{
    
    if ZHUser.shared().update {
        
        return ZHUser.shared()
    }
    if NSFileManager.defaultManager().fileExistsAtPath(userFilePath) {
        
        let model : ZHUser = NSKeyedUnarchiver.unarchiveObjectWithFile(userFilePath) as! ZHUser
        ZHUser.shared().name = model.name
        ZHUser.shared().uid = model.uid
        ZHUser.shared().token = model.token
        ZHUser.shared().isLogin = model.isLogin

        ZHUser.shared().avatar = model.avatar
        ZHUser.shared().expiresIn = model.expiresIn
    }
    
    return ZHUser.shared()
}


