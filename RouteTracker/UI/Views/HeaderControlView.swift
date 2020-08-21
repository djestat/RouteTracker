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
    
    private var routeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.FlatColor.Blue.Denim
        label.text = "Route Tracker"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
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
        addSubview(routeLabel)
        
        let safeAreaSpacing: CGFloat = 12
        
        let heightButton: CGFloat = 40
        let widthButton: CGFloat = 120
        
        NSLayoutConstraint.activate([
            logoutButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: safeAreaSpacing),
            logoutButton.heightAnchor.constraint(equalToConstant: heightButton),
            logoutButton.widthAnchor.constraint(equalToConstant: heightButton),
            logoutButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaSpacing),
            routeLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            routeLabel.heightAnchor.constraint(equalToConstant: heightButton),
            routeLabel.widthAnchor.constraint(equalToConstant: widthButton * 2),
            routeLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaSpacing)
        ])
    }
    
    // MARK: - Delegate Function
    @objc func didPressedLogoutButton() {
        delegate.didPressedLogoutButton()
    }
}
