//
//  ListMoviesRequest.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/21/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation
import Alamofire

class ListMoviesRequest: Request {
   
    private var page: Int!
    
    init(_ page: Int){
        self.page = page
    }
    
    override var url: String {
        return super.url + "list_movies.json"
    }
    
    override var parameters: Parameters{
        if let page = self.page {
            let parms: Parameters = ["page": page]
            return parms
        }
        return [:]
    }
    
    override var method: HTTPMethod{
        return .get
    }
}
