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

class GoogleMapView: GMSMapView  {
        
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
    }
    
    //MARK: - Centered Camera
    private func centeredCamera(_ position: CLLocationCoordinate2D) {
        let zoom = self.camera.zoom
        let camera = GMSCameraPosition.camera(withTarget: position, zoom: zoom)
        self.animate(to: camera)
    }
    
    //MARK: - Add marker
    func addMarker(_ position: CLLocationCoordinate2D) {
        centeredCamera(position)
        let marker = GMSMarker(position: position)
        marker.icon = UIImage(named: "flag_icon")
        marker.map = self
    }
    
    //MARK: - Show route path 
    
    func showLastRoutePath(_ path: GMSMutablePath) {
        self.clear()
        let bounds = GMSCoordinateBounds(path: path)
        let camera = GMSCameraUpdate.fit(bounds, withPadding: 50)
        self.animate(with: camera)
    }
    
    func showRouteTestsPath() {
        self.clear()
        let path = GMSMutablePath()
        var latitude: CLLocationDegrees = 55.753795
        var longitude:  CLLocationDegrees = 37.621153

        for _ in 0...20 {
            let randomDouble: Double = Double.random(in: 0.009...3)
            latitude = latitude - randomDouble
            longitude = longitude + randomDouble
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            addMarker(coordinate)
            path.add(coordinate)
        }
        showLastRoutePath(path)
    }
}
