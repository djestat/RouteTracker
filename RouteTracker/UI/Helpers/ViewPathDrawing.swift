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
    private func createSubviewBezierPath(_ superView: UIView,
                                 _ firstView: UIView,
                                 _ secondView: UIView,
                                 _ thirdView: UIView) -> UIBezierPath {
        let path = UIBezierPath()
        
        let zeroPoint: CGFloat          = 0
        let yLeftCorner: CGFloat   = superView.frame.height
        let xRightCorner: CGFloat       = superView.frame.width
        let yRightCorner: CGFloat       = superView.frame.height
                
        // starting point for the path (bottom left)
        path.move(to: .zero)
        // segment 1: line
        path.addLine(to: CGPoint(x: firstView.frame.midX,
                                 y: firstView.frame.origin.y + firstView.frame.height / 2 + spacing))
        // segment 2: arc
        path.addArc(withCenter: CGPoint(x: firstView.frame.midX,
                                        y: firstView.frame.midY), // center point of circle
                    radius: firstView.frame.height / 2 + spacing, // this will make it meet our path line
                    startAngle: CGFloat(3 * (CGFloat.pi / 2)), // 270 degrees = straight up
                    endAngle: CGFloat(0), // 0 degrees = straight right
                    clockwise: true) // startAngle to endAngle goes in a clockwise direction
        // segment 3: arc
        path.addArc(withCenter: CGPoint(x: secondView.frame.midX,
                                        y: secondView.frame.midY),
                    radius: secondView.frame.height / 2 + spacing,
                    startAngle: CGFloat.pi, // straight up
                    endAngle: CGFloat(0), // 0 radians = straight right
                    clockwise: false)

        // segment 4: arc
        path.addArc(withCenter: CGPoint(x: thirdView.frame.midX,
                                        y: thirdView.frame.midY),
                    radius: thirdView.frame.height / 2 + spacing,
                    startAngle: CGFloat.pi, // straight up
                    endAngle: CGFloat(0), // 0 radians = straight right
                    clockwise: true)

        // segment 5: line
        path.addLine(to: CGPoint(x: xRightCorner,
                                 y: zeroPoint))
        // segment 6: line
        path.addLine(to: CGPoint(x: xRightCorner,
                                 y: yRightCorner))
        // segment 7: line
        path.addLine(to: CGPoint(x: zeroPoint,
                                 y: yLeftCorner))
        // segment 8: line
        path.addLine(to: .zero)
        path.close()
        
        return path
    }
    
    private func createStartButtonViewBezierPath(_ superView: UIView) -> UIBezierPath {
        let path = UIBezierPath(ovalIn: CGRect(x: 0,
                                               y: 0,
                                               width: superView.frame.width,
                                               height: superView.frame.height))
        
        return path
    }
    
    //MARK: - Public methods
    
    
    public func createFooterControlShapeLayer(firstView: FooterControlView,
                                         secondView: FooterStartView) -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
//        let path = createSubviewBezierPath(firstView, firstView.avatarPhotoButton, firstView.zoomButton, secondView.startTrackerButton)
        let path = createSubviewBezierPath2(firstView, secondView)

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
    
    
    private func createSubviewBezierPath2(_ superView: FooterControlView,
                                          _ secondView: FooterStartView) -> UIBezierPath {
        let path = UIBezierPath()
        
        let zeroPoint: CGFloat          = 0
        let yLeftCorner: CGFloat        = superView.frame.height
        let xRightCorner: CGFloat       = superView.frame.width
        let yRightCorner: CGFloat       = superView.frame.height
                
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
                    endAngle: CGFloat(0), // 0 degrees = straight right
                    clockwise: true) // startAngle to endAngle goes in a clockwise direction
        
        // segment 3: arc
        path.addArc(withCenter: CGPoint(x: superView.frame.midX,
                                        y: zeroPoint), // center point of circle
                    radius: (secondView.frame.width  + spacing) / 2, // this will make it meet our path line
                    startAngle: CGFloat(CGFloat.pi), // 180 degrees = straight up
                    endAngle: CGFloat(0), // 0 degrees = straight right
                    clockwise: false) // startAngle to endAngle goes in a not clockwise direction
        
        // segment 2: arc
        path.addArc(withCenter: CGPoint(x: superView.frame.midX + (secondView.frame.width / 2) + spacing,
                                        y: zeroPoint + spacing / 2), // center point of circle
                    radius: (spacing / 2), // this will make it meet our path line
                    startAngle: CGFloat(CGFloat.pi), // 180 degrees = straight up
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
