//
//  ShieldActionExtension.swift
//  shieldaction
//
//  Created by redstar16 on 2023/04/11.
//

import ManagedSettings
import UIKit
// import WebKit

class ShieldActionExtension: ShieldActionDelegate,NSExtensionRequestHandling {
    var context: NSExtensionContext?
    func beginRequest(with context: NSExtensionContext) {
        print("beginRequest with: \(context)")
        self.context = context
    }

    func backHomeApp(){
        if let context = context,
           let url = URL(string: "screentimeapp://backHomeApp"){
            // "timeout://primary-button"
            context.open(url, completionHandler: nil)
            notification()
        }
    }

    func notification(){
        let notificationName = CFNotificationName("dev.akaboshinit.screentimeapp.info" as CFString)
        let notificationCenter = CFNotificationCenterGetDarwinNotifyCenter()
        CFNotificationCenterPostNotification(notificationCenter, notificationName, nil, nil, true)
    }

    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {

        let store = ManagedSettingsStore()
        switch action {
        case .primaryButtonPressed:
            print("primaryButtonPressed3")
            backHomeApp()
            completionHandler(.close)
        case .secondaryButtonPressed:
            print("secondaryButtonPressed3")
            backHomeApp()
            store.shield.applications?.remove(application)
            completionHandler(.defer)
        @unknown default:
            fatalError()
        }
    }

    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        let store = ManagedSettingsStore()
        switch action {
        case .primaryButtonPressed:
            print("primaryButtonPressed2")
            backHomeApp()
            completionHandler(.close)
        case .secondaryButtonPressed:
            print("secondaryButtonPressed2")
            backHomeApp()
            store.shield.applications?.removeAll()
            completionHandler(.defer)
        @unknown default:
            fatalError()
        }
    }

    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        let store = ManagedSettingsStore()
        switch action {
        case .primaryButtonPressed:
            print("primaryButtonPressed1")
            let task = URLSession.shared.dataTask(with: URL(string: "screentimeapp://backHomeApp")!) { (data, _, error) in
                guard let data = data else { return }
                print(data)
            }
            task.resume()
            backHomeApp()
            completionHandler(.close)
        case .secondaryButtonPressed:
            print("secondaryButtonPressed1")
            store.shield.applications = nil
            let task = URLSession.shared.dataTask(with: URL(string: "https://asia-northeast1-akaboshinit-5cecc.cloudfunctions.net/dogRandom")!) { (data, _, error) in
                guard let data = data else { return }
                print(data)
            }
            task.resume()
            backHomeApp()
            completionHandler(.defer)
            // completionHandler(.defer)
        @unknown default:
            fatalError()
        }
    }
}
