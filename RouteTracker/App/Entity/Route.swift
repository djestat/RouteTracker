//
//  Route.swift
//  RouteTracker
//
//  Created by Igor on 05.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation

class Route {
    let id: Int
    let name: String
    let startDate: Date
    let stopDate: Date
    let timeInterval: Date
    let routeDotsCoordinates: [RouteDotsCoordinates]
    
    init(id: Int, name: String, startDate: Date, stopDate: Date, timeInterval: Date,  routeDotsCoordinates: [RouteDotsCoordinates]) {
        self.id = id
        self.name = name
        self.startDate = startDate
        self.stopDate = stopDate
        self.timeInterval = timeInterval
        self.routeDotsCoordinates = routeDotsCoordinates
    }
}

class RouteDotsCoordinates {
    let id: Int
    let ownerid: Int
    let latitude: Double
    let longitude: Double
    
    init(id: Int, ownerid: Int, latitude: Double, longitude: Double) {
        self.id = id
        self.ownerid = ownerid
        self.latitude = latitude
        self.longitude = longitude
    }
}
