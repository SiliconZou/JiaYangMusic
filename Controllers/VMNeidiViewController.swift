//
//  VMNeidiViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/25.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class VMNeidiViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    var DataArr = [VBMVModel]()
    var Data = NSDictionary()
    var NameArr = [String]()
    var page = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView.register(UINib.init(nibName: "VBHomeCell", bundle: nil), forCellWithReuseIdentifier: "VBHomeCell")
        collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.collectionView.mj_header.endRefreshing()
        })
        self.loadData(con: self.page)
        let pagee = 20
        collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { 
            self.loadData(con: pagee)
            
        })
        collectionView.mj_header.beginRefreshing()
    }

    func loadData(con:Int) {
        let url = String.init(format: "http:mapiv2.yinyuetai.com/vchart/trend.json?area=ML&offset=%ld&size=20", con)
        BaseRequest.getWithURK(url: url, para: nil) { (data, error) in
            if error == nil {
//                let obj = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//                print(obj!)
                let data = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let dic = data["data"] as! NSDictionary
                let dicArr = dic["videos"] as! [NSDictionary]
                for obj in dicArr {
                    let model = VBMVModel()
                    model.albumImg = obj["albumImg"] as? String
                    model.posterPic = obj["posterPic"] as? String
                    model.title = obj["title"] as? String
                    model.videoId = obj["videoId"] as? Int
                    let extend = obj["extend"] as? NSDictionary
                    model.number = extend?["number"] as? Int
                    model.score = extend?["score"] as? String
                    model.trendScore = extend?["trendScore"] as? String
                    model.up = extend?["up"] as? Bool
                    let nameArr = obj["artists"] as! [NSDictionary]
                    for name in nameArr {
                        model.artistName = name["artistName"] as? String
                    }
                    self.DataArr.append(model)
                }
                self.Data = data
            } else {
                print(error?.localizedFailureReason as Any)
            }
            self.collectionView.reloadData()
        }
        
//        self.collectionView.mj_footer.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.DataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VBHomeCell", for: indexPath) as! VBHomeCell
        let model = self.DataArr[indexPath.item]
        cell.titleLabel.text = model.title!
        cell.numberLabel.text = "\(model.number!)"
        cell.picImg.sd_setImage(with: URL.init(string: model.albumImg!), placeholderImage: UIImage.init(named: "PlaceHolder_VBang~iphone"))
        cell.scoreLabel.text = model.score
        cell.trendLabel.text = model.trendScore
        cell.nameLabel.text = model.artistName!
        if model.up == false {
            cell.isupImg.image = UIImage.init(named: "VChart_down~iphone")
        } else {
            cell.isupImg.image = UIImage.init(named: "VChart_up~iphone")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.DataArr[indexPath.item]
        let vevc = VedioPlayController()
        vevc.ID = model.videoId!
        vevc.hidesBottomBarWhenPushed = true
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let window = delegate.window?.rootViewController as! UITabBarController
        let nav = window.viewControllers?[2] as! UINavigationController
        nav.pushViewController(vevc, animated: true)
        
        let mod = NSEntityDescription.insertNewObject(forEntityName: "Vedios", into: SingleContext.context) as! Vedios
        mod.iD = Int32(model.videoId!)
        mod.name = model.artistName
        mod.title = model.title!
        mod.img = NSData.init(contentsOf: URL.init(string: model.posterPic!)!)
        try! SingleContext.context.save()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 140)
    }
}
