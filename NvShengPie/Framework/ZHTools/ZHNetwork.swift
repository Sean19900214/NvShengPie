//
//  ZHNetwork.swift
//  Reselling
//
//  Created by ZhangYuting on 15/5/8.
//  Copyright (c) 2015 wjt. All rights reserved.
//

import Foundation

let baseUrl = "http://ubtech.nizaiganma.cn/"
//let baseUrl="http://www.91daoteng.com/index.php/"

//let baseUrl="http://\(appServer()).91daoteng.com/index.php/"


/**
网络请求返回数据

- Error:   网络请求错误
- PaseDic: 返回解析数据
*/
enum Result {

    case Error(NSError)
    case PaseDic(PaseResponse)
}

/**
解析数据

- Ret_succeed: ret状态为0表示成功
- Ret_failed:  ret状态为-2表示失败
- Ret_other:   ret的其它状态，通常用来统一处理一些事件，比如token验证失效的时候ret= -1000需要强制用户退出到登录界面
*/
enum PaseResponse {
    
    case Ret_succeed(NSDictionary)
    case Ret_failed(ret : Int, msg : NSString?)
}

class ZHNetwork {
    
    
    func getRequestWithUrl(url : NSURL,needToken : Bool, completionBlock : ((res : Result) -> Void)?){
        
        let request = NSMutableURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request.HTTPMethod = "GET"
        request.addValue(self.userAgentStr(), forHTTPHeaderField: "User-Agent")
        if needToken {
            
            request.HTTPShouldHandleCookies = true
           // request.addValue("\(USER().uid!)/\(USER().token!)", forHTTPHeaderField: "auth")
        }
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.currentQueue()!) { (response, data, connectionError) -> Void in
            
            if connectionError == nil{
                
                var jsonObject: NSDictionary?
                do {
                    let s = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("===========接口：\(request.URL)返回数据：\(s)")
                    try jsonObject = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    let ret : Int = jsonObject?["status"] as! Int
                    if ret == 0{
                        
                        if completionBlock != nil {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                completionBlock!(res: Result.PaseDic(PaseResponse.Ret_succeed(jsonObject!)))
                            })
                        }
                    }else {
                        
                        if completionBlock != nil {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                let msg : NSString? = jsonObject?["message"] as? NSString
                                print(msg)
                                completionBlock!(res: Result.PaseDic(PaseResponse.Ret_failed(ret: ret, msg: msg)))
                            })
                        }
                    }
                    
                }catch {
                    
                    print(error)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        HUD.sharedHUD().showHUDNeverAutoHide(UIApplication.sharedApplication().keyWindow, mode: MBProgressHUDModeText, title: "解析失败")
                        HUD.sharedHUD().myHud.hide(true, afterDelay: 2)
//                        completionBlock!(res: Result.Error(error))
                    })
                }
            }else {
                
                print(connectionError)
                if completionBlock != nil {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        HUD.sharedHUD().showHUDNeverAutoHide(UIApplication.sharedApplication().keyWindow, mode: MBProgressHUDModeText, title: connectionError!.localizedDescription)
                        HUD.sharedHUD().myHud.hide(true, afterDelay: 2)
                        completionBlock!(res: Result.Error(connectionError!))
                    })
                }
            }
        }
    }
    
    
    
    func postRequestWithControl(interfaceName : NSString, params : NSDictionary?, needToken : Bool, completionBlock : ((res : Result) -> Void)?){
        
        let url = NSURL(string: "\(baseUrl)\(interfaceName)")
        let request = NSMutableURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request.HTTPMethod = "POST"
        request.addValue(self.userAgentStr(), forHTTPHeaderField: "User-Agent")
        if needToken {
            
            request.HTTPShouldHandleCookies = true
           // request.addValue("\(USER().uid!)/\(USER().token!)", forHTTPHeaderField: "auth")
        }

        if params != nil {
            
            var paramsStr = ""
            for (k,v) in params! {
                
                paramsStr = paramsStr + "&\(k)=\(v)"
            }
            if paramsStr.hasPrefix("&") {
                
                paramsStr.removeAtIndex(paramsStr.startIndex)
            }
            print("\(url!)       \(paramsStr)")
            
            request.HTTPBody = paramsStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        }
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.currentQueue()!) { (response, data, connectionError) -> Void in
            
            if connectionError == nil{

                var jsonObject: NSDictionary?
                do {
                    let s = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("===========接口：\(request.URL)返回数据：\(s)")
                    try jsonObject = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                    
                    let ret : Int = jsonObject?["status"] as! Int                    
                    if ret == 0{
                        
                        if completionBlock != nil {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                completionBlock!(res: Result.PaseDic(PaseResponse.Ret_succeed(jsonObject!)))
                            })
                        }
                    }else {
                        
                        if completionBlock != nil {
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                
                                let msg : NSString? = jsonObject?["message"] as? NSString
                                print(msg)
                                completionBlock!(res: Result.PaseDic(PaseResponse.Ret_failed(ret: ret, msg: msg)))
                            })
                        }
                    }
                    
                }catch {
                
                    print(error)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        HUD.sharedHUD().showHUDNeverAutoHide(UIApplication.sharedApplication().keyWindow, mode: MBProgressHUDModeText, title: "解析失败")
                        HUD.sharedHUD().myHud.hide(true, afterDelay: 2)
                        //                        completionBlock!(res: Result.Error(error))
                    })
                }
            }else {
            
                print(connectionError)
                if completionBlock != nil {
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        
                        HUD.sharedHUD().showHUDNeverAutoHide(UIApplication.sharedApplication().keyWindow, mode: MBProgressHUDModeText, title: connectionError!.localizedDescription)
                        HUD.sharedHUD().myHud.hide(true, afterDelay: 2)
                        completionBlock!(res: Result.Error(connectionError!))
                    })
                }
            }

        }

    }
    
    
    func userAgentStr() -> String {
        
         let headStr = "";
       // let headStr = "User-Agent:AppStory/\(isOnline())/\(appVersion())/\(internalVersion())/0/\(userDeviceToken)/\(userDeviceToken)/0"
        return headStr
    }
 
}