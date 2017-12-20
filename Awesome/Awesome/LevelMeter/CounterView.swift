//
//  CounterView.swift
//  Awesome
//
//  Created by Artak on 12/4/17.
//  Copyright © 2017 Artak. All rights reserved.
//

import UIKit

class AngleCalculator{
    
    static func getRangeOf(segment: Int, ofTotal total: Int) -> (CGFloat, CGFloat){
        
        let startAngle: CGFloat = 3 * .pi / 4
        let angleShift = 3 * .pi / (2 * CGFloat(total))
        let delta : CGFloat = 0.02 * angleShift
        
        let beginAngle = startAngle + CGFloat(segment) * angleShift + delta
        let endAngle = beginAngle + angleShift - 2 * delta
        
        return (beginAngle, endAngle)
    }
    
    static func getArrowAngleOf(segment: Int, ofTotal total: Int) -> CGFloat{
        let startAngle: CGFloat = 3 * .pi / 4
        let angleShift = 3 * .pi / (2 * CGFloat(total))
        
        let angle = -startAngle + CGFloat(Double(segment) + 0.5) * angleShift
        
        return angle
    }
        
    static func getColorOf(segment: Int, ofTotal total: Int) -> (UIColor){
        let hue : CGFloat = (CGFloat(segment + 1) / CGFloat(total)) * 0.9
        return UIColor(hue: (0.9 - hue), saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    
}

@IBDesignable  class CounterView: UIView {
    
    @IBInspectable var counter: Int = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        self.backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        // 1
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        // 2
        let radius: CGFloat = max(bounds.width, bounds.height)
        let lineWidth = radius * 0.15
        let radiusCircle = radius/2 - lineWidth/2
        
        for i in 0 ..< counter {
            // 4
            let range = AngleCalculator.getRangeOf(segment: i, ofTotal: counter)
            
            let path = UIBezierPath(arcCenter: center,
                                    radius: radiusCircle,
                                    startAngle: range.0,
                                    endAngle: range.1,
                                    clockwise: true)
            
            // 5
            path.lineWidth = lineWidth
            AngleCalculator.getColorOf(segment: i, ofTotal: counter).setStroke()
            path.stroke()
        }
    }
}
