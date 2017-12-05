//
//  LevelView.swift
//  Awesome
//
//  Created by Artak on 12/5/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

@IBDesignable class LevelView: UIView {

    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var arrowView: ArrowView!
    @IBInspectable var counter: Int = 10
        {
        didSet {
            counterView?.counter = counter
            arrowView?.counter = counter
        }
    }
    
    
    @IBInspectable var level: Int = 1
        {
        didSet {
            arrowView?.level = level
        }
    }
//
    

}
