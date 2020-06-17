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
    func didPressedStartTrackerButton()
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
    
    private var avatarPhotoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "photo"), for: .normal)
        button.setImage(UIImage(named: "photo.highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(didPressedAddAvatarAlbumButton), for: .touchUpInside)
        return button
    }()
    
    private var startTrackerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "on"), for: .normal)
        button.setImage(UIImage(named: "on.highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(didPressedStartTrackerButton), for: .touchUpInside)
        return button
    }()
    
    private var zoomButton: UIButton = {
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
        configure()
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let backgroundImages = ["background","background2","background3","background4"]
        let randomInt = Int.random(in: 0..<backgroundImages.count)
        let image = backgroundImages[randomInt]
        if let backgroundImage = UIImage(named: image) {
            layer.contents = backgroundImage.cgImage
        }
    }
    
    func addSubviews() {
        addSubview(avatarCameraButton)
        addSubview(avatarPhotoButton)
        addSubview(startTrackerButton)
        addSubview(showLastRouteButton)
        addSubview(zoomButton)

        let safeAreaSpacing: CGFloat = 12
        
        let heightButton: CGFloat = 60
        
        NSLayoutConstraint.activate([
            startTrackerButton.heightAnchor.constraint(equalToConstant: (heightButton * 1.45)),
            startTrackerButton.widthAnchor.constraint(equalToConstant: (heightButton * 1.45)),
            startTrackerButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            startTrackerButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: (safeAreaSpacing * 3.25)),
            avatarCameraButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: safeAreaSpacing),
            avatarCameraButton.heightAnchor.constraint(equalToConstant: heightButton),
            avatarCameraButton.widthAnchor.constraint(equalToConstant: heightButton),
            avatarCameraButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(safeAreaSpacing * 2)),
            avatarPhotoButton.leftAnchor.constraint(equalTo: avatarCameraButton.rightAnchor, constant: safeAreaSpacing),
            avatarPhotoButton.heightAnchor.constraint(equalToConstant: heightButton),
            avatarPhotoButton.widthAnchor.constraint(equalToConstant: heightButton),
            avatarPhotoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaSpacing),
            zoomButton.rightAnchor.constraint(equalTo: showLastRouteButton.leftAnchor, constant: -safeAreaSpacing),
            zoomButton.heightAnchor.constraint(equalToConstant: heightButton),
            zoomButton.widthAnchor.constraint(equalToConstant: heightButton),
            zoomButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaSpacing),
            showLastRouteButton.heightAnchor.constraint(equalToConstant: heightButton),
            showLastRouteButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -safeAreaSpacing),
            showLastRouteButton.widthAnchor.constraint(equalToConstant: heightButton),
            showLastRouteButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -(safeAreaSpacing * 2))
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
    
    @objc func didPressedShowLastRouteButton() {
        delegate.didPressedShowLastRouteButton()
    }
    
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
