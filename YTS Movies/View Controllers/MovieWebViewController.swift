//
//  MovieWebViewController.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/27/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit
import WebKit

class MovieWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var movieURL: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: self.movieURL ?? "https://yts.am/")
        let requst = URLRequest(url: url!)
        
        webView.load(requst)
    }


}
