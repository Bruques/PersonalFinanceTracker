//
//  TransactionsListView.swift
//  PersonalFinanceTracker
//
//  Created by Bruno Marques on 30/03/25.
//

import SwiftUI
import CoreData

struct TransactionsListView: View {
    @State var showTransactionForm: Bool = false
    @State var transactions: [Transaction] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(transactions, id: \.id) { transaction in
                    VStack {
                        Text(transaction.title ?? "")
                        Text("\(transaction.ammount)")
                        Text("Category: \(transaction.category?.title ?? "")")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showTransactionForm = true
                    }, label: {
                        Image(systemName: "plus")
                            .font(.title2)
                    })
                }
            }
            .refreshable {
                fetchTransactions()
            }
        }
        .sheet(isPresented: $showTransactionForm, content: {
            TransactionFormView() { self.transactions.append($0) }
        })
        .onAppear {
            fetchTransactions()
        }
    }
}

extension TransactionsListView {
    private func fetchTransactions() {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        do {
            let response = try CoreDataStack.shared.persistentContainer.viewContext.fetch(request)
            transactions = response
        } catch {
            print("Fetch contracts error: \(error.localizedDescription)")
        }
    }
}

#Preview {
    TransactionsListView()
}
