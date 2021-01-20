//
//  Movies.swift
//  APIRequests
//
//  Created by Arturas Milius on 2021-01-20.
//

import SwiftUI

struct Movies: View {
    @ObservedObject var api = API()
    var body: some View {
        ForEach(api.movies) { movie in
            Text(movie.imdbRating)
        }
    }
}

struct Movies_Previews: PreviewProvider {
    static var previews: some View {
        Movies()
    }
}
