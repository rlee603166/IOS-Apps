//
//  ProfileView.swift
//  CineMate
//
//  Created by Ryan Lee on 8/9/24.
//

import SwiftUI

struct ProfileView: View {
    
    @AppStorage("largeFont") var largeFont = false
    @AppStorage("boldFont") var boldFont = false
    @AppStorage("inlineNotes") var inlineNotes = true
    
    @State private var numberOfColumns: Int = 2
    @State var uiImage: UIImage?
    @State private var isActionSheetShown = false
    
    var movies: [Movie]
    
    let imageURL: String = "https://image.tmdb.org/t/p/w500"
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: numberOfColumns)
        
        NavigationStack {
            VStack {
                VStack(spacing: 5) {
                    HStack {
                        Spacer()
                        Button {
                            isActionSheetShown.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.below.square.filled.and.square")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(.accent)
                                .padding(.horizontal)
                        }
                        .actionSheet(isPresented: $isActionSheetShown, content: {
                            ActionSheet(title: Text("Select number of columns"),
                                        message: Text("Something"),
                                        buttons: [
                                            .default(Text("1 Column")) { numberOfColumns = 1 },
                                            .default(Text("2 Columns")) { numberOfColumns = 2 },
                                            .default(Text("3 Columns")) { numberOfColumns = 3 },
                                            .cancel()
                                        ]
                            )
                        })
                        
                    }
                    VStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .foregroundColor(.accent)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75)
                            .padding()
                    }
                    Text("Profile likes:")
                }
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(movies, id: \.self) { movie in
                            NavigationLink(destination: AboutView(movie: movie)) {
                                ZStack {
                                    PosterView(movie: movie)
                                        .frame(width: UIScreen.main.bounds.width / (CGFloat(numberOfColumns)))
                                    
                                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]),
                                                   startPoint: .bottom, endPoint: .top)
                                    VStack {
                                        Spacer()
                                        Text(movie.originalTitle)
                                            .font(largeFont ? .body : .subheadline)
                                            .fontWeight(boldFont ? /*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/ : nil)
                                            .foregroundColor(.accent)
                                            .padding()
                                        if inlineNotes {
                                            Text(movie.overview)
                                                .font(largeFont ? .body : .subheadline)
                                                .frame(height: 50)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                    }
                }
            }
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
}

#Preview {
    ProfileView(movies: QueueManager().mock_data)
}
