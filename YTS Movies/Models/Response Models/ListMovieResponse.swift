//
//  ListMovieResponse.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/21/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation
import SwiftyJSON

class ListMovieResponse {
    var status: String!
    var statusMessage: String!
    var data: [Movie] = [Movie]()
    
    init(_ json: JSON) {
        status = json["status"].stringValue
        statusMessage = json["status_message"].stringValue
        if json["data"] != JSON.null {
            if let movies = json["data"]["movies"].array {
            
                for movie in movies {
                    let genresJson = movie["genres"].arrayValue
                    var genres: [String] = [String]()
                    for genre in genresJson {
                        genres.append(genre.stringValue)
                    }
                    let movieObject = Movie(id: movie["id"].intValue, imgURL: movie["medium_cover_image"].stringValue, title: movie["title_long"].stringValue, rate: movie["rating"].floatValue, genres: genres)
                    
                    self.data.append(movieObject)
                }
            }
        }
    }
}
