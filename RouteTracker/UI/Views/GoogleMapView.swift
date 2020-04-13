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
//        let zoom = self.camera.zoom
        let camera = GMSCameraPosition.camera(withTarget: position, zoom: 17)
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
    
    public func showRouteTestsPath() {
        let path = GMSMutablePath()
        var latitude: CLLocationDegrees = 55.753795
        var longitude:  CLLocationDegrees = 37.621153

        for _ in 0...20 {
            let randomDouble: Double = Double.random(in: 0.009...3)
            latitude = latitude - randomDouble
            longitude = longitude + randomDouble
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//            addMarker(coordinate)
            path.add(coordinate)
        }
        showLastRoute(path)
    }
}
