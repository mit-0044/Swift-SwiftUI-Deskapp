//
//  SideMenuViewModel.swift
//  Deskapp
//
//  Created by Mit Patel on 20/09/24.
//

import SwiftUI

class SideMenuViewModel: ObservableObject {
    
    static var shared: SideMenuViewModel = SideMenuViewModel()
    
    @Published var txtName: String = "No Name"
    @Published var txtRole: String = "No Role"
    @Published var txtEmail: String = "No Email"
    @Published var txtProfileImage: String = "NN"
    @Published var logoutTapped = false

    func getDetails(){
        self.txtName = Utilities.UDValue(key: "userName") as! String
        self.txtRole = Utilities.UDValue(key: "userRole") as! String
        self.txtEmail = Utilities.UDValue(key: "userEmail") as! String
        
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
}
