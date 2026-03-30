//
//  ButtonView.swift
//  Doggys
//
//  Created by Sofia Vieira Rocha on 29/03/26.
//

import SwiftUI

struct ButtonView: View {
    
    var text: String
    var color: ImageResource
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            ZStack {
                Image(color)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .opacity(0.8)
                    
                Text(text)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .foregroundColor(.white)
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(8)
    }
}

#Preview {
    HStack {
        ButtonView(text: "Delete", color: .redBone, action: {})
        ButtonView(text: "Continue", color: .greenBone, action: {})
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
