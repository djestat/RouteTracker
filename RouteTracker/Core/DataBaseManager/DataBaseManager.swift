//
//  DataBaseManager.swift
//  RouteTracker
//
//  Created by Igor on 05.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDataBaseManager {
    static let deletIfMigration = Realm.Configuration.init(deleteRealmIfMigrationNeeded: true)
    
    //MARK: - Realm Read current routes
    static func getCurrentRoute<T: Object>(_ result: T.Type) -> Results<T> {
        let realm = try! Realm(configuration: deletIfMigration)
        print(realm.configuration.fileURL!)
        print("READING REALM DATA!!! TYPE------>\(T.self)<------")
        return realm.objects(result)
    }
    
    //MARK: - Realm Read all routes
    static func getAllRoutes<T: Object>(_ result: T.Type) -> Results<T> {
        let realm = try! Realm(configuration: deletIfMigration)
        print(realm.configuration.fileURL!)
        print("READING REALM DATA!!! TYPE------>\(T.self)<------")
        return realm.objects(result)
    }
    
    //MARK: - Realm get dots in routes
    static func getDotsInRoutes<T: Object>(_ result: T.Type, _ searchingText: String) -> Results<T> {
        let realm = try! Realm(configuration: deletIfMigration)
        print(realm.configuration.fileURL!)
        print("SEARCHING IN REALM DATA!!! TYPE------>\(T.self)<------")
        return realm.objects(result).filter("name CONTAINS[cd] '\(searchingText)'")
    }
    
    //MARK: - Realm save
    static func save<T: Object>(data: [T]) {
        let realm = try! Realm(configuration: deletIfMigration)
        try! realm.write {
            realm.add(data, update: .modified)
        }
        print(realm.configuration.fileURL!)
        print("WRITING DATA INTO REALM NOW HERE!! TYPE------>\(T.self)<------")
    }
    
    //MARK: - Realm delete route
    static func delet<T: Object>(data: [T], routeID: Int) {
        let realm = try! Realm(configuration: deletIfMigration)
        try! realm.write {
            let deleteData = realm.objects(T.self).filter("id == %i", routeID).first
            realm.delete(deleteData!)
        }
        print(realm.configuration.fileURL!)
        print("DELETE DATA INTO REALM NOW HERE!! TYPE------>\(T.self)<------")
    }
 
}
