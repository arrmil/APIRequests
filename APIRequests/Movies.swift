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
    @State private var date = Date()
    @State private var selectedDateText: String = "Date"
    
    private var selectedDate: Binding<Date> {
      Binding<Date>(get: { self.date}, set : {
          self.date = $0
          self.setDateString()
      })
    }
    
    private func setDateString() {
      let formatter = DateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"

      self.selectedDateText = formatter.string(from: self.date)
    }
    
    var closedRange: ClosedRange<Date> {
        let zeroDays = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let sevenDays = Calendar.current.date(byAdding: .day, value: 7, to: Date())!
        
        return zeroDays...sevenDays
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Pasirinkite diena")
                        DatePicker("Pasirinkite diena", selection: selectedDate, in: closedRange, displayedComponents: .date)
                            .labelsHidden()
                            .background(Color.red)
                            .cornerRadius(5.0)
                            .padding(.bottom)
                            .onChange(of: selectedDateText, perform: { value in
                                api.requestProgram(Date: value)
                            })
                    Text("Pasirinkta diena: \(selectedDateText)")
                }
                ForEach(api.movies.sorted(by: { $0.imdbRating > $1.imdbRating }), id: \.self) { movie in
                    if(movie.Title != "" && movie.imdbRating != "N/A") {
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
