//
//  MovieDetailsResponse.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/22/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieDetailsResponse {
    var status: String!
    var statusMessage: String!
    var data: MovieDetails!
    
    
    init(_ json: JSON) {
        status = json["status"].stringValue
        statusMessage = json["status_message"].stringValue
        if json["data"] != JSON.null {
            
            let movieDetails = json["data"]["movie"]
            
            // load images into array
            var movieImages: [String] = [String]()
            movieImages.append(movieDetails["medium_cover_image"].stringValue)
            movieImages.append(movieDetails["medium_screenshot_image1"].stringValue)
            movieImages.append(movieDetails["medium_screenshot_image2"].stringValue)
            movieImages.append(movieDetails["medium_screenshot_image3"].stringValue)
            movieImages.append(movieDetails["background_image"].stringValue)
            
            // load the genres into array
            let genresJson = movieDetails["genres"].arrayValue
            var genres: [String] = [String]()
            for genre in genresJson {
                genres.append(genre.stringValue)
            }
            
                        
            // load actors into array
            let cast = movieDetails["cast"].arrayValue
            var actors: [Actor] = [Actor]()
            for actor in cast {
                let actorObject: Actor = Actor(name: actor["name"].stringValue, characterName: actor["character_name"].stringValue, imgURL: actor["url_small_image"].string ?? "https://www.mearto.com/assets/no-image-83a2b680abc7af87cfff7777d0756fadb9f9aecd5ebda5d34f8139668e0fc842.png")
                actors.append(actorObject)
            }
            
            
            
            let movieDetailObject = MovieDetails(id: movieDetails["id"].intValue, imagesURLs: movieImages, title: movieDetails["title_english"].stringValue, rate: movieDetails["rating"].floatValue, genres: genres, year: movieDetails["year"].intValue, downloadsCount: movieDetails["download_count"].intValue, likesCount: movieDetails["like_count"].intValue, runTime: movieDetails["runtime"].intValue, fullDescription: movieDetails["description_full"].stringValue, movieURL: movieDetails["url"].stringValue, language: movieDetails["language"].stringValue, cast: actors)
            
            self.data = movieDetailObject
            
        }
    }
}
