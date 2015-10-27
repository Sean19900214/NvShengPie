//
//  BaseTableViewController.swift
//  Reselling
//
//  Created by ZhangYuting on 15/5/11.
//  Copyright (c) 2015年 wjt. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController,UIGestureRecognizerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = ZHColorBackground
        
        let v = UIView()
        v.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = v
        
        
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
    
    
    override func viewDidLayoutSubviews() {
        
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 0)
        if #available(iOS 8.0, *) {
            self.tableView.layoutMargins = UIEdgeInsetsMake(0, 10, 0, 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
