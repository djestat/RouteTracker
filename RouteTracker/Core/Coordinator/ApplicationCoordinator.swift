//
//  ApplicationCoordinator.swift
//  RouteTracker
//
//  Created by Igor on 14.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation
import UIKit

final class ApplicationCoordinator: BaseCoordinator {
    
    override func start() {
        if UserDefaults.standard.bool(forKey: "isLogin") {
            toMap()
        } else {
            toAuth()
        }
    }
    
    private func toMap() {// Создаём координатор главного сценария
        let coordinator = MapCoordinator()
        // Устанавливаем ему поведение на завершение
        // Так как подсценарий завершился, держать его в памяти больше не нужно
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
        self?.removeDependency(coordinator)
        // Заново запустим главный координатор, чтобы выбрать следующий сценарий
        self?.start()
        }
        // Сохраним ссылку на дочерний координатор, чтобы он не выгружался из памяти
        addDependency(coordinator)
        // Запустим сценарий дочернего координатора
        coordinator.start()
    }
    
    private func toAuth() {
        // Создаём координатор сценария авторизации
        let coordinator = AuthCoordinator()
        // Устанавливаем ему поведение на завершение
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            // Так как подсценарий завершился, держать его в памяти больше не нужно
            self?.removeDependency(coordinator)
            // Заново запустим главный координатор, чтобы выбрать выбрать следующий
            // сценарий
            self?.start()
        }
        // Сохраним ссылку на дочерний координатор, чтобы он не выгружался из памяти
        addDependency(coordinator)
        // Запустим сценарий дочернего координатора
        coordinator.start()
    }
}

final class AuthCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showLoginModule()
    }
    
    private func showLoginModule() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(LoginViewController.self)
        
        controller.onMap = { [weak self] in
            self?.onFinishFlow?()
        }
        
        controller.onRegistration = { [weak self] in
            self?.showRegistrationModule()
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        rootController.isNavigationBarHidden = true
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
    private func showRegistrationModule() {
        let coordinator = RegistrationCoordinator()
        coordinator.onFinishFlow = { [weak self, weak coordinator] in
            self?.removeDependency(coordinator)
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }

//    private func showMapModule() {
//        let coordinator = MapCoordinator()
//        coordinator.onFinishFlow = { [weak self, weak coordinator] in
//            self?.removeDependency(coordinator)
//            self?.start()
//        }
//        addDependency(coordinator)
//        coordinator.start()
//    }
}

final class RegistrationCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showRegistrationModule()
    }
    
    private func showRegistrationModule() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(RegistrationViewController.self)

        controller.onLogin = { [weak self] in
            self?.onFinishFlow?()
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        rootController.isNavigationBarHidden = true
        setAsRoot(rootController)
        self.rootController = rootController
    }
    
//    private func showLoginModule() {
//        let coordinator = AuthCoordinator()
//        coordinator.onFinishFlow = { [weak self, weak coordinator] in
//            self?.removeDependency(coordinator)
//            self?.start()
//        }
//        addDependency(coordinator)
//        coordinator.start()
//    }
}

final class MapCoordinator: BaseCoordinator {
    
    var rootController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMapModule()
    }
    
    private func showMapModule() {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(GoogleMapViewController.self)

        controller.onLogin = { [weak self] in
            self?.onFinishFlow?()
        }
        
        let rootController = UINavigationController(rootViewController: controller)
        rootController.isNavigationBarHidden = true
        setAsRoot(rootController)
        self.rootController = rootController
    }
//
//    private func showLoginModule() {
//        let coordinator = AuthCoordinator()
//        coordinator.onFinishFlow = { [weak self, weak coordinator] in
//            self?.removeDependency(coordinator)
//            self?.start()
//        }
//        addDependency(coordinator)
//        coordinator.start()
//    }
}
