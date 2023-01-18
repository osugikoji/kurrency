//
//  CurrencyCodeExtensions.swift
//  ios-app
//
//  Created by Koji Osugi on 13/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

extension CurrencyCode {
    
    var image: Image {
        switch self {
        case .brl: return Image(uiImage: .brazil)
        case .cad: return Image(uiImage: .canada)
        case .cny: return Image(uiImage: .china)
        case .eur: return Image(uiImage: .euro)
        case .jpy: return Image(uiImage: .japan)
        case .krw: return Image(uiImage: .southKorea)
        case .usd: return Image(uiImage: .unitedStates)
        default: return Image(uiImage: .argentina)
        }
    }
}
