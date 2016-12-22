//
//  HistoryViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var DataArr = [Vedios]()
    var rightBtn = UIButton.init(type: .custom)
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI()
        
    }
    
    func createUI() {
        
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "播放记录"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        tableView.register(UINib.init(nibName: "HistoryCell", bundle: nil), forCellReuseIdentifier: "HistoryCell")
       rightBtn.frame = CGRect.init(x: 0, y: 0, width: 60, height: 40)
        rightBtn.setTitle("删除全部", for: .normal)
        rightBtn.setTitleColor(UIColor.white, for: .normal)
        rightBtn.setTitleColor(UIColor.init(red: 43/255, green: 185/255, blue: 110/255, alpha: 1), for: .highlighted)
        rightBtn.addTarget(self, action: #selector(self.rightBtnClick), for: .touchUpInside)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        let rightBtnItem = UIBarButtonItem.init(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightBtnItem
    }
    
    func rightBtnClick() {
            let ac = UIAlertAction.init(title: "是", style: .default) { (action) in
            for vedio in self.DataArr {
                SingleContext.context.delete(vedio)
                try! SingleContext.context.save()
            }
            self.selectedAll()
            SDImageCache.shared().clearDisk()
            URLCache.shared.removeAllCachedResponses()

       }
        let cache1 = URLCache.shared.currentDiskUsage
        let cache = SDImageCache.shared().getSize()
        let size = cache/(1024*1024)
        let size1 = cache1/(1024*1024)
        let big = Int(size) + size1
        let acon = UIAlertController.init(title: "⚠️", message: "是否全部删除,包含\(big)M缓存", preferredStyle: .alert)
        let ac1 = UIAlertAction.init(title: "否", style: .cancel, handler: nil)
        acon.addAction(ac)
        acon.addAction(ac1)
        self.present(acon, animated: true, completion: nil)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.selectedAll()
        
    }
    func selectedAll() {
        DataArr.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Vedios")
        let entity = NSEntityDescription.entity(forEntityName: "Vedios", in: SingleContext.context)
        request.entity = entity
        DataArr = try! SingleContext.context.fetch(request) as! [Vedios]
        tableView.reloadData()
//        for vedio in DataArr {
//            print(vedio.title!)
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.DataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as! HistoryCell
        let model = DataArr[indexPath.row]
        if model.name == nil {
            cell.nameLabel.text = "音悦台"
        } else {
            cell.nameLabel.text = model.name!
        }
        cell.titleLabel.text = model.title!
        if model.img == nil {
            let data = UIImagePNGRepresentation(UIImage.init(named: "PlaceHolder_5.9Movie~iphone")!)
            cell.picImg.image = UIImage.init(data: data!)
        } else {
            cell.picImg.image = UIImage.init(data: model.img! as Data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Vedios")
//        let entity = NSEntityDescription.entity(forEntityName: "Vedios", in: SingleContext.context)
//        request.entity = entity
        let vedio = DataArr[indexPath.row]
        SingleContext.context.delete(vedio)
        try! SingleContext.context.save()
        selectedAll()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = DataArr[indexPath.row]
        let vevc = VedioPlayController()
        vevc.ID = Int(model.iD)
        vevc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vevc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
