//
//  VBBillCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/25.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class VBBillCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var wksLabel: UILabel!
    @IBOutlet weak var peakLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        picImg.layer.masksToBounds = true
        picImg.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
