//
//  ItemDetailViewController.swift
//  Awesome
//
//  Created by Artak on 11/21/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit
import Kingfisher

class ItemDetailViewController: UIViewController {
    var level : Int!
    var item : CommonItem!

    @IBOutlet weak var detailView: ItemDetailView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.levelMeter.level = item.level
        detailView.titleLabel.text = item.title
        detailView.shortDescLabel.text = item.shortDesc
        detailView.fullDescLabel.text = item.longDesc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
