//
//  ViewController.swift
//  screentimeapp
//
//  Created by redstar16 on 2023/04/10.
//

import SwiftUI
import FamilyControls

struct ViewController: View {
    @StateObject var model = MyModel.shared
    @State var isPresented = false
    
    var body: some View {
        Button("Select Apps to Discourage") {
            isPresented = true
        }
        .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
        Button("Start Monitoring") {
            model.initiateMonitoring()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
