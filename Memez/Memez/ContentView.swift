//
//  ContentView.swift
//  Memez
//
//  Created by Ryan Lee on 7/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var generator: Generator
    @State var currMeme = [Meme]()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("showmesome")
                    .font(.largeTitle)
                    .padding()
                Spacer()
                NavigationLink {
                    MemeView(memes: currMeme)
                } label: {
                    ZStack {
                        Image("memez")
                            .resizable()
                            .frame(width: 250, height: 250)
                            .cornerRadius(15)
                            .padding()
                        
                        Text("MEMEZ!!!")
                            .font(.custom("Impact", size: 50))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 5, x: 2, y: 2)
                            .padding()
                    }
                }
                .onAppear() {
                    generator.generate()
                    currMeme = generator.memes
                }
                Spacer()
                
                Text("\(generator.count) processed", tableName: "LocalizableD")
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.locale, .init(identifier: "ko"))
            ContentView()
                .environment(\.locale, .init(identifier: "en"))
        }
        .environmentObject(Generator())
    }
}

