//
//  DetailProductViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 28/03/21.
//

import UIKit

class DetailProductViewController: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var result = ResultModel(id: "", siteID: "", title: "", price: 0, thumbnail: "  ", permalink: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    

    func initComponent(){
        titleLabel.text = result.title
        if let priceComplete = result.price {
            priceLabel.text = "$ \(priceComplete)"
        }
        if let url = URL(string: result.thumbnail){
            itemImageView.sd_setImage(with: url)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: -Actions

extension DetailProductViewController {
    @IBAction func showMorePressed(button: UIButton) {
        DialogWebViewViewController.show(controller: self, titleText: result.title, url: result.permalink)
    }
}
