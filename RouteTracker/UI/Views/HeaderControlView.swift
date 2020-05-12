//
//  HeaderControlView.swift
//  RouteTracker
//
//  Created by Igor on 29.03.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit

protocol HeaderControlViewDelegate: class {
    func didPressedLogoutButton()
    func didPressedShowLastRouteButton()
    func didPressedStartTrackerButton()
}

class HeaderControlView: UIView, HeaderControlViewDelegate {
    weak var delegate: HeaderControlViewDelegate!

    private var logoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "logout"), for: .normal)
        button.setImage(UIImage(named: "logout.highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(didPressedLogoutButton), for: .touchUpInside)
        return button
    }()
    
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
        addSubview(logoutButton)
        addSubview(showLastRouteButton)
        addSubview(startTrackerButton)
        
        let safeAreaSpacing: CGFloat = 12
        
        let heightButton: CGFloat = 40
        let widthButton: CGFloat = 80
        
        NSLayoutConstraint.activate([
            logoutButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: safeAreaSpacing),
            logoutButton.heightAnchor.constraint(equalToConstant: heightButton),
            logoutButton.widthAnchor.constraint(equalToConstant: heightButton),
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaSpacing),
            showLastRouteButton.leftAnchor.constraint(equalTo: logoutButton.rightAnchor, constant: safeAreaSpacing),
            showLastRouteButton.heightAnchor.constraint(equalToConstant: heightButton),
            showLastRouteButton.rightAnchor.constraint(equalTo: startTrackerButton.leftAnchor, constant: -safeAreaSpacing),
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
        Tracker.shared.setIsStrartedFalse()
    }
    
    private func setInStopStateTrackerButton() {
        startTrackerButton.setTitle("Stop", for: .normal)
        Tracker.shared.setIsStrartedTrue()
    }
    
    // MARK: - Delegate Function
    @objc func didPressedLogoutButton() {
        delegate.didPressedLogoutButton()
    }
    
    @objc func didPressedShowLastRouteButton() {
        delegate.didPressedShowLastRouteButton()
    }
    
    @objc func didPressedStartTrackerButton() {
        print("1 \(Tracker.shared.isStarted)")
        if !Tracker.shared.isStarted {
            setInStopStateTrackerButton()
            print("2 \(Tracker.shared.isStarted)")
        } else if Tracker.shared.isStarted {
            setInStartStateTrackerButton()
            print("3 \(Tracker.shared.isStarted)")
        }
        delegate.didPressedStartTrackerButton()
    }
    
}
