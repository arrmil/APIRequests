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
}


class API: ObservableObject {
    
    @Published var programme = [Programme]()
    
    init() {
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
}
//    func getChannels(completion: @escaping ([Programme]) -> ()) {
//        guard let url = URL(string: "https://www.tv24.lt/programme/listing/none/18-01-2021?filter=channel&subslug=tv3-2") else {
//            print("URL NOT FOUND")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, _, _) in
//            let channel = try!JSONDecoder().decode(Channel.self, from: data!)
//            DispatchQueue.main.async {
//                completion(channel.schedule.programme)
//            }
//        }
//        .resume()
//    }
