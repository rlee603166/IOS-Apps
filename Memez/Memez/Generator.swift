//
//  Generator.swift
//  Memez
//
//  Created by Ryan Lee on 7/19/24.
//

import Foundation


class Generator: ObservableObject {
    
    @Published var count = -5
    @Published var currImage: String
    @Published var currCaption: String
    @Published var memes: [Meme]
    
    let imgs = [
        "jesus",
        "asianman",
        "baby",
        "keynpeele",
        "spiderman",
        "shrek",
        "mj",
        "homer"
    ]
    
    let captions = [
        "memeone",
        "memetwo",
        "memethree",
        "memefour",
        "memefive",
        "memesix",
        "memeseven",
        "memeeight"
    ]
    
    init(currImage: String="", currCaption: String="") {
        self.currImage = currImage
        self.currCaption = currCaption
        self.memes = []
    }
    
    func generate() {
        var newMemes: [Meme] = []

        for _ in 1...5 {
            let meme = Meme(image: imgs.randomElement() ?? "", caption: captions.randomElement() ?? "")
            newMemes.append(meme)
            count+=1
        }
        
        memes = newMemes
    }
}

struct Meme: Identifiable {
    var id = UUID()
    var image: String
    var caption: String
    
    var localizedCaption: String {
        NSLocalizedString(caption, comment: "Caption for meme")
    }
}
