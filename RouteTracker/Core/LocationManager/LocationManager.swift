//
//  LocationManager.swift
//  RouteTracker
//
//  Created by Igor on 29.03.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import CoreLocation

class LocationManager {
    var manager: CLLocationManager?

    init() {
        configure()
    }
    
    func configure() {
        manager = CLLocationManager()
        manager?.requestAlwaysAuthorization()
        manager?.allowsBackgroundLocationUpdates = true
        manager?.pausesLocationUpdatesAutomatically = false
        manager?.startMonitoringSignificantLocationChanges()
        manager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        manager?.desiredAccuracy = .leastNormalMagnitude
        manager?.distanceFilter = 5.0
    }

}
