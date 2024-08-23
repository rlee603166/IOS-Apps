//
//  QueueManager.swift
//  CineMate
//
//  Created by Ryan Lee on 8/7/24.
//

import Foundation
import CoreData
import SwiftUI
import UIKit

class QueueManager: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var mock_data: [Movie] = []
    @Published var swipeType: SwipeType?
    @Published var likedMovies: [Movie]?
    
    private var index: Int = 0
    private var response: Response?
    private var newMovies: [Movie] = []
    
    let movieHelper = MovieHelper()
    let imageHelper = ImageHelper()
    
    init() {

        createMockData()
        Task {
            await fetchAPI()
            movies.shuffle()
        }
    }
    
    func fetchAPI() async {
        do {
            let response = try await movieHelper.fetchMovies(pageNumber: 1)
            let results = response.results
            movies.append(contentsOf: results)

        } catch { print( error ) }
    }
    
    func removeMovie() {
        if index < movies.count {
            movies.remove(at: index)
        }
    }
    
    private func createMockData() {
        mock_data = [
            Movie(genreIds: [0], originalLanguage: "en", originalTitle: "The Avengers", overview: "overview...", popularity:  8.5, posterPath: "TheAvengers", releaseDate: "2012", voteAverage: 8.5),
            Movie(genreIds: [0], originalLanguage: "en", originalTitle: "The Matrix", overview: "overview...", popularity:  8.5, posterPath: "TheMatrix", releaseDate: "1999", voteAverage: 8.5),
            Movie(genreIds: [0], originalLanguage: "en", originalTitle: "Deadpool", overview: "overview...", popularity:  8.5, posterPath: "Deadpool", releaseDate: "2016", voteAverage: 8.5),
            Movie(genreIds: [0], originalLanguage: "en", originalTitle: "Back to the Future", overview: "overview...", popularity:  8.5, posterPath: "BTF", releaseDate: "1985", voteAverage: 8.5),
            Movie(genreIds: [0], originalLanguage: "en", originalTitle: "Rocky", overview: "overview...", popularity:  8.5, posterPath: "Rocky", releaseDate: "1976", voteAverage: 8.5),
            Movie(genreIds: [0], originalLanguage: "en", originalTitle: "The Wolf of Wall Street", overview: "overview...", popularity: 8.5, posterPath: "TWWS", releaseDate: "2013", voteAverage:8.5),
            Movie(genreIds: [0], originalLanguage: "en", originalTitle: "Rush", overview: "overview...", popularity:  8.5, posterPath: "Rush", releaseDate: "2013", voteAverage: 8.5),
            Movie(genreIds: [0], originalLanguage: "en", originalTitle: "The Imitation Game", overview: "overview...", popularity: 8.5, posterPath: "TheImitationGame", releaseDate: "2014", voteAverage:8.5)
        ]
    }
//    private func addMovie() {
//        withAnimation {
//            let newMovie = Movie(context: viewContext)
//            newMovie.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteMovie(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { movies[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

