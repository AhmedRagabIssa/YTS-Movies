//
//  MoviesTableViewCell.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/21/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit
import Kingfisher

/// This class representing cell for Movies Table View
class MoviesTableViewCell: UITableViewCell {
    
    // the storyboard outlets
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    var isAnimated = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initDesign()
    }
    
    func initDesign(){
        self.cellBackgroundView.layer.cornerRadius = 25
        self.cellBackgroundView.layer.borderWidth = 3
        self.cellBackgroundView.layer.borderColor = #colorLiteral(red: 0.4156862745, green: 0.7529411765, blue: 0.2705882353, alpha: 1)
        self.cellBackgroundView.clipsToBounds = true
    }

    
    // configure the cell given the Movie object
    func configure(with data: Movie){
        self.movieTitle.text = data.title
        self.movieRating.text = "⭐️  \(data.rate ?? 0) / 10"
        self.movieGenres.text = data.genres.joined(separator: ", ")
        let imgURL = URL(string: data.imgURL!)
        let recource = ImageResource(downloadURL: imgURL!)
        self.movieImage.kf.setImage(with: recource)
        self.selectionStyle = .none
    }

}
