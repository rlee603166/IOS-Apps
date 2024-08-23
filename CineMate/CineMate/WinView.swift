//
//  WinView.swift
//  CineMate
//
//  Created by Ryan Lee on 8/9/24.


import SwiftUI

struct WinView: View {

    var end: Bool
    var height: CGFloat
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("sad")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("End of available movies...")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .shadow(radius: 15)
                .padding()
            
        }
        .offset(y: end ? 0 : -(height+40))
        .animation(.interpolatingSpring(stiffness: 200, damping: 12), value: end)
    }
}

#Preview {
    WinView(end: true, height: 240)
}
