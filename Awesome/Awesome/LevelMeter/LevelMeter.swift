//
//  LevelMeter.swift
//  Awesome
//
//  Created by Artak on 12/4/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

class LevelMeter: UIView {

    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var arrowView: ArrowView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let bundles = Bundle.main.loadNibNamed("LevelMeter", owner: self, options: nil)
        let xibView = bundles!.first as! UIView
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        xibView.backgroundColor = UIColor.clear
        self.addSubview(xibView)
        self.backgroundColor = UIColor.clear

    }
    
    var counter: Int = 1{
        didSet {
            counterView.counter = counter
            arrowView.counter = counter
        }
    }
    
    var level: Int = 1{
        didSet {
            arrowView.level = level
        }
    }
}
