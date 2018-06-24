//
//  SearchMoviesRequest.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/24/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation
import Alamofire

class SearchMoviesRequest: Request {
    
    private var page: Int!
    private var query: String!
    
    init(pageNumber page: Int, query: String){
        self.page = page
        self.query = query
    }
    
    override var url: String {
        return super.url + "list_movies.json"
    }
    
    override var parameters: Parameters{
        if let page = self.page, let query = self.query{
            let parms: Parameters = ["page": page, "query_term": query]
            return parms
        }
        return [:]
    }
    
    override var method: HTTPMethod{
        return .get
    }
}
