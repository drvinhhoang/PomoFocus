//
//  AlertItem.swift
//  Let's Focus
//
//  Created by VINH HOANG on 14/10/2021.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    
    static let saveSuccessful = AlertItem(title: Text("Saved."),
                                              message: Text("Settings have been saved."),
                                              dismissButton: .default(Text("OK")))

    
}
