import SwiftUI

struct AddCategorySheet: View {
    @Binding var isPresented: Bool
    @State private var categoryName: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Nome da categoria", text: $categoryName)
                }
            }
            .navigationTitle("Nova Categoria")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancelar") {
                    isPresented = false
                },
                trailing: Button("Salvar") {
                    // Aqui você pode adicionar a lógica para salvar a categoria
                    isPresented = false
                }
                .disabled(categoryName.isEmpty)
            )
        }
        .presentationDetents([.height(150)])
    }
}

#Preview {
    AddCategorySheet(isPresented: .constant(true))
}
