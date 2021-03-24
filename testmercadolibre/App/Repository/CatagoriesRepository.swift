//
//  CatagoriesRepository.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 23/03/21.
//

import Foundation
import UIKit

class CatagoriesRepository {
    func getCategoriesOfSites(siteId: String, ok: @escaping(([CategoryModel]) -> Void), error: @escaping ((String) -> Void)) {
        let url = getApi(api: .getCategoriesOfSite).replacingOccurrences(of: "{siteId}", with: siteId)
        getReturnData(url: url, statusCorrect: [200, 201]) { (data) in
            let categoryModel = try? JSONDecoder().decode([CategoryModel].self, from: data)
            print(categoryModel)
            let categoryReturnModel = categoryModel ?? [CategoryModel]()
            if categoryReturnModel.count >= 1 {
                ok(categoryReturnModel)
            } else {
                error(TextConstants().ERROR_SITES_DATA)
            }
            
        } error: { (err) in
            error(err)
        }
    }
}
