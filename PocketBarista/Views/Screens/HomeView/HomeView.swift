//
//  HomeView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/27/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
            VStack(alignment: .center, spacing: 44) {
                ZStack {
                    VStack {
                        Text("Pocket")
                        Text("Barista")
                    }
                    .font(Font.custom("Lobster-Regular", size: 64))
//                    Color.brandPrimary
//                        .clipShape(Ellipse())
//                        .padding(.horizontal)
//                        .zIndex(-1)
                }
//                Spacer()
//                    .frame(height: 20)
                Text("Welcome!")
                    .font(.largeTitle)
                Text("Are you ready to brew some coffee?")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 64)
                NavigationLink(destination: BrewQuantityView()) {
                    Text("Brew Coffee")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.brandPrimary)
                        .cornerRadius(15)
                }
                Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
