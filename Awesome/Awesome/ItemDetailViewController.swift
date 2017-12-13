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
    var level : Int = 5

    @IBOutlet weak var levelMeter: LevelMeter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.levelMeter.level = level
        self.levelMeter.counter = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
