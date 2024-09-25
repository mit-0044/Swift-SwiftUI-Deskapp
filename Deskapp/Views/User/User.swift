//
//  UserList.swift
//  Deskapp
//
//  Created by Mit Patel on 16/09/24.
//

import SwiftUI
import FirebaseAuth
import SideMenu

struct User: View {
    
    @Binding var presentSideMenu: Bool
    @StateObject var userVM = UserViewModel.shared
    
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
                        SearchTextField(placholder: "Search User", txt: $userVM.txtSearch)
                            .padding(.vertical)
                        
                        ScrollView {
                            VStack(spacing: 10){
                                ForEach(userVM.users.filter({ userVM.txtSearch.isEmpty ? true : ($0.name.localizedCaseInsensitiveContains(userVM.txtSearch) ||
                                    $0.email.localizedCaseInsensitiveContains(userVM.txtSearch)) })) { user in
                                    NavigationLink(destination: UserDetails(selectedUser: user)) {
                                        UserRowView(name: user.name, email: user.email )
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .frame(width: .screenWidth * 0.9, height: .screenHeight)
            .ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear() {
                userVM.fetchUserLists()
            }
        }
    }
}

struct User_Previews: PreviewProvider {
    @State static var presentSideMenu = false
    @State static var hideTabBar = false
    static var previews: some View {
        User(presentSideMenu: $presentSideMenu)
    }
}
