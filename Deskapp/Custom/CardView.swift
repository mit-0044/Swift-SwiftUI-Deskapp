//
//  InfoCard.swift
//  Deskapp
//
//  Created by Mit Patel on 25/09/24.
//

import SwiftUI

struct CardData: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var icon: String
}

struct CardView: View {
    var title: String
    var subtitle: String
    var icon: String
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 28, weight: .bold))
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.colorPrimary)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
        .frame(height: 100)
    }
}
struct CardView_Previews: PreviewProvider {
    @State static var title = "Title"
    @State static var subtitle = "SubTitle"
    @State static var icon = "person.fill"
    static var previews: some View {
        CardView(title: title, subtitle: subtitle, icon: icon)
    }
}
