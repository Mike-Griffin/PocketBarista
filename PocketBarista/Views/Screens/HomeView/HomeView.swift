//
//  HomeView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/27/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
            Spacer()
            Text("Are you ready to brew some coffee?")
            Spacer()
            NavigationLink(destination: BrewQuantityView()) {
                Text("Brew Coffee")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.brandPrimary)
                    .cornerRadius(15)
            }
        }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
