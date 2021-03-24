//
//  ListProductsViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 23/03/21.
//

import UIKit

class ListProductsViewController: UIViewController {
    @IBOutlet weak var searchBarView: SearchBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent(){
        searchBarView.delegate = self
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
extension ListProductsViewController: SearchBarViewDelegate {
    func searchBarView(didEdintingText text: String) {

    }
    
    func searchBarView(didClearText textBeforeClear: String) {

    }
    
    
}
