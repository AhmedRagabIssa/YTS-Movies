//
//  MovieWebViewController.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/27/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit
import WebKit

class MovieWebViewController: UIViewController, UIWebViewDelegate{

    @IBOutlet weak var webView: WKWebView!
    
    var movieURL: String!
    
    // this activity indecator to be showen while featching data from the internet
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initConfig()
        
        let url = URL(string: self.movieURL ?? "https://yts.am/")
        let requst = URLRequest(url: url!)
        
        webView.load(requst)
    }
    
    func initConfig(){
        // activity indecator init configuration
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        
        self.startActivityIndicator()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        activityIndicator.stopAnimating()
    }

    // this func is for start the activity indicator and disable the user interaction events
    func startActivityIndicator(){
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

}
