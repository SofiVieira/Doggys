//
//  ButtonView.swift
//  Doggys
//
//  Created by Sofia Vieira Rocha on 29/03/26.
//

import SwiftUI

struct ButtonView: View {
    
    var text: String
    var color: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .bold()
                .frame(maxWidth: .infinity, maxHeight: 44)
        })
        .buttonStyle(.borderedProminent)
        .tint(color)
    }
}

#Preview {
    HStack {
        ButtonView(text: "Delete", color: .red, action: {})
        ButtonView(text: "Continue", color: .green, action: {})
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
