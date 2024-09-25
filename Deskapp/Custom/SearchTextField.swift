//
//  SearchTextField.swift
//  Deskapp
//
//  Created by Mit Patel on 16/09/24.
//

import SwiftUI

struct SearchTextField: View {
   
    @State var placholder: String = "Placholder"
    @Binding var txt: String
    @State private var isEditing = false
    
    var body: some View {
        HStack(spacing: 15) {
            Image("search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
           
            TextField(placholder, text: $txt)
                .font(.customfont(.regular, fontSize: 17))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(height: 30)
        .padding(15)
        .background(Color(hex: "F2F3F2"))
        .cornerRadius(16)
    }
}

struct SearchTextField_Previews: PreviewProvider {
    @State static var txt: String = ""
    static var previews: some View {
        SearchTextField(placholder: "Search Store", txt: $txt)
            .padding(15)
    }
}
