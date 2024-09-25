//
//  ChangePassword.swift
//  Deskapp
//
//  Created by Mit Patel on 02/09/24.
//

import SwiftUI

struct ChangePassword: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var profileVM = ProfileViewModel.shared;
    
    var body: some View {
        ZStack {
            VStack (alignment: .center){
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
                .background(.white)
                Spacer()
            }
            VStack(spacing: 10){
                Text("Change Password")
                    .font(.customfont(.arial, fontSize: 26))
                    .foregroundColor(.colorPrimary)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("Change your password and keep secure your account")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.colorSecondary)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 15)
                
                LineSecureField(title: "Current Password", placholder: "Enter your current password", txt: $profileVM.txtCurrentPassword, isShowPassword: $profileVM.isShowPassword)
                
                LineSecureField(title: "New Password", placholder: "Enter your new password", txt: $profileVM.txtNewPassword, isShowPassword: $profileVM.isShowPassword)
                
                LineSecureField(title: "Confirm Password", placholder: "Confirm your new password", txt: $profileVM.txtConfirmPassword, isShowPassword: $profileVM.isShowPassword)
                
                Spacer()
                    
                FilledButton(title: "Submit"){
                    profileVM.changePassword()
                }
            }
            .padding(.top, .screenHeight * 0.075)
        }
        .toolbar(.hidden, for: .tabBar)
        .frame(width: .screenWidth * 0.9)
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .alert(Utilities.AppName, isPresented: $profileVM.showError, actions: {
            Button("Okay", role: .cancel) {  }
        }, message: { Text( profileVM.errorMessage ) })
        .alert(Utilities.AppName, isPresented: $profileVM.updatedSuccess, actions: {
            Button("Okay", role: .cancel) { dismiss() }
        }, message: { Text("Your password has been successfully updated!") })
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}
