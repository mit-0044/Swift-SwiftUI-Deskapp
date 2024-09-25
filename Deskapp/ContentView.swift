//
//  ContentView.swift
//  Deskapp
//
//  Created by Mit Patel on 30/08/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        if Auth.auth().currentUser != nil {
            MainTabView()
        }else{
            Login()
        }
    }
}

#Preview {
    ContentView()
}
