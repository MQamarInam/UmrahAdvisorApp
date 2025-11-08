import SwiftUI

struct TasbihCounterView: View {
    
    @StateObject private var viewModel = TasbihCounterViewModel()
    
    var body: some View {
        VStack {
            
            pickerSection
            
            Spacer()
            
            VStack {
                Text(viewModel.selectedZikr.name)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                
                Text("\(viewModel.selectedZikr.count)")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)
                    .animation(.easeInOut, value: viewModel.selectedZikr.count)
            }
            
            Spacer()
            
            zikrProgress
            
            Spacer()
            
            Button(action: {
                viewModel.incrementCounter()
            }) {
                Text("Count")
                    .font(.title)
                    .padding()
                    .frame(width: 150)
                    .background(Capsule().fill(.green))
                    .foregroundColor(.white)
                    .shadow(color: .green.opacity(0.5), radius: 10, x: 0, y: 5)
            }
            .padding()
            
            Button(action: {
                viewModel.resetCounter()
            }) {
                Text("Reset")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            .padding(.bottom, 20)
            
            Spacer()
            
        }
        .alert(isPresented: $viewModel.isGoalReached, content: {
            Alert(
                title: Text("Congratulations!"),
                message: Text("You've reached your goal of \(viewModel.goal) counts for \(viewModel.selectedZikr.name)!"),
                dismissButton: .default(Text("OK"))
            )
        })
        .padding()
        
    }
    
    private var pickerSection: some View {
        Picker("Zikr", selection: $viewModel.selectedZikrIndex) {
            ForEach(0..<viewModel.zikrs.count, id: \.self) { index in
                Text(viewModel.zikrs[index].name)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.vertical)
        .onChange(of: viewModel.selectedZikrIndex) {
            viewModel.checkGoal()
        }
    }
    
    private var zikrProgress: some View {
        ZStack {
            Circle()
                .stroke(.green.opacity(0.3), lineWidth: 15)
                .frame(width: 150, height: 150)
            
            Circle()
                .trim(from: 0.0,
                      to: CGFloat(min(Double(viewModel.selectedZikr.count) / Double(viewModel.goal), 1.0)))
                .stroke(.green, lineWidth: 15)
                .rotationEffect(Angle(degrees: 270))
                .frame(width: 150, height: 150)
                .animation(.easeInOut, value: viewModel.selectedZikr.count)
            
            Text("\(Int(Double(viewModel.selectedZikr.count) / Double(viewModel.goal) * 100))%")
                .font(.title2)
                .bold()
                .foregroundColor(.green)
        }
    }
    
}

#Preview {
    TasbihCounterView()
}
