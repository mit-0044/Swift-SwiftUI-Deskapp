//
//  UserModel.swift
//  Deskapp
//
//  Created by Mit Patel on 02/09/24.
//

import SwiftUI

struct UserModel: Identifiable, Equatable, Codable {
    var id: String = ""
    var role: String = ""
    var name: String = ""
    var accountStatus: String = ""
    var email: String = ""
    var contact: String = ""
    var address: String = ""
    var profileImage: String = ""
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: name) {
            formatter.style = .abbreviated
            return formatter.string(from:components)
        }
        return ""
    }
}

extension UserModel {
    static var MOCK_USER = UserModel(
        id: NSUUID().uuidString,
        role: "User",
        name: "Mock User",
        accountStatus: "Active",
        email: "test@gmail.com",
        contact: "1234567980",
        address: "Address",
        profileImage: "Image"
    )
}
