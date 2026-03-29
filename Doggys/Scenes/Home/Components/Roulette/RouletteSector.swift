//
//  RouletteSector.swift
//  Doggys
//
//  Created by Sofia Vieira Rocha on 29/03/26.
//

import SwiftUI

struct RouletteSector: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        // Move para o centro
        path.move(to: center)
        
        // Adiciona o arco
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle - .degrees(90), // Ajuste para o topo
                    endAngle: endAngle - .degrees(90),
                    clockwise: false)
        
        // Fecha de volta para o centro
        path.closeSubpath()
        
        return path
    }
}
