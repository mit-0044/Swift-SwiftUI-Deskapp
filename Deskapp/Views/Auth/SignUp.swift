//
//  SignUp.swift
//  Deskapp
//
//  Created by Mit Patel on 02/09/24.
//

import SwiftUI

struct SignUp: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var authVM = AuthViewModel.shared;
    @State static var presentSideMenu = false
    
    var body: some View {
        ZStack{
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .screenWidth * 0.75)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    Text("Sign Up")
                        .font(.customfont(.arial, fontSize: 26))
                        .foregroundColor(.colorPrimary)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    Text("Enter your credentials to continue")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.colorSecondary)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 15)
                    
                    LineTextField( title: "Name", placholder: "Enter your name", txt: $authVM.txtName, keyboardType: .default)
                    
                    LineTextField( title: "Contact", placholder: "Enter your contact", txt: $authVM.txtContact, keyboardType: .numberPad)
                    
                    LineTextField( title: "Email", placholder: "Enter your email address", txt: $authVM.txtEmail, keyboardType: .emailAddress)
                    
                    LineSecureField( title: "Password", placholder: "Enter your password", txt: $authVM.txtPassword, isShowPassword: $authVM.isShowPassword)
                    
                    FilledButton(title: "Create Account") {
                        authVM.signUp()
                    }
                    
                    Button {
                        dismiss()
                    } label: {
                        HStack{
                            Text("Alredy have an account?")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.black)
                            Text("Login")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, .topInsets + 50)
                .padding(.horizontal, 20)
                .padding(.bottom, .bottomInsets)
        }
        .alert(Utilities.AppName, isPresented: $authVM.showError, actions: {
            Button("Okay", role: .cancel) {  }
        }, message: { Text( authVM.errorMessage ) })
        .fullScreenCover(isPresented: $authVM.isAuthenticated) {
            MainTabView()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignUp()
        }
    }
}
