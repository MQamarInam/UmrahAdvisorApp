import SwiftUI

struct ProfileView: View {
    
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    @State private var showEditAlert = false
    @State private var showDeleteAlert = false
    @State private var newFullName = ""
    @State private var isLoggedOut = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationStack {
            if let user = authViewModel.currentUser {
                List {
                    
                    headerSection(user: user)
                    generalSection
                    bokingsSection
                    accountSection
                    
                }
                .alert("Confirm Deletion", isPresented: $showDeleteAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        authViewModel.deleteAccount { success in
                            if success {
                                isLoggedOut = true
                                authViewModel.signOut()
                                print("Account deleted successfully.")
                            } else {
                                print("Failed to delete account.")
                            }
                        }
                    }
                } message: {
                    Text("Are you sure you want to delete your account? This action cannot be undone.")
                }
                
            } else {
                Text("Please sign in to view your profile.")
                    .foregroundColor(.gray)
            }
        }
        .navigationDestination(isPresented: $isLoggedOut) {
            LoginView()
        }

    }
}

#Preview {
    ProfileView()
}

extension ProfileView {
    
    private func headerSection(user: User) -> some View {
        Section {
            HStack {
                Text(user.initials)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 72, height: 72)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(user.fullname)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        Spacer()
                        Image(systemName: "square.and.pencil")
                            .padding(.trailing, 10)
                            .foregroundStyle(Color.background)
                            .font(.headline)
                            .onTapGesture {
                                newFullName = user.fullname
                                showEditAlert = true
                            }
                    }
                    Text(user.email)
                        .font(.footnote)
                        .accentColor(.gray)
                        .lineLimit(1)
                }
            }
            .alert("Edit Name", isPresented: $showEditAlert) {
                TextField("Full Name", text: $newFullName)
                Button("Cancel", role: .cancel) { }
                Button("Update") {
                    authViewModel.updateUserName(fullName: newFullName) { success in
                        if success {
                            print("Name updated successfully.")
                        } else {
                            print("Failed to update name.")
                        }
                    }
                }
            } message: {
                Text("Enter your new name")
            }
        }
    }
    
    private var generalSection: some View {
        Section("General") {
            HStack {
                SettingRowView(imageName: "gear", title: "Version", tintColor: .gray)
                Spacer()
                Text("1.0.0")
                    .foregroundStyle(.gray)
            }
        }
    }
    
    private var bokingsSection: some View {
        Section("Bookings") {
            HStack {
                NavigationLink {
                    UserBookingRequestsView()
                } label: {
                    SettingRowView(imageName: "gear", title: "Package Bookings", tintColor: .gray)
                }
            }
        }
    }
    
    private var accountSection: some View {
        Section("Account") {
            Button {
                isLoggedOut = true
                authViewModel.signOut()
            } label: {
                SettingRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
            }
            
            Button {
                showDeleteAlert = true
            } label: {
                SettingRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
            }
        }
    }
    
}

struct SettingRowView: View {
    var imageName: String
    var title: String
    let tintColor: Color
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}
