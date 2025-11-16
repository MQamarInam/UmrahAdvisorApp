import SwiftUI

struct MainAdminPanelView: View {
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    NavigationLink {
                        AddPackageView()
                    } label: {
                        AdminButtons(text: "Create New Umrah Package", lineWidth: 5)
                    }
                    HStack(spacing: 15) {
                        NavigationLink {
                            DeletePackageView()
                        } label: {
                            AdminButtons(text: "Modify Umrah Package", lineWidth: 4)
                        }
                        NavigationLink {
                            BookingRequestsView()
                        } label: {
                            AdminButtons(text: "View Package Requests", lineWidth: 4)
                        }
                    }
                    NavigationLink {
                        CustomPackageRequestsView()
                    } label: {
                        AdminButtons(text: "View Custom Package Requests", lineWidth: 5)
                    }
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color.green)

                    // Add Custom Package Information Section
                    VStack(spacing: 15) {
                        Text("Add Custom Package Information")
                            .font(.headline)
                            .foregroundStyle(Color.primary.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack(spacing: 15) {
                            NavigationLink {
                                AddMakkahHotel()
                            } label: {
                                AdminButtons(text: "Add New Makkah Hotel", lineWidth: 3)
                            }
                            NavigationLink {
                                AddMadinahHotel()
                            } label: {
                                AdminButtons(text: "Add New Madinah Hotel", lineWidth: 3)
                            }
                        }

                        HStack(spacing: 15) {
                            NavigationLink {
                                AddFlightData()
                            } label: {
                                AdminButtons(text: "Add New Flight", lineWidth: 3)
                            }
                            NavigationLink {
                                AddZiyaratData()
                            } label: {
                                AdminButtons(text: "Add New Ziyarat", lineWidth: 3)
                            }
                        }
                        
                        HStack(spacing: 15) {
                            NavigationLink {
                                AddTransportationData()
                            } label: {
                                AdminButtons(text: "Add New Transportation", lineWidth: 3)
                            }
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)

                    Divider()
                        .frame(height: 2)
                        .background(Color.green)

                    // Modify Custom Package Data Section
                    VStack(spacing: 15) {
                        Text("Modify Custom Package Data")
                            .font(.headline)
                            .foregroundStyle(Color.primary.opacity(0.8))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        HStack(spacing: 15) {
                            NavigationLink {
                                ModifyMakkahHotel()
                            } label: {
                                AdminButtons(text: "Modify Makkah Hotel Data", lineWidth: 3)
                            }
                            NavigationLink {
                                ModifyMadinahHotel()
                            } label: {
                                AdminButtons(text: "Modify Madinah Hotel Data", lineWidth: 3)
                            }
                        }

                        HStack(spacing: 15) {
                            NavigationLink {
                                ModifyFlightData()
                            } label: {
                                AdminButtons(text: "Modify Flight Information", lineWidth: 3)
                            }
                            NavigationLink {
                                ModifyZiyaratData()
                            } label: {
                                AdminButtons(text: "Update Ziyarat Data", lineWidth: 3)
                            }
                        }
                        
                        HStack(spacing: 15) {
                            NavigationLink {
                                ModifyTransportationData()
                            } label: {
                                AdminButtons(text: "Modify Transportation Information", lineWidth: 3)
                            }
                        }
                        
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
                .padding()
                .navigationTitle("Admin Panel")
            }
        }
    }
    
}

struct AdminButtons: View {
    var text: String
    var lineWidth: CGFloat
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .green, .green, .blue]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                lineWidth: lineWidth
            )
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.2), Color.blue.opacity(0.2)]), startPoint: .leading, endPoint: .trailing))
            .overlay {
                Text(text)
                    .font(.headline)
                    .bold()
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(nil)
                    .foregroundStyle(Color.primary.opacity(0.8))
                    .padding()
            }
    }
}

#Preview {
    MainAdminPanelView()
}
