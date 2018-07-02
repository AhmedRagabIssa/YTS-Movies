//
//  SortByCollectionViewCell.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/28/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit

/// This class representing cell for sort by collection View
class SortByCollectionViewCell: UICollectionViewCell {
    
    // the storyboard outlets
    @IBOutlet weak var sortByOptionLabel: UILabel!
    @IBOutlet weak var cellShapeView: UIView!
    
    // the cell initianl design
    func initCellDesign(){
        self.cellShapeView.layer.cornerRadius = self.cellShapeView.frame.height / 2
        self.cellShapeView.layer.borderWidth = 1
        self.cellShapeView.layer.borderColor = #colorLiteral(red: 0.4156862745, green: 0.7529411765, blue: 0.2705882353, alpha: 1)
        self.sortByOptionLabel.textColor = #colorLiteral(red: 0.4156862745, green: 0.7529411765, blue: 0.2705882353, alpha: 1)
    }
    
//    func isSelected(selected: Bool){
//        if selected {
//            self.cellShapeView.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
//            self.sortByOptionLabel.textColor = UIColor.white
//        }else{
//            self.cellShapeView.backgroundColor = UIColor.white
//            self.sortByOptionLabel.textColor = UIColor.black
//        }
//    }
    
    // configure the cell given the data
    func configure(with data: String, isSelected: Bool){
        self.sortByOptionLabel.text = data
        
        if isSelected { // change the cell apperance according to it's state (selected or not)
            self.cellShapeView.backgroundColor = #colorLiteral(red: 0.4156862745, green: 0.7529411765, blue: 0.2705882353, alpha: 1)
            self.sortByOptionLabel.textColor = #colorLiteral(red: 0.1450980392, green: 0.1411764706, blue: 0.137254902, alpha: 1)
        }else{
            self.cellShapeView.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1411764706, blue: 0.137254902, alpha: 1)
            self.sortByOptionLabel.textColor = #colorLiteral(red: 0.4156862745, green: 0.7529411765, blue: 0.2705882353, alpha: 1)
        }
    }
}
