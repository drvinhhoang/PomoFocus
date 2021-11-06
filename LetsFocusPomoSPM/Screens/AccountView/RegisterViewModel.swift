//
//  RegisterViewModel.swift
//  LetsFocusPomo
//
//  Created by VINH HOANG on 17/10/2021.
//


import SwiftUI
import Firebase

class RegisterViewModel: ObservableObject {
    
    var email: String = ""
    var password: String = ""
    
    func register(completion: @escaping () -> Void ) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion()
            }
        }
    }
    
}

