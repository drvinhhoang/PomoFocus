//
//  LetsFocusModel.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import Foundation

struct TimerModel: Codable {
    
    static var defaultTimeModel = TimerModel(focusMinutes: 25, shortBreak: 5, longBreak: 10, currentSection: 0, totalSections: 10)
    var focusTime: Int {
        didSet {
            seconds = focusTime * 60
        }
    }
    var shortBreak: Int   // in minutes
    var longBreak: Int   // in minutes
    var currentSection: Int
    var totalSections: Int
    var seconds: Int
    
    init(focusMinutes: Int, shortBreak: Int, longBreak: Int, currentSection: Int, totalSections: Int) {
        self.focusTime = focusMinutes
        self.seconds = focusTime * 60
        self.shortBreak = shortBreak
        self.longBreak = longBreak
        self.currentSection = currentSection
        self.totalSections = totalSections
    }
}

struct MocData {
    static let SampleFocusTimer = TimerModel(focusMinutes: 25, shortBreak: 5, longBreak: 10, currentSection: 9, totalSections: 10)
    
}
