//
//  ListProductsViewModelTest.swift
//  testmercadolibreTests
//
//  Created by Pedro Alonso Daza B on 29/03/21.
//

import XCTest
@testable import testmercadolibre

class ListProductsViewModelTest: XCTestCase {

    private var sut: ListProductsViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "ListProducts", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "ListProductsViewController") as? ListProductsViewController else {
            XCTFail("Could not instantiate viewController as ProductListPageViewController.")
            return
        }
        sut = viewController

        
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSetCatogoryProductNoAvaibleFilters() throws {
        // This is an example of a performance test case.
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())
        
        let categoryModel = CategoryModel(id: "", name: "")
        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let recibedProducts = listProductsViewModel.setCatogoryProduct(nameCategory: "", categoryModel: categoryModel, productModel: products)

        assert((recibedProducts.filters.count >= 0) ? (recibedProducts.filters[0].values.isEmpty ? false : recibedProducts.filters[0].values[0].id == ""): false)
    }
    
    func testSetCatogoryProductAvaibleFilters() throws {
        // This is an example of a performance test case.
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())
        
        let categoryModel = CategoryModel(id: "C1", name: "category1")
        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let recibedProducts = listProductsViewModel.setCatogoryProduct(nameCategory: "category1", categoryModel: categoryModel, productModel: products)

        assert((recibedProducts.filters.count >= 0) ? (recibedProducts.filters[0].values.isEmpty ? false : recibedProducts.filters[0].values[0].id == "C1"): false)
    }
    
    func testSetCatogoryProductAvaibleFiltersWihtCategoryExist() throws {
        // This is an example of a performance test case.
        let filter = AvailableFilter(id: "c1", name: "category1", type: "cate", values: [AvailableFilterValue(id: "cv1", name: "value1", results: 0)])
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [filter])
        
        let categoryModel = CategoryModel(id: "cv1", name: "value1")
        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let recibedProducts = listProductsViewModel.setCatogoryProduct(nameCategory: "category1", categoryModel: categoryModel, productModel: products)

        assert((recibedProducts.filters.count >= 0) ? (recibedProducts.filters[0].values.isEmpty ? false : recibedProducts.filters[0].values[0].id == "cv1"): false)
    }
    
    func testGetListTextSortInternalCorrectLoadSorts() throws {
        // This is an example of a performance test case.
        let sorts = [Sort(id: "s1", name: "Sort1"), Sort(id: "s2", name: "Sort2"), Sort(id: "s3", name: "Sort3"), Sort(id: "s4", name: "Sort4")]
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "s5", name: "Sort5"), availableSorts: sorts, filters: [Filter](), availableFilters: [AvailableFilter]())

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let listSorts = listProductsViewModel.getListTextSortInternal(productModel: products)

        assert(listSorts.count == 5)
    }
    
    func testGetListTextSortInternalAddFirstFilterExist() throws {
        // This is an example of a performance test case.
        let sorts = [Sort(id: "s1", name: "Sort1"), Sort(id: "s2", name: "Sort2"), Sort(id: "s3", name: "Sort3"), Sort(id: "s4", name: "Sort4")]
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "s5", name: "Sort5"), availableSorts: sorts, filters: [Filter](), availableFilters: [AvailableFilter]())

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let listSorts = listProductsViewModel.getListTextSortInternal(productModel: products)

        assert((listSorts.count >= 1) ? listSorts[0] == "Sort5" : false)
    }
    
    func testSetInitOffsetAndLimit() throws {
        // This is an example of a performance test case.
        let sorts = [Sort(id: "s1", name: "Sort1"), Sort(id: "s2", name: "Sort2"), Sort(id: "s3", name: "Sort3"), Sort(id: "s4", name: "Sort4")]
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "s5", name: "Sort5"), availableSorts: sorts, filters: [Filter](), availableFilters: [AvailableFilter]())

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let recibedProducts = listProductsViewModel.setInitOffsetAndLimit(numberOfItems: 10, productModel: products)

        assert(recibedProducts.paging.limit == 10)
    }
    
    func testSetSortValueNoSortAvailable() throws {
        // This is an example of a performance test case.
        let sorts = [Sort(id: "s1", name: "Sort1"), Sort(id: "s2", name: "Sort2"), Sort(id: "s3", name: "Sort3"), Sort(id: "s4", name: "Sort4")]
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: sorts, filters: [Filter](), availableFilters: [AvailableFilter]())

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let recibedProducts = listProductsViewModel.setSortValue(nameSort: "", productModel: products)

        assert(recibedProducts.sort.id == "")
    }
    
    func testSetSortValueSortAvailable() throws {
        // This is an example of a performance test case.
        let sorts = [Sort(id: "s1", name: "Sort1"), Sort(id: "s2", name: "Sort2"), Sort(id: "s3", name: "Sort3"), Sort(id: "s4", name: "Sort4")]
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: sorts, filters: [Filter](), availableFilters: [AvailableFilter]())

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let recibedProducts = listProductsViewModel.setSortValue(nameSort: "Sort2", productModel: products)

        assert(recibedProducts.sort.id == "s2")
    }
    
    func testGetFiltersAvaible() throws {
        // This is an example of a performance test case.
        let filters = [AvailableFilter(id: "c1", name: "category1", type: "cate", values: [AvailableFilterValue(id: "cv1", name: "value1", results: 0)]), AvailableFilter(id: "c2", name: "category2", type: "cater", values: [AvailableFilterValue(id: "cv2", name: "value2", results: 0)])]
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: filters)
        
        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let listFilterData = listProductsViewModel.getFiltersAvaible(productModel: products)

        assert(listFilterData.count == 4)
    }
    
    func testGetFiltersAvaibleNoAvaibleFilters() throws {
        // This is an example of a performance test case.
        let filters = [AvailableFilter]()
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: filters)
        
        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let listFilterData = listProductsViewModel.getFiltersAvaible(productModel: products)

        assert(listFilterData.count == 0)
    }

    func testSetNewFiltersNoData() throws {
        // This is an example of a performance test case.
        let filters = [AvailableFilter(id: "c1", name: "category1", type: "cate", values: [AvailableFilterValue(id: "cv1", name: "value1", results: 0)]), AvailableFilter(id: "c2", name: "category2", type: "cater", values: [AvailableFilterValue(id: "cv2", name: "value2", results: 0)])]
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: filters)
        
        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let productsRecibed = listProductsViewModel.setNewFilters(listFilterData: [FilterData](), productModel: products)

        assert(productsRecibed.filters.count == 0)
    }
    
    func testSetNewFilters() throws {
        // This is an example of a performance test case.
        let filters = [FilterData(idTitle: "c1", nameTitle: "Category1", idValue: "", nameValue: "", isTitle: true, state: false), FilterData(idTitle: "c1", nameTitle: "Category1", idValue: "cv1", nameValue: "Valor1", isTitle: false, state: true), FilterData(idTitle: "c2", nameTitle: "Category2", idValue: "", nameValue: "", isTitle: true, state: false), FilterData(idTitle: "c2", nameTitle: "Category2", idValue: "cv2", nameValue: "Valor2", isTitle: false, state: true)]
        
        let filtersAvailable = [AvailableFilter(id: "c1", name: "category1", type: "cate", values: [AvailableFilterValue(id: "cv1", name: "value1", results: 0)]), AvailableFilter(id: "c2", name: "category2", type: "cater", values: [AvailableFilterValue(id: "cv2", name: "value2", results: 0)])]
        
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: filtersAvailable)

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let productsRecibed = listProductsViewModel.setNewFilters(listFilterData: filters, productModel: products)

        assert(productsRecibed.filters.count == 2 && productsRecibed.filters[0].values.count == 1 && productsRecibed.filters[1].values.count == 1)
    }
    
    func testSetNewFiltersOnlyOneItemMerge() throws {
        // This is an example of a performance test case.
        let filters = [FilterData(idTitle: "c1", nameTitle: "Category1", idValue: "", nameValue: "", isTitle: true, state: false), FilterData(idTitle: "c1", nameTitle: "Category1", idValue: "cv1", nameValue: "Valor1", isTitle: false, state: true), FilterData(idTitle: "c2", nameTitle: "Category2", idValue: "", nameValue: "", isTitle: true, state: false), FilterData(idTitle: "c2", nameTitle: "Category2", idValue: "cv2", nameValue: "Valor2", isTitle: false, state: true)]
        
        let filtersAvailable = [AvailableFilter(id: "c1", name: "category1", type: "cate", values: [AvailableFilterValue(id: "cv1", name: "value1", results: 0)])]
        
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: filtersAvailable)

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let productsRecibed = listProductsViewModel.setNewFilters(listFilterData: filters, productModel: products)

        assert(productsRecibed.filters.count == 1 && productsRecibed.filters[0].values.count == 1)
    }
    
    func testSetNewFiltersNoItems() throws {
        // This is an example of a performance test case.
        let filters = [FilterData(idTitle: "c1", nameTitle: "Category1", idValue: "", nameValue: "", isTitle: true, state: false), FilterData(idTitle: "c1", nameTitle: "Category1", idValue: "cv1", nameValue: "Valor1", isTitle: false, state: true), FilterData(idTitle: "c2", nameTitle: "Category2", idValue: "", nameValue: "", isTitle: true, state: false), FilterData(idTitle: "c2", nameTitle: "Category2", idValue: "cv2", nameValue: "Valor2", isTitle: false, state: true)]
        
        let filtersAvailable = [AvailableFilter]()
        
        let products = ProductModel(siteID: "", paging: Paging(total: 0, primaryResults: 0, offset: 0, limit: 0), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: filtersAvailable)

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let productsRecibed = listProductsViewModel.setNewFilters(listFilterData: filters, productModel: products)

        assert(productsRecibed.filters.count == 0)
    }
    
    func testAddItems() throws {
        // This is an example of a performance test case.
        let products = ProductModel(siteID: "", paging: Paging(total: 200, primaryResults: 0, offset: 10, limit: 10), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let productsRecibed = listProductsViewModel.addItems(numberOfItems: 10, productModel: products)

        assert(productsRecibed.paging.offset == 20)
    }
    
    func testAddItemsOffLimit() throws {
        // This is an example of a performance test case.
        let products = ProductModel(siteID: "", paging: Paging(total: 14, primaryResults: 0, offset: 10, limit: 10), results: [ResultModel](), secondaryResults: [JSONAny](), relatedResults: [JSONAny](), sort: Sort(id: "", name: ""), availableSorts: [Sort](), filters: [Filter](), availableFilters: [AvailableFilter]())

        let listProductsViewModel = ListProductsViewModel(listProductsViewModelDelegate: sut)
        let productsRecibed = listProductsViewModel.addItems(numberOfItems: 10, productModel: products)

        assert(productsRecibed.paging.offset == 10)
    }
}
