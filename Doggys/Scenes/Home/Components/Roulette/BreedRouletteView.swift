//
//  BreedRouletteView.swift
//  Doggys
//
//  Created by Sofia Vieira Rocha on 29/03/26.
//

import SwiftUI

struct BreedRouletteView: View {
    
    // MARK: - Private State properties
    @State private var rotation: Double = 0
    @State private var lastRotation: Double = 0
    @State private var selectedIndex: Int = 0
    @State private var dragVelocity: Double = 0
    @State private var lastDragValue: DragGesture.Value?
    @State private var showAddSheet: Bool = false
    private let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    // MARK: - Computed properties
    private var degreePerItem: Double {
        if dogs.isEmpty {
            return 360
        }
        
        return 360.0 / Double(dogs.count)
    }
    
    // MARK: - Dependencies
    let dogs: [DogModel]
    
    init(dogs: [DogModel]) {
        self.dogs = dogs
    }
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground).ignoresSafeArea()
            
            VStack(spacing: 60) {
                VStack(spacing: 8) {
                    Text("SORTEIE SEU COMPANHEIRO")
                        .font(.caption.bold())
                        .tracking(3)
                        .foregroundColor(.secondary)
                    
                    Text(dogs.isEmpty ? "Gire" : dogs[selectedIndex].name)
                        .font(.system(size: 34, weight: .black, design: .rounded))
                        .contentTransition(.interpolate)
                }
                .padding(.top, 40)
                
                ZStack(alignment: .top) {
                    ZStack {
                        Circle()
                            .fill(Color.secondary.opacity(0.2))
                            .shadow(color: .black.opacity(0.1), radius: 25, x: 0, y: 15)
                        
                        ForEach(0..<dogs.count, id: \.self) { index in
                            let startAngle: Angle = Angle(degrees: degreePerItem * Double(index))
                            let endAngle: Angle = Angle(degrees: degreePerItem * Double(index + 1))
                            
                            RouletteSector(startAngle: startAngle, endAngle: endAngle)
                                .fill(Color(hex: dogs[index].colorHex).opacity(0.2))
                                .overlay(
                                    RouletteSector(startAngle: startAngle, endAngle: endAngle)
                                        .stroke(Color.primary.opacity(0.05), lineWidth: 0.5)
                                )
                                .zIndex(0)
                            
                            VStack {
                                Image(dogs[index].image)
                                    .interpolation(.none)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .rotationEffect(.degrees(-(startAngle.degrees + (degreePerItem/2)) - (rotation - (degreePerItem/2))))
                                
                                Spacer()
                            }
                            .padding(.top, 35)
                            .rotationEffect(.degrees(startAngle.degrees + (degreePerItem/2)))
                            .zIndex(1)
                        }
                        
                        Circle()
                            .fill(Color(uiColor: .systemBackground))
                            .frame(width: 60, height: 60)
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                    .frame(width: 320, height: 320)
                    .rotationEffect(.degrees(rotation - (degreePerItem / 2)))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                guard !dogs.isEmpty else { return }
                                let translation = value.translation.width
                                rotation = lastRotation + translation
                                updateSelection()
                            }
                            .onEnded { value in
                                guard !dogs.isEmpty else { return }
                                let velocity = value.predictedEndTranslation.width
                                
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0)) {
                                    rotation += velocity / 2
                                    
                                    let degreePerItem = 360 / Double(dogs.count)
                                    rotation = (rotation / degreePerItem).rounded() * degreePerItem
                                    
                                    lastRotation = rotation
                                    updateSelection()
                                }
                                impactMed.impactOccurred(intensity: 0.8)
                            }
                    )
                    
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .frame(width: 20, height: 15)
                        .foregroundColor(.primary)
                        .rotationEffect(.degrees(180))
                        .offset(y: -10)
                        .dropShadow()
                }
                
                Spacer()
                
                ButtonView(text: "Adicionar opções", color: .blueBone) {
                    showAddSheet = true
                }
            }
        }
        .sheet(isPresented: $showAddSheet) {
            DogsListView()
        }
    }
    
    private func updateSelection() {
        guard !dogs.isEmpty else { return }
        let degreePerItem = 360 / Double(dogs.count)
        
        let normalizedRotation = (rotation.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
        
        let index = Int((360 - normalizedRotation).truncatingRemainder(dividingBy: 360) / degreePerItem)
        
        if index >= 0 && index < dogs.count && index != selectedIndex {
            selectedIndex = index
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
}

#Preview {
    BreedRouletteView(dogs: [])
}
