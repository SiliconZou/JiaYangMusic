//
//  NJiemuViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/20.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class NJiemuViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var SectionArr = [NSDictionary]()
    var ItemArr = [ContentModel]()
    var nameArr = [String]()
    var vedioArr = [ContentModel]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.loadData()
        })
        collectionView.mj_header.beginRefreshing()
        self.createUI()
    }
    
    func createUI() {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "音悦节目"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "NJiemuCell", bundle: nil), forCellWithReuseIdentifier: "NJiemuCell")
        collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        collectionView.register(UINib.init(nibName: "HheaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HheaderView")
        collectionView.register(UINib.init(nibName: "HfooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "HfooterView")
    }
    
    func loadData() {
        let urlStr = "http://mapiv2.yinyuetai.com/component/prefecture.json?type=4"
        BaseRequest.getWithURK(url: urlStr, para: nil) { (data, error) in
            if error == nil {
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let sectionDataArr = dic["data"] as! [NSDictionary]
                self.SectionArr = sectionDataArr
//                for section in  sectionDataArr {
//                    let sectionModel = SectionModel()
//                    sectionModel.title = section["title"] as? String
//                    sectionModel.enTitle = section["enTitle"] as? String
//                    self.SectionArr.append(sectionModel)
//                }
            } else {
                print(error?.localizedFailureReason as Any)
            }
            self.collectionView.reloadData()
        }
        collectionView.mj_header.endRefreshing()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.SectionArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let obj = self.SectionArr[section]
        let itemArr = obj["data"] as? [NSDictionary]
        return itemArr!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NJiemuCell", for: indexPath) as! NJiemuCell
            let obj = self.SectionArr[indexPath.section]
            let itemArr = obj["data"] as? [NSDictionary]
            let firstDic = itemArr?[0]
            let artArr = firstDic?["artists"] as! [NSDictionary]
            var nameArr = [String]()
            for art in artArr {
                let name = art["artistName"] as? String
                nameArr.append(name!)
            }
            if nameArr.count == 1 {
                cell.nameLabel.text = nameArr[0]
            } else {
              cell.nameLabel.text = "\(nameArr[0])&\(nameArr[1])"
            }
            cell.titleLabel.text = firstDic?["title"] as? String
            cell.playCountLabel.text = "播放量:\((firstDic?["totalView"] as? Int)!)"
            cell.picImg.sd_setImage(with: URL.init(string: (firstDic?["posterPic"] as? String)!), placeholderImage: UIImage.init(named: "PlaceHolder_Home_Title~iphone"))
            return cell
        } else {
        
            self.ItemArr.removeAll()
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
            let obj = self.SectionArr[indexPath.section]
            let itemArr = obj["data"] as! [NSDictionary]
            self.nameArr.removeAll()
            for item in itemArr {
    
                let model = ContentModel()
                model.title = item["title"] as? String
                model.totalView = item["totalView"] as? Int
                model.posterPic = item["posterPic"] as? String
                self.ItemArr.append(model)
            }
            let item1 = itemArr[indexPath.item]
            let artArr = item1["artists"] as! [NSDictionary]
            for art in artArr {
                let name = art["artistName"] as? String
                self.nameArr.append(name!)
            }
            if self.nameArr.count == 1 {
                cell.artistLabel.text = self.nameArr[0]
            } else {
                cell.artistLabel.text = "\(self.nameArr[0])&\(self.nameArr[1])"
            }

            let model = self.ItemArr[indexPath.item]
            cell.picImage.sd_setImage(with: URL.init(string: model.posterPic!), placeholderImage: UIImage.init(named: "PlaceHolder_Home_Title~iphone"))
            cell.titleLabel.text = model.title!
            cell.playcountLabel.text = "播放量:\(model.totalView!)"
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.vedioArr.removeAll()
        let obj = self.SectionArr[indexPath.section]
        let itemArr = obj["data"] as! [NSDictionary]
        for item in itemArr {
            let model = ContentModel()
            model.videoId = item["videoId"] as? Int
            model.title = item["title"] as? String
            model.posterPic = item["posterPic"] as? String
            self.vedioArr.append(model)
        }
        let item1 = itemArr[indexPath.item]
        let artArr = item1["artists"] as! [NSDictionary]
        for art in artArr {
            let name = art["artistName"] as? String
            self.nameArr.append(name!)
        }
        
        let model = vedioArr[indexPath.item]
        let veVC = VedioPlayController()
        
        veVC.ID = model.videoId!
        
        self.navigationController?.pushViewController(veVC, animated: true)
        
        let mod = NSEntityDescription.insertNewObject(forEntityName: "Vedios", into: SingleContext.context) as! Vedios
        mod.iD = Int32(model.videoId!)
        mod.name = self.nameArr[0]
        mod.title = model.title!
        mod.img = NSData.init(contentsOf: URL.init(string: model.posterPic!)!)
        try! SingleContext.context.save()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HheaderView", for: indexPath) as! HheaderView
            let dataDic = self.SectionArr[indexPath.section]
            let model = SectionModel()
            model.enTitle = dataDic["enTitle"] as? String
            model.title = dataDic["title"] as? String
            headerView.entitleLabel.text = model.enTitle
            headerView.titleLabel.text = model.title
            return headerView
        } else {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HfooterView", for: indexPath)
            return footer
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize.init(width: UIScreen.main.bounds.size.width, height: 165)
        }
        let cellWidth = (UIScreen.main.bounds.size.width - 30) / 2
        return CGSize.init(width: cellWidth, height: cellWidth * 145 / 220 + 30)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 40)
    }

    
}
