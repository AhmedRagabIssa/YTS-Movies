//
//  ViewController.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/21/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit
import Kingfisher


class ListMoviesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    

    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    var movies: [Movie] = [Movie]()
    
    var nextPageNumber: Int = 1
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var tableViewIsForSearch: Bool = false { // this is for determine whether the table view currently display search result or just list movies
        didSet{
            nextPageNumber = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfiguration()
        
        loadMovies()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MoviesTableViewCell
        cell.movieTitle.text = movies[indexPath.row].title
        cell.movieRating.text = "⭐️  \(movies[indexPath.row].rate ?? 0) / 10"
        cell.movieGenres.text = movies[indexPath.row].genres.joined(separator: ", ")
        let imgURL = URL(string: movies[indexPath.row].imgURL!)
        let recource = ImageResource(downloadURL: imgURL!)
        cell.movieImage.kf.setImage(with: recource)
        return cell
    }
    
    // this func is for loading more movies at the end of the table view
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.movies.count - 1 == indexPath.row {
            if !tableViewIsForSearch { // make sure that the table currently is for listing moves and not for displaying the search result
                loadMovies()
            }
        }
    }
    
    // this is when the search button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let queryTerm = searchBar.text, queryTerm.trimmingCharacters(in: [" "]) != ""{
            
            // empty the movies array
            self.movies.removeAll(keepingCapacity: false)
            
            // mark the table view for displaying search result
            tableViewIsForSearch = true
            
            searchMovies(query: queryTerm)
            
            searchBar.showsCancelButton = true
        }
        // hide the keyboard
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // empty the movies array
        self.movies.removeAll(keepingCapacity: false)
        
        // mark the table view for displaying list of movies and not for search
        tableViewIsForSearch = false
        
        loadMovies()
        
        // hide the cancel button because if the user clicked it again the data will reloaded with no need for that
        searchBar.showsCancelButton = false
        
        // hide the keyboard
        self.view.endEditing(true)
        searchBar.text = ""
    }
    
    // this is for hiding the keyboard when the user scroll down to the table view
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    

    /**
     This method is for initializing all the view components and configure it
     */
    func initConfiguration(){
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        movieSearchBar.delegate = self
        
        // activity indecator init configuration
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        
    }
    
    func loadMovies(){
        
        // start the activity indicator and disable the user interaction events
        startActivityIndicator()
        
        let moviesOperations = MovieServices()
        
        moviesOperations.listMovies(page: nextPageNumber, complation: {(movies, error) in
            if let err = error{
                print(err.localizedDescription)
            } else {
                self.movies.append(contentsOf: movies!)
                self.moviesTableView.reloadData()
                
                // For pagination: increment the number of page to be loaded next
                self.nextPageNumber+=1
                
                // stop the activity indicator and enable the user interaction events
                self.stopActivityIndicator()
            }
        })
    }
    
    func searchMovies(query: String){
        // start the activity indicator and disable the user interaction events
        startActivityIndicator()

        let moviesOperations = MovieServices()
        
        moviesOperations.searchMovies(page: nextPageNumber, query: query, complation: {(movies, error) in
            if let err = error{
                print(err.localizedDescription)
            } else {
                self.movies.append(contentsOf: movies!)
                self.moviesTableView.reloadData()
                
                // stop the activity indicator and enable the user interaction events
                self.stopActivityIndicator()
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieMoreDetails"{
            let movieDetailsViewController: MovieDetailsViewController = segue.destination as! MovieDetailsViewController
            
            if let movieIndex = moviesTableView.indexPathForSelectedRow?.row {
                if let movieId = movies[movieIndex].id{
                    movieDetailsViewController.movieId = movieId
                }
            }
        }
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
    
}