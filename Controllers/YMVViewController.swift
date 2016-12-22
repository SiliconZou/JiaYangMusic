//
//  YMVViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/27.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class YMVViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var ID:Int?
    var name:String?
    var DataArr = [NSDictionary]()
    var datasArr = [NSDictionary]()
    var ListArr = [YiMVModel]()
    var NameArr = [YiMVModel]()
    var vedioArr = [YiMVModel]()
    var Arr = [NSDictionary]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(con: ID!)
        collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        collectionView.register(UINib.init(nibName: "HheaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HheaderView")
        collectionView.register(UINib.init(nibName: "HfooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "HfooterView")
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = name!
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
    }
    
    func loadData(con:Int) {
        let url = String.init(format: "http://mapiv2.yinyuetai.com/artist/info.json?artistId=%ld", con)
        BaseRequest.getWithURK(url: url, para: nil) { (data, error) in
//            let obj = NSString.init(data: data as! Data, encoding: String.Encoding.utf8.rawValue)
//            print(obj!)
            if error == nil {
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let data = dic["data"] as! NSDictionary
                self.DataArr = data["artistMVs"] as! [NSDictionary]
            } else {
                print(error?.localizedFailureReason as Any)
            }
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        for dt in DataArr {
            if (dt["list"] as! [NSDictionary]).count == 0 {
                
            } else {
                datasArr.append(dt)
            }
        }
        return datasArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let obj = datasArr[section]
        Arr = obj["list"] as! [NSDictionary]
        return Arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
       
        let obj = self.datasArr[indexPath.section]
            let listArr = obj["list"] as! [NSDictionary]
       
            self.ListArr.removeAll()
            for list in listArr {
                let model = YiMVModel()
                model.title = list["title"] as? String
                model.posterPic = list["posterPic"] as? String
                model.totalView = list["totalView"] as? Int
                model.videoId = list["videoId"] as? Int
                model.regdate = list["regdate"] as? String
                self.ListArr.append(model)
            }
        let model = self.ListArr[indexPath.item]
        cell.artistLabel.text = self.name!
        cell.titleLabel.text = model.title!
        cell.playcountLabel.text = "播放量:\(model.totalView!)"
        cell.picImage.sd_setImage(with: URL.init(string: model.posterPic!), placeholderImage: UIImage.init(named: "PlaceHolder_5.9Movie~iphone"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vedioArr.removeAll()
        let obj = datasArr[indexPath.section]
        let listarr = obj["list"] as! [NSDictionary]
        for vedio in listarr {
            let model = YiMVModel()
            model.videoId = vedio["videoId"] as? Int
            model.title = vedio["title"] as? String
            model.posterPic = vedio["posterPic"] as? String
            self.vedioArr.append(model)
        }
        
        let mo = self.vedioArr[indexPath.item]
        let vevc = VedioPlayController()
        vevc.ID = mo.videoId!
        vevc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vevc, animated: true)
        
        let mod = NSEntityDescription.insertNewObject(forEntityName: "Vedios", into: SingleContext.context) as! Vedios
        mod.iD = Int32(mo.videoId!)
        mod.name = self.name!
        mod.title = mo.title!
        mod.img = NSData.init(contentsOf: URL.init(string: mo.posterPic!)!)
        try! SingleContext.context.save()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HheaderView", for: indexPath) as! HheaderView
            for obj in self.DataArr {
                let model = YiMVModel()
                model.name = obj["name"] as? String
                self.NameArr.append(model)
            }
            let mo = NameArr[indexPath.section]
            headerView.titleLabel.text = mo.name!
            return headerView
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HfooterView", for: indexPath)
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 25)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (UIScreen.main.bounds.size.width - 30) / 2
        return CGSize.init(width: cellWidth, height: cellWidth * 145 / 220 + 30)
    }
}
