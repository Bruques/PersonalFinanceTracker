//
//  FloatingButtonView.swift
//  PersonalFinanceTracker
//
//  Created by Bruno Marques on 07/04/25.
//

import SwiftUI

struct FloatingButtonView: View {
    var color: Color
    var iconName: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 70, height: 70)
            Image(systemName: iconName)
                .font(.system(size: 40))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    FloatingButtonView(color: .purple, iconName: "plus")
}
