//
//  NsecondTableViewCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/19.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class NsecondTableViewCell: UITableViewCell {

    @IBOutlet weak var zongBtn: UIButton!
   
    @IBOutlet weak var zongLabel: UILabel!
    @IBOutlet weak var fanPaBtn: UIButton!
    @IBOutlet weak var fanPaLabel: UILabel!
    @IBOutlet weak var shangChengBtn: UIButton!
    @IBOutlet weak var shangChengLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
