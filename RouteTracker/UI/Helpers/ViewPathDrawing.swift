//
//  ViewPathDrawing.swift
//  RouteTracker
//
//  Created by Igor on 14.08.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

class ViewPathDrawing {
    
    static let draw = ViewPathDrawing()
    private let spacing: CGFloat = 20    
    
    //MARK: - Public methods
    public func createFooterControlShapeLayer(firstView: FooterControlView,
                                         secondView: FooterStartView) -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        let path = createSubviewBezierPath(firstView, secondView)

        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.path = path.cgPath

        return maskLayer
    }
    
    public func createFooterStartShapeLayer(firstView: FooterStartView) -> CAShapeLayer {
            let maskLayer = CAShapeLayer()
            let path = createStartButtonViewBezierPath(firstView)

            maskLayer.backgroundColor = UIColor.clear.cgColor
            maskLayer.path = path.cgPath

            return maskLayer
        }
    
    //MARK: - Private methods
    private func createStartButtonViewBezierPath(_ superView: UIView) -> UIBezierPath {
        let path = UIBezierPath(ovalIn: CGRect(x: 0,
                                               y: 0,
                                               width: superView.frame.width,
                                               height: superView.frame.height))
        
        return path
    }
    
    private func createSubviewBezierPath(_ superView: FooterControlView,
                                          _ secondView: FooterStartView) -> UIBezierPath {
        let path = UIBezierPath()
        
        let zeroPoint: CGFloat          = 0
        let yLeftCorner: CGFloat        = superView.frame.height
        let xRightCorner: CGFloat       = superView.frame.width
        let yRightCorner: CGFloat       = superView.frame.height
        
        //
        
        let aLong: CGFloat = (secondView.frame.width / 2) + spacing
        let bShort: CGFloat = spacing / 2
        let degrees = DegreesToAB(aLong: aLong, bShort: bShort)
        
        // starting point for the path (bottom left)
        path.move(to: CGPoint(x: zeroPoint,
                              y: yLeftCorner))
        path.addLine(to: CGPoint(x: zeroPoint, y: zeroPoint))
        // segment 1: line
        path.addLine(to: CGPoint(x: superView.avatarPhotoButton.frame.midX - secondView.frame.width - spacing / 2 - spacing,
                                 y: zeroPoint))
        // segment 2: arc
        path.addArc(withCenter: CGPoint(x: superView.frame.midX - (secondView.frame.width / 2) - spacing,
                                        y: zeroPoint + spacing / 2), // center point of circle
                    radius: (spacing / 2), // this will make it meet our path line
                    startAngle: CGFloat(3 * CGFloat.pi / 2), // 90 degrees = straight up
                    endAngle: CGFloat(0 - degrees[1]), // 0 degrees = straight right
                    clockwise: true) // startAngle to endAngle goes in a clockwise direction
        
        // segment 3: arc
        path.addArc(withCenter: CGPoint(x: superView.frame.midX,
                                        y: zeroPoint), // center point of circle
                    radius: (secondView.frame.width + spacing) / 2, // this will make it meet our path line
                    startAngle: CGFloat(CGFloat.pi - degrees[1]), // 180 degrees = straight up
                    endAngle: CGFloat(0 + degrees[1]), // 0 degrees = straight right
                    clockwise: false) // startAngle to endAngle goes in a not clockwise direction
        
        // segment 2: arc
        path.addArc(withCenter: CGPoint(x: superView.frame.midX + (secondView.frame.width / 2) + spacing,
                                        y: zeroPoint + spacing / 2), // center point of circle
                    radius: (spacing / 2), // this will make it meet our path line
                    startAngle: CGFloat(CGFloat.pi + degrees[1]), // 180 degrees = straight up
                    endAngle: CGFloat(3 * CGFloat.pi / 2), // 90 degrees = straight right
                    clockwise: true) // startAngle to endAngle goes in a clockwise direction
        
        // segment 4: line
        path.addLine(to: CGPoint(x: xRightCorner,
                                 y: zeroPoint))
        // segment 5: line
        path.addLine(to: CGPoint(x: xRightCorner,
                                 y: yRightCorner))
        // segment 6: line
        path.addLine(to: CGPoint(x: zeroPoint,
                                 y: yLeftCorner))
        // segment 7: line
        path.close()
        
        return path
    }
}
