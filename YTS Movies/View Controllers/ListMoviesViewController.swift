//
//  ViewController.swift
//  YTS Movies
//
//
//  Created by Ahmed Ragab Issa on 6/21/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit

// conform the FilterDataSentDelegate in order to recive the data from the FilteredSearchViewController

class ListMoviesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, FilterDataSentDelegate{
    
    // storyboard outlets
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    // the table view data source (movies)
    var movies: [Movie] = [Movie]()
    
    // MARK: - TODO refrech controller
    // this refresh controller is for reload the data from the table view again from the begining
    private var refreshController:UIRefreshControl = UIRefreshControl()
    var nextPageNumber: Int = 1

    // this activity indecator to be showen while featching data from the internet
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var tableViewIsForDisplay: ResultFrom = .list { // this is for determine whether the table view currently display (search, list, filter) movies
        didSet{
            // this is for handling pagination
            // as when the data to be displayed changed begin from the first page
            nextPageNumber = 1
        }
    }
    
    // this var is for managing pagination and loading data for next page (to stop requesting more data at the end)
    var currentResponseMoviesCount = 0
    
    // this var for storing the search query
    var searchQuery: String!
    
    // the filter parameters (for pagination on filter result)
    private var filterQuery: String = "0"
    private var filterGenre: String = "all"
    private var filterRate: Int = 0
    private var filterQuality: String = "All"
    private var filterSortBy: String = "date_added"
    private var filterOrderBy: String = "desc"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initConfiguration()
        loadMovies()
    }
    
  
    //    MARK:- TableView Delegtes
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moviesTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MoviesTableViewCell
        
        // configure the cell with the model (Movie object)
        cell.configure(with: movies[indexPath.row])
       
        return cell
    }
    
    // this func is for animate the will display cell
    // and also for for loading more movies at the end of the table view
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (self.movies.count - 1 == indexPath.row) && (self.movies.count < self.currentResponseMoviesCount) {
            if tableViewIsForDisplay == .list { // make sure that the table currently is for listing moves and not for displaying the search result
                loadMovies()
            } else if tableViewIsForDisplay == .search {
                searchMovies()
            }else if tableViewIsForDisplay == .filter {
                filterMovies()
            }
        }
        
        // MARK: - Cell animation
        
        // the init state of the cell
        cell.alpha = 0
        let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 20, 0)
        cell.layer.transform = transform
        
        // animate the cell to the final state
        UIView.animate(withDuration: 1.0) {
            cell.alpha = 1.0
            cell.layer.transform = CATransform3DIdentity
        }
    }
    
    // this is when the search button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let queryTerm = searchBar.text, queryTerm.trimmingCharacters(in: [" "]) != ""{
            
            // empty the movies array
            self.movies.removeAll(keepingCapacity: false)
            
            // mark the table view for displaying search result
            tableViewIsForDisplay = .search
            
            self.searchQuery = queryTerm
            
            searchMovies()
            
//            searchBar.showsCancelButton = true
        }
        // hide the keyboard
        self.view.endEditing(true)
        searchBar.showsCancelButton = true

    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        // empty the movies array
