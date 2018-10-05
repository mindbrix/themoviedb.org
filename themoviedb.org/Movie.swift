//
//  Movie.swift
//  themoviedb.org
//
//  Created by Nigel Barber on 05/10/2018.
//  Copyright © 2018 Nigel Barber. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let poster_path: URL
    let title: String
    let overview: String
    let release_date: Date
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int else { return nil }
        guard let title = json["title"] as? String else { return nil }
        guard let poster_path = URL(string:"localhost:") else { return nil }
        guard let overview = json["overview"] as? String else { return nil }
        guard let release_date_string = json["release_date"] as? String else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let release_date = dateFormatter.date(from: release_date_string) else { return nil }
        
        self.id = id
        self.title = title
        self.poster_path = poster_path
        self.overview = overview
        self.release_date = release_date
    }
}
