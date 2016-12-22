//
//  MineViewController.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/14.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class MineViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var headBackImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "MfirstTableViewCell", bundle: nil), forCellReuseIdentifier: "mfirst")
        tableView.register(UINib.init(nibName: "MsecondTableViewCell", bundle: nil), forCellReuseIdentifier: "msecond")
        tableView.register(UINib.init(nibName: "MthirdTableViewCell", bundle: nil), forCellReuseIdentifier: "mthird")
        tableView.register(UINib.init(nibName: "MforthTableViewCell", bundle: nil), forCellReuseIdentifier: "mforth")
    }
    
    func createUI() {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        label.text = "我的"
        label.textColor = UIColor.white
        self.navigationItem.titleView = label
        
        let setBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
        setBtn.setBackgroundImage(UIImage.init(named: "set_icon~iphone"), for: .normal)
        setBtn.setBackgroundImage(UIImage.init(named: "set_icon_h~iphone"), for: .highlighted)
        setBtn.addTarget(self, action: #selector(self.setClick(button:)), for: .touchUpInside)
        let setItem = UIBarButtonItem.init(customView: setBtn)
        
        let mesBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 28, height: 23))
        mesBtn.setBackgroundImage(UIImage.init(named: "mine_mes~iphone"), for: .normal)
        mesBtn.setBackgroundImage(UIImage.init(named: "mine_mes_h~iphone"), for: .highlighted)
        mesBtn.addTarget(self, action: #selector(self.setClick(button:)), for: .touchUpInside)
        let mesItem = UIBarButtonItem.init(customView: mesBtn)
        
        self.navigationItem.rightBarButtonItems = [setItem,mesItem]
    }
    
    func setClick(button:UIButton) {
        print("set")
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        if offset.y < 0 {
            
            var rect = backImageView.frame
            rect.origin.y = offset.y
            rect.size.height = 200 - offset.y
            print("headBackImage.bounds.origin.y\(headBackImage.bounds.origin.y)")
            //headBackImage.bounds.origin.y = 0 - offset.y / 2
            backImageView.frame = rect
        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mfirst", for: indexPath) as! MfirstTableViewCell
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "msecond", for: indexPath) as! MsecondTableViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mthird", for: indexPath) as! MthirdTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mforth", for: indexPath) as! MforthTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else if indexPath.section == 1 {
            return 120
        } else if indexPath.section == 2 {
            return 90
        } else {
            return 55
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }

}
