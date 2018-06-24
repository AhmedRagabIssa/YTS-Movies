//
//  MovieDetailsRequest.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/22/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation
import Alamofire

class MovieDetailsRequest: Request{
    
    private var movieId: Int!
    
    init(_ movieId: Int){
        self.movieId = movieId
    }
    
    override var url: String {
        return super.url + "movie_details.json"
    }
    
    override var parameters: Parameters{
        if let movieId = self.movieId {
            let parms: Parameters = ["movie_id": movieId, "with_images" : "true", "with_cast" : "true" ]
            return parms
        }
        return [:]
    }
    
    override var method: HTTPMethod{
        return .get
    }

}
