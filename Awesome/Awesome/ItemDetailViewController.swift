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
    var level : Int = 8

    @IBOutlet weak var detailView: ItemDetailView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.levelMeter.level = level
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
