//
//  ArrowView.swift
//  Awesome
//
//  Created by Artak on 12/4/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

class ArrowView: UIView {
    
    var level: Int = 10{
        didSet{
            self.transform = CGAffineTransform(rotationAngle: AngleCalculator.getArrowAngleOf(segment: level - 1, ofTotal: counter))
        }
    }
    
    var counter: Int = 10{
        didSet{
            self.transform = CGAffineTransform(rotationAngle: AngleCalculator.getArrowAngleOf(segment: level, ofTotal: counter))
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let circleWidth = bounds.width/10
        
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: center.x - circleWidth / 4, y: center.y))
        trianglePath.addLine(to: CGPoint(x: center.x, y: 0))
        trianglePath.addLine(to: CGPoint(x: center.x + circleWidth / 4, y: center.y))
        trianglePath.addLine(to: CGPoint(x: center.x - circleWidth / 4, y: center.y))
        UIColor.orange.setFill()
        trianglePath.fill()
        
        let circleRect = CGRect(origin: CGPoint(x: center.x - circleWidth / 2, y: center.x - circleWidth / 2), size: CGSize(width: circleWidth, height: circleWidth))
        let path = UIBezierPath(ovalIn: circleRect)
        UIColor.green.setFill()
        path.fill()
    }
    
    
}
