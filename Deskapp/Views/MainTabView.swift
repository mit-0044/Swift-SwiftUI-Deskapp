//
//  MainTabView.swift
//  Deskapp
//
//  Created by Mit Patel on 16/09/24.
//

import SwiftUI

struct MainTabView: View {
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    @StateObject var authVM = AuthViewModel.shared;
    
    var body: some View {
        
        ZStack{
            TabView(selection: $selectedSideMenuTab) {
                Home(presentSideMenu: $presentSideMenu)
                    .tag(0)
                User(presentSideMenu: $presentSideMenu)
                    .tag(1)
                Profile(presentSideMenu: $presentSideMenu)
                    .tag(2)
            }
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTabView()
        }
    }
}
