//
//  ToolbarModifier.swift
//  ios-app
//
//  Created by Koji Osugi on 14/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

extension View {
    
    func applyToolbar(_ title: String, dismiss: DismissAction) -> some View {
        self
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    HStack {
                        ImageButton(
                            .arrowLeft,
                            color: .accentColor,
                            action: { dismiss() }
                        )
                        Text(title).style(.title)
                    }
                }
            }
    }
}
