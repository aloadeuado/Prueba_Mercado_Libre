//
//  ProductCollectionViewCell.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 26/03/21.
//

import Foundation
import UIKit
import SDWebImage
class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setValue(result: Results) {
        if let imageUrl = result.thumbnail {
            if let url = URL(string: imageUrl){
                productImageView.sd_setImage(with: url)
            }
        }
        if let name = result.title {
            nameLabel.text = name
        }
    }
}
