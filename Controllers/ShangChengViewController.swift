//
//  ShangChengViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/19.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class ShangChengViewController: UIViewController {

    let webView = UIWebView()
    var url = "http://shop.m.yinyuetai.com/"
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest.init(url: URL.init(string: url)!)
        webView.loadRequest(request)
        webView.frame = self.view.frame
        self.view.addSubview(webView)
    }
   
}
