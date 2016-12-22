//
//  NYTwoListViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/22.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NYTwoListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var DataArr = [NSDictionary]()
    var RowDataArr = [NYirenModel]()
    var RowDataArr1 = [NYirenModel]()
    var Titlen = ""
    var config = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        self.createUI()
        
    }
    func createUI() {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = Titlen
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
                let dic = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
                self.DataArr = dic["data"] as! [NSDictionary]
                
            } else {
                print(error?.localizedFailureReason as Any)
            }
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.DataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let obj = self.DataArr[section]
        let rowArr = obj["artistList"] as! [NSDictionary]
        return rowArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        RowDataArr.removeAll()
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYirendetailCell", for: indexPath) as! NYirendetailCell
        let obj = self.DataArr[indexPath.section]
        let rowArr = obj["artistList"] as! [NSDictionary]
        for dic in rowArr {
            let model = NYirenModel()
            model.artistId = dic["artistId"] as? Int
            model.name = dic["name"] as? String
            model.subCount = dic["subCount"] as? Int
            model.videoCount = dic["videoCount"] as? Int
            model.artistImg = dic["smallAvatar"] as? String
            self.RowDataArr.append(model)
        }
        let model = self.RowDataArr[indexPath.row]
        if model.artistImg == nil {
            cell.artistImg.image = UIImage.init(named: "PlaceHolder_Home_Title~iphone")
        } else {
            cell.artistImg.sd_setImage(with: URL.init(string: model.artistImg!), placeholderImage: UIImage.init(named: "PlaceHolder_Home_Title~iphone"))
        }
        cell.nameLabe.text = model.name!
        cell.subLabel.text = "\(model.subCount!)人预定"
        cell.vediocountLabel.text = "\(model.videoCount!)首MV"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.RowDataArr1.removeAll()
        let obj = self.DataArr[indexPath.section]
        let rowArr = obj["artistList"] as! [NSDictionary]
        for dic in rowArr {
            let model = NYirenModel()
            model.artistId = dic["artistId"] as? Int
            model.name = dic["name"] as? String
            self.RowDataArr1.append(model)
        }
        let model = self.RowDataArr1[indexPath.row]
        let yDetailVC = YMVViewController()
        yDetailVC.name = model.name!
        yDetailVC.ID = model.artistId!
        yDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(yDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let btn = UILabel.init()
        btn.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 0.7)
        btn.textColor = UIColor.lightGray
        let headerDic = self.DataArr[section]
        let abc = headerDic["initial"] as? String
        btn.text = abc!
        btn.textAlignment = .left
        return btn
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var tmpArr = [String]()
        for i in self.intFromChar(c: "A")...self.intFromChar(c: "Z") {
            tmpArr.append(self.charFromInt(i: i))
        }
        return tmpArr
    }

}

extension NYTwoListViewController {
    
    func intFromChar(c: String) -> Int {
        return c.unicodeScalars.last!.hashValue
    }
    
    func charFromInt(i: Int) -> String {
        return String.init(Character.init(UnicodeScalar.init(i)!))
    }
}



