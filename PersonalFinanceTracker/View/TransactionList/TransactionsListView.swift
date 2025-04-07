//
//  TransactionsListView.swift
//  PersonalFinanceTracker
//
//  Created by Bruno Marques on 30/03/25.
//

import SwiftUI

struct TransactionsListView: View {
    let context = CoreDataStack.shared.persistentContainer.viewContext
    
    var body: some View {
        ZStack {
            HStack {
                Button {
                    // Action
                } label: {
                    FloatingButtonView(color: .purple, iconName: "plus")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing, 24)
            .padding(.bottom, 24)
        }
    }
}

#Preview {
    TransactionsListView()
}
