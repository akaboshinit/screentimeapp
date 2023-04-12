//
//  DeviceActivityMonitorExtension.swift
//  devicemonitor
//
//  Created by redstar16 on 2023/04/10.
//

import UIKit
import MobileCoreServices
import ManagedSettings
import DeviceActivity

class DeviceActivityMonitorExtension: DeviceActivityMonitor {
    let store = ManagedSettingsStore()
    override func intervalDidStart(for activity: DeviceActivityName) {
        super.intervalDidStart(for: activity)
        print("interval did start")
        let model = MyModel.shared
        let applications = model.selectionToDiscourage.applicationTokens
        store.shield.applications = applications.isEmpty ? nil : applications
        store.dateAndTime.requireAutomaticDateAndTime = true
    }
    
    override func eventDidReachThreshold(_ event: DeviceActivityEvent.Name, activity: DeviceActivityName) {
        print("eventDidReachThreshold!")
    }

    override func intervalDidEnd(for activity: DeviceActivityName) {
        super.intervalDidEnd(for: activity)
        store.shield.applications = nil
        store.dateAndTime.requireAutomaticDateAndTime = false
    }
}
