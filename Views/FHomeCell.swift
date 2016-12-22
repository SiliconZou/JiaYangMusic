//
//  FHomeCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/26.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit
import CoreData
class FHomeCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subCountLabel: UILabel!
    @IBOutlet weak var videoCountLabel: UILabel!
    @IBOutlet weak var picImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var ConArr = [FCHomeModel]()
    var artistArr = [NSDictionary]()
    override func awakeFromNib() {
        super.awakeFromNib()
        picImg.layer.masksToBounds = true
        picImg.layer.cornerRadius = 24
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "FCHomeCell", bundle: nil), forCellWithReuseIdentifier: "FCHomeCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.ConArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FCHomeCell", for: indexPath) as! FCHomeCell
        let model = self.ConArr[indexPath.item]
        cell.picImg.sd_setImage(with: URL.init(string: model.posterPic!), placeholderImage: UIImage.init(named: "PlaceHolder_5.9Movie~iphone"))
        cell.playCountLabel.text = "播放数量:\(model.totalView!)"
        cell.titleLabel.text = model.title!
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = self.ConArr[indexPath.item]
        let veVC = VedioPlayController()
        veVC.ID = model.videoId!
        //veVC.type = 2
        veVC.hidesBottomBarWhenPushed = true
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let window = delegate.window?.rootViewController as! UITabBarController
        let nav = window.viewControllers?[3] as! UINavigationController
        nav.pushViewController(veVC, animated: true)
        
        let mod = NSEntityDescription.insertNewObject(forEntityName: "Vedios", into: SingleContext.context) as! Vedios
        mod.iD = Int32(model.videoId!)
        mod.name = model.artistName
        mod.title = model.title!
        mod.img = NSData.init(contentsOf: URL.init(string: model.posterPic!)!)
        try! SingleContext.context.save()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 130, height: 89)
    }
}
