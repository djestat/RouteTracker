//
//  LocationManager.swift
//  RouteTracker
//
//  Created by Igor on 29.03.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import CoreLocation
import RxCocoa

final class LocationManager: NSObject {
    static let instance = LocationManager()
    
    let locationManager = CLLocationManager()
    var location: BehaviorRelay<CLLocation?> = BehaviorRelay(value: nil)
    
    override init() {
        super.init()
        configure()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func configure() {
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.startMonitoringSignificantLocationChanges()
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.desiredAccuracy = .greatestFiniteMagnitude
//        locationManager.desiredAccuracy = .leastNormalMagnitude
//        locationManager.distanceFilter = 15.0
        locationManager.requestAlwaysAuthorization()
    }

}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location.accept(locations.last)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
