//
//  ReviewTableViewCell.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 7/1/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit

/// This class representing cell for review table View
class ReviewTableViewCell: UITableViewCell {

    // the storyboard outlets
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var reviewDescription: UILabel!
    @IBOutlet weak var cellBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initDesign()
    }
    
    // initialize the cell design
    func initDesign(){
        self.cellBackgroundView.layer.cornerRadius = 25
    }
    
    // configure the cell given the data
    func configCell(with review: Review){
        self.username.text = review.username
        self.title.text = review.title
        self.reviewDescription.text = review.description
    }


}
