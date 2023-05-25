//
//  ContentView.swift
//  ElasticToggle
//
//  Created by Raul on 25.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var switchScale = false
    @State private var switchOn = false
    
    // Constants for better code clarity and maintainability
    private let backgroundColourOn = Color(red: 0.1676135361, green: 0.368272543, blue: 1)
    private let backgroundColourOff = Color(red: 0.8231937289, green: 0.8392469287, blue: 0.9402464032)
    private let toggleSize = CGSize(width: 90, height: 50)
    private let circleSize = CGSize(width: 40, height: 40)
    private let shadowDescriptor = (color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
    private let offsetDistance: CGFloat = 20

    var body: some View {
        ZStack{
            Color.white.opacity(0.97)

            ZStack{
                Capsule()
                    .fill(switchOn ? backgroundColourOn : backgroundColourOff)
                    .frame(width: toggleSize.width, height: toggleSize.height)

                Circle()
                    .fill(Color.white)
                    .frame(width: circleSize.width, height: circleSize.height)
                    .shadow(color: shadowDescriptor.color, radius: CGFloat(shadowDescriptor.radius), x: CGFloat(shadowDescriptor.x), y: CGFloat(shadowDescriptor.y))
                    .scaleEffect(x: switchScale ? 1.4 : 1, anchor: switchOn ? .trailing : .leading)
                    .offset(x: switchOn ? offsetDistance : -offsetDistance)
            }
            .scaleEffect(switchScale ? 0.95 : 1)
            .onTapGesture {
                switchWithAnimation()
            }
        }.ignoresSafeArea(.all)
    }
    
    private func switchWithAnimation() {
        withAnimation(.easeIn(duration: 0.1)) {
            switchScale.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                withAnimation(Animation.spring()) {
                    switchScale.toggle()
                    switchOn.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
