//
//  ProductRepository.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 25/03/21.
//

import Foundation

class ProductRepository {
    
    func getProducts(siteId: String, productModel: ProductModel, ok: @escaping ((ProductModel) -> Void), error: @escaping ((String) -> Void)){
        var url = getApi(api: .getProducts).replacingOccurrences(of: "{siteId}", with: siteId)
        url += "limit=\(productModel.paging.limit)"
        url += "&offset=\(productModel.paging.offset)"
        url += (productModel.sort.id == "") ? "" : "&sort=\(productModel.sort.id)"
        productModel.filters.forEach { (filter) in
            let idFilter = filter.id
            filter.values.forEach { (filterValue) in
                url += "&\(idFilter)=\(filterValue.id)"
            }
        }
        if let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            url = urlString
        }
        getReturnData(url: url, statusCorrect: [200, 201]) { (data) in
            let product = try? JSONDecoder().decode(ProductModel.self, from: data)
            if let productReturn = product {
                print(productReturn)
                ok(productReturn)
            } else {
                error(TextConstants().WS_ERROR_NO_DATA)
            }
        } error: { (err) in
            error(err)
        }

    }
    
    func getProducts(siteId: String, textSearch: String, ok: @escaping ((ProductModel) -> Void), error: @escaping ((String) -> Void)){
        var url = getApi(api: .getSearchProducts).replacingOccurrences(of: "{siteId}", with: siteId).replacingOccurrences(of: "{text}", with: textSearch)

        if let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            url = urlString
        }
        getReturnData(url: url, statusCorrect: [200, 201]) { (data) in
            let product = try? ProductModel(data: data)
            if let productReturn = product {
                print(productReturn)
                ok(productReturn)
            } else {
                error(TextConstants().WS_ERROR_NO_DATA)
            }
        } error: { (err) in
            error(err)
        }

    }
}