//        self.movies.removeAll(keepingCapacity: false)
//
//        // mark the table view for displaying list of movies and not for search
////        tableViewIsForSearch = false
//        tableViewIsForDisplay = .list
//
//        loadMovies()
//
//        // hide the cancel button because if the user clicked it again the data will reloaded with no need for that
//        searchBar.showsCancelButton = false
//
//        // hide the keyboard
//        self.view.endEditing(true)
//        searchBar.text = ""
//    }
    
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
        
        // configure the navigation bar share button
        let navBarFilterButton = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .done, target: self, action: #selector(showFilterView))
        self.navigationItem.rightBarButtonItem = navBarFilterButton
        
        let navBarRefreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTheTableView))
        self.navigationItem.leftBarButtonItem = navBarRefreshButton
        
        // MARK: - TODO
        // configure the refresh controller
        refreshController.addTarget(self, action: #selector(refreshTheTableView), for: UIControlEvents.valueChanged)
        self.moviesTableView.refreshControl = refreshController
        self.moviesTableView.addSubview(refreshController)
        
    }
    
    // MARK: - Filter action
    // this is the action handler for the navigation bar filter button
    @objc func showFilterView(){
        self.performSegue(withIdentifier: "showFilter", sender: self)
    }
    
    // MARK: - Filter delegate
    // this is for handeling the Filter delegate & apply the filter given the user data
    func userDidApplySomeFilter(query: String, genre: String, minRate: Int, quality: String, sortBy: String, orderBy: String) {
        
        // mark the table view for displaying filter result
        self.tableViewIsForDisplay = .filter
        
        // set the filter parameters
        self.filterQuery = query
        self.filterGenre = genre
        self.filterRate = minRate
        self.filterQuality = quality
        self.filterSortBy = sortBy
        self.filterOrderBy = orderBy
        
        // empty the movies array
        self.movies.removeAll(keepingCapacity: false)
        // call the filter movies service
        filterMovies()
    }
    
    
    func loadMovies(){
        
        // start the activity indicator and disable the user interaction events
        startActivityIndicator()
        
        self.navigationItem.title = "Movies List"
        
        let moviesOperations = MovieServices()
        
        moviesOperations.listMovies(page: nextPageNumber, complation: {(listMovieResponse, error) in
            if let err = error{ // error ocured
                print(err.localizedDescription)
            } else if let movies = listMovieResponse?.data { // the result featched sucessfully
                self.movies.append(contentsOf: movies)
                self.currentResponseMoviesCount = listMovieResponse?.moviesCount ?? 0
                self.moviesTableView.reloadData()
                
                // For pagination: increment the number of page to be loaded next
                self.nextPageNumber+=1
                
                // stop the activity indicator and enable the user interaction events
                self.stopActivityIndicator()
            }
        })
    }
    
    // MARK: - TODO
    // this is the action of the refresh action
    @objc func refreshTheTableView(){
        self.tableViewIsForDisplay = .list
        print("Refreshing.......")
        self.movieSearchBar.text = nil
        
        // empty the movies array
        self.movies = []
        
        self.loadMovies()
        // go to the top of the table view
//        self.moviesTableView.setContentOffset(.zero, animated: false)
//        self.moviesTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)

        self.refreshController.endRefreshing()
    }
    
    func searchMovies(){
        // start the activity indicator and disable the user interaction events
        startActivityIndicator()

        self.navigationItem.title = "Movies Search"
        
        let moviesOperations = MovieServices()
        
        moviesOperations.searchMovies(page: nextPageNumber, query: searchQuery, complation: {(listMovieResponse, error) in
            if let err = error{
                print(err.localizedDescription)
            } else if let movies = listMovieResponse?.data{
                self.movies.append(contentsOf: movies)
                self.currentResponseMoviesCount = listMovieResponse?.moviesCount ?? 0
                self.moviesTableView.reloadData()
                
                // For pagination: increment the number of page to be loaded next
                self.nextPageNumber+=1
                
                // stop the activity indicator and enable the user interaction events
                self.stopActivityIndicator()
            }
        })
    }
    
    func filterMovies(){
        // start the activity indicator and disable the user interaction events
        startActivityIndicator()
        
        self.navigationItem.title = "Filtered Movies"
        
        let moviesOperations = MovieServices()
        
        moviesOperations.filterMovies(page: nextPageNumber, query: self.filterQuery, genre: self.filterGenre, rate: self.filterRate, quality: self.filterQuality, sortBy: self.filterSortBy, orderBy: self.filterOrderBy, complation: {(listMovieResponse, error) in
            if let err = error{
                print(err.localizedDescription)
            } else if let movies = listMovieResponse?.data {
                
                //                self.tableViewIsForSearch = true
                self.tableViewIsForDisplay = .filter
                
                self.movies.append(contentsOf: movies)
                self.currentResponseMoviesCount = listMovieResponse?.moviesCount ?? 0
                self.moviesTableView.reloadData()
                
                // For pagination: increment the number of page to be loaded next
                self.nextPageNumber+=1
                
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
        } else if segue.identifier == "showFilter" {
            // assign the delegate of the destination to self in order to recive data back from the destination 
            let filterSearchViewController: FilteredSearchViewController = segue.destination as! FilteredSearchViewController
            filterSearchViewController.delegate = self
        }
    }
    
    // this func is for start the activity indicator and disable the user interaction events
    func startActivityIndicator(){
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
//        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    // this func is for stop the activity indicator and enable the user interaction events
    func stopActivityIndicator(){
        activityIndicator.stopAnimating()
//        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
    
}
