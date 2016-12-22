//
//  FEryuanViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/26.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class FEryuanViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var DataArr = [FHomeModel]()
    var ConArr = [FCHomeModel]()
    var ArtistArr = [NSDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        tableView.register(UINib.init(nibName: "FHomeCell", bundle: nil), forCellReuseIdentifier: "FHomeCell")
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.tableView.mj_header.endRefreshing()
        })
        self.loadData()
        tableView.mj_header.beginRefreshing()
    }
    
    func loadData() {
        let url = "http://mapiv2.yinyuetai.com/artist/hot.json?area=ACG"
        BaseRequest.getWithURK(url: url, para: nil) { (data, error) in
            //            let dic = String.init(data: data as! Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            //            print(dic!)
            if error == nil {
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let data = dic["data"] as! NSDictionary
                let artistArr = data["artistList"] as! [NSDictionary]
                self.ArtistArr = artistArr
                for obj in artistArr {
                    let artist = obj["artist"] as! NSDictionary
                    let model = FHomeModel()
                    model.artistId = artist["artistId"] as? Int
                    model.name = artist["name"] as? String
                    model.smallAvatar = artist["smallAvatar"] as? String
                    model.subCount = artist["subCount"] as? Int
                    model.videoCount = artist["videoCount"] as? Int
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FHomeCell", for: indexPath) as! FHomeCell
        let model = self.DataArr[indexPath.item]
        cell.picImg.sd_setImage(with: URL.init(string: model.smallAvatar!), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
        cell.titleLabel.text = model.name!
        cell.videoCountLabel.text = "\(model.videoCount!)首mv"
        cell.subCountLabel.text = "\(model.subCount!)个人订阅"
        cell.selectionStyle = .none
        let contents = self.ArtistArr[indexPath.item]
        let conarr = contents["contents"] as! [NSDictionary]
        self.ConArr.removeAll()
        for con in conarr {
            let model = FCHomeModel()
            model.posterPic = con["posterPic"] as? String
            model.totalView = con["totalView"] as? Int
            model.title = con["title"] as? String
            model.videoId = con["videoId"] as? Int
            self.ConArr.append(model)
        }
        cell.collectionView.reloadData()
        cell.ConArr = self.ConArr
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.DataArr[indexPath.item]
        let yDetailVC = YiDetailViewController()
        yDetailVC.str = model.name!
        yDetailVC.id = model.artistId!
        yDetailVC.hidesBottomBarWhenPushed = true
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let window = delegate.window?.rootViewController as! UITabBarController
        let nav = window.viewControllers?[3] as! UINavigationController
        nav.pushViewController(yDetailVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
