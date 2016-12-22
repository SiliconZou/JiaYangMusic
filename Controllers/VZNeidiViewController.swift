//
//  VZNeidiViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/25.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class VZNeidiViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var DataArr = [VBZhuanjiModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.register(UINib.init(nibName: "VBZhuanjiCell", bundle: nil), forCellReuseIdentifier: "VBZhuanjiCell")
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.tableView.mj_header.endRefreshing()
        })
        self.loadData(con: 0, size: 20)
        let pagee = 20
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.loadData(con: pagee, size: 30)
        })
        tableView.mj_header.beginRefreshing()
    }
    func loadData(con:Int,size:Int) {
        let url = String.init(format: "http://mapiv2.yinyuetai.com/album/trend_rank.json?offset=%ld&size=%ld&type=ml", con,size)
        BaseRequest.getWithURK(url: url, para: nil) { (data, error) in
//            let obj = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//            print(obj!)
            if error == nil {
                let obj = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let dic = obj["data"] as! NSDictionary
                let dicArr = dic["videos"] as! [NSDictionary]
                for data in dicArr {
                    let model = VBZhuanjiModel()
                    model.artistName = data["artistName"] as? String
                    model.posterPic = data["posterPic"] as? String
                    model.rank = data["rank"] as? Int
                    model.title = data["title"] as? String
                    model.url = data["url"] as? String
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "VBZhuanjiCell", for: indexPath) as! VBZhuanjiCell
        let model = self.DataArr[indexPath.item]
        cell.nameLabel.text = model.artistName!
        cell.rankLabel.text = "\(model.rank!)"
        cell.picImg.sd_setImage(with: URL.init(string: model.posterPic!), placeholderImage: UIImage.init(named: "PlaceHolder_PlayList~iphone"))
        cell.titleLabel.text = model.title!
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.DataArr[indexPath.item]
        let webVC = ShangChengViewController()
        webVC.url = model.url!
        webVC.hidesBottomBarWhenPushed = true
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let window = delegate.window?.rootViewController as! UITabBarController
        let nav = window.viewControllers?[2] as! UINavigationController
        nav.pushViewController(webVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }
}
