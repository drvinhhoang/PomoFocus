//
//  LetsFocusModel.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import Foundation

struct TimerSetting: Codable {
    
    static let defaultSetting = TimerSetting()
    var focusTime: Int  = 25
    var shortBreak: Int = 5
    var longBreak: Int  = 10
    var currentSection: Int  = 0
    var totalSections: Int   = 10

    
}
//
//struct MocData {
//    static let SampleFocusTimer = TimerModel(focusMinutes: 25, shortBreak: 5, longBreak: 10, currentSection: 9, totalSections: 10)
//
//}
