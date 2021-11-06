//
//  AccountViewModel.swift
//  LetsFocusPomo
//
//  Created by VINH HOANG on 17/10/2021.
//

import SwiftUI
import Firebase

class AccountViewModel: ObservableObject {
    
  @Published  var isLogin: Bool = false
    var email: String = ""
    var password: String = ""
    var displayEmail: String = ""
    func login(completion: @escaping () -> Void ) {
       
        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion()
                DispatchQueue.main.async {
                   checkIsLogin()

                }
            }
        }
        
    }
    
    func checkIsLogin() {
        if  let currentUser = Auth.auth().currentUser {
            isLogin = true
            displayEmail = currentUser.email!
        }
    }
    
    
    func logout() {
        try? Auth.auth().signOut()
        isLogin = false
       
    }
    
}
