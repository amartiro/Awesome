//
//  GridCell.swift
//  Awesome
//
//  Created by Artak on 12/11/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

class GridCell: UITableViewCell {

    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor.blue
        
       // rightView.backgroundColor = .red
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
