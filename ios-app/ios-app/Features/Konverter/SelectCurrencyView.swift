//
//  SelectCurrencyView.swift
//  ios-app
//
//  Created by Koji Osugi on 14/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

internal struct SelectCurrencyView: View {
    
    @Environment(\.dismiss)
    private var dismiss
    
    @State
    private var searchText: String = ""
    
    var onSelectedCurrency: (CurrencyCode) -> Void = { _ in }
    
    private var currencyCodeList: [CurrencyCode] {
        if searchText.isEmpty {
            return CurrencyCode.Companion().allCurrencies()
        } else {
            return CurrencyCode.Companion().allCurrencies()
                .filter { $0.description_.contains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchTextField()
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 16)
            ScrollView {
                ForEach(currencyCodeList, id: \.name) {
                    CurrencyItem(currencyCode: $0)
                }
            }
        }
        .applyToolbar("Select Currency", dismiss: dismiss)
        .fullScreen()
    }
    
    @ViewBuilder
    private func SearchTextField() -> some View {
        TextField(text: $searchText) {
            Text("Search")
                .foregroundColor(.grayMain)
                .style(.subtitle)
        }
        .textContentType(.countryName)
        .textFieldStyle(DefaultTextFieldStyle())
    }
    
    @ViewBuilder
    private func CurrencyItem(currencyCode: CurrencyCode) -> some View {
        Button(action: {
            onSelectedCurrency(currencyCode)
            dismiss()
        }) {
            HStack {
                currencyCode.image
                    .resizable()
                    .clipShape(Circle())
                    .frame(width:32, height: 32)
                Text(currencyCode.description_)
                    .style(.subtitle)
                    .padding(.leading, 16)
                Spacer()
                Text(currencyCode.name)
                    .foregroundColor(.grayMedium)
                    .style(.subtitle)
            }
            .padding(16)
        }
    }
}

internal struct SelectCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SelectCurrencyView()
        }
    }
}
