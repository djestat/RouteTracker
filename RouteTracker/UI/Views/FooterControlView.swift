//
//  FooterControlView.swift
//  RouteTracker
//
//  Created by Igor on 14.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import UIKit

protocol FooterControlViewDelegate: class {
    func didPressedShowLastRouteButton()
    func didPressedAddAvatarCameraButton()
    func didPressedAddAvatarAlbumButton()
    func didPressedZoomButton()
}

class FooterControlView: UIView, FooterControlViewDelegate {
    weak var delegate: FooterControlViewDelegate!
    private let avatarManager = AvatarMarkerManager()
    
    private var avatarCameraButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "camera"), for: .normal)
        button.setImage(UIImage(named: "camera.highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(didPressedAddAvatarCameraButton), for: .touchUpInside)
        return button
    }()
    
    public var avatarPhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "photo"), for: .normal)
        button.setImage(UIImage(named: "photo.highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(didPressedAddAvatarAlbumButton), for: .touchUpInside)
        return button
    }()
    
    public var zoomButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "zoom"), for: .normal)
        button.setImage(UIImage(named: "zoom.highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(didPressedZoomButton), for: .touchUpInside)
        return button
    }()
    
    private var showLastRouteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "lastTrack"), for: .normal)
        button.setImage(UIImage(named: "lastTrack.highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(didPressedShowLastRouteButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.backgroundColor = UIColor.FlatColor.Blue.Denim
    }
    
    func addSubviews() {
        addSubview(avatarCameraButton)
        addSubview(avatarPhotoButton)
        addSubview(showLastRouteButton)
        addSubview(zoomButton)

        let safeAreaSpacing: CGFloat = 12
        
        let heightButton: CGFloat = 60
        
        NSLayoutConstraint.activate([
            avatarCameraButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: safeAreaSpacing),
            avatarCameraButton.heightAnchor.constraint(equalToConstant: heightButton),
            avatarCameraButton.widthAnchor.constraint(equalToConstant: heightButton),
            avatarCameraButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(safeAreaSpacing)),
            avatarPhotoButton.leftAnchor.constraint(equalTo: avatarCameraButton.rightAnchor, constant: safeAreaSpacing),
            avatarPhotoButton.heightAnchor.constraint(equalToConstant: heightButton),
            avatarPhotoButton.widthAnchor.constraint(equalToConstant: heightButton),
            avatarPhotoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            zoomButton.rightAnchor.constraint(equalTo: showLastRouteButton.leftAnchor, constant: -safeAreaSpacing),
            zoomButton.heightAnchor.constraint(equalToConstant: heightButton),
            zoomButton.widthAnchor.constraint(equalToConstant: heightButton),
            zoomButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            showLastRouteButton.heightAnchor.constraint(equalToConstant: heightButton),
            showLastRouteButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -safeAreaSpacing),
            showLastRouteButton.widthAnchor.constraint(equalToConstant: heightButton),
            showLastRouteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(safeAreaSpacing))
        ])
    }
    
    // MARK: - Delegate Function
    
    @objc func didPressedShowLastRouteButton() {
        delegate.didPressedShowLastRouteButton()
    }
    
    @objc func didPressedAddAvatarCameraButton() {
        delegate.didPressedAddAvatarCameraButton()
    }
    
    @objc func didPressedAddAvatarAlbumButton() {
        delegate.didPressedAddAvatarAlbumButton()
    }
    
    @objc func didPressedZoomButton() {
        delegate.didPressedZoomButton()
    }
    
}
