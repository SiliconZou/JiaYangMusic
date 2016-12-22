//
//  FocusViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/14.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class FocusViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        //self.abc()
        self.createVC()
    }
    
    func createVC() {
        let fQuan = FQuanbuViewController()
        fQuan.title = "全部"
        let fNei = FNeidiViewController()
        fNei.title = "内地"
        let fGang = FGangtaiViewController()
        fGang.title = "港台"
        let fOu = FOumeiViewController()
        fOu.title = "欧美"
        let fHan = FHanguoViewController()
        fHan.title = "韩国"
        let fRi = FRibenViewController()
        fRi.title = "日本"
        let fEr = FEryuanViewController()
        fEr.title = "二元次"
        let VCArr = [fQuan,fNei,fGang,fOu,fHan,fRi,fEr]
        self.automaticallyAdjustsScrollViewInsets = false
        let myTabview = MyTabBarView.init(frame: CGRect.init(x: 0, y: 20 + 44, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr as NSArray, dele: nil)
        myTabview.bodySV.isScrollEnabled = false
        self.view.addSubview(myTabview)
    }
    
    func createUI() {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "订阅"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        let rightBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 25))
        rightBtn.setBackgroundImage(UIImage.init(named: "RSS_recommend_add~iphone"), for: .normal)
        rightBtn.setBackgroundImage(UIImage.init(named: "RSS_recommend_add_sel~iphone"), for: .highlighted)
        rightBtn.addTarget(self, action: #selector(self.historyClick(button:)), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    func historyClick(button:UIButton) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.subtype = kCATransitionFromTop
        transition.type = kCATransitionMoveIn
        transition.type = "rotate"
        self.navigationController?.view.layer.add(transition, forKey: nil)
        let yiVC = NYirenViewController()
        yiVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(yiVC, animated: true)
    }

    func abc() {
        let url = "http://mapiv2.yinyuetai.com/artist/info.json?artistId=22873"
        BaseRequest.getWithURK(url: url, para: nil) { (data, error) in
            let dic = String.init(data: data as! Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            print(dic!)
        }
    }
}
