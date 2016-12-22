//
//  VBViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/14.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class VBViewController: UIViewController {
    @IBOutlet weak var MVview: UIView!
    @IBOutlet weak var Zhuanjiview: UIView!
    @IBOutlet weak var Chinaview: UIView!
    var leftBtn = UIButton.init(type: .custom)
    var midBtn = UIButton.init(type: .custom)
    var rightBtn = UIButton.init(type: .custom)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createBtn()
        leftBtn.isSelected = true
        self.createUI()
    }
    
    func pushToWeb(url:String) {
        let webVC = ShangChengViewController()
        print(url)
        webVC.url = url
        webVC.hidesBottomBarWhenPushed = true
        self.present(webVC, animated: true, completion: nil)
    }
    
    func createUI() {
        let vmNei = VMNeidiViewController()
        vmNei.title = "内地"
        let vmGang = VMGangtaiViewController()
        vmGang.title = "港台"
        let vmOu = VMOumeiViewController()
        vmOu.title = "欧美"
        let vmHan = VMHanguoViewController()
        vmHan.title = "韩国"
        let vmRi = VMRibenViewController()
        vmRi.title = "日本"
        let VCArr = [vmNei,vmGang,vmOu,vmHan,vmRi]
        self.automaticallyAdjustsScrollViewInsets = false
        let myTabview = MyTabBarView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr as NSArray, dele: nil)
        MVview.addSubview(myTabview)
        
        let vzNei = VZNeidiViewController()
        vzNei.title = "内地专辑销量榜"
        let vzJin = VZJinkouViewController()
        vzJin.title = "进口专辑销量榜"
        let VCArr2 = [vzNei,vzJin]
        let myTabview2 = MyTabBarView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr2 as NSArray, dele: nil)
        Zhuanjiview.addSubview(myTabview2)
        
        let vcChina = VCChinaViewController()
        vcChina.title = "CHINA V CHART TOP 30"
        let vcBill = VCBillViewController()
        vcBill.title = "billboard THE HOT 100"
        let VCArr3 = [vcChina,vcBill]
        
        let myTabview3 = MyTabBarView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), vcArr: VCArr3 as NSArray, dele: nil)
        Chinaview.addSubview(myTabview3)
    }
    func createBtn() {
        let btnWidth = UIScreen.main.bounds.size.width / 3
        
        leftBtn.frame = CGRect.init(x: 0, y: 0, width: btnWidth, height: 40)
        leftBtn.setTitle("MV作品榜", for: .normal)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        leftBtn.setTitleColor(UIColor.init(red: 43/255, green: 185/255, blue: 110/255, alpha: 1), for: .selected)
        leftBtn.addTarget(self, action: #selector(self.leftBtnClick), for: .touchUpInside)
        leftBtn.tag = 10
        let leftBtnItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftBtnItem
        
        midBtn.frame = CGRect.init(x: btnWidth, y: 0, width: btnWidth, height: 40)
        midBtn.setTitle("专辑榜", for: .normal)
        midBtn.setTitleColor(UIColor.init(red: 43/255, green: 185/255, blue: 110/255, alpha: 1), for: .selected)
        midBtn.addTarget(self, action: #selector(self.midBtnClick), for: .touchUpInside)
        midBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        midBtn.tag = 11
        self.navigationItem.titleView = midBtn
        
        rightBtn.frame = CGRect.init(x: btnWidth*2, y: 0, width: btnWidth, height: 40)
        rightBtn.setTitle("China V Chart", for: .normal)
        rightBtn.setTitleColor(UIColor.init(red: 43/255, green: 185/255, blue: 110/255, alpha: 1), for: .selected)
        rightBtn.addTarget(self, action: #selector(self.rightBtnClick), for: .touchUpInside)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        let rightBtnItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightBtnItem
    }
    
    func leftBtnClick(sender:UIButton) {
        midBtn.isSelected = false
        rightBtn.isSelected = false
        sender.isSelected = true
        MVview.isHidden = false
        Zhuanjiview.isHidden = true
        Chinaview.isHidden = true
    }
    
    func midBtnClick(sender:UIButton) {
        leftBtn.isSelected = false
        rightBtn.isSelected = false
        sender.isSelected = true
        MVview.isHidden = true
        Zhuanjiview.isHidden = false
        Chinaview.isHidden = true
    }
    
    func rightBtnClick(sender:UIButton) {
        midBtn.isSelected = false
        leftBtn.isSelected = false
        sender.isSelected = true
        MVview.isHidden = true
        Zhuanjiview.isHidden = true
        Chinaview.isHidden = false
    }

}
