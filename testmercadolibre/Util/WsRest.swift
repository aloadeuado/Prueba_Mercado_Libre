//
//  WsRest.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 22/03/21.
//

import Foundation

enum Api {
    case getAllSites
    case getDetailSite
    case getCategoriesOfSite
    case getProducts
    case getSearchProducts
}

func getStringInfoPList(key: String) -> String {
    return Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
}

func getApi(api: Api) -> String{
    switch api {
    case .getAllSites:
        let url = getStringInfoPList(key: "API_BASE_URL") + "/sites"
        return url
    case .getDetailSite:
        let url = getStringInfoPList(key: "API_REST_DETAIL_SITE")
        return url
    case .getCategoriesOfSite:
        let url = getStringInfoPList(key: "API_BASE_URL") + "/sites/{siteId}/categories"
        return url
    case .getProducts:
        let url = getStringInfoPList(key: "API_BASE_URL") + "/sites/{siteId}/search?"
        return url
    case .getSearchProducts:
        let url = getStringInfoPList(key: "API_BASE_URL") + "/sites/{siteId}/search?q={text}"
        return url
    default:
        return "/sites"
    }
}
