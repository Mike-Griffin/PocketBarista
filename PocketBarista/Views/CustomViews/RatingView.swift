//
//  RatingView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var body: some View {
        HStack {
            ForEach(0 ..< 5) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .onTapGesture {
                        rating = index + 1
                        print("rating selected??")
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}
