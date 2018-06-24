//
//  File.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/22/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation

struct MovieDetails {
    var id: Int?
    var imagesURLs: [String] = []
    var title: String?
    var rate: Float?
    var genres: [String] = []
    var year: Int?
    var downloadsCount: Int?
    var likesCount: Int?
    var runTime: Int?
    var fullDescription: String?
    var movieURL: String?
    var language: String?
    
    
    var cast: [Actor]? = []
}
