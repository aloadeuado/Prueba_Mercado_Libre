//
//  ContryRepository.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 22/03/21.
//

import Foundation

class ContryRepository {
    func getSites(ok: @escaping(([SiteModel]) -> Void), error: @escaping ((String) -> Void)) {
        let url = getApi(api: .getAllSites)
        getReturnData(url: url, statusCorrect: [200, 201]) { (data) in
            let sites = try? JSONDecoder().decode([SiteModel].self, from: data)
            let sitesReturn = sites ?? [SiteModel]()
            if sitesReturn.count >= 1 {
                ok(sitesReturn)
            } else {
                error(TextConstants().ERROR_SITES_DATA)
            }
            
        } error: { (err) in
            error(err)
        }

    }
    
    func getSiteDetail(site: String, ok: @escaping((SiteDetailModel) -> Void), error: @escaping ((String) -> Void)) {
        let url = getApi(api: .getDetailSite).replacingOccurrences(of: "{name}", with: site)
        
        getReturnData(url: url, statusCorrect: [200, 201]) { (data) in
            let siteDetail = try? JSONDecoder().decode([SiteDetailModel].self, from: data)
            let siteDetailReturn = siteDetail ?? [SiteDetailModel]()
            if siteDetailReturn.count >= 1 {
                ok(siteDetail![0] ?? SiteDetailModel())
            } else {
                error(TextConstants().ERROR_SITES_DATA)
            }
            
        } error: { (err) in
            error(err)
        }

    }
    
    func setInternalSite(site: SiteModel) {
        
        if let encoded = try? JSONEncoder().encode(site) {
            setData(didSetData: encoded, key: Constans.KEY_INTERNAL_STORAGE_SITE)
        }
        
    }
    
    func getInternalSite() -> (siteModel: SiteModel?, error: String) {
        let data = getData(didGetData: Constans.KEY_INTERNAL_STORAGE_SITE)
            let siteModel = try? JSONDecoder().decode(SiteModel.self, from: data)
            if let siteModel1 = siteModel{
                return (siteModel: siteModel1, error: "")
            }else {
                return (nil, TextConstants().ERROR_SITES_DATA)
            } 
    }
}

