//
//  NOTuijianViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/21.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class NOTuijianViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArr = [ContentModel]()
    var nameArr = [String]()
    //http://mapiv2.yinyuetai.com/navigation/list.json?area=US&type=US_REC&offset=0&size=20
    var page = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            self.collectionView.mj_header.endRefreshing()
        })
        self.loadData(con: self.page)
        collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 20
            self.loadData(con: self.page)
            self.collectionView.mj_footer.endRefreshing()
        })
        collectionView.mj_header.beginRefreshing()
        
    }
    
    func createUI() {
        
        collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
    }
    
    func loadData(con:Int) {
        let url = String.init(format: "http://mapiv2.yinyuetai.com/navigation/list.json?area=US&type=US_REC&offset=%ld&size=20", con)
        BaseRequest.getWithURK(url: url, para: nil) { (data, error) in
            if error == nil {
                //                let obj = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
                //                print(obj!)
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let dicArr = dic["data"] as! [NSDictionary]
                for obj in dicArr {
                    let model = ContentModel()
                    model.title = obj["title"] as? String
                    model.posterPic = obj["posterPic"] as? String
                    model.totalView = obj["totalView"] as? Int
                    model.videoId = obj["videoId"] as? Int
                    let artistArr = obj["artists"] as! [NSDictionary]
                    for artist in artistArr {
                        //model.artistId = artist["artistId"] as? Int
                        model.artistName = artist["artistName"] as? String
                    }
                    self.dataArr.append(model)
                }
                
            } else {
                print(error?.localizedFailureReason as Any)
            }
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        let model = dataArr[indexPath.item]
        cell.picImage.sd_setImage(with: URL.init(string: model.posterPic!), placeholderImage: UIImage.init(named: "PlaceHolder_5.9Movie~iphone"))
        if model.title == nil {
            cell.titleLabel.text = ""
        } else {
            cell.titleLabel.text = model.title!
        }
    
        cell.artistLabel.text = model.artistName!
        cell.playcountLabel.text = "播放量:\(model.totalView!)"
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArr[indexPath.item]
        let vevc = VedioPlayController()
        vevc.ID = model.videoId!
        vevc.hidesBottomBarWhenPushed = true
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let window = delegate.window?.rootViewController as! UITabBarController
        let nav = window.viewControllers?[1] as! UINavigationController
        nav.pushViewController(vevc, animated: true)
        
        let mod = NSEntityDescription.insertNewObject(forEntityName: "Vedios", into: SingleContext.context) as! Vedios
        mod.iD = Int32(model.videoId!)
        mod.name = model.artistName!
        mod.title = model.title!
        mod.img = NSData.init(contentsOf: URL.init(string: model.posterPic!)!)
        try! SingleContext.context.save()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.size.width - 30) / 2
        return CGSize.init(width: cellWidth, height: cellWidth * 145 / 220 + 30)
    }
}
