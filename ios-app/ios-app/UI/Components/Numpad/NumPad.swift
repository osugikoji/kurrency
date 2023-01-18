//
//  KeyPadButton.swift
//  ios-app
//
//  Created by Koji Osugi on 12/01/23.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct NumPad: View {
    @Binding var string: String
    
    var body: some View {
        HStack {
            VStack {
                KeyPadRow(keys: ["7", "8", "9"])
                KeyPadRow(keys: ["4", "5", "6"])
                KeyPadRow(keys: ["1", "2", "3"])
                HStack {
                    KeyPadButton(key: "0")
                    KeyPadButton(key: ",")
                        .aspectRatio(1, contentMode: .fit)
                }
            }
            KeyPadColumn(keys: ["C", "⌫"])
                .frame(maxWidth: 64)
        }
        .aspectRatio(1, contentMode: .fit)
        .environment(\.keyPadButtonAction, self.keyWasPressed(_:))
    }
    
    private func keyWasPressed(_ key: String) {
        switch key {
        case "," where string.contains(","): break
        case "," where string == "0": string += key
        case "C": string = "0"
        case "⌫":
            string.removeLast()
            if string.isEmpty { string = "0" }
        case _ where string == "0": string = key
        default: string += key
        }
    }
}

struct KeyPadRow: View {
    var keys: [String]
    
    var body: some View {
        HStack {
            ForEach(keys, id: \.self) { key in
                KeyPadButton(key: key)
            }
        }
    }
}

struct KeyPadColumn: View {
    var keys: [String]
    
    var body: some View {
        VStack {
            ForEach(keys, id: \.self) { key in
                KeyPadButton(
                    key: key,
                    bgColor: .accentColor,
                    textColor: .grayExtraLight
                )
            }
        }
    }
}

struct KeyPadButton: View {
    var key: String
    var bgColor = Color.grayExtraLight
    var textColor = Color.grayDark
    
    var body: some View {
        Button(action: { self.action(self.key) }) {
            Rectangle()
                .fill(bgColor)
                .overlay(Text(key)
                    .foregroundColor(textColor)
                    .style(.title)
                )
                .cornerRadius(8)
        }
    }
    
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
    
    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}

struct NumPad_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Color.blue.aspectRatio(1, contentMode: .fit)
            NumPad(string: .constant(""))
        }
    }
}
