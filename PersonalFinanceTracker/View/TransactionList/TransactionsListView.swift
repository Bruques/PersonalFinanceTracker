//
//  TransactionsListView.swift
//  PersonalFinanceTracker
//
//  Created by Bruno Marques on 30/03/25.
//

import SwiftUI

struct TransactionsListView: View {
    var body: some View {
        VStack {
            Image(systemName: "arrow.right.arrow.left.circle.fill")
                .font(.largeTitle)
            Text("Transaction list")
                .font(.title)
        }
    }
}

#Preview {
    TransactionsListView()
}
