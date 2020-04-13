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
    private let deletIfMigration = Realm.Configuration.init(deleteRealmIfMigrationNeeded: true)
    
    //MARK: - Realm Read current routes
    func getCurrentRoute (_ result: REALMRoute.Type) -> Results<REALMRoute> {
        let realm = try! Realm(configuration: deletIfMigration)
        print(realm.configuration.fileURL!)
        print("READING REALM DATA!!! TYPE------>REALMRoute<------")
        return realm.objects(result)
    }
    
    //MARK: - Realm Read all routes
    func getAllRoutes(_ result: REALMRoute.Type) -> Results<REALMRoute> {
        let realm = try! Realm(configuration: deletIfMigration)
        print(realm.configuration.fileURL!)
        print("READING REALM DATA!!! TYPE------>\(REALMRoute.self)<------")
        return realm.objects(result).sorted(byKeyPath: "name", ascending: true)
    }
    
    //MARK: - Realm get dots in routes
    
    func getDotsFromRoute<T: Object>(_ result: T.Type) -> Results<T> {
        let realm = try! Realm(configuration: deletIfMigration)
        print(realm.configuration.fileURL!)
        print("SEARCHING IN REALM DATA!!! TYPE------>\(T.self)<------")
        return realm.objects(result).sorted(byKeyPath: "time", ascending: true)
    }
    
    func getDotsFromRouteByName<T: Object>(_ result: T.Type, _ routeName: String) -> Results<T> {
        let realm = try! Realm(configuration: deletIfMigration)
        print(realm.configuration.fileURL!)
        print("SEARCHING IN REALM DATA!!! TYPE------>\(T.self)<------")
        return realm.objects(result).filter("ownerName CONTAINS[cd] '\(routeName)'")
    }
    
    //MARK: - Realm save
    func save<T: Object>(data: T) {
        let realm = try! Realm(configuration: deletIfMigration)
        try! realm.write {
            realm.add(data, update: .modified)
        }
        print(realm.configuration.fileURL!)
        print("WRITING DATA INTO REALM NOW HERE!! TYPE------>\(T.self)<------")
    }
    
    //MARK: - Realm delete route
    func delet<T: Object>(data: [T], routeID: Int) {
        let realm = try! Realm(configuration: deletIfMigration)
        try! realm.write {
            let deleteData = realm.objects(T.self).filter("id == %i", routeID).first
            realm.delete(deleteData!)
        }
        print(realm.configuration.fileURL!)
        print("DELETE DATA INTO REALM NOW HERE!! TYPE------>\(T.self)<------")
    }
 
}
