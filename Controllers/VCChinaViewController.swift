//
//  VCChinaViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/25.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class VCChinaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var DataArr = [VBChinaModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        
        tableView.register(UINib.init(nibName: "VBChinaCell", bundle: nil), forCellReuseIdentifier: "VBChinaCell")
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.tableView.mj_header.endRefreshing()
        })
        self.loadData()
        tableView.mj_header.beginRefreshing()
    }
    func loadData() {
        let url = "http://mapiv2.yinyuetai.com/cvc/trend.json?offset=0&size=30&type=ChinaVchart"
        BaseRequest.getWithURK(url: url, para: nil) { (data, error) in
//            let obj = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//            print(obj!)
            if error == nil {
                let obj = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let dic = obj["data"] as! NSDictionary
                let dicArr = dic["videos"] as! [NSDictionary]
                for data in dicArr {
                    let model = VBChinaModel()
                    model.title = data["title"] as? String
                    model.videoId = data["videoId"] as? Int
                    model.posterPic = data["posterPic"] as? String
                    let dic = data["extend"] as! NSDictionary
                    model.number = dic["number"] as? Int
                    model.score = dic["score"] as? String
                    let nameArr = data["artists"] as! [NSDictionary]
                    for name in  nameArr {
                        model.artistName = name["artistName"] as? String
                    }
                    self.DataArr.append(model)
                }
            } else {
                print(error?.localizedFailureReason as Any)
            }
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.DataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VBChinaCell", for: indexPath) as! VBChinaCell
        let model = self.DataArr[indexPath.item]
        cell.nameLabel.text = model.artistName!
        cell.numberLabel.text = "\(model.number!)"
        cell.picImg.sd_setImage(with: URL.init(string: model.posterPic!), placeholderImage: UIImage.init(named: "PlaceHolder_5.9Movie~iphone"))
        cell.titleLabel.text = model.title!
        cell.scoreLabel.text = model.score!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.DataArr[indexPath.item]
        let veVC = VedioPlayController()
        veVC.ID = model.videoId!
        //veVC.type = 2
        veVC.hidesBottomBarWhenPushed = true
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let window = delegate.window?.rootViewController as! UITabBarController
        let nav = window.viewControllers?[2] as! UINavigationController
        nav.pushViewController(veVC, animated: true)
        
        let mod = NSEntityDescription.insertNewObject(forEntityName: "Vedios", into: SingleContext.context) as! Vedios
        mod.iD = Int32(model.videoId!)
        mod.name = model.artistName
        mod.title = model.title!
        mod.img = NSData.init(contentsOf: URL.init(string: model.posterPic!)!)
        try! SingleContext.context.save()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
