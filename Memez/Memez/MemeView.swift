//
//  MemeView.swift
//  Memez
//
//  Created by Ryan Lee on 7/19/24.
//

import SwiftUI

struct MemeView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var memes: [Meme]
    
    var body: some View {
        
        VStack {
            Spacer()
            TabView {
                ForEach(memes) { meme in
                    VStack {
                        MemeCardView(meme: meme)
                    }
                }
            }
            .tabViewStyle(.page)
            .padding()

            Spacer()
            
            Button("back") {
                dismiss()
            }
            .font(.largeTitle)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MemeView(memes: [Meme(image: "asianman", caption: "memeone"),
                     Meme(image: "baby", caption: "memetwo"),
                     Meme(image: "mj", caption: "Hello"),
                     Meme(image: "jesus", caption: "Hello")])
}
