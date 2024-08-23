//
//  SwipeView.swift
//  CineMate
//
//  Created by Ryan Lee on 8/7/24.
//

import SwiftUI


struct SwipeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @EnvironmentObject var queueManager: QueueManager
    @Binding var liked: [Movie]
    @State private var offset = CGSize.zero
    @State private var topMovieIndex: Int = 0
    @State private var swipe: Int = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    ZStack {
                        ForEach(queueManager.movies.reversed(), id: \.self) { movie in
                            NavigationLink(destination: AboutView(movie: movie)) {
                                CardView(liked: $liked, movie: movie)
                                    .environmentObject(queueManager)
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            queueManager.swipeType = .dislike
                        }, label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.red)
                                    .frame(width: 75)
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 75)
                                    .shadow(radius: 5)
                            }
                        })
                        
                        Spacer()
                        
                        Button(action: {
                            queueManager.swipeType = .like
                        }, label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(.green)
                                    .frame(width: 75)
                                Image(systemName: "heart.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 75)
                                    .shadow(radius: 5)
                            }
                        })
                        Spacer()
                    }
                    Spacer()
                }
                WinView(end: queueManager.movies.count < 1, height: UIScreen.main.bounds.height)
            }
        }
    }
    
    
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        return SwipeView(liked: .constant([QueueManager().mock_data[0]]))
            .environmentObject(QueueManager())
    }
}
