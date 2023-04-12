//
//  screentimeappApp.swift
//  screentimeapp
//
//  Created by redstar16 on 2023/04/10.
//

import SwiftUI
import FamilyControls

@main
struct TestScreentimeAPIApp: App {
    init(){
        let noti = "dev.akaboshinit.screentimeapp.info" as CFString
        let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
        
        CFNotificationCenterAddObserver(
            notificationCenter,
            nil,
            { (
                center: CFNotificationCenter?,
                observer: UnsafeMutableRawPointer?,
                name: CFNotificationName?,
                object: UnsafeRawPointer?,
                userInfo: CFDictionary?
            ) in
            print("Notification name: \(String(describing: name))")
        },
            noti,
            nil,
            CFNotificationSuspensionBehavior.deliverImmediately
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
