//
//  NYListViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/22.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NYListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var DataArr = [NYirenModel]()
    var config = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.createUI()
    }

    func createUI() {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "热门艺人"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        tableView.register(UINib.init(nibName: "NYirendetailCell", bundle: nil), forCellReuseIdentifier: "NYirendetailCell")
    }
    
    func loadData() {
        let urlStr = String.init(format: "http://mapiv2.yinyuetai.com/artist/search.json?%@", config)
        BaseRequest.getWithURK(url: urlStr, para: nil) { (data, error) in
            if error == nil {
                
//                let dica = NSString.init(data: data! as Data, encoding: String.Encoding.utf8.rawValue)
//                print(dica!)

                let obj = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                let data = obj["data"] as! [NSDictionary]
                let data1 = data[0]
                let dataArr = data1["artistList"] as! [NSDictionary]
                for dic in dataArr {
                    let model = NYirenModel()
                    model.artistImg = dic["smallAvatar"] as? String
                    model.name = dic["name"] as? String
                    model.subCount = dic["subCount"] as? Int
                    model.videoCount = dic["videoCount"] as? Int
                    model.artistId = dic["artistId"] as? Int
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYirendetailCell", for: indexPath) as! NYirendetailCell
        let model = self.DataArr[indexPath.item]
        cell.artistImg.sd_setImage(with: URL.init(string: model.artistImg!), placeholderImage: UIImage.init(named: "PlaceHolder_OtherUser~iphone"))
        cell.nameLabe.text = model.name!
        cell.subLabel.text = "\(model.subCount!)人预定"
        cell.vediocountLabel.text = "\(model.videoCount!)首MV"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.DataArr[indexPath.row]
        let yDetailVC = YMVViewController()
        yDetailVC.name = model.name!
        yDetailVC.ID = model.artistId!
        yDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(yDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
}
