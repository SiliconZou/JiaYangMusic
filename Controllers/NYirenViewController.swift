//
//  NYirenViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/20.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NYirenViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var DataArr = [NYirenModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        self.loadData()
    }
    
    func createUI() {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "艺人"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        tableView.register(UINib.init(nibName: "NYirenCell", bundle: nil), forCellReuseIdentifier: "NYirenCell")
    }
    
    func loadData() {
        let urlStr = "http://mapiv2.yinyuetai.com/artist/groups.json"
        BaseRequest.getWithURK(url: urlStr, para: nil) { (data, error) in
//            let dic = NSString.init(data: data as! Data, encoding: String.Encoding.utf8.rawValue)
//            print(dic!)
            
            let obj = try! JSONSerialization.jsonObject(with: data as! Data, options: .allowFragments) as! NSDictionary
            if obj["data"] == nil {
                
                let acon = UIAlertController.init(title: "⚠️", message: "服务器故障，请稍后再试", preferredStyle: .alert)
                let ac1 = UIAlertAction.init(title: "是", style: .default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                })
                acon.addAction(ac1)
                self.present(acon, animated: true, completion: nil)
            } else {
                let dataArr = obj["data"] as! [NSDictionary]
                
                if error == nil {
                    for dic in dataArr {
                        let model = NYirenModel()
                        model.artistImg = dic["artistImg"] as? String
                        model.enname = dic["enname"] as? String
                        model.groupImg = dic["groupImg"] as? String
                        model.groupType = dic["groupType"] as? String
                        model.name = dic["name"] as? String
                        self.DataArr.append(model)
                    }
                } else {
                    print(error?.localizedFailureReason as Any)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.DataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYirenCell", for: indexPath) as! NYirenCell
        let model = self.DataArr[indexPath.row]
        cell.artistImg.sd_setImage(with: URL.init(string: model.artistImg!))
        cell.groupImg.sd_setImage(with: URL.init(string: model.groupImg!))
        cell.entitleLabel.text = model.enname!
        cell.titleLabel.text = model.name!
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.DataArr[indexPath.row]
        if indexPath.row == 0 {
            let nylVC = NYListViewController()
            nylVC.config = model.groupType!
            self.navigationController?.pushViewController(nylVC, animated: true)
        } else {
            let nytVC = NYTwoListViewController()
            nytVC.Titlen = model.name!
            nytVC.config = model.groupType!
            self.navigationController?.pushViewController(nytVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
}
