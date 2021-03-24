//
//  ListProductsViewModel.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 23/03/21.
//

import Foundation
class ListProductsViewModel{
    
    var listProductsViewModelDelegate: ListProductsViewModelDelegate?
    
    let categoryRepository = CatagoriesRepository()
    init(listProductsViewModelDelegate: ListProductsViewModelDelegate) {
        self.listProductsViewModelDelegate = listProductsViewModelDelegate
    }
    func getCategoriesOfSites(siteId: String) {
        categoryRepository.getCategoriesOfSites(siteId: siteId) { (categories) in
            self.listProductsViewModelDelegate?.listProductsViewModel(succesGetCategories: categories)
        } error: { (error) in
            self.listProductsViewModelDelegate?.listProductsViewModel(onError: error)
        }

    }
}
protocol ListProductsViewModelDelegate {
    func listProductsViewModel(succesGetCategories categories: [CategoryModel])
    func listProductsViewModel(onError error: String)
}
