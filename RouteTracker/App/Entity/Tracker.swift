//
//  Tracker.swift
//  RouteTracker
//
//  Created by Igor on 12.05.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation

class Tracker {
    var isStarted: Bool = false
    static let shared: Tracker = Tracker()
    
    private init() {
    }
    
    func setIsStrartedFalse() {
        isStarted = false
    }
    
    func setIsStrartedTrue() {
        isStarted = true
    }
    
}
