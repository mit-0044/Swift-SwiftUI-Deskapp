//
//  AuthViewModel.swift
//  Deskapp
//
//  Created by Mit Patel on 02/09/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFunctions

class AuthViewModel: ObservableObject {
    
    static var shared: AuthViewModel = AuthViewModel()
    var authUser: FirebaseAuth.User?
    
    let db = Firestore.firestore()
    
    @Published var txtName: String = ""
    @Published var txtEmail: String = ""
    @Published var txtContact: String = ""
    @Published var txtPassword: String = ""
    @Published var isShowPassword: Bool = false
    
    @Published var isAuthenticated = false
    @Published var logoutTapped = false
    @Published var isLoggedOut = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    init(){
        #if DEBUG
        txtEmail = "admin@admin.com"
        txtPassword = "Admin@123"
        #endif
    }
    
    //MARK: Login ServiceCall
    func login() {
        if(!txtEmail.isValidEmail) {
            self.errorMessage = "Please enter valid email address."
            self.showError = true
            return
        }else if(!txtPassword.isValidPassword) {
            self.errorMessage = "Please enter valid password with at least 8 characters, one uppercase, one lowercase, one number and one special character."
            self.showError = true
            return
        }else{
            Auth.auth().signIn( withEmail: txtEmail, password: txtPassword ){ result, error  in
                if let x = error {
                    let err = x as NSError
                        switch err.code {
                        case AuthErrorCode.invalidCredential.rawValue:
                            self.showError = true
                            self.errorMessage = "Invalid credentials or account not found."
                        case AuthErrorCode.userDisabled.rawValue:
                            self.showError = true
                            self.errorMessage = "Your account has been disabled by an administrator."
                        default:
                            self.showError = true
                            self.errorMessage = "Unknown error: \(err.localizedDescription)"
                    }
                } else {
                    print("User logged in successfully.")
                    Utilities.UDSET(data: true, key: "isLoggedIn")
                    self.authUser = Auth.auth().currentUser
                    self.isLoggedOut = false
                    self.isAuthenticated = true
                }
            }
        }
    }
    
    //MARK: SignUp ServiceCall
    func signUp(){
        if(txtName.isEmpty) {
            self.showError = true
            self.errorMessage = "Please enter your name."
            return
        }else if(!txtContact.isValidContact) {
            self.showError = true
            self.errorMessage = "Please enter valid contact with 10 digits only."
            return
        }else if(!txtEmail.isValidEmail) {
            self.showError = true
            self.errorMessage = "Please enter valid email address."
            return
        }else if(!txtPassword.isValidPassword) {
            self.showError = true
            self.errorMessage = "Please enter valid password with minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character."
            return
        }else{
            Auth.auth().createUser(withEmail: txtEmail, password: txtPassword) { authResult, error in
                if error != nil {
                    let err = error! as NSError
                    switch err.code {
                    case AuthErrorCode.emailAlreadyInUse.rawValue:
                        self.showError = true
                        self.errorMessage = "Email already exists."
                    default:
                        self.showError = true
                        self.errorMessage = "Unknown error: \(err.localizedDescription)"
                    }
                }
                else {
                    self.authUser = authResult?.user
                    let userUID = authResult?.user.uid
                    let data = [
                        "id": userUID!,
                        "role": "User",
                        "name": self.txtName,
                        "accountStatus": "Active",
                        "email": self.txtEmail,
                        "contact": self.txtContact,
                        "address": "",
                        "profileImage": ""
                    ]
                    Firestore.firestore().collection("users").document(userUID!).setData(data as [String : Any]) { error in
                        if error != nil {
                            let err = error! as NSError
                            switch err.code {
                            case AuthErrorCode.invalidEmail.rawValue:
                                self.showError = true
                                self.errorMessage = "Invalid email."
                            case AuthErrorCode.accountExistsWithDifferentCredential.rawValue:
                                self.showError = true
                                self.errorMessage = "Email already exists."
                            default:
                              print("Unknown error: \(err.localizedDescription)")
                            }
                        }
                        else {
                            print("User Registered.")
                            Utilities.UDSET(data: true, key: "isLoggedIn")
                            self.authUser = Auth.auth().currentUser
                            self.isLoggedOut = false
                            self.isAuthenticated = true
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Logout user
    func logout(){
        do {
            try Auth.auth().signOut()
            print("User logged out.")
            self.authUser = nil
            self.isAuthenticated = false
            self.isLoggedOut = true
        } catch let signOutError as NSError {
            self.showError = true
            self.errorMessage = signOutError.localizedDescription
        }
    }
    
}
