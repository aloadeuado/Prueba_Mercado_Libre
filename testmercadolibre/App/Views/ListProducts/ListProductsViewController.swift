//
//  ListProductsViewController.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 23/03/21.
//

import UIKit
import MaterialComponents.MaterialChips
import Toast_Swift
import ABLoaderView
class ListProductsViewController: UIViewController {
    @IBOutlet weak var searchBarView: SearchBarView!
    @IBOutlet weak var filterCategoryView: FilterCategoryView!
    @IBOutlet weak var sortSelectOptionView: SelectOptionView!
    
    @IBOutlet weak var filterSelected: CustomView!
    @IBOutlet weak var topProductCollectionViewLayout: NSLayoutConstraint!
    @IBOutlet weak var filtersLabel: UILabel!
    @IBOutlet weak var productCollectionView: UICollectionView!
    var listProductsViewModel: ListProductsViewModel?
    
    @IBOutlet weak var noDataView: UIView!
    var siteModel = SiteModel()
    var listCategoriesFilters = [FilterData]()
    var isLoadingProdcuts = false
    var isLoadingNewProducts = false
    var products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())
    var productsBefore = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())
    var categories = [CategoryModel]()
    var categoryText: String = ""
    var indexSelectedCategory = 0
    var numberOfItems: Int32 = 10
    var lastContentSizeHeight:CGFloat = 0
//Send Detail
    var result = ResultModel(id: "", siteID: "", title: "", price: 0, thumbnail: "  ", permalink: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponent()
        // Do any additional setup after loading the view.
    }
    
    func initComponent(){
        listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: self)
        filterCategoryView.setCategoryFilter(categoryTextArray: ["Option1", "Option1Option1", "Option1222", "Option1Option1"])
        filterCategoryView.showSpinner()
        filterCategoryView.delegate = self
        sortSelectOptionView.delegate = self
        searchBarView.delegate = self

        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        showTools()
        if listProductsViewModel?.getKeepSite() == "Save" {
            self.listProductsViewModel?.geInternalSite()
            return
        }
        listProductsViewModel?.getCategoriesOfSites(siteId: siteModel.id)
        
    }

    func reloadDataProducts(){
        noDataView.isHidden = true
        showSpinner()
        products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())
        productsBefore = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())
        products = listProductsViewModel?.setCatogoryProduct(nameCategory: categoryText, categoryModel: self.categories[indexSelectedCategory], productModel: products) ?? products
        products = listProductsViewModel?.setInitOffsetAndLimit(numberOfItems: numberOfItems, productModel: products) ?? products
        lastContentSizeHeight = 0
        
        loadDataProducts()
    }
    
    func loadDataProducts() {
        isLoadingProdcuts = true
        productCollectionView.reloadData()
        productsBefore = products
        listProductsViewModel?.getProducts(siteId: siteModel.id, productModel: products)
    }

    func loadSearchDataProducts(textSearch: String) {
        isLoadingProdcuts = true
        productCollectionView.reloadData()
        productsBefore = products
        listProductsViewModel?.getProducts(siteId: siteModel.id, textSearch: textSearch)
    }
    
    func showTools(){
        self.topProductCollectionViewLayout.constant = -110
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
          
            
            self.topProductCollectionViewLayout.constant = 15
        }, completion: { finished in
            self.topProductCollectionViewLayout.constant = 15
            
        })
    }
    
    func hideTools(){
        self.topProductCollectionViewLayout.constant = 15
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
          
            
            self.topProductCollectionViewLayout.constant = -110
        }, completion: { finished in
            self.topProductCollectionViewLayout.constant = -110
            
        })
    }
    
    func showSpinner(){
        ABLoader().startShining(sortSelectOptionView)
        ABLoader().startShining(filterSelected)
    }
    
    func stopSpinner(){
        ABLoader().stopShining(sortSelectOptionView)
        ABLoader().stopShining(filterSelected)
    }
    //MARK: -Action
    @IBAction func selectFileterPressed(_ sender: UIButton) {
        DialogSelectMultiFilterViewController.show(controller: self, delegate: self, listFilters: listCategoriesFilters)
    }
    
}
//MARK: -SearchBarViewDelegate
extension ListProductsViewController: SearchBarViewDelegate {
    func searchBarView(didEdintingText text: String) {

        if text.count >= 1{
            hideTools()
            products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())
            productsBefore = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())

            products = listProductsViewModel?.setInitOffsetAndLimit(numberOfItems: numberOfItems, productModel: products) ?? products
            lastContentSizeHeight = 0
            
