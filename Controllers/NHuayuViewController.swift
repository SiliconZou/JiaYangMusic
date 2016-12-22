//
//  NHuayuViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/20.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NHuayuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "华语"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        let nhTui = NHTuijianViewController()
        nhTui.title = "推荐"
        let nhYing = NHYingshiViewController()
        nhYing.title = "影视"
        let nhXian = NHXianchangViewController()
        nhXian.title = "现场"
        let nhFan = NHFanzhiViewController()
        nhFan.title = "饭制"
        let VCArr = [nhTui,nhYing,nhXian,nhFan]
        self.automaticallyAdjustsScrollViewInsets = false
        let myTabview = MyTabBarView.init(frame: CGRect.init(x: 0, y: 20 + 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr as NSArray, dele: nil)
        self.view.addSubview(myTabview)
    }

   
}
