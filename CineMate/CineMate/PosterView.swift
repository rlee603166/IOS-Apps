//
//  PosterView.swift
//  CineMate
//
//  Created by Ryan Lee on 8/9/24.
//

import SwiftUI

struct PosterView: View {
    
    @State var uiImage: UIImage?
    let imageURL: String = "https://image.tmdb.org/t/p/w500"
    let movie: Movie
    
    var body: some View {
        
        ZStack {
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            } else {
                Image("practice1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            loadImage(posterPath: movie.posterPath ?? "")
        }
        .scaledToFit()
    }
    func loadImage(posterPath: String) {
        if let url = URL(string: "\(imageURL)\(posterPath)") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.uiImage = image
                    }
                }
            }
        }
    }
}


struct Poster_Previews: PreviewProvider {
    static var previews: some View {
        let queueManager = QueueManager()
        PosterView(movie: queueManager.movies.first ?? queueManager.mock_data[0])
    }
}
