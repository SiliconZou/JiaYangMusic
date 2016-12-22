//
//  MthirdTableViewCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/15.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class MthirdTableViewCell: UITableViewCell {

    @IBOutlet weak var xiaoxiBtn: UIButton!
    @IBOutlet weak var lishiBtn: UIButton!
    @IBOutlet weak var dingyueBtn: UIButton!
    @IBOutlet weak var shoucangBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        dingyueBtn.setBackgroundImage(UIImage.init(named: "mine_rss_btn_p~iphone"), for: .highlighted)
        xiaoxiBtn.setBackgroundImage(UIImage.init(named: "mine_meg_btn_p~iphone"), for: .highlighted)
        shoucangBtn.setBackgroundImage(UIImage.init(named: "mine_fav_btn_p~iphone"), for: .highlighted)
        lishiBtn.setBackgroundImage(UIImage.init(named: "mine_his_btn_p~iphone"), for: .highlighted)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
