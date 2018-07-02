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
   
    private var page: Int
    
    private var query: String = "0"
    private var genre: String = "all"
    private var rate: Int = 0
    private var quality: String = "All"
    private var sortBy: String = "date_added"
    private var orderBy: String = "desc"
    
    init(_ page: Int){
        self.page = page
    }
    
    init(_ page: Int, query: String){
        self.page = page
        self.query = query
    }
    
    init(_ page: Int, query: String, genre: String, rate: Int, quality: String, sortBy: String, orderBy: String){
        self.page = page
        self.query = query
        self.genre = genre
        self.rate = rate
        self.quality = quality
        self.sortBy = sortBy
        self.orderBy = orderBy
    }
    
    override var url: String {
        return super.url + "list_movies.json"
    }
    
    override var parameters: Parameters{
        let parms: Parameters = ["page": page, "query_term" : query, "genre" : genre, "minimum_rating" : rate, "quality" : quality, "sort_by" : sortBy, "order_by" : orderBy]
//        let parms: Parameters = ["page": page, "query_term" : query]
        return parms
    }
    
    override var method: HTTPMethod{
        return .get
    }
}
