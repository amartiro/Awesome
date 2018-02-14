//
//  GridCell.swift
//  Awesome
//
//  Created by Artak on 12/11/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {

    @IBOutlet weak var levelBkg: UIView!
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var levelLabel: UILabel?
    @IBOutlet weak var shortDescLabel: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        levelBkg.layer.cornerRadius = levelBkg.bounds.size.width / 2.0
        self.contentView.backgroundColor = UIColor.white
    }


}
