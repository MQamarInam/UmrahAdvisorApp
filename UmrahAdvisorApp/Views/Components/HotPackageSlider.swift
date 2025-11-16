import SwiftUI

struct HotPackageSlider: View {
    
    var hotPackages: [Packages]
    
    @State private var currentIndex: Int = 0
    @State private var selectedPackage: Packages? = nil
    @State private var timer: Timer? = nil
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                if hotPackages.isEmpty {
                    placeholderView
                } else {
                    packageSection
                }
                if !hotPackages.isEmpty {
                    circleSection
                }
            }
            .background(
                ZStack {
                    Color.white
                    DealRadialAnimation(color: Color.background)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            )

        }
        .shadow(color: .black.opacity(0.4), radius: 4, x: 1, y: 2)
        .padding(.vertical, 10)
        .onAppear {
            if !hotPackages.isEmpty {
                startSliding()
            }
        }
        .onDisappear {
            stopSliding()
        }
        .onChange(of: hotPackages.count) { oldValue, newValue in
            currentIndex = 0
            if newValue == 0 {
                stopSliding()
            } else {
                startSliding()
            }
        }
        .sheet(item: $selectedPackage) { package in
            PackageDetailView(item: package)
        }
    }
    
}

extension HotPackageSlider {
    
    private var placeholderView: some View {
        VStack {
            ProgressView()
                .font(.headline)
                .tint(.white)
            Text("No Hot Packages Available")
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.background.cornerRadius(12))
    }
    
    private var packageSection: some View {
        let package = hotPackages[currentIndex]
        return ZStack {
            Image("logoPng")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .opacity(0.1)
                .cornerRadius(30)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(package.name)
                        .font(.title2)
                        .fontWeight(.semibold)

                    VStack(alignment: .leading) {
                        Text("Duration: \(package.days) days")
                        Text("Price: \(package.price, specifier: "%.2f") PKR")
                    }
                    .font(.caption)

                    Text("Itinerary")
                        .fontWeight(.medium)

                    VStack(alignment: .leading) {
                        Text("• First \(package.firstDays) days in Makkah")
                        Text("• Next \(package.nextDays) days in Madina")
                        Text("• Last \(package.lastDays) days back in Makkah")
                    }
                    .font(.caption)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)
            .foregroundColor(Color.background)
            .frame(maxWidth: .infinity, minHeight: 180)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedPackage = package
        }
    }
    
    private var circleSection: some View {
        HStack {
            ForEach(0..<hotPackages.count, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? Color.bgcu : Color.gray.opacity(0.5))
                    .frame(width: 10, height: 10)
            }
        }
        .padding(.bottom)
        .padding(.top, 5)
    }
    
    private func startSliding() {
        stopSliding()
        guard !hotPackages.isEmpty else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
            withAnimation(.easeIn) {
                currentIndex = (currentIndex + 1) % hotPackages.count
            }
        }
    }
    
    private func stopSliding() {
        timer?.invalidate()
        timer = nil
    }
    
}

struct DealRadialAnimation: View {
    var color: Color = .background
    @State private var animate = false
    @State private var animateSecond = false

    var body: some View {
        GeometryReader { geo in
            let maxSide = max(geo.size.width, geo.size.height)
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: maxSide * 0.18, height: maxSide * 0.18)
                    .scaleEffect(animateSecond ? (maxSide / (maxSide * 0.18)) * 2.4 : 0.04)
                    .opacity(animateSecond ? 0.08 : 0.7)
                    .blur(radius: animateSecond ? 60 : 14)
                    .animation(.easeOut(duration: 2.2).repeatForever(autoreverses: false), value: animateSecond)
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .onAppear {
                animate = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    animateSecond = true
                }
            }
        }
        .compositingGroup()
        .allowsHitTesting(false)
    }
}


