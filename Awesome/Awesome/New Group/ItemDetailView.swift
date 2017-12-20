//
//  ItemDetailView.swift
//  Awesome
//
//  Created by Artak on 12/15/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit


class ItemDetailView: UIView {

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDescLabel: UILabel!
    @IBOutlet weak var fullDescLabel: UILabel!
    @IBOutlet weak var levelMeter: LevelMeter!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit(){
        let bundles = Bundle.main.loadNibNamed("ItemDetailView", owner: self, options: nil)
        let xibView = bundles!.first as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        levelMeter.counter = 10
        levelMeter.level = 4
    }
}
