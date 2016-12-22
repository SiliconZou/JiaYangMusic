//
//  FQuanbuViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/26.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class FQuanbuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var DataArr1 = [FHomeModel]()
    var ConArr = [FCHomeModel]()
    var ConArr1 = [FCHomeModel]()
    var ArtistArr = [NSDictionary]()
    var page = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI()
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.tableView.mj_header.endRefreshing()
        })
        self.loadData1(page: page)
        //self.loadData()
        
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 20
            self.loadData1(page: self.page)
            self.tableView.mj_footer.endRefreshing()
        })
        
    }
    
    func createUI() {
        
        tableView.register(UINib.init(nibName: "FTHomeCell", bundle: nil), forCellReuseIdentifier: "FTHomeCell")
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 3))
        view.backgroundColor = UIColor.lightGray
        tableView.tableHeaderView = view
    }
    
    func loadData1(page:Int) {
        let url1 = String.init(format: "http://mapiv2.yinyuetai.com/mediauser/rank.json?offset=%ld&size=20", page)
        BaseRequest.getWithURK(url: url1, para: nil) { (data, error) in
//            let dic = String.init(data: data as! Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
//            print(dic!)
            if error == nil {
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let data = dic["data"] as! NSDictionary
                let artistArr = data["artistList"] as! [NSDictionary]
                self.ArtistArr.append(contentsOf: artistArr)
                for obj in artistArr {
                    let artist = obj["artist"] as! NSDictionary
                    let model = FHomeModel()
                    model.artistId = artist["artistId"] as? Int
                    model.name = artist["name"] as? String
                    model.smallAvatar = artist["smallAvatar"] as? String
                    model.subCount = artist["subCount"] as? Int
                    model.videoCount = artist["videoCount"] as? Int
                    self.DataArr1.append(model)
                }
                
            } else {
                print(error?.localizedFailureReason as Any)
            }
            self.tableView.reloadData()
        }
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.DataArr1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "FTHomeCell", for: indexPath) as! FTHomeCell
            //print(indexPath.section ,indexPath.item)
            let model = self.DataArr1[indexPath.item]
            //print(model.name!)
            cell1.picImg.sd_setImage(with: URL.init(string: model.smallAvatar!), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
            cell1.nameLabel.text = model.name!
            cell1.vedioCountLabel.text = "\(model.videoCount!)首mv"
            cell1.subCountLabel.text = "\(model.subCount!)个人订阅"
            cell1.selectionStyle = .none
            let contents = self.ArtistArr[indexPath.item]
            let conarr = contents["contents"] as! [NSDictionary]
            self.ConArr1.removeAll()
            for con in conarr {
                let model = FCHomeModel()
                model.posterPic = con["posterPic"] as? String
                model.totalView = con["totalView"] as? Int
                model.title = con["title"] as? String
                model.videoId = con["videoId"] as? Int
                let nameArr = con["artists"] as! [NSDictionary]
                for name in nameArr {
                    model.artistName = name["artistName"] as? String
                }
                self.ConArr1.append(model)
            }
            cell1.collectionView.reloadData()
            cell1.ConArr = self.ConArr1
            return cell1
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = UIColor.darkText
        label.textAlignment = .left
            label.text = "自媒体推荐"
            label.font = UIFont.systemFont(ofSize: 13)
            return label
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            return 165
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            let sectionHeaderHeight:CGFloat = 10
            if scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0 {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
            } else if scrollView.contentOffset.y >= sectionHeaderHeight {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0)
            }
        }
    }

}
