//
//  LineTextField.swift
//  Deskapp
//
//  Created by Mit Patel on 02/09/24.
//

import SwiftUI

struct LineTextField: View {
    @State var title: String = "Title"
    @State var placholder: String = "Placholder"
    @Binding var txt: String
    @State var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3){
            Text(title)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.gray)
                .frame(width: .screenWidth * 0.9, alignment: .leading)
            
            TextField(placholder, text: $txt)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(width: .screenWidth * 0.9, alignment: .leading)
            
            Divider()
        }
        .padding(.bottom)
        .frame(maxWidth: .screenWidth * 0.9, minHeight: 0, alignment: .leading)
    }
}

struct LineSecureField: View {
    @State var title: String = "Title"
    @State var placholder: String = "Placholder"
    @Binding var txt: String
    @Binding var isShowPassword: Bool
    
    
    var body: some View {
        VStack(spacing: 3){
            Text(title)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if (isShowPassword) {
                TextField(placholder, text: $txt)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .modifier( ShowButton(isShow: $isShowPassword))
            }else{
                SecureField(placholder, text: $txt)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .modifier( ShowButton(isShow: $isShowPassword))
            }
            Divider()
        }
        .padding(.bottom)
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(limit))
            }
        }
        return self
    }
}

struct LineTextField_Previews: PreviewProvider {
    @State static  var txt: String = ""
    static var previews: some View {
        LineTextField(txt: $txt)
    }
}
struct LineSecureField_Previews: PreviewProvider {
    @State static  var txt: String = ""
    @State static  var isShowPassword: Bool = false
    static var previews: some View {
        LineSecureField(txt: $txt, isShowPassword: $isShowPassword)
    }
}
