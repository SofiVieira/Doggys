//
//  DogListCellView.swift
//  Doggys
//
//  Created by Yuri Strack on 29/03/26.
//

import SwiftUI

struct DogListCellView: View {
    
    // MARK: - Cell identifier
    static let identifier: String = "DogListCellView"
    
    // MARK: - Constants
    private enum LayoutConstants {
        enum Image {
            static let size: CGSize = .init(width: 110, height: 100)
            static let cornerRadius: CGFloat = 16
        }
    }
    
    // MARK: - Dependencies
    private let dog: DogModel
    private let isSelected: Bool
    
    // MARK: - Initializer
    init(dog: DogModel, isSelected: Bool) {
        self.dog = dog
        self.isSelected = isSelected
    }
    
    // MARK: - View Body
    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .top) {
                Image(systemName: "dog.fill")
                    .resizable()
                    .background(Color(uiColor: .tertiaryLabel))
                    .frame(
                        width: LayoutConstants.Image.size.width,
                        height: LayoutConstants.Image.size.height
                    )
                    .clipShape(borderShape)
                    .overlay(
                        borderShape
                            .stroke(Color.black, lineWidth: 1)
                    )
                
                Text(dog.name)
                    .font(.body)
                    .fontWeight(.black)
                    .fontDesign(.rounded)
            }
            
            Spacer()
            
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .font(.title)
                .symbolVariant(.fill)
                .foregroundStyle(isSelected ? Color.accentColor : Color.secondary.opacity(0.2))
                .contentTransition(.symbolEffect(.replace))
        }
        .animation(.snappy(duration: 0.2), value: isSelected)
    }
    
    // MARK: - Subviews
    private var borderShape: some Shape {
        RoundedRectangle(
            cornerRadius: LayoutConstants.Image.cornerRadius
        )
    }
}

#Preview {
    DogListCellView(dog: .init(name: "Teste"), isSelected: false)
}
