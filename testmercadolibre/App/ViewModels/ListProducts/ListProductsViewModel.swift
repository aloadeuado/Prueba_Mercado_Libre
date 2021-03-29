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
    func setCatogoryProduct(nameCategory: String, categoryModel: CategoryModel,productModel:ProductModel) -> ProductModel {
        guard let categoryFilterAvaible = productModel.availableFilters.first(where: { (availableFilter) -> Bool in
            return availableFilter.id == "category"
        }) else {
            let filterValue = FilterValue(id: categoryModel.id, name: categoryModel.name)
            let filterr = Filter(id: "category", name: "", type: "", values: [filterValue])
            productModel.filters = [filterr]
            return productModel
        }
        
        guard let valueAvaible = categoryFilterAvaible.values.first(where: { (availableFilterValue) -> Bool in
            availableFilterValue.name == nameCategory
        }) else {
            let filterValue = FilterValue(id: categoryModel.id, name: categoryModel.name)
            let filterr = Filter(id: "category", name: "", type: "", values: [filterValue])
            productModel.filters = [filterr]
            return productModel
        }
        
        guard let categoryFilter = productModel.filters.first(where: { (filter) -> Bool in
            return filter.id == "category"
        }) else { return productModel }
        categoryFilter.values = [FilterValue(id: valueAvaible.id, name: valueAvaible.name)]
        productModel.filters = [categoryFilter]
        
        return productModel
    }
    
    func getListTextSortInternal(productModel:ProductModel) -> [String] {
        var listTextSort = [String] ()
        listTextSort.append(productModel.sort.name)
        productModel.availableSorts.forEach { (sort) in
            listTextSort.append(sort.name)
        }
        
        return listTextSort
    }
    
    func setInitOffsetAndLimit(numberOfItems: Int32, productModel:ProductModel) -> ProductModel {
        productModel.paging.offset = 0
        productModel.paging.limit = Int(numberOfItems)
        
        return productModel
    }
    
    func setSortValue(nameSort: String, productModel: ProductModel) -> ProductModel {
        guard let sordSend = productModel.availableSorts.first(where: { (sort) -> Bool in
            return sort.name == nameSort
        }) else {
            return productModel
        }
        
        productModel.sort = sordSend
        
        return productModel
    }
    
    func getFiltersAvaible(productModel: ProductModel) -> [FilterData] {
        var listFilter = [FilterData]()
        productModel.availableFilters.forEach { (availableFilter) in
            let idTitle = availableFilter.id
            let nameTitle = availableFilter.name
            listFilter.append(FilterData(idTitle: idTitle, nameTitle: nameTitle, idValue: "", nameValue: "", isTitle: true, state: false))
            availableFilter.values.forEach { (availableFilterValue) in
                let idValue = availableFilterValue.id
                let nameValue = availableFilterValue.name
                var state = false
                if let _ = productModel.filters.first(where: { (filter) -> Bool in
                    return filter.id == availableFilterValue.id
                }) {
                    state = true
                }
                listFilter.append(FilterData(idTitle: idTitle, nameTitle: nameTitle, idValue: idValue, nameValue: nameValue, isTitle: false, state: state))
            }
            
        }
        
        return listFilter
    }
    
    func setNewFilters(listFilterData: [FilterData], productModel: ProductModel) -> ProductModel {
        let listFilterData1 = listFilterData.filter { (filterData) -> Bool in
            filterData.state == true
        }
        var filters = productModel.filters
        let filtersAvailble = productModel.availableFilters
        filtersAvailble.forEach { (filter) in
            if let filterSelect = listFilterData1.first(where: { (filterData) -> Bool in
                return filterData.idTitle == filter.id
            }) {
                let filterSend = Filter(id: filterSelect.idTitle, name: filterSelect.nameTitle, type: "", values: [FilterValue]())
                filter.values.forEach { (availableFilterValue) in
                    if let filterValueSelect = listFilterData1.first(where: { (filterData) -> Bool in
                        return filterData.idValue == availableFilterValue.id
                    }) {
                        let filterValue = FilterValue(id: filterValueSelect.idValue, name: filterValueSelect.nameValue)
                        filterSend.values.append(filterValue)
                    }
                }
                if !filterSend.values.isEmpty {
                    filters.append(filterSend)
                }
            }
        }
        
        productModel.filters = filters
        
        return productModel
        
    }
    
    func addItems(numberOfItems: Int32, productModel: ProductModel) -> ProductModel {
        var offset = productModel.paging.offset
        if ((offset + Int(numberOfItems)) >= productModel.paging.total) {
            offset = productModel.paging.offset
        } else {
            offset += Int(numberOfItems)
        }


        let limit = Int(numberOfItems)
        
        productModel.paging.offset = offset
        productModel.paging.limit = limit
        
        return productModel
    }
    
    func getCategoriesOfSites(siteId: String) {
        categoryRepository.getCategoriesOfSites(siteId: siteId) { (categories) in
            self.listProductsViewModelDelegate?.listProductsViewModel(succesGetCategories: categories)
        } error: { (error) in
            self.listProductsViewModelDelegate?.listProductsViewModel(onError: error)
        }
    }
    func getProducts(siteId: String, productModel: ProductModel){
        productRepository.getProducts(siteId: siteId, productModel: productModel) { (product) in
            self.listProductsViewModelDelegate?.listProductsViewModel(succesGetProduct: product)
        } error: { (error) in
            self.listProductsViewModelDelegate?.listProductsViewModel(onError: error)
        }
    }
    
    func getProducts(siteId: String, textSearch: String){
        productRepository.getProducts(siteId: siteId, textSearch: textSearch) { (product) in
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
    func listProductsViewModel(succesGetProduct products: ProductModel)
}
