//
//  RatingDisplayView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 7/27/21.
//

import SwiftUI

struct RatingDisplayView: View {
    var rating: Int
    var body: some View {
        HStack {
            ForEach(0 ..< 5) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
            }
        }
    }
}

struct RatingDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        RatingDisplayView(rating: 2)
    }
}
