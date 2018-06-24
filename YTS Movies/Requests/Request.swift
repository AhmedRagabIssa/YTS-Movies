//
//  Request.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/21/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation
import Alamofire

class Request{
    
    var url: String {
        return "https://yts.am/api/v2/"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    var parameters: Parameters {
        return[:]
    }
}
