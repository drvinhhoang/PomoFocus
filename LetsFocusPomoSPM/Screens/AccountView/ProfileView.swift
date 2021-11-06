//
//  ProfileView.swift
//  DubDubGrub
//
//  Created by Sean Allen on 5/19/21.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var AccountVM: AccountViewModel
    
    var body: some View {
        
        VStack {
            ZStack {
                NameBackgroundView()
                VStack(spacing: 16) {
                    
                    AvatarView(image: Image("default-avatar"), size: 84)
                        .padding(.leading, 12)
                    Text("Loged in: \(AccountVM.displayEmail)")
                    
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Button {
                    AccountVM.logout()
                } label: {
                    Text("Log out")
                }
                
                
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            //                Button {
            //                    viewModel.profileContext == .create ? viewModel.createProfile() : viewModel.updateProfile()
            //                } label: {
            //                    DDGButton(title: viewModel.profileContext == .create ? "Create Profile" : "Update Profile")
            //                }
            //                .padding(.bottom)
        }
        
        
        .navigationTitle("Profile")
        
        
        
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(AccountVM: AccountViewModel())
        }
    }
}


struct NameBackgroundView: View {
    var body: some View {
        Color(.secondarySystemBackground)
            .frame(height: 130)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

struct EditImage: View {
    var body: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 14, height: 14)
            .foregroundColor(.white)
            .offset(y: 30)
    }
}

struct CharactersRemainView: View {
    
    var currentCount: Int
    
    var body: some View {
        Text("Bio: ")
            .font(.callout)
            .foregroundColor(.secondary)
            +
            Text("\(100 - currentCount)")
            .bold()
            .font(.callout)
            .foregroundColor(currentCount <= 100 ? .brandPrimary : Color(.systemPink))
            +
            Text(" Characters Remain")
            .font(.callout)
            .foregroundColor(.secondary)
    }
}
