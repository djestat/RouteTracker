//
//  CustomeView.swift
//  RouteTracker
//
//  Created by Igor on 15.08.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

class CustomeView: UIView {
    
    let pathDrawer = ViewPathDrawing()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Error!")
    }

    func setup(frame: CGRect) {

        // Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()

        // The Bezier path that we made needs to be converted to
        // a CGPath before it can be used on a layer.
//        shapeLayer.path = pathDrawer.createSubviewBezierPath(UIView, UIView, UIView, UIView).cgPath

        // apply other properties related to the path
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.position = CGPoint(x: 10, y: 10)

        // add the new layer to our custom view
        self.layer.addSublayer(shapeLayer)
    }
}
