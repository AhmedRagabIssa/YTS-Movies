//
//  Movie.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/21/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import Foundation

struct Movie {
    var id: Int?
    var imgURL: String?
    var title: String?
    var rate: Float?
    var genres: [String] = []
}
