//
//  SplashView.swift
//  RickAndMortySwiftUI
//
//  Created by Okan Özdemir on 23.04.2023.
//

import SwiftUI

struct SplashView: View {
    @State private var isFirstLaunch: Bool = UserDefaults.standard.bool(forKey: "isFirstLaunch")
    @State var isActive: Bool = false
    @State private var animate = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                ContentView()
            } else {
                    VStack {
                        Image("RMLogo")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaleEffect(animate ? 1.0 : 0.8)
                            .shadow(color: animate ? Color.green : Color.yellow,
                                    radius: animate ? 30 : 20)
                        Text(!isFirstLaunch ? "Welcome!" : "Hello")
                            .font(.custom("GetSchwifty-Regular", size: 40))
                            .fontWeight(.bold)
                            .padding(.top, 20)
                            .multilineTextAlignment(.center)
                            .shadow(color: Color.green,
                                    radius: 30)
                    }
                    .frame(maxWidth: 400)
                    .onAppear {
                        addAnimation()
                    }
                }
        }
        .onAppear {
            if !isFirstLaunch {
                UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
    
    func addAnimation() {
        guard !animate else { return }
            withAnimation(
                Animation
                    .easeInOut(duration: 1.5)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    
}
