//
//  YiDetailViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/27.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class YiDetailViewController: UIViewController {

    var str:String?
    var id:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createUI()
    }
    
    func createUI() {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = str!
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        
        let yMVC = YMVViewController()
        yMVC.ID = self.id
        yMVC.name = self.str
        yMVC.title = "MV"
        let yInVC = YInfoViewController()
        yInVC.title = "艺人资料"
        self.automaticallyAdjustsScrollViewInsets = false
        let VCArr = [yMVC]
        let myTabView = MyTabBarView.init(frame: CGRect.init(x: 0, y: 20 + 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr as NSArray, dele: nil)
        self.view.addSubview(myTabView)
    }
}
