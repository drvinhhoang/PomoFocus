//
//  SettingView.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI

struct SettingView: View {  
    @ObservedObject var timerViewmodel: TimerViewModel
    
    var focusTime = 1...50
    var shortBreak = [5, 10, 15, 20, 25, 30]
    var longBreak = [ 5, 10, 15, 20, 25, 30]
    var sections = 1...20
    
    @Binding var isPresentedSettingView: Bool
    
    
    var body: some View {
    
        NavigationView {
            VStack {
                Form {
                    Picker("Focus time", selection: $timerViewmodel.timerModel.focusTime) {
                        ForEach(focusTime, id: \.self) {
                            Text(String($0))
                        }
                    }
                    Picker("Short break", selection: $timerViewmodel.timerModel.shortBreak) {
                        ForEach(shortBreak, id: \.self) {
                            Text(String($0))
                        }
                    }
                    Picker("Long break", selection: $timerViewmodel.timerModel.longBreak) {
                        ForEach(longBreak, id: \.self) {
                            Text(String($0))
                        }
                    }
                    Section(header: Text("Intervals")) {
                        Picker("Intervals", selection: $timerViewmodel.timerModel.totalSections) {
                            ForEach(sections, id: \.self) {
                                Text(String($0))
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                .background(Color.backgroundLightColor)
 
            }
            .navigationTitle("Setting")
            .navigationBarItems(trailing: Button {
                timerViewmodel.saveChanges()
                isPresentedSettingView = false
                
            } label: {
                Text("Save")
                    .foregroundColor(.red)            }
            )
            
        }
    }
    
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView()
//    }
//}
