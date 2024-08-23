//
//  MovieModel.swift
//  CineMate
//
//  Created by Ryan Lee on 8/7/24.
//

import Foundation

class MovieModel: ObservableObject {
    @Published var likedMovies: [Movie] = []
    
}
