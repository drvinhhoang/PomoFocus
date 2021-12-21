//
//  TimerViewModel.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth


class TimerManager: ObservableObject {
    
    let db = Firestore.firestore()
    
    @AppStorage("setting") private var timerLocalSetting: Data?
    @Published var timerModel = TimerSetting.defaultSetting {
        didSet {
            print(timerModel)
            setBreakTime()
        }
    }
    @Published var isRunning = false
    @Published var section: Int = 0
    @Published var isBreakTime: Bool = false
    @Published var isLongBreak: Bool = false
    @Published var alertItem: AlertItem?
    
    
    @Published var seconds = TimerSetting.defaultSetting.focusTime * 60
    
    private var timer = Timer()
    
    // Store setting data to AppStorage variable
    func saveChanges() {
        let uid = Auth.auth().currentUser?.uid
        
       
        print(timerLocalSetting)
        if let uid = uid {
            do {
                try db.collection("setting").document(uid).setData(from: timerModel, merge: true) { error in
                    self.alertItem = AlertContext.saveSuccessful
                }
            } catch let error {
                print("Error writing setting timer to firestore:\(error)")
            }
        } else {
            saveSettingToLocal()
        }
    }
    
    
    func saveSettingToLocal() {
        let data = try? JSONEncoder().encode(timerModel)
        timerLocalSetting = data
    }
    func retrieveSetting() {
        let uid = Auth.auth().currentUser?.uid
        
        
        
        if let uid = uid {
            
            let storeCloudSetting = db.collection("setting").document(uid)
            
            storeCloudSetting.getDocument {[weak self] (document, error) in
                guard let self = self else { return }
                
                let result = Result {
                    try document?.data(as: TimerSetting.self)
                }
                switch result {
                case .success(let timerSetting):
                    if let timerSetting = timerSetting {

                        self.timerModel = timerSetting
                        
                    }
                case .failure(let error):
                    print("Loading setting error: \(error)")
                }
            }
        } else {
            self.retrieveLocalStoredSetting()

        }
    }
    
    func retrieveLocalStoredSetting() {
        if let timerLocalSetting = self.timerLocalSetting  {
            let tempSettingLocal = try? JSONDecoder().decode(TimerSetting.self, from: timerLocalSetting)
            DispatchQueue.main.async {
                self.timerModel = tempSettingLocal ?? TimerSetting.defaultSetting
            }
        }
    }
    
    
    // Set color for timerView's timer
    func setTimerColor() -> (primary: Color, secondary: Color) {
        if isBreakTime {
            return isLongBreak ? (.green, .green) : (.blue, .blue)
        } else {
            return (.brandPrimary, .secondaryBrand)
        }
    }
    
    
    func startTimer() {
        isRunning.toggle()
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {[self] time in
                seconds -= 1
                if seconds <= 0 {
                    time.invalidate()
                    isRunning = false
                    // when senconds to 0, change to breaking time
                    if !isBreakTime {
                        section += 1
                    }
                    isBreakTime.toggle()
                    setBreakTime()
                }
            }
        } else { // if isRunning == false
            stopTimer()
        }
    }
    
    
    func stopTimer() {
        timer.invalidate()
        isRunning = false
    }
    
    
    func setBreakTime() {
        if isBreakTime {
            if section % 4 == 0 && section > 0 {
                isLongBreak = true
                
            } else {
                isLongBreak = false
            }
            
            if isLongBreak {
                seconds = timerModel.longBreak * 60
            } else {
                seconds = timerModel.shortBreak * 60
            }
            
        } else {
            seconds = timerModel.focusTime * 60
        }
    }
    
    
    
    func setTimeWhenXDismissPressed() {
        stopTimer()
        isBreakTime = false
        setBreakTime()
    }
    
    
    
}
