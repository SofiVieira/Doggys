//
//  View+Extension.swift
//  Doggys
//
//  Created by Sofia Vieira Rocha on 29/03/26.
//

import SwiftUI

extension View {
    func dropShadow() -> some View {
        self.shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
