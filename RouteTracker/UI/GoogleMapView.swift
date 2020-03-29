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

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addMarker(coordinate)
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
    
    func addMarker(_ position: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: position)
        marker.map = self
    }
}
