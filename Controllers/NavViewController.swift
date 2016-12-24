//
//  NavViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/14.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NavViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var BtnDataArr = [String]()
    var Pro1DataArr = [String]()
    var Pro2DataArr = [String]()
    var Pro3DataArr = [String]()
    var UrlStrArr = [String]()
    var btnsArr = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.createUI()
    }
    
    func createUI() {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "导航"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        let rightBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 45, height: 45))
        rightBtn.setBackgroundImage(UIImage.init(named: "home_history~iphone"), for: .normal)
        rightBtn.setBackgroundImage(UIImage.init(named: "home_history_sel~iphone"), for: .highlighted)
        rightBtn.addTarget(self, action: #selector(self.historyClick(button:)), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        tableView.register(UINib.init(nibName: "NfirstTableViewCell", bundle: nil), forCellReuseIdentifier: "nfirst")
        tableView.register(UINib.init(nibName: "NsecondTableViewCell", bundle: nil), forCellReuseIdentifier: "nsecond")
        
    }
    func historyClick(button:UIButton) {
        let hisVC = HistoryViewController()
        self.navigationController?.pushViewController(hisVC, animated: true)
    }
    
    func loadData() {
        let urlStr = "http://mapiv2.yinyuetai.com/navigation/config.json"
        BaseRequest.getWithURK(url: urlStr, para: nil) { (data, error) in
            if error == nil {
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as? NSDictionary
//                let dic = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//                print(dic!)
                let data = dic?["data"] as! NSDictionary
                let btnArr = data["contents"] as! [NSDictionary]
                for btn in btnArr {
                    let btnStr = btn["icon"] as? String
                    self.BtnDataArr.append(btnStr!)
                }
                let btnsArr = data["buttons"] as! [NSDictionary]
                self.btnsArr = btnsArr
                let funArr = data["functions"] as! [NSDictionary]
                let fun1 = funArr[0]
                let pro1 = fun1["products"] as! [NSDictionary]
                for title in pro1 {
                    let tiStr = title["title"] as? String
                    self.Pro1DataArr.append(tiStr!)
                }
                let fun2 = funArr[1]
                let pro2 = fun2["products"] as! [NSDictionary]
                for title in pro2 {
                    let tiStr = title["title"] as? String
                    self.Pro2DataArr.append(tiStr!)
                }
//                let fun3 = funArr[2]
//                let urlDic = fun3["extend"] as! NSDictionary
//                let url = urlDic["url"] as? String
//                self.UrlStrArr.append(url!)
//                let pro3 = fun3["products"] as! [NSDictionary]
//                for title in pro3 {
//                    let tiStr = title["title"] as? String
//                    self.Pro3DataArr.append(tiStr!)
//                }
            } else {
                print(error?.localizedFailureReason as Any)
            }
            self.tableView.reloadData()
        }
    }
    
    func JiemuBtnClick() {
        let jieVC = NJiemuViewController()
        jieVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(jieVC, animated: true)
    }
    func HuayuBtnClick() {
        let huaVC = NHuayuViewController()
        huaVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(huaVC, animated: true)
    }
    func HanyuBtnClick() {
        let hanVC = NHanyuViewController()
        hanVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(hanVC, animated: true)
    }
    func OumeiBtnClick() {
        let ouVC = NOumeiViewController()
        ouVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(ouVC, animated: true)
    }
    func RiyuBtnClick() {
        let riVC = NRiyuViewController()
        riVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(riVC, animated: true)
    }
    func YingshiBtnClick() {
        let yingVC = NYingshiViewController()
        yingVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(yingVC, animated: true)
    }
    func ZongyiBtnClick() {
        let zongVC = NZongyiViewController()
        zongVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(zongVC, animated: true)
    }
    func MvBtnClick() {
        let mvVC = NMvViewController()
        mvVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(mvVC, animated: true)
    }
    func YirenBtnClick() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.subtype = kCATransitionFromTop
        transition.type = kCATransitionMoveIn
        transition.type = "alignedCube"
        self.navigationController?.view.layer.add(transition, forKey: nil)
        let yiVC = NYirenViewController()
        yiVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(yiVC, animated: true)
    }
    
    func ShangBtnClick() {
        let webVC = ShangChengViewController()
        webVC.url = self.UrlStrArr[0]
        webVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func ShangBtnClick2() {
        let webVC = ShangChengViewController()
        webVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.btnsArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "nfirst", for: indexPath) as! NfirstTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.selectionStyle = .none
            //PlaceHolder_OtherUser~iphone
            cell.jieMuImg.sd_setImage(with: URL.init(string: self.BtnDataArr[0]), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
            cell.huaYuImg.sd_setImage(with: URL.init(string: self.BtnDataArr[1]), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
            cell.hanYuImg.sd_setImage(with: URL.init(string: self.BtnDataArr[2]), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
            cell.ouMeiImg.sd_setImage(with: URL.init(string: self.BtnDataArr[3]), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
            cell.riYuImg.sd_setImage(with: URL.init(string: self.BtnDataArr[4]), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
            cell.yingShiImg.sd_setImage(with: URL.init(string: self.BtnDataArr[5]), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
            cell.zongYiImg.sd_setImage(with: URL.init(string: self.BtnDataArr[6]), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
            cell.jieMuBtn.addTarget(self, action: #selector(self.JiemuBtnClick), for: .touchUpInside)
            cell.huaYuBtn.addTarget(self, action: #selector(self.HuayuBtnClick), for: .touchUpInside)
            cell.hanYuBtn.addTarget(self, action: #selector(self.HanyuBtnClick), for: .touchUpInside)
            cell.ouMeiBtn.addTarget(self, action: #selector(self.OumeiBtnClick), for: .touchUpInside)
            cell.riYuBtn.addTarget(self, action: #selector(self.RiyuBtnClick), for: .touchUpInside)
            cell.yingShiBtn.addTarget(self, action: #selector(self.YingshiBtnClick), for: .touchUpInside)
            cell.zongYiBtn.addTarget(self, action: #selector(self.ZongyiBtnClick), for: .touchUpInside)
            cell.MVBtn.addTarget(self, action: #selector(self.MvBtnClick), for: .touchUpInside)
            cell.yiRenBtn.addTarget(self, action: #selector(self.YirenBtnClick), for: .touchUpInside)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "nsecond", for: indexPath) as! NsecondTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        if self.Pro1DataArr.count > 1 {
            cell.shangChengLabel.text = "1.\(Pro1DataArr[0])\n2.\(Pro1DataArr[1])"
        } else {
            cell.shangChengLabel.text = Pro1DataArr[0]
        }
        
        if self.Pro2DataArr.count > 1 {
            cell.fanPaLabel.text = "1.\(Pro2DataArr[0])\n2.\(Pro2DataArr[1])"
        } else {
            cell.fanPaLabel.text = Pro2DataArr[0]
        }
        
//        if self.Pro3DataArr.count > 1 {
//            cell.zongLabel.text = "1.\(Pro3DataArr[0])\n2.\(Pro3DataArr[1])"
//        } else {
//            cell.zongLabel.text = Pro3DataArr[0]
//        }
        cell.shangChengBtn.addTarget(self, action: #selector(self.ShangBtnClick2), for: .touchUpInside)
        cell.zongBtn.addTarget(self, action: #selector(self.ShangBtnClick), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }
        return 200
    }
    
}
