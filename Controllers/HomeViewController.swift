//
//  HomeViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/14.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class HomeViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var picDataArr = [String]()
    var btnDataArr = [String]()
    var dataArr = [NSDictionary]()
    var contentDataArr = [ContentModel]()
    var artistArr = [ContentModel]()
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
        label.text = "首页"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        let rightBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 45, height: 45))
        rightBtn.setBackgroundImage(UIImage.init(named: "home_history~iphone"), for: .normal)
        rightBtn.setBackgroundImage(UIImage.init(named: "home_history_sel~iphone"), for: .highlighted)
        rightBtn.addTarget(self, action: #selector(self.historyClick(button:)), for: .touchUpInside)
        let rightItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightItem
        
        collectionView.register(UINib.init(nibName: "HfirstCell", bundle: nil), forCellWithReuseIdentifier: "HfirstCell")
        collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        collectionView.register(UINib.init(nibName: "HheaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HheaderView")
        collectionView.register(UINib.init(nibName: "HfooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "HfooterView")
    }
    func historyClick(button:UIButton) {
        let hisVC = HistoryViewController()
        self.navigationController?.pushViewController(hisVC, animated: true)
    }
    
    func loadData() {
        
        let urlStr = "http://mapiv2.yinyuetai.com/component/prefecture.json?type=1"
        BaseRequest.getWithURK(url: urlStr, para: nil) { (data, error) in
            
            if error == nil {
//                let obj = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//                print(obj!)
                let dic = try! JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as? NSDictionary
                let datarr = dic?["data"] as! [NSDictionary]
                self.dataArr = datarr
                let picData = self.dataArr[0]
                let picDataArr = picData["data"] as! [NSDictionary]
                for pic in picDataArr {
                    var picUrl = pic["posterPic"] as? String
                    if picUrl == nil {
                        picUrl = ""
                    }
                    self.picDataArr.append(picUrl!)
                }
                let btnData = self.dataArr[1]
                let btnarr = btnData["data"] as! [NSDictionary]
                for btn in btnarr {
                    let btnUrl = btn["icon"] as? String
                    self.btnDataArr.append(btnUrl!)
                }
                
            } else {
                print(error?.localizedDescription as Any)
            }
             self.collectionView.reloadData()
        }
        collectionView.mj_header.endRefreshing()
    }
    
    func ShangChengClick() {
        let webVC = ShangChengViewController()
        webVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    func TuiJianClick() {
        let HtuiVC = HTuijianViewController()
        HtuiVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(HtuiVC, animated: true)
    }
    func YueDanClick() {
        let HyueVC = HYuedanViewController()
        HyueVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(HyueVC, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataArr.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        let sectionContent = self.dataArr[section + 1]
        let sectionContentArr = sectionContent["data"] as! [NSDictionary]
        return sectionContentArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let fcell = collectionView.dequeueReusableCell(withReuseIdentifier: "HfirstCell", for: indexPath) as! HfirstCell
            fcell.scrView.imageURLArray = picDataArr
            fcell.scrView.placeHolderImageName = "PlaceHolder_Home_Title~iphone"
            fcell.yueDanImage.sd_setImage(with: URL.init(string: btnDataArr[0]))
            fcell.shangChengImage.sd_setImage(with: URL.init(string: btnDataArr[1]))
            fcell.tuiJianImage.sd_setImage(with: URL.init(string: btnDataArr[2]))
            fcell.shangChengBtn.addTarget(self, action: #selector(self.ShangChengClick), for: .touchUpInside)
            fcell.tuiJianBtn.addTarget(self, action: #selector(self.TuiJianClick), for: .touchUpInside)
            fcell.yueDanBtn.addTarget(self, action: #selector(self.YueDanClick), for: .touchUpInside)
            return fcell
        } else {
            self.contentDataArr.removeAll()
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
            let dataDic = self.dataArr[indexPath.section + 1]
            let contentDic = dataDic["data"] as! [NSDictionary]
            for obj in contentDic {
                let model = ContentModel()
                model.posterPic = obj["posterPic"] as? String
                model.title = obj["title"] as? String
                model.totalView = obj["totalView"] as? Int
                model.videoId = obj["totalView"] as? Int
                if obj["artists"] == nil {
                    
                } else {
                    let artistArr = obj["artists"] as! [NSDictionary]
                    for artist in artistArr {
                        model.artistId = artist["artistId"] as? Int
                        model.artistName = artist["artistName"] as? String
                    }
                }
                
                self.contentDataArr.append(model)
            }
            let model = contentDataArr[indexPath.item]
            if model.posterPic == nil {
                cell.picImage.image = UIImage.init(named: "PlaceHolder_5.9Movie~iphone")
                cell.isUserInteractionEnabled = false
            } else {
                cell.picImage.sd_setImage(with: URL.init(string: model.posterPic!), placeholderImage: UIImage.init(named: "PlaceHolder_5.9Movie~iphone"))
            }
            
            if model.title == nil {
                cell.titleLabel.text = ""
            } else {
               cell.titleLabel.text = model.title!
            }
            
            if model.artistName == nil {
                cell.artistLabel.text = nil
            } else {
                cell.artistLabel.text = model.artistName!
            }
            
            if model.totalView == nil {
                cell.playcountLabel.text = nil
            } else {
                cell.playcountLabel.text = "播放量:\(model.totalView!)"
            }
            cell.backgroundColor = UIColor.white
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        artistArr.removeAll()
        let dataDic = self.dataArr[indexPath.section + 1]
        let contentDic = dataDic["data"] as! [NSDictionary]
        for obj in contentDic {
            let model = ContentModel()
            model.videoId = obj["videoId"] as? Int
            model.posterPic = obj["posterPic"] as? String
            model.title = obj["title"] as? String
            let artistarr = obj["artists"] as! [NSDictionary]
            for artist in artistarr {
                model.artistId = artist["artistId"] as? Int
                model.artistName = artist["artistName"] as? String
            }
            self.artistArr.append(model)
        }
        let model = artistArr[indexPath.item]
        //print(model.videoId!)
        let vevc = VedioPlayController()
        vevc.ID = model.videoId!
        vevc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vevc, animated: true)
//        self.present(vevc, animated: true, completion: nil)
        
        let mod = NSEntityDescription.insertNewObject(forEntityName: "Vedios", into: SingleContext.context) as! Vedios
        mod.iD = Int32(model.videoId!)
        mod.name = model.artistName!
        mod.title = model.title!
        mod.img = NSData.init(contentsOf: URL.init(string: model.posterPic!)!)
        try! SingleContext.context.save()
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HheaderView", for: indexPath) as! HheaderView
            let dataDic = self.dataArr[indexPath.section + 1]
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
        if indexPath.section == 0 {
            return CGSize.init(width: UIScreen.main.bounds.size.width, height: 270)
        }
        let cellWidth = (UIScreen.main.bounds.size.width - 30) / 2
        return CGSize.init(width: cellWidth, height: cellWidth * 145 / 220 + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.init(width: UIScreen.main.bounds.size.width, height: 0)
        }
        return CGSize.init(width: UIScreen.main.bounds.size.width, height: 40)
    }
}
