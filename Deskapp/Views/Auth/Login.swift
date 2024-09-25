//
//  Login.swift
//  Deskapp
//
//  Created by Mit Patel on 31/08/24.
//

import SwiftUI

struct Login: View {
    
    @StateObject var authVM = AuthViewModel.shared;
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("bottom_bg")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .screenWidth, height: .screenHeight)
                    .ignoresSafeArea()
                
                VStack{
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .screenWidth * 0.75)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    Text("Login")
                        .font(.customfont(.arial, fontSize: 26))
                        .foregroundColor(.colorPrimary)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    Text("Enter your email and password")
                        .font(.customfont(.semibold, fontSize: 16))
                        .foregroundColor(.colorSecondary)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 15)
                    
                    LineTextField( title: "Email", placholder: "Enter your email address", txt: $authVM.txtEmail, keyboardType: .emailAddress)
                    
                    LineSecureField( title: "Password", placholder: "Enter your password", txt: $authVM.txtPassword, isShowPassword: $authVM.isShowPassword)
                    
                    FilledButton(title: "Login") {
                        authVM.login()
                    }
                    
                    NavigationLink {
                        SignUp()
                    } label: {
                        HStack{
                            Text("Don’t have an account?")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.black)
                            
                            Text("SignUp")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Spacer()
                    
                }
                .padding(.top, .topInsets + 50)
                .padding(.bottom, .bottomInsets)
                .frame(width: .screenWidth * 0.9)
            }
            .fullScreenCover(isPresented: $authVM.isAuthenticated) {
                MainTabView()
            }
            .alert(Utilities.AppName, isPresented: $authVM.showError, actions: {
                Button("Okay", role: .cancel) {  }
            }, message: { Text( authVM.errorMessage ) })
            .ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

