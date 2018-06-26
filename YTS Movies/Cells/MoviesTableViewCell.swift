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
    
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
