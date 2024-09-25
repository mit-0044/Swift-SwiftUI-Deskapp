//
//  Validation.swift
//  Deskapp
//
//  Created by Mit Patel on 02/09/24.
//

import Foundation

extension String {
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    var isValidContact: Bool {
        let TextRegEx = "^[0-9]\\d{9}$"
        let TextTest = NSPredicate(format: "SELF MATCHES %@", TextRegEx)
        return TextTest.evaluate(with: self)
    }
}
