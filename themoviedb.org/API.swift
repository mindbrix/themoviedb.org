//
//  API.swift
//  themoviedb.org
//
//  Created by Nigel Barber on 05/10/2018.
//  Copyright © 2018 Nigel Barber. All rights reserved.
//

import Foundation

struct API {
    // No concerns about sharing this
    static let api_key = "e3efd8f6c608c73380b1e2d127fa78b5"
    
    // Hard-coded due to time. Should GET from /configuration
    static let image_base_url = "https://image.tmdb.org/t/p/w154"
    
    static let base_url = "https://api.themoviedb.org/3"
    
    // Concentrate all URL creation in one location
    // Could extend URL to provide these once a clear pattern to the API is understood
    static func imageURL(_ path: String) -> URL? {
        return URL(string:image_base_url + path)
    }
    
    static func getDetails(id: Int, completion: @escaping ([Movie]) -> Void) {
        if let url = URL(string: base_url + "/\(id)?api_key=\(api_key)&language=en-US&page=1") {
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, _ in
                var results: [Movie] = []
                if let data = data {
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let movie = Movie(json: json!) {
                            results.append(movie)
                        }
                    }
                }
                DispatchQueue.main.async {
                    completion(results)
                }
            }.resume()
        }
    }
    
    static func getNowPlaying(completion: @escaping ([Movie]) -> Void) {
        if let url = URL(string: base_url + "/movie/now_playing?api_key=\(api_key)&language=en-US&page=1") {
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
