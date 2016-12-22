//
//  HYuedanViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/20.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class HYuedanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "悦单"
        self.navigationItem.titleView = label
        
        let hyTai = HYTaigeViewController()
        hyTai.title = "台哥推荐"
        let hyPai = HYPaihangViewController()
        hyPai.title = "排行榜"
        let VCArr = [hyTai,hyPai]
        label.textColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        let myTabview = MyTabBarView.init(frame: CGRect.init(x: 0, y: 20 + 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr as NSArray, dele: nil)
        self.view.addSubview(myTabview)
    }
}
