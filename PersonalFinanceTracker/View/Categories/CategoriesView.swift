import SwiftUI

struct CategoriesView: View {
    @State private var showingAddSheet = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Categorias")
                    .font(.title)
                    .padding()
                
                List {
                    // Aqui você pode adicionar suas categorias
                    Text("Categoria 1")
                    Text("Categoria 2")
                    Text("Categoria 3")
                }
            }
            
            // Botão flutuante
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showingAddSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            AddCategorySheet(isPresented: $showingAddSheet)
        }
    }
}

#Preview {
    CategoriesView()
}
