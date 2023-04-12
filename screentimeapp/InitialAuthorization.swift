//
//  InitialAuthorization.swift
//  screentimeapp
//
//  Created by redstar16 on 2023/04/10.
//

import SwiftUI
import FamilyControls

struct InitialAuthorization: App {

    let center = AuthorizationCenter.shared

    var body: some Scene {

        WindowGroup {

            VStack{}.onAppear{

                Task {

                    do {

                        try await center.requestAuthorization(for: .individual)

                    }

                    catch {

                        print("failed to enroll \(error)")

                    }

                }

            }

        }

    }

}
