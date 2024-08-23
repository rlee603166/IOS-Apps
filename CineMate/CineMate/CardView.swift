//
//  CardView.swift
//  CineMate
//
//  Created by Ryan Lee on 8/7/24.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var queueManager: QueueManager
    @Binding var liked: [Movie]
    @State private var offset = CGSize.zero
    @State var uiImage: UIImage?
    let imageURL: String = "https://image.tmdb.org/t/p/w500"
    let movie: Movie

    var body: some View {
        VStack {
            ZStack {
                PosterView(movie: movie)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 1.45)
                VStack {
                    Spacer()
                        .frame(height: 10)
                    HStack {
                        Spacer()
                            .frame(width: 262)
                        EmojiView(movie: movie, opinion: PopularityType(rawValue: getPopularityType(opinion: movie.popularity)))
                    }
                    .padding()
                    Spacer()
                        .frame(height: 350)
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Ratings:")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: UIScreen.main.bounds.width - 60, height: 24)
                                .offset(CGSize(width: 0, height: -4))
                                .foregroundColor(.accent)
                            RatingView(rating: RatingType(rawValue: getRatingType(rating: movie.voteAverage)))
                                .frame(width: UIScreen.main.bounds.width - 80)
                        }
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height / 1.45)
            }
            .onReceive(queueManager.$swipeType, perform: { swipe in
                buttonSignal(swipe: swipe)
            })
            .offset(x: offset.width, y: offset.height * 0.4)
            .rotationEffect(.degrees(Double( offset.width / 40)))
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        offset = gesture.translation
                    } .onEnded { _ in
                        withAnimation(.snappy()) {
                            handleSwipe(width: offset.width)
                        }
                    }
            )
        }
                                    
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
    
    private func getPopularityType(opinion: Double) -> Int {
        if opinion < 1500 {
            return 0
        }
        else if opinion < 3000 {
            return 1
        }
        else {
            return 2
        }
    }
    private func getRatingType(rating: Double) -> Int {
        if rating < 5 {
            return 0
        }
        else if rating < 6 {
            return 1
        }
        else if rating < 7.5 {
            return 2
        }
        else if rating < 9 {
            return 3
        }
        else {
            return 4
        }
    }

    private func handleSwipe(width: CGFloat) {
        switch width {
        case -500...(-150):
            swipeLeft()
        case 150...500:
            swipeRight()
        default:
            offset = .zero
        }
    }
    
    private func swipeLeft() {
        withAnimation(.snappy) {
            offset.width = -500
        } completion: {
            queueManager.removeMovie()
        }
    }
    private func swipeRight() {
        withAnimation(.snappy) {
            offset.width = 500
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if let firstMovie = queueManager.movies.first {
                liked.append(firstMovie)
                queueManager.removeMovie()
            }
        }
    }
    
    private func buttonSignal(swipe: SwipeType?) {
        guard let swipe else {
            return
        }
        let movieCard = queueManager.movies.first
        
        if movieCard == movie {
            switch swipe {
            case .dislike:
                swipeLeft()
            case .like:
                swipeRight()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        let queueManager = QueueManager()
        CardView(liked: .constant([QueueManager().mock_data[0]]), movie: queueManager.movies.first ?? queueManager.mock_data[0])
            .environmentObject(ImageHelper())
            .environmentObject(QueueManager())
    }
}
