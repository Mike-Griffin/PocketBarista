//
//  OnboardView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 8/2/21.
//

import SwiftUI

struct OnboardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            OnboardInfoView(imageName: "questionmark.circle",
                            title: "Coffee Brew Guidance",
                            description: "Calculate the amount of coffee and water needed to make the best cup of coffee")
            OnboardInfoView(imageName: "pencil.circle",
                            title: "Log Brews",
                            description: "Keep logs of coffee brews to what see ratios and setups are best for you")
            OnboardInfoView(imageName: "star.circle",
                            title: "Track Beans and Roasters",
                            description: "Save the coffee beans you've tried and your favorite roasters")
        }
        .padding(.horizontal, 30)
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView()
    }
}
struct OnboardInfoView: View {
    var imageName: String
    var title: String
    var description: String
    var body: some View {
        HStack(spacing: 26) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)
            VStack(alignment: .leading, spacing: 4) {
                Text(title).bold()
                Text(description)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
            }
        }

    }
}
