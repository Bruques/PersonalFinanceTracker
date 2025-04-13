//
//  TransactionFormView.swift
//  PersonalFinanceTracker
//
//  Created by Bruno Marques on 12/04/25.
//

import SwiftUI
import CoreData

struct TransactionFormView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    @State var ammount: String = ""
    @State var date: Date = Date()
    @State var title: String = ""
    @State var categories: [Category] = []
    @State var selectedCategory: Category?
    
    let completion: (Transaction) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Valor da despesa", text: $ammount)
                    .focused($isFocused)
                    .onAppear(perform: {
                        isFocused = true
                    })
                    .keyboardType(.decimalPad)
                Picker("Categorias", selection: $selectedCategory) {
                    ForEach(categories, id: \.id) { category in
                        Text(category.title ?? "Sem título")
                            .tag(Optional(category)) // I need use this because selectec category is optional
                    }
                }
                DatePicker("Data da despesa", selection: $date, displayedComponents: .date)
                TextField("Descrição", text: $title)
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Nova despesa")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
                ToolbarItem(placement: .topBarTrailing) {
                    saveButton
                }
            }
        }
        .onAppear {
            fetchCategories()
        }
    }
    
    var backButton: some View {
            Button(action: {
                dismiss()
            }, label: {
                Text("Voltar")
            })
        }
        
        var saveButton: some View {
            Button(action: {
                saveTransaction()
            }, label: {
                Text("Salvar")
                    .font(.headline)
            })
            .disabled(!isSaveButtonEnabled())
        }
}

extension TransactionFormView {
    private func isSaveButtonEnabled() -> Bool {
        return !ammount.isEmpty && !title.isEmpty
    }
    
    private func fetchCategories() {
        let request = NSFetchRequest<Category>(entityName: "Category")
        do {
            let response = try CoreDataStack.shared.persistentContainer.viewContext.fetch(request)
            categories = response
            selectedCategory = response.first
        } catch {
            print("Fetch contracts error: \(error.localizedDescription)")
        }
    }
    
    private func saveTransaction() {
        guard let ammount = Double(ammount) else {
            return
        }
        let transaction = Transaction(context: CoreDataStack.shared.persistentContainer.viewContext)
        transaction.ammount = ammount
        transaction.date = date
        transaction.title = title
        CoreDataStack.shared.save()
        completion(transaction)
        dismiss()
    }
}

#Preview {
    TransactionFormView() { _ in }
}
