//
//  NMvViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/20.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class NMvViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var zuiXinBtn: UIButton!

    @IBOutlet weak var haoPingBtn: UIButton!
    @IBOutlet weak var zuiReBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArr = [ContentModel]()
    var page = 0
    var page1 = 0
    var page2 = 0
    var istrue = true
    override func viewDidLoad() {
        super.viewDidLoad()
        zuiXinBtn.isSelected = true
        self.createUI()
        let str = "REGDATE"
        collectionView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.collectionView.mj_header.endRefreshing()
        })
        self.loadData(config: str, page: 0)
        page = 0
        collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 20
            self.loadData(config: str, page: self.page)
            self.collectionView.mj_footer.endRefreshing()
        })
        collectionView.mj_header.beginRefreshing()
    }
    
    func createUI() {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "全部MV"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        zuiXinBtn.setTitleColor(UIColor.init(red: 43/255, green: 185/255, blue: 110/255, alpha: 1), for: .selected)
        zuiReBtn.setTitleColor(UIColor.init(red: 43/255, green: 185/255, blue: 110/255, alpha: 1), for: .selected)
        haoPingBtn.setTitleColor(UIColor.init(red: 43/255, green: 185/255, blue: 110/255, alpha: 1), for: .selected)
        self.collectionView.register(UINib.init(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
    }
    
    @IBAction func xinBtnClick(_ sender: UIButton) {
        zuiReBtn.isSelected = false
        haoPingBtn.isSelected = false
        sender.isSelected = true
        self.dataArr.removeAll()
        let str = "REGDATE"
        self.loadData(config: str, page: 0)
        page = 0
        collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 20
            self.loadData(config: str, page: self.page)
            self.collectionView.mj_footer.endRefreshing()
        })
        
    }
    @IBAction func haoBtnClick(_ sender: UIButton) {
        zuiXinBtn.isSelected = false
        zuiReBtn.isSelected = false
        haoPingBtn.isSelected = true
        self.dataArr.removeAll()
        let str = "DAY_RECOMMENDS"
        self.loadData(config: str, page: 0)
        page2 = 0
        collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page2 += 20
            self.loadData(config: str, page: self.page2)
            self.collectionView.mj_footer.endRefreshing()
        })
    }
    

    @IBAction func reBtnClick(_ sender: UIButton) {
        zuiXinBtn.isSelected = false
        haoPingBtn.isSelected = false
        zuiReBtn.isSelected = true
        self.dataArr.removeAll()
        let str = "DAY_VIEWS"
        self.loadData(config: str, page: 0)
        page1 = 0
        collectionView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page1 += 20
            self.loadData(config: str, page: self.page1)
            self.collectionView.mj_footer.endRefreshing()
        })
    }
        
    func loadData(config:String,page:Int) {
        let urlStr = String.init(format: "http://mapiv2.yinyuetai.com/mv/search.json?offset=%ld&size=20&sort=%@",page,config)
        BaseRequest.getWithURK(url: urlStr, para: nil) { (data, error) in
            
//                let obj = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//                print(obj!)
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as? NSDictionary
                if dic?["data"] == nil {
                    let acon = UIAlertController.init(title: "⚠️", message: "服务器故障，请稍后再试", preferredStyle: .alert)
                    let ac1 = UIAlertAction.init(title: "是", style: .default, handler: { (action) in
                        self.navigationController?.popViewController(animated: true)
                    })
                    acon.addAction(ac1)
                    self.present(acon, animated: true, completion: nil)
                } else {
                    if error == nil {
                        let dicArr = dic?["data"] as! [NSDictionary]
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
