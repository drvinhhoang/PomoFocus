//
//  LetsFocusPomoSPMApp.swift
//  LetsFocusPomoSPM
//
//  Created by VINH HOANG on 26/10/2021.
//

import SwiftUI
import Firebase

@main
struct LetsFocusPomoSPMApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            LetsFocusTabView().environmentObject(TimerViewModel())
        }
    }
}
