//
//  ListProductsViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 23/03/21.
//

import UIKit
import MaterialComponents.MaterialChips

class ListProductsViewController: UIViewController {
    @IBOutlet weak var searchBarView: SearchBarView!
    @IBOutlet weak var filterCategoryView: FilterCategoryView!
    @IBOutlet weak var sortSelectOptionView: SelectOptionView!
    
    @IBOutlet weak var filtersLabel: UILabel!
    @IBOutlet weak var productCollectionView: UICollectionView!
    var listProductsViewModel: ListProductsViewModel?
    
    var siteModel: SiteModel?
    var products: Product?
    var categories = [CategoryModel]()
    var listTextFilters = [String]()
    var indexSelectedSort = 0
    var indexSelectedFilter = 0
    
    
    var listFilters = [FilterData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent(){
        listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: self)
        filterCategoryView.setCategoryFilter(categoryTextArray: ["Option1", "Option1Option1", "Option1222", "Option1Option1"])
        filterCategoryView.showSpinner()
        sortSelectOptionView.delegate = self

        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        if listProductsViewModel?.getKeepSite() == "Save" {
            self.listProductsViewModel?.geInternalSite()
            return
        }
        if let site = siteModel {
            
            listProductsViewModel?.getCategoriesOfSites(siteId: site.id)
        }
    }

    //Load products
    func loadSortFilters(){
        if let product = self.products {
            guard let available_sorts = product.available_sorts else {return}
            //listSorts = available_sorts
            var listTextSorts = [String]()
            available_sorts.forEach { (available_filters) in
                listTextSorts.append(available_filters.name ?? "")
            }
            sortSelectOptionView.arrayList = listTextSorts
            
            guard let filtersSelect = product.filters else {
                return
            }
            guard let available_filters = product.available_filters else {
                return
            }
            listFilters = [FilterData]()
            available_filters.forEach { (available_filters) in
                let idTitle = available_filters.id ?? ""
                let nameTitle = available_filters.name ?? ""
                let filterFilter = filtersSelect.first { (filters) -> Bool in
                    return filters.id == available_filters.id
                }
                let filterTitleData = FilterData(idTitle: idTitle, nameTitle: nameTitle, idValue: "", nameValue: "", isTitle: true, state: false)
                listFilters.append(filterTitleData)
                if let values = available_filters.values {
                    values.forEach { (value) in
                        let idValue = value.id ?? ""
                        let nameValue = value.name ?? ""
                        var state = false
                        if let filterFilter1 = filterFilter {
                             if filterFilter1.values?.first(where: { (value2) -> Bool in
                                return value2.id == value.id
                            }) != nil {
                                state = true
                            }
                        }
                        let filterValueData = FilterData(idTitle: idTitle, nameTitle: nameTitle, idValue: idValue, nameValue: nameValue, isTitle: false, state: state)
                        listFilters.append(filterValueData)
                    }
                }
            }
        }
    }
    
    func loadProducts(){
        if !self.categories.isEmpty {
            if let site = siteModel {
                guard let product = self.products else {
                    listProductsViewModel?.getProducts(siteId: site.id, offset: 0, limit: 10, sort: "", filters: [SortData(filer: "category", value: self.categories[0].id)])
                    return
                }
                guard let sorts = product.available_sorts else {return}
                guard let filters = product.available_filters  else {return}
                let sortText = ((sorts.isEmpty) ? "": sorts[indexSelectedSort].name) ?? ""
                var listFiltersSend = [SortData]()
                if filters.isEmpty {
                    listFiltersSend = [SortData(filer: "category", value: self.categories[0].id)]
                } else {
                    //filters.
                }

                listProductsViewModel?.getProducts(siteId: site.id, offset: 0, limit: 10, sort: sortText, filters: listFiltersSend)
            }
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
    //MARK: -Action
    @IBAction func selectFileterPressed(_ sender: UIButton) {
        DialogSelectMultiFilterViewController.show(controller: self, delegate: self, listFilters: listFilters)
    }
    
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
    func listProductsViewModel(succesGetSite siteModel: SiteModel) {
        self.siteModel = siteModel
    }
    
    func listProductsViewModel(succesGetProduct products: Product) {
        self.products = products
        loadSortFilters()
        productCollectionView.reloadData()
        
    }
    
    func listProductsViewModel(succesGetCategories categories: [CategoryModel]) {
        filterCategoryView.stopSpinner()
        self.categories = categories
        var listTextCategories = [String]()
        categories.forEach { (categoryModel) in
            listTextCategories.append(categoryModel.name)
        }
        filterCategoryView.setCategoryFilter(categoryTextArray: listTextCategories)
        loadProducts()
        
    }
    
    func listProductsViewModel(onError error: String) {
        
    }
    
    
}
//MARK: -SelectOptionViewDelegate
extension ListProductsViewController: SelectOptionViewDelegate {
    func selectOptionView(didSelectedItem item: String, index: Int) {
        indexSelectedSort = index
        loadProducts()
    }
    
    func selectOptionView(didCancel item: String) {
        
    }
}
//MARK: -FiltersTableViewDelegate
extension ListProductsViewController: FiltersTableViewDelegate{
    func filtersTableView(didGetFilter filterSelecter: FilterData, listFiltersSelecter: [FilterData]) {
        
        
    }
    
    func filtersTableView(aplyFilter listFiltersSelecter: [FilterData]) {
        self.listFilters = listFiltersSelecter
        var text = ""
        listFiltersSelecter.forEach { (filterData) in
            text += (filterData.isTitle) ? "" : (filterData.state) ? filterData.nameTitle + ": " + filterData.nameValue + "  " : ""
            
        }
        
        filtersLabel.text = text
    }
    
    
}
//MARK: -UICollectionViewDataSource
extension ListProductsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let product = products else {
            return 0
        }
        guard let results = product.results else {
            return 0
        }
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let product = products else {
            return UICollectionViewCell()
        }
        guard let results = product.results else {
            return UICollectionViewCell()
        }
        cell.setValue(result: results[indexPath.row])
        return cell
    }
}
//MARK: -UICollectionViewDelegate
extension ListProductsViewController: UICollectionViewDelegate {
    
}
//MARK: -UICollectionViewLayout
extension ListProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
