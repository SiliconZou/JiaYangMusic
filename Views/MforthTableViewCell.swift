//
//  MforthTableViewCell.swift
//  MusicTai
//
//  Created by Silicon.Zou on 16/10/15.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

import UIKit

class MforthTableViewCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func createClick(_ sender: UIButton) {
        print(345)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
