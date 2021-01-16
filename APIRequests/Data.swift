//
//  Data.swift
//  APIRequests
//
//  Created by Arturas Milius on 2021-01-16.
//

import SwiftUI

struct User: Codable,Identifiable {
    let id = UUID()
    var name: String
    var email: String
}


class API {
    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let users = try!JSONDecoder().decode([User].self, from: data!)
            print(users)
        }
        .resume()
    }
}
