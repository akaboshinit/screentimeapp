//
//  ContentView.swift
//  screentimeapp
//
//  Created by redstar16 on 2023/04/10.
//
import SwiftUI
import FamilyControls
import ScreenTime
import UserNotifications

struct ContentView: View {
    @StateObject var model = MyModel.shared
    @State var isPresented = false

    var body: some View {
        Button("requestAuthorization") {
            Task {
                do {
                    try await AuthorizationCenter.shared.requestAuthorization(for: .individual);
                }catch{
                    print("await error for screentime is \(error)")
                }

                _ = AuthorizationCenter.shared.$authorizationStatus
                    .sink() {_ in
                        switch AuthorizationCenter.shared.authorizationStatus {
                        case .notDetermined:
                            print("not determined")
                        case .denied:
                            print("denied")
                        case .approved:
                            print("approved")
                        @unknown default:
                            break
                        }
                    }
            }
        }
        Button("Select Apps to Discourage") {
            isPresented = true
        }
        .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
        Button("Start Monitoring") {
            model.initiateMonitoring()
        }
        Button("Stop Monitoring") {
            model.stopMonitoring()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
