//
//  Data.swift
//  APIRequests
//
//  Created by Arturas Milius on 2021-01-16.
//

import SwiftUI

struct Channel: Codable, Identifiable {
    let id = UUID()
    var nextDate: String
    var previousDate: String
    
    var schedule: Schedule
}

struct Schedule: Codable {
    var dayName: String
    var date: String
    var programme: [Programme]
}

struct Programme: Codable, Hashable, Identifiable {
    let id = UUID()
    var title: String
    var title_original: String
    var year: Int
}

struct MovieDetails: Codable, Hashable {
//    let id = UUID()
    var Title: String
    var imdbRating: String
}


class API: ObservableObject {
    
    @Published var programme = [Programme]()
    @Published var movies = [MovieDetails]()
    
    init() {
        requestProgram()
    }
    
    func requestProgram() {
        guard let url = URL(string: "https://www.tv24.lt/programme/listing/none/18-01-2021?filter=channel&subslug=tv3-2") else {
            print("URL NOT FOUND")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let channel = try!JSONDecoder().decode(Channel.self, from: data!)
            DispatchQueue.main.async {
                self.programme = channel.schedule.programme
                self.requestMovieRating()
            }
        }
        .resume()
    }
    
//    func requestMovieRating() {
//        let testmovie = self.programme[0].title_original
//        let testyear = self.programme[0].year
//        let url = "https://www.omdbapi.com/?apikey=1ecc14c6&t=\(testmovie)&y=\(testyear)"
//        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//        guard let urlEndPoint = URL(string: urlString!) else {
//            print("MOVIE URL NOT FOUND")
//            return
//        }
//
//        URLSession.shared.dataTask(with: urlEndPoint) { (data, _, _) in
//            if let data = data {
//                let movieDetails = try!JSONDecoder().decode(MovieDetails.self, from: data)
//                DispatchQueue.main.async {
//                    self.movies.append(movieDetails)
//                }
//            }
//        }
//        .resume()
//    }
//}

    func requestMovieRating() {
        for program in self.programme {
            let url = "https://www.omdbapi.com/?apikey=1ecc14c6&t=\(program.title_original)&y=\(program.year)"
            let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            guard let urlEndPoint = URL(string: urlString!) else {
                print("MOVIE URL NOT FOUND")
                return
            }

            URLSession.shared.dataTask(with: urlEndPoint) { (data, _, error) in
                if let data = data {
                    let movieDetails = try?JSONDecoder().decode(MovieDetails.self, from: data)
                    DispatchQueue.main.async {
                        self.movies.append(movieDetails ?? MovieDetails.init(Title: "", imdbRating: ""))
                        let mySet = Set<MovieDetails>(self.movies)
                        self.movies = Array(mySet)
                    }
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Movie not found")")
            }
            .resume()
        }
    }
}


//KingFisher library to be able to use posters url inside Image() ?
