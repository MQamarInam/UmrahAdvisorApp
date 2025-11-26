//
//  UmrahGuideView.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 06/08/2024.
//

import SwiftUI

struct UmrahGuideView: View {

    @StateObject private var vm = UmrahGuideViewModel()

    var body: some View {
        NavigationStack {
            VStack {

                ProgressView(value: Double(vm.currentStepIndex + 1),
                             total: Double(vm.steps.count))
                    .tint(.green)
                    .padding(.horizontal)
                    .padding(.vertical, 6)

                stepSection
                buttonsSection
            }
            .padding(.horizontal)
            .navigationTitle(
                Text("Step \(vm.currentStepIndex + 1) of \(vm.steps.count)")
            )
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var stepSection: some View {
        VStack(spacing: 15) {
            Image("umrahfull")
                .resizable()
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            Text(vm.steps[vm.currentStepIndex].title)
                .font(.title2)
                .fontWeight(.bold)

            List(vm.steps[vm.currentStepIndex].description, id: \.self) { text in
                Text(text)
            }
            .listStyle(.plain)
            .frame(maxHeight: .infinity)
        }
    }

    private var buttonsSection: some View {
        VStack {
            Toggle("Mark as Completed",
                   isOn: Binding(
                       get: { vm.steps[vm.currentStepIndex].isCompleted },
                       set: { _ in vm.toggleCompletion() }
                   )
            )
            .toggleStyle(.switch)
            .tint(.green)

            HStack {
                Button(action: vm.previousStep) {
                    Text("Previous")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(vm.currentStepIndex == 0)
                
                Button(action: vm.nextStep) {
                    Text(vm.currentStepIndex < vm.steps.count - 1 ? "Next" : "Finish")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.bgcu, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(vm.currentStepIndex == vm.steps.count - 1)
            }
        }
    }
    
}

#Preview {
    UmrahGuideView()
}
