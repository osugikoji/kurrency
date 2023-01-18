//
//  KoinApp.swift
//  ios-app
//
//  Created by Koji Osugi on 15/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import shared

typealias KoinApplication = Koin_coreKoinApplication
typealias Koin = Koin_coreKoin

extension KoinApplication {
    
    private static let keyPaths: [PartialKeyPath<Koin>] = [
        \.cacheManager,
         \.currentCurrencyUseCase,
         \.rateUseCase
    ]
    
    public func inject<T>() -> T {
        for partialKeyPath in Self.keyPaths {
            guard let keyPath = partialKeyPath as? KeyPath<Koin, T> else { continue }
            return KurrencySetup.shared.getKoinApp().koin[keyPath: keyPath]
        }
        fatalError("\(T.self) is not registered with KoinApplication")
    }
}

@propertyWrapper
public struct Inject<T> {
    public lazy var wrappedValue: T = { KurrencySetup.shared.getKoinApp().inject() }()

    public init() { }
}
