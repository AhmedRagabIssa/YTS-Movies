//
//  ActorTableViewCell.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/23/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit
import Kingfisher

/// This class representing cell for Actors Table View
class ActorTableViewCell: UITableViewCell {

    // the storyboard outlets
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorCharacter: UILabel!
    
    // this url is for if the actor image is not provided
     let imageNotFound: String = "https://www.mearto.com/assets/no-image-83a2b680abc7af87cfff7777d0756fadb9f9aecd5ebda5d34f8139668e0fc842.png"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initCellDesign()
    }

    // init cell design configuration
    func initCellDesign(){
        self.actorImage.layer.cornerRadius = self.actorImage.frame.width / 2
        self.actorImage.layer.masksToBounds = true
    }
    
    // configure the cell given the Actor object
    func configure(with data: Actor){
        let actorImgURL = URL(string: data.imgURL ?? imageNotFound)
        let resource = ImageResource(downloadURL: actorImgURL!)
        self.actorImage?.kf.setImage(with: resource)
        self.actorName.text = data.name
        self.actorCharacter.text = data.characterName
    }
}
