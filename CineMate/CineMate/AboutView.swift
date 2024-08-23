//
//  AboutView.swift
//  CineMate
//
//  Created by Ryan Lee on 8/9/24.
//

import SwiftUI

struct AboutView: View {
    
    @State var uiImage: UIImage?
    let imageURL: String = "https://image.tmdb.org/t/p/w500"
    
    @AppStorage("largeFont") var largeFont = true
    @AppStorage("boldFont") var boldFont = false
    
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack {
                    if let image = uiImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 325)
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                    } else {
                        Image("practice1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 325)
                            .clipped()
                            .ignoresSafeArea(edges: .top)
                    }
                }
                .onAppear {
                    loadImage(posterPath: movie.posterPath ?? "")
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .center) {
                        Text(movie.originalTitle)
                            .font(largeFont ? .largeTitle : .headline)
                            .fontWeight(.heavy)
                        
                        ZStack {
                            Image(systemName: "seal.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                                .foregroundColor(.accent)
                            Text(movie.originalLanguage.uppercased())
                                .font(.system(size: 12))
                        }
                    }
                    .padding(.bottom, 10)
                    HStack {
                        Image(systemName: "video.fill")
                            .foregroundColor(.accent)
                        Text("Release Date: \(movie.releaseDate)")
                            .font(largeFont ? .title3 : .subheadline)
                            .fontWeight(boldFont ? /*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/ : nil)
                    }
                    .fontWeight(boldFont ? /*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/ : nil)
                    HStack {
                        Image(systemName: "heart")
                            .foregroundColor(.accent)
                        Text("Ratings: \(movie.voteAverage)")
                            .font(largeFont ? .title3 : .subheadline)
                            .fontWeight(boldFont ? /*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/ : nil)
                    }
                    HStack {
                        Image(systemName: "flame")
                            .foregroundColor(.accent)
                        Text("Popularity: \(movie.popularity)")
                            .font(largeFont ? .title3 : .subheadline)
                            .fontWeight(boldFont ? /*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/ : nil)
                    }
                    VStack {
                        Text("Overview:")
                            .font(largeFont ? .title3 : .subheadline)
                            .fontWeight(boldFont ? /*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/ : nil)
                        Text(movie.overview)
                            .font(largeFont ? .title3 : .subheadline)
                            .fontWeight(boldFont ? /*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/ : nil)
                    }
                }
                .padding()
            }
        }
        
        .edgesIgnoringSafeArea(.top)
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

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        let queueManager = QueueManager()
        AboutView(movie: queueManager.movies.first ?? queueManager.mock_data[0])
    }
}
