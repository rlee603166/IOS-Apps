//
//  MovieHelper.swift
//  CineMate
//
//  Created by Ryan Lee on 8/8/24.
//

import Foundation

class MovieHelper: ObservableObject{
    
    @Published var baseURL = "https://api.themoviedb.org/3/movie/popular"
    let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!
    
    func fetchMovies(pageNumber: Int = 1) async throws -> Response {
        guard var components = URLComponents(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(pageNumber)")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.addValue("Bearer \(Keys.accesstoken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let movieResponse = try decoder.decode(Response.self, from: data)
        
        return movieResponse
    }
}
