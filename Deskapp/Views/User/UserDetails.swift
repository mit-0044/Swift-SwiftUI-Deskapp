//
//  UserDetails.swift
//  Deskapp
//
//  Created by Mit Patel on 18/09/24.
//

import SwiftUI

struct UserDetails: View {
    
    @StateObject var userVM = UserViewModel.shared
    @Environment(\.dismiss) var dismiss
    var selectedUser: UserModel
    
    var body: some View {
        ZStack {
            VStack {
                HStack(){
                    Button {
                        dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.top, 5)
                    }
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .padding(.top, .screenWidth * 0.025)
                        .frame(height: .screenWidth / 10)
                    Spacer()
                        .frame(width: .screenWidth * 0.283)
                }
                Spacer()
            }
            
            VStack{
                VStack{
                    Text(selectedUser.initials)
                        .font(.customfont(.arial, fontSize: 75))
                        .foregroundColor(.white)
                        .frame(width: 150, height: 150)
                        .background(.colorInfo)
                        .clipShape(Circle())
                        .padding(.leading, 10)
                    VStack{
                        Text(selectedUser.name)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                        Text(selectedUser.role)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary.opacity(0.5))
                    }
                }
                .padding(.vertical, .screenWidth * 0.025)
                
                VStack(alignment: .leading, spacing: 15) {
                    DetailsInfoRow(image: "person.fill", title: selectedUser.name)
                    DetailsInfoRow(image: "envelope.fill", title: selectedUser.email)
                    DetailsInfoRow(image: "phone.fill", title: selectedUser.contact)
                    DetailsInfoRow(image: "house.fill", title: selectedUser.address)
                }
                .padding(.vertical, .screenWidth * 0.025)
                .padding(.bottom)
                
                Spacer()
            }
            .padding(.top, .screenHeight * 0.075)
        }
        .toolbar(.hidden, for: .tabBar)
        .frame(width: .screenWidth * 0.9)
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct DetailsInfoRow: View {
    var image: String
    var title: String
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.colorPrimary)
            Text(title)
            Spacer()
        }
        .padding([.leading, .bottom], 5)
    }
}

struct UserDetails_Previews: PreviewProvider {
    @State static var user = UserModel()
    static var previews: some View {
        UserDetails(selectedUser: user)
    }
}
