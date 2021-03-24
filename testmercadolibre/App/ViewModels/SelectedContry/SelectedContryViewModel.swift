//
//  SelectedContryViewModel.swift
//  testmercadolibre
//
//  Created by Pedro Alonso Daza B on 21/03/21.
//

import Foundation
import Alamofire

class SelectedContryViewModel{
    var selectedContryDelegate: SelectedContryDelegate?
    
    var contryRepository = ContryRepository()
    
    init(selectedContryDelegate: SelectedContryDelegate?){
        self.selectedContryDelegate = selectedContryDelegate
    }
    
    func getSites() {
     
        contryRepository.getSites { (sites) in
            self.selectedContryDelegate?.selectedContry(succesComplete: sites)
        } error: { (err) in
            self.selectedContryDelegate?.selectedContry(onError: err)
        }

    }
    
    func getSiteDetail(site: String) {
        contryRepository.getSiteDetail(site: site) { (siteDetailModel) in
            self.selectedContryDelegate?.selectedContry(succesCompleteDetail: siteDetailModel)
        } error: { (err) in
            self.selectedContryDelegate?.selectedContry(onError: err)
        }
    }
    
    func setInternalSite(site: SiteModel) {
        contryRepository.setInternalSite(site: site)
    }
}
protocol SelectedContryDelegate {
    func selectedContry(succesComplete listSites: [SiteModel])
    func selectedContry(succesCompleteDetail siteDetail: SiteDetailModel)
    func selectedContry(onNoData nodata:String)
    func selectedContry(onError error:String)
}
