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
    
    let gestureRecognizer = UITapGestureRecognizer()

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
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    //MARK: -
    private func centeredCamera(_ position: CLLocationCoordinate2D) {
        let zoom = self.camera.zoom
        let camera = GMSCameraPosition.camera(withTarget: position, zoom: zoom)
     
        self.animate(to: camera)
        
        switch gestureRecognizer.state {
        case .began:
            print("began")
        case .cancelled:
            print("cancelled")
        case .changed:
            print("changed")
        case .ended:
            print("ended")
        case .failed:
            print("failed")
        case .possible:
            print("possible")
        case .recognized:
            print("recognized")
        default:
            print("default")
        }
    }
    
    //MARK: -
    func addMarker(_ position: CLLocationCoordinate2D) {
        centeredCamera(position)
        let marker = GMSMarker(position: position)
        marker.map = self
    }
}
