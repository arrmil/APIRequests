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
        ForEach(api.movies) { movie in
            HStack {
                Text(movie.Title)
                Spacer()
                Text(movie.imdbRating)
            }
        }
    }
//    @ObservedObject var api = API()
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                ForEach(api.programme) { program in
//                    VStack {
//                        if(program.title_original != "") {
//                            Text(program.title_original + ": \(program.year)")
//                        }
//                    }
//                }
//            }
//        }
//    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
