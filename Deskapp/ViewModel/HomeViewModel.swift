//
//  HomeViewModel.swift
//  Deskapp
//
//  Created by Mit Patel on 16/09/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class HomeViewModel: ObservableObject
{
    static var shared: HomeViewModel = HomeViewModel()
    let db = Firestore.firestore()
    
    @Published var selectTab: Int = 0
    @Published var countUsers: Int = 0
    @Published var countAdmins: Int = 0
    @Published var txtSearch: String = ""
    
    @Published var showError = false
    @Published var errorMessage = ""
    
    //MARK: Home()
    func fetchUser(){
        let user = Auth.auth().currentUser
        guard let id = user?.uid else { return }
        db.collection("users").document(id).getDocument { snapshot, error in
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
    
    // Fetch users with "user" role
    func fetchCounts() {
        db.collection("users")
        .whereField("role", isEqualTo: "User")
        .getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting user documents: \(error)")
            } else {
                self.countUsers = querySnapshot?.documents.count ?? 0
            }
        }
        
        // Fetch users with "admin" role
        db.collection("users")
        .whereField("role", isEqualTo: "Admin")
        .getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting admin documents: \(error)")
            } else {
                self.countAdmins = querySnapshot?.documents.count ?? 0
            }
        }
    }
}
