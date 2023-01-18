//
//  SplashViewModel.swift
//  ios-app
//
//  Created by Koji Osugi on 17/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

internal final class SplashViewModel: ObservableObject {
    
    @Inject
    private var rateUseCase: RateUseCase
    
    @Published
    var redirectToMain: Bool = false
    
    func fetchRates() {
        rateUseCase.fetchRatesIfNeeded { isSuccess, error in
            if (isSuccess?.boolValue == true) {
                self.redirectToMain = true
            }
        }
    }
}
