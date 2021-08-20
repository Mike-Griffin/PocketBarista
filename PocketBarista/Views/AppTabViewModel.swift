//
//  AppTabViewModel.swift
//  PocketBarista
//
//  Created by Mike Griffin on 8/20/21.
//

import Foundation

final class AppTabViewModel: ObservableObject {
    @Published var isShowingOnboardView = false
    func startupChecks() {
        if !UserDefaultsManager.shared.hasSeenOnboardView() {
            isShowingOnboardView = true
            UserDefaultsManager.shared.setSeenOnboardView()
        }
    }
}
