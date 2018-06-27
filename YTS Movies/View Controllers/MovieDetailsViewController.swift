//
//  MovieDetailsViewController.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/22/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    // cast table hight outlet
    @IBOutlet weak var movieCastTableViewHeightContrains: NSLayoutConstraint!
    
    // the movie id that passed from the listMoviesViewController
    var movieId: Int?
    
    var movieDetails: MovieDetails!
    
    var movieImagesResourcesArray = [ImageResource]()
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    let imageNotFound: String = "https://www.mearto.com/assets/no-image-83a2b680abc7af87cfff7777d0756fadb9f9aecd5ebda5d34f8139668e0fc842.png"
    
    // the view outlets
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieDownloadsCount: UILabel!
    @IBOutlet weak var movieLikesCount: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieFullDescription: UILabel!
    @IBOutlet weak var movieCastTableView: UITableView!
    @IBOutlet weak var movieURL: UILabel!
    @IBOutlet weak var movieImagesScrollView: UIScrollView!
    @IBOutlet weak var movieCastLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfig()
        
        loadMovieDetails()
    }
    
    // this func is for start the activity indicator and disable the user interaction events
    func startActivityIndicator(){
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    // this func is for stop the activity indicator and enable the user interaction events
    func stopActivityIndicator(){
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }

    // this func is for loading the movie details from the API using the given movie id
    func loadMovieDetails(){
        // start the activity indicator and disable the user interaction events
        startActivityIndicator()
        
        let moviesOperations = MovieServices()
        
        moviesOperations.movieDetails(movieId: movieId ?? 0, complation: {(movieDetails, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                self.movieDetails = movieDetails
                
                // load the movie images
                self.loadMovieImages()
                
                // update the view using the retrived data
                self.displayDataInTheView()
                
                // stop the activity indicator and enable the user interaction events
                self.stopActivityIndicator()
            }
        })
    }
    
    func loadMovieImages(){
        for imageURL in self.movieDetails.imagesURLs{
            let resource = ImageResource(downloadURL: URL(string: imageURL)!)
            self.movieImagesResourcesArray.append(resource)
        }
    }
    
    // this func is for the init configuration
    func initConfig(){
        // cast table view init configuration
        movieCastTableView.delegate = self
        movieCastTableView.dataSource = self
        
        // activity indecator init configuration
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        
        // this geseture for openning the URL when tap on the URL link
        let movieURLTapGesture = UITapGestureRecognizer(target: self, action: #selector(MovieDetailsViewController.uRLTapGesture))
        
        // add the the gesture for open the URL when tap on it
        movieURL.isUserInteractionEnabled = true
        movieURL.addGestureRecognizer(movieURLTapGesture)
        
        // configure the navigation bar share button
        let navBarShareButton = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(shareMovie))
        self.navigationItem.rightBarButtonItem = navBarShareButton
    }
    
    // this is the action for the navigation bar share button
    @objc func shareMovie(){
        
        
        
        let shareActivityViewController = UIActivityViewController(activityItems: ["I recommend this movie to you" , "\"\(self.movieDetails.title ?? "")\"", self.movieDetails.movieURL ?? ""], applicationActivities: nil)
        shareActivityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(shareActivityViewController, animated: true, completion: nil)
    }
    
    // this func is for openning the URL when tap on the URL link
    @objc func uRLTapGesture(){
        if let url = URL(string: movieURL.text ?? ""){
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    // this func is for showing the data in the view
    func displayDataInTheView(){
        self.title = movieDetails.title
        self.movieYear.text = "\(movieDetails.year ?? 2000)"
        self.movieGenres.text = movieDetails.genres.joined(separator: ", ")
        self.movieDownloadsCount.text = "\(movieDetails.downloadsCount ?? 0)"
        self.movieLikesCount.text = "\(movieDetails.likesCount ?? 0)"
        self.movieRate.text = "\(movieDetails.rate ?? 0)"
        self.movieLanguage.text = movieDetails.language
        self.movieFullDescription.text = movieDetails.fullDescription
        self.movieURL.text = movieDetails.movieURL
        
        // display the movie photos on the scroll view
        addMovieImagesToTheScrollView()
        
        loadCastIntoTheTableView()
//        print(movieDetails.cast)
    }
    
    func addMovieImagesToTheScrollView(){
        
        for i in 0..<self.movieImagesResourcesArray.count{
            let imageView = UIImageView()
            imageView.kf.setImage(with: movieImagesResourcesArray[i])
            imageView.contentMode = .scaleAspectFit
            let xPosition = self.movieImagesScrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: self.movieImagesScrollView.frame.width, height: self.movieImagesScrollView.frame.height)
            
            self.movieImagesScrollView.contentSize.width = self.movieImagesScrollView.frame.width * CGFloat(i + 1)
            self.movieImagesScrollView.addSubview(imageView)
        }
    }
    
    
    // this method is for loading the cast into the table view
    func loadCastIntoTheTableView(){
        self.movieCastTableView.reloadData()
        if let castCount = self.movieDetails.cast?.count{
            self.movieCastTableViewHeightContrains.constant = CGFloat(castCount * 90)
            
            //  if there is no cast display a message "Not available"
            if(castCount <= 0){
                self.movieCastLbl.text = "Cast: not available."
            }
        }
    }
    
    
    // this is for the table of Cast
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  self.movieDetails != nil{
            return self.movieDetails.cast!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.movieCastTableView.dequeueReusableCell(withIdentifier: "ActorCell") as! ActorTableViewCell
        
        // configure the cell with the model (Actor object)
        cell.configure(with: self.movieDetails.cast![indexPath.row])
        
        return cell
    }
}
