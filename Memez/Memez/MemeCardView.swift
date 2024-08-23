//
//  MemeCardView.swift
//  Memez
//
//  Created by Ryan Lee on 7/19/24.
//

import SwiftUI

struct MemeCardView: View {
    
    var meme: Meme
    
    var body: some View {
        ZStack {
            Image(meme.image)
                .resizable()
                .aspectRatio(1.0, contentMode: .fit)
            VStack {
                
                Text(meme.localizedCaption)
                    .font(.custom("Impact", size: 20))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5, x: 2, y: 2)
                    .padding()
                
                Spacer()
                    .frame(height: 260)
            }
        }
        .cornerRadius(15)
    }
}

struct MemeCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MemeCardView(meme: Meme(image: "asianman", caption: "memefour"))
                .environment(\.locale, .init(identifier: "ko"))
            MemeCardView(meme: Meme(image: "asianman", caption: "memefive"))
                .environment(\.locale, .init(identifier: "en"))
        }
        .environmentObject(Generator())
    }
}
