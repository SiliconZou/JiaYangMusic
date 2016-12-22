//
//  HYPaihangViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/20.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class HYPaihangViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var DataArr = [HYueModel]()
    //"http://mapiv2.yinyuetai.com/playlist/rank.json?offset=0&size=20"
    var page = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.tableView.mj_header.endRefreshing()
        })
        self.loadData(con: self.page)
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 20
            self.loadData(con: self.page)
            self.tableView.mj_footer.endRefreshing()
        })
        tableView.mj_header.beginRefreshing()
        tableView.register(UINib.init(nibName: "HYPaiTableViewCell", bundle: nil), forCellReuseIdentifier: "HYPaiTableViewCell")
    }

    func loadData(con:Int) {
        let url = String.init(format: "http://mapiv2.yinyuetai.com/playlist/rank.json?offset=%ld&size=20", con)
        BaseRequest.getWithURK(url: url, para: nil) { (data, error) in
            //let obj = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
            //print(obj!)
            if error == nil {
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let dataArr = dic["data"] as! [NSDictionary]
                for obj in dataArr {
                    let model = HYueModel()
                    model.desc = obj["desc"] as? String
                    model.posterPic = obj["posterPic"] as? String
                    model.playListId = obj["playListId"] as? Int
                    model.title = obj["title"] as? String
                    model.totalView = obj["totalView"] as? Int
                    model.totalFavorite = obj["totalFavorite"] as? Int
                    model.totalVideo = obj["totalVideo"] as? Int
                    let nameDic = obj["creator"] as! NSDictionary
                    model.nickName = nameDic["nickName"] as? String
                    model.smallAvatar = nameDic["smallAvatar"] as? String
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HYPaiTableViewCell", for: indexPath) as! HYPaiTableViewCell
        cell.selectionStyle = .none
        let model = self.DataArr[indexPath.item]
        cell.nameLabel.text = model.nickName!
        cell.iconImg.sd_setImage(with: URL.init(string: model.smallAvatar!), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
        cell.titleLabel.text = model.title!
        cell.favouriteLabel.text = "\(model.totalFavorite!)"
        cell.totalVedioLabel.text = "\(model.totalVideo!)"
        if model.desc == nil {
            cell.descLabel.text = ""
        } else {
            cell.descLabel.text = model.desc!
        }
        cell.playCountLabel.text = "播放量:\(model.totalView!)"
        cell.picImg.sd_setImage(with: URL.init(string: model.posterPic!), placeholderImage: UIImage.init(named: "PlaceHolder_PlayList~iphone"))
        cell.backgroundColor = UIColor.white

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.DataArr[indexPath.item]
        let veVC = VedioPlayController()
        veVC.ID = model.playListId!
        veVC.type = 2
        veVC.hidesBottomBarWhenPushed = true
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let window = delegate.window?.rootViewController as! UITabBarController
        let nav = window.viewControllers?[0] as! UINavigationController
        nav.pushViewController(veVC, animated: true)
        
//        let mod = NSEntityDescription.insertNewObject(forEntityName: "Vedios", into: SingleContext.context) as! Vedios
//        mod.iD = Int32(model.playListId!)
//        mod.name = model.nickName!
//        mod.title = model.title!
//        mod.img = NSData.init(contentsOf: URL.init(string: model.posterPic!)!)
//        try! SingleContext.context.save()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
}
