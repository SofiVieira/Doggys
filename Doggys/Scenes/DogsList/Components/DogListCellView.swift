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
        
        enum SelectedImage {
            static let padding: CGFloat = 2
            static let unselectedOpacity: CGFloat = 0.2
        }
        
        enum Animation {
            static let duration: CGFloat = 0.2
        }
        
        enum Border {
            static let width: CGFloat = 1
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
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(systemName: "dog.fill")
                    .resizable()
                    .background(Color(uiColor: .tertiaryLabel))
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .symbolVariant(.fill)
                    .foregroundStyle(isSelected ? Color.accentColor : Color.secondary.opacity(LayoutConstants.SelectedImage.unselectedOpacity))
                    .contentTransition(.symbolEffect(.replace))
                    .padding(LayoutConstants.SelectedImage.padding)
            }
            
            Text(dog.name)
                .font(.body)
                .fontWeight(.black)
                .fontDesign(.rounded)
        }
        .animation(.snappy(duration: LayoutConstants.Animation.duration), value: isSelected)
        .frame(maxWidth: .infinity)
        .clipShape(borderShape)
        .overlay(
            borderShape
                .stroke(Color.black, lineWidth: LayoutConstants.Border.width)
        )
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
