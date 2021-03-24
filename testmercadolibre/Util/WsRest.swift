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
    default:
        return "/sites"
    }
}
