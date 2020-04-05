//
//  RealmRoute.swift
//  RouteTracker
//
//  Created by Igor on 05.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import RealmSwift

class REALMRoute: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var startDate: Date = Date()
    @objc dynamic var stopDate: Date? = nil
    @objc dynamic var timeInterval: Date? = nil
    let routeDotsCoordinates = List<REALMRouteDotsCoordinates>()
    
    convenience init(id: Int, name: String, startDate: Date, stopDate: Date?, timeInterval: Date?,  routeDotsCoordinates:[REALMRouteDotsCoordinates] = []) {
        self.init()
        self.id = id
        self.name = name
        self.startDate = startDate
        self.stopDate = stopDate
        self.timeInterval = timeInterval
        self.routeDotsCoordinates.append(objectsIn: routeDotsCoordinates)
    }
        
    override static func primaryKey() -> String? {
        return "id"
    }
}

class REALMRouteDotsCoordinates: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerid: Int = 0
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    let owner = LinkingObjects(fromType: REALMRoute.self, property: "routeDotsCoordinates")
    
    convenience init(id: Int, ownerid: Int, latitude: Double, longitude: Double) {
        self.init()
        self.id = id
        self.ownerid = ownerid
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