            loadSearchDataProducts(textSearch: text)
        
        } else {
            showTools()
            reloadDataProducts()
            // se reinician ambas variables para priorizar las seleccion de categoria
            
            
        }
        
    }
    
    func searchBarView(didClearText textBeforeClear: String) {
        showTools()
        // se reinician ambas variables para priorizar las seleccion de categoria
        reloadDataProducts()
    }
    
    
}
//MARK: -selectCategoryDelegate
extension ListProductsViewController: selectCategoryDelegate {
    func selectIndexCategory(index: Int, categoryText: String) {
        indexSelectedCategory = index
        self.categoryText = categoryText
        // se reinician ambas variables para priorizar las seleccion de categoria
        reloadDataProducts()
    }
}
//MARK: -ListProductsViewModel
extension ListProductsViewController: ListProductsViewModelDelegate {
    func listProductsViewModel(succesGetSite siteModel: SiteModel) {
        self.siteModel = siteModel
    }
    
    func listProductsViewModel(succesGetProduct products: ProductModel) {
        stopSpinner()
        var productsNewsResult = self.products.results
        productsNewsResult.append(contentsOf: products.results)
        self.products = products
        self.products.results = productsNewsResult
        sortSelectOptionView.arrayList = listProductsViewModel?.getListTextSortInternal(productModel: self.products) ?? [String]()
        listCategoriesFilters = listProductsViewModel?.getFiltersAvaible(productModel: self.products) ?? [FilterData]()
        productCollectionView.setContentOffset(CGPoint(x: 0, y: lastContentSizeHeight), animated: false)
        isLoadingProdcuts = false
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
        
    }
    
    func listProductsViewModel(onError error: String) {
        stopSpinner()
        noDataView.isHidden = false
        isLoadingProdcuts = false
        products = productsBefore
        productCollectionView.reloadData()
        self.view.makeToast(error)
    }
    
    
}
//MARK: -SelectOptionViewDelegate
extension ListProductsViewController: SelectOptionViewDelegate {
    func selectOptionView(didSelectedItem item: String, index: Int) {
        //indexSelectedSort = index
        //loadProducts()
        self.products = listProductsViewModel?.setSortValue(nameSort: item, productModel: self.products) ?? self.products
        products = listProductsViewModel?.setInitOffsetAndLimit(numberOfItems: numberOfItems, productModel: products) ?? products
        lastContentSizeHeight = 0
        
        loadDataProducts()
        products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())
    }
    
    func selectOptionView(didCancel item: String) {
        
    }
}
//MARK: -FiltersTableViewDelegate
extension ListProductsViewController: FiltersTableViewDelegate{
    func filtersTableView(didGetFilter filterSelecter: FilterData, listFiltersSelecter: [FilterData]) {
        
        
    }
    
    func filtersTableView(aplyFilter listFiltersSelecter: [FilterData]) {
        self.listCategoriesFilters = listFiltersSelecter
        var text = ""
        listFiltersSelecter.forEach { (filterData) in
            text += (filterData.isTitle) ? "" : (filterData.state) ? filterData.nameTitle + ": " + filterData.nameValue + "  " : ""
            
        }
        
        filtersLabel.text = text
        
        self.products = listProductsViewModel?.setNewFilters(listFilterData: self.listCategoriesFilters, productModel: self.products) ?? self.products
        products = listProductsViewModel?.setInitOffsetAndLimit(numberOfItems: numberOfItems, productModel: products) ?? products
        lastContentSizeHeight = 0
        loadDataProducts()
        products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())
    }
    
    
}
//MARK: -UICollectionViewDataSource
extension ListProductsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return isLoadingProdcuts ? 3 : products.results.count + (products.paging.total <= (self.products.paging.offset + Int(numberOfItems)) ? 0 : 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }

        if (indexPath.row) >= products.results.count {
            cell.showSpinner()
        } else if (isLoadingProdcuts){
            cell.showSpinner()
        }else {
            cell.stopSpinner()
            cell.setValue(result: products.results[indexPath.row])
        }
        return cell
    }
}
//MARK: -UICollectionViewDelegate
extension ListProductsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        result = products.results[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
}
//MARK: -UICollectionViewLayout
extension ListProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 280)
    }
}
//MARK: -UIScrollViewDelegate
extension ListProductsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentScrollTrigger = scrollView.contentSize.height - 600
        if scrollView.contentOffset.y >= contentScrollTrigger {
            //initIndexOffset += (numberItemForPage + 1)
            if isLoadingNewProducts && !isLoadingProdcuts {
                if products.paging.total <= (self.products.paging.offset + Int(numberOfItems)) {
                    isLoadingNewProducts = false
                    return
                }
                self.products = listProductsViewModel?.addItems(numberOfItems: numberOfItems, productModel: self.products) ?? self.products
                isLoadingNewProducts = false
                lastContentSizeHeight = scrollView.contentOffset.y
                
                loadDataProducts()
            }
            
        }else {
            isLoadingNewProducts = true
        }
        
        
    }
}
//MARK: -prepare
extension ListProductsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailProductViewController {
            vc.result = result
        }
    }
}
