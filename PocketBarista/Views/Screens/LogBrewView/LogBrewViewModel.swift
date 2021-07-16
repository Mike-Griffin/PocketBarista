//
//  LogBrewViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 6/25/21.
//

import Foundation
import Combine

class LogBrewViewModel: ObservableObject {
    @Published var grindSetting: String = ""
    @Published var rating: Int = 0
    @Published var selectedCoffee: PBCoffee?
    @Published var isShowingCoffeePicker        = false
}
