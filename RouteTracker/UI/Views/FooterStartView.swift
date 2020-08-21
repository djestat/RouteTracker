//
//  FooterStartView.swift
//  RouteTracker
//
//  Created by Igor on 15.08.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import UIKit

protocol FooterStartViewDelegate: class {
    func didPressedStartTrackerButton()
}

class FooterStartView: UIView, FooterStartViewDelegate {
    weak var delegate: FooterStartViewDelegate!
    
    public var startTrackerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "on"), for: .normal)
        button.setImage(UIImage(named: "on.highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(didPressedStartTrackerButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = UIColor.FlatColor.Blue.Denim
    }
    
    func addSubviews() {
        addSubview(startTrackerButton)
        
        let heightButton: CGFloat = 80
        
        NSLayoutConstraint.activate([
            startTrackerButton.heightAnchor.constraint(equalToConstant: heightButton),
            startTrackerButton.widthAnchor.constraint(equalToConstant: heightButton),
            startTrackerButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            startTrackerButton.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    // MARK: - Start / stop button Functions
    
    public func setInStartStateTrackerButton() {
        startTrackerButton.setImage(UIImage(named: "on"), for: .normal)
        startTrackerButton.setImage(UIImage(named: "on.highlighted"), for: .highlighted)
        Tracker.shared.setIsStrartedFalse()
    }
    
    private func setInStopStateTrackerButton() {
        startTrackerButton.setImage(UIImage(named: "off"), for: .normal)
        startTrackerButton.setImage(UIImage(named: "off.highlighted"), for: .highlighted)
        Tracker.shared.setIsStrartedTrue()
    }
    
    // MARK: - Delegate Function
    
    @objc func didPressedStartTrackerButton() {
        print("1 is started? \(Tracker.shared.isStarted)")
        if !Tracker.shared.isStarted {
            setInStopStateTrackerButton()
            print("2 set stoped = \(Tracker.shared.isStarted)")
        } else if Tracker.shared.isStarted {
            setInStartStateTrackerButton()
            print("3 set started = \(Tracker.shared.isStarted)")
        }
        delegate.didPressedStartTrackerButton()
    }
}
