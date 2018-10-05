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
    let belongs_to_collection: Any? // Currently all now_playing movies return nil for this field, so I am unable to progress here
    let poster_url: URL
    let title: String
    let overview: String
    let release_date: Date
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int else { return nil }
        guard let title = json["title"] as? String else { return nil }
        guard let poster_path = json["poster_path"] as? String else { return nil }
        guard let poster_url = API.imageURL(poster_path) else { return nil }
        guard let overview = json["overview"] as? String else { return nil }
        guard let release_date_string = json["release_date"] as? String else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let release_date = dateFormatter.date(from: release_date_string) else { return nil }
        
        self.id = id
        self.belongs_to_collection = json["belongs_to_collection"]
        self.title = title
        self.poster_url = poster_url
        self.overview = overview
        self.release_date = release_date
    }
}
