//
//  BaseCoordinator.swift
//  RouteTracker
//
//  Created by Igor on 14.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import UIKit

class BaseCoordinator {
    var childCoordinators: [BaseCoordinator] = []
    
    func start() {
    }
    
    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard !childCoordinators.isEmpty,
            let coordinator = coordinator else { return }
        
        for (index, element) in childCoordinators.reversed().enumerated()
            where element === coordinator {
                childCoordinators.remove(at: index)
                break
        }
    }
    
    func setAsRoot(_ controller: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = controller
    }
}

