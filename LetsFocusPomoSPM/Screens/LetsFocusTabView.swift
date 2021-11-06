//
//  ContentView.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI


struct LetsFocusTabView: View {
    
    var body: some View {
        TabView() {
            TimerView()
                .tabItem {
                    Image(systemName: "timer")
                }
//            SettingView()
//                .tabItem {
//                    Image(systemName: "gearshape")
//                }
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                }
        }
        .accentColor(Color(.systemPurple))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LetsFocusTabView()
    }
}
