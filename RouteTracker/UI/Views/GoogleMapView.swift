//
//  GoogleMapView.swift
//  RouteTracker
//
//  Created by Igor on 29.03.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import GoogleMaps

private let coordinate = CLLocationCoordinate2D(latitude: 55.753795, longitude: 37.621153)

protocol GoogleMapViewDelegate: class {
    func didPressedAddAvatarButton()
}

class GoogleMapView: GMSMapView, GoogleMapViewDelegate  {

    weak var buttonDelegate: GoogleMapViewDelegate!
    private let avatarManager = AvatarMarkerManager()
    private var zoom: Float = 17
    private var zoomNewValue: Float = 17

    private var avatarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "camera"), for: .normal)
        button.setImage(UIImage(named: "camera.highlighted"), for: .highlighted)
        button.addTarget(self, action: #selector(didPressedAddAvatarButton), for: .touchUpInside)
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
            
    //MARK: - Init and configure
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17)
        self.camera = camera
                
        self.isTrafficEnabled = false
        self.mapType = .normal
        
        self.settings.compassButton = true
        self.settings.myLocationButton = true
        addSubviews()
    }
    
    func addSubviews() {
        addSubview(avatarButton)
        addSubview(zoomButton)
        
        let safeAreaSpacing: CGFloat = 10
        
        let heightButton: CGFloat = 60
        let widthButton: CGFloat = heightButton
        
        NSLayoutConstraint.activate([
            avatarButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: safeAreaSpacing),
            avatarButton.heightAnchor.constraint(equalToConstant: heightButton),
            avatarButton.widthAnchor.constraint(equalToConstant: widthButton),
            avatarButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeAreaSpacing),
            zoomButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: safeAreaSpacing),
            zoomButton.heightAnchor.constraint(equalToConstant: heightButton),
            zoomButton.widthAnchor.constraint(equalToConstant: widthButton),
            zoomButton.bottomAnchor.constraint(equalTo: avatarButton.topAnchor, constant: -(3 * safeAreaSpacing))
        ])
    }
    
    //MARK: - Centered Camera
    private func centeredCamera(_ position: CLLocationCoordinate2D) {
        if self.camera.zoom != zoom {
            zoomNewValue = self.camera.zoom
        }
        if zoom != zoomNewValue {
            zoom = zoomNewValue
        }
        let camera = GMSCameraPosition.camera(withTarget: position, zoom: zoom)
        addAvatarMarker(position)
        self.animate(to: camera)
    }
        
    //MARK: - Add marker
    func addMarker(_ position: CLLocationCoordinate2D) {
        centeredCamera(position)
        let marker = GMSMarker(position: position)
        marker.icon = UIImage(named: "flag_icon")
        marker.title = "Now"
        marker.snippet = "Now"
        marker.map = self
    }
    
    func addAvatarMarker(_ position: CLLocationCoordinate2D) {
        self.clear()
        let image = avatarManager.readAvatarFromDisk()
        if let image = image {
            let marker = GMSMarker(position: position)
            marker.icon = image
            marker.title = "Hi!"
            marker.snippet = "I'am here now"
            marker.map = self
        }
    }
    
    public func showStartFinishMarkers(_ path: GMSMutablePath) {
        let count = path.count()
        if count >= 2 {
            let startPosition = path.coordinate(at: 0)
            let countDotsInPath = path.count() - 1
            let finishPosition = path.coordinate(at: countDotsInPath)
            
            let startMarker = GMSMarker(position: startPosition)
            startMarker.icon = UIImage(named: "start")
            startMarker.title = "Start"
            startMarker.snippet = "Track #1"
            startMarker.map = self
            
            let finishMarker = GMSMarker(position: finishPosition)
            finishMarker.icon = UIImage(named: "finish")
            finishMarker.title = "Finish"
            finishMarker.snippet = "Time in way: 1:00"
            finishMarker.map = self
        }
    }
    
    //MARK: - Add marker
    public func drawRoute(_ newPosition: CLLocationCoordinate2D, _ path: GMSMutablePath) {
        centeredCamera(newPosition)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 7
        polyline.geodesic = true
        polyline.map = self
        polyline.strokeColor = .systemRed
    }
    
    //MARK: - Show route path 
    
    public func showLastRoute(_ path: GMSMutablePath) {
        self.clear()
        let bounds = GMSCoordinateBounds(path: path)
        let camera = GMSCameraUpdate.fit(bounds, withPadding: 50)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 7
        polyline.geodesic = true
        polyline.map = self
        polyline.strokeColor = .systemRed
        self.animate(with: camera)
        showStartFinishMarkers(path)
    }
    
    //MARK: - Delegate function

    @objc func didPressedAddAvatarButton() {
        buttonDelegate.didPressedAddAvatarButton()
    }
    
    @objc func didPressedZoomButton() {
        zoomNewValue = 17
    }
}
