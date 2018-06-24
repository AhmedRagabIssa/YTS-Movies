//
//  ServiceManager.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/21/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ReachabilitySwift


class ServiceManager: NSObject {

    private let reachability = Reachability()!
    
    func RequestService(_ request: Request, withComplation complation: @escaping (_ response: Any?, _ error: Error?) -> Void){
        
        guard reachability.isReachable else{
            print("No Internet Connection")
            return
        }
        
         Alamofire.request(request.url, method: request.method, parameters: request.parameters, encoding: (request.method == .post ? JSONEncoding.default : URLEncoding.methodDependent ), headers: request.headers).validate().responseJSON { (response) in
            

            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print(json)
                complation(json, nil)
                
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                print("\n\n===========================")
                complation(nil,error)
                break
            }
        }
    }
}

class ErrorHandler: Error{
    private var error: String
    var localizedDescription: String{
        return error
    }
    
    init(_ message: String){
        self.error = message
    }
}







