//
//  HfirstCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/17.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class HfirstCell: UICollectionViewCell {

    @IBOutlet weak var tuiJianImage: UIImageView!
    @IBOutlet weak var shangChengImage: UIImageView!
    @IBOutlet weak var yueDanImage: UIImageView!
    @IBOutlet weak var picView: UIView!
    
    @IBOutlet weak var tuiJianBtn: UIButton!
    @IBOutlet weak var shangChengBtn: UIButton!
    @IBOutlet weak var yueDanBtn: UIButton!
    var scrView = XTADScrollView()

    override func awakeFromNib() {
        super.awakeFromNib()
        scrView = XTADScrollView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
        scrView.infiniteLoop = true
        scrView.needPageControl = false
        picView.addSubview(scrView)
        
    }
}
