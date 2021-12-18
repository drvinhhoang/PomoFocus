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


class TimerViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    
    @AppStorage("setting") private var timerLocalSetting: Data?
    @Published var timerModel = TimerModel.defaultTimeModel
    @Published var isRunning = false
    @Published var section: Int = 0
    @Published var isBreakTime: Bool = false
    @Published var isLongBreak: Bool = false
    @Published var alertItem: AlertItem?
    
 
    private var timer = Timer()
  
    // Store setting data to AppStorage variable
    func saveChanges() {
        let uid = Auth.auth().currentUser?.uid
     
        let data = try? JSONEncoder().encode(timerModel)
        timerLocalSetting = data
        guard let uid = uid else {return}
        do {
            try db.collection("setting").document(uid).setData(from: timerModel, merge: true) { error in
                self.alertItem = AlertContext.saveSuccessful
            }
        } catch let error {
            print("Error writing setting timer to firestore:\(error)")
        }
    }
  
    func retrieveSetting() {
        let uid = Auth.auth().currentUser?.uid
        guard let timerLocalSetting = timerLocalSetting else { return }
        
        let tempSettingLocal = try? JSONDecoder().decode(TimerModel.self, from: timerLocalSetting)
        
        if let uid = uid {
            let settingDoc = db.collection("setting").document(uid)
            settingDoc.getDocument { (document, error) in
                let result = Result {
                    try document?.data(as: TimerModel.self)
                }
                switch result {
                case .success(let timerSetting):
                    if let timerSetting = timerSetting {
                        DispatchQueue.main.async {
                            self.timerModel = timerSetting
                        }
                    } else {
                        print("Setting not exist")
                        if let tempSetting = tempSettingLocal  {
                            DispatchQueue.main.async {
                                self.timerModel = tempSetting
                            }
                        }
                    }
                case .failure(let error):
                    print("Loading setting error: \(error)")
                    
                    if let tempSetting = tempSettingLocal  {
                        DispatchQueue.main.async {
                            self.timerModel = tempSetting
                        }
                    }
                }
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
                timerModel.seconds -= 1
                if timerModel.seconds <= 0 {
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
                timerModel.seconds = timerModel.longBreak * 60
            } else {
                timerModel.seconds = timerModel.shortBreak * 60
            }
            
        } else {
            timerModel.seconds = timerModel.focusTime * 60
        }
    }
    
    
    
    func setTimeWhenXDismissPressed() {
        stopTimer()
        isBreakTime = false
        setBreakTime()
    }
    
    
    
}
