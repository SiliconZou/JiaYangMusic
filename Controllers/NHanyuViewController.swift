//
//  NHanyuViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/20.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NHanyuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "韩语"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        
        let nhTui = NHaTuijianViewController()
        nhTui.title = "推荐"
        let nhYing = NHaYingshiViewController()
        nhYing.title = "影视"
        let nhXian = NHaZongyiViewController()
        nhXian.title = "综艺cut"
        let nhFan = NHaFanzhiViewController()
        nhFan.title = "饭制"
        let VCArr = [nhTui,nhYing,nhXian,nhFan]
        self.automaticallyAdjustsScrollViewInsets = false
        let myTabview = MyTabBarView.init(frame: CGRect.init(x: 0, y: 20 + 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr as NSArray, dele: nil)
        self.view.addSubview(myTabview)

    }

    

}
