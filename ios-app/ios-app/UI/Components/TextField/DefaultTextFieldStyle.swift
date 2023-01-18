//
//  DefaultTextFieldStyle.swift
//  ios-app
//
//  Created by Koji Osugi on 14/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct DefaultTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical)
            .padding(.horizontal, 24)
            .background(Color.grayExtraLight)
            .foregroundColor(.grayDark)
            .cornerRadius(8)
    }
}
