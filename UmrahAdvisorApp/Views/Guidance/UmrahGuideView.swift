//
//  UmrahGuideView.swift
//  UmrahBooking
//
//  Created by Macbook Pro on 06/08/2024.
//

import SwiftUI

struct UmrahGuideView: View {
        
    @StateObject private var viewModel = UmrahGuideViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                progressSection
                
                VStack(spacing: 15) {
                    
                    Image("umrahfull")
                        .resizable()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    
                    Text(viewModel.steps[viewModel.currentStepIndex].title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.vertical, -10)
                    
                    List(viewModel.steps[viewModel.currentStepIndex].description, id: \.self) { description in
                        Text(description)
                    }
                    .listStyle(PlainListStyle())
                    
                    buttonsSection
                    
                }
                .animation(.easeInOut(duration: 0.5), value: viewModel.currentStepIndex)
                .padding(.top)
                
            }
                
        }
        
    }
    
    private var progressSection: some View {
        VStack {
            HStack {
                Text("Step \(viewModel.currentStepIndex + 1) of \(viewModel.steps.count)")
                    .font(.headline)
                    .padding(.top, 10)
            }
            .padding(.horizontal)
            
            ProgressView(value: Double(viewModel.currentStepIndex + 1), total: Double(viewModel.steps.count))
                .padding(.horizontal)
                .accentColor(.green)
        }
    }
    
    private var buttonsSection: some View {
        VStack {
            HStack {
                Toggle(isOn: $viewModel.steps[viewModel.currentStepIndex].isCompleted.onChange(viewModel.saveSteps)) {
                    Text("Mark as Completed")
                        .font(.headline)
                }
                .padding(.horizontal)
                .toggleStyle(SwitchToggleStyle(tint: .green))
            }
            HStack {
                Button(action: viewModel.previousStep) {
                    Text("Previous")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black.opacity(0.8)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.currentStepIndex == 0)
                
                Button(action: viewModel.nextStep) {
                    Text(viewModel.currentStepIndex < viewModel.steps.count - 1 ? "Next" : "Finish")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.currentStepIndex == viewModel.steps.count - 1)
            }
        }
        .padding(.horizontal, 16)
    }
    
}

#Preview {
    UmrahGuideView()
}
