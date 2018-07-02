//
//  SearchMoviesRequest.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/24/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

/// deprcated class

//import Foundation
//import Alamofire
//
//class SearchMoviesRequest: Request {
//    
//    private var page: Int
//    private let query: String
//    
//    init(pageNumber page: Int, query: String){
//        self.page = page
//        self.query = query
//    }
//    
//    override var url: String {
//        return super.url + "list_movies.json"
//    }
//    
//    override var parameters: Parameters{
//        let parms: Parameters = ["page": page, "query_term": query]
//        return parms
//    }
//    
//    override var method: HTTPMethod{
//        return .get
//    }
//}
