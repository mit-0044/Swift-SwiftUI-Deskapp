//
//  ProfileViewModel.swift
//  Deskapp
//
//  Created by Mit Patel on 18/09/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    static var shared: ProfileViewModel = ProfileViewModel()
    @StateObject var authVM = AuthViewModel.shared
    
    let db = Firestore.firestore()
    
    @Published var txtName: String = "No Name"
    @Published var txtRole: String = "No Role"
    @Published var txtEmail: String = "No Email"
    @Published var txtContact: String = "No Contact"
    @Published var txtAccountStatus: String = "No AccountStatus"
    @Published var txtAddress: String = "No Address"
    @Published var txtProfileImage: String = ""
    
    @Published var txtCurrentPassword: String = ""
    @Published var updatedSuccess: Bool = false
    @Published var txtNewPassword: String = ""
    @Published var txtConfirmPassword: String = ""
    @Published var isShowPassword: Bool = false
    
    @Published var deleteTapped = false
    @Published var logoutTapped = false
    
    @Published var showError = false
    @Published var errorMessage = ""

    func getDetails(){
        self.logoutTapped = false
        self.txtName = Utilities.UDValue(key: "userName") as! String
        self.txtRole = Utilities.UDValue(key: "userRole") as! String
        self.txtEmail = Utilities.UDValue(key: "userEmail") as! String
        self.txtContact = Utilities.UDValue(key: "userContact") as! String
        self.txtAccountStatus = Utilities.UDValue(key: "userAccountStatus") as! String
        self.txtAddress = Utilities.UDValue(key: "userAddress") as! String
        
        var profileImage: String {
            let formatter = PersonNameComponentsFormatter()
            if let components = formatter.personNameComponents(from: txtName) {
                formatter.style = .abbreviated
                return formatter.string(from:components)
            }
            return ""
        }
        self.txtProfileImage = profileImage
    }
    
    //MARK: Update Profile
    func updateProfileServiceCall(){
        if(txtName.isEmpty) {
            self.showError = true
            self.errorMessage = "Please enter your name."
            return
        }else if(!txtEmail.isValidEmail) {
            self.showError = true
            self.errorMessage = "Please enter valid email."
            return
        }else if(!txtContact.isValidContact) {
            self.showError = true
            self.errorMessage = "Please enter valid contact no. with 10 digits only."
            return
        }else if(txtAddress.isEmpty) {
            self.showError = true
            self.errorMessage = "Please enter your address."
            return
        }else{
            let userUID = Auth.auth().currentUser?.uid
            let doc =  db.collection("users").document(userUID!)
            
            let data = [
                "name": self.txtName,
                "contact": self.txtContact,
                "address": self.txtAddress
            ]
            doc.setData(data, merge: true) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully updated!")
                    self.updateSession()
                    self.updatedSuccess = true
                }
            }
        }
    }
    
    //MARK: Update Session
    func updateSession(){
        let userId = Auth.auth().currentUser?.uid
        db.collection("users").document(userId!).getDocument { snapshot, error in
            if error != nil {
                print("Fetch User Error: \(error!.localizedDescription)")
            } else {
                Utilities.UDSET(data: snapshot?.get("name") as! String, key: "userName")
                Utilities.UDSET(data: snapshot?.get("contact") as! String, key: "userContact")
                Utilities.UDSET(data: snapshot?.get("role") as! String, key: "userRole")
                Utilities.UDSET(data: snapshot?.get("email") as! String, key: "userEmail")
                Utilities.UDSET(data: snapshot?.get("accountStatus") as! String, key: "userAccountStatus")
                Utilities.UDSET(data: snapshot?.get("address") as! String, key: "userAddress")
            }
        }
    }
    
    
    //MARK: Change password
    func changePassword(){
        if(!txtNewPassword.isValidPassword) {
            self.showError = true
            self.errorMessage = "Please enter valid password with minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character."
            return
        }else if(txtConfirmPassword != txtNewPassword) {
            self.showError = true
            self.errorMessage = "Comfirm password does not match."
            return
        }else {
            guard let user = Auth.auth().currentUser else {
                self.showError = true
                self.errorMessage = "No user is signed in."
                return
            }
            let credential = EmailAuthProvider.credential(withEmail: user.email ?? "", password: self.txtCurrentPassword)
            
            user.reauthenticate(with: credential) { result, error in
                if let error = error {
                    // Re-authentication failed, show error
                    self.showError = true
                    self.errorMessage = "Re-authentication failed: \(error.localizedDescription)"
                    return
                }
                
                user.updatePassword(to: self.txtNewPassword) { error in
                    if let error = error {
                        // Password update failed
                        self.showError = true
                        self.errorMessage = "Password change failed: \(error.localizedDescription)"
                        return
                    }
                    
                    self.updatedSuccess = true
                }
            }
        }
    }
}

