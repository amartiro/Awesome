//
//  ItemCell.swift
//  Awesome
//
//  Created by Artak on 11/20/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescr: UILabel!
    @IBOutlet weak var levelBkg: UIView!
    @IBOutlet weak var levelLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        levelBkg.layer.cornerRadius = levelBkg.bounds.size.width / 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
