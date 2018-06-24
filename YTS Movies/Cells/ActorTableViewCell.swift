//
//  ActorTableViewCell.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 6/23/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit

class ActorTableViewCell: UITableViewCell {

    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorCharacter: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        initCellDesign()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func initCellDesign(){
        self.actorImage.layer.cornerRadius = self.actorImage.frame.width / 2
        self.actorImage.layer.masksToBounds = true
    }
    
}
