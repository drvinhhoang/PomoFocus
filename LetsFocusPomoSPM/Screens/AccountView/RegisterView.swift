//
//  LoginView.swift
//  FungiFinder
//
//  Created by Mohammad Azam on 11/3/20.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    
    @StateObject var RegisterVM = RegisterViewModel()
    @Binding var isPresented: Bool
        
    var body: some View {
        VStack {
            Image("mushroom")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .padding(.bottom, 20)
            
            TextField("Email", text: $RegisterVM.email)
                .padding(.bottom, 20)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            SecureField("Password", text: $RegisterVM.password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            Button("Create account") {
               
                RegisterVM.register {
                    isPresented = false
                }
                
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.top, 30)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
       
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(isPresented: .constant(true))
    }
}
