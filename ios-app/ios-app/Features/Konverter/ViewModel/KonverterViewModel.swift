//
//  KonverterViewModel.swift
//  ios-app
//
//  Created by Koji Osugi on 13/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import Foundation
import shared

internal final class KonverterViewModel: ObservableObject {
    
    @Inject
    private var rateUseCase: RateUseCase
    
    @Inject
    private var currentCurrencyUseCase: CurrentCurrencyUseCase
    
    @Published
    var fromCurrency: CurrencyHolder = .init()
    
    @Published
    var toCurrency: CurrencyHolder = .init()
    
    func setupCurrencyValues() {
        self.fromCurrency = CurrencyHolder(currency: currentCurrencyUseCase.getFromCurrency())
        self.toCurrency = CurrencyHolder(currency: currentCurrencyUseCase.getToCurrency())
    }
    
    func convertValue(value: String) {
        let baseValue = Double(value.replacingOccurrences(of: ",", with: "."))!
        let result = rateUseCase.convertValue(
            baseCurrency: fromCurrency.currency,
            toCurrency: toCurrency.currency,
            value: baseValue
        )
        toCurrency.value = String(result)
    }
    
    func swapCurrency() {
        let oldFromCurrency = fromCurrency
        let oldToCurrency = toCurrency
        fromCurrency.currency = oldToCurrency.currency
        toCurrency.currency = oldFromCurrency.currency
        convertValue(value: fromCurrency.value)
    }
    
    func onSelectedFromCurrency(currency: CurrencyCode) {
        self.fromCurrency.currency = currency
        currentCurrencyUseCase.saveFromCurrency(currencyCode: currency)
    }
    
    func onSelectedToCurrency(currency: CurrencyCode) {
        self.toCurrency.currency = currency
        currentCurrencyUseCase.saveToCurrency(currencyCode: currency)
    }
    
    struct CurrencyHolder {
        var value: String = "0"
        var currency: CurrencyCode = .none
    }
}
