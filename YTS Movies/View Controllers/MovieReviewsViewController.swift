//
//  MovieReviewsViewController.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 7/1/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit

class MovieReviewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var movieReviewsTableView: UITableView!
    
    
    var reviews = [Review]()
    override func viewDidLoad() {
        super.viewDidLoad()

        loadReviews()
        movieReviewsTableView.delegate = self
        movieReviewsTableView.dataSource = self
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell") as! ReviewTableViewCell
        cell.configCell(with: reviews[indexPath.row])
        return cell
    }
    
    func loadReviews(){
        let review1 = Review(username: "rosannag", title: "Different Experience to Original Tomb Raider", description: "Given the poor ratings I had low expectations for this movie but it was surprisingly very entertaining. I wouldn't compare it to the Original movies with Angelina Jolie as it was just a different movie experience. I am still a fan of Angelina Jolie as Lara Croft but the Alicia Vikander version works too.")
        self.reviews.append(review1)
        
        let review2 = Review(username: "georgiev-ivan", title: "Proof that the touch of Hollywood can spoil anythting", description: "Amazing start, good action, deep enough character development. After 30 minutes the production becomes completely predictable and starts following the cliche guidelines of an low budget movie designed to kill time for the average house wife. Despite Alicia Vikander's great performance going further the story becomes extremely boring, I assume sensed by the director, who decided to flood all milestones in it with too much drama and extremely irritating 80s-cheap-movie dramatic music. On top of everything else, the film deviates from the game story completely. Well, it is not a total wreck but if you have played the game and enjoyed it even a little, you do not need to suffer this glorified hiccup of a production.")
        self.reviews.append(review2)
        
        let review3 = Review(username: "mimimsy", title: "Trash, plot holes, bad acting and cheap CGI", description: "I'll keep this very simple, slapping the name Tomb Raider does not give permission to make a crappy movie and expect people to pay for it. This movie had plenty of plot holes, the chosen Lara Croft was not the best choice and the CG in this trashy movie is cheap.")
        self.reviews.append(review3)
        
    }

}
