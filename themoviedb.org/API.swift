//
//  API.swift
//  themoviedb.org
//
//  Created by Nigel Barber on 05/10/2018.
//  Copyright © 2018 Nigel Barber. All rights reserved.
//

import Foundation

struct API {
    static let api_key = "e3efd8f6c608c73380b1e2d127fa78b5"
    
    static func searchNowPlaying(completion: @escaping ([Movie]) -> Void) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(api_key)&language=en-US&page=1") {
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
                var results: [Movie] = []
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let items = json!["results"] as? [[String: Any]] {
                            results = items.compactMap { Movie(json: $0) }
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion(results)
                }
            }.resume()
        }
    }
}
