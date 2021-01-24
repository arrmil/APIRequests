//
//  ContentView.swift
//  APIRequests
//
//  Created by Arturas Milius on 2021-01-16.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var api = API()
    @State private var date = Date()
    var body: some View {
        NavigationView {
            DatePicker("Pasirinkite diena", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .background(Color.red)
                .cornerRadius(5.0)
                .padding(.bottom)
//            VStack {
//                ForEach(api.movies.sorted(by: { $0.imdbRating > $1.imdbRating }), id: \.self) { movie in
//                    if(movie.Title != "") {
//                        HStack {
//                            Text(movie.Title)
//                            Spacer()
//                            Text(movie.imdbRating)
//                        }
//                    }
//                }
//            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
