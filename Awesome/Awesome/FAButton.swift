//
//  FAButton.swift
//  Awesome
//
//  Created by Artak on 11/27/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

class FAButton: UIButton {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        UIColor.green.setFill()
        path.fill()
    }

}
