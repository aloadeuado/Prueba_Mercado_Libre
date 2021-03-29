//
//  ProductCollectionViewCell.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 26/03/21.
//

import Foundation
import UIKit
import SDWebImage
import ABLoaderView
class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var generalView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func setValue(result: ResultModel) {

        if let url = URL(string: result.thumbnail){
            productImageView.sd_setImage(with: url)
        }
        nameLabel.text = result.title

    }
    
    func showSpinner(){
        generalView.subviews.forEach { (view) in
            ABLoader().startShining(view)
        }
    }
    
    func stopSpinner() {
        generalView.subviews.forEach { (view) in
            ABLoader().stopShining(view)
        }
    }
}
