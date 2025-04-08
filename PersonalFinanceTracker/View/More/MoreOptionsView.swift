//
//  MoreOptionsView.swift
//  PersonalFinanceTracker
//
//  Created by Bruno Marques on 08/04/25.
//

import SwiftUI

struct MoreOptionsView: View {
    var body: some View {
        VStack {
            Image(systemName: "ellipsis.circle")
                .font(.largeTitle)
            Text("More")
                .font(.title)
        }
    }
}

#Preview {
    MoreOptionsView()
}
