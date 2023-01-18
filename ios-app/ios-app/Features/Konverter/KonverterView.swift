//
//  KonverterView.swift
//  ios-app
//
//  Created by Koji Osugi on 12/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct KonverterView: View {
    
    @ObservedObject
    private var viewModel: KonverterViewModel
    
    @State
    private var showSelectedFromCurrency: Bool = false
    
    @State
    private var showSelectedToCurrency: Bool = false
    
    init(viewModel: KonverterViewModel = .init()) {
        self.viewModel = viewModel
        viewModel.setupCurrencyValues()
    }
    
    var body: some View {
        VStack {
            FromCurrency().padding(.top, 24)
            SwapSection()
            ToCurrency()
            NumPad(string: $viewModel.fromCurrency.value)
                .padding(.vertical, 16)
        }
        .fullScreen()
        .navigationDestination(isPresented: $showSelectedFromCurrency) {
            SelectCurrencyView(
                onSelectedCurrency: { viewModel.onSelectedFromCurrency(currency: $0) }
            )
        }
        .navigationDestination(isPresented: $showSelectedToCurrency) {
            SelectCurrencyView(
                onSelectedCurrency: { viewModel.onSelectedToCurrency(currency: $0) }
            )
        }
        .onChange(of: viewModel.fromCurrency.value) {
            viewModel.convertValue(value: $0)
        }
    }
    
    @ViewBuilder
    private func FromCurrency() -> some View {
        HStack(alignment: .center, spacing: 0) {
            CurrencyCodeSelector(
                currencyCode: viewModel.fromCurrency.currency,
                onAction: { showSelectedFromCurrency = true }
            )
            InputBox(text: viewModel.fromCurrency.value)
                .padding(.leading, 16)
        }.padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private func SwapSection() -> some View {
        HStack {
            VStack { Divider() }.padding(.horizontal, 16)
            SwapButton().padding(.vertical, 16)
            VStack { Divider() }.padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private func ToCurrency() -> some View {
        HStack(alignment: .center, spacing: 0) {
            CurrencyCodeSelector(
                currencyCode: viewModel.toCurrency.currency,
                onAction: { showSelectedToCurrency = true }
            )
            InputBox(text: viewModel.toCurrency.value)
                .padding(.leading, 16)
        }.padding(.horizontal, 16)
    }
    
    @ViewBuilder
    private func SwapButton() -> some View {
        Button(action: { viewModel.swapCurrency() }) {
            ZStack {
                Circle()
                    .fill(Color.accentColor)
                    .frame(width: 48, height: 48)
                Image(uiImage: .swap)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
            }
        }
    }
    
    
    @ViewBuilder
    private func InputBox(text: String) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Text(text)
                .style(.subtitle)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(Color.grayExtraLight)
        .cornerRadius(8)
        
    }
    
    @ViewBuilder
    private func CurrencyCodeSelector(
        currencyCode: CurrencyCode,
        onAction: @escaping () -> Void = { }
    ) -> some View {
        Button(action: onAction) {
            HStack(spacing: 0) {
                currencyCode.image
                    .resizable()
                    .clipShape(Circle())
                    .frame(width:32, height: 32)
                    .padding(.leading, 4)
                Text(currencyCode.name)
                    .style(.title)
                    .padding(.leading, 8)
                Image(uiImage: .arrowDown)
                    .padding(.leading, 4)
            }
        }
    }
    
    @ViewBuilder
    private func CountryImage(_ url: String) -> some View {
        CachedAsyncImage(url: URL(string: url)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(maxWidth:40, maxHeight: 40)
                
        } placeholder: {
            ProgressView()
                .tint(.accentColor)
        }
    }
}

// Handle KonverterView Navigation
private extension KonverterView {
    
    func teste() -> some View {
        self.navigationDestination(isPresented: $showSelectedToCurrency) {
            SelectCurrencyView()
        }
    }
}

struct KonverterView_Previews: PreviewProvider {
    static var previews: some View {
        KonverterView()
    }
}
