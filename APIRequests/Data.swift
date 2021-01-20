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

struct MovieDetails: Codable, Identifiable, Hashable {
    let id = UUID()
    var Title: String
    var imdbRating: String
}


class API: ObservableObject {
    
    @Published var programme = [Programme]()
    @Published var movies = [MovieDetails]()
    
    init() {
        requestProgram()
        requestMovieRating()
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
            }
        }
        .resume()
    }
    
    func requestMovieRating() {
            let testmovie = self.programme[0].title_original
            let testyear = self.programme[0].year
            guard let url = URL(string: "http://www.omdbapi.com/?apikey=1ecc14c6&t=\(testmovie)&y=\(testyear)") else {
                print("MOVIE URL NOT FOUND")
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                let movieDetails = try!JSONDecoder().decode([MovieDetails].self, from: data!)
                DispatchQueue.main.async {
                    self.movies = movieDetails
                }
                
            }
            .resume()
        
        
    }
}


//KingFisher library to be able to use posters url inside Image() ?
