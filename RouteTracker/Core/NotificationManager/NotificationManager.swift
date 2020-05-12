//
//  NotificationManager.swift
//  RouteTracker
//
//  Created by Igor on 12.05.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import NotificationCenter

class NotificationManager {
    
    init() {
        config()
    }
    
    private func config() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            guard granted else {
                print("Разрешение не получено")
                return
            }
        }
        
    }
    
    func sendNotification() {
        self.sendNotificatioRequest(
            content: self.makeNotificationContent(),
            trigger: self.makeIntervalNotificatioTrigger()
        )
    }
    
    private func makeNotificationContent() -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        let sound: UNNotificationSoundName = UNNotificationSoundName("connected.mp3")
        content.sound = UNNotificationSound(named: sound)
        content.title = "RouteTracker"
        content.subtitle = "Don't forget me!"
        let isStarted = Tracker.shared.isStarted
        print(Tracker.shared.isStarted)
        if isStarted == true {
            content.body = "Come back and complete your track!"
        } else if isStarted == false {
            content.body = "Come back and start your new track!"
        }
        return content
    }
    
    private func makeIntervalNotificatioTrigger() -> UNNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(
            timeInterval: 30,
            repeats: false
        )
    }
    
    private func sendNotificatioRequest(
        content: UNNotificationContent,
        trigger: UNNotificationTrigger) {
        
        let request = UNNotificationRequest(
            identifier: "comeback",
            content: content,
            trigger: trigger
        )
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}



