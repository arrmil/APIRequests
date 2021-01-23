//
//  Movies.swift
//  APIRequests
//
//  Created by Arturas Milius on 2021-01-20.
//

import SwiftUI
import Kingfisher

struct Movies: View {
    @ObservedObject var api = API()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                ForEach(api.movies.sorted(by: { $0.imdbRating > $1.imdbRating }), id: \.self) { movie in
                    if(movie.Title != "") {
                        MovieBox(MovieTitle: movie.Title, MoviePoster: movie.Poster, MovieIMDB: movie.imdbRating)
                    }
                }
            }
            .navigationTitle("Dienos Filmai:")
            .padding()
        }
    }
}


struct MovieBox: View {
    var MovieTitle: String
    var MoviePoster: String
    var MovieIMDB: String

    var body: some View {
        ZStack {
            VStack {
                Text(MovieTitle)
                    .font(.title3)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .kerning(2)
                    .scaledToFit()
                    .padding()
                    .padding(.leading)
                HStack {
                    KFImage(URL(string: MoviePoster))
                        .resizable()
//                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .cornerRadius(5.0)
                        .background(Color.blue)
                        .padding()
                    Spacer()
                    Text(MovieIMDB)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.yellow)
                        .background(Color.green)
                        .frame(width:100, height: 100)
//                        .padding(.trailing, 40)
                }
            }
            .frame(width: 350, height: 300)
        }
        .background(Color.red)
        .cornerRadius(10.0)
    }
}

struct Movies_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}
