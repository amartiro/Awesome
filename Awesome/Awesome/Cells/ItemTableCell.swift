//
//  ItemTableCell.swift
//  Awesome
//
//  Created by Artak on 2/14/18.
//  Copyright © 2018 Artak. All rights reserved.
//

import UIKit

class ItemTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescr: UILabel!
    @IBOutlet weak var levelBkg: UIView!
    @IBOutlet weak var levelLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         levelBkg.layer.cornerRadius = levelBkg.bounds.size.width / 2.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
