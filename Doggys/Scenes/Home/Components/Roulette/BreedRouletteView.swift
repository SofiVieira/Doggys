//
//  BreedRouletteView.swift
//  Doggys
//
//  Created by Sofia Vieira Rocha on 29/03/26.
//

import SwiftUI

struct BreedRouletteView: View {
    // Dados das raças
    let breeds = [
        DogBreed(name: "Yorkshire", icon: .yorkshire, color: .yellow),
        DogBreed(name: "Samoieda", icon: .samoieda, color: .green),
        DogBreed(name: "Cocker Spaniel", icon: .cockerSpaniel, color: .blue),
        DogBreed(name: "King Cavalier", icon: .kingCavalier, color: .purple),
        DogBreed(name: "Maltês", icon: .maltes, color: .red),
        DogBreed(name: "Shiba Inu", icon: .shibaInu, color: .orange)
    ]
    
    @State private var rotation: Double = 0
    @State private var lastRotation: Double = 0
    @State private var selectedIndex: Int = 0
    @State private var dragVelocity: Double = 0
    @State private var lastDragValue: DragGesture.Value?
    
    private let impactMed = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        ZStack {
            // Fundo Minimalista
            Color(uiColor: .systemBackground).ignoresSafeArea()
            
            VStack(spacing: 60) {
                // Legenda Elegante
                VStack(spacing: 8) {
                    Text("SORTEIE SEU COMPANHEIRO")
                        .font(.caption.bold())
                        .tracking(3)
                        .foregroundColor(.secondary)
                    
                    Text(breeds[selectedIndex].name)
                        .font(.system(size: 34, weight: .black, design: .rounded))
                        .contentTransition(.interpolate)
                }
                .padding(.top, 40)
                
                ZStack(alignment: .top) {
                    // A Roleta
                    ZStack {
                        // Sombra de fundo para dar profundidade
                        Circle()
                            .fill(Color(uiColor: .systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 25, x: 0, y: 15)
                        
                        let degreePerItem = 360.0 / Double(breeds.count)
                        
                        ForEach(0..<breeds.count, id: \.self) { index in
                            let startAngle = Angle(degrees: degreePerItem * Double(index))
                            let endAngle = Angle(degrees: degreePerItem * Double(index + 1))
                            
                            // 3. Desenha a Fatia Colorida
                            RouletteSector(startAngle: startAngle, endAngle: endAngle)
                                .fill(breeds[index].color.opacity(0.2)) // Sua opacidade de 0.2
                                .overlay(
                                    // Linha divisória fina e elegante
                                    RouletteSector(startAngle: startAngle, endAngle: endAngle)
                                        .stroke(Color.primary.opacity(0.05), lineWidth: 0.5)
                                )
                            // Garante que as fatias não sobreponham o conteúdo
                                .zIndex(0)
                            
                            // 4. Posiciona o Conteúdo (Emoji)
                            VStack {
                                Image(breeds[index].icon)
                                    .interpolation(.none)
                                    .resizable()
                                    .frame(maxWidth: 60, maxHeight: 60)
                                    .rotationEffect(.degrees(-(startAngle.degrees + (degreePerItem/2)) - rotation))
                                Spacer()
                            }
                            .padding(.top, 40) // Ajusta a distância do emoji do centro
                            .rotationEffect(.degrees(startAngle.degrees + (degreePerItem/2)))
                            .zIndex(1)
                        }
                        
                        // Círculo central "limpo" para estética premiada
                        Circle()
                            .fill(Color(uiColor: .systemBackground))
                            .frame(width: 60, height: 60)
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                    .frame(width: 320, height: 320)
                    .rotationEffect(.degrees(rotation))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // O segredo está aqui: para seguir o dedo, usamos o valor positivo
                                // Se sentir que ainda está "invertido", mude para -value.translation.width
                                let translation = value.translation.width
                                rotation = lastRotation + translation
                                updateSelection()
                            }
                            .onEnded { value in
                                // Usamos a velocidade prevista (impulso) também com sinal corrigido
                                let velocity = value.predictedEndTranslation.width
                                
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0)) {
                                    // O impulso soma à rotação atual
                                    rotation += velocity / 2
                                    
                                    // Snap para a posição mais próxima (mecanismo de trava)
                                    let degreePerItem = 360 / Double(breeds.count)
                                    rotation = (rotation / degreePerItem).rounded() * degreePerItem
                                    
                                    lastRotation = rotation
                                    updateSelection()
                                }
                                impactMed.impactOccurred(intensity: 0.8)
                            }
                    )
                    
                    // A "Setinha" (Pointer)
                    Image(systemName: "triangle.fill")
                        .resizable()
                        .frame(width: 20, height: 15)
                        .foregroundColor(.primary)
                        .rotationEffect(.degrees(180))
                        .offset(y: -10)
                        .dropShadow()
                }
                
                Spacer()
            }
        }
    }
    
    private func updateSelection() {
        let degreePerItem = 360 / Double(breeds.count)
        // Normaliza o ângulo para positivo e calcula o índice
        let normalizedRotation = (rotation.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
        let index = Int((360 - normalizedRotation + (degreePerItem / 2)).truncatingRemainder(dividingBy: 360) / degreePerItem)
        
        if index != selectedIndex && index < breeds.count {
            selectedIndex = index
            // Feedback tátil ao passar por cada item
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
}

#Preview {
    BreedRouletteView()
}
