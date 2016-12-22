//
//  HTuijianViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/20.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class HTuijianViewController: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "今日推荐"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        let htReVC = HTRemenViewController()
        htReVC.title = "热门"
        let htNeiVC = HTNeidiViewController()
        htNeiVC.title = "内地"
        let htGangVC = HTGangtaiViewController()
        htGangVC.title = "港台"
        let htHanVC = HTHanguoViewController()
        htHanVC.title = "韩国"
        let htRiVC = HTRibenViewController()
        htRiVC.title = "日本"
        let htOuVC = HTOumeiViewController()
        htOuVC.title = "欧美"
        let VCArr = [htReVC,htNeiVC,htGangVC,htOuVC,htHanVC,htRiVC]
        self.navigationItem.title = "今日推荐"
        self.automaticallyAdjustsScrollViewInsets = false
        //0, 22, SCREEN_WIDTH, SCREEN_HEIGHT-22
        let myTabview = MyTabBarView.init(frame: CGRect.init(x: 0, y: 20 + 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr as NSArray, dele: nil)
        self.view.addSubview(myTabview)
    }
}
