import SwiftUI

struct ModifyZiyaratData: View {
    
    @StateObject private var viewModel = CustomPackageViewModel()
    @State private var showDeleteAlert = false
    @State private var ziyaratToDelete: Ziyarat?
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(viewModel.ziyaratList, id: \.id) { ziyarat in
                    NavigationLink {
                        ZiyaratDetailView(ziyarat: ziyarat, viewModel: viewModel)
                    } label: {
                        Text(ziyarat.name)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        ziyaratToDelete = viewModel.ziyaratList[index]
                        showDeleteAlert = true
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Ziyarats")
            .alert("Delete Ziyarat", isPresented: $showDeleteAlert) {
                Button("Delete", role: .destructive) {
                    if let ziyarat = ziyaratToDelete {
                        viewModel.deleteZiyarat(ziyarat)
                    }
                }
                Button("Cancel", role: .cancel) {
                    ziyaratToDelete = nil
                }
            } message: {
                Text("Are you sure you want to delete this Ziyarat?")
            }
        }
    }
}

#Preview {
    ModifyZiyaratData()
}
