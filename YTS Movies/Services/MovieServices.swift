//
//  File.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/21/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieServices {
    private let serviceManager = ServiceManager()
    
    func listMovies(page: Int, complation: @escaping (_ response: ListMovieResponse?, _ Error: ErrorHandler?) -> Void){
        let request = ListMoviesRequest(page)
        serviceManager.RequestService(request){ (response, error) in
            if let err = error { // that means there is error in the request
                print("their is error in the list movies service")
                print(err)
                complation(nil, ErrorHandler(err.localizedDescription))
            } else { // that means sucessful request almost with response
                let json = JSON(response!)
                let movieResponse = ListMovieResponse(json)
                
                if movieResponse.status == "ok"{
//                    print("-------")
//                    print(movieResponse.data)
//                    print("-------")
                    complation(movieResponse, nil)
                } else {
                    complation(nil, ErrorHandler("error in the list movies 1"))
                }
            }
        }
    }
    
    
    func searchMovies(page: Int,query: String, complation: @escaping (_ response: ListMovieResponse?, _ Error: ErrorHandler?) -> Void){
        let request = SearchMoviesRequest(pageNumber: page, query: query)
        
        serviceManager.RequestService(request){ (response, error) in
            if let err = error { // that means there is error in the request
                print("their is error in the list movies service")
                print(err)
                complation(nil, ErrorHandler(err.localizedDescription))
            } else { // that means sucessful request almost with response
                let json = JSON(response!)
                let movieResponse = ListMovieResponse(json)
                
                if movieResponse.status == "ok"{
                    //                    print("-------")
                    //                    print(movieResponse.data)
                    //                    print("-------")
                    complation(movieResponse, nil)
                } else {
                    complation(nil, ErrorHandler("error in the search movies 1"))
                }
            }
        }
    }
    
    func movieDetails(movieId: Int, complation: @escaping (_ response: MovieDetails?, _ Error: ErrorHandler?) -> Void){
        let request = MovieDetailsRequest(movieId)
        
        serviceManager.RequestService(request) { (response, error) in
            if let err = error { // that means there is error in the request
                print("their is error in the movie details request")
                print(err)
                complation(nil, ErrorHandler(err.localizedDescription))
            } else { // that means sucessful request almost with response
                let json = JSON(response!)
                let movieDetailsResponse = MovieDetailsResponse(json)
                
                if movieDetailsResponse.status == "ok" {
//                    print("***********")
//                    print(movieDetailsResponse.data)
//                    print("***********")
                    complation(movieDetailsResponse.data, nil)
                } else {
                    complation(nil, ErrorHandler("error in the movie details 1"))
                }
            }
        }  
    }
}
















