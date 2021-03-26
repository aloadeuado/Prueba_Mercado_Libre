//
//  ProductRepository.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 25/03/21.
//

import Foundation

class ProductRepository {
    
    func getProducts(siteId: String, offset: Int32, limit: Int32, sort: String, filters: [SortData], ok: @escaping ((Product) -> Void), error: @escaping ((String) -> Void)){
        var url = getApi(api: .getProducts).replacingOccurrences(of: "{siteId}", with: siteId)
        url += "limit=\(limit)"
        url += "&offset=\(offset)"
        url += (sort == "") ? "" : "&sort=\(sort)"
        filters.forEach { (filter) in
            url += "&\(filter.filer)=\(filter.value)"
        }
        getReturnData(url: url, statusCorrect: [200, 201]) { (data) in
            let product = try? JSONDecoder().decode(Product.self, from: data)
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
