//
//  BrewLogDetailView.swift
//  PocketBarista
//
//  Created by Mike Griffin on 8/20/21.
//

import SwiftUI

struct BrewLogDetailView: View {
    var brewLog: PBBrewLog
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 24) {
                if let coffee = brewLog.coffee {
                    Section {
                        VStack {
                            Text("Coffee Bean: \(coffee.name!)")
                            if let roaster = coffee.roaster {
                                Spacer()
                                    .frame(height: 16)
                                Text("Roaster: \(roaster.name!)")
                            }
                        }
                        .font(.title)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    }
                    Spacer()
                        .frame(height: 24)
                }
                Section {
                    HStack {
                        Text("Rating")
                            .fontWeight(.semibold)
                        RatingDisplayView(rating: Int(brewLog.rating))
                    }
                    .padding(.horizontal)
                }
                Section {
                    Text("Ratio used: 1 gram coffee to \(estimateRatio(brewLog.ratio)) grams water")
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                }
                Section {
                    if let date = brewLog.date {
                        Text("Brewed: \(date.toDateTime())")
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                    }
                }
                Section {
                    if let notes = brewLog.notes {
                        VStack(alignment: .leading) {
                            Text("Notes:")
                                .fontWeight(.bold)
                            Text(notes)
                        }
                        // .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                }
                Spacer()
            }
        }
    }
}

func estimateRatio(_ ratio: Float) -> Int {
    var closestVal = 0
    var closestSum: Float = 1000
    for ind in 12 ... 22 {
        let multiplied = ratio * Float(ind)
        if abs(multiplied - 1) < closestSum {
            print(closestVal)
            closestVal = ind
            closestSum = abs(multiplied - 1)
        }
    }
    return closestVal
}
