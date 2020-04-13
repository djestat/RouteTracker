//
//  HeaderControlView.swift
//  RouteTracker
//
//  Created by Igor on 29.03.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

protocol HeaderControlViewDelegate: class {
    func didPressedShowLastRouteButton()
    func didPressedStartTrackerButton()
}

class HeaderControlView: UIView, HeaderControlViewDelegate {
   
    weak var delegate: HeaderControlViewDelegate!
    public var isStartedTracker: Bool = false

    private var showLastRouteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.setTitle("Show Last Route", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.systemGray, for: .highlighted)
        button.addTarget(self, action: #selector(didPressedShowLastRouteButton), for: .touchUpInside)
        return button
    }()
    
    private var startTrackerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.setTitle("Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.systemGray, for: .highlighted)
        button.addTarget(self, action: #selector(didPressedStartTrackerButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(showLastRouteButton)
        addSubview(startTrackerButton)
        
        let safeAreaSpacing: CGFloat = 12
        
        let heightButton: CGFloat = 40
        let widthButton: CGFloat = 80
        
        NSLayoutConstraint.activate([
            showLastRouteButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: safeAreaSpacing),
            showLastRouteButton.heightAnchor.constraint(equalToConstant: heightButton),
//            showLastRouteButton.rightAnchor.constraint(equalTo: startTrackerButton.leftAnchor, constant: -safeAreaSpacing),
            showLastRouteButton.widthAnchor.constraint(equalToConstant: widthButton * 2),
            showLastRouteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaSpacing),
            startTrackerButton.heightAnchor.constraint(equalToConstant: heightButton),
            startTrackerButton.widthAnchor.constraint(equalToConstant: widthButton),
            startTrackerButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -safeAreaSpacing),
            startTrackerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaSpacing)
        ])
    }
    
    // MARK: - Start / stop button Functions
    
    public func setInStartStateTrackerButton() {
        startTrackerButton.setTitle("Start", for: .normal)
        isStartedTracker = false
    }
    
    private func setInStopStateTrackerButton() {
        startTrackerButton.setTitle("Stop", for: .normal)
        isStartedTracker = true
    }
    
    // MARK: - Delegate Function

    @objc func didPressedShowLastRouteButton() {
        delegate.didPressedShowLastRouteButton()
    }
    
    @objc func didPressedStartTrackerButton() {
        print("1 \(isStartedTracker)")
        if !isStartedTracker {
            setInStopStateTrackerButton()
            print("2 \(isStartedTracker)")
        } else if isStartedTracker {
            setInStartStateTrackerButton()
            print("3 \(isStartedTracker)")
        }
        delegate.didPressedStartTrackerButton()
    }
    
}
