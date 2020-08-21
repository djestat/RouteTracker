//
//  RealmAdapter.swift
//  RouteTracker
//
//  Created by Igor on 05.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwift
import GoogleMaps

final class RealmAdapter {
    
    private let realm: RealmDataBaseManager = RealmDataBaseManager()
    private let helper: DateFormatterHelper = DateFormatterHelper()
    
    //MARK: - DOTS
    func saveRoutePathDotsPosition(_ time: Int, _ nameRoute: String,_ position: CLLocationCoordinate2D ) {
        let routeDotCoordinate = REALMRouteDotsCoordinates(time: time, ownerName: nameRoute, latitude: position.latitude, longitude: position.longitude)
        realm.save(data: routeDotCoordinate)
    }
    
    func getLastRoute() -> GMSMutablePath {
        let routePath: GMSMutablePath = GMSMutablePath()
        let arrayOfDots = realm.getDotsFromRoute(REALMRouteDotsCoordinates.self)
        if let lastDot = arrayOfDots.last {
            let routeName = lastDot.ownerName
            for dot in arrayOfDots {
                if dot.ownerName == routeName{
                    let coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: dot.latitude, longitude: dot.longitude)
                    routePath.add(coord)
                }
            }
        }
        return routePath
    }
    
    //MARK: - USERS
    
    func searchUserLogin(_ login: String) -> REALMUser {
        let result = realm.getUserByLogin(login).first
        let user: REALMUser = REALMUser(login: result?.login ?? "no user", password: result?.password ?? "no password")
        return user
    }
    
    func saveUserLogin(_ login: String, _ password: String) {
        let user = REALMUser(login: login, password: password)
        realm.save(data: user)
    }
    
}

/*
final class RealmAdapter {
        
    private var realmNotificationTokens: NotificationToken?
    
    // MARK: - Load all routes
    
    func getRoutes(completion: @escaping ([FriendProfile]) -> Void) {
        
        let realmConfig = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: realmConfig)
        let friendList = realm.objects(REALMFriendProfile.self).filter("name != 'DELETED'")
        realmNotificationTokens = friendList.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
           
            case .update(let realmFriends, _, _, _):
                var friends: [FriendProfile] = []
                for friend in realmFriends {
                    friends.append(self.friends(from: friend))
                }
                self.realmNotificationTokens?.invalidate()
                completion(friends)
            case .error(let error):
                print(error.localizedDescription)
            case .initial(let realmFriends):
                var friends: [FriendProfile] = []
                for friend in realmFriends {
                    friends.append(self.friends(from: friend))
                }
                self.realmNotificationTokens?.invalidate()
                completion(friends)
            }
        }
        
        vkapiService.loadFriends { result in
            switch result {
            case .success(let friendList):
                RealmProvider.save(data: friendList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func friends(from realmFriendProfile: REALMFriendProfile) -> FriendProfile {
        return FriendProfile(id: realmFriendProfile.id, name: realmFriendProfile.name, lastname: realmFriendProfile.lastname, avatarGroupImage: realmFriendProfile.avatarGroupImage, avatarImage: realmFriendProfile.avatarImage, online: realmFriendProfile.online)
    }
}
*/
