//
//  MyModel.swift
//  screentimeapp
//
//  Created by redstar16 on 2023/04/10.
//
import Foundation
import FamilyControls
import DeviceActivity
import ManagedSettings

class MyModel: ObservableObject {
    static let shared = MyModel()
    let store = ManagedSettingsStore()
    let center = DeviceActivityCenter()
    
    private init() {}
    
    var selectionToDiscourage = FamilyActivitySelection() {
        willSet {
            print ("got here \(newValue)")
            let applications = newValue.applicationTokens
            let categories = newValue.categoryTokens
            let webCategories = newValue.webDomainTokens
            store.shield.applications = applications.isEmpty ? nil : applications
            store.shield.applicationCategories = ShieldSettings.ActivityCategoryPolicy.specific(categories, except: Set())
            store.shield.webDomains = webCategories
        }
    }
    
    func initiateMonitoring() {
        print("Setting schedule...")
        let events: [DeviceActivityEvent.Name: DeviceActivityEvent] = [
            .encouraged: DeviceActivityEvent(
                applications: selectionToDiscourage.applicationTokens,
                threshold: DateComponents(minute: 5)
            )
        ]
        
        do {
            try center.startMonitoring(.daily, during: schedule,events: events)
        }
        catch {
            print ("Could not start monitoring \(error)")
        }
        
//        store.appStore.maximumRating = 200
        print("Setting schedule Complete!")
    }
    
    func stopMonitoring(){
        print("Setting schedule Stop")
        center.stopMonitoring()
        store.clearAllSettings()
    }
}


let schedule = DeviceActivitySchedule(
    intervalStart: DateComponents(hour: 0, minute: 0), intervalEnd: DateComponents(hour: 23, minute: 59), repeats: true, warningTime: nil
)

extension DeviceActivityName {
    static let daily = Self("daily")
}

extension DeviceActivityEvent.Name {
    static let encouraged = Self("encouraged")
}
