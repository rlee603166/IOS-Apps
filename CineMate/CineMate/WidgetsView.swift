//
//  WidgetsView.swift
//  CineMate
//
//  Created by Ryan Lee on 8/9/24.
//

import SwiftUI

struct RatingView: View {
    
    let rating: RatingType
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack(alignment: .leading) {
                
                LinearGradient(gradient: Gradient(colors: rating.colors()),
                               startPoint: .leading, endPoint: .trailing)
            }
            .frame(height: 8)
            .cornerRadius(4)
            
            RoundedRectangle(cornerSize: CGSize(width: 4, height: 4))
                .frame(width: 8, height: 16)
                .foregroundColor(rating.color())
                .shadow(radius: 4)
                .offset(x: geo.size.width * rating.position() - 4)
                .animation(.easeInOut, value: rating.rawValue)
        }
        .frame(height: 16)
    }
    
}

struct EmojiView: View {
    
    @EnvironmentObject private var queueManager: QueueManager
    let movie: Movie
    let opinion: PopularityType
    
    var body: some View {
        
        VStack(spacing: 5)  {
            ZStack {
                Circle()
                    .foregroundColor(opinion.color())
                    .frame(width: 75)
                Text(opinion.description())
                    .font(.system(size: 50))
            }
            .animation(.spring, value:
                        movie.originalTitle == queueManager.movies.first?.originalTitle)
            
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.accent)
                    .frame(width: 110, height: 24)
                Text("Sentiment")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                    .fontWeight(.heavy)
                    .offset(CGSize(width: -2, height: 0))
            }
        }
    }
}
#Preview {
    RatingView(rating: RatingType(rawValue: 1))
}

#Preview {
    EmojiView(movie: QueueManager().mock_data[0], opinion: PopularityType(rawValue: 1))
        .environmentObject(QueueManager())
}
