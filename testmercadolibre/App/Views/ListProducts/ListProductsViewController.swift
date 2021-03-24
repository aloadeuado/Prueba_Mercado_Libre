//
//  ListProductsViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 23/03/21.
//

import UIKit

class ListProductsViewController: UIViewController {
    @IBOutlet weak var searchBarView: SearchBarView!
    @IBOutlet weak var filterCategoryView: FilterCategoryView!
    
    var listProductsViewModel: ListProductsViewModel?
    
    var siteModel: SiteModel?
    var listCategies = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent(){
        searchBarView.delegate = self
        listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: self)
        if let site = siteModel {
            listProductsViewModel?.getCategoriesOfSites(siteId: site.id)
        }
        filterCategoryView.setCategoryFilter(categoryTextArray: ["Amor", "Hermoso"])
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
//MARK: -SearchBarViewDelegate
extension ListProductsViewController: SearchBarViewDelegate {
    func searchBarView(didEdintingText text: String) {

    }
    
    func searchBarView(didClearText textBeforeClear: String) {

    }
    
    
}
//MARK: -ListProductsViewModel
extension ListProductsViewController: ListProductsViewModelDelegate {
    func listProductsViewModel(succesGetCategories categories: [CategoryModel]) {
        listCategies = [String]()
        categories.forEach { (categoryModel) in
            listCategies.append(categoryModel.name)
        }
        filterCategoryView.setCategoryFilter(categoryTextArray: listCategies)
    }
    
    func listProductsViewModel(onError error: String) {
        
    }
    
    
}
