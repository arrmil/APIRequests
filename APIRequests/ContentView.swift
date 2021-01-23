//
//  ContentView.swift
//  APIRequests
//
//  Created by Arturas Milius on 2021-01-16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var api = API()
    var body: some View {
        NavigationView {
            VStack {
                ForEach(api.movies.sorted(by: { $0.imdbRating > $1.imdbRating }), id: \.self) { movie in
                    if(movie.Title != "") {
                        HStack {
                            Text(movie.Title)
                            Spacer()
                            Text(movie.imdbRating)
                        }
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
