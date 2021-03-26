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
    let productRepository = ProductRepository()
    let contryRepository = ContryRepository()
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
    func getProducts(siteId: String, offset: Int32, limit: Int32, sort: String, filters: [SortData]){
        productRepository.getProducts(siteId: siteId, offset: offset, limit: limit, sort: sort, filters: filters) { (product) in
            self.listProductsViewModelDelegate?.listProductsViewModel(succesGetProduct: product)
        } error: { (error) in
            self.listProductsViewModelDelegate?.listProductsViewModel(onError: error)
        }
    }

    func geInternalSite(){
        let result = contryRepository.getInternalSite()
        if result.error != "" {
            self.listProductsViewModelDelegate?.listProductsViewModel(onError: result.error)
        } else {
            if let site = result.siteModel {
                getCategoriesOfSites(siteId: site.id)
                self.listProductsViewModelDelegate?.listProductsViewModel(succesGetSite: site)
            }
            
        }
    }
    
    func getKeepSite() -> String{
        return getString(didGetString: "keyKeepSite")
    }
}
protocol ListProductsViewModelDelegate {
    func listProductsViewModel(succesGetCategories categories: [CategoryModel])
    func listProductsViewModel(succesGetSite siteModel: SiteModel)
    func listProductsViewModel(onError error: String)
    func listProductsViewModel(succesGetProduct products: Product)
}
