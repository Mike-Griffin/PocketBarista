//
//  RatingView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import SwiftUI

struct RatingSelectionView: View {
    @Binding var rating: Int
    var body: some View {
        HStack {
            ForEach(0 ..< 5) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .onTapGesture {
                        playHaptic()
                        rating = index + 1
                    }
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingSelectionView(rating: .constant(3))
    }
}
