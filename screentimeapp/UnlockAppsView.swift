//
//  UnlockAppsView.swift
//  screentimeapp
//
//  Created by redstar16 on 2023/04/11.
//

import FamilyControls
import DeviceActivity
import ManagedSettings
import SwiftUI

class storeData {
    @State var appData: Set<ApplicationToken>?
}

struct UnlockAccess: View {
    
    @State var timerStarted: Bool = false
    var body: some View {
        
        ZStack {
            Color(UIColor.white)
            
            Button("  Unlock Applications  ") {
                
                let store = ManagedSettingsStore()
                let applicationData = store.shield.applications
                
                storeData().appData = applicationData
                
             //   UserDefaults.standard.setValue(applicationData, forKey: "appList")
                store.shield.applications = nil
                
                timerStarted.toggle()
            }.font(.system(size: 35))
                .foregroundColor(.black)
              //  .border(.black, width: 0.5)
                .sheet(isPresented: $timerStarted) {
                    TimerView()
                }

        }.ignoresSafeArea()
    }
}
func secondsToMinutesSeconds(_ seconds: Int) -> ( Int, Int) {
    return ((seconds % 3600) / 60, (seconds % 3600) % 60)
}


struct TimerView: View {
    @State var timeRemaining = 120
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        let time = secondsToMinutesSeconds(timeRemaining)
        
        if timeRemaining > 0 {
        Text("Locking apps in \(time.0):\(time.1)")
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
                else {
                    accessFunc().disable()
                }
            }.font(.system(size: 35))
    }
        else {
            //accessFunc().disable()
            UnlockAccess.init(timerStarted: false)

        }
}
}


struct UnlockAccessView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockAccess()
    }
}

class accessFunc {
    
    func disable() {
        let appsList = storeData().appData
                 let store = ManagedSettingsStore()
                    store.shield.applications = appsList
    }
}
