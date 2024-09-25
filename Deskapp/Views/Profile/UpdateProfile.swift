//
//  UpdateProfile.swift
//  Deskapp
//
//  Created by Mit Patel on 20/09/24.
//

import SwiftUI

struct UpdateProfile: View {
    
    @StateObject var profileVM = ProfileViewModel.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
        ZStack {
            VStack(alignment: .center){
                HStack(){
                    Button {
                        dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.top, 5)
                    }
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, .screenHeight * 0.01)
                        .frame(height: .screenWidth * 0.1)
                    Spacer()
                        .frame(width: .screenWidth * 0.283)
                }
                
                VStack(spacing: 0){
                    LineTextField(title: "Name", placholder: "Enter your name", txt: $profileVM.txtName, keyboardType: .default)
                    LineTextField(title: "Email", placholder: "Enter your email", txt: $profileVM.txtEmail, keyboardType: .emailAddress)
                        .foregroundColor(.gray)
                        .disabled(true)
                    LineTextField(title: "Contact", placholder: "Enter your contact", txt: $profileVM.txtContact, keyboardType: .numberPad)
                    LineTextField(title: "Address", placholder: "Enter your address", txt: $profileVM.txtAddress, keyboardType: .default)
                    
                    Spacer()
                    
                    FilledButton(title: "Submit"){
                        profileVM.updateProfileServiceCall()
                    }
                }
                Spacer()
            }
            .padding(.top, .topInsets)
        }
        .toolbar(.hidden, for: .tabBar)
        .frame(width: .screenWidth * 0.9, height: .screenHeight)
        .ignoresSafeArea()
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .alert(Utilities.AppName, isPresented: $profileVM.showError, actions: {
            Button("Okay", role: .cancel) {  }
        }, message: { Text( profileVM.errorMessage ) })
        .alert(Utilities.AppName, isPresented: $profileVM.updatedSuccess, actions: {
            Button("Okay") { dismiss() }
        }, message: { Text( "Your details have been updated." ) })
    }
    }
}

#Preview {
    UpdateProfile()
}
