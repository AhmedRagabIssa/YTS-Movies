//
//  Extention.swift
//  YTS Movies
//
//  Created by Ahmed Ragab Issa on 7/2/18.
//  Copyright © 2018 Ragab. All rights reserved.
//

import UIKit

// MARK: - String extention for width calculation
extension String{
    func widthGivenFont(_ height: CGFloat, font: UIFont) -> CGFloat{
        let size = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:font], context: nil)
        return ceil(boundingBox.width)
    }
}
