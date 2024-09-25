//
//  AccountView.swift
//  Deskapp
//
//  Created by Mit Patel on 16/09/24.
//

import SwiftUI
import SideMenu

struct Profile: View {
    
    @Binding var presentSideMenu: Bool
    @StateObject var profileVM = ProfileViewModel.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack{
                    HStack{
                        Button{
                            presentSideMenu.toggle()
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.primary)
                                .frame(width: .screenWidth * 0.1)
                        }
                        Spacer()
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: .screenWidth * 0.35)
                        Spacer()
                    }
                    .padding(.top, .topInsets)
                    
                    VStack{
                        Text(profileVM.txtProfileImage)
                            .font(.customfont(.arial, fontSize: 75))
                            .foregroundColor(.white)
                            .frame(width: 150, height: 150)
                            .background(.colorInfo)
                            .clipShape(Circle())
                        VStack(){
                            Text(profileVM.txtName)
                                .font(.system(size: 24, weight: .bold))
                            Text(profileVM.txtRole)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.primary.opacity(0.5))
                        }
                    }
                    .padding(.vertical, .screenWidth * 0.025)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        ProfileInfoRow(image: "person.fill", title: profileVM.txtName)
                        ProfileInfoRow(image: "envelope.fill", title: profileVM.txtEmail)
                        ProfileInfoRow(image: "phone.fill", title: profileVM.txtContact)
                        ProfileInfoRow(image: "house.fill", title: profileVM.txtAddress)
                    }
                    .padding(.vertical, .screenWidth * 0.025)
                    
                    Spacer()
                    
                    VStack(){
                        NavigationLink {
                            UpdateProfile()
                        } label: {
                            Text("Edit Profile")
                                .font(.customfont(.bold, fontSize: 22))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                                .background(.colorPrimary)
                                .cornerRadius(20)
                        }
                        NavigationLink {
                            ChangePassword()
                        } label: {
                            Text("Change Password")
                                .font(.customfont(.bold, fontSize: 22))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                                .background(.colorSecondary)
                                .cornerRadius(20)
                        }
                    }
                    .padding(.bottom, .bottomInsets)
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .frame(width: .screenWidth * 0.9, height: .screenHeight)
            .ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                profileVM.getDetails()
            }
        }
    }
}

struct ProfileInfoRow: View {
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
                .foregroundColor(.black)
            Spacer()
        }
        .padding([.leading, .bottom], 5)
    }
}

struct Profile_Previews: PreviewProvider {
    @State static var presentSideMenu = false
    @State static var hideTabBar = false
    static var previews: some View {
        Profile(presentSideMenu: $presentSideMenu)
    }
}
