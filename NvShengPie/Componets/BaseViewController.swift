//
//  BaseViewController.swift
//  Reselling
//
//  Created by ZhangYuting on 15/5/8.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.navigationController?.viewControllers.count > 1 {
            
            self.navigationController?.interactivePopGestureRecognizer!.enabled = true
            self.navigationController?.interactivePopGestureRecognizer!.delegate = self
        }else {
            
            self.navigationController?.interactivePopGestureRecognizer!.enabled = false
        }
    }
    
    @IBAction func backButtontClick(){
        
        if self.navigationController?.childViewControllers.count > 1{
            
            self.navigationController?.popViewControllerAnimated(true)
        }else {
            
            self .dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
