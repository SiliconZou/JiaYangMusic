//
//  NRiyuViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/20.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NRiyuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "日语"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        
        let nhTui = NRTuijianViewController()
        nhTui.title = "推荐"
        let nhYing = NRYingshiViewController()
        nhYing.title = "影视"
        let nhXian = NRErciViewController()
        nhXian.title = "二次元"
        let nhFan = NRZongyiViewController()
        nhFan.title = "综艺cut"
        let VCArr = [nhTui,nhYing,nhXian,nhFan]
        self.automaticallyAdjustsScrollViewInsets = false
        let myTabview = MyTabBarView.init(frame: CGRect.init(x: 0, y: 20 + 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr as NSArray, dele: nil)
        self.view.addSubview(myTabview)
    }

    
}
