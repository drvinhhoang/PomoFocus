//
//  AccountView.swift
//  Let's Focus
//
//  Created by VINH HOANG on 12/10/2021.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var ACViewModel = AccountViewModel()
    
    @State var isPresented: Bool = false
    @State var isActive: Bool = false
    @State var isSignIn: Bool = false
    
    var body: some View {
        VStack {
            if ACViewModel.isLogin {
                ProfileView(AccountVM: ACViewModel)
            } else {
                MainAccountView(isPresented: $isPresented, viewModel: ACViewModel)
                    .sheet(isPresented: $isPresented, content: {
                        RegisterView(isPresented: $isPresented)
                    })
                    .navigationTitle("Fungi Finder")
            }
        }
        .onAppear {
            ACViewModel.checkIsLogin()
        }
      
        
        
       
    }
    
    
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}


struct MainAccountView: View {
    @Binding var isPresented: Bool
   @ObservedObject var viewModel: AccountViewModel
    var body: some View {
        VStack {
            Image("mushroom")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .padding(.bottom, 20)
            
            TextField("Username", text: $viewModel.email)
                .padding(.bottom, 20)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            
            SecureField("Password", text: $viewModel.password)
                .disableAutocorrection(true)
                .autocapitalization(.none)
               
            Spacer()
            
            Button("Login") {
                viewModel.login {
                    print("Login successful!")
                    
                    
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .padding(.bottom, 10)
            
            Button("Create account") {
                isPresented = true
            }.buttonStyle(SecondaryButtonStyle())
           
            Spacer()
           
            
        }
        .padding()
       

    }
}
