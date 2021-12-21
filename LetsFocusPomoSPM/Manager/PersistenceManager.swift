//
//  PersistenceManager.swift
//  Let's Focus
//
//  Created by VINH HOANG on 20/12/2021.
//

import SwiftUI

class PersistenceManager {
    static let shared = PersistenceManager()
    
    @AppStorage("setting") private var storedSetting: Data?

    func saveChanges(for timerSetting: TimerSetting, completed: @escaping (AlertItem) -> ()) {
        let data = try? JSONEncoder().encode(timerSetting)
        storedSetting = data
        print("Save data successfully \(storedSetting)")
        completed(AlertContext.saveSuccessful)

    }
    
    func retrieveSetting(completed: @escaping (TimerSetting) -> Void) {
        guard let storedSetting = storedSetting else { return}
        do { let tempTimerSetting = try JSONDecoder().decode(TimerSetting.self, from: storedSetting)
            completed(tempTimerSetting)
            print(tempTimerSetting)

        } catch(let error) {
            print(error.localizedDescription)
        }

    }
}
