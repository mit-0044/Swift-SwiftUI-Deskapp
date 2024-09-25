//
//  MainTabView.swift
//  Deskapp
//
//  Created by Mit Patel on 02/09/24.
//

import SwiftUI
import FirebaseAuth
import SideMenu

struct Home: View {
    
    @StateObject var homeVM = HomeViewModel.shared
    @StateObject var authVM = AuthViewModel.shared
    @Binding var presentSideMenu: Bool
    @State private var isAuthenticated = false
    
    var body: some View {
        
        let data = [
            CardData(title: "\(homeVM.countUsers + homeVM.countAdmins)", subtitle: "Total", icon: "person.3.fill"),
            CardData(title: "\(homeVM.countAdmins)", subtitle: "Admins", icon: "person.badge.key.fill"),
            CardData(title: "\(homeVM.countUsers)", subtitle: "Users", icon: "person.fill")
        ]
        let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
        
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
                        Button{
                            authVM.logoutTapped = true
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.primary)
                                .frame(width: .screenWidth * 0.1)
                        }
                    }
                    .padding(.top, .topInsets)
                    
                    if Utilities.UDValue(key: "userRole") as! String == "Admin" {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(data) { item in
                                CardView(title: item.title, subtitle: item.subtitle, icon: item.icon)
                            }
                        }
                        .padding(.top)
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .toolbar(.hidden, for: .tabBar)
            .frame(width: .screenWidth * 0.9, height: .screenHeight)
            .ignoresSafeArea()
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                homeVM.fetchCounts()
                homeVM.fetchUser()
            }
            .alert(isPresented: $authVM.logoutTapped) {
                Alert(
                    title: Text(Utilities.AppName),
                    message: Text( "Are you sure want to logout?" ),
                    primaryButton: .destructive(Text("Logout")){
                        authVM.logout()
                    },
                    secondaryButton: .default(Text("Cancel"))
                )
            }
            .fullScreenCover(isPresented: $authVM.isLoggedOut) {
                Login()
            }
        }
    }
}
struct Home_Previews: PreviewProvider {
    @State static var presentSideMenu = false
    @State static var hideTabBar = false
    static var previews: some View {
        Home(presentSideMenu: $presentSideMenu)
    }
}
